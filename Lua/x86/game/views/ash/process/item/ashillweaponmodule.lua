local var_0_0 = class("AshILLWeaponModule", ReduxView)
local var_0_1 = "Widget/System/Activity_EkChuah/EkChuah_IllustratedUI/WeaponItem"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.from = arg_1_3 or "DEFAULT"

	if not arg_1_2 then
		arg_1_0.gameObject_ = GameObject.Instantiate(Asset.Load(var_0_1))
		arg_1_0.transform_ = arg_1_0.gameObject_.transform
		arg_1_0.transform_.parent = arg_1_1
		arg_1_0.transform_.localPosition = Vector3.zero
		arg_1_0.transform_.localRotation = Quaternion.identity
		arg_1_0.transform_.localScale = Vector3.one
		arg_1_0.isCustomObj = false
	else
		arg_1_0.gameObject_ = arg_1_2
		arg_1_0.transform_ = arg_1_0.gameObject_.transform
		arg_1_0.isCustomObj = true
	end

	arg_1_0.callback = nil

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.lockController = arg_2_0.controller_:GetController("lock")
	arg_2_0.tipController = arg_2_0.controller_:GetController("tips")

	arg_2_0:ShowProp(false)
	arg_2_0:ShowTip(false)
	arg_2_0:AddBtnListener(arg_2_0.maskBtn_, nil, function()
		if arg_2_0.from == "PREPARE" then
			local var_3_0 = arg_2_0.weaponCfg.unlockRate

			if var_3_0 > AshSystemData:GetHomologyRate() then
				ShowTips(string.format(GetTips("ASH_UNLOCK_TIP"), var_3_0))

				if arg_2_0.callback then
					arg_2_0.callback()
				end
			elseif arg_2_0.callback then
				arg_2_0.callback(arg_2_0.weaponCfg.id)
			end

			return
		end

		local var_3_1 = arg_2_0.weaponCfg.unlockRate

		if var_3_1 > AshSystemData:GetHomologyRate() then
			ShowTips(string.format(GetTips("ASH_UNLOCK_TIP"), var_3_1))
		else
			arg_2_0:ShowProp(not arg_2_0.isShowProp)
		end
	end)
end

function var_0_0.ShowTip(arg_4_0, arg_4_1)
	if arg_4_1 ~= arg_4_0.isShowTip then
		arg_4_0.tipController:SetSelectedIndex(arg_4_1 and 1 or 0)

		arg_4_0.isShowTip = arg_4_1
	end
end

function var_0_0.ShowProp(arg_5_0, arg_5_1)
	if arg_5_1 ~= arg_5_0.isShowProp then
		SetActive(arg_5_0.propObj_, arg_5_1)

		arg_5_0.isShowProp = arg_5_1
	end
end

function var_0_0.Render(arg_6_0, arg_6_1)
	arg_6_0.weaponCfg = arg_6_1

	if not arg_6_0.weaponCfg then
		arg_6_0.lockController:SetSelectedState("true")

		return
	end

	local var_6_0 = arg_6_0.weaponCfg.cfg

	arg_6_0.icon_.sprite = pureGetSpriteWithoutAtlas(var_6_0.icon)
	arg_6_0.nameTxt_.text = GetI18NText(var_6_0.name)
	arg_6_0.descTxt_.text = GetI18NText(var_6_0.desc)
	arg_6_0.atkTxt_.text = GetI18NText(var_6_0.atk)
	arg_6_0.criTxt_.text = GetI18NText(var_6_0.crit)
	arg_6_0.speedTxt_.text = GetI18NText(var_6_0.rate_of_fire)
	arg_6_0.tipnameTxt_.text = GetI18NText(var_6_0.name)
	arg_6_0.tipdescTxt_.text = GetI18NText(var_6_0.desc)
	arg_6_0.tipatkTxt_.text = GetI18NText(var_6_0.atk)
	arg_6_0.tipcriTxt_.text = GetI18NText(var_6_0.crit)
	arg_6_0.tipspeedTxt_.text = GetI18NText(var_6_0.rate_of_fire)

	arg_6_0:RenderLock()

	if arg_6_0.weaponCfg.unlockRate > AshSystemData:GetHomologyRate() or arg_6_0.from == "PREPARE" then
		arg_6_0:ShowProp(false)
	else
		arg_6_0:ShowProp(true)
	end
end

function var_0_0.RenderLock(arg_7_0)
	if arg_7_0.weaponCfg.unlockRate > AshSystemData:GetHomologyRate() then
		arg_7_0.lockController:SetSelectedState("true")
	else
		arg_7_0.lockController:SetSelectedState("false")

		local var_7_0 = "CowbotWeaponModuleLock" .. arg_7_0.from .. arg_7_0.weaponCfg.id
		local var_7_1 = getData("ash", var_7_0)

		if arg_7_0.aniTimer_ then
			arg_7_0.aniTimer_:Stop()

			arg_7_0.aniTimer_ = nil
		end

		if not var_7_1 then
			saveData("ash", var_7_0, true)
			FrameTimer.New(function()
				arg_7_0.aniTimer_ = Timer.New(function()
					if arg_7_0.lockAnim_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
						if arg_7_0.aniTimer_ then
							arg_7_0.aniTimer_:Stop()

							arg_7_0.aniTimer_ = nil
						end

						manager.ui:UIEventEnabled(true)
					end
				end, 0.033, -1)

				manager.ui:UIEventEnabled(false)
				arg_7_0.lockAnim_:Play("WeaponItem_unlock", 0, 0)
				arg_7_0.aniTimer_:Start()
			end, 1, 1):Start()
		end
	end
end

function var_0_0.SetCallback(arg_10_0, arg_10_1)
	arg_10_0.callback = arg_10_1
end

function var_0_0.CheckID(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return false
	end

	return arg_11_1 == arg_11_0.weaponCfg.id
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.aniTimer_ then
		arg_12_0.aniTimer_:Stop()

		arg_12_0.aniTimer_ = nil
	end

	if not arg_12_0.isCustomObj then
		GameObject.DestroyImmediate(arg_12_0.gameObject_)
		Asset.Unload(var_0_1)
	end

	arg_12_0.super.Dispose(arg_12_0)
end

return var_0_0
