local SummerRaceStageNodeItemView = class("SummerRaceStageNodeItemView", ReduxView)

local function var_0_1(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0:Find(arg_1_1)

	if var_1_0 == nil then
		return nil
	end

	return var_1_0:GetComponent(arg_1_2)
end

local function var_0_2(arg_2_0)
	if arg_2_0 == nil then
		return "main"
	end

	local var_2_0 = tostring(arg_2_0.nodeVisualType or arg_2_0.nodeType or "")

	if var_2_0 == "side" or var_2_0 == "boss" or var_2_0 == "plot" then
		return var_2_0
	end

	return "main"
end

local function var_0_3(arg_3_0)
	if arg_3_0 == "side" then
		return "UI_SummerRace_StageItem_side_unlock"
	end

	if arg_3_0 == "boss" then
		return "UI_SummerRace_StageItem_boss_unlock"
	end

	if arg_3_0 == "plot" then
		return "UI_SummerRace_StageItem_plot_unlock"
	end

	return "UI_SummerRace_StageItem_unlock"
end

local function var_0_4(arg_4_0, arg_4_1)
	if arg_4_1 == "side" then
		return arg_4_0.sideAnimator_
	end

	if arg_4_1 == "boss" then
		return arg_4_0.bossAnimator_
	end

	if arg_4_1 == "plot" then
		return arg_4_0.plotAnimator_
	end

	return arg_4_0.mainAnimator_
end

local function var_0_5(arg_5_0, arg_5_1)
	if arg_5_0 ~= nil then
		arg_5_0.enabled = arg_5_1
	end
end

local var_0_6 = 0.05

function SummerRaceStageNodeItemView:OnCtor(arg_6_1)
	self.gameObject_ = arg_6_1
	self.transform_ = arg_6_1.transform

	self:Init()
end

function SummerRaceStageNodeItemView:Init()
	self:BindCfgUI()

	self.controllerEx_ = self.transform_:GetComponent("ControllerExCollection")
	self.typeController_ = self.controllerEx_:GetController("type")
	self.gouController_ = self.controllerEx_:GetController("gou")
	self.lockController_ = self.controllerEx_:GetController("lock")
	self.mainText_ = var_0_1(self.transform_, "root/main/text_shadow/text", typeof(Text))
	self.plotText_ = var_0_1(self.transform_, "root/plot/text_shadow/text", typeof(Text))
	self.sideText_ = var_0_1(self.transform_, "root/side/text_shadow/text", typeof(Text))
	self.bossText_ = var_0_1(self.transform_, "root/boss/text", typeof(Text))
	self.mainAnimator_ = var_0_1(self.transform_, "root/main", typeof(Animator))
	self.plotAnimator_ = var_0_1(self.transform_, "root/plot", typeof(Animator))
	self.sideAnimator_ = var_0_1(self.transform_, "root/side", typeof(Animator))
	self.bossAnimator_ = var_0_1(self.transform_, "root/boss", typeof(Animator))

	self:AddUIListener()
end

function SummerRaceStageNodeItemView:AddUIListener()
	self:AddBtnListener(self.clickBtn_, nil, function()
		if self.clickHandler_ then
			self.clickHandler_(self.index_, self.stageData_)
		end
	end)
end

function SummerRaceStageNodeItemView:SetData(arg_10_1, arg_10_2, arg_10_3)
	self.stageData_ = arg_10_1
	self.index_ = arg_10_2
	self.clickHandler_ = arg_10_3

	self:RefreshView()
end

function SummerRaceStageNodeItemView:RefreshView()
	if self.stageData_ == nil then
		SetActive(self.gameObject_, false)

		return
	end

	SetActive(self.gameObject_, true)

	local var_11_0 = tostring(self.stageData_.stageName or "")

	if self.mainText_ ~= nil then
		self.mainText_.text = var_11_0
	end

	if self.plotText_ ~= nil then
		self.plotText_.text = var_11_0
	end

	if self.sideText_ ~= nil then
		self.sideText_.text = var_11_0
	end

	if self.bossText_ ~= nil then
		self.bossText_.text = var_11_0
	end

	self.typeController_:SetSelectedState((var_0_2(self.stageData_)))
	self.gouController_:SetSelectedState(self.stageData_.isCompleted == true and "show" or "hide")
	self.lockController_:SetSelectedState(self.stageData_.isUnlocked == true and "hide" or "show")
end

function SummerRaceStageNodeItemView:SetUnlockLockVisible(arg_12_1)
	if self.lockController_ ~= nil then
		self.lockController_:SetSelectedState(arg_12_1 == true and "show" or "hide")
	end
end

function SummerRaceStageNodeItemView:StopUnlockAnimTimer()
	if self.unlockAnimTimer_ ~= nil then
		self.unlockAnimTimer_:Stop()

		self.unlockAnimTimer_ = nil
	end
end

function SummerRaceStageNodeItemView:PlayUnlockAnim()
	if self.stageData_ == nil or self.stageData_.isUnlocked ~= true then
		return false
	end

	self:StopUnlockAnimTimer()
	self:SetUnlockLockVisible(true)

	local var_14_0 = var_0_2(self.stageData_)
	local var_14_1 = var_0_3(var_14_0)
	local var_14_2 = var_0_4(self, var_14_0)

	if var_14_2 == nil then
		self:SetUnlockLockVisible(false)

		return false
	end

	var_14_2.enabled = true

	var_14_2:Play(var_14_1, 0, 0)
	var_14_2:Update(0)

	self.unlockAnimTimer_ = Timer.New(function()
		local var_15_0 = var_14_2:GetCurrentAnimatorStateInfo(0)

		if var_15_0 ~= nil and var_15_0:IsName(var_14_1) and var_15_0.normalizedTime >= 1 then
			self:StopUnlockAnimTimer()
			self:SetUnlockLockVisible(false)
		end
	end, var_0_6, -1)

	self.unlockAnimTimer_:Start()

	return true
end

function SummerRaceStageNodeItemView:StopUnlockAnim()
	self:StopUnlockAnimTimer()
	var_0_5(self.mainAnimator_, false)
	var_0_5(self.plotAnimator_, false)
	var_0_5(self.sideAnimator_, false)
	var_0_5(self.bossAnimator_, false)
end

function SummerRaceStageNodeItemView:Dispose()
	self:StopUnlockAnim()

	self.stageData_ = nil
	self.clickHandler_ = nil

	SummerRaceStageNodeItemView.super.Dispose(self)
end

return SummerRaceStageNodeItemView
