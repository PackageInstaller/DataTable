local CustomIndexLayer = class("CustomIndexLayer", import("..base.BaseUI"))

function CustomIndexLayer:getUIName()
	return "CustomIndexUI"
end

CustomIndexLayer.Mode = {
	OR = 2,
	AND = 1,
	NUM = 3
}

function CustomIndexLayer:init()
	self.panel = self._tf:Find("index_panel")
	self.layout = self.panel:Find("layout")
	self.contianer = self.layout:Find("container")

	eachChild(self.contianer, function(arg_3_0)
		setActive(arg_3_0, false)

		return
	end)

	self.panelTemplate = self.layout:Find("container/Template")
	self.displayList = {}
	self.typeList = {}
	self.btnConfirm = self.panel:Find("layout/btns/ok")
	self.btnCancel = self.panel:Find("layout/btns/cancel")

	setText(self.btnConfirm:Find("Image"), i18n("text_confirm"))
	setText(self.btnCancel:Find("Image"), i18n("text_cancel"))

	self.greySprite = self.panel:Find("resource/grey"):GetComponent(typeof(Image)).sprite
	self.blueSprite = self.panel:Find("resource/blue"):GetComponent(typeof(Image)).sprite
	self.yellowSprite = self.panel:Find("resource/yellow"):GetComponent(typeof(Image)).sprite

	return
end

