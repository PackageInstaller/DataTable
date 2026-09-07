local EquipmentTransformInfoLayer = class("EquipmentTransformInfoLayer", import("view.base.BaseUI"))

function EquipmentTransformInfoLayer:getUIName()
	return "EquipmentTransformInfoUI"
end

function EquipmentTransformInfoLayer:init()
	self.loader = AutoLoader.New()

	return
end

function EquipmentTransformInfoLayer:didEnter()
	assert(self.contextData.equipVO, "Not Pass EquipVO")

	local var_3_0 = self._tf:Find("Main"):Find("item")
	local var_3_1 = {
		type = DROP_TYPE_EQUIP,
		id = self.contextData.equipVO.id
	}

	updateDrop(var_3_0, var_3_1)
	onButton(self, var_3_0, function()
		self:emit(EquipmentTransformInfoLayer.ON_DROP, var_3_1)

		return
	end, SFX_PANEL)

	local var_3_2

	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self.loader:GetPrefab("ui/equipupgradeAni", "", function(arg_5_0)
		setParent(arg_5_0, self._tf)
		setActive(arg_5_0, true)

		local var_5_0 = arg_5_0:GetComponent(typeof(DftAniEvent))

		var_5_0:SetTriggerEvent(function(arg_6_0)
			var_3_2 = true

			return
		end)
		var_5_0:SetEndEvent(function(arg_7_0)
			self:closeView()

			return
		end)

		function self.unloadEffect()
			var_5_0:SetTriggerEvent(nil)
			var_5_0:SetEndEvent(nil)

			return
		end

		return
	end)
	onButton(self, self._tf, function()
		if var_3_2 then
			self:closeView()
		end

		return
	end)

	return
end

function EquipmentTransformInfoLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	if self.unloadEffect then
		self.unloadEffect()
	end

	self.loader:Clear()

	return
end

return EquipmentTransformInfoLayer
