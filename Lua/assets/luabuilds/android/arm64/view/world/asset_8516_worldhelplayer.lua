local WorldHelpLayer = class("WorldHelpLayer", import("view.base.BaseUI"))

function WorldHelpLayer:getUIName()
	return "WorldHelpUI"
end

function WorldHelpLayer:init()
	self.rtTitle = self._tf:Find("title")
	self.btnBack = self.rtTitle:Find("btn_back")

	onButton(self, self.btnBack, function()
		self:closeView()

		return
	end, SFX_CANCEL)

	self.groupList = UIItemList.New(self.rtTitle:Find("toggles"), self.rtTitle:Find("toggles/toggle"))

	self.groupList:make(function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = self.titles[arg_4_1]

			setText(arg_4_2:Find("Text"), pg.world_help_data[self.titles[arg_4_1]].name)
			onToggle(self, arg_4_2, function(arg_5_0)
				if arg_5_0 then
					if self.curGroupId ~= var_4_0 then
						self:toggleAnim(arg_4_2, true)
						self:setCurGroup(var_4_0)
					end
				else
					self:toggleAnim(arg_4_2, false)
				end

				return
			end, SFX_PANEL)
		end

		return
	end)

	self.rtMain = self._tf:Find("main")
	self.rtScroll = self.rtMain:Find("Scroll")

	onButton(self, self.rtMain:Find("left"), function()
		if LeanTween.isTweening(go(self.rtScroll)) then
			return
		end

		if self.curPageIndex > 1 then
			local var_6_0 = {}

			table.insert(var_6_0, function(arg_7_0)
				self:pageAnim(false, arg_7_0)

				return
			end)
			table.insert(var_6_0, function(arg_8_0)
				self:setCurPage(self.curPageIndex - 1)
				arg_8_0()

				return
			end)
			table.insert(var_6_0, function(arg_9_0)
				self:pageAnim(true, arg_9_0)

				return
			end)
			seriesAsync(var_6_0, function()
				return
			end)
		end

		return
	end)
	onButton(self, self.rtMain:Find("right"), function()
		if LeanTween.isTweening(go(self.rtScroll)) then
			return
		end

		if self.curPageIndex < #self.pageList then
			local var_11_0 = {}

			table.insert(var_11_0, function(arg_12_0)
				self:pageAnim(false, arg_12_0)

				return
			end)
			table.insert(var_11_0, function(arg_13_0)
				self:setCurPage(self.curPageIndex + 1)
				arg_13_0()

				return
			end)
			table.insert(var_11_0, function(arg_14_0)
				self:pageAnim(true, arg_14_0)

				return
			end)
			seriesAsync(var_11_0, function()
				return
			end)
		end

		return
	end)

	return
end

function WorldHelpLayer:setCurGroup(arg_16_1)
	local var_16_0 = {}

	if self.curGroupId then
		table.insert(var_16_0, function(arg_17_0)
			self:pageAnim(false, arg_17_0)

			return
		end)
	end

	self.curGroupId = arg_16_1

	table.insert(var_16_0, function(arg_18_0)
		self.pageList = {}

		local var_18_0 = nowWorld():GetProgress()

		for iter_18_0, iter_18_1 in ipairs(pg.world_help_data[self.curGroupId].stage_help) do
			if var_18_0 >= iter_18_1[1] then
				table.insert(self.pageList, {
					id = iter_18_0,
					path = iter_18_1[2]
				})
			end
		end

		if #self.pageList > 0 then
			self:setCurPage(1)
		end

		arg_18_0()

		return
	end)
	seriesAsync(var_16_0, function()
		self:pageAnim(true)

		return
	end)

	return
end

function WorldHelpLayer:setCurPage(arg_20_1)
	self.curPageIndex = arg_20_1

	setText(self.rtMain:Find("page/Text"), self.curPageIndex .. "/" .. #self.pageList)

	local var_20_0 = self.rtScroll:Find("Card")

	setImageAlpha(var_20_0:Find("Image"), 0)
	GetSpriteFromAtlasAsync(self.pageList[arg_20_1].path, "", function(arg_21_0)
		if self.curPageIndex == arg_20_1 then
			setImageSprite(var_20_0:Find("Image"), arg_21_0)
			setImageAlpha(var_20_0:Find("Image"), 1)
		end

		return
	end)

	return
end

function WorldHelpLayer:getPageIndex(arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(self.pageList) do
		if iter_22_1.id == arg_22_1 then
			return iter_22_0
		end
	end

	return 1
end

function WorldHelpLayer:pageAnim(arg_23_1, arg_23_2)
	LeanTween.cancel(go(self.rtScroll))

	local var_23_0 = GetOrAddComponent(self.rtScroll, "CanvasGroup")

	var_23_0.alpha = arg_23_1 and 0 or 1

	LeanTween.alphaCanvas(var_23_0, arg_23_1 and 1 or 0, 0.3):setOnComplete(System.Action(function()
		return existCall(arg_23_2)
	end))

	return
end

function WorldHelpLayer:toggleAnim(arg_25_1, arg_25_2)
	LeanTween.cancel(arg_25_1.gameObject)

	local var_25_0 = GetComponent(arg_25_1, typeof(LayoutElement))

	if arg_25_2 then
		LeanTween.value(arg_25_1.gameObject, var_25_0.preferredWidth, 238, 0.15):setOnUpdate(System.Action_float(function(arg_26_0)
			var_25_0.preferredWidth = arg_26_0

			return
		end)):setOnComplete(System.Action(function()
			setActive(arg_25_1:Find("selected"), arg_25_2)

			return
		end))
	else
		setActive(arg_25_1:Find("selected"), arg_25_2)
		LeanTween.value(arg_25_1.gameObject, var_25_0.preferredWidth, 176, 0.15):setOnUpdate(System.Action_float(function(arg_28_0)
			var_25_0.preferredWidth = arg_28_0

			return
		end))
	end

	return
end

function WorldHelpLayer:didEnter()
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	local var_29_0

	self.titles = {}

	local var_29_1 = nowWorld():GetProgress()

	for iter_29_0, iter_29_1 in ipairs(pg.world_help_data.all) do
		if var_29_1 >= pg.world_help_data[iter_29_1].stage then
			table.insert(self.titles, iter_29_1)

			if self.contextData.titleId == iter_29_1 then
				var_29_0 = #self.titles
			end
		end
	end

	self.groupList:align(#self.titles)
	setActive(self.rtScroll, #self.titles > 0)

	if #self.titles > 0 then
		if var_29_0 then
			triggerToggle(self.groupList.container:GetChild(var_29_0 - 1), true)
			self:setCurPage(self:getPageIndex(self.contextData.pageId))
		else
			triggerToggle(self.groupList.container:GetChild(0), true)
		end
	end

	return
end

function WorldHelpLayer:willExit()
	LeanTween.cancel(go(self.rtScroll))
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return WorldHelpLayer
