local SoloChallengeAffixItem = class("SoloChallengeAffixItem", ReduxView)

function SoloChallengeAffixItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)
	self:Init()
end

function SoloChallengeAffixItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
	self.lockStateController_ = ControllerUtil.GetController(self.transform_, "lock")
	self.equipController_ = ControllerUtil.GetController(self.transform_, "equiped")
	self.addController_ = ControllerUtil.GetController(self.transform_, "add")
end

function SoloChallengeAffixItem:InitUI()
	self:BindCfgUI()
end

function SoloChallengeAffixItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.extra_ == false then
			JumpTools.OpenPageByJump("soloChallengeAffix", {
				activityID = self.activityID_,
				affixID = self.affixID_,
				pos = self.pos_,
				stageID = self.stageID_
			})

			return
		end

		self:SetSelect(true)
	end)

	if self.toggle_ ~= nil then
		self:AddToggleListener(self.toggle_, function(arg_6_0)
			if self.selectController_ ~= nil then
				if arg_6_0 then
					self.selectController_:SetSelectedState("on")
				else
					self.selectController_:SetSelectedState("off")
				end
			end
		end)
	end
end

function SoloChallengeAffixItem:SetData(arg_7_1, arg_7_2, arg_7_3)
	self.activityID_ = arg_7_1
	self.affixID_ = arg_7_2

	if arg_7_3 ~= nil then
		self.toggle_.group = arg_7_3
		self.extra_ = true
	else
		self.extra_ = false
	end
end

function SoloChallengeAffixItem:SetState(arg_8_1)
	self.stageID_ = arg_8_1.stageID
	self.pos_ = arg_8_1.pos

	self:RefreshUI()
end

function SoloChallengeAffixItem:RefreshUI()
	if self.extra_ then
		self:RefreshFightOrder()
	end

	self:RefreshLockState()
	self:RefreshAffixImage()
	self:RefreshEquipState()
end

function SoloChallengeAffixItem:RefreshFightOrder()
	if self.stageID_ ~= -1 then
		local var_10_0 = table.keyof(ActivitySoloChallengeCfg[self.activityID_].stage_id[SoloChallengeData:GetSelectedDifficultyIndex(self.activityID_)][2], self.stageID_)

		if var_10_0 ~= nil then
			self.orderText_.text = var_10_0
		end
	end
end

function SoloChallengeAffixItem:RefreshAffixImage()
	local var_11_0 = false

	if self.affixID_ ~= 0 then
		self.icon_.sprite = getAffixSprite(ActivityAffixPoolCfg[self.affixID_].affix)
		var_11_0 = true
	end

	if self.addController_ ~= nil then
		self.addController_:SetSelectedState(tostring(var_11_0))
	end
end

function SoloChallengeAffixItem:RefreshEquipState()
	if self.equipController_ ~= nil then
		if self.stageID_ ~= -1 then
			self.equipController_:SetSelectedState("on")
		else
			self.equipController_:SetSelectedState("off")
		end
	end
end

function SoloChallengeAffixItem:RefreshLockState()
	local var_13_0 = not not table.keyof(SoloChallengeData:GetCompletedStageList(self.activityID_)[SoloChallengeData:GetSelectedDifficultyIndex(self.activityID_)], self.stageID_)

	self.btn_.interactable = not var_13_0

	if self.extra_ and self.lockStateController_ ~= nil then
		if var_13_0 then
			self.lockStateController_:SetSelectedState("lock")
		else
			self.lockStateController_:SetSelectedState("unlock")
		end
	end
end

function SoloChallengeAffixItem:SetSelect(arg_14_1)
	if arg_14_1 == nil then
		return
	end

	if self.toggle_ then
		self.toggle_.isOn = arg_14_1
	end

	if arg_14_1 == true and self.selectCallBack_ then
		self.selectCallBack_(self.affixID_, self.pos_)
	end
end

function SoloChallengeAffixItem:RegistSelectCallBack(arg_15_1)
	self.selectCallBack_ = arg_15_1
end

function SoloChallengeAffixItem:Dispose()
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
	self.selectCallBack_ = nil
	self.selectController_ = nil
	self.lockStateController_ = nil
	self.equipController_ = nil

	SoloChallengeAffixItem.super.Dispose(self)
end

return SoloChallengeAffixItem
