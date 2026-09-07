local NewEducateFavorPanel = class("NewEducateFavorPanel", import("view.base.BaseSubView"))

function NewEducateFavorPanel:getUIName()
	return "NewEducateFavorPanel"
end

function NewEducateFavorPanel:OnLoaded()
	self.favorPanelTF = self._tf:Find("favor_panel")
	self.favorPanelAnim = self.favorPanelTF:GetComponent(typeof(Animation))
	self.favorPanelAnimEvent = self.favorPanelTF:GetComponent(typeof(DftAniEvent))

	self.favorPanelAnimEvent:SetEndEvent(function()
		setActive(self.favorPanelTF, false)

		return
	end)
	setActive(self.favorPanelTF, false)

	local var_2_0 = self._tf:Find("favor_panel/panel")
	local var_2_1 = var_2_0:Find("bg/view/content")

	self.favorUIList = UIItemList.New(var_2_1, var_2_1:Find("tpl"))
	self.favorCurTF = var_2_0:Find("bg/cur")

	self:OverlayPanel(self._tf, {
		pbList = {
			var_2_0:Find("bg")
		}
	})

	return
end

function NewEducateFavorPanel:OnInit()
	onButton(self, self._tf:Find("favor_panel"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	self.favorUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_6_1, arg_6_2)
		end

		return
	end)

	return
end

function NewEducateFavorPanel:UpdateFavorPanel()
	local var_7_0 = self.contextData.char:GetFavorInfo()

	setText(self.favorCurTF:Find("lv"), var_7_0.lv)

	local var_7_1 = self.contextData.char:getConfig("favor_exp")[var_7_0.lv]

	setText(self.favorCurTF:Find("progress"), i18n("child_favor_progress", var_7_0.value .. "/" .. (var_7_1 or "Max")))
	setSlider(self.favorCurTF:Find("slider"), 0, 1, (var_7_1 or nil) and (var_7_0.value / var_7_1 or 1))
	self.favorUIList:align(self.contextData.char:getConfig("favor_level") - 1)

	return
end

function NewEducateFavorPanel:UpdateItem(arg_8_1, arg_8_2)
	setText(arg_8_2:Find("lv"), arg_8_1 + 1 + 1)

	local var_8_0 = arg_8_1 + 1 < self.contextData.char:GetFavorInfo().lv

	setActive(arg_8_2:Find("lock"), not var_8_0)
	setActive(arg_8_2:Find("award/got"), var_8_0)
	setText(arg_8_2:Find("Text"), i18n("child_favor_lock1", arg_8_1 + 1 + 1))
	setTextColor(arg_8_2:Find("Text"), Color.NewHex(var_8_0 and "393A3C" or "F5F5F5"))
	setTextColor(arg_8_2:Find("lv"), Color.NewHex(var_8_0 and "FFFFFF" or "F5F5F5"))

	local var_8_1 = NewEducateHelper.Config2Drop(self.contextData.char:getConfig("favor_result_display")[arg_8_1 + 1])

	NewEducateHelper.UpdateItem(arg_8_2:Find("award/item"), var_8_1)
	onButton(self, arg_8_2:Find("award"), function()
		self:emit(NewEducateBaseUI.ON_ITEM, {
			drop = var_8_1
		})

		return
	end, SFX_PANEL)

	return
end

function NewEducateFavorPanel:Show()
	NewEducateFavorPanel.super.Show(self)
	setActive(self.favorPanelTF, true)
	self:UpdateFavorPanel()

	return
end

function NewEducateFavorPanel:Hide()
	self.favorPanelAnim:Play("anim_educate_educateUI_favor_out")

	return
end

function NewEducateFavorPanel:OnDestroy()
	self:UnOverlayPanel(self._tf)

	return
end

return NewEducateFavorPanel
