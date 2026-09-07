local CourtYardBottomPanel = class("CourtYardBottomPanel", import(".CourtYardBasePanel"))

function CourtYardBottomPanel:GetUIName()
	return "main/bottomPanel"
end

function CourtYardBottomPanel:init()
	self.granaryBtn = self._tf:Find("bottomleft/feed_btn")
	self.stockBar = self.granaryBtn:Find("progress"):GetComponent(typeof(Slider))
	self.stockTimeTxt = self.granaryBtn:Find("time"):GetComponent(typeof(Text))
	self.stockTxt = self.granaryBtn:Find("Text"):GetComponent(typeof(Text))
	self.stampBtn = self._tf:Find("stamp")
	self.shopBtn = self._tf:Find("bottomright/shop_btn")
	self.decorateBtn = self._tf:Find("bottomright/decorate_btn")
	self.templateBtn = self._tf:Find("bottomright/theme_template_btn")
	self.shareBtn = self._tf:Find("bottomright/share_btn")
	self.shopTip = self.shopBtn:Find("tip")
	self.trainBtn = self._tf:Find("bottomleft/train_btn")
	self.trainBtnTxt = self.trainBtn:Find("Text"):GetComponent(typeof(Text))
	self.trainBtnLabel = self.trainBtn:Find("label"):GetComponent(typeof(Text))
	self.icon1 = self._tf:Find("bottomleft/train_btn/icon")
	self.icon2 = self._tf:Find("bottomleft/train_btn/icon_1")

	setText(self.granaryBtn:Find("label"), i18n("courtyard_label_capacity"))
	setText(self.shareBtn:Find("Text"), i18n("courtyard_label_share"))
	setText(self.shopBtn:Find("Text"), i18n("courtyard_label_shop"))
	setText(self.decorateBtn:Find("Text"), i18n("courtyard_label_decoration"))
	setText(self.templateBtn:Find("Text"), i18n("courtyard_label_template"))

	return
end

function CourtYardBottomPanel:OnRegister()
	onButton(self, self.stampBtn, function()
		getProxy(TaskProxy):dealMingshiTouchFlag(7)

		return
	end, SFX_PANEL)
	onButton(self, self.shareBtn, function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeBackyard, pg.ShareMgr.PANEL_TYPE_PINK)

		return
	end, SFX_PANEL)
	onButton(self, self.granaryBtn, function()
		self:emit(CourtYardMediator.GO_GRANARY)

		return
	end, SFX_PANEL)
	onButton(self, self.shopBtn, function()
		self:emit(CourtYardMediator.GO_SHOP)

		return
	end, SFX_PANEL)
	onButton(self, self.decorateBtn, function()
		self:emit(CourtYardMediator.OPEN_DECORATION)

		return
	end, SFX_PANEL)
	onButton(self, self.templateBtn, function()
		if LOCK_BACKYARD_TEMPLATE then
			return
		end

		self:emit(CourtYardMediator.GO_THEME_TEMPLATE)

		return
	end, SFX_PANEL)
	onButton(self, self.trainBtn, function()
		if self.contextData.floor == 1 then
			self:emit(CourtYardMediator.SEL_TRAIN_SHIP)
		elseif self.contextData.floor == 2 then
			self:emit(CourtYardMediator.SEL_REST_SHIP)
		end

		return
	end, SFX_PANEL)
	self:SetActive(self.stampBtn, not LOCK_CLICK_MINGSHI and getProxy(TaskProxy):mingshiTouchFlagEnabled())
	self:UpdateShopTip()

	return
end

function CourtYardBottomPanel:OnVisitRegister()
	setActive(self._tf, false)

	return
end

