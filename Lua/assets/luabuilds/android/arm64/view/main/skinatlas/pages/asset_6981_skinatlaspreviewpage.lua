local SkinAtlasPreviewPage = class("SkinAtlasPreviewPage", import("....base.BaseSubView"))

SkinAtlasPreviewPage.ON_BG_SWITCH_DONE = "SkinAtlasScene:ON_BG_SWITCH_DONE"
SkinAtlasPreviewPage.ON_L2D_SWITCH_DONE = "SkinAtlasScene:ON_L2D_SWITCH_DONE"

function SkinAtlasPreviewPage:getUIName()
	return "SkinAtlasPreviewPage"
end

function SkinAtlasPreviewPage:OnLoaded()
	self.paintingTr = self._tf:Find("paint")
	self.live2dContainer = self._tf:Find("paint/live2d")
	self.mainImg = self._tf:Find("main"):GetComponent(typeof(UnityEngine.UI.Graphic))
	self.backBtn = self._tf:Find("main/left/back")
	self.nameTxt = self._tf:Find("main/left/name_bg/skin_name"):GetComponent(typeof(Text))
	self.shipnameTxt = self._tf:Find("main/left/name_bg/name"):GetComponent(typeof(Text))
	self.charParent = self._tf:Find("main/right/char")
	self.viewBtn = self._tf:Find("main/right/view_btn")
	self.changeBtn = self._tf:Find("main/right/change_btn")
	self.changeBtnDis = self.changeBtn:Find("dis")
	self.changeBtnEn = self.changeBtn:Find("en")
	self.obtainBtn = self._tf:Find("main/right/obtain_btn")
	self.bgFlag = true
	self.l2dFlag = false

	local var_2_0 = self._tf:Find("main/left/tpl")

	self.btns = {
		ShipAtlasBgBtn.New(var_2_0, PlayerVitaeBaseBtn.HRZ_TYPE, self.event, self.bgFlag),
		ShipAtlasLive2dBtn.New(var_2_0, PlayerVitaeBaseBtn.HRZ_TYPE, self.event, self.l2dFlag)
	}
	self.changeSkinUI = self._tf:Find("main/bottom/changeSkin")
	self.changeSkinToggle = ChangeSkinToggle.New(findTF(self.changeSkinUI, "ChangeSkinToggleUI"))
	self.bgView = SkinAtlasBgView.New(self._tf:Find("bg/bg"))
	self.paintingView = SkinAtlasPaintingView.New(self._tf:Find("paint"))
	self.selectShipPage = ChangeShipSkinPage.New(self._parentTf, self.event)

	return
end

function SkinAtlasPreviewPage:OnInit()
	onButton(self, self.backBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.viewBtn, function()
		self.mainImg.enabled = false

		self.paintingView:Enter()

		if self.live2d then
			self.live2d:OpenClick()
		end

		return
	end, SFX_PANEL)

	local var_3_0 = self._tf:GetComponent(typeof(PinchZoom))

	onButton(self, self._tf, function()
		if var_3_0.processing then
			return
		end

		self.mainImg.enabled = true

		self.paintingView:Exit()

		if self.live2d then
			self.live2d:CloseClick()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.changeBtn, function()
		if self.skin:CantUse() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("without_ship_to_wear"))

			return
		end

		self.selectShipPage:ExecuteAction("Show", self.skin)

		return
	end, SFX_PANEL)
	onButton(self, self.obtainBtn, function()
		local var_8_0 = ShipGroup.New({
			id = self.skin:getConfig("ship_group")
		})

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_OBTAIN,
			shipId = var_8_0:getShipConfigId(),
			list = var_8_0.groupConfig.description,
			mediatorName = SkinAtlasMediator.__cname
		})

		return
	end, SFX_PANEL)
	onButton(self, self.changeSkinUI, function()
		if ShipSkin.GetChangeSkinData(self.skin.id) then
			self:Flush(ShipSkin.New({
				id = ShipSkin.GetChangeSkinNextId(self.skin.id)
			}), self.index)
		end

		return
	end, SFX_PANEL)
	self:bind(SkinAtlasPreviewPage.ON_BG_SWITCH_DONE, function(arg_10_0, arg_10_1)
		self.bgFlag = arg_10_1

		self.bgView:Init(self.ship, self.bgFlag)

		return
	end)
	self:bind(SkinAtlasPreviewPage.ON_L2D_SWITCH_DONE, function(arg_11_0, arg_11_1)
		self.l2dFlag = arg_11_1

		self:UpdatePainting(self.ship)

		return
	end)
	addSlip(SLIP_TYPE_HRZ, self._tf:Find("main"), function()
		self:OnPrev()

		return
	end, function()
		self:OnNext()

		return
	end)

	return
end

function SkinAtlasPreviewPage:OnNext()
	if self.loading then
		return
	end

	self:emit(SkinAtlasScene.ON_NEXT_SKIN, self.index)

	return
end

function SkinAtlasPreviewPage:OnPrev()
	if self.loading then
		return
	end

	self:emit(SkinAtlasScene.ON_PREV_SKIN, self.index)

	return
end

