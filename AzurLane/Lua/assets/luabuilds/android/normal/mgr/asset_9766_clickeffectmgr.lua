pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.ClickEffectMgr = var_0_10001("ClickEffectMgr")
pg = var_0

local var_0_1 = var_0.ClickEffectMgr

var_0_1.CONFIG = {
	NORMAL = {
		"ui",
		"clickeffect"
	},
	DORM3D = {
		"ui",
		"clickeffectdorm"
	}
}

function var_0_1.Init(arg_1_0, arg_1_1)
	print = var_1_10002

	var_1_10002("initializing click effect manager...")

	tf = var_1_10002
	GameObject = var_3
	arg_1_0.OverlayCamera = var_1_10002(var_3.Find("OverlayCamera"))

	local var_1_0 = arg_1_0.OverlayCamera

	arg_1_0.OverlayEffect = var_2.Find(var_1_0, "Overlay/UIEffect")

	local var_1_1 = arg_1_0.OverlayEffect

	arg_1_0.OverlayEffectClickCom = var_2.GetComponent(var_1_1, "ClickEffectBehaviour")

	local var_1_2 = arg_1_0.OverlayEffectClickCom
	local var_1_3 = var_2.Init
	local var_1_4 = arg_1_0.OverlayCamera

	var_1_3(var_1_2, var_4.GetComponent(var_1_4, "Camera"), arg_1_0.OverlayEffect)

	arg_1_0.effectClick = nil
	arg_1_0.effectDic = {}
	PlayerPrefs = var_2

	local var_1_5 = var_2.GetInt

	SHOW_TOUCH_EFFECT = var_1_2

	local var_1_6 = var_1_5(var_1_2, 1)
	local var_1_7 = 0 < var_1_6

	SetActive = var_3

	var_3(arg_1_0.OverlayEffect, var_1_7)
	arg_1_0:SetClickEffect("NORMAL", nil, nil, arg_1_1)

	return
end

function var_0_1.ClearClickEffect(arg_2_0)
	if arg_2_0.clickEffect then
		local var_2_0 = arg_2_0.OverlayEffectClickCom

		var_1.UnRegisterEffect(var_2_0)

		SetActive = var_1

		var_1(arg_2_0.clickEffect, false)

		arg_2_0.clickEffect = nil
	end

	return
end

function var_0_1.SetClickEffect(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if not arg_3_0.CONFIG[arg_3_1] then
		return
	end

	local var_3_0 = arg_3_0.CONFIG[arg_3_1][1]
	local var_3_1 = arg_3_0.CONFIG[arg_3_1][2]

	arg_3_0:ClearClickEffect()

	arg_3_0.clickEffect = arg_3_0.effectDic[var_3_1]

	local function var_3_2()
		local var_4_0 = arg_3_0.OverlayEffectClickCom

		var_0.RegisterEffect(var_4_0, arg_3_0.clickEffect, arg_3_2, arg_3_3)

		if arg_3_4 then
			arg_3_4()
		end

		return
	end

	if arg_3_0.clickEffect then
		var_3_2()
	else
		LoadAndInstantiateAsync = var_8

		var_8(var_3_0, var_3_1, function(arg_5_0)
			local var_5_0 = arg_3_0.effectDic
			local var_5_1 = var_3_1

			go = var_2_10003
			var_5_0[var_5_1] = var_2_10003(arg_5_0)
			setParent = var_5_0

			var_5_0(arg_3_0.effectDic[var_3_1], arg_3_0.OverlayEffect)

			arg_3_0.clickEffect = arg_3_0.effectDic[var_3_1]

			var_3_2()

			return
		end)
	end

	return
end

return
