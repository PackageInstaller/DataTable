local MetaPTAwardPreviewLayer = class("MetaPTAwardPreviewLayer", import("...base.BaseUI"))

function MetaPTAwardPreviewLayer:getUIName()
	return "MetaPTAwardPreviewUI"
end

function MetaPTAwardPreviewLayer:init()
	self:initUITextTips()
	self:initData()
	self:findUI()
	self:addListener()
	self:initScrollList()

	return
end

function MetaPTAwardPreviewLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:updatePTInfo()
	self:updateScrollList()

	return
end

function MetaPTAwardPreviewLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function MetaPTAwardPreviewLayer:initUITextTips()
	setText(self._tf:Find("Panel/AwardTpl/PointLight/PointTipText"), i18n("meta_pt_point"))
	setText(self._tf:Find("Panel/AwardTpl/PointGray/PointTipText"), i18n("meta_pt_point"))
	setText(self._tf:Find("Panel/AwardTpl/GetText"), i18n("meta_award_get"))
	setText(self._tf:Find("Panel/AwardTpl/GotText"), i18n("meta_award_got"))

	return
end

function MetaPTAwardPreviewLayer:initData()
	self.curMetaProgressVO = self.contextData.metaProgressVO
	self.ptData = self.curMetaProgressVO.metaPtData
	self.itemNum = #self.ptData.dropList

	return
end

function MetaPTAwardPreviewLayer:findUI()
	self.bg = self._tf:Find("BG")

	local var_7_0 = self._tf:Find("Panel")
	local var_7_1 = var_7_0:Find("PT")

	self.ptNumText = var_7_1:Find("NumText")
	self.ptIcon = var_7_1:Find("PTIcon")
	self.scrollViewTF = var_7_0:Find("ScrollView")
	self.awardContainerTF = var_7_0:Find("ScrollView/Viewport/Content")
	self.awardTpl = var_7_0:Find("AwardTpl")

	local var_7_2 = self._tf:Find("NotchAdapt")

	self.nextArrow = var_7_2:Find("NextBtn")
	self.preArrow = var_7_2:Find("PreBtn")
	self.sizeW = GetComponent(self.awardTpl, "LayoutElement").preferredWidth
	self.spaceW = GetComponent(self.awardContainerTF, "HorizontalLayoutGroup").spacing
	self.leftW = GetComponent(self.awardContainerTF, "HorizontalLayoutGroup").padding.left

	return
end

function MetaPTAwardPreviewLayer:addListener()
	onButton(self, self.bg, function()
		self:closeView()

		return
	end, SFX_PANEL)

	return
end

function MetaPTAwardPreviewLayer:initScrollList()
	self.awardUIItemList = UIItemList.New(self.awardContainerTF, self.awardTpl)

	self.awardUIItemList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			self:updateAwardTpl(arg_11_2, arg_11_1 + 1)
		end

		return
	end)

	self.scrollRectSC = self.scrollViewTF:GetComponent("ScrollRect")

	self.scrollRectSC.onValueChanged:AddListener(function(arg_12_0)
		setActive(self.preArrow, arg_12_0.x >= 0.01)
		setActive(self.nextArrow, arg_12_0.x <= 0.99)

		return
	end)

	return
end

function MetaPTAwardPreviewLayer:updateScrollList()
	local var_13_0, var_13_1, var_13_2 = self.curMetaProgressVO.metaPtData:GetLevelProgress()

	self.awardUIItemList:align(var_13_1)
	setLocalPosition(self.awardContainerTF, {
		x = -((var_13_0 - 1) * (self.sizeW + self.spaceW))
	})

	if var_13_0 > 1 then
		setActive(self.preArrow, true)
	end

	return
end

function MetaPTAwardPreviewLayer:updateAwardTpl(arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1:Find("Item")
	local var_14_1 = var_14_0:Find("mask")
	local var_14_2 = var_14_1:Find("Got")
	local var_14_3 = var_14_1:Find("Lock")
	local var_14_4 = arg_14_1:Find("PointLight")
	local var_14_5 = arg_14_1:Find("PointGray")
	local var_14_6 = arg_14_1:Find("GetText")
	local var_14_7 = arg_14_1:Find("GotText")
	local var_14_8 = arg_14_1:Find("LockText")
	local var_14_9 = arg_14_1:Find("LineTpl")
	local var_14_10 = arg_14_1:Find("LineTpl/Light")
	local var_14_11 = arg_14_1:Find("LineTpl/Dark")
	local var_14_12 = {
		type = self.ptData.dropList[arg_14_2][1],
		id = self.ptData.dropList[arg_14_2][2],
		count = self.ptData.dropList[arg_14_2][3]
	}

	updateDrop(var_14_0, var_14_12, {
		hideName = true
	})
	onButton(self, var_14_0, function()
		self:emit(BaseUI.ON_DROP, var_14_12)

		return
	end, SFX_PANEL)
	setText(var_14_4:Find("NumText"), self.ptData.targets[arg_14_2])
	setText(var_14_5:Find("NumText"), self.ptData.targets[arg_14_2])
	setText(var_14_8, "PHASE " .. calcFloor(self.ptData.targets[arg_14_2] / self.curMetaProgressVO.unlockPTNum * 100) .. "%")

	if arg_14_2 < self.ptData.level + 1 then
		setActive(var_14_1, true)
		setActive(var_14_2, true)
		setActive(var_14_3, false)
		setActive(var_14_4, false)
		setActive(var_14_5, true)
		setActive(var_14_10, false)
		setActive(var_14_11, true)
		setActive(var_14_6, false)
		setActive(var_14_7, true)
		setActive(var_14_8, false)
	elseif self.ptData.targets[arg_14_2] > self.ptData.count then
		setActive(var_14_1, true)
		setActive(var_14_2, false)
		setActive(var_14_3, true)
		setActive(var_14_4, false)
		setActive(var_14_5, true)
		setActive(var_14_10, false)
		setActive(var_14_11, true)
		setActive(var_14_6, false)
		setActive(var_14_7, false)
		setActive(var_14_8, true)
	else
		setActive(var_14_1, false)
		setActive(var_14_2, false)
		setActive(var_14_3, false)
		setActive(var_14_4, true)
		setActive(var_14_5, false)
		setActive(var_14_10, true)
		setActive(var_14_11, false)
		setActive(var_14_6, true)
		setActive(var_14_7, false)
		setActive(var_14_8, false)
	end

	if arg_14_2 == 1 then
		setActive(var_14_9, false)
	end

	return
end

function MetaPTAwardPreviewLayer:updatePTInfo()
	setImageSprite(self.ptIcon, LoadSprite(self.curMetaProgressVO:getPtIconPath()))
	setText(self.ptNumText, self.ptData.count)

	return
end

return MetaPTAwardPreviewLayer
