class = var_0_10000

local var_0_0 = "EquipmentTransformInfoLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "EquipmentTransformInfoUI"
end

function var_0_1.init(arg_2_0)
	AutoLoader = var_1_10001
	arg_2_0.loader = var_1_10001.New()

	return
end

function var_0_1.didEnter(arg_3_0)
	assert = var_1_10001

	var_1_10001(arg_3_0.contextData.equipVO, "Not Pass EquipVO")

	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "Main")
	local var_3_2 = var_1.Find(var_3_1, "item")
	local var_3_3 = {}

	DROP_TYPE_EQUIP = var_3_1
	var_3_3.type = var_3_1
	var_3_3.id = arg_3_0.contextData.equipVO.id
	updateDrop = var_4

	var_4(var_3_2, var_3_3)

	onButton = var_4

	local var_3_4 = arg_3_0
	local var_3_5 = var_3_2

	local function var_3_6()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_DROP, var_3_3)

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_3_4, var_3_5, var_3_6, var_1_10009)

	local var_3_7

	pg = var_5

	local var_3_8 = var_5.UIMgr.GetInstance()

	var_5.BlurPanel(var_3_8, arg_3_0._tf)

	local var_3_9 = arg_3_0.loader

	var_5.GetPrefab(var_3_9, "ui/equipupgradeAni", "", function(arg_5_0)
		setParent = var_2_10001

		var_2_10001(arg_5_0, arg_3_0._tf)

		setActive = var_2_10001

		var_2_10001(arg_5_0, true)

		local var_5_0 = arg_5_0
		local var_5_1 = arg_5_0.GetComponent

		typeof = var_4
		DftAniEvent = var_2_10006

		local var_5_2 = var_5_1(var_5_0, var_4(var_2_10006))

		var_1.SetTriggerEvent(var_5_2, function(arg_6_0)
			var_3_7 = true

			return
		end)
		var_1:SetEndEvent(function(arg_7_0)
			local var_7_0 = arg_3_0

			var_1.closeView(var_7_0)

			return
		end)

		function arg_3_0.unloadEffect()
			local var_8_0 = var_0

			var_0.SetTriggerEvent(var_8_0, nil)

			local var_8_1 = var_0

			var_0.SetEndEvent(var_8_1, nil)

			return
		end

		return
	end)

	onButton = var_5

	var_5(arg_3_0, arg_3_0._tf, function()
		if var_3_7 then
			local var_9_0 = arg_3_0

			var_0.closeView(var_9_0)
		end

		return
	end)

	return
end

function var_0_1.willExit(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_10_0, arg_10_0._tf)

	if arg_10_0.unloadEffect then
		arg_10_0.unloadEffect()
	end

	local var_10_1 = arg_10_0.loader

	var_1.Clear(var_10_1)

	return
end

return var_0_1
