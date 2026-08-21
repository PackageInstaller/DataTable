local var_0_0 = class("CrusingScene", import("view.base.BaseUI"))

var_0_0.optionsPath = {
	"top/home"
}
var_0_0.FrameSpeed = 10
var_0_0.PlaySpeed = 1.5

function var_0_0.getUIName(arg_1_0)
	return "CrusingUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	local var_2_0 = getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING)
	local var_2_1 = PoolMgr.GetInstance()

	table.insert({}, function(arg_3_0)
		var_2_1:GetPrefab("crusingmap/" .. pg.battlepass_event_pt[var_2_0.id].crusing_map, "", true, function(arg_4_0)
			arg_2_0.rtMap = tf(arg_4_0)
			arg_2_0.PhaseFrame, arg_2_0.AllFrameCount = CrusingMapInfo.GetPhaseFrame(var_0)

			arg_3_0()

			return
		end)

		return
	end)
	table.insert({}, function(arg_5_0)
		var_2_1:GetSpineChar(pg.battlepass_event_pt[var_2_0.id].spine_name, true, function(arg_6_0)
			arg_2_0.rtModel = tf(arg_6_0)

			arg_5_0()

			return
		end)

		return
	end)
	parallelAsync({}, function()
		setParent(arg_2_0.rtModel, arg_2_0.rtMap:Find("icon/model"))

		arg_2_0.rtModel.localScale = Vector3.one

		arg_2_1()

		return
	end)

	return
end

function var_0_0.init(arg_8_0)
	arg_8_0.rtBg = arg_8_0._tf:Find("bg")
	arg_8_0.scrollMap = arg_8_0.rtBg:Find("map_scroll")
	arg_8_0.btnTask = arg_8_0.rtBg:Find("task_btn")
	arg_8_0.textTip = arg_8_0.rtBg:Find("tip")
	arg_8_0.rtAward = arg_8_0._tf:Find("award_panel")
	arg_8_0.textPhase = arg_8_0.rtAward:Find("phase/Text")
	arg_8_0.sliderPt = arg_8_0.rtAward:Find("Slider")
	arg_8_0.comScroll = GetComponent(arg_8_0.rtAward:Find("view/content"), "LScrollRect")

	function arg_8_0.comScroll.onUpdateItem(arg_9_0, arg_9_1)
		arg_8_0:updateAwardInfo(tf(arg_9_1), arg_8_0.awardList[arg_9_0 + 1])

		return
	end

	arg_8_0.rtNextAward = arg_8_0.rtAward:Find("next")
	arg_8_0.btnAll = arg_8_0.rtAward:Find("btn_all")
	arg_8_0.btnPay = arg_8_0.rtAward:Find("btn_pay")
	arg_8_0.btnAfter = arg_8_0.rtAward:Find("btn_after")
	arg_8_0.btnFinish = arg_8_0.rtAward:Find("btn_finish")
	arg_8_0.rtTop = arg_8_0._tf:Find("top")
	arg_8_0.btnBack = arg_8_0.rtTop:Find("back")
	arg_8_0.btnHelp = arg_8_0.rtTop:Find("help")
	arg_8_0.textDay = arg_8_0.rtTop:Find("day/Text")
	arg_8_0.chargeTipWindow = ChargeTipWindow.New(arg_8_0._tf, arg_8_0.event)
	arg_8_0.LTDic = {}

	return
end

