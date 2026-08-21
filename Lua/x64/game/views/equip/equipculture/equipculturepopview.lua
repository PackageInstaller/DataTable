local var_0_0 = import("game.views.pop.PopLevelUpBaseView")
local var_0_1 = class("EquipCulturePopView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Hero_equip/Develop/EquipupPopUI"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_1.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_1.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.attrs_ = {}

	for iter_4_0 = 1, 2 do
		local var_4_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_4_0, arg_4_0["attr_" .. iter_4_0])
		table.insert(arg_4_0.attrs_, var_4_0)
	end

	arg_4_0.stateController_ = arg_4_0.transCon_:GetController("state")
	arg_4_0.upgradeController_ = arg_4_0.transCon_:GetController("upgrade")
end

function var_0_1.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnBack_, nil, function()
		SetActive(arg_5_0.oldLv_.gameObject, false)
		manager.notify:Invoke(EQUIP_CULTURE_SUCCESS)
		arg_5_0:Back()

		if arg_5_0.params_.callback then
			arg_5_0.params_.callback()

			arg_5_0.params_.callback = nil
		end
	end)
end

function var_0_1.OnEnter(arg_7_0)
	arg_7_0:CheckBack()
	arg_7_0:RefreshUI()
end

function var_0_1.RefreshUI(arg_8_0)
	local var_8_0 = arg_8_0.params_.type

	SetActive(arg_8_0.oldLv_.gameObject, true)
	arg_8_0:RefreshType(var_8_0)

	if var_8_0 ~= "reset" then
		local var_8_1 = arg_8_0.params_.oldEquip
		local var_8_2 = arg_8_0.params_.newEquip

		if not var_8_1 or not var_8_2 then
			return
		end

		local var_8_3 = var_8_1:GetLevel()
		local var_8_4 = var_8_2:GetLevel()
		local var_8_5 = EquipTools.CountEquipAttribute(var_8_1)
		local var_8_6 = EquipTools.CountEquipAttribute(var_8_2)
		local var_8_7 = 1

		for iter_8_0, iter_8_1 in pairs(var_8_5) do
			local var_8_8 = PublicAttrCfg[iter_8_0]
			local var_8_9 = arg_8_0.attrs_[var_8_7]
			local var_8_10 = math.floor(iter_8_1)
			local var_8_11 = math.floor(var_8_6[iter_8_0])

			if var_8_8.percent and var_8_8.percent == 1 then
				var_8_10 = iter_8_1 / 10 .. "%"
				var_8_11 = var_8_6[iter_8_0] / 10 .. "%"
			end

			var_8_9.name_.text = GetI18NText(var_8_8.name)
			var_8_9.icon_.sprite = getSprite("Atlas/SystemCommonAtlas", var_8_8.icon)
			var_8_9.oldVal_.text = var_8_10
			var_8_9.newVal_.text = var_8_11
			var_8_7 = var_8_7 + 1
		end
	end
end

function var_0_1.RefreshType(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.params_.oldEquip
	local var_9_1 = arg_9_0.params_.newEquip

	arg_9_0.stateController_:SetSelectedState(arg_9_1 == "reset" and "reset" or "lv")
	arg_9_0.upgradeController_:SetSelectedState("hide")

	if arg_9_1 == "levelup" then
		arg_9_0.oldLv_.text = var_9_0:GetLevel()
		arg_9_0.newLv_.text = var_9_1:GetLevel()
		arg_9_0.mainTitle_.text = GetTips("EQUIP_LEVELUP_POP")

		if arg_9_0.params_.breakTimes and arg_9_0.params_.breakTimes > 0 then
			arg_9_0.upgradeController_:SetSelectedState("show")

			arg_9_0.oldUpgradeLv_.text = var_9_0:GetMaxLv()
			arg_9_0.nowUpgradeLv_.text = var_9_1:GetMaxLv()
			arg_9_0.params_.breakTimes = nil
		end
	elseif arg_9_1 == "upgrade" then
		arg_9_0.oldLv_.text = var_9_0:GetMaxLv()
		arg_9_0.newLv_.text = var_9_1:GetMaxLv()
		arg_9_0.mainTitle_.text = GetTips("EQUIP_UPGRADE_POP")

		arg_9_0:ShowUpGradeTips()
	elseif arg_9_1 == "reset" then
		local var_9_2 = arg_9_0.params_.heroId

		arg_9_0.resetHeroIcon_.sprite = SpritePathCfg.HeroMediumIcon.path .. var_9_2
		arg_9_0.resetDesc_.text = string.format(GetTips("EQUIP_HERO_RESET_POP"), HeroTools.GetHeroFullName(var_9_2))
	end
end

function var_0_1.ShowUpGradeTips(arg_10_0)
	local var_10_0

	var_10_0 = Timer.New(function()
		var_10_0:Stop()
		ShowTips("EQUIP_BREAK_SUCCESS")
	end, 1, 0)

	var_10_0:Start()
end

function var_0_1.RefreshSkill(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = #arg_12_1

	for iter_12_0 = 1, var_12_0 do
		if iter_12_0 > #arg_12_0.skillItems_ then
			local var_12_1 = Object.Instantiate(arg_12_0.skillItem_, arg_12_0.skillParent_.transform)
			local var_12_2 = var_12_1.transform

			arg_12_0.skillItems_[iter_12_0] = {
				gameObject = var_12_1,
				icon_ = arg_12_0:FindCom(typeof(Image), "icon", var_12_2),
				name_ = arg_12_0:FindCom(typeof(Text), "lv", var_12_2),
				lv_ = arg_12_0:FindCom(typeof(Text), "name", var_12_2)
			}
		end

		local var_12_3 = arg_12_1[iter_12_0]
		local var_12_4 = EquipSkillCfg[var_12_3.id]

		arg_12_0.skillItems_[iter_12_0].icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. var_12_4.icon)
		arg_12_0.skillItems_[iter_12_0].name_.text = GetI18NText(var_12_4.name)
		arg_12_0.skillItems_[iter_12_0].lv_.text = GetTips("LEVEL") .. var_12_3.num
	end

	for iter_12_1, iter_12_2 in ipairs(arg_12_0.skillItems_) do
		SetActive(iter_12_2.gameObject, iter_12_1 <= var_12_0)
	end
end

function var_0_1.GetPlayBackwardsAnimator(arg_13_0)
	return {
		{
			arg_13_0.animator_,
			"Fx_CompopUI04_xs",
			false
		}
	}, nil
end

function var_0_1.Dispose(arg_14_0)
	var_0_1.super.Dispose(arg_14_0)
end

return var_0_1
