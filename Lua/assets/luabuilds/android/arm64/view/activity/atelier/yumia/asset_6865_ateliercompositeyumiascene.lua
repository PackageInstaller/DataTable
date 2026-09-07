local AtelierCompositeYumiaScene = class("AtelierCompositeYumiaScene", import("view.activity.Atelier.base.AtelierCompositeBaseScene"))

function AtelierCompositeYumiaScene:getUIName()
	return "AtelierCompositeYumiaUI"
end

function AtelierCompositeYumiaScene:InitCustom()
	self.layerEmpty = self._tf:Find("bg/Empty")

	setText(self._tf:Find("bg/Empty/bg/Text"), i18n(self.unlockText))

	self.painting = self._tf:Find("bg/painting")
	self.topBar = self._tf:Find("Top/TopBar")
	self.chat = self._tf:Find("bg/Chat")

	setActive(self.chat, false)

	return
end

function AtelierCompositeYumiaScene:InitStr()
	self.bundleName = "ui/AtelierCompositeYumiaUI_atlas"
	self.commonBundleName = "ui/AtelierCommonYumiaUI_atlas"
	self.chatText = {
		idle = {
			"atelier_yumia_1"
		},
		clickFormula = {
			"atelier_yumia_2",
			"atelier_yumia_3",
			"atelier_yumia_4"
		},
		showMaterialSelectWindow = {
			"atelier_yumia_2",
			"atelier_yumia_3",
			"atelier_yumia_4"
		},
		selectMaterial = {
			"atelier_yumia_5",
			"atelier_atellier6",
			"atelier_atellier7"
		},
		compositeResult = {
			"atelier_atellier8",
			"atelier_atellier9"
		},
		compositeResult2 = {
			"atelier_atellier10",
			"atelier_atellier11"
		}
	}
	self.soundStr = {
		formulaDetailUnlock = "event:/ui/ryza_atellier_ui_3",
		showMaterialSelectWindow = "event:/ui/ryza_atellier_ui_1",
		compositeConfirm = "event:/ui/ryza_atellier_ui_6",
		selectMaterial = "event:/ui/ryza_atellier_ui_2",
		formulaDetail = "event:/ui/ryza_atellier_ui_5",
		clickFormula = "event:/ui/ryza_atellier_ui_1",
		formulaDetailFill = "event:/ui/ryza_atellier_ui_4"
	}
	self.helpStr = "ryza_composite_help_tip"
	self.tipStr = "yumia_atelier_tip22"
	self.unlockText = "yumia_atelier_tip1"

	return
end

function AtelierCompositeYumiaScene:InitView()
	self.atelierFormulaListView = AtelierFormulaListYumiaView.New(self.layerFormulaPanel, self)
	self.atelierFormulaDetailView = AtelierFormulaDetailYumiaView.New(self.layerFormulaDetailPanel, self)
	self.atelierMaterialSelectView = AtelierMaterialSelectYumiaView.New(self.materialSelectPanel, self)
	self.atelierMaterialsPreview = AtelierFormulaMaterialsPreviewYumia.New(self.materialsPreviewPanel, self)
	self.atelierCompositeConfirmView = AtelierCompositeConfirmYumiaView.New(self.compositeConfirmPanel, self)
	self.atelierCompositeResultView = AtelierCompositeResultYumiaView.New(self.compositeResultPanel, self)

	return
end

function AtelierCompositeYumiaScene:RefreshEmptyPanel()
	setActive(self.layerEmpty, not self.unlockSystem)

	return
end

function AtelierCompositeYumiaScene:didEnter()
	self:UpdateAdapt()
	AtelierCompositeYumiaScene.super.didEnter(self)

	return
end

function AtelierCompositeYumiaScene:UpdateAdapt()
	local var_7_0 = pg.CameraFixMgr.GetInstance()
	local var_7_1 = math.clamp(var_7_0.currentWidth / var_7_0.currentHeight, 1.3333333333333333, 2.1666666666666665)

	self._tf:GetComponent(typeof(AspectRatioFitter)).aspectRatio = var_7_1
	self.top:GetComponent(typeof(AspectRatioFitter)).aspectRatio = var_7_1

	return
end

function AtelierCompositeYumiaScene:OnClickStore()
	addSubLayer(Context.New({
		mediator = AtelierStoreBaseMediator,
		viewComponent = AtelierStoreYumiaScene,
		data = {
			activity = self.activity
		}
	}), (getProxy(ContextProxy):getCurrentContext():getContextByMediator(AtelierCompositeMediator)))

	return
end

function AtelierCompositeYumiaScene:ShowFormulaList()
	self:AddIdleTimer()
	self.atelierFormulaListView:ShowFormulaList()

	return
