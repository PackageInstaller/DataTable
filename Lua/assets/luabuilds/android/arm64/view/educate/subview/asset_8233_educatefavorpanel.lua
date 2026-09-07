local EducateFavorPanel = class("EducateFavorPanel", import("...base.BaseSubView"))

function EducateFavorPanel:getUIName()
	return "EducateFavorPanel"
end

function EducateFavorPanel:OnInit()
	self.favorPanelTF = self._tf:Find("favor_panel")
	self.favorPanelAnim = self.favorPanelTF:GetComponent(typeof(Animation))
	self.favorPanelAnimEvent = self.favorPanelTF:GetComponent(typeof(DftAniEvent))

	self.favorPanelAnimEvent:SetEndEvent(function()
		setActive(self.favorPanelTF, false)

		return
	end)
	setActive(self.favorPanelTF, false)

	self.favorUIList = UIItemList.New(self.favorPanelTF:Find("panel/bg/view/content"), self.favorPanelTF:Find("panel/bg/view/content/tpl"))
	self.favorCurTF = self.favorPanelTF:Find("panel/bg/cur")

	self:OverlayPanel(self._tf, {
		pbList = {
			self.favorPanelTF:Find("panel/bg")
		}
	})
	self:addListener()
	self:Flush()

	return
end

function EducateFavorPanel:addListener()
	onButton(self, self.favorPanelTF, function()
		self:Hide()

		return
	end, SFX_PANEL)
	self.favorUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			self:updateFavorItem(arg_6_1, arg_6_2)
		end

		return
	end)

	return
end

function EducateFavorPanel:updateFavorPanel()
	self.char = getProxy(EducateProxy):GetCharData()

	local var_7_0 = self.char:GetFavor()

	setText(self.favorCurTF:Find("lv"), var_7_0.lv)

	local var_7_1 = self.char:GetFavorUpgradExp(var_7_0.lv)

	setText(self.favorCurTF:Find("progress"), i18n("child_favor_progress", var_7_0.exp .. "/" .. var_7_1))
	setSlider(self.favorCurTF:Find("slider"), 0, 1, var_7_0.exp / var_7_1)
	self.favorUIList:align(self.char:getConfig("favor_level") - 1)

	return
end

function EducateFavorPanel:updateFavorItem(arg_8_1, arg_8_2)
	setText(arg_8_2:Find("lv"), arg_8_1 + 1 + 1)

	local var_8_0 = arg_8_1 + 1 < self.char:GetFavor().lv

	setActive(arg_8_2:Find("lock"), not var_8_0)
	setActive(arg_8_2:Find("unlock"), var_8_0)

	if not var_8_0 then
		local var_8_1 = self.char:GetFavorUpgradExp(arg_8_1 + 1)

		setText(arg_8_2:Find("Text"), i18n("child_favor_lock1", arg_8_1 + 1 + 1))
		setTextColor(arg_8_2:Find("Text"), Color.NewHex("F5F5F5"))
		setTextColor(arg_8_2:Find("lv"), Color.NewHex("F5F5F5"))
	else
		local var_8_2 = self.char:GetPerformByReplace(arg_8_1 + 1)

		if var_8_2[1] then
			setText(arg_8_2:Find("Text"), (self:getStoryTitle(pg.child_performance[var_8_2[1]].param)))
		end

		setTextColor(arg_8_2:Find("Text"), Color.NewHex("393A3C"))
		setTextColor(arg_8_2:Find("lv"), Color.NewHex("FFFFFF"))
		onButton(self, arg_8_2:Find("unlock"), function()
			pg.PerformMgr.GetInstance():PlayOne(var_8_2[1])

			return
		end, SFX_PANEL)
	end

	return
end

function EducateFavorPanel:getStoryTitle(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(pg.memory_template.all) do
		if table.contains(pg.memory_template[iter_10_1].unlock_pre, arg_10_1) then
			return pg.memory_template[iter_10_1].title
		end
	end

	return arg_10_1
end

function EducateFavorPanel:Show()
	if not self:GetLoaded() then
		return
	end

	setActive(self.favorPanelTF, true)
	self:updateFavorPanel()

	return
end

function EducateFavorPanel:Hide()
	self.favorPanelAnim:Play("anim_educate_educateUI_favor_out")

	return
end

function EducateFavorPanel:Flush()
	if not self:GetLoaded() then
		return
	end

	self:updateFavorPanel()

	return
end

function EducateFavorPanel:OnDestroy()
	self.favorPanelAnimEvent:SetEndEvent(nil)
	self:UnOverlayPanel(self._tf)

	return
end

return EducateFavorPanel
