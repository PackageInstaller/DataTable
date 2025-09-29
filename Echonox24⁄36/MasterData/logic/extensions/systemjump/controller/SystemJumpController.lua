-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemjump/controller/SystemJumpController.lua

module("logic.extensions.systemjump.controller.SystemJumpController", package.seeall)

local M = class("SystemJumpController", BaseController)

function M:ctor()
	self._jumpFuncMap = {}
	self._jumpSceneMap = {}
	self._CUSTOM_HOUSE_JUMP_MARK = "#customJumpHouseRoom"
	self._KEY_PRODUCT_FURNITURE = "#productFurniture"
	self._KEY_CHARACTER_INFO = "#characterInfo"
	self._KEY_STORE_LIST_JUMP = "#storeListJump"
end

function M:onInit()
	self:onReset()
	self:_registerJumpFunc()
	self:_registerJumpScene()
	GlobalDispatcher:addEventListener(EventType.JUMP_VIEW_EVENT, self._dealJump, self)
end

function M:onReset()
	self._crossSceneJumpInfo = {}
end

function M:_registerJumpFunc()
	self._jumpFuncMap[ViewName.MainUIView] = self._jumpToMainUI
	self._jumpFuncMap[ViewName.StoreMainViewViewPresentor] = self._jumpToStore
	self._jumpFuncMap[self._KEY_STORE_LIST_JUMP] = self._jumpToOneOfStoreInList
	self._jumpFuncMap[ViewName.CharacterDepotMainViewNew] = self._jumpToCharacterDepot
	self._jumpFuncMap[ViewName.CharacterMainSystemViewNew] = self._jumpToCharacterSystem
	self._jumpFuncMap[ViewName.CharacterHeartAnchorBreakView] = self._jumpToCharacterAnchorBreak
	self._jumpFuncMap[ViewName.CharacterHeartAnchorView] = self._jumpToCharacterAnchor
	self._jumpFuncMap[ViewName.ThinkingMainView] = self._jumpToThinkingMain
	self._jumpFuncMap[ViewName.CharacterUpgrade] = self._jumpToCharacterUpgrade
	self._jumpFuncMap[ViewName.CharacterSkinView] = self._jumpToCharacterSkin
	self._jumpFuncMap[ViewName.StableAreaChapterView] = self._jumpToStableAreaDungeon
	self._jumpFuncMap[ViewName.RedMistChapterView] = self._jumpToEquipExploreDungeon
	self._jumpFuncMap[ViewName.MainlineDungeonView] = self._jumpToMainlineDungeon
	self._jumpFuncMap[ViewName.ClimbingTowerEntryView] = self._jumpToClimbTowerDungeon
	self._jumpFuncMap[ViewName.PlayerInfoMain] = self._jumpToPlayerInfo
	self._jumpFuncMap[ViewName.SeasonNewMain] = self._jumpToSeasonNew
	self._jumpFuncMap[ViewName.BackpackView] = self._jumpToBackpack
	self._jumpFuncMap[ViewName.RoomMainView] = self._jumpJumpToHouse
	self._jumpFuncMap[ViewName.SupervisorMain] = self._jumpJumpToHouse
	self._jumpFuncMap[ViewName.ManufactureMain] = self._jumpJumpToHouse
	self._jumpFuncMap[ViewName.TradingEntrance] = self._jumpJumpToHouse
	self._jumpFuncMap[ViewName.FacilityHoldingMainView] = self._jumpJumpToHouse
	self._jumpFuncMap[ViewName.FacilityHoldingInformationTipsView] = self._jumpJumpToHouse
	self._jumpFuncMap[self._CUSTOM_HOUSE_JUMP_MARK] = self._jumpJumpToHouse
	self._jumpFuncMap[self._KEY_PRODUCT_FURNITURE] = self._jumpToProductFurniture
	self._jumpFuncMap[ViewName.LotteryEntry] = self._jumpToLottery
	self._jumpFuncMap[ViewName.AirWorkShopTaskView] = self._jumpAirWorkTask
	self._jumpFuncMap[ViewName.TreasureChooseViewNew] = self._jumpToChooseBoxView
	self._jumpFuncMap[ViewName.WelfareMainView] = self._jumpWelfareMainView
	self._jumpFuncMap[ViewName.SevenSignInTips] = self._jumpJumpSevenSign
	self._jumpFuncMap[self._KEY_CHARACTER_INFO] = self._jumpToCharacterView
	self._jumpFuncMap[ViewName.AirtightRoomTimeView] = self._jumpToAirtightRoom
	self._jumpFuncMap[ViewName.RetrieveMainViewViewPresentor] = self._jumpToRetrieve
