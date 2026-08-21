local var_0_0 = class("BilliardGameMergeSuccessPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_BallxPit/Activity_WuLuo_BallxPit_BuffResultPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:OnInit()
	arg_3_0:AddUIListener()
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.typeController_ = arg_4_0.transCon_:GetController("type")
	arg_4_0.mergeAnimController_ = arg_4_0.transCon_:GetController("mergeAnim")
	arg_4_0.formulaNumController_ = arg_4_0.transCon_:GetController("formulaNum")
	arg_4_0.mainBuffItem_ = BilliardGameSmallSkillItemView.New(arg_4_0.buffItemGo_)
	arg_4_0.conbineTagTextList_ = {}
	arg_4_0.conbineSkillItemList_ = {}

	for iter_4_0 = 1, 2 do
		arg_4_0.conbineTagTextList_[iter_4_0] = arg_4_0["combineTagText_" .. iter_4_0]
		arg_4_0.conbineSkillItemList_[iter_4_0] = {}

		ComponentBinder.GetInstance():BindCfgUI(arg_4_0.conbineSkillItemList_[iter_4_0], arg_4_0["combineSkillGo_" .. iter_4_0])

		arg_4_0.conbineSkillItemList_[iter_4_0].buffItem = BilliardGameSmallSkillItemView.New(arg_4_0.conbineSkillItemList_[iter_4_0].buffItemGo_)
	end

	arg_4_0.animFormulaItemList_ = {}

	for iter_4_1 = 1, 3 do
		arg_4_0.animFormulaItemList_[iter_4_1] = BilliardGameSmallSkillItemView.New(arg_4_0["animFormulaItemGo_" .. iter_4_1])
	end

	arg_4_0.animResultItem_ = BilliardGameSmallSkillItemView.New(arg_4_0.animResultItemGo_)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()
		manager.notify:Invoke(BilliardGameEvent.MAIN_POP_END)
		manager.notify:Invoke(BilliardGameEvent.SET_MERGE_AND_BALL_ACTIVE, true)
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.skill_ = arg_7_0.params_.skill

	arg_7_0:RefreshEnterAnimShow()

	if arg_7_0.skill_.mainBuffId ~= nil then
		if arg_7_0.skill_.isCombine_ then
			arg_7_0:RefreshCombineSkill(arg_7_0.skill_)
		else
			arg_7_0:RefreshSkill(arg_7_0.skill_)
		end
	end
end

function var_0_0.RefreshEnterAnimShow(arg_8_0)
	if arg_8_0.skill_.isCombine_ then
		arg_8_0.animFormulaItemList_[1]:SetBuffData(arg_8_0.skill_.buffIdList[1])
		arg_8_0.animFormulaItemList_[3]:SetBuffData(arg_8_0.skill_.buffIdList[2])
		arg_8_0.formulaNumController_:SetSelectedState("2")
		arg_8_0.mergeAnimController_:SetSelectedState("combine")
	else
		local var_8_0 = MergeBallBuffCfg[arg_8_0.skill_.mainBuffId]

		arg_8_0.formulaNumController_:SetSelectedState(#var_8_0.formula)

		if #var_8_0.formula == 2 then
			arg_8_0.animFormulaItemList_[1]:SetBuffData(var_8_0.formula[1])
			arg_8_0.animFormulaItemList_[3]:SetBuffData(var_8_0.formula[2])
		elseif #var_8_0.formula == 3 then
			arg_8_0.animFormulaItemList_[1]:SetBuffData(var_8_0.formula[1])
			arg_8_0.animFormulaItemList_[2]:SetBuffData(var_8_0.formula[2])
			arg_8_0.animFormulaItemList_[3]:SetBuffData(var_8_0.formula[3])
		end

		if var_8_0.type == BilliardGameConst.MergeBallBuffType.ADVANCE then
			arg_8_0.mergeAnimController_:SetSelectedState("advanced")
		elseif var_8_0.type == BilliardGameConst.MergeBallBuffType.ULTIMATE then
			arg_8_0.mergeAnimController_:SetSelectedState("ultimate")
		else
			arg_8_0.mergeAnimController_:SetSelectedState("combine")
		end
	end

	arg_8_0.animResultItem_:SetSkillData(arg_8_0.skill_)
end

function var_0_0.RefreshCombineSkill(arg_9_0, arg_9_1)
	arg_9_0.combineScroll_.verticalNormalizedPosition = 1

	arg_9_0.typeController_:SetSelectedIndex(0)
	arg_9_0.mainBuffItem_:SetSkillData(arg_9_1)

	local var_9_0 = {}

	for iter_9_0 = 1, #arg_9_1.buffIdList do
		local var_9_1 = MergeBallBuffCfg[arg_9_1.buffIdList[iter_9_0]]

		if arg_9_0.conbineTagTextList_[iter_9_0] then
			arg_9_0.conbineTagTextList_[iter_9_0].text = GetTips("MERGE_BALL_TAG_" .. var_9_1.tag[1])
		end

		if arg_9_0.conbineSkillItemList_[iter_9_0] then
			arg_9_0.conbineSkillItemList_[iter_9_0].buffItem:SetBuffData(arg_9_1.buffIdList[iter_9_0])

			arg_9_0.conbineSkillItemList_[iter_9_0].nameText_.text = var_9_1.name
			arg_9_0.conbineSkillItemList_[iter_9_0].descText_.text = string.format(var_9_1.desc, unpack(var_9_1.param_level[arg_9_1.level]))
		end

		table.insert(var_9_0, var_9_1)
	end

	if #var_9_0 == 1 then
		arg_9_0.nameText_.text = var_9_0[1].name
		arg_9_0.combineDesc_.text = ""
	elseif #var_9_0 == 2 then
		arg_9_0.nameText_.text = string.format("%s X %s", var_9_0[1].name, var_9_0[2].name)

		if var_9_0[1].merge_weight == var_9_0[2].merge_weight or var_9_0[1].merge_weight == 0 or var_9_0[2].merge_weight == 0 then
			arg_9_0.combineDesc_.text = GetTips("MERGE_BALL_COMBINE_TIP_BLANK")
		else
			arg_9_0.combineDesc_.text = string.format(GetTips("MERGE_BALL_COMBINE_TIP"), var_9_0[1].combine_text1, var_9_0[2].combine_text2)
		end
	end
end

function var_0_0.RefreshSkill(arg_10_0, arg_10_1)
	local var_10_0 = MergeBallBuffCfg[arg_10_1.mainBuffId]

	if var_10_0.type == BilliardGameConst.MergeBallBuffType.ADVANCE then
		arg_10_0.typeController_:SetSelectedState("advanced")
	elseif var_10_0.type == BilliardGameConst.MergeBallBuffType.ULTIMATE then
		arg_10_0.typeController_:SetSelectedState("ultimate")
	else
		arg_10_0.typeController_:SetSelectedState("combine")
	end

	arg_10_0.mainBuffItem_:SetBuffData(arg_10_1.mainBuffId)

	arg_10_0.nameText_.text = var_10_0.name
	arg_10_0.tagText_.text = GetTips("MERGE_BALL_TAG_" .. var_10_0.tag[1])
	arg_10_0.descText_.text = string.format(var_10_0.desc, unpack(var_10_0.param_level[1]))
end

function var_0_0.OnTop(arg_11_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnExit(arg_12_0)
	return
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.mainBuffItem_:Dispose()

	for iter_13_0 = 1, #arg_13_0.conbineSkillItemList_ do
		arg_13_0.conbineSkillItemList_[iter_13_0].buffItem:Dispose()
	end

	arg_13_0.conbineSkillItemList_ = {}

	for iter_13_1 = 1, 3 do
		arg_13_0.animFormulaItemList_[iter_13_1]:Dispose()
	end

	arg_13_0.animFormulaItemList_ = {}

	arg_13_0.animResultItem_:Dispose()
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
