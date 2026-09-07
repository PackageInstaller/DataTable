local FeastResWindow = class("FeastResWindow", import("view.base.BaseSubView"))

function FeastResWindow:getUIName()
	return "FeastResWindow"
end

function FeastResWindow:OnLoaded()
	self.icon = self._tf:Find("frame/item/icon"):GetComponent(typeof(Image))
	self.name = self._tf:Find("frame/name/Text"):GetComponent(typeof(Text))
	self.desc = self._tf:Find("frame/Text"):GetComponent(typeof(Text))
	self.outPut = self._tf:Find("frame/output/Text"):GetComponent(typeof(Text))
	self.goBtn = self._tf:Find("frame/go")

	setText(self.goBtn:Find("Text"), i18n("feast_res_window_go_label"))
	setText(self._tf:Find("frame/title"), i18n("feast_res_window_title"))

	return
end

function FeastResWindow:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function FeastResWindow:Show(arg_5_1)
	FeastResWindow.super.Show(self)

	self.id = arg_5_1

	self:UpdateView()

	return
end

function FeastResWindow:UpdateView()
	self.icon.sprite = LoadSprite("props/" .. pg.activity_workbench_item[self.id].icon)

	self.icon:SetNativeSize()

	self.name.text = pg.activity_workbench_item[self.id].name
	self.desc.text = pg.activity_workbench_item[self.id].display
	self.outPut.text = pg.activity_workbench_item[self.id].get_access[1]

	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.WORKBENCH_ITEM_GO, self.id)

		return
	end, SFX_PANEL)

	return
end

function FeastResWindow:OnDestroy()
	return
end

return FeastResWindow
