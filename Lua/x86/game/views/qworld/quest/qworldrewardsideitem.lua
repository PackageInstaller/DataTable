local var_0_0 = class("QWorldRewardSideItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.rareController_ = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("highlight")
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.reward_ = arg_5_1

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = arg_6_0.reward_

	if var_6_0 then
		arg_6_0.text_.text = ItemTools.getItemName(var_6_0.id)
		arg_6_0.numText_.text = formatNumber(var_6_0.num)

		local var_6_1 = false
		local var_6_2 = ItemCfg[var_6_0.id]

		if var_6_2.type == ItemConst.ITEM_TYPE.EQUIP then
			var_6_1 = true
		end

		ItemTools.GetItemSpriteAsync(var_6_0.id, function(arg_7_0, arg_7_1)
			if isNil(arg_6_0.gameObject_) then
				return
			end

			if var_6_0 and arg_7_0 == var_6_0.id then
				arg_6_0.icon_.sprite = arg_7_1
			end
		end, nil, var_6_1)

		if var_6_2.display_rare == 5 then
			arg_6_0.animName_ = "UI_propsPanel_Item_gloden"

			arg_6_0.rareController_:SetSelectedState("true")
		else
			arg_6_0.animName_ = "UI_propsPanel_Item"

			arg_6_0.rareController_:SetSelectedState("false")
		end

		arg_6_0:RefreshAnim()
	end
end

function var_0_0.RefreshAnim(arg_8_0)
	if arg_8_0.animName_ and arg_8_0.gameObject_.activeInHierarchy then
		arg_8_0.ani_:Play(arg_8_0.animName_)
		arg_8_0.ani_:Update(0)

		arg_8_0.animName_ = nil
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