function CourtYardBottomPanel:OnFlush(arg_12_1)
	arg_12_1 = arg_12_1 or bit.bor(BackYardConst.DORM_UPDATE_TYPE_UPDATEFOOD, BackYardConst.DORM_UPDATE_TYPE_LEVEL, BackYardConst.DORM_UPDATE_TYPE_SHIP, BackYardConst.DORM_UPDATE_TYPE_USEFOOD, BackYardConst.DORM_UPDATE_TYPE_EXTENDFOOD)

	local var_12_0 = self.dorm

	if bit.band(arg_12_1, BackYardConst.DORM_UPDATE_TYPE_UPDATEFOOD) > 0 or bit.band(arg_12_1, BackYardConst.DORM_UPDATE_TYPE_USEFOOD) > 0 or bit.band(arg_12_1, BackYardConst.DORM_UPDATE_TYPE_EXTENDFOOD) > 0 then
		self:CalcStockLeftTime()
	end

	if bit.band(arg_12_1, BackYardConst.DORM_UPDATE_TYPE_SHIP) > 0 then
		self:CalcStockLeftTime()
		self:UpdateTrainBtn()
	end

	if bit.band(arg_12_1, BackYardConst.DORM_UPDATE_TYPE_LEVEL) > 0 then
		SetActive(self.templateBtn, not LOCK_BACKYARD_TEMPLATE)

		if not LOCK_BACKYARD_TEMPLATE then
			self:PlayBackYardThemeTemplate()
			SetActive(self.templateBtn, var_12_0:IsMaxLevel() and self:IsInner())
		end
	end

	if bit.band(arg_12_1, BackYardConst.DORM_UPDATE_TYPE_UPDATEFOOD) > 0 or bit.band(arg_12_1, BackYardConst.DORM_UPDATE_TYPE_LEVEL) > 0 or bit.band(arg_12_1, BackYardConst.DORM_UPDATE_TYPE_USEFOOD) > 0 or bit.band(arg_12_1, BackYardConst.DORM_UPDATE_TYPE_EXTENDFOOD) > 0 then
		local var_12_1 = pg.dorm_data_template[var_12_0.id].capacity

		self.stockBar.value = var_12_0.food / (pg.dorm_data_template[var_12_0.id].capacity + var_12_0:GetFoodMax())
		self.stockTxt.text = math.ceil(var_12_0.food) .. "/" .. var_12_1 + var_12_0:GetFoodMax()
	end

	self:UpdateFloor()

	return
end

function CourtYardBottomPanel:PlayBackYardThemeTemplate()
	if getProxy(DormProxy):getRawData():IsMaxLevel() then
		if not pg.NewStoryMgr.GetInstance():GetPlayedFlag(90021) then
			_BackyardMsgBoxMgr:Show({
				modal = true,
				hideNo = true,
				hideClose = true,
				content = i18n("open_backyard_theme_template_tip")
			})
			pg.m02:sendNotification(GAME.STORY_UPDATE, {
				storyId = "NG0020"
			})
		end
	end

	return
end

function CourtYardBottomPanel:UpdateTrainBtn()
	if self.contextData.floor == 1 then
		self.trainBtnLabel.text = i18n("courtyard_label_train")
		self.trainBtnTxt.text = self.dorm:GetFloorShipCnt(DormShip.FLOOR_1) .. "/" .. self.dorm.exp_pos
	elseif self.contextData.floor == 2 then
		self.trainBtnLabel.text = i18n("courtyard_label_rest")
		self.trainBtnTxt.text = self.dorm:GetFloorShipCnt(DormShip.FLOOR_2) .. "/" .. self.dorm.rest_pos
	end

	return
end

function CourtYardBottomPanel:UpdateShopTip()
	local var_15_0 = getProxy(SettingsProxy):IsTipNewTheme()

	var_15_0 = var_15_0 or getProxy(SettingsProxy):IsTipNewGemFurniture()

	setActive(self.shopTip, var_15_0)

	return
end

function CourtYardBottomPanel:OnRemoveLayer(arg_16_1)
	if arg_16_1 == NewBackYardShopMediator then
		self:UpdateShopTip()
	end

	return
end

function CourtYardBottomPanel:CalcStockLeftTime()
	self:RemoveTimer()

	self.stockTimeTxt.text = ""

	if self.dorm:GetFloorShipCnt(DormShip.FLOOR_1) <= 0 or self.dorm.food <= 0 then
		return
	end

	local var_17_0 = self.dorm:getFoodLeftTime()

	self.timer = Timer.New(function()
		local var_18_0 = math.floor(var_17_0) - pg.TimeMgr.GetInstance():GetServerTime()

		self.stockTimeTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_18_0)

		if var_18_0 <= 0 then
			self:RemoveTimer()
		end

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function CourtYardBottomPanel:RemoveTimer()
	self.stockTimeTxt.text = ""

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function CourtYardBottomPanel:GetMoveY()
	return {
		{
			self._tf,
			-1
		}
	}
end

function CourtYardBottomPanel:UpdateFloor(arg_21_1)
	SetActive(self.granaryBtn, self:IsInner() and getProxy(DormProxy).floor == 1)
	self:UpdateTrainBtn()
	setActive(self.icon1, getProxy(DormProxy).floor == 1)
	setActive(self.icon2, getProxy(DormProxy).floor == 2)

	return
end

function CourtYardBottomPanel:OnDispose()
	self:RemoveTimer()

	return
end

return CourtYardBottomPanel
