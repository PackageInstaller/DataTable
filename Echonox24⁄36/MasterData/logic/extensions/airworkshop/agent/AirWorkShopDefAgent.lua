-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/agent/AirWorkShopDefAgent.lua

module("logic.extensions.airworkshop.agent.AirWorkShopDefAgent", package.seeall)

local M = class("AirWorkShopDefAgent", BaseAgent)

function M:_onReset()
	self._createdMap = false
	self._modifyMap = false
end

function M:sendGetAirMapListRequest()
	local msg = AirStudioDefExtension_pb.GetAirMapListRequest()

	self:sendMsg(msg)
end

function M:handleGetAirMapListReply(status, msg)
	if status == 0 then
		AirWorkMapModel.instance:initAirMapList(msg.map)
		AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.ON_GET_MAPLIST_DONE)
	end
end

function M:sendCreateAirMapRequest(mapMO, index)
	if self._createdMap then
		return
	end

	self._createdMap = mapMO
	self._createIndex = index

	local msg = AirStudioDefExtension_pb.CreateAirMapRequest()

	mapMO:trans2AgentForm(msg.info)

	msg.createPos = index

	self:sendMsg(msg)
end

function M:handleCreateAirMapReply(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show(lang("tip_airwork_save_success"))
		AirWorkMapModel.instance:createAirMap(msg.id, self._createIndex, self._createdMap, msg.cover)
		AirWorkMapModel.instance:addImage2NewSavedLevel(msg.cover)
		AirWorkShopModel.instance:saveLastEditLevelMo(AirWorkMapModel.instance:getLevelMOById(msg.id))
		AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.ON_LEVEL_SAVED_SUCCESS)
	else
		local itemInfo = LanguageMgr.instance:getLangRcInfo(tostring(status))

		FloatWordMgr.instance:show(string.format(lang("tip_airwork_save_fail"), LanguageMgr.instance:getText(itemInfo)))
	end

	self._createdMap = false
end

function M:sendModifyAirMapRequest(id, mapMo)
	if self._modifyMap then
		return
	end

	local levelMO = AirWorkMapModel.instance:getLevelMOById(id)

	self._modifyMap = mapMo:deepCopy()

	local msg = AirStudioDefExtension_pb.ModifyAirMapRequest()

	mapMo:trans2AgentForm(msg.info)

	msg.id = id

	for heroId, v in pairs(mapMo:getRefreshHeros()) do
		table.insert(msg.refreshHeroId, heroId)
	end

	self:sendMsg(msg)
end

function M:handleModifyAirMapReply(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show(lang("tip_airwork_save_success"))

		local oldLevelMO = AirWorkMapModel.instance:getLevelMOById(msg.oldId)
		local oldCover = oldLevelMO:getCover()

		AirWorkMapModel.instance:modifyAirMap(msg.oldId, msg.newId, self._modifyMap, msg.newCover)
		AirWorkMapModel.instance:addImage2NewSavedLevel(msg.newCover, oldCover)

		if msg.oldId ~= msg.newId then
			AirWorkMapModel.instance:updateOnlineStatus(msg.newId, false)
		end

		AirWorkShopModel.instance:saveLastEditLevelMo(AirWorkMapModel.instance:getLevelMOById(msg.newId))
		AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.ON_LEVEL_SAVED_SUCCESS)
	else
		local itemInfo = LanguageMgr.instance:getLangRcInfo(tostring(status))

		FloatWordMgr.instance:show(string.format(lang("tip_airwork_save_fail"), LanguageMgr.instance:getText(itemInfo)))
	end

	self._modifyMap = false
end

function M:sendDeleteAirMapRequest(id)
	local msg = AirStudioDefExtension_pb.DeleteAirMapRequest()

	msg.id = id

	self:sendMsg(msg)
end

function M:handleDeleteAirMapReply(status, msg)
	if status == 0 then
		AirWorkMapModel.instance:deleteAirMap(msg.id)
		GlobalDispatcher:dispatchEvent(EventType.AIRWORKSHOP_MANAGER_DELETE)
	end
end

