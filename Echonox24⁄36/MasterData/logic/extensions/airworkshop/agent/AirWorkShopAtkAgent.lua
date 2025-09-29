-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/agent/AirWorkShopAtkAgent.lua

module("logic.extensions.airworkshop.agent.AirWorkShopAtkAgent", package.seeall)

local M = class("AirWorkShopAtkAgent", BaseAgent)

function M:ctor()
	return
end

function M:sendRodeoInfoRequest()
	local msg = AirAtkExtension_pb.RodeoInfoRequest()

	self:sendMsg(msg)
end

function M:handleRodeoInfoReply(status, msg)
	if status == 0 then
		AirWorkShopChallengeModel.instance:updateRodeoInfoFromServer(msg)
		GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_RODEO_INFO_CHANGE)
	end
end

function M:sendPlayRecordRequest(type, page)
	local msg = AirAtkExtension_pb.PlayRecordRequest()

	msg.type = type
	msg.page = page
	self._recordReqInfo = {
		type = type,
		page = page
	}

	self:sendMsg(msg)
end

function M:handlePlayRecordReply(status, msg)
	if status == 0 then
		AirWorkShopRecordModel.instance:updateLstFromServer(msg.record, self._recordReqInfo)
		GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_QUALIFYING_RECORD_CHANGE)
	end
end

function M:sendRodeoMatchRequest()
	AirWorkShopChallengeModel.instance:setRodeoSettle(false)

	local msg = AirAtkExtension_pb.RodeoMatchRequest()

	self:sendMsg(msg)
end

function M:handleRodeoMatchReply(status, msg)
	if status == 0 then
		AirWorkShopController.instance:onRodeoMatchReply(msg.level)
	else
		if Astral.OSDef.isEditor then
			local itemInfo = LanguageMgr.instance:getLangRcInfo(tostring(status))

			if itemInfo and itemInfo.workType == 0 then
				printError(string.format("空气工坊-竞技模式-匹配关卡,status[%s],%s", status, LanguageMgr.instance:getText(itemInfo)))
			end
		end

		GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_RODEO_MATCH_REPLY, status, nil)
	end
end

function M:sendRodeoStartRequest(hard)
	local msg = AirAtkExtension_pb.RodeoStartRequest()

	msg.hard = hard

	self:sendMsg(msg)
end

function M:handleRodeoStartReply(status, msg)
	if status == 0 then
		BattleEnterUtil.enterBattle(msg.battle)
	elseif Astral.OSDef.isEditor then
		local itemInfo = LanguageMgr.instance:getLangRcInfo(tostring(status))

		if itemInfo and itemInfo.workType == 0 then
			printError(string.format("竞技模式，开始关卡,status[%s],%s", status, LanguageMgr.instance:getText(itemInfo)))
		end
	end
end

function M:sendRodeoGiveUpRequest()
	local msg = AirAtkExtension_pb.RodeoGiveUpRequest()

	self:sendMsg(msg)
end

function M:handleRodeoGiveUpReply(status, msg)
	self:sendRodeoInfoRequest()

	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_RODEO_GIVE_UP_REPLY, status)
end

function M:sendFreeSelectRequest(mapId)
	local msg = AirAtkExtension_pb.FreeSelectRequest()

	msg.mapId = mapId

	self:sendMsg(msg)
end

function M:handleFreeSelectReply(status, msg)
	local mapInfo

	if status == 0 and msg:HasField("mapInfo") then
		mapInfo = msg.mapInfo
	end

	GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_FREE_SELECT_REPLY, mapInfo)
end

function M:sendFreeMatchRequest(hard)
	local msg = AirAtkExtension_pb.FreeMatchRequest()

	msg.hard = hard

	self:sendMsg(msg)
end

function M:handleFreeMatchReply(status, msg)
	local levelNO

	if status == 0 then
		if msg:HasField("level") then
			levelNO = msg.level
		end
	elseif Astral.OSDef.isEditor then
		local itemInfo = LanguageMgr.instance:getLangRcInfo(tostring(status))

		if itemInfo and itemInfo.workType == 0 then
			printError(string.format("自由匹配回调,status[%s],%s", status, LanguageMgr.instance:getText(itemInfo)))
		end
	end

	GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_FREE_MATCH_REPLY, status, levelNO)
end

function M:sendEndlessMatchRequest()
	local msg = AirAtkExtension_pb.EndlessMatchRequest()

	self:sendMsg(msg)
end

