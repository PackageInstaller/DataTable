local var_0_0 = class("CourtYardBottomPanel", import(".CourtYardBasePanel"))

function var_0_0.GetUIName(arg_1_0)
	return "main/bottomPanel"
end

function var_0_0.init(arg_2_0)
	arg_2_0.granaryBtn = arg_2_0._tf:Find("bottomleft/feed_btn")
	arg_2_0.stockBar = arg_2_0.granaryBtn:Find("progress"):GetComponent(typeof(Slider))
	arg_2_0.stockTimeTxt = arg_2_0.granaryBtn:Find("time"):GetComponent(typeof(Text))
	arg_2_0.stockTxt = arg_2_0.granaryBtn:Find("Text"):GetComponent(typeof(Text))
	arg_2_0.stampBtn = arg_2_0._tf:Find("stamp")
	arg_2_0.shopBtn = arg_2_0._tf:Find("bottomright/shop_btn")
	arg_2_0.decorateBtn = arg_2_0._tf:Find("bottomright/decorate_btn")
	arg_2_0.templateBtn = arg_2_0._tf:Find("bottomright/theme_template_btn")
	arg_2_0.shareBtn = arg_2_0._tf:Find("bottomright/share_btn")
	arg_2_0.shopTip = arg_2_0.shopBtn:Find("tip")
	arg_2_0.trainBtn = arg_2_0._tf:Find("bottomleft/train_btn")
	arg_2_0.trainBtnTxt = arg_2_0.trainBtn:Find("Text"):GetComponent(typeof(Text))
	arg_2_0.trainBtnLabel = arg_2_0.trainBtn:Find("label"):GetComponent(typeof(Text))
	arg_2_0.icon1 = arg_2_0._tf:Find("bottomleft/train_btn/icon")
	arg_2_0.icon2 = arg_2_0._tf:Find("bottomleft/train_btn/icon_1")

	setText(arg_2_0.granaryBtn:Find("label"), i18n("courtyard_label_capacity"))
	setText(arg_2_0.shareBtn:Find("Text"), i18n("courtyard_label_share"))
	setText(arg_2_0.shopBtn:Find("Text"), i18n("courtyard_label_shop"))
	setText(arg_2_0.decorateBtn:Find("Text"), i18n("courtyard_label_decoration"))
	setText(arg_2_0.templateBtn:Find("Text"), i18n("courtyard_label_template"))

	return
end

function var_0_0.OnRegister(arg_3_0)
	onButton(arg_3_0, arg_3_0.stampBtn, function()
		getProxy(TaskProxy):dealMingshiTouchFlag(7)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.shareBtn, function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeBackyard, pg.ShareMgr.PANEL_TYPE_PINK)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.granaryBtn, function()
		arg_3_0:emit(CourtYardMediator.GO_GRANARY)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.shopBtn, function()
		arg_3_0:emit(CourtYardMediator.GO_SHOP)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.decorateBtn, function()
		arg_3_0:emit(CourtYardMediator.OPEN_DECORATION)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.templateBtn, function()
		if LOCK_BACKYARD_TEMPLATE then
			return
		end

		arg_3_0:emit(CourtYardMediator.GO_THEME_TEMPLATE)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.trainBtn, function()
		if arg_3_0.contextData.floor == 1 then
			arg_3_0:emit(CourtYardMediator.SEL_TRAIN_SHIP)
		elseif arg_3_0.contextData.floor == 2 then
			arg_3_0:emit(CourtYardMediator.SEL_REST_SHIP)
		end

		return
	end, SFX_PANEL)

	local var_3_0 = arg_3_0
	local var_3_2 = arg_3_0.stampBtn
	local var_3_3 = not LOCK_CLICK_MINGSHI and getProxy(TaskProxy):mingshiTouchFlagEnabled()

	var_3_1(var_3_0, var_3_2, var_3_3)
	arg_3_0:UpdateShopTip()

	return
end

function var_0_0.OnVisitRegister(arg_11_0)
	setActive(arg_11_0._tf, false)

	return
end

