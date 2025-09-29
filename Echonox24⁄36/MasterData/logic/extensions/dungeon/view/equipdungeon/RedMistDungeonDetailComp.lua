-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/equipdungeon/RedMistDungeonDetailComp.lua

module("logic.extensions.dungeon.view.equipdungeon.RedMistDungeonDetailComp", package.seeall)

local M = class("RedMistDungeonDetailComp", ViewComponent)
local RewardEnum = CommEnum.RewardEnum
local SignTyp = CommEnum.BackPackItemSignTyp

function M:ctor()
	self._rewardGoList = {}
	self._dungeonDescCache = {}
end

function M:buildUI()
	self._textName = self:getText("red_mist_chapters_view_-1811187788")
	self._textNum = self:getText("red_mist_chapters_view_-705920404")
	self._textDesc = self:getUIComponent("red_mist_chapters_view_-502868286", UIComponentType.TextMeshProUGUI)
	self._goDifficultyFlag = self:getGo("3&instance_danger_-1654566369")
	self._transfRewardRoot = self:getRectTransform("red_mist_chapters_view_-331641715")
	self._goRewardPrefab = self:getGo("4&rewards_detail_item_2141037416")
	self._btnMoreReward = self:getBtn("red_mist_chapters_view_1410225382")
	self._goBtns1 = self:getGo("red_mist_chapters_view_1670497435")
	self._goBtns2 = self:getGo("red_mist_chapters_view_-1524952539")
	self._costCell1 = PrefabReferenceUtil.createCurrencyCostLuaCell(self:getGo("14&com_price_1317146225"))
	self._costCell2 = PrefabReferenceUtil.createCurrencyCostLuaCell(self:getGo("15&com_price_1317146225"))
	self._quickFightCell = Astral.SimpleLuaComponentContainer.Add(self:getGo("8&btn_left_-1571983320"), CommButton)
	self._fightBtnCell1 = Astral.SimpleLuaComponentContainer.Add(self:getGo("9&btn_right_1251431307"), CommButton)
	self._fightBtnCell2 = Astral.SimpleLuaComponentContainer.Add(self:getGo("11&btn_middle_-31477526"), CommButton)
	self._textFight = self:getText("8&btn_left_423343501")
	self._doubleHintGo = self:getGo("13&com_multiple_rewards_right_hint_1207926246")
	self._txtNumberMultiple = self:getText("13&com_multiple_rewards_right_hint_1142272974")
	self._txtTimesMultiple = self:getText("13&com_multiple_rewards_right_hint_490855671")

	goutil.setActive(self._goRewardPrefab, false)
end

function M:bindEvents()
	self._btnMoreReward:AddClickListener(self._onClickMoreReward, self)
	self._fightBtnCell1:AddClickListener(self._onClickStartFight, self)
	self._fightBtnCell2:AddClickListener(self._onClickStartFight, self)
	self._quickFightCell:AddClickListener(self._onClickQuickFight, self)
end

function M:unbindEvents()
	self._btnMoreReward:RemoveClickListener()
	self._fightBtnCell1:RemoveClickListener()
	self._fightBtnCell2:RemoveClickListener()
	self._quickFightCell:RemoveClickListener()
end

function M:onEnter()
	self:_bindDispatcherEvent()
end

function M:onExit()
	self:_unbindDispatcherEvent()
end

function M:destroyUI()
	self._rewardGoList = nil
end

function M:_bindDispatcherEvent()
	GlobalDispatcher:addEventListener(EventType.ON_DUNGEON_DANGER_TIPS_CONFIRM, self._goFight, self)
	GlobalDispatcher:addEventListener(EventType.ON_MULTI_FIGHT_TIPS_CONFIRM, self._handleMultiFightTipsConfirm, self)
end

function M:_unbindDispatcherEvent()
	GlobalDispatcher:removeEventListener(EventType.ON_DUNGEON_DANGER_TIPS_CONFIRM, self._goFight, self)
	GlobalDispatcher:removeEventListener(EventType.ON_MULTI_FIGHT_TIPS_CONFIRM, self._handleMultiFightTipsConfirm, self)
end

function M:setData(dungeonMo, chapterMo, dungeonIndex)
	self._dungeonMo = dungeonMo
	self._dungeonId = dungeonMo:getId()
	self._dungeonIndex = dungeonIndex
	self._chapterMo = chapterMo
	self._chapterId = self._chapterMo:getChapterId()
	self._gamePlay = BattleEnum.GamePlayType.RECORD

	self:_refreshUI()
end

function M:_refreshUI()
	self:_refreshBaseInfo()
	self:_refreshRewardPanel()
	self:_refreshBottomPanel()
	self:_refreshMultipleDrop()
end

