local AutoChessMedalItem = class("AutoChessMedalItem", BaseView)

function AutoChessMedalItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.id = arg_1_2

	self:Init()
end

function AutoChessMedalItem:Init()
	self:BindCfgUI()
	self:AddUIListeners()

	self.iconController1001_ = self.controller1001_:GetController("state")
	self.iconController1002_ = self.controller1002_:GetController("state")
	self.iconController1003_ = self.controller1003_:GetController("state")
	self.iconController1004_ = self.controller1004_:GetController("state")
end

function AutoChessMedalItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.OpenPageByJump("autoChessMedalInfoView", {
			id = self.id
		})
		OperationRecorder.RecordButtonTouch({
			source = 1,
			button_name = "activity_autochess_achie_touch",
			activity_id = AutoChessData:GetActivityID()
		})
	end)
end

function AutoChessMedalItem:SetData(arg_5_1, arg_5_2)
	self.id = arg_5_1

	local var_5_1, var_5_2 = AutoChessData:FindMedalInfo(arg_5_1)
	local var_5_3 = AutoChessData.IsMedalUnlockedFromInfo(var_5_2)

	SetActive(self.gameObject_, var_5_3)

	if arg_5_2 then
		self.anim_:Play("medalItem", 0, 0)
	end

	if var_5_3 then
		self["iconController" .. self.id .. "_"]:SetSelectedState(AutoChessData.IsMedalAdvancedFromInfo(var_5_2) and "03" or "01")
	end
end

function AutoChessMedalItem:SetOnClick(arg_6_1)
	self.onClick = arg_6_1
end

function AutoChessMedalItem:SetTips(arg_7_1)
	self.onTips = arg_7_1
end

return AutoChessMedalItem
