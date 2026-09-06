-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brothergroup/controller/BrotherGroupController.lua

module("logic.extensions.brothergroup.controller.BrotherGroupController", package.seeall)

local BrotherGroupController = class("BrotherGroupController", BaseController)

function BrotherGroupController:onInit()
	GlobalDispatcher:addListener("brother_group_open", self._add2PopupMsg, self)
	self:onReset()
end

function BrotherGroupController:onReset()
	self._popMsgIds = {}
end

function BrotherGroupController:getInfo()
	BrotherGroupAgent.instance:sendPM_BrotherGroupInfoReq()
end

function BrotherGroupController:handleGetInfo(msg)
	BrotherGroupModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupGetInfo)
	GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupUpdateTeammateInfo)
end

function BrotherGroupController:getRequestList()
	BrotherGroupAgent.instance:sendPM_BrotherGroupRequestListReq()
end

function BrotherGroupController:handleGetRequestList(msg)
	BrotherGroupModel.instance:onGetRequestList(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupUpdateRequestList)
end

function BrotherGroupController:sendRequest(targetUserId)
	BrotherGroupAgent.instance:sendPM_BrotherGroupSendRequestReq(targetUserId)
end

function BrotherGroupController:handleSendRequest(msg)
	return
end

function BrotherGroupController:handleRequest(userId, action)
	BrotherGroupAgent.instance:sendPM_BrotherGroupHandlerRequestReq(userId, action)
end

function BrotherGroupController:handleHandleRequest(msg)
	BrotherGroupModel.instance:onHandleRequest(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupUpdateRequestList)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_BROTHER_GROUP_INVITE_RED, BrotherGroupModel.instance:isShowInviteRed())
	self:_add2PopupMsg()

	if msg.result == 0 then
		UIStateManager.instance:clear()
		UIStateManager.instance:push(ViewName.BrotherGroupView)
	end
end

function BrotherGroupController:personMatching()
	BrotherGroupAgent.instance:sendPM_BrotherGroupPersonalMatchingReq()
end

function BrotherGroupController:handlePersonMatching(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupStartMatching)
end

function BrotherGroupController:teamMatching()
	BrotherGroupAgent.instance:sendPM_BrotherGroupTeamMatchingReq()
end

function BrotherGroupController:handleTeamMatching(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupStartMatching)
end

function BrotherGroupController:cancelMatching()
	BrotherGroupAgent.instance:sendPM_BrotherGroupCancelMatchingReq()
end

function BrotherGroupController:handleCancelMatching(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupEndMatching)
end

function BrotherGroupController:gainPersonalPrize(prizeId)
	BrotherGroupAgent.instance:sendPM_BrotherGroupGainPersonalPrizeReq(prizeId)
end

function BrotherGroupController:handleGainPersonalPrize(msg)
	BrotherGroupModel.instance:onGainPersonPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupUpdatePrizeList)
end

function BrotherGroupController:getTaskInfo()
	BrotherGroupAgent.instance:sendPM_BrotherGroupGetTaskInfoReq()
end

function BrotherGroupController:handleGetTaskInfo(msg)
	BrotherGroupModel.instance:onGetTaskInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupUpdateTaskInfo)
end

function BrotherGroupController:gainTaskPrize(taskId)
	BrotherGroupAgent.instance:sendPM_BrotherGroupGainTaskPrizeReq(taskId)
end

function BrotherGroupController:handleGainTaskPrize(msg)
	BrotherGroupModel.instance:onFinishTask(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupUpdateTaskInfo)
end

function BrotherGroupController:handleNotifyReceived(msg)
	BrotherGroupModel.instance:onGetReceived(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupUpdateRequestList)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_BROTHER_GROUP_INVITE_RED, BrotherGroupModel.instance:isShowInviteRed())
end

function BrotherGroupController:handleNotifyTeamInfoChange(msg)
	BrotherGroupModel.instance:onTeammateUpdate(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupUpdateTeammateInfo)
end

function BrotherGroupController:handleNotifyMatchingSuc(msg)
	BrotherGroupModel.instance:onTeammateUpdate(msg)
	BrotherGroupModel.instance:removeAllInviteInfo()
	GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupUpdateTeammateInfo)
	GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupMatchSuc)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_BROTHER_GROUP_INVITE_RED, false)
end

function BrotherGroupController:handleNotifyMatchingFail(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupMatchFail)
end

function BrotherGroupController:_add2PopupMsg()
	self:_removeAllPopMsg()

	if not BrotherGroupModel.instance:isExitTeam() then
		local infoHash = BrotherGroupModel.instance:getInviteInfoList()

		if table.nums(infoHash) > 0 then
			local dataList = {}

			for k, info in pairs(infoHash) do
				if info.inviteEndTime == -1 then
					info.inviteEndTime = ServerTime.now() + BrotherGroupConfig.instance:getCommomValue("MAX_REQUEST_TIME")
				end

				table.insert(dataList, info)
			end

			local function sort_func(a, b)
				return a.inviteEndTime < b.inviteEndTime
			end

			table.sort(dataList, sort_func)

			for i, request in ipairs(dataList) do
				local params = {
					bTimeOutReject = true,
					cd = request.inviteEndTime,
					askAcceptFunc = self._askAcceptInvite,
					acceptFunc = self._tryAcceptInvite,
					rejectFunc = self._tryRejectInvite,
					thisArg = self,
					headInfo = request.headInfo,
					desc = langPara("兄弟组队（队伍人数：%s）", request.memberNum),
					request = request
				}
				local index = MainUIPopupMsgController.instance:regPopMsg(params)

				table.insert(self._popMsgIds, index)
			end
		end
	end
end

function BrotherGroupController:_removeAllPopMsg()
	for userId, index in pairs(self._popMsgIds) do
		MainUIPopupMsgController.instance:removePopMsg(index)
	end

	self._popMsgIds = {}
end

function BrotherGroupController:_tryAcceptInvite(data)
	local info = data.info
	local headInfo = info.headInfo

	self:handleRequest(headInfo.userId, 1)
end

function BrotherGroupController:_tryRejectInvite(data)
	local info = data.info
	local headInfo = info.headInfo

	self:handleRequest(headInfo.userId, 2)
end

BrotherGroupController.instance = BrotherGroupController.New()

return BrotherGroupController
