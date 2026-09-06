-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualactivity/controller/AnnualActivityController.lua

module("logic.extensions.annualactivity.controller.AnnualActivityController", package.seeall)

local AnnualActivityController = class("AnnualActivityController", BaseController)

AnnualActivityController.GoldBarInfo = {
	{
		tipsName = "",
		viewIndex = 1,
		viewName = ViewName.AnnualPuzzle,
		btnName = lang("text_annual_desc_7")
	},
	{
		tipsName = "",
		viewIndex = 2,
		viewName = ViewName.AnnualTask,
		btnName = lang("text_annual_desc_8")
	}
}

function AnnualActivityController:ctor()
	return
end

function AnnualActivityController:onInit()
	AnnualActivityController.super.onInit(self)
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._TickDailyRefreshData, self)
end

function AnnualActivityController:onReset()
	return
end

function AnnualActivityController:_TickDailyRefreshData()
	local actId = AnnualActivityConfig.instance:getOpenActivityId()

	if checknumber(actId) <= 0 then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.AnnualActivity) then
		self:csRequestPJGetPosterInfoReq(actId)
	end

	if ViewMgr.instance:isOpen(ViewName.AnnualTask) then
		self:csRequestPJGetTaskInfoReq(actId)
	end
end

function AnnualActivityController:csRequestPJGetPosterInfoReq(actId)
	PosterJigsawAgent.instance:sendPM_PJGetPosterInfoReq(actId)
end

function AnnualActivityController:scPushPJGetPosterInfo(msg)
	AnnualActivityModel.instance:scPushPJGetPosterInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataAnnualActivityPoster)
end

function AnnualActivityController:csRequestPJActivateJigsawReq(actId, posterId, index)
	PosterJigsawAgent.instance:sendPM_PJActivateJigsawReq(actId, posterId, index)
end

function AnnualActivityController:scPushPJActivateJigsaw(msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	AnnualActivityModel.instance:scPushPJActivateJigsaw(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataAnnualActivityPoster, msg)
end

function AnnualActivityController:csRequestPJGainBigPrizeReq(actId, posterId)
	PosterJigsawAgent.instance:sendPM_PJGainBigPrizeReq(actId, posterId)
end

function AnnualActivityController:scPushPJGainBigPrize(msg)
	AnnualActivityModel.instance:scPushPJGainBigPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataAnnualActivityPoster)
end

function AnnualActivityController:csRequestPJGetTaskInfoReq(actId)
	PosterJigsawAgent.instance:sendPM_PJGetTaskInfoReq(actId)
end

function AnnualActivityController:scPushPJGetTaskInfo(msg)
	AnnualActivityModel.instance:scPushPJGetTaskInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataAnnualActivityTask)
end

function AnnualActivityController:csRequestPJGainTaskPrizeReq(actId, taskId)
	PosterJigsawAgent.instance:sendPM_PJGainTaskPrizeReq(actId, taskId)
end

function AnnualActivityController:scPushPJGainTaskPrize(msg)
	AnnualActivityModel.instance:scPushPJGainTaskPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataAnnualActivityTask)
end

function AnnualActivityController:csRequestPJLotteryReq(actId)
	PosterJigsawAgent.instance:sendPM_PJLotteryReq(actId)
end

function AnnualActivityController:scPushPJLottery()
	GlobalDispatcher:dispatch(GlobalNotify.UpdataAnnualActivityPoster)
end

AnnualActivityController.instance = AnnualActivityController.New()

return AnnualActivityController