function var_0_0.didEnter(arg_10_0)
	onButton(arg_10_0, arg_10_0.btnBack, function()
		arg_10_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_10_0, arg_10_0.btnTask, function()
		if arg_10_0.phase < #arg_10_0.awardList then
			arg_10_0:emit(CrusingMediator.EVENT_OPEN_TASK)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("battlepass_complete"))
		end

		return
	end, SFX_PANEL)
	onButton(arg_10_0, arg_10_0.btnAll, function()
		local var_13_0 = arg_10_0.activity:GetCrusingUnreceiveAward()

		if #var_13_0 > 0 then
			if arg_10_0:checkLimitMax(var_13_0) then
				table.insert({}, function(arg_14_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("player_expResource_mail_fullBag"),
						onYes = arg_14_0
					})

					return
				end)
			end

			seriesAsync({}, function()
				arg_10_0:emit(CrusingMediator.EVENT_GET_AWARD_ALL)

				return
			end)
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_10_0, arg_10_0.btnPay, function()
		arg_10_0:openBuyPanel()

		return
	end, SFX_CONFIRM)
	onButton(arg_10_0, arg_10_0.btnAfter, function()
		local var_17_0 = arg_10_0.activity:GetCrusingUnreceiveAward()

		if #var_17_0 > 0 then
			if arg_10_0:checkLimitMax(var_17_0) then
				table.insert({}, function(arg_18_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("player_expResource_mail_fullBag"),
						onYes = arg_18_0
					})

					return
				end)
			end

			seriesAsync({}, function()
				arg_10_0:emit(CrusingMediator.EVENT_GET_AWARD_ALL)

				return
			end)
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_10_0, arg_10_0.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("battlepass_main_help_" .. pg.battlepass_event_pt[arg_10_0.activity.id].map_name)
		})

		return
	end, SFX_PANEL)

	arg_10_0.maps = {
		(function(arg_21_0)
			local var_21_0 = {
				_tf = arg_21_0,
				rtLine = arg_21_0:Find("line"),
				rtIcon = arg_21_0:Find("icon"),
				rtSimple = arg_21_0:Find("simple")
			}

			setParent(arg_21_0, arg_10_0.scrollMap)
			SetCompomentEnabled(arg_21_0, typeof(Image), false)

			arg_21_0.name = "map_tpl"

			SetAction(var_21_0.rtIcon:Find("model"):GetChild(0), "normal")

			return var_21_0
		end)(arg_10_0.rtMap)
	}

	while #arg_10_0.maps < 3 do
		table.insert(arg_10_0.maps, (function(arg_21_0)
			local var_21_0 = {
				_tf = arg_21_0,
				rtLine = arg_21_0:Find("line"),
				rtIcon = arg_21_0:Find("icon"),
				rtSimple = arg_21_0:Find("simple")
			}

			setParent(arg_21_0, arg_10_0.scrollMap)
			SetCompomentEnabled(arg_21_0, typeof(Image), false)

			arg_21_0.name = "map_tpl"

			SetAction(var_21_0.rtIcon:Find("model"):GetChild(0), "normal")

			return var_21_0
		end)(tf(Instantiate(arg_10_0.rtMap))))
	end

	Canvas.ForceUpdateCanvases()

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.maps) do
		setParent(iter_10_1.rtLine, arg_10_0.scrollMap:Find("bg"), true)
	end

	GetComponent(arg_10_0.textTip, "RichText"):AddSprite("pt", GetSpriteFromAtlas(Drop.New({
		type = DROP_TYPE_VITEM,
		id = arg_10_0.ptId
	}):getIcon(), ""))
	setText(arg_10_0.textTip, i18n("battlepass_main_tip_" .. pg.battlepass_event_pt[arg_10_0.activity.id].map_name))

	local var_10_0 = arg_10_0.activity.stopTime - pg.TimeMgr.GetInstance():GetServerTime()

	setText(arg_10_0.textDay, i18n("battlepass_main_time", math.floor(var_10_0 / 0), math.floor(var_10_0 % 0 / 16)))

	local var_10_1 = GetComponent(arg_10_0.scrollMap, typeof(ScrollRect))
	local var_10_2 = var_10_1.content.rect.width / 3 / (var_10_1.content.rect.width - var_10_1.viewport.rect.width)

	onScroll(arg_10_0, arg_10_0.scrollMap, function(arg_22_0)
		if arg_22_0.x < 0.1 then
			var_10_1.normalizedPosition.x = arg_22_0.x + var_10_2
			var_10_1.normalizedPosition = var_10_1.normalizedPosition
			var_10_1.velocity = var_10_1.velocity
		elseif arg_22_0.x > 0.9 then
			var_10_1.normalizedPosition.x = arg_22_0.x - var_10_2
			var_10_1.normalizedPosition = var_10_1.normalizedPosition
			var_10_1.velocity = var_10_1.velocity
		end

		return
	end)
	arg_10_0:onScroll(arg_10_0.comScroll, function(arg_23_0)
		arg_10_0:updateNextAward(arg_23_0.y)

		return
	end)
	arg_10_0:updateAwardPanel()
	arg_10_0:buildPhaseAwardScrollPos()

	if arg_10_0.phase == 0 then
		arg_10_0.comScroll:ScrollTo(0)
	elseif arg_10_0.phase == #arg_10_0.awardList then
		arg_10_0.comScroll:ScrollTo(1)
	else
		arg_10_0.comScroll:ScrollTo(math.clamp(arg_10_0.phasePos[arg_10_0.phase], 0, 1))
	end

	arg_10_0:updateMapStatus()
	LoadImageSpriteAtlasAsync(Drop.New({
		type = DROP_TYPE_VITEM,
		id = arg_10_0.ptId
	}):getIcon(), "", arg_10_0.sliderPt:Find("Text/icon"), true)
	arg_10_0:updateMapWay()

	return
