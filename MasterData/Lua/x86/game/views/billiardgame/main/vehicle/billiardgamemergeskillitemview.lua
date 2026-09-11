local BilliardGameMergeSkillItemView = class("BilliardGameMergeSkillItemView", ReduxView)

function BilliardGameMergeSkillItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function BilliardGameMergeSkillItemView:Init()
	self:InitUI()
end

function BilliardGameMergeSkillItemView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.formulaSkillBuffList_ = {}

	for iter_3_0 = 1, 3 do
		self.formulaSkillBuffList_[iter_3_0] = BilliardGameSmallSkillItemView.New(self["formulaItemGo_" .. iter_3_0])
	end

	self.typeController_ = self.transCon_:GetController("type")
	self.buffNumController_ = self.transCon_:GetController("buffNum")
	self.selectController_ = self.transCon_:GetController("select")
	self.recommendController_ = self.transCon_:GetController("recommend")
	self.newTagController_ = self.transCon_:GetController("newTag")
	self.trackController_ = self.transCon_:GetController("trackTag")
end

function BilliardGameMergeSkillItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickCallback_ then
			self:clickCallback_()
		end
	end)
end

function BilliardGameMergeSkillItemView:SetData(arg_6_1, arg_6_2)
	self.skill_ = arg_6_1
	self.index_ = arg_6_2

	self.newTagController_:SetSelectedState("hide")
	self.trackController_:SetSelectedState("hide")

	if self.skill_ and self.skill_.mainBuffId then
		self.isCombine_ = self.skill_.isCombine_
		self.cfg_ = MergeBallBuffCfg[self.skill_.mainBuffId]
		self.formulaBuffList_ = {}

		if self.isCombine_ then
			self.formulaBuffList_ = self.skill_.buffIdList
		else
			self.formulaBuffList_ = self.cfg_ and self.cfg_.formula

			self.newTagController_:SetSelectedState(self.cfg_.type ~= BilliardGameConst.MergeBallBuffType.EFFECT and not VehicleBallData:IsBuffUnlocked(self.skill_.mainBuffId) and "show" or "hide")
			self:RefreshTrackState()
		end

		self:RefreshFormula()
	else
		self.cfg_ = nil
		self.isCombine_ = false
		self.formulaBuffList_ = {}
	end

	self:RefreshType()
end

function BilliardGameMergeSkillItemView:RefreshFormula()
	self.buffNumController_:SetSelectedState(tostring(#self.formulaBuffList_))

	for iter_7_0 = 1, #self.formulaBuffList_ do
		self.formulaSkillBuffList_[iter_7_0]:SetBuffData(self.formulaBuffList_[iter_7_0])
	end
end

function BilliardGameMergeSkillItemView:RefreshType()
	local var_8_0 = self.cfg_ and self.cfg_.type

	if self.isCombine_ then
		self.typeController_:SetSelectedState("combine")

		self.tittleText_.text = GetTips("MERGE_BALL_MERGE_GROUP")
	elseif var_8_0 == BilliardGameConst.MergeBallBuffType.ADVANCE then
		self.typeController_:SetSelectedState("advanced")

		self.tittleText_.text = GetTips("MERGE_BALL_MERGE_ADVANCE")
	elseif var_8_0 == BilliardGameConst.MergeBallBuffType.ULTIMATE then
		self.typeController_:SetSelectedState("ultimate")

		self.tittleText_.text = GetTips("MERGE_BALL_MERGE_ULT")
	elseif var_8_0 == BilliardGameConst.MergeBallBuffType.EFFECT then
		self.typeController_:SetSelectedState("other")

		self.tittleText_.text = GetTips((self.cfg_ or nil) and (self.cfg_.name or "MERGE_BALL_MERGE_EFFECT"))
	else
		self.typeController_:SetSelectedState("other")

		self.tittleText_.text = GetTips("MERGE_BALL_MERGE_UPGRADE")
	end
end

function BilliardGameMergeSkillItemView:RefreshTrackState()
	if self.skill_ and self.skill_.mainBuffId and not self.isCombine_ then
		self.trackController_:SetSelectedState(BilliardGameTools.GetIsInTrackChain(self.skill_.mainBuffId) and "show" or "hide")
	end
end

function BilliardGameMergeSkillItemView:RegisterClickEvent(arg_10_1)
	self.clickCallback_ = arg_10_1
end

function BilliardGameMergeSkillItemView:SetSelected(arg_11_1)
	self.selectController_:SetSelectedState(tostring(arg_11_1))
end

function BilliardGameMergeSkillItemView:Dispose()
	for iter_12_0, iter_12_1 in ipairs(self.formulaSkillBuffList_) do
		iter_12_1:Dispose()
	end

	BilliardGameMergeSkillItemView.super.Dispose(self)
end

return BilliardGameMergeSkillItemView
