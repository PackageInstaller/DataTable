local PushSnowBallTeamTaskPopView = class("PushSnowBallTeamTaskPopView", ReduxView)

function PushSnowBallTeamTaskPopView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballQuestPopUI"
end

function PushSnowBallTeamTaskPopView:UIParent()
	return manager.ui.uiPop.transform
end

function PushSnowBallTeamTaskPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PushSnowBallTeamTaskPopView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.taskList_, PushSnowBallTeamTaskItem)
	self.rewardController_ = ControllerUtil.GetController(self.transform_, "clear")
end

function PushSnowBallTeamTaskPopView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(self.taskDataList_) do
			if AssignmentCfg[iter_7_1.id].need <= iter_7_1.progress and iter_7_1.complete_flag < 1 then
				var_7_0[#var_7_0 + 1] = iter_7_1.id
			end
		end

		TaskAction:SubmitTaskList(var_7_0)
	end)
end

function PushSnowBallTeamTaskPopView:OnEnter()
	self:RefreshUI()
end

function PushSnowBallTeamTaskPopView:OnTaskListChange()
	self:RefreshUI()
end

function PushSnowBallTeamTaskPopView:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_1, self.taskDataList_[arg_10_1])
end

function PushSnowBallTeamTaskPopView:RefreshUI()
	self.taskDataList_ = PushSnowBallData:GetTeamParticipateTaskList()

	self.uiList_:StartScroll(#self.taskDataList_)
	self.rewardController_:SetSelectedState(tostring((PushSnowBallData:GetHasCompeletedTeamTask())))
end

function PushSnowBallTeamTaskPopView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	PushSnowBallTeamTaskPopView.super.Dispose(self)
end

return PushSnowBallTeamTaskPopView