end

function var_0_0.willExit(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.LTDic) do
		if iter_24_1 then
			LeanTween.cancel(iter_24_0)
		end
	end

	local var_24_0 = PoolMgr.GetInstance()

	for iter_24_2, iter_24_3 in ipairs(arg_24_0.maps) do
		setParent(iter_24_3.rtLine, iter_24_3._tf, true)

		local var_24_1 = iter_24_3.rtIcon:Find("model")

		var_24_0:ReturnSpineChar(pg.battlepass_event_pt[arg_24_0.activity.id].spine_name, go(var_24_1:GetChild(0)))
		var_24_0:ReturnPrefab("crusingmap/" .. pg.battlepass_event_pt[arg_24_0.activity.id].crusing_map, "", go(iter_24_3._tf))
	end

	if arg_24_0.chargeTipWindow then
		arg_24_0.chargeTipWindow:Destroy()

		arg_24_0.chargeTipWindow = nil
	end

	return
end

function var_0_0.setActivity(arg_25_0, arg_25_1)
	arg_25_0.activity = arg_25_1

	for iter_25_0, iter_25_1 in pairs(arg_25_1:GetCrusingInfo()) do
		arg_25_0[iter_25_0] = iter_25_1
	end

	return
end

function var_0_0.setPlayer(arg_26_0, arg_26_1)
	arg_26_0.player = arg_26_1

	return
end

