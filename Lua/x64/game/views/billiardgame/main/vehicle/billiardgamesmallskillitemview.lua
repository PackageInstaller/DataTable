local var_0_0 = class("BilliardGameSmallSkillItemView", ReduxView)

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

	arg_3_0.typeController_ = arg_3_0.buffCon_:GetController("type")
	arg_3_0.starController_ = arg_3_0.buffCon_:GetController("star")
	arg_3_0.emptyController_ = arg_3_0.buffCon_:GetController("empty")
	arg_3_0.selectController_ = arg_3_0.buffCon_:GetController("select")
	arg_3_0.getController_ = arg_3_0.buffCon_:GetController("get")
	arg_3_0.activeController_ = arg_3_0.buffCon_:GetController("active")
	arg_3_0.passiveController_ = arg_3_0.buffCon_:GetController("passive")
	arg_3_0.activeRareController_ = arg_3_0.buffCon_:GetController("activeRare")
	arg_3_0.newTagController_ = arg_3_0.buffCon_:GetController("newTag")
	arg_3_0.trackController_ = arg_3_0.buffCon_:GetController("trackbg")
	arg_3_0.iconStateController_ = arg_3_0.buffCon_:GetController("iconState")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickCallback_ then
			arg_4_0.clickCallback_(arg_4_0, arg_4_0.buffId_)
		end
	end)
end

function var_0_0.SetSkillData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.skill_ = arg_6_1
	arg_6_0.isSelected_ = false
	arg_6_0.buffId_ = arg_6_1.mainBuffId
	arg_6_0.mainBuffCfg_ = MergeBallBuffCfg[arg_6_0.buffId_]

	if arg_6_0.buffId_ == nil then
		arg_6_0:RefreshState(nil, false)
		arg_6_0.starController_:SetSelectedState("hide")

		return
	end

	if arg_6_1.isCombine_ then
		local var_6_0 = MergeBallBuffCfg[arg_6_1.buffIdList[2]]

		if arg_6_0.mainBuffCfg_ and var_6_0 then
			arg_6_0.combinBuffIcon_1.sprite = pureGetSpriteWithoutAtlas(arg_6_0.mainBuffCfg_.icon)
			arg_6_0.combinBuffIcon_2.sprite = pureGetSpriteWithoutAtlas(var_6_0.icon)
		end
	else
		arg_6_0:SetIcon(arg_6_0.buffId_)
	end

	arg_6_0:RefreshState(arg_6_0.buffId_, arg_6_1.isCombine_)

	if arg_6_2 and arg_6_1 then
		arg_6_0.starController_:SetSelectedIndex(arg_6_1.level + 1)
	else
		arg_6_0.starController_:SetSelectedState("hide")
	end
end

function var_0_0.SetBuffData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.isSelected_ = false
	arg_7_0.buffId_ = arg_7_1
	arg_7_0.mainBuffCfg_ = MergeBallBuffCfg[arg_7_1]

	arg_7_0:SetIcon(arg_7_1)
	arg_7_0:RefreshState(arg_7_1, false, arg_7_2)
end

function var_0_0.SetIcon(arg_8_0, arg_8_1)
	if arg_8_1 and arg_8_0.mainBuffCfg_ then
		if arg_8_0.mainBuffCfg_.type == BilliardGameConst.MergeBallBuffType.PASSIVE then
			arg_8_0.passiveIcon_.sprite = pureGetSpriteWithoutAtlas(arg_8_0.mainBuffCfg_.icon)
		else
			arg_8_0.activeIcon_.sprite = pureGetSpriteWithoutAtlas(arg_8_0.mainBuffCfg_.icon)
		end
	end
end

