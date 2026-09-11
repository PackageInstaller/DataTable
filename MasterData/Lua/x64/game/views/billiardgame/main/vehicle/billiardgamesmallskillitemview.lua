local BilliardGameSmallSkillItemView = class("BilliardGameSmallSkillItemView", ReduxView)

function BilliardGameSmallSkillItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function BilliardGameSmallSkillItemView:Init()
	self:InitUI()
end

function BilliardGameSmallSkillItemView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.typeController_ = self.buffCon_:GetController("type")
	self.starController_ = self.buffCon_:GetController("star")
	self.emptyController_ = self.buffCon_:GetController("empty")
	self.selectController_ = self.buffCon_:GetController("select")
	self.getController_ = self.buffCon_:GetController("get")
	self.activeController_ = self.buffCon_:GetController("active")
	self.passiveController_ = self.buffCon_:GetController("passive")
	self.activeRareController_ = self.buffCon_:GetController("activeRare")
	self.newTagController_ = self.buffCon_:GetController("newTag")
	self.trackController_ = self.buffCon_:GetController("trackbg")
	self.iconStateController_ = self.buffCon_:GetController("iconState")
end

function BilliardGameSmallSkillItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickCallback_ then
			self:clickCallback_(self.buffId_)
		end
	end)
end

function BilliardGameSmallSkillItemView:SetSkillData(arg_6_1, arg_6_2)
	self.skill_ = arg_6_1
	self.isSelected_ = false
	self.buffId_ = arg_6_1.mainBuffId
	self.mainBuffCfg_ = MergeBallBuffCfg[self.buffId_]

	if self.buffId_ == nil then
		self:RefreshState(nil, false)
		self.starController_:SetSelectedState("hide")

		return
	end

	if arg_6_1.isCombine_ then
		if self.mainBuffCfg_ and MergeBallBuffCfg[arg_6_1.buffIdList[2]] then
			self.combinBuffIcon_1.sprite = pureGetSpriteWithoutAtlas(self.mainBuffCfg_.icon)
			self.combinBuffIcon_2.sprite = pureGetSpriteWithoutAtlas(MergeBallBuffCfg[arg_6_1.buffIdList[2]].icon)
		end
	else
		self:SetIcon(self.buffId_)
	end

	self:RefreshState(self.buffId_, arg_6_1.isCombine_)

	if arg_6_2 and arg_6_1 then
		self.starController_:SetSelectedIndex(arg_6_1.level + 1)
	else
		self.starController_:SetSelectedState("hide")
	end
end

function BilliardGameSmallSkillItemView:SetBuffData(arg_7_1, arg_7_2)
	self.isSelected_ = false
	self.buffId_ = arg_7_1
	self.mainBuffCfg_ = MergeBallBuffCfg[arg_7_1]

	self:SetIcon(arg_7_1)
	self:RefreshState(arg_7_1, false, arg_7_2)
end

function BilliardGameSmallSkillItemView:SetIcon(arg_8_1)
	if arg_8_1 and self.mainBuffCfg_ then
		if self.mainBuffCfg_.type == BilliardGameConst.MergeBallBuffType.PASSIVE then
			self.passiveIcon_.sprite = pureGetSpriteWithoutAtlas(self.mainBuffCfg_.icon)
		else
			self.activeIcon_.sprite = pureGetSpriteWithoutAtlas(self.mainBuffCfg_.icon)
		end
	end
end

function BilliardGameSmallSkillItemView:UpdateActiveRareState(arg_9_1, arg_9_2, arg_9_3)
	if arg_9_1 then
		self.activeRareController_:SetSelectedState("basic")
		self.iconStateController_:SetSelectedState("none")

		return
	end

	local var_9_0 = 0

	if arg_9_2 then
		self.iconStateController_:SetSelectedState(arg_9_3 and "two" or "none")

		for iter_9_0, iter_9_1 in ipairs(self.skill_.buffIdList) do
			var_9_0 = math.max(var_9_0, MergeBallBuffCfg[iter_9_1].type)
		end
	else
		self.iconStateController_:SetSelectedState(arg_9_3 and "one" or "none")

		var_9_0 = self.mainBuffCfg_.type
	end

	if var_9_0 == BilliardGameConst.MergeBallBuffType.BASIC then
		self.activeRareController_:SetSelectedState("basic")
	elseif var_9_0 == BilliardGameConst.MergeBallBuffType.ADVANCE then
		self.activeRareController_:SetSelectedState("advance")
	elseif var_9_0 == BilliardGameConst.MergeBallBuffType.ULTIMATE then
		self.activeRareController_:SetSelectedState("ultimate")
	else
		self.activeRareController_:SetSelectedState("basic")
	end