function M:handleEndlessMatchReply(status, msg)
	local levelNO

	if status == 0 then
		if msg:HasField("level") then
			levelNO = msg.level
		end

		local infoMo = AirWorkShopFreeModel.instance:getEndlessPlayerInfoMo()

		infoMo:setMatchLevelNO(levelNO)
	elseif Astral.OSDef.isEditor then
		local itemInfo = LanguageMgr.instance:getLangRcInfo(tostring(status))

		if itemInfo and itemInfo.workType == 0 then
			printError(string.format("自由无尽匹配回调,status[%s],%s", status, LanguageMgr.instance:getText(itemInfo)))
		end
	end

	GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_FREE_ENDLESS_MATCH_REPLY, levelNO)
	self:sendFreeEndlessInfoRequest()
end

function M:sendFreeStartRequest(hard, mapId)
	local msg = AirAtkExtension_pb.FreeStartRequest()

	msg.hard = hard
	msg.mapId = mapId

	self:sendMsg(msg)
end

function M:handleFreeStartReply(status, msg)
	if status == 0 then
		BattleEnterUtil.enterBattle(msg.battle)
	end
end

function M:sendFreeEndlessInfoRequest()
	local msg = AirAtkExtension_pb.FreeEndlessInfoRequest()

	self:sendMsg(msg)
end

function M:handleFreeEndlessInfoReply(status, msg)
	if status == 0 then
		AirWorkShopFreeModel.instance:updateEndlessInfoFromServer(msg)
		GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_FREE_ENDLESS_INFO_CHANGE)
	end
end

function M:sendEndlessStartRequest()
	local msg = AirAtkExtension_pb.EndlessStartRequest()

	self:sendMsg(msg)
end

function M:handleEndlessStartReply(status, msg)
	if status == 0 then
		BattleEnterUtil.enterBattle(msg.battle)
	elseif Astral.OSDef.isEditor then
		local itemInfo = LanguageMgr.instance:getLangRcInfo(tostring(status))

		if itemInfo and itemInfo.workType == 0 then
			printError(string.format("自由模式-无尽模式，进入挑战,status[%s],%s", status, LanguageMgr.instance:getText(itemInfo)))
		end
	end
end

function M:sendEndlessGiveUpRequest()
	local msg = AirAtkExtension_pb.EndlessGiveUpRequest()

	self:sendMsg(msg)
end

function M:handleEndlessGiveUpReply(status, msg)
	if status == 0 then
		local infoMo = AirWorkShopFreeModel.instance:getEndlessPlayerInfoMo()

		infoMo:setMatchLevelNO(nil)
		GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_FREE_ENDLESS_GIVE_UP_REPLY)
		self:sendFreeEndlessInfoRequest()
	end
end

function M:sendLikeRequest(mapId, like)
	local msg = AirAtkExtension_pb.LikeRequest()

	msg.mapId = mapId
	msg.like = like
	self._cacheLikeMapId = mapId
	self._cacheLikeMapLiked = like

	self:sendMsg(msg)
end

function M:handleLikeReply(status, msg)
	if status == 0 then
		AirWorkShopController.instance:onLikedMap(self._cacheLikeMapId, self._cacheLikeMapLiked)

		self._cacheLikeMapId = nil
		self._cacheLikeMapLiked = nil
	end
end

function M:sendTagRequest(mapId, tagIdList)
	local msg = AirAtkExtension_pb.TagRequest()

	msg.mapId = mapId

	for _, tagId in pairs(tagIdList or {}) do
		table.insert(msg.tagId, tagId)
	end

	self:sendMsg(msg)
end

function M:handleTagReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_GIVE_MAP_TAG)
	end
end

function M:sendSettleWeekRequest()
	local msg = AirAtkExtension_pb.SettleWeekRequest()

	self:sendMsg(msg)
end

function M:handleSettleWeekReply(status, msg)
	if status == 0 then
		local oldLv = msg.oldLv
		local lv = msg.lv

		AirWorkShopChallengeModel.instance:setRodeoSettle(false)
		self:sendRodeoInfoRequest()
		ToolTipsMgr.showAirWorkShopRodeoWeekRewardTips(oldLv, lv)
	end
end

function M:sendGetHotMapRequest()
	local msg = AirAtkExtension_pb.GetHotMapRequest()

	self:sendMsg(msg)
end

function M:handleGetHotMapReply(status, msg)
	local hotRankLst = {}

	if status == 0 then
		for _, AirMapRecordNO in ipairs(msg.rank or {}) do
			table.insert(hotRankLst, AirMapRecordNO)
		end
	end

	GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_HOT_MAP_REPLY, hotRankLst)
end

function M:sendGetAirPageRequest(userId, pageType)
	local msg = AirAtkExtension_pb.GetAirPageRequest()

	msg.userId = userId
	self._getAirPageInfo = {
		userId = userId,
		pageType = pageType
	}

	self:sendMsg(msg)
