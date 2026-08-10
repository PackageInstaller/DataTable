local var_0_0 = class("WeaponServantWakeUpView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/ObtainUI/Weapon/WeaponServantWakeUp_anim"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.maskBtn_, nil, function()
		local var_5_0 = arg_4_0.weaponservantwakeup_animAni_:GetCurrentAnimatorStateInfo(0)

		if var_5_0.normalizedTime <= 0.0505 then
			arg_4_0.weaponservantwakeup_animAni_:Play(var_5_0.fullPathHash, -1, 0.0505)
			manager.audio:StopEffect()
		else
			arg_4_0:Back()
			arg_4_0:Back()
			ServantTools.JumpToNormalList(arg_4_0.HeroID, arg_4_0.uid_)
			arg_4_0:Go("/weaponServant", {
				uid = arg_4_0.uid_,
				HeroID = arg_4_0.HeroID
			})
		end
	end)
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()

	arg_6_0.sleepyiconImg_.immediate = true
	arg_6_0.portrait_.immediate = true
end

function var_0_0.OnEnter(arg_7_0)
	manager.windowBar:HideBar()

	arg_7_0.servantID_ = arg_7_0.params_.servantID
	arg_7_0.sleepyID_ = ServantTools.GetSleepyServantByServant(arg_7_0.servantID_)
	arg_7_0.uid_ = arg_7_0.params_.uid
	arg_7_0.HeroId = arg_7_0.params_.HeroID
	arg_7_0.name_.text = ItemTools.getItemName(arg_7_0.servantID_)

	local var_7_0 = WeaponServantCfg[arg_7_0.servantID_].race
	local var_7_1 = string.format("icon_group_%d_c", var_7_0)

	arg_7_0.campImg_.sprite = getSprite("Atlas/CampItemAtlas", var_7_1)
	arg_7_0.sleepyiconImg_.spriteSync = "TextureConfig/WeaponServant/Portrait/" .. arg_7_0.sleepyID_
	arg_7_0.portrait_.spriteSync = "TextureConfig/WeaponServant/Portrait/" .. arg_7_0.servantID_

	manager.audio:PlayEffect("ui_system", "key_awakening")
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Cacheable(arg_9_0)
	return false
end

return var_0_0