function var_0_0.updateAwardInfo(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_2.pt <= arg_27_0.pt

	if arg_27_1:Find("mask") then
		setActive(arg_27_1:Find("mask"), not var_27_0)
	end

	setText(arg_27_1:Find("Text"), arg_27_2.id)
	updateDrop(arg_27_1:Find("award"), (Drop.Create(arg_27_2.award)))
	setActive(arg_27_1:Find("award/get"), var_27_0 and not arg_27_0.awardDic[arg_27_2.pt])
	setActive(arg_27_1:Find("award/got"), arg_27_0.awardDic[arg_27_2.pt])
	setActive(arg_27_1:Find("award/mask"), arg_27_0.awardDic[arg_27_2.pt])
	onButton(arg_27_0, arg_27_1:Find("award"), function()
		arg_27_0:emit(var_0_0.ON_DROP, var_0)

		return
	end, SFX_CONFIRM)
	updateDrop(arg_27_1:Find("award_pay"), (Drop.Create(arg_27_2.award_pay)))
	setActive(arg_27_1:Find("award_pay/lock"), not arg_27_0.isPay)

	local var_27_1 = arg_27_0.isPay and var_27_0 and not arg_27_0.awardPayDic[arg_27_2.pt]

	setActive(arg_27_1:Find("award_pay/get"), var_27_1)
	setActive(arg_27_1:Find("award_pay/got"), arg_27_0.awardPayDic[arg_27_2.pt])
	setActive(arg_27_1:Find("award_pay/mask"), not arg_27_0.isPay or arg_27_0.awardPayDic[arg_27_2.pt])
	onButton(arg_27_0, arg_27_1:Find("award_pay"), function()
		arg_27_0:emit(var_0_0.ON_DROP, var_0)

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.updateAwardPanel(arg_30_0)
	setText(arg_30_0.textPhase, arg_30_0.phase)

	if arg_30_0.phase < #arg_30_0.awardList then
		local var_30_0 = arg_30_0.pt - (arg_30_0.phase == 0 and 0 or arg_30_0.awardList[arg_30_0.phase].pt)

		setSlider(arg_30_0.sliderPt, 0, arg_30_0.awardList[arg_30_0.phase + 1].pt - (arg_30_0.phase == 0 and 0 or arg_30_0.awardList[arg_30_0.phase].pt), arg_30_0.pt - (arg_30_0.phase == 0 and 0 or arg_30_0.awardList[arg_30_0.phase].pt))
		setText(arg_30_0.sliderPt:Find("Text"), var_30_0 .. "/" .. arg_30_0.awardList[arg_30_0.phase + 1].pt - (arg_30_0.phase == 0 and 0 or arg_30_0.awardList[arg_30_0.phase].pt))
	else
		setSlider(arg_30_0.sliderPt, 0, 1, 1)
		setText(arg_30_0.sliderPt:Find("Text"), "MAX")
	end

	arg_30_0.nextAward = nil

	arg_30_0.comScroll:SetTotalCount(#arg_30_0.awardList - 1)
	arg_30_0:updateNextAward(arg_30_0.comScroll.value)

	local var_30_1 = #arg_30_0.activity:GetCrusingUnreceiveAward() > 0

	setActive(arg_30_0.btnAll, not arg_30_0.isPay and var_30_1)
	setActive(arg_30_0.btnPay, not arg_30_0.isPay)
	setActive(arg_30_0.rtAward:Find("text_image_3"), not arg_30_0.isPay)

	local var_30_2 = arg_30_0.isPay and arg_30_0.phase == #arg_30_0.awardList and not var_30_1

	setActive(arg_30_0.btnFinish, var_30_2)

	local var_30_3 = arg_30_0.isPay and not isActive(arg_30_0.btnFinish)

	setActive(arg_30_0.btnAfter, var_30_3)
	setButtonEnabled(arg_30_0.btnAfter, var_30_1)

	return
end

function var_0_0.updateMapStatus(arg_31_0)
	for iter_31_0, iter_31_1 in ipairs(arg_31_0.maps) do
		local var_31_0
		local var_31_1 = {}

		eachChild(iter_31_1.rtLine, function(arg_32_0)
			local var_32_0 = tonumber(arg_32_0.name)

			if var_32_0 > arg_31_0.phase then
				if not var_31_0 then
					var_31_0 = var_32_0

					table.insert(var_31_1, arg_32_0)
					setActive(arg_32_0, true)
				elseif var_32_0 < var_31_0 then
					while #var_31_1 > 0 do
						setActive(table.remove(var_31_1), false)
					end

					var_31_0 = var_32_0

					table.insert(var_31_1, arg_32_0)
					setActive(arg_32_0, true)
				elseif var_31_0 == var_32_0 then
					table.insert(var_31_1, arg_32_0)
					setActive(arg_32_0, true)
				else
					setActive(arg_32_0, false)
				end
			else
				setActive(arg_32_0, true)
			end

			local var_32_1 = var_32_0 > arg_31_0.phase

			setGray(arg_32_0, not (var_32_0 > arg_31_0.phase), false)
			setImageAlpha(arg_32_0, var_32_1 and 1 or 0.9)

			if isActive(arg_32_0) then
				local function var_32_3(arg_33_0, arg_33_1)
					local var_33_0 = getImageSprite(arg_33_0)

					if var_33_0 then
						setImageSprite(arg_33_1, var_33_0)
					end

					eachChild(arg_33_0, function(arg_34_0)
						var_32_3(arg_34_0, arg_33_1:Find(arg_34_0.name))

						return
					end)

					return
				end

				local var_32_4 = iter_31_1.rtSimple:Find(var_32_1 and "active" or "gray")

				eachChild(arg_32_0, function(arg_35_0)
					var_32_3(var_32_4:Find(arg_35_0.name), arg_35_0)

					return
				end)
			end

			return
		end)
	end

	return
end

function var_0_0.updateMapWay(arg_36_0)
	if arg_36_0.exited or arg_36_0.contextData.frozenMapUpdate then
		return
	end

	local var_36_0 = PlayerPrefs.GetInt(string.format("crusing_%d_phase_display", arg_36_0.activity.id), 0)

	PlayerPrefs.SetInt(string.format("crusing_%d_phase_display", arg_36_0.activity.id), arg_36_0.phase)

	for iter_36_0, iter_36_1 in ipairs(arg_36_0.maps) do
		local var_36_1 = GetComponent(iter_36_1.rtIcon, typeof(Animator))

		if var_36_0 < arg_36_0.phase then
			local var_36_2 = arg_36_0.PhaseFrame[arg_36_0.phase]

			var_36_1.speed = var_0_0.PlaySpeed

			var_36_1:Play("empty")
			var_36_1:Play("mix", 0, arg_36_0.PhaseFrame[var_36_0] / arg_36_0.AllFrameCount)

			if iter_36_1.rtIcon:Find("model").childCount > 0 then
				local var_36_3 = iter_36_1.rtIcon:Find("model")

				SetAction(var_36_3:GetChild(0), "move")
			end

			local var_36_4

			arg_36_0.LTDic[LeanTween.delayedCall((arg_36_0.PhaseFrame[arg_36_0.phase] - arg_36_0.PhaseFrame[var_36_0]) / var_0_0.FrameSpeed / var_0_0.PlaySpeed, System.Action(function()
				var_36_1.speed = 0

				var_36_1:Play("empty")
				var_36_1:Play("mix", 0, var_36_2 / arg_36_0.AllFrameCount)

				arg_36_0.LTDic[var_36_4] = false

				if iter_36_1.rtIcon:Find("model").childCount > 0 then
					SetAction(iter_36_1.rtIcon:Find("model"):GetChild(0), "normal")
				end

				return
			end)).uniqueId] = true
		else
			var_36_1.speed = 0

			var_36_1:Play("empty")
			var_36_1:Play("mix", 0, arg_36_0.PhaseFrame[arg_36_0.phase] / arg_36_0.AllFrameCount)
		end
	end

	return
end

function var_0_0.buildPhaseAwardScrollPos(arg_38_0)
	arg_38_0.phasePos = {}

	for iter_38_0 = 1, #arg_38_0.awardList - 1 do
		table.insert(arg_38_0.phasePos, arg_38_0.comScroll:HeadIndexToValue(iter_38_0 - 1))
	end

	return
end

function var_0_0.onScroll(arg_39_0, arg_39_1, arg_39_2)
	assert(arg_39_2, "callback should exist")
	arg_39_1.onValueChanged:RemoveAllListeners()
	pg.DelegateInfo.Add(arg_39_0, arg_39_1.onValueChanged)
	arg_39_1.onValueChanged:AddListener(arg_39_2)

	return
end

function var_0_0.updateNextAward(arg_40_0, arg_40_1)
	if not arg_40_0.phasePos then
		return
	end

	local var_40_0 = arg_40_0.phasePos[#arg_40_0.phasePos] - 1
	local var_40_1 = #arg_40_0.awardList

	for iter_40_0 = #arg_40_0.awardList - 1, 1, -1 do
		if arg_40_0.phasePos[iter_40_0] < arg_40_1 + var_40_0 or arg_40_0.awardList[iter_40_0].pt <= arg_40_0.pt then
			break
		elseif arg_40_0.awardList[iter_40_0].isImportent then
			var_40_1 = iter_40_0
		end
	end

	if arg_40_0.nextAward ~= var_40_1 then
		arg_40_0.nextAward = var_40_1

		arg_40_0:updateAwardInfo(arg_40_0.rtNextAward, arg_40_0.awardList[var_40_1])
	end

	return
end

function var_0_0.checkLimitMax(arg_41_0, arg_41_1)
	for iter_41_0, iter_41_1 in ipairs(arg_41_1) do
		if iter_41_1.type == DROP_TYPE_RESOURCE then
			if iter_41_1.id == 1 then
				if arg_41_0.player:GoldMax(iter_41_1.count) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title"))

					return true
				end
			elseif iter_41_1.id == 2 and arg_41_0.player:OilMax(iter_41_1.count) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("oil_max_tip_title"))

				return true
			end
		elseif iter_41_1.type == DROP_TYPE_ITEM then
			local var_41_0 = Item.getConfigData(iter_41_1.id)

			if var_41_0.type == Item.EXP_BOOK_TYPE then
				local var_41_1 = getProxy(BagProxy)

				if var_41_1:getItemCountById(iter_41_1.id) + iter_41_1.count > var_41_0.max_num then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.openBuyPanel(arg_42_0)
	local var_42_0 = Goods.Create({
		shop_id = arg_42_0:getPassID()
	}, Goods.TYPE_CHARGE)
	local var_42_2 = {
		isChargeType = true,
		commodity = var_42_0,
		infoTip = var_42_0:GetInfoTip(),
		icon = "chargeicon/" .. var_42_0:getConfig("picture"),
		name = var_42_0:getConfig("name_display"),
		tipExtra = i18n("battlepass_pay_tip"),
		extraItems = var_42_0:GetExtraServiceItem(),
		price = var_42_0:getConfig("money"),
		isLocalPrice = var_42_0:IsLocalPrice(),
		tagType = var_42_0:getConfig("tag"),
		isMonthCard = var_42_0:isMonthCard()
	}

	var_42_2.tipBonus = nil
	var_42_2.bonusItem = nil
	var_42_2.extraDrop = var_42_0:GetExtraDrop()
	var_42_2.descExtra = var_42_0:getConfig("descrip_extra")

	function var_42_2.onYes()
		if ChargeConst.isNeedSetBirth() then
			arg_42_0:emit(CrusingMediator.EVENT_OPEN_BIRTHDAY)
		else
			pg.m02:sendNotification(GAME.CHARGE_OPERATION, {
				shopId = var_42_0.id
			})
		end

		return
	end

	arg_42_0:emit(CrusingMediator.EVENT_GO_CHARGE, var_42_2)

	return
end

function var_0_0.getPassID(arg_44_0)
	local var_44_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING)

	if var_44_0 and not var_44_0:isEnd() then
		for iter_44_0, iter_44_1 in ipairs(pg.pay_data_display.all) do
			if pg.pay_data_display[iter_44_1].sub_display and type(pg.pay_data_display[iter_44_1].sub_display) == "table" and pg.pay_data_display[iter_44_1].sub_display[1] == var_44_0.id then
				return iter_44_1
			end
		end
	end

	return
end

function var_0_0.OnChargeSuccess(arg_45_0, arg_45_1)
	arg_45_0.chargeTipWindow:ExecuteAction("Show", arg_45_1)

	return
end

return var_0_0
