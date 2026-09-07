local IslandInventoryIndexPage = class("IslandInventoryIndexPage", import("...base.IslandBasePage"))

function IslandInventoryIndexPage:getUIName()
	return "IslandInventoryIndexUI"
end

function IslandInventoryIndexPage:OnLoaded()
	self.uiItemList = UIItemList.New(self._tf:Find("frame/list"), self._tf:Find("frame/list/tpl"))
	self.closeBtn = self._tf:Find("frame/top/close_btn")
	self.cancelBtn = self._tf:Find("frame/button_list/cancel")
	self.confirmBtn = self._tf:Find("frame/button_list/confirm")

	setText(self._tf:Find("frame/top/title"), i18n("child_filter_title"))
	setText(self.cancelBtn:Find("Text"), i18n("island_word_reset"))
	setText(self.confirmBtn:Find("Text"), i18n("word_ok"))

	return
end

function IslandInventoryIndexPage:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:ResetData()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		self:emit(IslandScene.ON_INVENTORY_FILTER, self.values)
		self:Hide()

		return
	end, SFX_PANEL)

	self.btns = {}

	return
end

function IslandInventoryIndexPage:Show(arg_8_1)
	IslandInventoryIndexPage.super.Show(self)
	assert(arg_8_1)

	self.values = arg_8_1:GetData()

	self:Flush((arg_8_1:GetLayoutData()))

	return
end

function IslandInventoryIndexPage:Flush(arg_9_1)
	self.uiItemList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			table.insert(self.btns, (self:InitLayout(arg_9_1[arg_10_1 + 1], arg_10_1 + 1, arg_10_2)))
		end

		return
	end)
	self.uiItemList:align(#arg_9_1)

	return
end

function IslandInventoryIndexPage:InitLayout(arg_11_1, arg_11_2, arg_11_3)
	setText(arg_11_3:Find("title/title"), arg_11_1.title)

	local var_11_0 = UIItemList.New(arg_11_3:Find("buttons"), arg_11_3:Find("buttons/tpl"))
	local var_11_1 = {}

	var_11_0:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			setText(arg_12_2:Find("Text"), arg_11_1.names[arg_12_1 + 1])
			setText(arg_12_2:Find("mark/Text"), arg_11_1.names[arg_12_1 + 1])
			setActive(arg_12_2:Find("line"), (not (arg_12_1 > 0) or arg_12_1 % 4 ~= 0) and arg_12_1 + 1 ~= #arg_11_1.list)

			local var_12_0 = arg_11_1.list[arg_12_1 + 1]
			local var_12_1 = arg_12_1 == 0

			onButton(self, arg_12_2, function()
				local var_13_0 = self.values[arg_11_2]

				var_13_0 = arg_11_1.mode == IslandInventoryIndexData.MODE_SINGLE and var_12_0 or self:HandleMultiClick(var_12_0, var_13_0, IslandInventoryIndexData.CheckSelectedAll(arg_11_1.list, var_13_0), var_12_1, arg_11_1.list[1])

				self:FlushBtns(var_11_1, arg_11_1.list, var_13_0, arg_11_1.mode)

				self.values[arg_11_2] = var_13_0

				return
			end, SFX_PANEL)
			table.insert(var_11_1, {
				mark = arg_12_2:Find("trigger"),
				isAll = var_12_1
			})
		end

		return
	end)
	var_11_0:align(#arg_11_1.list)
	self:FlushBtns(var_11_1, arg_11_1.list, self.values[arg_11_2], arg_11_1.mode)

	return var_11_1
end

function IslandInventoryIndexPage:HandleMultiClick(arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	if arg_14_3 and arg_14_1 == arg_14_2 then
		-- block empty
	else
		arg_14_2 = arg_14_3 and arg_14_1 ~= arg_14_2 and arg_14_1 or arg_14_4 and arg_14_5 or bit.band(arg_14_2, arg_14_1) > 0 and bit.bxor(arg_14_2, arg_14_1) or bit.bor(arg_14_2, arg_14_1)
	end

	arg_14_2 = arg_14_2 ~= 0 and arg_14_2 or arg_14_5

	return arg_14_2
end

function IslandInventoryIndexPage:FlushBtns(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	if arg_15_4 == IslandInventoryIndexData.MODE_SINGLE then
		for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
			triggerToggle(iter_15_1.mark, bit.band(arg_15_2[iter_15_0], arg_15_3) > 0)
		end
	elseif arg_15_4 == IslandInventoryIndexData.MODE_MULTI then
		if IslandInventoryIndexData.CheckSelectedAll(arg_15_2, arg_15_3) then
			for iter_15_2, iter_15_3 in ipairs(arg_15_1) do
				triggerToggle(iter_15_3.mark, iter_15_3.isAll)
			end
		else
			for iter_15_4, iter_15_5 in ipairs(arg_15_1) do
				triggerToggle(iter_15_5.mark, not iter_15_5.isAll and bit.band(arg_15_2[iter_15_4], arg_15_3) > 0)
			end
		end
	end

	return
end

function IslandInventoryIndexPage:ResetData()
	for iter_16_0, iter_16_1 in ipairs(self.btns) do
		for iter_16_2, iter_16_3 in ipairs(iter_16_1) do
			if iter_16_3.isAll then
				triggerButton(iter_16_3.mark.parent)
			end
		end
	end

	return
end

function IslandInventoryIndexPage:OnDestroy()
	return
end

return IslandInventoryIndexPage
