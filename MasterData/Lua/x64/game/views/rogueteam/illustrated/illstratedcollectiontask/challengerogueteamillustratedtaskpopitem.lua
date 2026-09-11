local ChallengeRogueTeamIllustratedTaskPopItem = class("ChallengeRogueTeamIllustratedTaskPopItem", ReduxView)

function ChallengeRogueTeamIllustratedTaskPopItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ChallengeRogueTeamIllustratedTaskPopItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.itemGoList_ = {}

	for iter_2_0 = 1, 3 do
		table.insert(self.itemGoList_, self["awardItem" .. iter_2_0 .. "Obj_"])
	end

	self.itemList_ = {}
	self.btnController_ = self.controller_:GetController("all")
end

function ChallengeRogueTeamIllustratedTaskPopItem:InitUI()
	self:BindCfgUI()
end

function ChallengeRogueTeamIllustratedTaskPopItem:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function ChallengeRogueTeamIllustratedTaskPopItem:IndexItem(arg_6_1, arg_6_2)
	local var_6_0 = formatReward(self.rewardData_[arg_6_1])
	local var_6_1 = clone(ItemTemplateData)

	var_6_1.id = var_6_0.id
	var_6_1.number = var_6_0.num
	var_6_1.timeValid = var_6_0.timeValid or 0

	function var_6_1:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	arg_6_2:SetData(var_6_1)
end

function ChallengeRogueTeamIllustratedTaskPopItem:SetData(arg_8_1)
	self.taskID_ = arg_8_1
	self.cfg_ = AssignmentCfg[arg_8_1]
	self.rewardData_ = self.cfg_.reward

	if not self.taskID_ or self.taskID_ == 0 then
		return
	end

	self:UpdateView()
end

function ChallengeRogueTeamIllustratedTaskPopItem:UpdateView()
	local var_9_0 = TaskData2:GetTaskComplete(self.taskID_)
	local var_9_1 = TaskData2:GetTaskProgress(self.taskID_) >= self.cfg_.need

	self.titleText_.text = self.cfg_.desc

	if var_9_0 then
		self.btnController_:SetSelectedState("complete")
	elseif var_9_1 then
		self.btnController_:SetSelectedState("receive")
	else
		self.btnController_:SetSelectedState("lock")
	end

	for iter_9_0, iter_9_1 in ipairs(self.itemGoList_) do
		self.itemList_[iter_9_0] = self.itemList_[iter_9_0] or CommonItemView.New(iter_9_1)

		if self.rewardData_[iter_9_0] then
			self:IndexItem(iter_9_0, self.itemList_[iter_9_0])
			SetActive(iter_9_1, true)
		else
			SetActive(iter_9_1, false)
		end
	end
end

function ChallengeRogueTeamIllustratedTaskPopItem:Dispose()
	self:RemoveAllListeners()

	if self.itemList_ then
		for iter_10_0, iter_10_1 in ipairs(self.itemList_) do
			iter_10_1:Dispose()
		end
	end

	ChallengeRogueTeamIllustratedTaskPopItem.super.Dispose(self)
end

return ChallengeRogueTeamIllustratedTaskPopItem