end

function M:handleGetAirPageReply(status, msg)
	if status == 0 then
		local userId, pageType

		if self._getAirPageInfo then
			userId = self._getAirPageInfo.userId
			pageType = self._getAirPageInfo.pageType
		end

		GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_AIR_PAGE_REPLY, AirWorkShopEnum.PersonalPageType.Main, msg)

		if userId then
			if ViewMgr.instance:isOpen(ViewName.AirWorkShopPersonalView) then
				local info = {
					userId = userId,
					tabIndex = AirWorkShopEnum.PersonalPageType.Main,
					mainPageMsg = msg
				}

				GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_AIR_PAGE_USER_CHANGE, info)
			else
				local info = {
					userId = userId,
					tabIndex = pageType,
					mainPageMsg = msg
				}

				ViewMgr.instance:open(ViewName.AirWorkShopPersonalView, info)
			end
		end
	end

	self._getAirPageInfo = nil
end

function M:sendGetAirCupPageRequest(userId)
	local msg = AirAtkExtension_pb.GetAirCupPageRequest()

	msg.userId = userId

	self:sendMsg(msg)
end

function M:handleGetAirCupPageReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_AIR_PAGE_REPLY, AirWorkShopEnum.PersonalPageType.Trophy, msg)
	end
end

function M:sendGetCreatedMapPageRequest(userId, page)
	local msg = AirAtkExtension_pb.GetCreatedMapPageRequest()

	msg.userId = userId
	msg.page = page

	self:sendMsg(msg)
end

function M:handleGetCreatedMapPageReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_AIR_PAGE_REPLY, AirWorkShopEnum.PersonalPageType.LevelPublish, msg)
	end
end

function M:sendGetLikedMapPageRequest(userId, page)
	local msg = AirAtkExtension_pb.GetLikedMapPageRequest()

	msg.userId = userId
	msg.page = page

	self:sendMsg(msg)
end

function M:handleGetLikedMapPageReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_AIR_PAGE_REPLY, AirWorkShopEnum.PersonalPageType.LevelLike, msg)
	end
end

function M:sendGetHistoryPageRequest(userId, page)
	local msg = AirAtkExtension_pb.GetHistoryPageRequest()

	msg.userId = userId
	msg.page = page

	self:sendMsg(msg)
end

function M:handleGetHistoryPageReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_AIR_PAGE_REPLY, AirWorkShopEnum.PersonalPageType.LevelHistory, msg)
	end
end

function M:handleChallengeNumChange(status, msg)
	if status == 0 then
		AirWorkShopController.instance:onChallengeNumChange(msg)
	end
end

function M:handleWeekSettlePush(status, msg)
	if status == 0 then
		AirWorkShopController.instance:onWeekSettlePush(msg)
	end
end

function M:handleBattleSettlePush(status, msg)
	if status == 0 then
		if msg.rodeo and msg.rodeo.round == 5 then
			AirWorkShopChallengeModel.instance:setRodeoSettle(true)
		end

		self:sendRodeoInfoRequest()
		self:sendFreeEndlessInfoRequest()
		AirWorkShopController.instance:onBattleSettlePush(msg)
	end
end

function M:sendExchangeRequest(useProps)
	local msg = AirAtkExtension_pb.ExchangeRequest()

	msg.props = useProps

	self:sendMsg(msg)
end

function M:handleExchangeReply(status, msg)
	if status == 0 then
		ToolTipsMgr.showCharacterTopToast(lang("tip_air_challengenum_exchange_succ"), CommEnum.CharacterTopToastIcon.Succ, 1)
	end
end

function M:sendGetRodeoRankRequest(week, part, startIndex, endIndex, useFakeData)
	local msg = AirAtkExtension_pb.GetRodeoRankRequest()

	msg.week = week
	msg.part = part
	msg.startIndex = startIndex
	msg.endIndex = endIndex
	self._rodeoRankReqInfo = {
		week = week,
		part = part,
		startIndex = startIndex,
		endIndex = endIndex,
		useFakeData = useFakeData
	}

	self:sendMsg(msg)
end

function M:handleGetRodeoRankReply(status, msg)
	if status == 0 then
		self._rodeoRankReqInfo.listRankEntryNO = msg.entry
		self._rodeoRankReqInfo.myRankEntryNO = msg.myEntry

		AirWorkShopChallengeModel.instance:updateRankFromServer(self._rodeoRankReqInfo)
	end
end

function M:handleRodeoFinishPush(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_RODEO_FINISH_PUSH, msg.round)
	end
end

M.instance = M.New()

return M
