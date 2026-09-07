local ItemResetPanel = class("ItemResetPanel")

ItemResetPanel.SINGLE = 1
ItemResetPanel.BATCH = 2
ItemResetPanel.INFO = 3
ItemResetPanel.SEE = 4

function ItemResetPanel:Ctor(arg_1_1, arg_1_2)
	pg.DelegateInfo.New(self)

	self._parent = arg_1_2
	self._go = arg_1_1
	self._tf = tf(arg_1_1)

	onButton(self, self._tf:Find("bg"), function()
		self:Close()

		return
	end, SFX_PANEL)
	setActive(self._go, false)

	self.backBtn = self._tf:Find("window/top/btnBack")

	onButton(self, self.backBtn, function()
		self:Close()

		return
	end, SFX_PANEL)

	self.infoPanel = self._tf:Find("window/panel/info")
	self.fromListPanel = self._tf:Find("window/panel/list")
	self.fromItemList = UIItemList.New(self.fromListPanel:Find("view/content"), self.fromListPanel:Find("view/content/item"))

	self.fromItemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		if arg_4_0 == UIItemList.EventUpdate then
			setActive(arg_4_2:Find("from"), self.infoList[arg_4_1])
			setActive(arg_4_2:Find("nothing"), not self.infoList[arg_4_1])

			if self.infoList[arg_4_1] then
				setText(arg_4_2:Find("from/Text"), pg.world_item_data_origin[self.infoList[arg_4_1]].origin_text)
			end
		end

		return
	end)

	return
end

function ItemResetPanel:Open(arg_5_1)
	self.itemVO = WorldItem.New(arg_5_1)

	self:Update(self.itemVO)
	setActive(self._tf, true)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function ItemResetPanel:Close()
	self.itemVO = nil

	setActive(self._tf, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parent)

	return
end

function ItemResetPanel:Update(arg_7_1)
	local var_7_0 = Drop.New({
		type = arg_7_1.type,
		id = arg_7_1.id,
		count = arg_7_1.count
	})
	local var_7_1

	if arg_7_1:getConfig("item_transform_item_type") > 0 then
		var_7_0.count = arg_7_1:getConfig("item_transform_num")
		var_7_1 = Drop.New({
			type = arg_7_1:getConfig("item_transform_item_type"),
			id = arg_7_1:getConfig("item_transform_item_id"),
			count = arg_7_1:getConfig("item_transform_item_number")
		})
	end

	setText(self.infoPanel:Find("top_text"), i18n("world_item_recycle_" .. (var_7_1 and 1 or 2)))
	setText(self.infoPanel:Find("bottom_text"), i18n("world_item_origin"))
	updateDrop(self.infoPanel:Find("before"), var_7_0)
	updateDrop(self.infoPanel:Find("after"), defaultValue(var_7_1, var_7_0))
	setActive(self.infoPanel:Find("after/destroy_mask"), not var_7_1)

	self.infoList = arg_7_1:getConfig("item_origin")

	if #self.infoList == 0 then
		table.insert(self.infoList, 1)
	end

	self.fromItemList:align(math.max(#self.infoList, 3))

	return
end

function ItemResetPanel:Dispose()
	self:Close()
	pg.DelegateInfo.Dispose(self)

	return
end

return ItemResetPanel
