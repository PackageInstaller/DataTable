local SculptureResMsgBoxPage = class("SculptureResMsgBoxPage", import("view.base.BaseSubView"))

function SculptureResMsgBoxPage:getUIName()
	return "SculptureResMsgBoxUI"
end

function SculptureResMsgBoxPage:OnLoaded()
	self.closeBtn = self._tf:Find("frame/close")
	self.icon = self._tf:Find("frame/icon/Image"):GetComponent(typeof(Image))
	self.name = self._tf:Find("frame/name"):GetComponent(typeof(Text))
	self.desc = self._tf:Find("frame/scrollrect/desc"):GetComponent(typeof(Text))
	self.outPut = self._tf:Find("frame/output/Text"):GetComponent(typeof(Text))
	self.goBtn = self._tf:Find("frame/output/btn")

	return
end

function SculptureResMsgBoxPage:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function SculptureResMsgBoxPage:Show(arg_6_1)
	SculptureResMsgBoxPage.super.Show(self)

	self.id = arg_6_1

	self:UpdateView()

	return
end

function SculptureResMsgBoxPage:UpdateView()
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

function SculptureResMsgBoxPage:OnDestroy()
	return
end

return SculptureResMsgBoxPage