function M:sendTestAirMapRequest(id)
	local msg = AirStudioDefExtension_pb.TestAirMapRequest()

	msg.id = id

	self:sendMsg(msg)
end

function M:handleTestAirMapReply(status, msg)
	if status == 0 then
		AirWorkShopDefMgr.instance:exit()
		BattleEnterUtil.enterBattle(msg.info)
	end
end

function M:handleTestAirMapResultPush(status, msg)
	if status == 0 then
		printWarn("=====handleTestAirMapResultPush====")
		AirWorkMapModel.instance:testResult(msg)
		GlobalDispatcher:dispatchEvent(EventType.AIRWORKSHOP_MANAGER_TESTRESULT, AirWorkShopEnum.CalculateStyle.Test)
	end
end

function M:sendModifyAirMapOnlineStateRequest(id, online)
	local msg = AirStudioDefExtension_pb.ModifyAirMapOnlineStateRequest()

	msg.id = id
	msg.online = online

	self:sendMsg(msg)
end

function M:handleModifyAirMapOnlineStateReply(status, msg)
	if status == 0 then
		AirWorkMapModel.instance:updateOnlineStatus(msg.id, msg.online)
		GlobalDispatcher:dispatchEvent(EventType.AIRWORKSHOP_MANAGER_STATUS_UPDATE)
	end
end

function M:sendGetAirMapStatisticsRequest(id)
	local msg = AirStudioDefExtension_pb.GetAirMapStatisticsRequest()

	msg.id = id
	self._cacheStatisticsMapId = id

	self:sendMsg(msg)
end

function M:handleGetAirMapStatisticsReply(status, msg)
	if status == 0 then
		local id = self._cacheStatisticsMapId

		AirWorkShopStatisticsModel.instance:updateFromServer(id, msg)
		GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_BATTLE_STATISTICS_REPLY, id)

		self._cacheStatisticsMapId = nil
	end
end

function M:sendGetHotMapByTagRequest(tagId)
	local msg = AirStudioDefExtension_pb.GetHotMapByTagRequest()

	msg.tagId = tagId

	self:sendMsg(msg)
end

function M:handleGetHotMapByTagReply(status, msg)
	local hotRankLst = {}

	if status == 0 then
		for _, AirMapRecordNO in ipairs(msg.record or {}) do
			table.insert(hotRankLst, AirMapRecordNO)
		end
	end

	GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_HOT_MAP_BY_TAG_REPLY, hotRankLst)
end

function M:sendGetAirMapCellKillRequest(id)
	local msg = AirStudioDefExtension_pb.GetAirMapCellKillRequest()

	msg.id = id

	self:sendMsg(msg)
end

function M:handleGetAirMapCellKillReply(status, msg)
	if status == 0 then
		AirWorkMapModel.instance:setCellKillData(msg.cellKill)
		GlobalDispatcher:dispatchEvent(EventType.AIRWORKSHOP_CELL_KILLDATA_DONE)
	end
end

function M:sendGetAirInfoRequest()
	local msg = AirStudioDefExtension_pb.GetAirInfoRequest()

	self:sendMsg(msg)
end

function M:handleGetAirInfoReply(status, msg)
	if status == 0 then
		AirWorkShopController.instance:onGetAirInfoReply(msg.info)
	end
end

function M:sendGetAirTaskListRequest()
	local msg = AirStudioDefExtension_pb.GetAirTaskListRequest()

	self:sendMsg(msg)
end

function M:handleGetAirTaskListReply(status, msg)
	if status == 0 then
		AirWorkMapModel.instance:updateTask(msg.task)
		GlobalDispatcher:dispatchEvent(EventType.AIRWORKSHOP_TASK_UPDATE)
	end
end

function M:sendFinishAirTaskRequest(taskIds)
	local msg = AirStudioDefExtension_pb.FinishAirTaskRequest()

	for i, v in ipairs(taskIds) do
		table.insert(msg.id, v)
	end

	self:sendMsg(msg)
end

function M:handleFinishAirTaskReply(status, msg)
	if status == 0 then
		AirWorkMapModel.instance:updateTaskStatus(msg.id)
		self:sendGetAirTaskListRequest()
		GlobalDispatcher:dispatchEvent(EventType.AIRWORKSHOP_TASK_UPDATE)
	end
