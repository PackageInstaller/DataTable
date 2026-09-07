local SVRealmPanel = class("SVRealmPanel", import("view.base.BaseSubView"))

function SVRealmPanel:getUIName()
	return "SVRealmPanel"
end

function SVRealmPanel:OnLoaded()
	return
end

function SVRealmPanel:OnInit()
	local var_3_0 = self._tf:Find("panel")

	self.btnBLHX = var_3_0:Find("blhx")
	self.btnCSZZ = var_3_0:Find("cszz")

	setActive(self.btnBLHX, true)
	setActive(self.btnCSZZ, true)
	onButton(self, self.btnBLHX, function()
		self:PlayAnim(self.btnBLHX, function()
			self:Hide()
			self.onConfirm(1)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, self.btnCSZZ, function()
		self:PlayAnim(self.btnCSZZ, function()
			self:Hide()
			self.onConfirm(2)

			return
		end)

		return
	end)

	return
end

function SVRealmPanel:OnDestroy()
	return
end

function SVRealmPanel:Show()
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)
	setActive(self._tf, true)

	return
end

function SVRealmPanel:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	setActive(self._tf, false)

	return
end

function SVRealmPanel:Setup(arg_11_1)
	self.onConfirm = arg_11_1

	return
end

function SVRealmPanel:PlayAnim(arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1:Find("bg")

	setActive(var_12_0, true)
	LeanTween.value(go(var_12_0), 1, 1.2, 0.2):setOnUpdate(System.Action_float(function(arg_13_0)
		var_12_0.localScale = Vector3(arg_13_0, arg_13_0, 1)

		return
	end)):setOnComplete(System.Action(function()
		setActive(var_12_0, false)

		var_12_0.localScale = Vector3(1, 1, 1)

		arg_12_2()

		return
	end))
	LeanTween.value(go(var_12_0), 1, 0.7, 0.2)

	return
end

return SVRealmPanel
