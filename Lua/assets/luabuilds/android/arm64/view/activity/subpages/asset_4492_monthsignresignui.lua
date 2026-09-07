local MonthSignReSignUI = class("MonthSignReSignUI", import("...base.BaseSubView"))

function MonthSignReSignUI:getUIName()
	return "MonthSignReSignUI"
end

function MonthSignReSignUI:OnInit()
	self:InitUI()
	setActive(self._tf, true)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function MonthSignReSignUI:InitUI()
	self.destroyBonusList = self._tf:Find("frame/bg/scrollview/list")
	self.itemTpl = self.destroyBonusList:Find("item_tpl")

	setText(self._tf:Find("frame/title_text/Text"), i18n("month_sign_resign"))
	onButton(self, self._tf:Find("frame/top/btnBack"), function()
		self:Destroy()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("frame/actions/confirm_btn"), function()
		self:Destroy()

		return
	end, SFX_UI_EQUIPMENT_RESOLVE)

	return
end

function MonthSignReSignUI:setAwardShow(arg_6_1, arg_6_2)
	self.awards = arg_6_1
	self.callback = arg_6_2

	self:displayAwards()

	return
end

function MonthSignReSignUI:OnDestroy()
	self.selectedIds = nil

	if self.callback then
		self.callback()

		self.callback = nil
	end

	self.awards = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function MonthSignReSignUI:displayAwards()
	assert(#self.awards ~= 0, "items数量不能为0")
	removeAllChildren(self.destroyBonusList)

	for iter_8_0 = 1, #self.awards do
		local var_8_0 = cloneTplTo(self.itemTpl, self.destroyBonusList):Find("bg")
		local var_8_1 = self.awards[iter_8_0]

		updateDrop(tf(var_8_0), self.awards[iter_8_0], {
			fromAwardLayer = true
		})
		setActive(findTF(var_8_0, "bonus"), self.awards[iter_8_0].riraty)

		local var_8_2 = findTF(var_8_0, "name")
		local var_8_3 = findTF(var_8_0, "name_mask")
		local var_8_4 = findTF(var_8_0, "name_mask/name"):GetComponent("ScrollText")

		setActive(var_8_2, false)
		setActive(var_8_3, true)
		var_8_4:SetText(self.awards[iter_8_0].name or getText(var_8_2))
		onButton(self, var_8_0, function()
			if self.inAniming then
				return
			end

			self:emit(BaseUI.ON_DROP, var_8_1)

			return
		end, SFX_PANEL)
	end

	return
end

return MonthSignReSignUI