end

function M:sendCommentRequest(id, leaveMsgMo)
	local msg = AirStudioDefExtension_pb.CommentRequest()

	msg.id = id

	leaveMsgMo:trans2MessageCompositeNO(msg.msg)
	self:sendMsg(msg)
end

function M:handleCommentReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_COMMENT_MAP)
	end
end

function M:sendGetCommentsRequest(id)
	local msg = AirStudioDefExtension_pb.GetCommentsRequest()

	msg.id = id

	self:sendMsg(msg)
end

function M:handleGetCommentsReply(status, msg)
	local record

	if status == 0 then
		record = msg.record
	end

	GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_GET_MAP_COMMENTS_REPLY, record)
end

function M:sendGetAirMapTemplatesRequest(ids)
	local msg = AirStudioDefExtension_pb.GetAirMapTemplatesRequest()

	for i, v in ipairs(ids) do
		table.insert(msg.id, v)
	end

	self:sendMsg(msg)
end

function M:handleGetAirMapTemplatesReply(status, msg)
	if status == 0 then
		for i, v in ipairs(msg.template) do
			AirWorkMapModel.instance:addTemplateScene(v)
		end

		AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.ON_TEMPLATE_UPDATE)
	end
end

function M:sendGetAirMapNewsRequest(typeList)
	if not typeList or #typeList == 0 then
		return
	end

	self._getAirMapNewsReqTypeList = {}

	local msg = AirStudioDefExtension_pb.GetAirMapNewsRequest()

	for _, _type in ipairs(typeList) do
		table.insert(msg.type, _type)
		table.insert(self._getAirMapNewsReqTypeList, _type)
	end

	self:sendMsg(msg)
end

function M:sendGetAllAirMapNewsReq()
	local typeList = {
		GameEnum.AirMapNewsEnum.Comment,
		GameEnum.AirMapNewsEnum.Like,
		GameEnum.AirMapNewsEnum.Defence
	}

	self:sendGetAirMapNewsRequest(typeList)
end

function M:handleGetAirMapNewsReply(status, msg)
	if status == 0 then
		AirWorkShopModel.instance:onGetAirMapNewsReply(msg.news, self._getAirMapNewsReqTypeList)
		AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.ON_GET_AIR_MAP_NEWS_REPLY, msg.news, self._getAirMapNewsReqTypeList)
	end
end

function M:sendReadMapCommentsRequest(mapIds)
	local len = mapIds and #mapIds or 0

	if len == 0 then
		return
	end

	local msg = AirStudioDefExtension_pb.ReadMapCommentsRequest()

	for _, _mapId in ipairs(mapIds) do
		table.insert(msg.mapId, tonumber(_mapId))
	end

	self:sendMsg(msg)
end

function M:handleReadMapCommentsReply(status, msg)
	if status == 0 then
		self:sendGetAirMapNewsRequest({
			GameEnum.AirMapNewsEnum.Comment
		})
	end
end

function M:sendReadMapNewsRequest(typeList)
	local len = typeList and #typeList or 0

	if len == 0 then
		return
	end

	self._readMapNewsReqTypeList = typeList

	local msg = AirStudioDefExtension_pb.ReadMapNewsRequest()

	for _, _type in ipairs(typeList) do
		table.insert(msg.type, _type)
	end

	self:sendMsg(msg)
end

function M:handleReadMapNewsReply(status, msg)
	if status == 0 then
		self:sendGetAirMapNewsRequest(self._readMapNewsReqTypeList)

		self._readMapNewsReqTypeList = nil
	end
end

function M:sendReadAgreementRequest()
	local msg = AirStudioDefExtension_pb.ReadAgreementRequest()

	self:sendMsg(msg)
end

function M:handleReadAgreementReply(status, msg)
	if status == 0 then
		AirWorkShopModel.instance:updateAgreement()
		GlobalDispatcher:dispatchEvent(EventType.AGREE_AIRWORK_PROTOCOL_EVENT, true)
	end
end

M.instance = M.New()

return M
