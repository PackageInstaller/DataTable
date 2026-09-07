local AllBuffDetailLayer = class("AllBuffDetailLayer", import("..base.BaseUI"))

function AllBuffDetailLayer:getUIName()
	return "TechnologyTreeAllBuffUI"
end

function AllBuffDetailLayer:init()
	self:initData()
	self:findUI()

	return
end

function AllBuffDetailLayer:didEnter()
	self:BlurPanel(self._tf)
	self:addListener()
	self:updateDetail()

	return
end

function AllBuffDetailLayer:willExit()
	self:UnOverlayPanel(self._tf)

	return
end

function AllBuffDetailLayer:initData()
	self.technologyNationProxy = getProxy(TechnologyNationProxy)
	self.tecList = self.technologyNationProxy:GetTecList()
	self.typeAttrTable, self.typeOrder, self.typeAttrOrderTable = self.technologyNationProxy:getTecBuff()
	self.typeOrder = ShipType.FilterOverQuZhuType(self.typeOrder)

	return
end

function AllBuffDetailLayer:findUI()
	self.backBtn = self._tf:Find("BG")
	self.scrollView = self._tf:Find("Scroll View")
	self.viewport = self.scrollView:Find("Viewport")
	self.typeContainer = self.viewport:Find("Content")
	self.typeItemTpl = self._tf:Find("TypeItemTpl")
	self.buffItemTpl = self._tf:Find("BuffItemTpl")
	self.scrollViewGroupCom = GetComponent(self.scrollView, "VerticalLayoutGroup")
	self.scrollViewFitterCom = GetComponent(self.scrollView, "ContentSizeFitter")
	self.viewportGroupCom = GetComponent(self.viewport, "VerticalLayoutGroup")
	self.viewportFitterCom = GetComponent(self.viewport, "ContentSizeFitter")
	self.setValueBtn = self._tf:Find("Scroll View/bg/SetValueBtn")

	return
end

function AllBuffDetailLayer:onBackPressed()
	triggerButton(self.backBtn)

	return
end

function AllBuffDetailLayer:addListener()
	onButton(self, self.backBtn, function()
		self:emit(AllBuffDetailLayer.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(self, self.setValueBtn, function()
		if getProxy(ChapterProxy):getActiveChapter(true) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("attrset_disable"))
		else
			self:emit(AllBuffDetailMediator.OPEN_SET_VALUE_LAYER)
		end

		return
	end, SFX_PANEL)

	return
end

function AllBuffDetailLayer:updateDetail()
	local var_11_0 = UIItemList.New(self.typeContainer, self.typeItemTpl)

	var_11_0:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			setImageSprite(arg_12_2:Find("TypeTitle/TypeTextImg"), GetSpriteFromAtlas("ShipType", "ch_title_" .. self.typeOrder[arg_12_1 + 1]))
			setImageSprite(arg_12_2:Find("TypeTitle/TypeImg"), GetSpriteFromAtlas("ShipType", "buffitem_tec_" .. self.typeOrder[arg_12_1 + 1]), true)
			Canvas.ForceUpdateCanvases()
			self:updateBuffList(arg_12_2:Find("Container"), self.typeOrder[arg_12_1 + 1])
		end

		return
	end)
	var_11_0:align(#self.typeOrder)
	Canvas.ForceUpdateCanvases()

	if self.scrollView.rect.height >= 850 then
		self.viewportGroupCom.enabled = false
		self.viewportFitterCom.enabled = false
		self.scrollViewFitterCom.enabled = false
		self.scrollView.sizeDelta = Vector2.New(0, 850)
		GetComponent(self.scrollView, "ScrollRect").enabled = true
	end

	setActive(self.scrollView, false)
	setActive(self.scrollView, true)

	return
end

function AllBuffDetailLayer:updateBuffList(arg_13_1, arg_13_2)
	local var_13_0 = UIItemList.New(arg_13_1, self.buffItemTpl)
	local var_13_1 = self.typeAttrTable[arg_13_2]
	local var_13_2 = self.typeAttrOrderTable[arg_13_2]

	var_13_0:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			local var_14_0 = arg_14_2:Find("ValueText")
			local var_14_1 = self.technologyNationProxy:getSetableAttrAdditionValueByTypeAttr(arg_13_2, var_13_2[arg_14_1 + 1])

			setText(arg_14_2:Find("AttrText"), AttributeType.Type2Name(pg.attribute_info_by_type[var_13_2[arg_14_1 + 1]].name))

			local var_14_2

			if var_14_1 == var_13_1[var_13_2[arg_14_1 + 1]] then
				var_14_2 = "#00FF32FF"
			elseif var_14_1 == 0 then
				var_14_2 = "#CA5B5BFF"
			elseif var_14_1 < var_13_1[var_13_2[arg_14_1 + 1]] then
				var_14_2 = "#A5BBD6FF"
			end

			setText(var_14_0, setColorStr("+" .. var_14_1, var_14_2))
		end

		return
	end)
	var_13_0:align(#self.typeAttrOrderTable[arg_13_2])

	return
end

return AllBuffDetailLayer