function M:_refreshBaseInfo()
	self._textName.text = self._dungeonMo:getName()
	self._textNum.text = string.format("%02d", self._dungeonIndex)

	if self._dungeonDescCache[self._dungeonId] == nil then
		self._dungeonDescCache[self._dungeonId] = StringUtil.replaceTMPBlackBlock(self._dungeonMo:getDesc())
	end

	self._textDesc.text = self._dungeonDescCache[self._dungeonId]

	local scoreRate = DungeonModel.instance:getDungeonScoreRate(self._dungeonId) * 1000
	local scoreCO = DungeonConfig.instance:getDungeonScoreCOByScore(scoreRate, self._dungeonMo:getScoreGroup())

	DifficultyUtil.setDifficultyFlag(self._goDifficultyFlag, scoreCO)

	local cost = self._dungeonMo:getPointCost()

	self._costCell1:updateData(CommEnum.CurrencyCodeEnum.TlCode, cost)
	self._costCell2:updateData(CommEnum.CurrencyCodeEnum.TlCode, cost)
end

function M:_refreshRewardPanel()
	local allRewardList = self:_getAllReward()

	for _, go in pairs(self._rewardGoList) do
		goutil.setActive(go, false)
	end

	for i = 1, #allRewardList do
		local go = self._rewardGoList[i]

		if not go then
			go = goutil.cloneAndSetParent(self._goRewardPrefab, self._transfRewardRoot)
			self._rewardGoList[i] = go
		end

		local rewardCell = Astral.SimpleLuaComponentContainer.Add(go, RewardCell)
		local data = allRewardList[i]

		rewardCell:updateData(data)
		goutil.setActive(go, true)
	end
end

function M:_getAllReward()
	local hasPassed = self._dungeonMo:hasPassed()
	local allRewardList = {}

	if not hasPassed then
		local firstRewards = self._dungeonMo:getAllFirstPassReward()
		local firstRewardList = self:_createRewardData(firstRewards, RewardEnum.HasGot, SignTyp.First, SignTyp.First)

		TableUtil.addRange(allRewardList, firstRewardList)
	end

	local importRewards = self._dungeonMo:getImportantPassReward()
	local rewardsAdapter = {}

	for _, code in ipairs(importRewards) do
		table.insert(rewardsAdapter, {
			num = 0,
			code = code
		})
	end

	local importRewardList = self:_createRewardData(rewardsAdapter, RewardEnum.CanNotGot)

	TableUtil.addRange(allRewardList, importRewardList)

	if hasPassed and #allRewardList == 0 then
		local gotRewards = self._dungeonMo:getAllFirstPassReward()
		local gotRewardList = self:_createRewardData(gotRewards, RewardEnum.HasGot, SignTyp.Get, SignTyp.Get)

		TableUtil.addRange(allRewardList, gotRewardList)
	end

	return allRewardList
end

function M:_createRewardData(rewards, rewardStatus, itemSign, signTyp)
	local itemList = {}
	local dataList = {}

	for _, reward in ipairs(rewards) do
		table.insert(itemList, ItemUtil.createItemData({
			itemId = reward.code,
			count = reward.num
		}))
	end

	table.sort(itemList, ItemUtil.commonSortFunc)

	for _, itemData in ipairs(itemList) do
		local count = itemData:getCount()
		local rewardData = RewardData.New({
			code = itemData:getItemId(),
			count = count ~= 0 and count or nil,
			rewardStatus = rewardStatus,
			itemData = itemData,
			itemSign = itemSign,
			signTyp = signTyp,
			clickCallBack = self._onClickMoreReward,
			clickCallBackObj = self
		})

		table.insert(dataList, rewardData)
	end

	return dataList
end

function M:_refreshBottomPanel()
	local showBtn = true
	local isPassed = self._dungeonMo:hasPassed()

	if self._gamePlay == BattleEnum.GamePlayType.RECORD then
		self._textFight.text = lang("multi_fight_title")
		showBtn = isPassed and self._chapterMo:getCanOpenMulti() and SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonMultipleBattle, false)
	elseif self._gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		local maxCount = self._chapterMo:getConsecutiveLimit()

		showBtn = isPassed and maxCount and maxCount > 0 and SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonConsecutiveBattle, false)
	end

	goutil.setActive(self._goBtns1, showBtn)

	local isUnlock = self._dungeonMo:getIsUnlock()

	self._fightBtnCell1:setActiveState(isUnlock)
	self._fightBtnCell2:setActiveState(isUnlock)
	self._quickFightCell:setActiveState(isUnlock)
	goutil.setActive(self._goBtns2, not showBtn)
end

function M:_refreshMultipleDrop()
	local type = self._dungeonMo:getType()
	local isShow = false
	local redPointMultiple = RedDotModel.instance:getRedDotDetailList(GameEnum.RedPointEnum.DungeonRewardUp) or {}

	for k, v in ipairs(redPointMultiple) do
		if tonumber(v) == type then
			isShow = true
		end
	end

	if isShow then
		local rewardId = self._dungeonMo:getImportantPassReward()
		local tabelT = MultipleDropController.instance:getLeftNumberByTypeAndReward(type, rewardId)

		if tabelT.times == "" or tabelT.leftNumber == 0 then
			isShow = false
		else
			self._txtNumberMultiple.text = tabelT.left
			self._txtTimesMultiple.text = tabelT.times
		end
	end

	goutil.setActive(self._doubleHintGo.gameObject, isShow)
end

