local var_0_0 = class("CultureGravureEquipPreviewItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController_ = arg_3_0.control_:GetController("status")
	arg_3_0.qualityController_ = arg_3_0.control_:GetController("quality")
	arg_3_0.enchantController_ = arg_3_0.control_:GetController("enchant")
	arg_3_0.resetController_ = arg_3_0.control_:GetController("reset")
	arg_3_0.emptyController_ = arg_3_0.control_:GetController("empty")
	arg_3_0.starController_ = ControllerUtil.GetController(arg_3_0.equipItem_, "star")
	arg_3_0.posController_ = ControllerUtil.GetController(arg_3_0.equipItem_, "position")
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_1 and (arg_5_1.equip_id ~= 0 or arg_5_3) then
		local var_5_0 = EquipCfg[arg_5_1.prefab_id]

		arg_5_0.imgIcon_.sprite = ItemTools.getItemSprite(arg_5_1.prefab_id, nil, true)
		arg_5_0.textName_.text = ItemTools.getItemName(arg_5_1.prefab_id)

		local var_5_1 = ItemCfg[arg_5_1.prefab_id].rare
		local var_5_2 = HeroConst.RARE_COLOR[var_5_1]

		arg_5_0.starController_:SetSelectedState(var_5_0.starlevel)
		arg_5_0.qualityController_:SetSelectedState(var_5_0.starlevel)
		arg_5_0.enchantController_:SetSelectedState(arg_5_1:GetEnchantCount())

		local var_5_3 = arg_5_1:GetMaxLv()

		arg_5_0.level_ = arg_5_1:GetLevel()
		arg_5_0.textLv_.text = string.format(GetTips("LEVEL") .. "：%s/%s", arg_5_0.level_, var_5_3)

		local var_5_4 = var_5_0.pos

		arg_5_0.posController_:SetSelectedState(var_5_4)
		arg_5_0:RreshReset(arg_5_1)
	end

	if arg_5_1 == nil or arg_5_1.equip_id == 0 and not arg_5_3 then
		arg_5_0.statusController_:SetSelectedState("empty")
		arg_5_0.emptyController_:SetSelectedState(arg_5_4)
	elseif arg_5_2 == "had" and arg_5_3 then
		arg_5_0.statusController_:SetSelectedState("equipped")
	else
		arg_5_0.statusController_:SetSelectedState("current")
	end
end

function var_0_0.RreshReset(arg_6_0, arg_6_1)
	if arg_6_1 and arg_6_1.race ~= 0 then
		local var_6_0 = RaceEffectCfg.all
		local var_6_1

		arg_6_0.resetController_:SetSelectedState("true")

		if table.keyof(var_6_0, arg_6_1.race) ~= nil then
			local var_6_2 = RaceEffectCfg[arg_6_1.race]

			arg_6_0.textReset_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(var_6_2.name))
			arg_6_0.imgReset_.sprite = getSprite("Atlas/SystemGroupAtlas", var_6_2.icon2)
			arg_6_0.imgReset_.color = Color(0.49019607843137253, 0.5411764705882353, 0.596078431372549)
		else
			local var_6_3 = arg_6_1.race
			local var_6_4 = HeroCfg[var_6_3]

			arg_6_0.textReset_.text = string.format(GetTips("EQUIP_HERO_ATTRIBUTE_UP"), HeroTools.GetHeroFullName(var_6_3))
			arg_6_0.imgReset_.sprite = HeroTools.GetSmallHeadSprite(arg_6_1.race)
			arg_6_0.imgReset_.color = Color.white
		end
	else
		arg_6_0.resetController_:SetSelectedState("false")
	end
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