function CustomIndexLayer:didEnter()
	onButton(self, self.btnConfirm, function()
		if self.contextData.callback then
			self.contextData.callback(self.contextData.indexDatas)

			self.contextData.callback = nil
		end

		self:emit(CustomIndexLayer.ON_CLOSE)

		return
	end, SFX_CONFIRM)
	onButton(self, self.btnCancel, function()
		self:emit(CustomIndexLayer.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(self, self.panel:Find("btn"), function()
		self:emit(CustomIndexLayer.ON_CLOSE)

		return
	end, SFX_CANCEL)
	self:DoEnterAnimation()
	setText(self.panel:Find("layout/tip"), self.contextData.tip or "")
	self:InitGroup()
	self:BlurPanel()

	return
end

function CustomIndexLayer:DoEnterAnimation()
	self.panel.localScale = Vector3.zero

	LeanTween.scale(self.panel, Vector3(1, 1, 1), 0.2)

	return
end

function CustomIndexLayer:BlurPanel()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function CustomIndexLayer:InitGroup()
	self.onInit = true
	self.contextData.indexDatas = self.contextData.indexDatas or {}
	self.dropdownDic = {}
	self.updateList = {}
	self.simpleDropdownDic = {}

	for iter_10_0, iter_10_1 in pairs(self.contextData.groupList) do
		if iter_10_1.dropdown then
			self:InitDropdown(iter_10_1)
		else
			self:InitCustoms(iter_10_1)
		end
	end

	for iter_10_2, iter_10_3 in ipairs(self.updateList) do
		iter_10_3()
	end

	if self.contextData.customPanels.minHeight then
		GetOrAddComponent(self.layout, typeof(LayoutElement)).minHeight = self.contextData.customPanels.minHeight
	end

	if self.contextData.customPanels.layoutPos then
		setLocalPosition(self.layout, self.contextData.customPanels.layoutPos)
	end

	self.onInit = false

	return
end

function CustomIndexLayer:InitDropdown(arg_11_1)
	local var_11_0 = tf(Instantiate(self.panelTemplate))

	setParent(var_11_0, self.contianer, false)
	setActive(var_11_0, true)

	local var_11_1 = CustomIndexLayer.Clone2Full(var_11_0:Find("bg"), #arg_11_1.tags)

	go(var_11_0).name = arg_11_1.titleTxt

	setText(var_11_0:Find("title/Image"), i18n(arg_11_1.titleTxt))
	setText(var_11_0:Find("title/Image/Image_en"), i18n(arg_11_1.titleENTxt))

	var_11_0:Find("bg"):GetComponent(typeof(ScrollRect)).enabled = false

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.tags) do
		local var_11_2 = var_11_1[iter_11_0]

		setActive(var_11_1[iter_11_0]:Find("dropdown"), true)

		local var_11_3 = CustomDropdown.New(self.panel, self.event, self.contextData, iter_11_1, var_11_1[iter_11_0])

		onButton(self, var_11_1[iter_11_0], function()
			if not var_11_3:GetLoaded() then
				var_11_3:Load()
			end

			var_11_3:ActionInvoke("Show", (self.panel:InverseTransformPoint(var_11_2.position)))

			return
		end)

		self.dropdownDic[iter_11_1] = var_11_3
	end

	return
end

function CustomIndexLayer:InitCustoms(arg_13_1)
	local var_13_0 = arg_13_1.tags[1]
	local var_13_1 = self.contextData.customPanels[arg_13_1.tags[1]]
	local var_13_2 = tf(Instantiate(self.panelTemplate))

	setParent(var_13_2, self.contianer, false)
	setActive(var_13_2, true)

	go(var_13_2).name = arg_13_1.titleTxt

	setText(var_13_2:Find("title/Image"), i18n(arg_13_1.titleTxt))
	setText(var_13_2:Find("title/Image/Image_en"), i18n(arg_13_1.titleENTxt))

	var_13_2:Find("bg"):GetComponent(typeof(ScrollRect)).enabled = false

	local var_13_3 = var_13_1.options
	local var_13_4 = var_13_1.mode or CustomIndexLayer.Mode.OR
	local var_13_5 = 0

	if var_13_1.blueSeleted then
		local var_13_6 = self.blueSprite or self.yellowSprite
	end

	for iter_13_0, iter_13_1 in ipairs(var_13_3) do
		var_13_5 = bit.bor(iter_13_1, var_13_5)
	end

	self.contextData.indexDatas[var_13_0] = self.contextData.indexDatas[var_13_0] or var_13_3[1]

	local var_13_7
	local var_13_8 = CustomIndexLayer.Clone2Full(var_13_2:Find("bg"), #var_13_3)

	for iter_13_2, iter_13_3 in ipairs(var_13_8) do
		local var_13_9 = var_13_3[iter_13_2]

		setText(findTF(iter_13_3, "Image"), i18n(var_13_1.names[iter_13_2]))
		self:UpdateBtnStyle(iter_13_3, self.greySprite)
		onButton(self, iter_13_3, function()
			switch(var_13_4, {
				[CustomIndexLayer.Mode.AND] = function()
					self.contextData.indexDatas[var_13_0] = (iter_13_2 == 1 or self.contextData.indexDatas[var_13_0] == var_13_3[1]) and var_13_9 or bit.bxor(self.contextData.indexDatas[var_13_0], var_13_9)

					if self.contextData.indexDatas[var_13_0] == 0 or self.contextData.indexDatas[var_13_0] == var_13_5 then
						self.contextData.indexDatas[var_13_0] = var_13_3[1]
					end

					return
				end,
				[CustomIndexLayer.Mode.OR] = function()
					if var_13_1.isSort then
						self.contextData.indexDatas[var_13_0] = var_13_9
					elseif var_13_9 == self.contextData.indexDatas[var_13_0] then
						self.contextData.indexDatas[var_13_0] = var_13_3[1] or var_13_9
					end

					return
				end,
				[CustomIndexLayer.Mode.NUM] = function()
					local var_17_0 = 0

					while self.contextData.indexDatas[var_13_0] > 0 do
						var_17_0 = var_17_0 + 1

						local var_17_1 = bit.band(self.contextData.indexDatas[var_13_0], self.contextData.indexDatas[var_13_0] - 1)
					end

					if var_17_0 < var_13_1.num or bit.band(self.contextData.indexDatas[var_13_0], var_13_9) > 0 then
						self.contextData.indexDatas[var_13_0] = bit.bxor(self.contextData.indexDatas[var_13_0], var_13_9)
					else
						pg.TipsMgr.GetInstance():ShowTips(i18n("equipcode_share_exceedlimit"))
					end

					return
				end
			})
			var_13_7()

			return
		end, SFX_UI_TAG)
	end

	function var_13_7()
		switch(var_13_4, {
			[CustomIndexLayer.Mode.AND] = function()
				if self.contextData.indexDatas[var_13_0] == var_13_3[1] then
					for iter_19_0, iter_19_1 in ipairs(var_13_8) do
						local var_19_0 = findTF(iter_19_1, "Image")

						self:UpdateBtnStyle(iter_19_1, (var_13_3[iter_19_0] == var_13_3[1] or nil) and (var_13_6 or self.greySprite))
					end
				else
					for iter_19_2, iter_19_3 in ipairs(var_13_8) do
						local var_19_1 = findTF(iter_19_3, "Image")

						self:UpdateBtnStyle(iter_19_3, (var_13_3[iter_19_2] ~= var_13_3[1] and bit.band(self.contextData.indexDatas[var_13_0], var_13_3[iter_19_2]) > 0 or nil) and (var_13_6 or self.greySprite))
					end
				end

				return
			end,
			[CustomIndexLayer.Mode.OR] = function()
				for iter_20_0, iter_20_1 in ipairs(var_13_8) do
					local var_20_0 = findTF(iter_20_1, "Image")

					self:UpdateBtnStyle(iter_20_1, (var_13_3[iter_20_0] == self.contextData.indexDatas[var_13_0] or nil) and (var_13_6 or self.greySprite))
				end

				return
			end,
			[CustomIndexLayer.Mode.NUM] = function()
				for iter_21_0, iter_21_1 in ipairs(var_13_8) do
					local var_21_0 = findTF(iter_21_1, "Image")

					self:UpdateBtnStyle(iter_21_1, (bit.band(self.contextData.indexDatas[var_13_0], var_13_3[iter_21_0]) > 0 or nil) and (var_13_6 or self.greySprite))
				end

				return
			end
		})
		self:OnDatasChange(var_13_0)

		if self.simpleDropdownDic[var_13_0] then
			for iter_18_0, iter_18_1 in pairs(self.simpleDropdownDic[var_13_0]) do
				iter_18_1:UpdateVirtualBtn()
			end
		end

		return
	end

	table.insert(self.updateList, var_13_7)

	if arg_13_1.simpleDropdown then
		assert(var_13_4 == CustomIndexLayer.Mode.OR, "simpleDropdown目前只支持OR模式")

		local var_13_10 = var_13_2:Find("bg"):GetChild(0)

		for iter_13_4, iter_13_5 in ipairs(arg_13_1.simpleDropdown) do
			local var_13_11 = cloneTplTo(var_13_10, var_13_2:Find("bg"))

			var_13_11.name = iter_13_5 .. "_simple"

			local var_13_12 = SimpleDropdown.New(self.panel, self.event, self.contextData, var_13_0, var_13_11, self.contextData.customPanels[iter_13_5], var_13_7, self.greySprite, self.yellowSprite)

			setActive(var_13_11:Find("dropdown"), true)
			onButton(self, var_13_11, function()
				if not var_13_12:GetLoaded() then
					var_13_12:Load()
				end

				var_13_12:ActionInvoke("Show", (self.panel:InverseTransformPoint(var_13_11.position)))

				return
			end)

			self.simpleDropdownDic[var_13_0] = self.simpleDropdownDic[var_13_0] or {}
			self.simpleDropdownDic[var_13_0][iter_13_5] = var_13_12
		end
	end

	return
end

function CustomIndexLayer:UpdateBtnStyle(arg_23_1, arg_23_2)
	setImageSprite(arg_23_1, arg_23_2)

	return
end

function CustomIndexLayer:OnDatasChange(arg_24_1)
	local var_24_0 = self.contextData.dropdownLimit or {}

	for iter_24_0, iter_24_1 in pairs(self.dropdownDic) do
		if var_24_0[iter_24_0] ~= nil then
			if var_24_0[iter_24_0].exclude[arg_24_1] ~= nil or var_24_0[iter_24_0].include[arg_24_1] ~= nil then
				local var_24_1 = self.contextData.indexDatas[arg_24_1]
				local var_24_2 = false

				if var_24_0[iter_24_0].exclude[arg_24_1] ~= nil and var_24_1 == var_24_0[iter_24_0].exclude[arg_24_1] then
					var_24_2 = false
				elseif var_24_0[iter_24_0].include[arg_24_1] ~= nil then
					var_24_2 = bit.band(var_24_1, var_24_0[iter_24_0].include[arg_24_1]) > 0
				end

				setActive(self.dropdownDic[iter_24_0].virtualBtn, var_24_2)

				if not self.onInit then
					self.contextData.indexDatas[iter_24_0] = self.contextData.customPanels[iter_24_0].options[1]
				end

				self.dropdownDic[iter_24_0]:UpdateVirtualBtn()
				self.dropdownDic[iter_24_0]:ActionInvoke("SelectLast")
			end
		end
	end

	return
end

function CustomIndexLayer:willExit()
	LeanTween.cancel(go(self.panel))

	for iter_25_0, iter_25_1 in pairs(self.dropdownDic) do
		iter_25_1:Destroy()
	end

	for iter_25_2, iter_25_3 in pairs(self.simpleDropdownDic) do
		for iter_25_4, iter_25_5 in pairs(iter_25_3) do
			iter_25_5:Destroy()
		end
	end

	self.updateList = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function CustomIndexLayer:Clone2Full(arg_26_1)
	local var_26_0 = {}
	local var_26_1 = self:GetChild(0)

	for iter_26_0 = 0, self.childCount - 1 do
		table.insert(var_26_0, self:GetChild(iter_26_0))
	end

	for iter_26_1 = self.childCount, arg_26_1 - 1 do
		local var_26_2 = cloneTplTo(var_26_1, self)

		var_26_2.name = iter_26_1

		table.insert(var_26_0, tf(var_26_2))
	end

	for iter_26_2 = 0, self.childCount - 1 do
		setActive(self:GetChild(iter_26_2), iter_26_2 < arg_26_1)
	end

	for iter_26_3 = self.childCount, arg_26_1 + 1, -1 do
		table.remove(var_26_0)
	end

	return var_26_0
end

return CustomIndexLayer
