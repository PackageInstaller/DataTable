local DreamlandChatPage = class("DreamlandChatPage", import("view.base.BaseSubView"))

function DreamlandChatPage:getUIName()
	return "DreamlandChatUI"
end

function DreamlandChatPage:Ctor(arg_2_1, arg_2_2, arg_2_3)
	DreamlandChatPage.super.Ctor(self, arg_2_1, arg_2_2, arg_2_3)

	self.uiList = {
		arg_2_1:Find("adapt/time"),
		arg_2_1:Find("adapt/handbook"),
		arg_2_1:Find("adapt/hotspring")
	}
	self.toHideUI = {}

	return
end

function DreamlandChatPage:OnLoaded()
	self.icon = self._tf:Find("icon"):GetComponent(typeof(Image))
	self.content = self._tf:Find("Text"):GetComponent(typeof(Text))

	return
end

function DreamlandChatPage:OnInit()
	onButton(self, self._tf, function()
		if self.clickCnt < self.totlalCnt then
			self:ShowContent()
		else
			self:Hide()
		end

		return
	end, SFX_PANEL)

	return
end

function DreamlandChatPage:Show(arg_6_1)
	DreamlandChatPage.super.Show(self)

	self.clickCnt = 0
	self.textList = _.flatten(arg_6_1.desc)
	self.totlalCnt = #self.textList

	self:ShowContent()

	self.icon.sprite = LoadSprite("exploreObj/icon_" .. self:GetPic(arg_6_1))

	self.icon:SetNativeSize()
	self:HideUI()

	return
end

function DreamlandChatPage:ShowContent()
	self.clickCnt = self.clickCnt + 1
	self.content.text = HXSet.hxLan(self.textList[self.clickCnt] or "")

	return
end

function DreamlandChatPage:HideUI()
	self.toHideUI = {}

	for iter_8_0, iter_8_1 in ipairs(self.uiList) do
		if isActive(iter_8_1) then
			setActive(iter_8_1, false)
			table.insert(self.toHideUI, iter_8_1)
		end
	end

	return
end

function DreamlandChatPage:ShowUI()
	for iter_9_0, iter_9_1 in ipairs(self.toHideUI or {}) do
		if not isActive(iter_9_1) then
			setActive(iter_9_1, true)
		end
	end

	self.toHideUI = {}

	return
end

function DreamlandChatPage:Hide()
	DreamlandChatPage.super.Hide(self)

	self.textList = {}
	self.clickCnt = 0
	self.totlalCnt = 0

	self:ShowUI()

	return
end

function DreamlandChatPage:GetPic(arg_11_1)
	return pg.activity_dreamland_explore[(pg.activity_dreamland_explore.get_id_list_by_group[arg_11_1.group] or {})[1] or arg_11_1.id].pic
end

function DreamlandChatPage:OnDestroy()
	return
end

return DreamlandChatPage
