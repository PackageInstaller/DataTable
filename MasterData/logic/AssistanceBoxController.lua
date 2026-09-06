-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assistancebox/controller/AssistanceBoxController.lua

module("logic.extensions.assistancebox.controller.AssistanceBoxController", package.seeall)

local AssistanceBoxController = class("AssistanceBoxController", BaseController)

function AssistanceBoxController:ctor()
	AssistanceBoxController.super.ctor(self)
end

function AssistanceBoxController:onInit()
	AssistanceBoxAgent.instance:addHandler(AssistanceBoxAgent.PM_AssistanceBoxTrigger, self.onBoxTrigger, self)
	AssistanceBoxAgent.instance:addHandler(AssistanceBoxAgent.PM_AssistanceBoxInvite, self.onBoxInvite, self)
	AssistanceBoxAgent.instance:addHandler(AssistanceBoxAgent.PM_AssistanceBoxBeHelp, self.onBoxBeHelp, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewOpenDone, self.tryOpenTriggerView, self)
	self:onReset()
end

function AssistanceBoxController:onReset()
	self.isTriggerBox = false
	self.msgMap = {}
	self.msgCdMap = {}
end

function AssistanceBoxController:onBoxTrigger(msg, status)
	self.isTriggerBox = true

	self:tryOpenTriggerView()
end

function AssistanceBoxController:tryOpenTriggerView()
	if self.isTriggerBox and (ViewMgr.instance:isOpen(ViewName.HolyStripeCopyView) or ViewMgr.instance:isOpen(ViewName.MainUI) or ViewMgr.instance:isOpen(ViewName.HolyStripeCopyChallengeView) or ViewMgr.instance:isOpen(ViewName.FormTeamCurTeamView)) then
		UIStateManager.instance:push(ViewName.AssistanceboxopenView)

		self.isTriggerBox = false
	end
end

function AssistanceBoxController:onBoxInvite(msg, status)
	if msg and msg.record and msg.record.headInfo then
		local todayGainPrizeCount = msg.todayGainPrizeCount
		local total = checknumber(AssistanceBoxConfig.instance:getParamValue("DAILY_HELP_TIME"))
		local left = total - todayGainPrizeCount
		local time = checknumber(AssistanceBoxConfig.instance:getParamValue("INVITATION_SHOW_CD"))
		local rcd = checknumber(self.msgCdMap[msg.record.headInfo.userId])

		if time < ServerTime.now() - rcd then
			self:_tryUnregPopupMsg(msg.record.headInfo.userId)

			self.msgMap[msg.record.headInfo.userId] = MainUIPopupMsgController.instance:regPopMsg({
				bTimeOutReject = true,
				showInitCD = time,
				acceptFunc = self._tryAcceptInvite,
				rejectFunc = function()
					return
				end,
				thisArg = self,
				desc = langPara("助力宝箱（剩余奖励次数：%s）", left),
				headInfo = msg.record.headInfo,
				record = msg.record
			})
			self.msgCdMap[msg.record.headInfo.userId] = ServerTime.now()
		end
	end
end

function AssistanceBoxController:_tryAcceptInvite(params)
	local info = params.info
	local headInfo = info.headInfo
	local record = info.record

	AssistanceBoxModel.instance:resetView()
	UIStateManager.instance:push(ViewName.AssistanceboxView, headInfo.userId, record.boxToken)
end

function AssistanceBoxController:_tryUnregPopupMsg(userId)
	local key = self.msgMap[userId]

	MainUIPopupMsgController.instance:removePopMsg(key)

	self.msgMap[userId] = nil
	self.msgCdMap[userId] = nil
end

function AssistanceBoxController:sendGentInfo()
	AssistanceBoxAgent.instance:sendPM_AssistanceBoxGetInfoReq()
end

function AssistanceBoxController:onGetInfo(msg)
	AssistanceBoxModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnGetAssistanceBoxInfo)
end

function AssistanceBoxController:sendUserInvite(usersList)
	AssistanceBoxAgent.instance:sendPM_AssistanceBoxInviteReq(usersList)
end

function AssistanceBoxController:onUserInvite(msg)
	TipsFacade.instance:openCommonTips(lang("成功发送助力邀请"))
	GlobalDispatcher:dispatch(GlobalNotify.OnGetAssistanceBoxInvite)
end

function AssistanceBoxController:sendGetMyRecord()
	AssistanceBoxAgent.instance:sendPM_AssistanceBoxGetRecordReq()
end

function AssistanceBoxController:onGetMyRecord(msg)
	AssistanceBoxModel.instance:onGetMyRecord(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnGetAssistanceBoxInfo)
end

function AssistanceBoxController:sendBoxHelp(boxOwnerId, boxToken)
	self.tmpBoxOwnerId = boxOwnerId

	AssistanceBoxAgent.instance:sendPM_AssistanceBoxHelpReq(boxOwnerId, boxToken)
end

function AssistanceBoxController:onBoxHelp(msg)
	AssistanceBoxModel.instance:onBoxHelp(msg)
	AssistanceBoxModel.instance:onGetOtherBoxInfo(msg)
	self:_tryUnregPopupMsg(self.tmpBoxOwnerId)
	GlobalDispatcher:dispatch(GlobalNotify.OnGetAssistanceBoxHelpSuccess)
end

function AssistanceBoxController:sendBoxGain()
	AssistanceBoxAgent.instance:sendPM_AssistanceBoxGainPrizeReq()
end

function AssistanceBoxController:onBoxGain(msg)
	AssistanceBoxModel.instance:onGetOtherBoxInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnGetAssistanceBoxGainSuccess)
end

function AssistanceBoxController:sendGetOtherBoxInfo(boxOwnerId, boxToken)
	AssistanceBoxAgent.instance:sendPM_AssistanceBoxGetOtherInfoReq(boxOwnerId, boxToken)
end

function AssistanceBoxController:onGetOtherBoxInfo(msg)
	AssistanceBoxModel.instance:onGetOtherBoxInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnGetAssistanceBoxInfo)
end

function AssistanceBoxController:onBoxBeHelp(msg)
	AssistanceBoxController.instance:sendGentInfo()
	GlobalDispatcher:dispatch(GlobalNotify.OnGetAssistanceBoxBeHelp)
end

AssistanceBoxController.instance = AssistanceBoxController.New()

return AssistanceBoxController
