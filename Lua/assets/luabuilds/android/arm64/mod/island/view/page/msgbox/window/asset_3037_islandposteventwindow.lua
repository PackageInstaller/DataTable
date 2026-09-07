local IslandPostEventWindow = class("IslandPostEventWindow", import(".IslandBaseMsgboxWindow"))

function IslandPostEventWindow:getUIName()
	return "IslandPostEventboxUI"
end

function IslandPostEventWindow:OnLoaded()
	self.titleTxt = self._tf:Find("title/Text"):GetComponent(typeof(Text))
	self.descTxt = self._tf:Find("title/desc"):GetComponent(typeof(Text))
	self.icon = self._tf:Find("title/icon_bg/icon"):GetComponent(typeof(Image))
	self.bigIcon = self._tf:Find("frame/ico"):GetComponent(typeof(Image))
	self.itemsList = UIItemList.New(self._tf:Find("frame/items"), self._tf:Find("frame/items/tpl"))
	self.additionList = UIItemList.New(self._tf:Find("frame/addition"), self._tf:Find("frame/addition/tpl"))
	self.closeBtn = self._tf:Find("frame/btns/close")
	self.openBtn = self._tf:Find("frame/btns/open")

	setText(self._tf:Find("title/event/Text"), i18n("island_post_event_label"))
	setText(self._tf:Find("frame/btns/close/Text"), i18n("island_post_event_close_label"))
	setText(self._tf:Find("frame/btns/open/Text"), i18n("island_post_event_open_label"))
	setText(self._tf:Find("frame/title/Text"), i18n("island_post_event_addition_label"))

	self.animation = self._tf:GetComponent(typeof(Animation))
	self.dftAniEvent = self._tf:GetComponent(typeof(DftAniEvent))

	return
end

function IslandPostEventWindow:OnInit()
	onButton(self, self._tf, function()
		if not self.isSwitch then
			self:Switch()

			return
		end

		triggerButton(self.closeBtn)

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.openBtn, function()
		self:Hide()

		if self.settings.onYes then
			self.settings.onYes()
		end

		return
	end, SFX_PANEL)

	return
end

function IslandPostEventWindow:Switch()
	if self.isAnimating then
		return
	end

	self.isAnimating = true

	self.animation:Play("switch")

	return
end

function IslandPostEventWindow:OnShow()
	self.dftAniEvent:SetEndEvent(function()
		self.isSwitch = true
		self.isAnimating = false

		return
	end)

	self.isSwitch = false
	self.isAnimating = false
	self.config = pg.island_manage_event[self.settings.rest:GetEventInfo()]

	self:UpdateTitle(self.settings.rest)
	self:UpdateMainView(self.settings.rest)

	if not self.settings.isNew then
		triggerButton(self._tf)
	end

	if self.settings.blur then
		self:BlurPanel()
	end

	if self.settings.isNew then
		getProxy(SettingsProxy):RecordIslandRestEvet()
	end

	return
end

function IslandPostEventWindow:BlurPanel()
	self.view.viewComponent:BlurPanel(self.view._tf)

	return
end

function IslandPostEventWindow:UnBlurPanel()
	self.view.viewComponent:UnOverlayPanel(self.view._tf, pg.UIMgr.GetInstance().OverlayMain)

	return
end

function IslandPostEventWindow:UpdateTitle(arg_12_1)
	self.titleTxt.text = self.config.name
	self.descTxt.text = string.gsub(self.config.desc, "$1", arg_12_1:getConfig("name"))
	self.icon.sprite = GetSpriteFromAtlas("ui/islandpostmsgboxui_atlas", "icon" .. self.config.id)

	return
end

function IslandPostEventWindow:UpdateMainView(arg_13_1)
	local var_13_0 = self:WarpItemInfo(arg_13_1)

	self.itemsList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_14_2, (Drop.New({
				count = 0,
				type = DROP_TYPE_ISLAND_ITEM,
				id = var_13_0[arg_14_1 + 1].id
			})))
		end

		return
	end)
	self.itemsList:align(#var_13_0)

	local var_13_1 = self:WarpAdditionInfo()

	self.additionList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			setText(arg_15_2:Find("Text"), var_13_1[arg_15_1 + 1][1])
			setText(arg_15_2:Find("value"), "+" .. var_13_1[arg_15_1 + 1][2] .. "%")
		end

		return
	end)
	self.additionList:align(#var_13_1)
	LoadSpriteAsync("island/islandrestevent/" .. (arg_13_1:getConfig("aera_group") or 1) .. self.config.id, function(arg_16_0)
		if IsNil(self.bigIcon) then
			return
		end

		self.bigIcon.sprite = arg_16_0

		return
	end)

	return
end

function IslandPostEventWindow:WarpItemInfo(arg_17_1)
	local var_17_0 = {}
	local var_17_1, var_17_2 = arg_17_1:GetEventInfo()
	local var_17_3 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	for iter_17_0, iter_17_1 in ipairs(arg_17_1:getConfig("item_id")) do
		local var_17_4 = var_17_3:GetItemById(iter_17_1[1]) or IslandItem.New({
			id = iter_17_1[1]
		})

		if var_17_4 and var_17_2[var_17_4.id] then
			table.insert(var_17_0, var_17_4)
		end
	end

	return var_17_0
end

function IslandPostEventWindow:WarpAdditionInfo()
	local var_18_0 = {}

	table.insert(var_18_0, {
		i18n("island_addition_influence"),
		self.config.influence_bonus
	})
	table.insert(var_18_0, {
		i18n("island_addition_sale"),
		self.config.event_effect[1][1]
	})

	return var_18_0
end

function IslandPostEventWindow:OnHide()
	if self.settings.onHide then
		self.settings.onHide()

		self.settings.onHide = nil
	end

	if self.dftAniEvent then
		self.dftAniEvent:SetEndEvent(nil)
	end

	if self.settings.blur then
		self:UnBlurPanel()
	end

	return
end

return IslandPostEventWindow
