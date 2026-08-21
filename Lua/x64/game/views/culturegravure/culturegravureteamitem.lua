local var_0_0 = class("CultureGravureTeamItem", ReduxView)

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

	arg_3_0.isShowDetail_ = false
	arg_3_0.detailController_ = arg_3_0.itemCon_:GetController("detail")

	arg_3_0:InitHero()
end

function var_0_0.InitHero(arg_4_0)
	arg_4_0.heros = {}

	for iter_4_0 = 1, 3 do
		local var_4_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_4_0, arg_4_0["hero_" .. iter_4_0])

		var_4_0.selectController = var_4_0.heroCon_:GetController("selected")
		var_4_0.lockController = var_4_0.heroCon_:GetController("lock")
		var_4_0.astroCon = {}

		for iter_4_1 = 1, 3 do
			var_4_0.astroCon[iter_4_1] = ControllerUtil.GetController(var_4_0["astro_" .. iter_4_1], "color")
		end

		for iter_4_2 = 1, 2 do
			local var_4_1 = var_4_0["equipBtn_" .. iter_4_2]

			arg_4_0:AddBtnListener(var_4_1, nil, function()
				local var_5_0 = EquipSuitCfg[arg_4_0.teamCfg_.hero_equip_suit[iter_4_0][iter_4_2]]
				local var_5_1 = var_4_1.transform.position
				local var_5_2 = GetI18NText(EquipTools.GetEffectDesc(var_5_0.suit_effect[1]))

				arg_4_0.equipClickCb(var_5_0.name, var_5_2, Vector3(var_5_1.x, var_5_1.y, var_5_1.z), var_4_0.rightTrans_, iter_4_0 ~= 3)
			end)
		end

		table.insert(arg_4_0.heros, var_4_0)
	end
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.detailBtn_, nil, function()
		arg_6_0.clickFun(arg_6_0)
	end)
end

function var_0_0.RegisterTeamClick(arg_8_0, arg_8_1)
	arg_8_0.clickFun = arg_8_1
end

function var_0_0.SetEquipClickCallBack(arg_9_0, arg_9_1)
	arg_9_0.equipClickCb = arg_9_1
end

function var_0_0.SetData(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = RecommandTeamCfg[arg_10_1]

	arg_10_0.teamCfg_ = var_10_0

	arg_10_0:IsShowDetail(false)

	for iter_10_0 = 1, 3 do
		local var_10_1 = arg_10_0.heros[iter_10_0]
		local var_10_2 = var_10_0.hero_id[iter_10_0]

		var_10_1.heroIconImg_.sprite = HeroTools.GetHeadSprite(var_10_2)
		var_10_1.typeIconImg_.sprite = HeroTools.GetHeroSkillAttributeIcon(var_10_2)
		var_10_1.nameText_.text = HeroCfg[var_10_2].name
		var_10_1.rolePosText_.text = var_10_0.hero_desc[iter_10_0]

		for iter_10_1, iter_10_2 in ipairs(var_10_0.hero_astrolabe[iter_10_0]) do
			local var_10_3 = AstrolabeTools.GetAstrolabeItemPos(iter_10_2, var_10_2)

			var_10_1.astroCon[iter_10_1]:SetSelectedState(var_10_3 or 1)
		end

		var_10_1.equip_1.spriteSync = "TextureConfig/Equip/icon_s/" .. EquipSuitCfg[var_10_0.hero_equip_suit[iter_10_0][1]].icon
		var_10_1.equip_2.spriteSync = "TextureConfig/Equip/icon_s/" .. EquipSuitCfg[var_10_0.hero_equip_suit[iter_10_0][2]].icon

		var_10_1.lockController:SetSelectedState(tostring(not HeroTools.GetHeroIsUnlock(var_10_2)))
	end
end

function var_0_0.IsShowDetail(arg_11_0, arg_11_1)
	if arg_11_1 ~= nil then
		arg_11_0.isShowDetail_ = arg_11_1

		arg_11_0.detailController_:SetSelectedState(tostring(arg_11_1))
	else
		arg_11_0.isShowDetail_ = not arg_11_0.isShowDetail_

		arg_11_0.detailController_:SetSelectedState(tostring(arg_11_0.isShowDetail_))
	end
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