function var_0_0.OnFlush(arg_12_0, arg_12_1)
	arg_12_1 = arg_12_1 or bit.bor(BackYardConst.DORM_UPDATE_TYPE_UPDATEFOOD, BackYardConst.DORM_UPDATE_TYPE_LEVEL, BackYardConst.DORM_UPDATE_TYPE_SHIP, BackYardConst.DORM_UPDATE_TYPE_USEFOOD, BackYardConst.DORM_UPDATE_TYPE_EXTENDFOOD)

	local var_12_0 = arg_12_0.dorm

	if bit.band(arg_12_1, BackYardConst.DORM_UPDATE_TYPE_UPDATEFOOD) > 0 or bit.band(arg_12_1, BackYardConst.DORM_UPDATE_TYPE_USEFOOD) > 0 or bit.band(arg_12_1, BackYardConst.DORM_UPDATE_TYPE_EXTENDFOOD) > 0 then
		arg_12_0:CalcStockLeftTime()
	end

	if bit.band(arg_12_1, BackYardConst.DORM_UPDATE_TYPE_SHIP) > 0 then
		arg_12_0:CalcStockLeftTime()
		arg_12_0:UpdateTrainBtn()
	end

	if bit.band(arg_12_1, BackYardConst.DORM_UPDATE_TYPE_LEVEL) > 0 then
		SetActive(arg_12_0.templateBtn, not LOCK_BACKYARD_TEMPLATE)

		if not LOCK_BACKYARD_TEMPLATE then
			arg_12_0:PlayBackYardThemeTemplate()

			local var_12_1 = var_12_0:IsMaxLevel() and arg_12_0:IsInner()

			SetActive(arg_12_0.templateBtn, var_12_1)
		end
	end

	if bit.band(arg_12_1, BackYardConst.DORM_UPDATE_TYPE_UPDATEFOOD) > 0 or bit.band(arg_12_1, BackYardConst.DORM_UPDATE_TYPE_LEVEL) > 0 or bit.band(arg_12_1, BackYardConst.DORM_UPDATE_TYPE_USEFOOD) > 0 or bit.band(arg_12_1, BackYardConst.DORM_UPDATE_TYPE_EXTENDFOOD) > 0 then
		local var_12_2 = pg.dorm_data_template[var_12_0.id].capacity

		arg_12_0.stockBar.value = var_12_0.food / (pg.dorm_data_template[var_12_0.id].capacity + var_12_0:GetFoodMax())
		arg_12_0.stockTxt.text = math.ceil(var_12_0.food) .. "/" .. var_12_2 + var_12_0:GetFoodMax()
	end

	arg_12_0:UpdateFloor()

	return
end

function var_0_0.PlayBackYardThemeTemplate(arg_13_0)
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

function var_0_0.UpdateTrainBtn(arg_14_0)
	if arg_14_0.contextData.floor == 1 then
		arg_14_0.trainBtnLabel.text = i18n("courtyard_label_train")
		arg_14_0.trainBtnTxt.text = arg_14_0.dorm:GetFloorShipCnt(DormShip.FLOOR_1) .. "/" .. arg_14_0.dorm.exp_pos
	elseif arg_14_0.contextData.floor == 2 then
		arg_14_0.trainBtnLabel.text = i18n("courtyard_label_rest")
		arg_14_0.trainBtnTxt.text = arg_14_0.dorm:GetFloorShipCnt(DormShip.FLOOR_2) .. "/" .. arg_14_0.dorm.rest_pos
	end

	return
end

function var_0_0.UpdateShopTip(arg_15_0)
	local var_15_0 = getProxy(SettingsProxy):IsTipNewTheme()

	var_15_0 = var_15_0 or getProxy(SettingsProxy):IsTipNewGemFurniture()

	setActive(arg_15_0.shopTip, var_15_0)

	return
end

function var_0_0.OnRemoveLayer(arg_16_0, arg_16_1)
	if arg_16_1 == NewBackYardShopMediator then
		arg_16_0:UpdateShopTip()
	end

	return
end

function var_0_0.CalcStockLeftTime(arg_17_0)
	arg_17_0:RemoveTimer()

	arg_17_0.stockTimeTxt.text = ""

	if arg_17_0.dorm:GetFloorShipCnt(DormShip.FLOOR_1) <= 0 or arg_17_0.dorm.food <= 0 then
		return
	end

	local var_17_0 = arg_17_0.dorm:getFoodLeftTime()

	arg_17_0.timer = Timer.New(function()
		local var_18_0 = math.floor(var_17_0) - pg.TimeMgr.GetInstance():GetServerTime()

		arg_17_0.stockTimeTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_18_0)

		if var_18_0 <= 0 then
			arg_17_0:RemoveTimer()
		end

		return
	end, 1, -1)

	arg_17_0.timer:Start()
	arg_17_0.timer.func()

	return
end

function var_0_0.RemoveTimer(arg_19_0)
	arg_19_0.stockTimeTxt.text = ""

	if arg_19_0.timer then
		arg_19_0.timer:Stop()

		arg_19_0.timer = nil
	end

	return
end

function var_0_0.GetMoveY(arg_20_0)
	return {
		{
			arg_20_0._tf,
			-1
		}
	}
end

function var_0_0.UpdateFloor(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:IsInner() and getProxy(DormProxy).floor == 1

	SetActive(arg_21_0.granaryBtn, var_21_0)
	arg_21_0:UpdateTrainBtn()
	setActive(arg_21_0.icon1, getProxy(DormProxy).floor == 1)
	setActive(arg_21_0.icon2, getProxy(DormProxy).floor == 2)

	return
end

function var_0_0.OnDispose(arg_22_0)
	arg_22_0:RemoveTimer()

	return
end

return var_0_0