function var_0_0.UpdateActiveRareState(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_1 then
		arg_9_0.activeRareController_:SetSelectedState("basic")
		arg_9_0.iconStateController_:SetSelectedState("none")

		return
	end

	local var_9_0 = 0

	if arg_9_2 then
		arg_9_0.iconStateController_:SetSelectedState(arg_9_3 and "two" or "none")

		for iter_9_0, iter_9_1 in ipairs(arg_9_0.skill_.buffIdList) do
			var_9_0 = math.max(var_9_0, MergeBallBuffCfg[iter_9_1].type)
		end
	else
		arg_9_0.iconStateController_:SetSelectedState(arg_9_3 and "one" or "none")

		var_9_0 = arg_9_0.mainBuffCfg_.type
	end

	if var_9_0 == BilliardGameConst.MergeBallBuffType.BASIC then
		arg_9_0.activeRareController_:SetSelectedState("basic")
	elseif var_9_0 == BilliardGameConst.MergeBallBuffType.ADVANCE then
		arg_9_0.activeRareController_:SetSelectedState("advance")
	elseif var_9_0 == BilliardGameConst.MergeBallBuffType.ULTIMATE then
		arg_9_0.activeRareController_:SetSelectedState("ultimate")
	else
		arg_9_0.activeRareController_:SetSelectedState("basic")
	end
end

function var_0_0.RefreshState(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_1 or not arg_10_0.mainBuffCfg_ then
		arg_10_0.activeController_:SetSelectedState("empty")
		arg_10_0.passiveController_:SetSelectedState("empty")
		arg_10_0.iconStateController_:SetSelectedState("none")

		return
	end

	local var_10_0 = arg_10_0.mainBuffCfg_.type == BilliardGameConst.MergeBallBuffType.PASSIVE

	arg_10_0.typeController_:SetSelectedState(var_10_0 and "passive" or "active")

	local var_10_1 = VehicleBallData:IsBuffUnlocked(arg_10_1)

	if arg_10_3 then
		arg_10_0.newTagController_:SetSelectedState(var_10_1 and "hide" or "show")
		arg_10_0.activeController_:SetSelectedState(var_10_0 and "empty" or "open")
		arg_10_0.passiveController_:SetSelectedState(var_10_0 and "open" or "empty")
		arg_10_0:UpdateActiveRareState(var_10_0, false, true)
	else
		arg_10_0.newTagController_:SetSelectedState("hide")

		if var_10_0 then
			arg_10_0.activeController_:SetSelectedState("empty")
			arg_10_0.passiveController_:SetSelectedState(var_10_1 and "open" or "notget")
			arg_10_0:UpdateActiveRareState(true, false, var_10_1)
		else
			arg_10_0.activeController_:SetSelectedState(arg_10_2 and "open" or var_10_1 and "open" or "notget")
			arg_10_0.passiveController_:SetSelectedState("empty")
			arg_10_0:UpdateActiveRareState(false, arg_10_2, var_10_1)
		end
	end
end

function var_0_0.ForceShowStar(arg_11_0, arg_11_1)
	arg_11_0.starController_:SetSelectedIndex(arg_11_1 + 1)
end

function var_0_0.ShowStarBreathAnim(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2 then
		arg_12_0["starAnim_" .. arg_12_1]:Play("BuffItem_star02")
	else
		arg_12_0["starAnim_" .. arg_12_1]:Play("normal")
	end
end

function var_0_0.ShowStarLevelAnim(arg_13_0, arg_13_1)
	arg_13_0["starLevelAnim_" .. arg_13_1]:Play("BuffItem_star02")
end

function var_0_0.ShowBuffAnim(arg_14_0, arg_14_1)
	if arg_14_0.mainBuffCfg_.type == BilliardGameConst.MergeBallBuffType.PASSIVE then
		arg_14_0.buffAnim_:Play(arg_14_1 and "buffItem_passive_On" or "buffItem_passive_Off", -1, 0)
	else
		arg_14_0.buffAnim_:Play(arg_14_1 and "buffItem_active_On" or "buffItem_active_Off", -1, 0)
	end
end

function var_0_0.CheckTrackState(arg_15_0, arg_15_1)
	local var_15_0 = BilliardGameTools.GetIsInTrackChain(arg_15_1)

	arg_15_0.trackController_:SetSelectedState(var_15_0 and "show" or "hide")
end

function var_0_0.RegisterClick(arg_16_0, arg_16_1)
	arg_16_0.clickCallback_ = arg_16_1
end

function var_0_0.SetSelectedState(arg_17_0, arg_17_1)
	arg_17_0.isSelected_ = arg_17_1

	arg_17_0.selectController_:SetSelectedState(arg_17_0.isSelected_ and "show" or "hide")
end

function var_0_0.ShowBuffIsGet(arg_18_0, arg_18_1)
	arg_18_0.getController_:SetSelectedState(arg_18_1 and "show" or "hide")
end

function var_0_0.Dispose(arg_19_0)
	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