end

function M:_registerJumpScene()
	self._jumpSceneMap[ViewName.CharacterDepotMainViewNew] = SceneType.Room
	self._jumpSceneMap[ViewName.CharacterMainSystemViewNew] = SceneType.Room
	self._jumpSceneMap[ViewName.CharacterUpgrade] = SceneType.Room
	self._jumpSceneMap[ViewName.SeasonNewMain] = SceneType.Room
	self._jumpSceneMap[ViewName.AirtightRoomTimeView] = SceneType.Room
end

function M:canJump(jumpId, isShowLockTips)
	local jumpInfo = SystemJumpConfig.instance:getJumpInfo(jumpId)

	if not jumpInfo then
		printError(string.format("无法从[t_%s]找到[%s]的配置", ConfigName.SystemJump, jumpId))

		return false
	end

	if jumpInfo.systemId > 0 and not SystemOpenFacade.instance:isOpen(jumpInfo.systemId, isShowLockTips) then
		return false
	end

	return true
end

function M:jumpTo(jumpId, isShowLockTips)
	if self:canJump(jumpId, isShowLockTips) then
		self:_dealJump(nil, jumpId)

		return true
	end

	return false
end

function M:_jumpToStore(jumpInfo, ...)
	local storeId = 0
	local goodsId = 0

	if not string.nilorempty(jumpInfo.extValue1) then
		storeId = tonumber(jumpInfo.extValue1)
	end

	if not string.nilorempty(jumpInfo.extValue2) then
		goodsId = tonumber(jumpInfo.extValue2)
	end

	if storeId == 0 then
		StoreMainFacade.instance:showStoreMain(1)
	else
		StoreAgent.instance:reqJumpTo(storeId, goodsId)
	end
end

function M:_jumpToOneOfStoreInList(jumpInfo, ...)
	local storeIds = {}

	if not string.nilorempty(jumpInfo.extValue1) then
		for s in string.gmatch(jumpInfo.extValue1, "%d+") do
			table.insert(storeIds, tonumber(s))
		end
	end

	if #storeIds > 0 then
		StoreAgent.instance:reqJumpToStoreInList(storeIds)
	end
end

function M:_jumpToPlayerInfo(jumpInfo, ...)
	if ViewMgr.instance:isOpen(ViewName.PlayerInfoMain) then
		ViewMgr.instance:close(ViewName.PlayerInfoMain)
	end

	local info = {}

	info.index = tonumber(jumpInfo.extValue1)
	info.isSelf = true

	ViewMgr.instance:open(ViewName.PlayerInfoMain, info)
end

function M:_jumpToSeasonNew(jumpInfo, ...)
	if ViewMgr.instance:isOpen(ViewName.SeasonNewMain) then
		ViewMgr.instance:close(ViewName.SeasonNewMain)
	end

	local info = {}

	info.index = tonumber(jumpInfo.extValue1)
	info.subIndex = tonumber(jumpInfo.extValue2)

	ViewMgr.instance:open(ViewName.SeasonNewMain, info)
end

function M:_jumpToCharacterDepot(jumpInfo, ...)
	CharacterSystemFacade.instance:showCharacterDepotView(true)
end

function M:jumpToCharacterSystem(heroId, tab, tabInfo, needDepot, openView)
	local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if not heroData then
		local tmpHeroList = HeroDepotModel.instance:getHeroDepotData():getShowDataList()
		local list = tmpHeroList:getMoList()

		if #list > 0 then
			heroData = list[1]
		end
	end

	if heroData then
		tab = tab or CommEnum.CharacterSystemTab.Detail

		self:_dealJump(nil, 10200001, heroData:getId(), tab, needDepot, openView, tabInfo)
	end
