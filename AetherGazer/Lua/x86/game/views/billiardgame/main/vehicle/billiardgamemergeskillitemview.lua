local var_0_0 = class("BilliardGameMergeSkillItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.formulaSkillBuffList_ = {}

	for iter_3_0 = 1, 3 do
		arg_3_0.formulaSkillBuffList_[iter_3_0] = BilliardGameSmallSkillItemView.New(arg_3_0["formulaItemGo_" .. iter_3_0])
	end

	arg_3_0.typeController_ = arg_3_0.transCon_:GetController("type")
	arg_3_0.buffNumController_ = arg_3_0.transCon_:GetController("buffNum")
	arg_3_0.selectController_ = arg_3_0.transCon_:GetController("select")
	arg_3_0.recommendController_ = arg_3_0.transCon_:GetController("recommend")
	arg_3_0.newTagController_ = arg_3_0.transCon_:GetController("newTag")
	arg_3_0.trackController_ = arg_3_0.transCon_:GetController("trackTag")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickCallback_ then
			arg_4_0.clickCallback_(arg_4_0)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.skill_ = arg_6_1
	arg_6_0.index_ = arg_6_2

	arg_6_0.newTagController_:SetSelectedState("hide")
	arg_6_0.trackController_:SetSelectedState("hide")

	if arg_6_0.skill_ and arg_6_0.skill_.mainBuffId then
		arg_6_0.isCombine_ = arg_6_0.skill_.isCombine_
		arg_6_0.cfg_ = MergeBallBuffCfg[arg_6_0.skill_.mainBuffId]
		arg_6_0.formulaBuffList_ = {}

		if arg_6_0.isCombine_ then
			arg_6_0.formulaBuffList_ = arg_6_0.skill_.buffIdList
		else
			arg_6_0.formulaBuffList_ = arg_6_0.cfg_ and arg_6_0.cfg_.formula

			local var_6_0 = arg_6_0.cfg_.type ~= BilliardGameConst.MergeBallBuffType.EFFECT and not VehicleBallData:IsBuffUnlocked(arg_6_0.skill_.mainBuffId)

			arg_6_0.newTagController_:SetSelectedState(var_6_0 and "show" or "hide")
			arg_6_0:RefreshTrackState()
		end

		arg_6_0:RefreshFormula()
	else
		arg_6_0.cfg_ = nil
		arg_6_0.isCombine_ = false
		arg_6_0.formulaBuffList_ = {}
	end

	arg_6_0:RefreshType()
end

function var_0_0.RefreshFormula(arg_7_0)
	local var_7_0 = #arg_7_0.formulaBuffList_

	arg_7_0.buffNumController_:SetSelectedState(tostring(var_7_0))

	for iter_7_0 = 1, var_7_0 do
		local var_7_1 = arg_7_0.formulaBuffList_[iter_7_0]

		arg_7_0.formulaSkillBuffList_[iter_7_0]:SetBuffData(var_7_1)
	end
end

function var_0_0.RefreshType(arg_8_0)
	local var_8_0 = arg_8_0.cfg_ and arg_8_0.cfg_.type

	if arg_8_0.isCombine_ then
		arg_8_0.typeController_:SetSelectedState("combine")

		arg_8_0.tittleText_.text = GetTips("MERGE_BALL_MERGE_GROUP")
	elseif var_8_0 == BilliardGameConst.MergeBallBuffType.ADVANCE then
		arg_8_0.typeController_:SetSelectedState("advanced")

		arg_8_0.tittleText_.text = GetTips("MERGE_BALL_MERGE_ADVANCE")
	elseif var_8_0 == BilliardGameConst.MergeBallBuffType.ULTIMATE then
		arg_8_0.typeController_:SetSelectedState("ultimate")

		arg_8_0.tittleText_.text = GetTips("MERGE_BALL_MERGE_ULT")
	elseif var_8_0 == BilliardGameConst.MergeBallBuffType.EFFECT then
		arg_8_0.typeController_:SetSelectedState("other")

		arg_8_0.tittleText_.text = GetTips(arg_8_0.cfg_ and arg_8_0.cfg_.name or "MERGE_BALL_MERGE_EFFECT")
	else
		arg_8_0.typeController_:SetSelectedState("other")

		arg_8_0.tittleText_.text = GetTips("MERGE_BALL_MERGE_UPGRADE")
	end
end

function var_0_0.RefreshTrackState(arg_9_0)
	if arg_9_0.skill_ and arg_9_0.skill_.mainBuffId and not arg_9_0.isCombine_ then
		local var_9_0 = BilliardGameTools.GetIsInTrackChain(arg_9_0.skill_.mainBuffId)

		arg_9_0.trackController_:SetSelectedState(var_9_0 and "show" or "hide")
	end
end

function var_0_0.RegisterClickEvent(arg_10_0, arg_10_1)
	arg_10_0.clickCallback_ = arg_10_1
end

function var_0_0.SetSelected(arg_11_0, arg_11_1)
	arg_11_0.selectController_:SetSelectedState(tostring(arg_11_1))
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.formulaSkillBuffList_) do
		iter_12_1:Dispose()
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
