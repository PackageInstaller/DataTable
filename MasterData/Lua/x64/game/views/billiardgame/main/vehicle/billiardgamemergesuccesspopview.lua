local BilliardGameMergeSuccessPopView = class("BilliardGameMergeSuccessPopView", ReduxView)

function BilliardGameMergeSuccessPopView:UIName()
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_BallxPit/Activity_WuLuo_BallxPit_BuffResultPopUI"
end

function BilliardGameMergeSuccessPopView:UIParent()
	return manager.ui.uiPop.transform
end

function BilliardGameMergeSuccessPopView:Init()
	self:OnInit()
	self:AddUIListener()
end

function BilliardGameMergeSuccessPopView:OnInit()
	self:BindCfgUI()

	self.typeController_ = self.transCon_:GetController("type")
	self.mergeAnimController_ = self.transCon_:GetController("mergeAnim")
	self.formulaNumController_ = self.transCon_:GetController("formulaNum")
	self.mainBuffItem_ = BilliardGameSmallSkillItemView.New(self.buffItemGo_)
	self.conbineTagTextList_ = {}
	self.conbineSkillItemList_ = {}

	for iter_4_0 = 1, 2 do
		self.conbineTagTextList_[iter_4_0] = self["combineTagText_" .. iter_4_0]
		self.conbineSkillItemList_[iter_4_0] = {}

		ComponentBinder.GetInstance():BindCfgUI(self.conbineSkillItemList_[iter_4_0], self["combineSkillGo_" .. iter_4_0])

		self.conbineSkillItemList_[iter_4_0].buffItem = BilliardGameSmallSkillItemView.New(self.conbineSkillItemList_[iter_4_0].buffItemGo_)
	end

	self.animFormulaItemList_ = {}

	for iter_4_1 = 1, 3 do
		self.animFormulaItemList_[iter_4_1] = BilliardGameSmallSkillItemView.New(self["animFormulaItemGo_" .. iter_4_1])
	end

	self.animResultItem_ = BilliardGameSmallSkillItemView.New(self.animResultItemGo_)
end

function BilliardGameMergeSuccessPopView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
		manager.notify:Invoke(BilliardGameEvent.MAIN_POP_END)
		manager.notify:Invoke(BilliardGameEvent.SET_MERGE_AND_BALL_ACTIVE, true)
	end)
end

function BilliardGameMergeSuccessPopView:OnEnter()
	self.skill_ = self.params_.skill

	self:RefreshEnterAnimShow()

	if self.skill_.mainBuffId ~= nil then
		if self.skill_.isCombine_ then
			self:RefreshCombineSkill(self.skill_)
		else
			self:RefreshSkill(self.skill_)
		end
	end
end