end

function M:_jumpToCharacterSystem(jumpInfo, tagetHeroId, tab, needDepot, openView, ...)
	if needDepot then
		CharacterSystemFacade.instance:showCharacterDepotView()
	end

	local tmpHeroList = HeroDepotModel.instance:getHeroDepotData():getShowDataList()
	local sortData = CharacterUtil.SortAndFitler(CommEnum.HeroFilter.HeroDepot, tmpHeroList:getMoList())
	local index = 1

	if tagetHeroId then
		for _index, characterBaseData in ipairs(sortData or {}) do
			if characterBaseData:getId() == tagetHeroId then
				index = _index
			end
		end
	end

	HeroDepotModel.instance:setViewPageMo({
		hero = sortData[index],
		index = index,
		list = {
			sortData[index]
		}
	})

	local tabIndex = tonumber(jumpInfo.extValue1) or CommEnum.CharacterSystemTab.Detail

	if tab then
		tabIndex = tab
	end

	local passInfo = {
		openView = jumpInfo.extValue2,
		otherParam = jumpInfo.param
	}

	if not string.nilorempty(openView) then
		passInfo.openView = openView
	end

	passInfo.data = ...

	CharacterSystemFacade.instance:showCharacterSystem(tabIndex, passInfo)
end

function M:_jumpToCharacterUpgrade(jumpInfo, ...)
	local heroId
	local needDepot = false
	local openView = "upgrade"

	self:_dealJump(nil, 10200001, heroId, CommEnum.CharacterSystemTab.Detail, needDepot, openView)
end

function M:_jumpToCharacterAnchorBreak(jumpInfo, ...)
	local tmpHeroList = HeroDepotModel.instance:getHeroDepotData():getShowDataList()
	local index = 1
	local list = tmpHeroList:getMoList()

	HeroDepotModel.instance:setViewPageMo({
		hero = list[index],
		index = index,
		list = {
			list[index]
		}
	})
	ViewMgr.instance:open(ViewName.CharacterHeartAnchorBreakView)
end

function M:_jumpToCharacterAnchor(jumpInfo, ...)
	local tmpHeroList = HeroDepotModel.instance:getHeroDepotData():getShowDataList()
	local index = 1
	local list = tmpHeroList:getMoList()

	HeroDepotModel.instance:setViewPageMo({
		hero = list[index],
		index = index,
		list = {
			list[index]
		}
	})
	ViewMgr.instance:open(ViewName.CharacterHeartAnchorView)
end

function M:_jumpToThinkingMain(jumpInfo, ...)
	ViewMgr.instance:open(ViewName.ThinkingMainView)
end

function M:_jumpToCharacterSkin(jumpInfo, ...)
	local arg = {
		...
	}
	local heroId = arg[1]
	local skinId = arg[2] or 0
	local showType = arg[3] or HeroSkinEnum.ShowType.SingleSkin

	ViewMgr.instance:open(ViewName.CharacterSkinView, {
		heroId = heroId,
		skinId = skinId,
		showType = showType
	})
end

function M:_jumpToStableAreaDungeon(jumpInfo, ...)
	local chapterId = tonumber(jumpInfo.extValue1)
	local dungeonIndex = tonumber(jumpInfo.extValue2)

	MaterialDungeonController.instance:jump(chapterId, dungeonIndex)
end

function M:_jumpToEquipExploreDungeon(jumpInfo, ...)
	local chapterId = tonumber(jumpInfo.extValue1)
	local dungeonIndex = tonumber(jumpInfo.extValue2)

	EquipDungeonController.instance:jump(chapterId, dungeonIndex)
end

function M:_jumpToMainlineDungeon(jumpInfo, ...)
	local recordInfo = DungeonMainLineChapterModel.instance:getDungeonSceneChpaterInfo()
	local chapterInfo = {}

	chapterInfo.needShowChapterSelect = recordInfo and recordInfo.needShowChapterSelect

	DungeonMainLineChapterModel.instance:tryEnterChapterScene(jumpInfo.jumpId, chapterInfo)
