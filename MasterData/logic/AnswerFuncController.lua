-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/answerfunc/controller/AnswerFuncController.lua

module("logic.extensions.answerfunc.controller.AnswerFuncController", package.seeall)

local AnswerFuncController = class("AnswerFuncController", BaseController)

function AnswerFuncController:ctor()
	return
end

function AnswerFuncController:onInit()
	self:onReset()
end

function AnswerFuncController:onReset()
	GlobalDispatcher:addListener("gotoanswerfuncview", self.gotoAnswerFuncView, self)
end

function AnswerFuncController:_onHandTickDailyRefresh()
	return
end

function AnswerFuncController:csGetAnswerProblemUnlockPlotInfoReq(activityId)
	AnswerProblemUnlockPlotAgent.instance:sendPM_AnswerProblemUnlockPlotInfoReq(activityId)
end

function AnswerFuncController:scSendAnswerProblemUnlockPlotInfo(msg)
	AnswerFuncModel.instance:scSendAnswerProblemUnlockPlotInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.Answer_UpdataFuncInfo)
end

function AnswerFuncController:csGetAnswerProblemUnlockPlotGainPrizeReq(activityId, onlyId)
	AnswerProblemUnlockPlotAgent.instance:sendPM_AnswerProblemUnlockPlotGainPrizeReq(activityId, onlyId)
end

function AnswerFuncController:scSendAnswerProblemUnlockPlotGainPrize(msg)
	AnswerFuncModel.instance:scSendAnswerProblemUnlockPlotGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.Answer_UpdataStoryPrize)
end

function AnswerFuncController:csGetAnswerProblemUnlockPlotStartAnswerReq(activityId)
	local clientKey = math.random(ServerTime.now())

	AnswerFuncModel.instance:setClientKey(clientKey)
	AnswerProblemUnlockPlotAgent.instance:sendPM_AnswerProblemUnlockPlotStartAnswerReq(activityId, clientKey)
end

function AnswerFuncController:scSendAnswerProblemUnlockPlotStartAnswer(msg)
	AnswerFuncModel.instance:setServerKey(msg.encryptedKey)
	GlobalDispatcher:dispatch(GlobalNotify.Answer_UpdataCurrentAnswer, checknumber(msg.questionId), true, checknumber(msg.addScore))
end

function AnswerFuncController:csGetAnswerProblemUnlockPlotAnswerReq(activityId, isRight, questionId)
	local curKey = AnswerFuncModel.instance:getEncryptedKey(activityId, questionId, isRight and 1 or 0)

	AnswerProblemUnlockPlotAgent.instance:sendPM_AnswerProblemUnlockPlotAnswerReq(activityId, isRight, questionId, curKey)
end

function AnswerFuncController:scSendAnswerProblemUnlockPlotAnswer(msg)
	GlobalDispatcher:dispatch(GlobalNotify.Answer_UpdataCurrentAnswer, checknumber(msg.nextQuestionId), false, checknumber(msg.addScore))
end

function AnswerFuncController:csGetAnswerProblemUnlockPlotAnswerEndReq(activityId)
	AnswerProblemUnlockPlotAgent.instance:sendPM_AnswerProblemUnlockPlotAnswerEndReq(activityId)
end

function AnswerFuncController:scSendAnswerProblemUnlockPlotAnswerEnd(msg)
	return
end

function AnswerFuncController:scSendAnswerProblemUnlockPlotResult(msg)
	AnswerFuncModel.instance:scSendAnswerProblemUnlockPlotResult(msg)
	GlobalDispatcher:dispatch(GlobalNotify.Answer_UpdataResultAnswer, msg)
end

function AnswerFuncController:sendPM_AnswerProblemSelectTypeReq(activityId, typeId)
	AnswerProblemUnlockPlotAgent.instance:sendPM_AnswerProblemSelectTypeReq(activityId, typeId)
end

function AnswerFuncController:handlePM_AnswerProblemSelectTypeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.Answer_SelectTypeRes)
end

function AnswerFuncController:gotoAnswerFuncView(params)
	self:openAnswerFuncView()
end

function AnswerFuncController:openAnswerFuncView()
	local activityId = AnswerFuncConfig.instance:getAnswerFuncActivityId()

	if activityId <= 0 then
		FloatWordMgr.instance:show("不在活动时间范围内")

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.Answer_UpdataFuncInfo, self._handleOpenAnswerFuncView, self)
	AnswerFuncController.instance:csGetAnswerProblemUnlockPlotInfoReq(activityId)
end

function AnswerFuncController:_handleOpenAnswerFuncView()
	GlobalDispatcher:removeListener(GlobalNotify.Answer_UpdataFuncInfo, self._handleOpenAnswerFuncView, self)

	local info = AnswerFuncModel.instance:getAnswerFuncInfo()
	local activityId = info.activityId
	local typeId = info.typeId

	if typeId == 0 then
		FloatWordMgr.instance:show("请先选择女神团")

		return
	else
		local typeData = AnswerFuncConfig.instance:getTypeData(activityId, typeId)

		if typeData == nil then
			printError(string.format("题目类型缺失(activityId=%s, typeId=%s)", activityId, typeId))

			return
		end
	end

	UIStateManager.instance:push(ViewName.AnswerFunc)
end

AnswerFuncController.instance = AnswerFuncController.New()

return AnswerFuncController