function M:_checkBackpackLimit()
	local equipMaxCount = PlayerModel.instance:getBackpackLimit(GameEnum.ItemTypeEnum.EquipItemType, "EquipmentBackpackCapacity")
	local curEquipCount = ItemModel.instance:getItemCountByTS(GameEnum.ItemTypeEnum.EquipItemType, 0)

	return equipMaxCount <= curEquipCount
end

function M:_isExpire()
	if self._chapterMo:getIsInWeekDay() then
		return false
	else
		FloatWordMgr.instance:show(self._chapterMo:getWeekDayStr())

		return true
	end
end

function M:_formatLevel(level)
	local a = math.floor(level / 10)
	local b = level % 10

	return string.format("%s-%s", a, b)
end

function M:_onClickMoreReward()
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_click)
	ViewMgr.instance:open(ViewName.DungeonRewardDetailView, self._dungeonId)

	return false
end

function M:_onClickQuickFight()
	local chapterMo = self._chapterMo
	local dungeonMo = self._dungeonMo
	local hasPassed = dungeonMo:hasPassed()
	local canOpenMulti = chapterMo:getCanOpenMulti()
	local canQuickFight = false
	local canProxy = chapterMo:canProxy()
	local maxCount = 0
	local backPackLimit = self:_checkBackpackLimit()

	if self._gamePlay == BattleEnum.GamePlayType.RECORD then
		maxCount = chapterMo:getMultiMaxCount()

		if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonMultipleBattle, true) then
			return
		end

		if not canOpenMulti then
			FloatWordMgr.instance:show(lang("tip_not_open_multiple"))

			return
		elseif not hasPassed then
			FloatWordMgr.instance:show(lang("tip_pass_open_multiple"))

			return
		end
	elseif self._gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		maxCount = chapterMo:getConsecutiveLimit()

		if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonConsecutiveBattle, true) then
			return
		end

		if maxCount <= 0 then
			FloatWordMgr.instance:show(lang("tip_not_open_consecutive"))

			return
		elseif not hasPassed then
			FloatWordMgr.instance:show(lang("tip_pass_open_consecutive"))

			return
		end
	else
		return
	end

	if backPackLimit then
		local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang("tip_warehouse_undercapacity"))

		dialog:setConfirmButtonText(lang("tip_common_sure"))

		return
	end

	ToolTipsMgr.showMultiFightTipsView(self._dungeonId, maxCount, canQuickFight, canProxy, self._gamePlay)
end

function M:_onClickStartFight()
	if self._dungeonMo:getIsLock(true) then
		return
	end

	if self:_isExpire() then
		self:close()

		return
	end

	if self._dungeonMo:getPointCost() > ItemModel.instance:getItemCountByItemId(GameEnum.CurrencyCodeEnum.TlCode) then
		ToolTipsMgr.showHealthExchangeTips()

		return
	end

	if self:_checkBackpackLimit() then
		local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang("tip_warehouse_undercapacity"))

		dialog:setConfirmButtonText(lang("tip_common_sure"))

		return
	end

	BattleCalculateModel.instance:setDefaultItemMoList(self._dungeonMo:getPointCost())

	local info = {}

	info.dungeonCode = self._dungeonId
	info.afflatusBuff = false
	info.isShowPlot = true
	info.multiCount = 1
	info.gamePlay = BattleEnum.GamePlayType.NORMAL

	self:_startFight(info)
end

function M:_handleMultiFightTipsConfirm(e, tipsInfo)
	if self:_isExpire(true) then
		return
	end

	local pointCost = self._dungeonMo:getPointCost()

	BattleCalculateModel.instance:setDefaultItemMoList(pointCost * tipsInfo.multiCount)

	local info = {}

	info.dungeonCode = self._dungeonId
	info.afflatusBuff = false
	info.isShowPlot = false
	info.multiCount = tipsInfo.multiCount
	info.gamePlay = tipsInfo.gamePlay

	self:_startFight(info, false)
end

function M:_startFight(info, checkDanger)
	checkDanger = checkDanger == nil and true or checkDanger

	if not checkDanger then
		self:_goFight(false, info)

		return
	end

	if not self._dungeonMo:getIsPlotNode() then
		local scoreRate = DungeonModel.instance:getDungeonScoreRate(self._dungeonId) * 1000
		local scoreCO = DungeonConfig.instance:getDungeonScoreCOByScore(scoreRate, self._dungeonMo:getScoreGroup())

		if not DungeonController.instance:tryOpenDangerTips(scoreCO, info) then
			self:_goFight(false, info)
		end
	else
		self:_goFight(false, info)
	end
end

function M:_goFight(_, info)
	DungeonEquipExploreChapterModel.instance:setClickChapterIdAndDungeonIndex(self._chapterId, self._dungeonId)
	Astral.LocalStorage.Instance:SetString("dungeon_latest_type", string.format("3,%d,%02d", self._chapterId, self._dungeonIndex))
	Astral.LocalStorage.Instance:SetString("dungeon_latest_info", self._dungeonId)
	Astral.LocalStorage.Instance:SetString("dungeon_latest_id", PlayerModel.instance:getId())
	SceneFace.instance:exitScene()
	DungeonController.instance:startDungeonBattle(info)
end

return M
