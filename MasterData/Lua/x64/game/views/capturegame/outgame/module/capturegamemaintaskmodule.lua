local CaptureCheckPointModule = class("CaptureCheckPointModule", ReduxView)

function CaptureCheckPointModule:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CaptureCheckPointModule:Init()
	self:InitUI()
end

function CaptureCheckPointModule:InitUI()
	self:BindCfgUI()
	self:AddListener()

	self.timeController = self.greyController_:GetController("TImeTips")
	self.btnController = self.allBtnController_:GetController("all")

	self.timeController:SetSelectedState("false")

	self.rewardItem = {}

	for iter_3_0 = 1, 3 do
		table.insert(self.rewardItem, CommonItemView.New(self[string.format("awardItem%dObj_", iter_3_0)]))
	end
end

function CaptureCheckPointModule:AddListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		self:OnReceiveClick()
	end)
end

function CaptureCheckPointModule:OnReceiveClick()
	CaptureGameAction.ReceiveTaskReward({
		self.taskId
	})
end

function CaptureCheckPointModule:RenderReward()
	for iter_7_0 = 1, 3 do
		if ActivityPointRewardCfg[self.taskId].reward_item_list[iter_7_0] then
			local var_7_0 = clone(ItemTemplateData)

			var_7_0.id = ActivityPointRewardCfg[self.taskId].reward_item_list[iter_7_0][1]
			var_7_0.number = ActivityPointRewardCfg[self.taskId].reward_item_list[iter_7_0][2]

			function var_7_0:clickFun()
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end

			self.rewardItem[iter_7_0]:SetData(var_7_0)
		else
			self.rewardItem[iter_7_0]:SetData(nil)
		end
	end
end

function CaptureCheckPointModule:RenderView(arg_9_1)
	self.taskId = ActivityPointRewardCfg[arg_9_1].id
	self.activityId = ActivityPointRewardCfg[arg_9_1].activity_id
	self.need = ActivityPointRewardCfg[arg_9_1].need
	self.titleText_.text = self:GetTaskDescription(ActivityPointRewardCfg[arg_9_1].id)

	local var_9_0 = math.min(CaptureGameData:GetCompleteNumByMainActivity(self.activityId) or 0, ActivityPointRewardCfg[arg_9_1].need)

	self.progressText_.text = var_9_0 .. "/" .. ActivityPointRewardCfg[arg_9_1].need
	self.progressBar_.value = var_9_0 / ActivityPointRewardCfg[arg_9_1].need

	self:BuildBtnState()
	self:RenderReward()
end

function CaptureCheckPointModule:GetTaskDescription(arg_10_1)
	local var_10_1 = ""

	if self.activityId == CaptureGameConst.ModeMainActivity.Single then
		var_10_1 = "CAPTURE_GAME_TASK_SINGLE"
	end

	if self.activityId == CaptureGameConst.ModeMainActivity.Multi then
		var_10_1 = "CAPTURE_GAME_TASK_MULTI"
	end

	if self.activityId == CaptureGameConst.ModeMainActivity.MultiFree then
		var_10_1 = "CAPTURE_GAME_TASK_MULTI_FREE"
	end

	if self.activityId == CaptureGameConst.ModeMainActivity.SingleFree then
		var_10_1 = "CAPTURE_GAME_TASK_SINGLE_FREE"
	end

	return string.format(GetTips((self.activityId == CaptureGameConst.ModeMainActivity.Common or nil) and "CAPTURE_GAME_TASK_TOTAL"), ActivityPointRewardCfg[arg_10_1].need)
end

function CaptureCheckPointModule:BuildBtnState()
	if CaptureGameData:GetCompleteNumByMainActivity(self.activityId) < ActivityPointRewardCfg[self.taskId].need then
		self.btnController:SetSelectedState("lock")

		return
	end

	self.btnController:SetSelectedState(CaptureGameData:CheckTaskIsComplete(self.taskId) and "complete" or "receive")
end

function CaptureCheckPointModule:Dispose()
	CaptureCheckPointModule.super.Dispose(self)
end

return CaptureCheckPointModule