end

function BilliardGameSmallSkillItemView:RefreshState(arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_1 or not self.mainBuffCfg_ then
		self.activeController_:SetSelectedState("empty")
		self.passiveController_:SetSelectedState("empty")
		self.iconStateController_:SetSelectedState("none")

		return
	end

	local var_10_0 = self.mainBuffCfg_.type == BilliardGameConst.MergeBallBuffType.PASSIVE

	self.typeController_:SetSelectedState(self.mainBuffCfg_.type == BilliardGameConst.MergeBallBuffType.PASSIVE and "passive" or "active")

	local var_10_1 = VehicleBallData:IsBuffUnlocked(arg_10_1)

	if arg_10_3 then
		self.newTagController_:SetSelectedState(var_10_1 and "hide" or "show")
		self.activeController_:SetSelectedState(var_10_0 and "empty" or "open")
		self.passiveController_:SetSelectedState(var_10_0 and "open" or "empty")
		self:UpdateActiveRareState(var_10_0, false, true)
	else
		self.newTagController_:SetSelectedState("hide")

		if var_10_0 then
			self.activeController_:SetSelectedState("empty")
			self.passiveController_:SetSelectedState(var_10_1 and "open" or "notget")
			self:UpdateActiveRareState(true, false, var_10_1)
		else
			self.activeController_:SetSelectedState(arg_10_2 and "open" or var_10_1 and "open" or "notget")
			self.passiveController_:SetSelectedState("empty")
			self:UpdateActiveRareState(false, arg_10_2, var_10_1)
		end
	end
end

function BilliardGameSmallSkillItemView:ForceShowStar(arg_11_1)
	self.starController_:SetSelectedIndex(arg_11_1 + 1)
end

function BilliardGameSmallSkillItemView:ShowStarBreathAnim(arg_12_1, arg_12_2)
	if arg_12_2 then
		self["starAnim_" .. arg_12_1]:Play("BuffItem_star02")
	else
		self["starAnim_" .. arg_12_1]:Play("normal")
	end
end

function BilliardGameSmallSkillItemView:ShowStarLevelAnim(arg_13_1)
	self["starLevelAnim_" .. arg_13_1]:Play("BuffItem_star02")
end

function BilliardGameSmallSkillItemView:ShowBuffAnim(arg_14_1)
	if self.mainBuffCfg_.type == BilliardGameConst.MergeBallBuffType.PASSIVE then
		self.buffAnim_:Play(arg_14_1 and "buffItem_passive_On" or "buffItem_passive_Off", -1, 0)
	else
		self.buffAnim_:Play(arg_14_1 and "buffItem_active_On" or "buffItem_active_Off", -1, 0)
	end
end

function BilliardGameSmallSkillItemView:CheckTrackState(arg_15_1)
	self.trackController_:SetSelectedState(BilliardGameTools.GetIsInTrackChain(arg_15_1) and "show" or "hide")
end

function BilliardGameSmallSkillItemView:RegisterClick(arg_16_1)
	self.clickCallback_ = arg_16_1
end

function BilliardGameSmallSkillItemView:SetSelectedState(arg_17_1)
	self.isSelected_ = arg_17_1

	self.selectController_:SetSelectedState(self.isSelected_ and "show" or "hide")
end

function BilliardGameSmallSkillItemView:ShowBuffIsGet(arg_18_1)
	self.getController_:SetSelectedState(arg_18_1 and "show" or "hide")
end

function BilliardGameSmallSkillItemView:Dispose()
	BilliardGameSmallSkillItemView.super.Dispose(self)
end

return BilliardGameSmallSkillItemView