function BilliardGameMergeSuccessPopView:RefreshEnterAnimShow()
	if self.skill_.isCombine_ then
		self.animFormulaItemList_[1]:SetBuffData(self.skill_.buffIdList[1])
		self.animFormulaItemList_[3]:SetBuffData(self.skill_.buffIdList[2])
		self.formulaNumController_:SetSelectedState("2")
		self.mergeAnimController_:SetSelectedState("combine")
	else
		local var_8_0 = MergeBallBuffCfg[self.skill_.mainBuffId]

		self.formulaNumController_:SetSelectedState(#MergeBallBuffCfg[self.skill_.mainBuffId].formula)

		if #var_8_0.formula == 2 then
			self.animFormulaItemList_[1]:SetBuffData(var_8_0.formula[1])
			self.animFormulaItemList_[3]:SetBuffData(var_8_0.formula[2])
		elseif #var_8_0.formula == 3 then
			self.animFormulaItemList_[1]:SetBuffData(var_8_0.formula[1])
			self.animFormulaItemList_[2]:SetBuffData(var_8_0.formula[2])
			self.animFormulaItemList_[3]:SetBuffData(var_8_0.formula[3])
		end

		if var_8_0.type == BilliardGameConst.MergeBallBuffType.ADVANCE then
			self.mergeAnimController_:SetSelectedState("advanced")
		elseif var_8_0.type == BilliardGameConst.MergeBallBuffType.ULTIMATE then
			self.mergeAnimController_:SetSelectedState("ultimate")
		else
			self.mergeAnimController_:SetSelectedState("combine")
		end
	end

	self.animResultItem_:SetSkillData(self.skill_)
end

function BilliardGameMergeSuccessPopView:RefreshCombineSkill(arg_9_1)
	self.combineScroll_.verticalNormalizedPosition = 1

	self.typeController_:SetSelectedIndex(0)
	self.mainBuffItem_:SetSkillData(arg_9_1)

	local var_9_0 = {}

	for iter_9_0 = 1, #arg_9_1.buffIdList do
		if self.conbineTagTextList_[iter_9_0] then
			self.conbineTagTextList_[iter_9_0].text = GetTips("MERGE_BALL_TAG_" .. MergeBallBuffCfg[arg_9_1.buffIdList[iter_9_0]].tag[1])
		end

		if self.conbineSkillItemList_[iter_9_0] then
			self.conbineSkillItemList_[iter_9_0].buffItem:SetBuffData(arg_9_1.buffIdList[iter_9_0])

			self.conbineSkillItemList_[iter_9_0].nameText_.text = MergeBallBuffCfg[arg_9_1.buffIdList[iter_9_0]].name
			self.conbineSkillItemList_[iter_9_0].descText_.text = string.format(MergeBallBuffCfg[arg_9_1.buffIdList[iter_9_0]].desc, unpack(MergeBallBuffCfg[arg_9_1.buffIdList[iter_9_0]].param_level[arg_9_1.level]))
		end

		table.insert(var_9_0, MergeBallBuffCfg[arg_9_1.buffIdList[iter_9_0]])
	end

	if #var_9_0 == 1 then
		self.nameText_.text = var_9_0[1].name
		self.combineDesc_.text = ""
	elseif #var_9_0 == 2 then
		self.nameText_.text = string.format("%s X %s", var_9_0[1].name, var_9_0[2].name)
		self.combineDesc_.text = (var_9_0[1].merge_weight == var_9_0[2].merge_weight or var_9_0[1].merge_weight == 0 or var_9_0[2].merge_weight == 0) and GetTips("MERGE_BALL_COMBINE_TIP_BLANK") or string.format(GetTips("MERGE_BALL_COMBINE_TIP"), var_9_0[1].combine_text1, var_9_0[2].combine_text2)
	end
end

function BilliardGameMergeSuccessPopView:RefreshSkill(arg_10_1)
	local var_10_0 = MergeBallBuffCfg[arg_10_1.mainBuffId]

	if MergeBallBuffCfg[arg_10_1.mainBuffId].type == BilliardGameConst.MergeBallBuffType.ADVANCE then
		self.typeController_:SetSelectedState("advanced")
	elseif var_10_0.type == BilliardGameConst.MergeBallBuffType.ULTIMATE then
		self.typeController_:SetSelectedState("ultimate")
	else
		self.typeController_:SetSelectedState("combine")
	end

	self.mainBuffItem_:SetBuffData(arg_10_1.mainBuffId)

	self.nameText_.text = var_10_0.name
	self.tagText_.text = GetTips("MERGE_BALL_TAG_" .. var_10_0.tag[1])
	self.descText_.text = string.format(var_10_0.desc, unpack(var_10_0.param_level[1]))
end

function BilliardGameMergeSuccessPopView:OnTop()
	manager.windowBar:SwitchBar({})
end

function BilliardGameMergeSuccessPopView:OnExit()
	return
end

function BilliardGameMergeSuccessPopView:Dispose()
	self.mainBuffItem_:Dispose()

	for iter_13_0 = 1, #self.conbineSkillItemList_ do
		self.conbineSkillItemList_[iter_13_0].buffItem:Dispose()
	end

	self.conbineSkillItemList_ = {}

	for iter_13_1 = 1, 3 do
		self.animFormulaItemList_[iter_13_1]:Dispose()
	end

	self.animFormulaItemList_ = {}

	self.animResultItem_:Dispose()
	BilliardGameMergeSuccessPopView.super.Dispose(self)
end

return BilliardGameMergeSuccessPopView
