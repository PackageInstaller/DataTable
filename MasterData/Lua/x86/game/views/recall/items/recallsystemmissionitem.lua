local RecallSystemMissionItem = class("RecallSystemMissionItem", ReduxView)

function RecallSystemMissionItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RecallSystemMissionItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function RecallSystemMissionItem:AddUIListener()
	self:AddBtnListener(self.completeBtn_, nil, function()
		TaskAction:SubmitTask(self.taskCfg.id)
	end)
end

function RecallSystemMissionItem:InitUI()
	self:BindCfgUI()

	self.controller = ControllerUtil.GetController(self.gameObject_.transform, "state")
	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, CommonItemView)
end

function RecallSystemMissionItem:IndexItem(arg_6_1, arg_6_2)
	CommonTools.SetCommonData(arg_6_2, {
		id = self.rewardList[arg_6_1][1],
		number = self.rewardList[arg_6_1][2],
		clickFun = function(self)
			ShowPopItem(POP_OTHER_ITEM, {
				self.id,
				self.number
			})
		end
	})
end

function RecallSystemMissionItem:SetData(arg_8_1)
	self.taskCfg = AssignmentCfg[arg_8_1.id]
	self.taskInfo = arg_8_1
	self.rewardList = self.taskCfg.reward or {}

	self:UpdateView()
end

function RecallSystemMissionItem:UpdateView()
	self.list_:StartScrollWithoutAnimator(#self.rewardList)

	self.taskDescTxt_.text = self.taskCfg.desc

	local var_9_0 = self.taskInfo.progress

	if self.taskCfg.need < self.taskInfo.progress then
		var_9_0 = self.taskCfg.need
	end

	self.taskProgressTxt_.text = string.format("%d/%d", var_9_0, self.taskCfg.need)

	if self.taskInfo.complete_flag == 1 then
		self.controller:SetSelectedState("accepted")
	elseif self.taskCfg.need <= var_9_0 then
		self.controller:SetSelectedState("complete")
	else
		self.controller:SetSelectedState("uncomplete")
	end

	self.taskTypeTxt_.text = self.taskCfg.name
end

function RecallSystemMissionItem:OnEnter()
	return
end

function RecallSystemMissionItem:OnExit()
	return
end

function RecallSystemMissionItem:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	RecallSystemMissionItem.super.Dispose(self)
end

return RecallSystemMissionItem