end

function M:_jumpToClimbTowerDungeon(jumpInfo, ...)
	local info

	if not string.nilorempty(jumpInfo.extValue1) then
		local pageType = tonumber(jumpInfo.extValue1)

		if pageType == ClimbingTowerEnum.PageTyp.DarkSide then
			local expire = true
			local round = ClimbingTowerDarkModel.instance:getDarkRound()

			if round and round > 0 then
				local roundCO = ClimbingTowerConfig.instance:getDarkRoundCO(round)

				if roundCO and not roundCO:isExpired() then
					expire = false
				end
			end

			if expire then
				FloatWordMgr.instance:show(lang("tip_dark_not_work"))

				return
			end
		end

		local pageType = tonumber(jumpInfo.extValue1)

		info = {
			lastClimbingTowerTyp = pageType
		}

		ClimbingTowerModel.instance:cacheEntryViewPageType(pageType)
	else
		ClimbingTowerModel.instance:cacheEntryViewPageType(0)
	end

	if ViewMgr.instance:isOpen(ViewName.ClimbingTowerEntryView) then
		ViewMgr.instance:close(ViewName.ClimbingTowerEntryView)
	end

	ViewMgr.instance:open(ViewName.ClimbingTowerEntryView, info)
end

function M:jumpToHouseRoomCustom(roomId, otherViewName, otherViewOpenParam, isShowLockTips)
	local jumpId = 20050000

	if not self:canJump(jumpId, isShowLockTips) then
		printWarn("不能跳转：", jumpId)

		return false
	end

	local roomOpenTyp = HouseMainRoomModel.instance:getRoomOpenTyp(roomId)

	if roomOpenTyp ~= HouseMainEnum.RoomOpenTyp.OpenActive then
		printWarn(string.format("不能执行跳转[%s] targetRoom[%s] openTyp[%s]不为OpenActive", jumpId, roomId, roomOpenTyp))

		if isShowLockTips then
			FloatWordMgr.instance:show("房间未激活")
		end

		return false
	end

	local info = {
		roomId = roomId,
		otherViewName = otherViewName,
		otherViewOpenParam = otherViewOpenParam
	}

	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, jumpId, info)

	return true
end

function M:_jumpJumpToHouse(jumpInfo, info)
	info = info or {}

	local isCustomJump = jumpInfo.viewName == self._CUSTOM_HOUSE_JUMP_MARK

	info.isCustomJump = isCustomJump

	local targetRoomId = 0

	if isCustomJump then
		targetRoomId = info.roomId
	elseif not string.nilorempty(jumpInfo.extValue1) then
		targetRoomId = tonumber(jumpInfo.extValue1)
	end

	if targetRoomId == 0 then
		if jumpInfo.viewName ~= "room_main_view" then
			printError(string.format("不能执行跳转[%s] viewName[%s] targetRoom[%s]", jumpInfo.jumpId, jumpInfo.viewName, targetRoomId))

			return
		end
	else
		local roomOpenTyp = HouseMainRoomModel.instance:getRoomOpenTyp(targetRoomId)

		if roomOpenTyp ~= HouseMainEnum.RoomOpenTyp.OpenActive then
			printError(string.format("不能执行跳转[%s] viewName[%s] targetRoom[%s] openTyp[%s]不为OpenActive", jumpInfo.jumpId, jumpInfo.viewName, targetRoomId, roomOpenTyp))

			return
		end
	end

	local curSceneFlowTyp = SceneFace.instance:getCurSceneFlowTyp()

	if curSceneFlowTyp and curSceneFlowTyp == SceneType.House then
		local jumpInfoTable = {
			jumpInfo = jumpInfo,
			otherParams = info
		}

		HouseMainController.instance:onHouseSceneEnterDealJumpInfo(jumpInfoTable)
	else
		if targetRoomId > 0 then
			HouseMainRoomModel.instance:setFocusRoomId(targetRoomId)
		end

		HouseMainRoomModel.instance:setJumpInfo(jumpInfo, info)
		SceneFace.instance:enterHouseScene()
	end