end

function AtelierCompositeYumiaScene:ShowFormulaDetail(arg_10_1)
	self.contextData.formulaId = arg_10_1:GetConfigID()

	self.atelierFormulaDetailView:Show(arg_10_1)
	setActive(self.materialSelectPanel, false)

	return
end

function AtelierCompositeYumiaScene:HideFormulaDetail()
	self:ShowTopBar(true)

	if not isActive(self.layerFormulaDetailPanel) then
		return
	end

	self.atelierMaterialSelectView:HideCandicatePanel()
	self.atelierFormulaDetailView:HideDescriptionView()
	setActive(self.layerFormulaDetailPanel, false)

	return true
end

function AtelierCompositeYumiaScene:ShowMaterialSelectWindow(arg_12_1, arg_12_2, arg_12_3)
	self.atelierFormulaDetailView:HideDescriptionView()
	self.atelierFormulaDetailView:HideCompositePanel()
	AtelierCompositeYumiaScene.super.ShowMaterialSelectWindow(self, arg_12_1, arg_12_2, arg_12_3)

	return
end

function AtelierCompositeYumiaScene:RefreshScrollViewPosition()
	self.atelierFormulaDetailView:RefreshScrollViewPosition()

	return
end

function AtelierCompositeYumiaScene:ShowTopBar(arg_14_1)
	setActive(self.topBar, arg_14_1)

	return
end

function AtelierCompositeYumiaScene:UpdateRyzaDrop(arg_15_1, arg_15_2, arg_15_3)
	updateDrop(arg_15_1, arg_15_2)
	SetCompomentEnabled(arg_15_1:Find("icon_bg"), typeof(Image), false)
	setActive(arg_15_1:Find("bg"), false)
	setActive(arg_15_1:Find("icon_bg/frame"), false)
	setActive(arg_15_1:Find("icon_bg/stars"), false)

	local var_15_0 = arg_15_2:getConfig("rarity")

	if arg_15_2.type == DROP_TYPE_EQUIP or arg_15_2.type == DROP_TYPE_EQUIPMENT_SKIN then
		var_15_0 = var_15_0 - 1
	end

	GetImageSpriteFromAtlasAsync("weaponframes", "bg" .. ItemRarity.Rarity2Print(var_15_0), arg_15_1:Find("icon_bg"))

	if arg_15_2.type ~= DROP_TYPE_RYZA_DROP then
		onButton(self, arg_15_1, function()
			self:emit(AtelierCompositeYumiaScene.ON_DROP, arg_15_2)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_15_1)
	end

	return
end

function AtelierCompositeYumiaScene:UpdateRyzaItem(arg_17_1, arg_17_2, arg_17_3)
	AtelierTools.UpdateYumiaItem(arg_17_1, arg_17_2)

	return
end

function AtelierCompositeYumiaScene:GetAtelierCompositEffect()
	return "youmiya_lianjinhecheng"
end

function AtelierCompositeYumiaScene:GetAtelierCompositEffectPos()
	return Vector2(0, 100)
end

function AtelierCompositeYumiaScene:AddIdleTimer()
	local var_20_0 = GetComponent(self._tf, typeof(Animation))

	if var_20_0:IsPlaying("anim_composite_in") then
		self:RemoveIdleTimer()

		self.idleTimer = FrameTimer.New(function()
			if not var_20_0:IsPlaying("anim_composite_in") then
				self:DispalyChat(self.chatText.idle)
				self:AddChatTimer()

				return
			end

			return
		end, 1, -1)

		self.idleTimer:Start()
	else
		self:AddChatTimer()
	end

	return
end

function AtelierCompositeYumiaScene:AddChatTimer()
	self:RemoveIdleTimer()

	self.idleTimer = Timer.New(function()
		self:DispalyChat(self.chatText.idle)
		self:AddIdleTimer()

		return
	end, 8 + math.random() * 4)

	self.idleTimer:Start()

	return
end

function AtelierCompositeYumiaScene:DispalyChat(arg_24_1)
	if GetComponent(self._tf, typeof(Animation)):IsPlaying("anim_composite_in") then
		return
	end

	AtelierCompositeYumiaScene.super.DispalyChat(self, arg_24_1)
	self.painting:Find("root"):GetComponent("Animation"):Play("anim_composite_formulalist_talk")

	return
end

function AtelierCompositeYumiaScene:GetSoundPath()
	return "event:/cv/" .. 17 .. "/"
end

function AtelierCompositeYumiaScene:PlaySoundEffect(arg_26_1)
	return
end

function AtelierCompositeYumiaScene:ClearSound()
	return
end

function AtelierCompositeYumiaScene:PlayGuide()
	return
end

return AtelierCompositeYumiaScene
