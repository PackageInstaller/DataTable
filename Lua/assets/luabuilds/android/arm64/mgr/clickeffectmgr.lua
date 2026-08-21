pg = pg or {}
pg.ClickEffectMgr = singletonClass("ClickEffectMgr")
pg.ClickEffectMgr.CONFIG = {
	NORMAL = {
		"ui",
		"clickeffect"
	},
	DORM3D = {
		"ui",
		"clickeffectdorm"
	}
}

function pg.ClickEffectMgr.Init(arg_1_0, arg_1_1)
	print("initializing click effect manager...")

	arg_1_0.OverlayCamera = tf(GameObject.Find("OverlayCamera"))
	arg_1_0.OverlayEffect = arg_1_0.OverlayCamera:Find("Overlay/UIEffect")
	arg_1_0.OverlayEffectClickCom = arg_1_0.OverlayEffect:GetComponent("ClickEffectBehaviour")

	arg_1_0.OverlayEffectClickCom:Init(arg_1_0.OverlayCamera:GetComponent("Camera"), arg_1_0.OverlayEffect)

	arg_1_0.effectClick = nil
	arg_1_0.effectDic = {}

	SetActive(arg_1_0.OverlayEffect, PlayerPrefs.GetInt(SHOW_TOUCH_EFFECT, 1) > 0)
	arg_1_0:SetClickEffect("NORMAL", nil, nil, arg_1_1)

	return
end

function pg.ClickEffectMgr.ClearClickEffect(arg_2_0)
	if arg_2_0.clickEffect then
		arg_2_0.OverlayEffectClickCom:UnRegisterEffect()
		SetActive(arg_2_0.clickEffect, false)

		arg_2_0.clickEffect = nil
	end

	return
end

function pg.ClickEffectMgr.SetClickEffect(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if not arg_3_0.CONFIG[arg_3_1] then
		return
	end

	local var_3_0 = arg_3_0.CONFIG[arg_3_1][1]
	local var_3_1 = arg_3_0.CONFIG[arg_3_1][2]

	arg_3_0:ClearClickEffect()

	arg_3_0.clickEffect = arg_3_0.effectDic[arg_3_0.CONFIG[arg_3_1][2]]

	local function var_3_2()
		arg_3_0.OverlayEffectClickCom:RegisterEffect(arg_3_0.clickEffect, arg_3_2, arg_3_3)

		if arg_3_4 then
			arg_3_4()
		end

		return
	end

	if arg_3_0.clickEffect then
		(function()
			arg_3_0.OverlayEffectClickCom:RegisterEffect(arg_3_0.clickEffect, arg_3_2, arg_3_3)

			if arg_3_4 then
				arg_3_4()
			end

			return
		end)()
	else
		LoadAndInstantiateAsync(var_3_0, arg_3_0.CONFIG[arg_3_1][2], function(arg_5_0)
			arg_3_0.effectDic[var_3_1] = go(arg_5_0)

			setParent(arg_3_0.effectDic[var_3_1], arg_3_0.OverlayEffect)

			arg_3_0.clickEffect = arg_3_0.effectDic[var_3_1]

			var_3_2()

			return
		end)
	end

	return
end

return
