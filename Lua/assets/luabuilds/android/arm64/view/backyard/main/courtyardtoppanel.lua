local var_0_0 = class("CourtYardTopPanel", import(".CourtYardBasePanel"))

function var_0_0.GetUIName(arg_1_0)
	return "main/topPanel"
end

function var_0_0.init(arg_2_0)
	arg_2_0.backBtn = arg_2_0._tf:Find("btns/topleft/return")
	arg_2_0.nameTxt = arg_2_0._tf:Find("btns/topleft/name/Text"):GetComponent(typeof(Text))
	arg_2_0.renameBtn = arg_2_0._tf:Find("btns/topleft/name")
	arg_2_0.comfortableBtn = arg_2_0._tf:Find("btns/topright/comfortable")
	arg_2_0.comfortableTxt = arg_2_0._tf:Find("btns/topright/comfortable/Text"):GetComponent(typeof(Text))
	arg_2_0.comfortableImg = arg_2_0._tf:Find("btns/topright/comfortable/icon"):GetComponent(typeof(Image))
	arg_2_0.switchBtn = arg_2_0._tf:Find("btns/topright/switch")
	arg_2_0.switchTxt = arg_2_0.switchBtn:Find("Text"):GetComponent(typeof(Text))
	arg_2_0.renamePage = CourtYardRenamePage.New(arg_2_0._tf.parent.parent, arg_2_0.parent.event)
	arg_2_0.comfortablePage = CourtYardComfortablePage.New(arg_2_0._tf.parent.parent, arg_2_0.parent.event)
	arg_2_0.cg = GetOrAddComponent(arg_2_0._tf:Find("btns/topright"), typeof(CanvasGroup))

	setText(arg_2_0._tf:Find("btns/topright/comfortable/label"), i18n("word_comfort_level"))
	setText(arg_2_0._tf:Find("btns/topright/switch/label"), i18n("courtyard_label_floor"))

	return
end

function var_0_0.OnRegister(arg_3_0)
	onButton(arg_3_0, arg_3_0.renameBtn, function()
		if arg_3_0.cg.blocksRaycasts then
			arg_3_0.renamePage:ExecuteAction("Flush")
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.backBtn, function()
		_courtyard:GetController():Quit()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.comfortableBtn, function()
		arg_3_0.comfortablePage:ExecuteAction("Show", arg_3_0.dorm)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.switchBtn, function()
		local var_7_0 = arg_3_0.contextData.floor == 1 and 2 or 1

		if not arg_3_0.dorm:isUnlockFloor(arg_3_0.contextData.floor == 1 and 2 or 1) then
			arg_3_0:UnLockTip()
		else
			arg_3_0:emit(CourtYardMediator.SWITCH, var_7_0)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UnLockTip(arg_8_0)
	if not arg_8_0.dorm:IsMaxLevel() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("sec_floor_limit_tip"))

		return
	end

	;({}).content = i18n("backyard_open_2floor", pg.shop_template[ShopArgs.DORM_FLOOR_ID].resource_num)
	;({}).onYes = function()
		arg_8_0:emit(CourtYardMediator.UN_LOCK_2FLOOR, var_0, 1)

		return
	end

	_BackyardMsgBoxMgr:Show({})

	return
end

function var_0_0.UpdateFloor(arg_10_0)
	local var_10_0 = arg_10_0.contextData.floor or 1

	arg_10_0.switchTxt.text = var_10_0 .. "F"

	return
end

function var_0_0.OnVisitRegister(arg_11_0)
	onButton(arg_11_0, arg_11_0.backBtn, function()
		_courtyard:GetController():Quit()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnVisitFlush(arg_13_0)
	arg_13_0:OnFlush()

	return
end

function var_0_0.OnFlush(arg_14_0, arg_14_1)
	arg_14_1 = arg_14_1 or bit.bor(BackYardConst.DORM_UPDATE_TYPE_NAME, BackYardConst.DORM_UPDATE_TYPE_LEVEL)

	if bit.band(arg_14_1, BackYardConst.DORM_UPDATE_TYPE_NAME) > 0 then
		arg_14_0:FlushName()
	end

	if bit.band(arg_14_1, BackYardConst.DORM_UPDATE_TYPE_LEVEL) > 0 then
		arg_14_0:FlushComfortable()
		arg_14_0:UpdateFloor()
	end

	return
end

function var_0_0.FlushName(arg_15_0)
	local var_15_0 = arg_15_0.dorm:GetName()

	if not var_15_0 or var_15_0 == "" then
		local var_15_1 = getProxy(PlayerProxy)

		var_15_0 = var_15_1:getRawData().name
		arg_15_0.nameTxt.text = var_15_0
	else
		arg_15_0.nameTxt.text = var_15_0
	end

	return
end

function var_0_0.FlushComfortable(arg_16_0)
	local var_16_0 = arg_16_0.dorm:getComfortable()

	arg_16_0.comfortableTxt.text = var_16_0

	LoadSpriteAtlasAsync("ui/CourtyardUI_atlas", "express_" .. arg_16_0.dorm:GetComfortableLevel(var_16_0), function(arg_17_0)
		if arg_16_0.exited then
			return
		end

		arg_16_0.comfortableImg.sprite = arg_17_0

		arg_16_0.comfortableImg:SetNativeSize()

		return
	end)

	return
end

function var_0_0.GetMoveY(arg_18_0)
	return {
		{
			arg_18_0._tf,
			1
		}
	}
end

function var_0_0.OnEnterEditMode(arg_19_0)
	arg_19_0.cg.blocksRaycasts = false

	return
end

function var_0_0.OnExitEditMode(arg_20_0)
	arg_20_0.cg.blocksRaycasts = true

	return
end

function var_0_0.onBackPressed(arg_21_0)
	if arg_21_0.renamePage:GetLoaded() and arg_21_0.renamePage:isShowing() then
		arg_21_0.renamePage:Hide()

		return true
	end

	return false
end

function var_0_0.OnDispose(arg_22_0)
	arg_22_0.exited = true

	if arg_22_0.renamePage then
		arg_22_0.renamePage:Destroy()

		arg_22_0.renamePage = nil
	end

	if arg_22_0.comfortablePage then
		arg_22_0.comfortablePage:Destroy()

		arg_22_0.comfortablePage = nil
	end

	return
end

return var_0_0
