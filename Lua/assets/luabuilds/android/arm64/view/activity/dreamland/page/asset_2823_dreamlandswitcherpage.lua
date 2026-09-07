local DreamlandSwitcherPage = class("DreamlandSwitcherPage", import("view.base.BaseSubView"))

function DreamlandSwitcherPage:getUIName()
	return "DreamlandSwitcherUI"
end

function DreamlandSwitcherPage:OnLoaded()
	self.confirmBtn = self._tf:Find("bg/confirm")
	self.times = {
		self._tf:Find("bg/conent/1"),
		self._tf:Find("bg/conent/2"),
		self._tf:Find("bg/conent/3")
	}

	setText(self.times[1]:Find("title"), i18n("dreamland_label_day"))
	setText(self.times[2]:Find("title"), i18n("dreamland_label_dusk"))
	setText(self.times[3]:Find("title"), i18n("dreamland_label_night"))

	return
end

function DreamlandSwitcherPage:OnInit()
	for iter_3_0, iter_3_1 in ipairs(self.times) do
		onToggle(self, iter_3_1, function(arg_4_0)
			if arg_4_0 then
				self.selected = iter_3_0
			end

			self:UpdateToggleStyle(iter_3_1, arg_4_0)

			return
		end, SFX_PANEL)
	end

	onButton(self, self.confirmBtn, function()
		if not self.selected then
			return
		end

		self:emit(DreamlandScene.EVENT_SWITCH_TIME, self.selected)
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function DreamlandSwitcherPage:Show(arg_7_1)
	DreamlandSwitcherPage.super.Show(self)
	triggerToggle(self.times[arg_7_1], true)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:InitTogglesStyle(arg_7_1)

	return
end

function DreamlandSwitcherPage:InitTogglesStyle(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(self.times) do
		if iter_8_0 ~= arg_8_1 then
			self:UpdateToggleStyle(iter_8_1, false)
		end
	end

	return
end

function DreamlandSwitcherPage:UpdateToggleStyle(arg_9_1, arg_9_2)
	local var_9_0 = arg_9_1:Find("icon")
	local var_9_1 = var_9_0:GetComponent(typeof(Image))
	local var_9_2 = arg_9_1:Find("title_icon"):GetComponent(typeof(Image))
	local var_9_3 = arg_9_1:Find("title").GetComponent(var_9_0, typeof(Text))
	local var_9_4 = Color.New(1, 1, 1, 1)
	local var_9_5 = Color.New(0.4235294, 0.4313726, 0.5137255, 1)

	var_9_1.color = arg_9_2 and var_9_4 or var_9_5
	var_9_2.color = arg_9_2 and var_9_4 or var_9_5
	var_9_3.color = arg_9_2 and var_9_4 or var_9_5

	return
end

function DreamlandSwitcherPage:Hide()
	DreamlandSwitcherPage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function DreamlandSwitcherPage:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return DreamlandSwitcherPage