end

function M:_jumpToMainUI(jumpInfo, ...)
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:_jumpToProductFurniture(jumpInfo, itemId)
	HouseFacade.instance:productFurnitureByFurnitureId(itemId)
end

function M:_jumpToLottery(jumpInfo, info)
	if jumpInfo.systemId ~= 0 and not SystemOpenFacade.instance:isOpen(jumpInfo.systemId, true) then
		return
	end

	RetrieveController.instance:enterScene()
end

function M:_jumpToRetrieve(jumpInfo, info)
	if jumpInfo.systemId ~= 0 and not SystemOpenFacade.instance:isOpen(jumpInfo.systemId, true) then
		return
	end

	local curLotteryIdStr = jumpInfo.extValue1

	if not string.nilorempty(curLotteryIdStr) then
		local poolId = tonumber(curLotteryIdStr)
		local lotteryData = ActivityController.instance:getActivityByLogicTypeAndCode(ActivityEnum.LogicType.LOTTERY, poolId)

		if lotteryData then
			local jumpInfo = {
				needShowEnter = true,
				lotteryId = lotteryData:getLotteryId()
			}

			RetrieveModel.instance:setJumpInfo(jumpInfo)
		elseif enableWarnLog then
			printWarn("没有找到对应的卡池活动:", poolId)
		end
	end

	RetrieveController.instance:enterScene()
end

function M:_jumpWelfareMainView(jumpInfo, info)
	if jumpInfo.systemId ~= 0 and not SystemOpenFacade.instance:isOpen(jumpInfo.systemId, true) then
		return
	end

	if not WelfareUtil.isSystemOpen() then
		return
	end

	local tabId = tonumber(jumpInfo.extValue1)

	if not WelfareUtil.isTabActive(tabId) then
		FloatWordMgr.instance:show(lang("activity_closed"))

		return
	end

	local param = {}

	param.tabId = tabId

	if ViewMgr.instance:isOpen(jumpInfo.viewName) then
		ViewMgr.instance:close(jumpInfo.viewName)
	end

	ViewMgr.instance:open(jumpInfo.viewName, param)
end

function M:_jumpJumpSevenSign(jumpInfo, actId)
	if jumpInfo.systemId ~= 0 and not SystemOpenFacade.instance:isOpen(jumpInfo.systemId, true) then
		return
	end

	local info = {}

	info.actId = actId

	if ViewMgr.instance:isOpen(jumpInfo.viewName) then
		ViewMgr.instance:close(jumpInfo.viewName)
	end

	ViewMgr.instance:open(jumpInfo.viewName, info)
end

function M:_jumpAirWorkTask(jumpInfo, info)
	if ViewMgr.instance:isOpen(ViewName.AirWorkShopTaskView) then
		ViewMgr.instance:close(ViewName.AirWorkShopTaskView, false, WindowType.WindowCloseReasonType.QuickCloseType, false)
	end

	local tabIndex

	if not string.nilorempty(jumpInfo.extValue1) then
		tabIndex = tonumber(jumpInfo.extValue1)
	end

	tabIndex = tabIndex or AirWorkShopEnum.TaskPageType.Create

	ViewMgr.instance:open(ViewName.AirWorkShopTaskView, {
		tabIndex = tabIndex
	})
end

function M:_dealJump(e, jumpId, ...)
	if jumpId then
		local jumpInfo = SystemJumpConfig.instance:getJumpInfo(jumpId)

		if jumpInfo then
			if jumpInfo.systemId ~= 0 and not SystemOpenFacade.instance:isOpen(jumpInfo.systemId, true) then
				return
			end

			if self:_judgeJumpScene(jumpInfo, ...) then
				if Astral.OSDef.isEditor then
					printWarn("需先进行场景跳转:", jumpInfo.jumpId)
				end

				return
			end

			local func = self._jumpFuncMap[jumpInfo.viewName]

			if func then
				func(self, jumpInfo, ...)
			else
				if ViewMgr.instance:isOpen(jumpInfo.viewName) then
					ViewMgr.instance:close(jumpInfo.viewName)
				end

				ViewMgr.instance:open(jumpInfo.viewName, ...)
			end
		end
	end
