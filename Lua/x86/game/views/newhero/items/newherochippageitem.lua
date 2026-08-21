local var_0_0 = class("NewHeroChipPageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.chipID_ = arg_2_1
	arg_2_0.heroID_ = arg_2_2
	arg_2_0.type_ = arg_2_3

	arg_2_0:RefreshUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.controller_ = arg_3_0.itemCon_:GetController("ishavechip")
	arg_3_0.iconController_ = arg_3_0.itemCon_:GetController("icon")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		arg_4_0:Go("/newHeroChipView", {
			heroID = arg_4_0.heroID_,
			type = arg_4_0.type_,
			chipID = arg_4_0.chipID_
		})
	end)
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0.iconController_:SetSelectedState(arg_6_0.type_)

	arg_6_0.typeText_.text = GetTips("CHIP_HERO_TYPE_" .. arg_6_0.type_)

	if arg_6_0.chipID_ and arg_6_0.chipID_ > 0 then
		arg_6_0.scrollRect_.verticalNormalizedPosition = 1

		arg_6_0.controller_:SetSelectedState("on")

		local var_6_0 = ChipCfg[arg_6_0.chipID_]

		arg_6_0.nameText_.text = var_6_0.suit_name
		arg_6_0.desText_.text = var_6_0.desc

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.contentTrans_)

		arg_6_0.iconImage_.sprite = getSpriteViaConfig("ChipSkillIcon", var_6_0.picture_id)
	else
		arg_6_0.controller_:SetSelectedState("off")
	end
end

function var_0_0.SetIsShow(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.BindRedPoint(arg_8_0)
	if arg_8_0.extra_ then
		SetActive(arg_8_0.redGo_, false)
	else
		local var_8_0 = RedPointConst.CHIP_HERO_CHIP .. "_all_" .. arg_8_0.heroID_ .. "_" .. arg_8_0.type_
		local var_8_1 = RedPointConst.CHIP_HERO_CHIP .. "_" .. arg_8_0.heroID_ .. "_" .. arg_8_0.type_
		local var_8_2 = RedPointConst.CHIP_HERO_CURRENCY_CHIP .. "_" .. arg_8_0.heroID_ .. "_" .. arg_8_0.type_

		manager.redPoint:addGroup(var_8_0, {
			var_8_1,
			var_8_2
		})
		manager.redPoint:bindUIandKey(arg_8_0.transform_, var_8_0)
	end
end

function var_0_0.UnBindRedPoint(arg_9_0)
	if arg_9_0.extra_ then
		-- block empty
	else
		manager.redPoint:unbindUIandKey(arg_9_0.transform_)
	end
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
