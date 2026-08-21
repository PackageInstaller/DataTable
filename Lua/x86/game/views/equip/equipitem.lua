local var_0_0 = class("EquipItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.starController_ = arg_2_0.equipController_:GetController("star")
	arg_2_0.posController_ = arg_2_0.equipController_:GetController("equippos")
	arg_2_0.lvController_ = arg_2_0.equipController_:GetController("lv")
	arg_2_0.selectController_ = arg_2_0.equipController_:GetController("sel")
	arg_2_0.emptyController_ = arg_2_0.equipController_:GetController("empty")
	arg_2_0.detailController_ = arg_2_0.equipController_:GetController("lvstate")

	arg_2_0:AddUIListeners()
end

function var_0_0.AddUIListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		arg_3_0:OnClick()
	end)
end

function var_0_0.RefreshData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.info_ = arg_5_1
	arg_5_0.isShowDetail_ = arg_5_2

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0.isEquip_ = arg_6_0.info_ and arg_6_0.info_.prefab_id ~= 0

	arg_6_0.emptyController_:SetSelectedState(arg_6_0.isEquip_ and "notEmpty" or "empty")
	arg_6_0.detailController_:SetSelectedState(arg_6_0.isEquip_ and arg_6_0.isShowDetail_ and "show" or "hide")

	if arg_6_0.isEquip_ then
		arg_6_0:RefreshDetail()

		arg_6_0.equipIcon_.sprite = ItemTools.getItemSprite(arg_6_0.info_.prefab_id)
	end
end

function var_0_0.RefreshDetail(arg_7_0)
	if arg_7_0.isEquip_ then
		local var_7_0 = EquipCfg[arg_7_0.info_.prefab_id]

		arg_7_0.starController_:SetSelectedState(var_7_0.starlevel)
		arg_7_0.posController_:SetSelectedState(var_7_0.pos)

		arg_7_0.level_.text = string.format(GetTips("DORM_LEVEL_TIPS"), arg_7_0.info_:GetLevel())

		if arg_7_0.info_.race == 0 then
			arg_7_0.lvController_:SetSelectedState("level")
		elseif table.keyof(RaceEffectCfg.all, arg_7_0.info_.race) ~= nil then
			local var_7_1 = RaceEffectCfg[arg_7_0.info_.race]

			if var_7_1 then
				arg_7_0.imgGroup_.sprite = getSprite("Atlas/SystemGroupAtlas", var_7_1.icon2)

				arg_7_0.lvController_:SetSelectedState("group")
			end
		elseif HeroCfg[arg_7_0.info_.race] then
			arg_7_0.imgHeroIcon_.sprite = HeroTools.GetSmallHeadSprite(arg_7_0.info_.race)

			arg_7_0.lvController_:SetSelectedState("hero")
		end
	end
end

function var_0_0.ShowSelect(arg_8_0, arg_8_1)
	arg_8_0.selectController_:SetSelectedState(arg_8_1 and "select" or "unselect")
end

function var_0_0.OnClick(arg_9_0)
	if arg_9_0.clickFunc then
		arg_9_0.clickFunc(arg_9_0.info_, arg_9_0)
	end
end

function var_0_0.RegistCallBack(arg_10_0, arg_10_1)
	arg_10_0.clickFunc = arg_10_1
end

function var_0_0.GetItemInfo(arg_11_0)
	return arg_11_0.info_
end

function var_0_0.ShowAnim(arg_12_0)
	arg_12_0.emptyController_:SetSelectedState("notEmpty")

	if arg_12_0.info_ and arg_12_0.info_.prefab_id ~= 0 then
		arg_12_0.effectAnim_:Play("Fx_icon_qiehuan")
	else
		arg_12_0.iconAnim_:Play("Fx_icon_chuandai")
		arg_12_0.effectAnim_:Play("Fx_icon_chuandai")
	end
end

function var_0_0.Hide(arg_13_0)
	arg_13_0.emptyController_:SetSelectedState("empty")
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.clickFunc = nil

	arg_14_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