function SkinAtlasPreviewPage:Show(arg_16_1, arg_16_2)
	SkinAtlasPreviewPage.super.Show(self)

	self.index = arg_16_2
	self.skin = arg_16_1
	self.bgFlag = true
	self.l2dFlag = false

	local var_16_0 = self.skin:ToShip()

	assert(var_16_0)

	self.ship = var_16_0

	self:UpdateMain(var_16_0)

	local var_16_1 = self.skin:CantUse()

	setActive(self.changeBtnDis, var_16_1)
	setActive(self.changeBtnEn, not var_16_1)
	setActive(self.changeSkinUI, ShipSkin.GetChangeSkinData(self.skin.id) and true or false)
	self.changeSkinToggle:setSkinData(self.skin.id)
	setActive(self.changeSkinUI, not self.changeSkinToggle:IsAsmrSkin())
	setActive(self.obtainBtn, not self.skin:OwnShip())

	return
end

function SkinAtlasPreviewPage:Flush(arg_17_1, arg_17_2)
	self:Clear()
	self:Show(arg_17_1, arg_17_2)

	return
end

function SkinAtlasPreviewPage:UpdateMain(arg_18_1)
	local var_18_0 = 0

	for iter_18_0, iter_18_1 in ipairs(self.btns) do
		local var_18_1 = iter_18_1:IsActive(arg_18_1)

		if var_18_1 then
			var_18_0 = var_18_0 + 1
		end

		iter_18_1:Update(var_18_1, var_18_0, arg_18_1)
	end

	self.nameTxt.text = self.skin:getConfig("name")
	self.shipnameTxt.text = arg_18_1:getName()
	self.loading = true

	parallelAsync({
		function(arg_19_0)
			self.bgView:Init(arg_18_1, self.bgFlag, arg_19_0)

			return
		end,
		function(arg_20_0)
			self:UpdatePainting(arg_18_1, arg_20_0)

			return
		end,
		function(arg_21_0)
			self:UpdateChar(arg_18_1, arg_21_0)

			return
		end
	}, function()
		self.loading = false

		return
	end)

	return
end

function SkinAtlasPreviewPage:UpdatePainting(arg_23_1, arg_23_2)
	if self.l2dFlag then
		self:InitL2D(arg_23_1, arg_23_2)
	else
		self:InitPainting(arg_23_1, arg_23_2)
	end

	return
end

function SkinAtlasPreviewPage:InitPainting(arg_24_1, arg_24_2)
	self:ClearPainting(arg_24_1)
	setActive(self.live2dContainer, false)

	self.painting = arg_24_1:getPainting()

	setPaintingPrefabAsync(self.paintingTr, self.painting, "chuanwu", arg_24_2)

	return
end

function SkinAtlasPreviewPage:InitL2D(arg_25_1, arg_25_2)
	self:ClearPainting(arg_25_1)

	self.live2d = SkinAtlasLive2dView.New(arg_25_1, self.live2dContainer, arg_25_2)

	self.live2d.live2dChar:changeTriggerFlag(false)

	return
end

function SkinAtlasPreviewPage:UpdateChar(arg_26_1, arg_26_2)
	PoolMgr.GetInstance():GetSpineChar(arg_26_1:getPrefab(), true, function(arg_27_0)
		self.modelTf = tf(arg_27_0)
		self.modelTf.localScale = Vector3(0.9, 0.9, 1)
		self.modelTf.localPosition = Vector3(0, -135, 0)

		pg.ViewUtils.SetLayer(self.modelTf, Layer.UI)
		setParent(self.modelTf, self.charParent)
		arg_27_0:GetComponent("SpineAnimUI"):SetAction("normal", 0)
		arg_26_2()

		return
	end)

	return
end

function SkinAtlasPreviewPage:ClearPainting(arg_28_1)
	if self.live2d then
		self.live2d:Dispose()

		self.live2d = nil
	elseif self.painting then
		retPaintingPrefab(self.paintingTr, self.painting)

		self.painting = nil
	end

	return
end

function SkinAtlasPreviewPage:ClearChar(arg_29_1)
	if self.modelTf then
		PoolMgr.GetInstance():ReturnSpineChar(arg_29_1:getPrefab(), self.modelTf.gameObject)

		self.modelTf = nil
	end

	return
end

function SkinAtlasPreviewPage:Clear()
	if self.ship then
		self:ClearPainting(self.ship)
		self:ClearChar(self.ship)

		self.ship = nil
	end

	return
end

function SkinAtlasPreviewPage:Hide()
	SkinAtlasPreviewPage.super.Hide(self)
	self:Clear()

	self.skin = nil

	self.bgView:Clear()

	if self.paintingView:IsEnter() then
		self.paintingView:Exit()
	end

	return
end

function SkinAtlasPreviewPage:IsShowSelectShipView()
	local var_32_0 = self.selectShipPage

	if self.selectShipPage then
		var_32_0 = self.selectShipPage:GetLoaded()
		var_32_0 = var_32_0 and self.selectShipPage:isShowing()
	end

	return var_32_0
end

function SkinAtlasPreviewPage:CloseSelectShipView()
	self.selectShipPage:Hide()

	return
end

function SkinAtlasPreviewPage:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	for iter_34_0, iter_34_1 in ipairs(self.btns) do
		iter_34_1:Dispose()
	end

	self.btns = nil

	self.bgView:Dispose()

	self.bgView = nil

	self.selectShipPage:Destroy()

	self.selectShipPage = nil

	self.paintingView:Dispose()

	self.paintingView = nil

	return
end

return SkinAtlasPreviewPage
