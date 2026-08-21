local var_0_0 = class("EquipmentTransformInfoLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "EquipmentTransformInfoUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.loader = AutoLoader.New()

	return
end

function var_0_0.didEnter(arg_3_0)
	assert(arg_3_0.contextData.equipVO, "Not Pass EquipVO")

	local var_3_0 = arg_3_0._tf:Find("Main"):Find("item")

	updateDrop(var_3_0, {
		type = DROP_TYPE_EQUIP,
		id = arg_3_0.contextData.equipVO.id
	})
	onButton(arg_3_0, var_3_0, function()
		arg_3_0:emit(var_0_0.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_3_1

	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)
	arg_3_0.loader:GetPrefab("ui/equipupgradeAni", "", function(arg_5_0)
		setParent(arg_5_0, arg_3_0._tf)
		setActive(arg_5_0, true)

		local var_5_0 = arg_5_0:GetComponent(typeof(DftAniEvent))

		var_5_0:SetTriggerEvent(function(arg_6_0)
			var_3_1 = true

			return
		end)
		var_5_0:SetEndEvent(function(arg_7_0)
			arg_3_0:closeView()

			return
		end)

		function arg_3_0.unloadEffect()
			var_5_0:SetTriggerEvent(nil)
			var_5_0:SetEndEvent(nil)

			return
		end

		return
	end)
	onButton(arg_3_0, arg_3_0._tf, function()
		if var_3_1 then
			arg_3_0:closeView()
		end

		return
	end)

	return
end

function var_0_0.willExit(arg_10_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_10_0._tf)

	if arg_10_0.unloadEffect then
		arg_10_0.unloadEffect()
	end

	arg_10_0.loader:Clear()

	return
end

return var_0_0