end

function M:_jumpToBackpack(jumpInfo, ...)
	if not jumpInfo.extValue1 or jumpInfo.extValue1 == "" then
		if ViewMgr.instance:isOpen(jumpInfo.viewName) then
			ViewMgr.instance:close(jumpInfo.viewName)
		end

		ViewMgr.instance:open(jumpInfo.viewName, ...)

		return
	end

	local showType, jumpItem = MainBackpackModel.instance:canJump(jumpInfo.extValue1, jumpInfo.extValue2)

	if showType then
		if ViewMgr.instance:isOpen(jumpInfo.viewName) then
			ViewMgr.instance:close(jumpInfo.viewName)
		end

		MainBackpackModel.instance:setJumpItem(showType, jumpItem)
		ViewMgr.instance:open(jumpInfo.viewName)
	elseif not jumpItem then
		ToolTipsMgr.showCharacterTopToast(lang("tip_jump_backpack_empty"), CommEnum.CharacterTopToastIcon.Fail, 1)
	end
end

function M:_jumpToChooseBoxView(jumpInfo, ...)
	if string.nilorempty(jumpInfo.extValue1) then
		return
	end

	local boxId = tonumber(jumpInfo.extValue1)
	local boxItemCount = ItemModel.instance:getItemCountByItemId(boxId)

	if not boxItemCount or boxItemCount <= 0 then
		ToolTipsMgr.showCharacterTopToast(lang("tip_jump_backpack_empty"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	local params = {
		...
	}
	local itemData = ItemData.New({
		itemId = boxId,
		count = boxItemCount
	})
	local needItemId = params[1]
	local needItemCount = params[2]

	BackpackUtil.useTreasureItem(itemData, needItemId, needItemCount)
end

function M:_jumpToCharacterView(jumpInfo, ...)
	local mapData = CommEnum.CharacterSystemStringMap[jumpInfo.extValue1]

	if not mapData then
		return
	end

	local tabIndex = mapData[1]
	local systemId = mapData[2]
	local openView = mapData[3]

	if systemId ~= 0 and not SystemOpenFacade.instance:isOpen(systemId, true) then
		return
	end

	local heroId = checknumber(jumpInfo.extValue2)

	self:jumpToCharacterSystem(heroId, tabIndex, nil, false, openView)
end

function M:_jumpToAirtightRoom(jumpInfo, ...)
	ViewMgr.instance:open(ViewName.AirtightRoomTimeView)
end

function M:_judgeJumpScene(jumpInfo, ...)
	local needJumpScene = false
	local targetSceneType = self._jumpSceneMap[jumpInfo.viewName]

	if targetSceneType and targetSceneType > 0 and not SceneFace.instance:isCurScene(targetSceneType) then
		needJumpScene = true

		self:setCrossSceneJumpInfo(targetSceneType, jumpInfo, ...)
		SceneFace.instance:jumpScene(targetSceneType)
	end

	return needJumpScene
end

function M:setCrossSceneJumpInfo(sceneType, jumpInfo, ...)
	if not self._crossSceneJumpInfo then
		self._crossSceneJumpInfo = {}
	end

	self._crossSceneJumpInfo[sceneType] = {
		jumpInfo = jumpInfo,
		info = {
			...
		}
	}
end

function M:clearCrossSceneJumpInfo(sceneType)
	self._crossSceneJumpInfo[sceneType] = nil
end

function M:getCrossSceneJumpInfo(sceneType)
	return self._crossSceneJumpInfo[sceneType]
end

function M:dealCrossSceneJumpInfo(sceneType)
	local deal = false
	local cJumpInfo = self:getCrossSceneJumpInfo(sceneType)

	if cJumpInfo then
		deal = true

		self:_dealJump(nil, cJumpInfo.jumpInfo.jumpId, unpack(cJumpInfo.info))
		self:clearCrossSceneJumpInfo(sceneType)
	end

	return deal
end

M.instance = M.New()

return M
