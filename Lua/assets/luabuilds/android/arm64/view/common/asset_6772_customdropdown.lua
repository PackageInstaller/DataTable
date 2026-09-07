local CustomDropdown = class("CustomDropdown", import("view.base.BaseSubView"))

function CustomDropdown:getUIName()
	return "IndexDropdownUI"
end

function CustomDropdown:Ctor(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	CustomDropdown.super.Ctor(self, arg_2_1, arg_2_2, arg_2_3)

	self.tag = arg_2_4
	self.virtualBtn = arg_2_5
	self.virtualBtnTitle = findTF(self.virtualBtn, "Image")
	self.virtualBtnDropdownSign = findTF(self.virtualBtn, "dropdown")
	self.setting = self.contextData.customPanels[self.tag]
	self.mode = self.setting.mode or CustomIndexLayer.Mode.OR
	self.options = self.setting.options
	self.names = self.setting.names

	self:UpdateVirtualBtn()

	return
end

function CustomDropdown:UpdateVirtualBtn()
	self.contextData.indexDatas[self.tag] = self.contextData.indexDatas[self.tag] or self.options[1]
	self.preIndex = table.indexof(self.options, self.contextData.indexDatas[self.tag])

	setText(self.virtualBtnTitle, i18n(self.names[self.preIndex]))

	return
end

function CustomDropdown:OnInit()
	self.btnTpl = self._tf:Find("resource/tpl")
	self.btnList = {}
	self.greySprite = self._tf:Find("resource/grey"):GetComponent(typeof(Image)).sprite
	self.yellowSprite = self._tf:Find("resource/yellow"):GetComponent(typeof(Image)).sprite
	self.mainBtn = tf(instantiate(self.btnTpl))
	self.mainTitle = self.mainBtn:Find("Image")

	setImageSprite(self.mainBtn, self.yellowSprite)
	setParent(self.mainBtn, self._tf)
	setActive(self.mainBtn, true)

	self.mainBtn:Find("dropdown").localEulerAngles = Vector3.New(0, 0, 0)

	onButton(self, self.mainBtn, function()
		self:Hide()

		return
	end)
	onButton(self, self._tf:Find("mask"), function()
		self:Hide()

		return
	end)

	self.attrs = self._tf:Find("Attrs")
	GetComponent(self.attrs, typeof(GridLayoutGroup)).constraintCount = #self.options > 6 and 2 or 1

	for iter_4_0 = 1, #self.options do
		if iter_4_0 == 1 then
			-- block empty
		else
			local var_4_2 = tf(instantiate(self.btnTpl))
			local var_4_3 = var_4_2:Find("Image")

			go(var_4_2).name = i18n(self.names[iter_4_0])

			setActive(var_4_2, true)
			setActive(var_4_2:Find("dropdown"), false)
			setText(var_4_3, i18n(self.names[iter_4_0]))
			setParent(var_4_2, self.attrs)
			onButton(self, var_4_2, function()
				self:UpdateData(iter_4_0)
				self:UpdateBtnState()

				return
			end, SFX_UI_TAG)
			table.insert(self.btnList, var_4_2)
		end
	end

	self:SelectLast()

	return
end

function CustomDropdown:SelectLast()
	self:UpdateBtnState()

	return
end

function CustomDropdown:UpdateData(arg_9_1)
	local var_9_0 = self.contextData.indexDatas[self.tag]
	local var_9_1 = bit.band(self.contextData.indexDatas[self.tag], self.options[arg_9_1]) > 0

	if self.mode == CustomIndexLayer.Mode.AND then
		self.contextData.indexDatas[self.tag] = var_9_1 and var_9_0 - self.options[arg_9_1] or bit.bxor(var_9_0, self.options[arg_9_1])
	elseif self.mode == CustomIndexLayer.Mode.OR then
		self.contextData.indexDatas[self.tag] = var_9_0 ~= self.options[1] and var_9_1 and var_9_0 - self.options[arg_9_1] or self.options[arg_9_1]

		if self.contextData.indexDatas[self.tag] == 0 then
			self.contextData.indexDatas[self.tag] = self.options[1]
		end
	end

	return
end

function CustomDropdown:UpdateBtnState()
	local function var_10_0(arg_11_0)
		setText(self.mainTitle, i18n(self.names[arg_11_0]))
		setText(self.virtualBtnTitle, i18n(self.names[arg_11_0]))

		return
	end

	if self.mode == CustomIndexLayer.Mode.AND then
		if self.contextData.indexDatas[self.tag] == self.options[1] then
			for iter_10_0, iter_10_1 in ipairs(self.btnList) do
				setImageSprite(iter_10_1, self.greySprite)
			end
		else
			for iter_10_2, iter_10_3 in ipairs(self.btnList) do
				setImageSprite(iter_10_3, (bit.band(self.contextData.indexDatas[self.tag], self.options[iter_10_2 + 1]) > 0 or nil) and (self.yellowSprite or self.greySprite))
			end
		end

		var_10_0(1)
	elseif self.mode == CustomIndexLayer.Mode.OR then
		local var_10_3 = false

		for iter_10_4, iter_10_5 in ipairs(self.btnList) do
			local var_10_4 = self.options[iter_10_4 + 1] == self.contextData.indexDatas[self.tag]

			setImageSprite(iter_10_5, (self.options[iter_10_4 + 1] == self.contextData.indexDatas[self.tag] or nil) and (self.yellowSprite or self.greySprite))

			if var_10_4 then
				var_10_3 = true

				var_10_0(iter_10_4 + 1)
			end
		end

		if not var_10_3 then
			var_10_0(1)
		end
	end

	return
end

function CustomDropdown:Show(arg_12_1)
	self.attrs.localPosition = arg_12_1
	self.mainBtn.anchoredPosition = self.attrs.anchoredPosition
	self.attrs.anchoredPosition = self.attrs.anchoredPosition + Vector2.New(0, -45)

	setActive(self._tf, true)
	setActive(self.virtualBtnDropdownSign, false)

	return
end

function CustomDropdown:Hide()
	CustomDropdown.super.Hide(self)
	setActive(self.virtualBtnDropdownSign, true)

	return
end

function CustomDropdown:OnDestroy()
	self.btnList = nil

	return
end

return CustomDropdown
