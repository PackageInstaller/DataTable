-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signin/agent/WelfareSigninAgent.lua

module("logic.extensions.signin.agent.WelfareSigninAgent", package.seeall)

local M = class("WelfareSigninAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	return
end

function M:_handleErrorMsgShow(status, funcMsg)
	if enableErrorLog then
		local itemInfo = LanguageMgr.instance:getLangRcInfo(tostring(status))

		if itemInfo and itemInfo.workType ~= 0 then
			FloatWordMgr.instance:show(LanguageMgr.instance:getText(itemInfo))
		else
			printError(string.format("status[%d],func : %s", status, funcMsg or ""))
		end
	end
end

function M:sendGetSignInInfoRequest()
	local req = ActivityExtension_pb.GetSignInInfoRequest()

	self:sendMsg(req)
end

function M:handleGetSignInInfoReply(status, msg)
	if status == 0 then
		SigninController.instance:refreshSignInInfoLst(msg.infos)
	else
		self:_handleErrorMsgShow(status, "[3]handleGetSignInInfoReply")
	end
end

function M:sendTakeSignInRewardRequest(activityId, day)
	local req = ActivityExtension_pb.TakeSignInRewardRequest()

	req.activity = activityId
	req.day = WelfareSigninUtil.client2ServerDay(day)

	self:sendMsg(req)
end

function M:handleTakeSignInRewardReply(status, msg)
	if status == 0 then
		SigninController.instance:onSignInReward(msg.activity, msg.day)
	end
end

M.instance = M.New()

return M
