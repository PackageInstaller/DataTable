local AtelierCompositeResultYumiaView = class("AtelierCompositeResultYumiaView", import("view.activity.Atelier.base.AtelierCompositeResultView"))

function AtelierCompositeResultYumiaView:ShowCompositeResult(arg_1_1)
	GetComponent(self._tf, typeof(Animation)):Play("Anim_AtelierCompositeYumiaUI_ConfirmWindow_Resultwindow_In")
	setActive(self._go, true)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	if arg_1_1[1] == nil then
		return
	end

	local var_1_0 = self._tf:Find("Window/itemContant")
	local var_1_1 = self._tf:Find("Window/AtelierCommonYumiaItem")

	if arg_1_1[1].type ~= DROP_TYPE_RYZA_DROP then
		setActive(var_1_1, false)
		setActive(var_1_0, true)
		UIItemList.StaticAlign(var_1_0, self._tf:Find("Window/itemContant/Icon"), #arg_1_1, function(arg_2_0, arg_2_1, arg_2_2)
			if arg_2_0 == UIItemList.EventUpdate then
				self._parentClass:UpdateRyzaDrop(arg_2_2, arg_1_1[arg_2_1 + 1])
				setActive(arg_2_2, true)
			end

			return
		end)

		local var_1_2 = 0

		for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
			var_1_2 = iter_1_1:getCount() + var_1_2
		end

		setText(self._tf:Find("Window/CountBG/Text"), var_1_2)
	else
		local var_1_3 = AtelierMaterial.New({
			configId = arg_1_1[1].id
		})

		var_1_3.count = arg_1_1[1]:getCount()

		self._parentClass:UpdateRyzaItem(var_1_1, var_1_3)
		setActive(var_1_1, true)
		setActive(var_1_0, false)
		setText(self._tf:Find("Window/CountBG/Text"), arg_1_1[1]:getCount())
	end

	return
end

function AtelierCompositeResultYumiaView:HideCompositeResult()
	if not isActive(self._go) then
		return
	end

	local var_3_0 = GetComponent(self._tf, typeof(Animation))

	var_3_0:Play("Anim_AtelierCompositeYumiaUI_ConfirmWindow_Resultwindow_Out")
	pg.UIMgr.GetInstance():LoadingOn(false)

	self.closeTimer = FrameTimer.New(function()
		if not var_3_0:IsPlaying("Anim_AtelierCompositeYumiaUI_ConfirmWindow_Resultwindow_Out") then
			self:StopCloseTimer()
			pg.UIMgr.GetInstance():LoadingOff()
			AtelierCompositeResultYumiaView.super.HideCompositeResult(self)
		end

		return
	end, 1, -1)

	self.closeTimer:Start()

	return true
end

function AtelierCompositeResultYumiaView:StopCloseTimer()
	if self.closeTimer then
		self.closeTimer:Stop()

		self.closeTimer = nil
	end

	return
end

function AtelierCompositeResultYumiaView:PlayGuide()
	return
end

return AtelierCompositeResultYumiaView
