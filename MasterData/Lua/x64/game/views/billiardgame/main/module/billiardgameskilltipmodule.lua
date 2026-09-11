local BilliardGameSkillTipModule = class("BilliardGameSkillTipModule", ReduxView)

function BilliardGameSkillTipModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function BilliardGameSkillTipModule:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.typeController_ = self.tipsCon_:GetController("type")
	self.combineController_ = self.tipsCon_:GetController("combine")
	self.buffItem1 = BilliardGameBigBuffItemView.New(self.skill_1)
	self.buffItem2 = BilliardGameBigBuffItemView.New(self.skill_2)
end

function BilliardGameSkillTipModule:AddUIListener()
	return
end

function BilliardGameSkillTipModule:SetData(arg_4_1)
	self.isCombine_ = arg_4_1.isCombine_
	self.mainSkillId = arg_4_1.mainBuffId

	self.combineController_:SetSelectedState(self.isCombine_ and "show" or "hide")

	if self.isCombine_ then
		local var_4_0 = arg_4_1.buffIdList[2]

		self.typeController_:SetSelectedState("ActiveBuff")

		local var_4_1 = MergeBallBuffCfg[self.mainSkillId]
		local var_4_2 = MergeBallBuffCfg[var_4_0]

		self.buffNameText_.text = string.format("%s X %s", MergeBallBuffCfg[self.mainSkillId].name, MergeBallBuffCfg[var_4_0].name)
		self.combinationText_.text = (var_4_1.merge_weight == var_4_2.merge_weight or var_4_1.merge_weight == 0 or var_4_2.merge_weight == 0) and GetTips("MERGE_BALL_COMBINE_TIP_BLANK") or string.format(GetTips("MERGE_BALL_COMBINE_TIP"), var_4_1.combine_text1, var_4_2.combine_text2)
		self.labelText_1.text = GetTips("MERGE_BALL_TAG_" .. var_4_1.tag[1])
		self.labelText_2.text = GetTips("MERGE_BALL_TAG_" .. var_4_2.tag[1])

		self.buffItem1:IsShowName(true)
		self.buffItem2:IsShowName(true)
		self.buffItem1:SetData(self.mainSkillId, arg_4_1.level, true)
		self.buffItem2:SetData(var_4_0, arg_4_1.level, true)
	else
		self:SetOneBuffData(self.mainSkillId, arg_4_1.level)
	end
end

function BilliardGameSkillTipModule:SetOneBuffData(arg_5_1, arg_5_2)
	self.mainSkillId = arg_5_1

	local var_5_0 = MergeBallBuffCfg[self.mainSkillId]

	self.typeController_:SetSelectedState(MergeBallBuffCfg[self.mainSkillId].type == BilliardGameConst.MergeBallBuffType.PASSIVE and "PassiveBuff" or "ActiveBuff")

	local var_5_1 = VehicleBallData:IsBuffUnlocked(arg_5_1)

	if var_5_1 then
		self.buffNameText_.text = var_5_0.name or "???"
	end

	self.labelText_1.text = var_5_1 and GetTips("MERGE_BALL_TAG_" .. var_5_0.tag[1]) or "???"

	self.buffItem1:IsShowName(false)
	self.buffItem1:SetData(self.mainSkillId, arg_5_2)
end

function BilliardGameSkillTipModule:Dispose()
	self.buffItem1:Dispose()
	self.buffItem2:Dispose()
	BilliardGameSkillTipModule.super.Dispose(self)
end

return BilliardGameSkillTipModule
