local CaptureActivityMainView = class("CaptureActivityMainView", ReduxView)

function CaptureActivityMainView:UIName()
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/Main/Summer2024_CaptureTaskUI"
end

function CaptureActivityMainView:UIParent()
	return manager.ui.uiPop.transform
end

function CaptureActivityMainView:Init()
	self:InitUI()
end

function CaptureActivityMainView:BuildContext()
	return
end

function CaptureActivityMainView:InitUI()
	self:BindCfgUI()
	self:BuildContext()
	self:AddListener()

	self.scrollHelper = LuaList.New(handler(self, self.RenderItem), self.taskList_, CaptureGameMainTaskModule)
	self.taskUpdateHandler = handler(self, self.OnTaskUpdate)
	self.onceController = self.controller_:GetController("oneclick")
end

function CaptureActivityMainView:AddListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:OnBackClick()
	end)
	self:AddBtnListener(self.onceBtn_, nil, function()
		self:OnOnceClick()
	end)
end

function CaptureActivityMainView:OnBackClick()
	self:Back()
end

function CaptureActivityMainView:OnOnceClick()
	CaptureGameAction.ReceiveTaskReward((self:CheckTaskCanReceive()))
end

function CaptureActivityMainView:RenderItem(arg_11_1, arg_11_2)
	arg_11_2:RenderView(self.taskList[arg_11_1])
end

function CaptureActivityMainView:OnEnter()
	manager.notify:RegistListener(CAPTURE_GAME_OUTGAME_TASK_UPDATE, self.taskUpdateHandler)

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs({
		CaptureGameConst.ModeMainActivity.Single,
		CaptureGameConst.ModeMainActivity.Multi,
		CaptureGameConst.ModeMainActivity.Common
	}) do
		for iter_12_2, iter_12_3 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[iter_12_1]) do
			table.insert(var_12_0, iter_12_3)
		end
	end

	self.taskList = var_12_0

	self:OnTaskUpdate()
	self:RefreshOnce()
end

function CaptureActivityMainView:OnTaskUpdate()
	self:UpdateCounter()

	local var_13_0 = self

	table.sort(self.taskList, function(arg_14_0, arg_14_1)
		local var_14_0 = var_13_0:CheckSingleTaskCanReceive(arg_14_0)
		local var_14_1 = var_13_0:CheckSingleTaskCanReceive(arg_14_1)

		if var_14_0 ~= var_14_1 then
			if var_14_0 == 1 then
				return true
			end

			if var_14_1 == 1 then
				return false
			end

			if var_14_0 == 2 then
				return false
			end

			if var_14_1 == 2 then
				return true
			end

			return arg_14_0 < arg_14_1
		else
			return arg_14_0 < arg_14_1
		end
	end)
	self.scrollHelper:StartScroll(#self.taskList)
	self:RefreshOnce()
end

function CaptureActivityMainView:RefreshOnce()
	self.onceController:SetSelectedState(#self:CheckTaskCanReceive() > 0 and "state1" or "state0")
end

function CaptureActivityMainView:CheckSingleTaskCanReceive(arg_16_1)
	local var_16_0 = CaptureGameData:CheckTaskIsComplete(arg_16_1)

	if var_16_0 then
		return 2
	end

	if ActivityPointRewardCfg[arg_16_1].need <= (self.mainCountMap[ActivityPointRewardCfg[arg_16_1].activity_id] or 0) and not var_16_0 then
		return 1
	end

	return 0
end

function CaptureActivityMainView:CheckTaskCanReceive()
	self:UpdateCounter()

	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(self.taskList) do
		if self:CheckSingleTaskCanReceive(iter_17_1) == 1 then
			table.insert(var_17_0, iter_17_1)
		end
	end

	return var_17_0
end

function CaptureActivityMainView:UpdateCounter()
	self.mainCountMap = {
		[CaptureGameConst.ModeMainActivity.Single] = CaptureGameData:GetCaptureCountByMode(CaptureGameConst.ServerNeedGameMode.Single),
		[CaptureGameConst.ModeMainActivity.Multi] = CaptureGameData:GetCaptureCountByMode(CaptureGameConst.ServerNeedGameMode.Multiple),
		[CaptureGameConst.ModeMainActivity.Common] = CaptureGameData:GetCaptureCountFull()
	}
end

function CaptureActivityMainView:OnExit()
	manager.notify:RemoveListener(CAPTURE_GAME_OUTGAME_TASK_UPDATE, self.taskUpdateHandler)
end

function CaptureActivityMainView:Dispose()
	self.scrollHelper:Dispose()
	CaptureActivityMainView.super.Dispose(self)
end

return CaptureActivityMainView
