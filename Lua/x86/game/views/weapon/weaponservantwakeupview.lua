local var_0_0 = class("WeaponServantWakeUpView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_servant/HeroServantCallNameUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.characterImg_.immediate = true
	arg_4_0.iconImg_.immediate = true
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.checkBtn_, nil, function()
		ServantAction.ServantMerge(arg_5_0.servantID_, {
			arg_5_0.uid_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnServantMergeResult(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:Go("/weaponServantMergeResultView", {
		servantID = arg_8_0.servantID_,
		uid = tonumber(arg_8_1.servant_uid),
		backThrice = arg_8_0.backThrice_,
		HeroId = arg_8_0.params_.HeroId,
		race = arg_8_0.params_.race
	})
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.servantID_ = arg_9_0.params_.servantID
	arg_9_0.uid_ = arg_9_0.params_.uid
	arg_9_0.backThrice_ = arg_9_0.params_.backThrice

	manager.windowBar:RegistBackCallBack(function()
		arg_9_0:Back()
	end)

	local var_9_0 = ServantTools.GetServantSpecHero(arg_9_0.servantID_)

	arg_9_0.characterImg_.spriteSync = SpritePathCfg.HeroLittleIcon.path .. var_9_0
	arg_9_0.heronameText_.text = GetI18NText(HeroCfg[var_9_0].name)
	arg_9_0.servantnameText_.text = ItemTools.getItemName(arg_9_0.servantID_)

	arg_9_0:UpdateImg()
	arg_9_0:UpdateTips()
end

function var_0_0.UpdateImg(arg_11_0)
	arg_11_0.iconImg_.spriteSync = "TextureConfig/WeaponServant/Portrait/" .. arg_11_0.servantID_
end

function var_0_0.UpdateTips(arg_12_0)
	local var_12_0 = WeaponServantData:GetServantSByID(arg_12_0.servantID_)
	local var_12_1 = WeaponServantCfg[arg_12_0.servantID_].starlevel
	local var_12_2 = GameSetting.weapon_promote_max.value[var_12_1] + 1
	local var_12_3 = 0
	local var_12_4 = 0

	if var_12_0 then
		for iter_12_0, iter_12_1 in pairs(var_12_0) do
			local var_12_5 = WeaponServantData:GetServantDataByUID(iter_12_0)

			if var_12_3 < var_12_5.stage then
				var_12_3 = var_12_5.stage
			end

			var_12_4 = var_12_4 + 1
		end
	end

	local var_12_6 = var_12_3 + var_12_4 - 1

	if var_12_4 > 0 then
		SetActive(arg_12_0.tipsGo_, true)

		var_12_6 = var_12_2 < var_12_6 and var_12_2 or var_12_6
		arg_12_0.tipsText_.text = string.format(GetTips("SERVANT_TRANSCEND_PROMPT"), tostring(var_12_6))
	else
		SetActive(arg_12_0.tipsGo_, false)
	end
end

function var_0_0.OnExit(arg_13_0)
	return
end

return var_0_0
