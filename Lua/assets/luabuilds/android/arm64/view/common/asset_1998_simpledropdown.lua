local SimpleDropdown = class("SimpleDropdown", import("view.base.BaseSubView"))

function SimpleDropdown:getUIName()
	return "IndexDropdownUI"
end

function SimpleDropdown:Ctor(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8, arg_2_9)
	SimpleDropdown.super.Ctor(self, arg_2_1, arg_2_2, arg_2_3)

	self.tag = arg_2_4
	self.virtualBtn = arg_2_5
	self.virtualBtnTitle = findTF(self.virtualBtn, "Image")
	self.virtualBtnDropdownSign = findTF(self.virtualBtn, "dropdown")
	self.setting = arg_2_6
	self.options = self.setting.options
	self.names = self.setting.names
	self.isSelected = true
	self.onUpdate = arg_2_7
	self.greySprite = arg_2_8
	self.yellowSprite = arg_2_9

	self:UpdateVirtualBtn()

	return
end

function SimpleDropdown:UpdateVirtualBtn()
	self.preIndex = table.indexof(self.options, self.contextData.indexDatas[self.tag]) or 1

	setText(self.virtualBtnTitle, i18n(self.names[self.preIndex]))
	setImageSprite(self.virtualBtn, (self.preIndex == 1 or nil) and (self.greySprite or self.yellowSprite))

	return
end

function SimpleDropdown:OnInit()
	self.btnTpl = self._tf:Find("resource/tpl")
	self.btnList = {}
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
	GetComponent(self.attrs, typeof(GridLayoutGroup)).constraintCount = 1

	for iter_4_0 = 1, #self.options do
		if iter_4_0 == 1 then
			-- block empty
		else
			local var_4_1 = tf(instantiate(self.btnTpl))
			local var_4_2 = var_4_1:Find("Image")

			go(var_4_1).name = i18n(self.names[iter_4_0])

			setActive(var_4_1, true)
			setActive(var_4_1:Find("dropdown"), false)
			setText(var_4_2, i18n(self.names[iter_4_0]))
			setParent(var_4_1, self.attrs)
			onButton(self, var_4_1, function()
				self:UpdateData(iter_4_0)
				self:UpdateBtnState()

				return
			end, SFX_UI_TAG)
			table.insert(self.btnList, var_4_1)
		end
	end

	self:UpdateVirtualBtn()
	self:SelectLast()

	return
end

function SimpleDropdown:SelectLast()
	self:UpdateBtnState()

	return
end

function SimpleDropdown:UpdateData(arg_9_1)
	self.contextData.indexDatas[self.tag] = self.options[arg_9_1]

	if self.onUpdate then
		self.onUpdate()
	end

	return
end

function SimpleDropdown:UpdateBtnState()
	local function var_10_0(arg_11_0)
		setText(self.mainTitle, i18n(self.names[arg_11_0]))
		setText(self.virtualBtnTitle, i18n(self.names[arg_11_0]))

		return
	end

	local var_10_1 = false

	for iter_10_0, iter_10_1 in ipairs(self.btnList) do
		local var_10_2 = self.options[iter_10_0 + 1] == self.contextData.indexDatas[self.tag]

		setImageSprite(iter_10_1, (self.options[iter_10_0 + 1] == self.contextData.indexDatas[self.tag] or nil) and (self.yellowSprite or self.greySprite))

		if var_10_2 then
			var_10_1 = true

			var_10_0(iter_10_0 + 1)
		end
	end

	if not var_10_1 then
		var_10_0(1)
	end

	return
end

function SimpleDropdown:Show(arg_12_1)
	self.attrs.localPosition = arg_12_1
	self.mainBtn.anchoredPosition = self.attrs.anchoredPosition
	self.attrs.anchoredPosition = self.attrs.anchoredPosition + Vector2.New(0, -45)

	setActive(self._tf, true)
	setActive(self.virtualBtnDropdownSign, false)
	self:UpdateBtnState()

	return
end

function SimpleDropdown:Hide()
	SimpleDropdown.super.Hide(self)
	setActive(self.virtualBtnDropdownSign, true)

	return
end

function SimpleDropdown:OnDestroy()
	self.btnList = nil

	return
end

return SimpleDropdown
