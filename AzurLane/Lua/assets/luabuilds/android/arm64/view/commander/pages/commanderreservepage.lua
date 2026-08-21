local var_0_0 = class("CommanderReservePage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "CommanderReserveUI"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.bg1 = arg_2_0._tf:Find("frame/bg1")

	setActive(arg_2_0.bg1, true)

	arg_2_0.minusBtn = arg_2_0.bg1:Find("count/min")
	arg_2_0.addBtn = arg_2_0.bg1:Find("count/add")
	arg_2_0.countTxt = arg_2_0.bg1:Find("count/Text"):GetComponent(typeof(Text))
	arg_2_0.consumeTxt = arg_2_0.bg1:Find("price/Text"):GetComponent(typeof(Text))
	arg_2_0.totalTxt = arg_2_0.bg1:Find("price_all/Text"):GetComponent(typeof(Text))
	arg_2_0.firstTip = arg_2_0.bg1:Find("firstTip")
	arg_2_0.confirmBtn = arg_2_0.bg1:Find("Button")
	arg_2_0.maxBtn = arg_2_0.bg1:Find("max")
	arg_2_0.bg2 = arg_2_0._tf:Find("frame/bg2")
	arg_2_0.box1 = arg_2_0.bg2:Find("boxes/1"):GetComponent(typeof(Image))
	arg_2_0.box2 = arg_2_0.bg2:Find("boxes/2"):GetComponent(typeof(Image))
	arg_2_0.box3 = arg_2_0.bg2:Find("boxes/3"):GetComponent(typeof(Image))
	arg_2_0.box4 = arg_2_0.bg2:Find("boxes/4"):GetComponent(typeof(Image))
	arg_2_0.skipBtn = arg_2_0.bg2:Find("Button")
	arg_2_0.animtion = arg_2_0.bg2:GetComponent(typeof(Animation))
	arg_2_0.aniEvt = arg_2_0.bg2:GetComponent(typeof(DftAniEvent))
	arg_2_0.boxes = arg_2_0.bg2:Find("boxes")
	arg_2_0.closeBg = arg_2_0._tf:Find("bg")
	arg_2_0.boxTF = arg_2_0.bg2:Find("box")
	arg_2_0.boxMove = arg_2_0.bg2:Find("boxMove")
	arg_2_0.tweenList = {}

	setActive(arg_2_0.bg2, false)

	arg_2_0.skip = false
	arg_2_0.block = false

	onButton(arg_2_0, arg_2_0.closeBg, function()
		if arg_2_0.block then
			return
		end

		arg_2_0:Hide()

		return
	end, SFX_PANEL)
	pressPersistTrigger(arg_2_0.minusBtn, 0.5, function(arg_4_0)
		if arg_2_0.currCnt == 1 then
			arg_4_0()

			return
		end

		arg_2_0.currCnt = arg_2_0.currCnt - 1

		arg_2_0:updateValue()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(arg_2_0.addBtn, 0.5, function(arg_5_0)
		if arg_2_0.currCnt > CommanderConst.MAX_GETBOX_CNT - arg_2_0.count - 1 then
			arg_5_0()

			return
		end

		arg_2_0.currCnt = arg_2_0.currCnt + 1

		arg_2_0:updateValue()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.skipBtn, function()
		arg_2_0.skip = true

		arg_2_0.animtion:Stop()
		arg_2_0:endAnim()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.maxBtn, function()
		local var_7_0 = getProxy(PlayerProxy):getRawData():getResById(1)
		local var_7_1 = 0
		local var_7_2 = 0

		for iter_7_0 = arg_2_0.count, arg_2_0.count + (CommanderConst.MAX_GETBOX_CNT - arg_2_0.count) - 1 do
			var_7_2 = var_7_2 + CommanderConst.getBoxComsume(iter_7_0)

			if var_7_0 < var_7_2 then
				break
			else
				var_7_1 = var_7_1 + 1
			end
		end

		arg_2_0.currCnt = math.max(1, var_7_1)

		arg_2_0:updateValue()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.confirmBtn, function()
		if arg_2_0.currCnt > 0 then
			arg_2_0.skip = false

			arg_2_0:OnConfirm(arg_2_0.total, arg_2_0.currCnt)
		end

		return
	end, SFX_PANEL)
	setText(arg_2_0._tf:Find("frame/bg1/tip"), i18n("commander_build_rate_tip"))
	setText(arg_2_0._tf:Find("frame/bg1/label"), i18n("commander_get_box_tip"))
	setText(arg_2_0._tf:Find("frame/bg1/label1"), i18n("commander_total_gold"))
	setText(arg_2_0._tf:Find("frame/bg1/Text"), i18n("commander_get_box_tip_1"))

	return
end

function var_0_0.OnConfirm(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = getProxy(PlayerProxy):getRawData()
	local var_9_1

	if arg_9_1 > var_9_0.gold then
		arg_9_0:GoShoppingMsgBox(i18n("switch_to_shop_tip_2", i18n("word_gold")), ChargeScene.TYPE_ITEM, {
			{
				59001,
				arg_9_1 - var_9_0.gold,
				arg_9_1
			}
		})

		do return end

		var_9_1 = arg_9_0.contextData.msgBox.ExecuteAction
	end

	;({}).content = i18n(arg_9_1 <= 0 and "commander_get_1" or "commander_get", arg_9_1, arg_9_2)
	;({}).onYes = function()
		arg_9_0:emit(CommanderCatMediator.RESERVE_BOX, arg_9_2)

		return
	end

	var_9_1(arg_9_0.contextData.msgBox, "Show", {})

	return
end

function var_0_0.GoShoppingMsgBox(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_3 then
		local var_11_0 = ""

		for iter_11_0, iter_11_1 in ipairs(arg_11_3) do
			var_11_0 = var_11_0 .. i18n(iter_11_1[1] == 59001 and "text_noRes_info_tip" or "text_noRes_info_tip2", Item.getConfigData(iter_11_1[1]).name, iter_11_1[2])

			if iter_11_0 < #arg_11_3 then
				var_11_0 = var_11_0 .. i18n("text_noRes_info_tip_link")
			end
		end

		if var_11_0 ~= "" then
			arg_11_1 = arg_11_1 .. "\n" .. i18n("text_noRes_tip", var_11_0)
		end
	end

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		parent = rtf(pg.UIMgr.GetInstance().OverlayToast),
		content = arg_11_1,
		onYes = function()
			gotoChargeScene(arg_11_2, arg_11_3)

			return
		end
	})

	return
end

function var_0_0.OnLoaded(arg_13_0)
	arg_13_0:bind(CommanderCatScene.MSG_RESERVE_BOX, function(arg_14_0, arg_14_1)
		arg_13_0:OnReserveDone(arg_14_1)

		return
	end)

	return
end

function var_0_0.OnReserveDone(arg_15_0, arg_15_1)
	arg_15_0.block = true

	seriesAsync({
		function(arg_16_0)
			arg_15_0:PlayAnim(arg_15_1, arg_16_0)

			return
		end,
		function(arg_17_0)
			arg_15_0:Update()
			arg_15_0:emit(BaseUI.ON_AWARD, {
				items = arg_15_1
			})
			arg_17_0()

			return
		end
	}, function()
		arg_15_0.block = false

		return
	end)

	return
end

function var_0_0.updateValue(arg_19_0)
	arg_19_0.countTxt.text = arg_19_0.currCnt
	arg_19_0.consumeTxt.text = CommanderConst.getBoxComsume(arg_19_0.count + arg_19_0.currCnt - 1)
	arg_19_0.total = 0

	for iter_19_0 = arg_19_0.count, arg_19_0.count + arg_19_0.currCnt - 1 do
		arg_19_0.total = arg_19_0.total + CommanderConst.getBoxComsume(iter_19_0)
	end

	local var_19_0 = arg_19_0.totalTxt

	if getProxy(PlayerProxy):getRawData().gold < arg_19_0.total then
		var_19_0.text = "<color=" .. COLOR_RED .. ">" .. arg_19_0.total .. "</color>" or arg_19_0.total

		return
	end
end

function var_0_0.Update(arg_20_0)
	arg_20_0.count = getProxy(CommanderProxy):getBoxUseCnt()
	arg_20_0.currCnt = 1
	arg_20_0.total = 0

	arg_20_0:updateValue()
	setActive(arg_20_0.firstTip, arg_20_0.count <= 0)
	arg_20_0:Show()

	return
end

function var_0_0.endAnim(arg_21_0)
	setActive(arg_21_0.bg1, true)
	setActive(arg_21_0.bg2, false)

	for iter_21_0 = 0, arg_21_0.boxMove.childCount - 1 do
		Destroy((arg_21_0.boxMove:GetChild(iter_21_0)))
	end

	for iter_21_1, iter_21_2 in ipairs(arg_21_0.tweenList) do
		if iter_21_2 then
			LeanTween.cancel(iter_21_2)
		end
	end

	arg_21_0.tweenList = {}
	arg_21_0.skip = false

	if arg_21_0.callback then
		arg_21_0.callback()

		arg_21_0.callback = nil
	end

	return
end

function var_0_0.PlayAnim(arg_22_0, arg_22_1, arg_22_2)
	assert(arg_22_2)

	arg_22_0.callback = arg_22_2

	setActive(arg_22_0.bg1, false)
	setActive(arg_22_0.bg2, true)
	setActive(arg_22_0.boxes, true)

	if arg_22_0.skip then
		arg_22_0:endAnim()
	else
		arg_22_0.animtion:Play("reserve")

		local var_22_0 = 0
		local var_22_1 = 0

		arg_22_0.aniEvt:SetTriggerEvent(function(arg_23_0)
			for iter_23_0, iter_23_1 in ipairs(arg_22_1) do
				var_22_0 = var_22_0 + iter_23_0
			end

			for iter_23_2, iter_23_3 in ipairs(arg_22_1) do
				for iter_23_4 = 1, iter_23_3.count do
					table.insert(arg_22_0.tweenList, LeanTween.delayedCall(0.2 + 1 * var_22_1 + 1 * (iter_23_4 - 1), System.Action(function()
						arg_22_0:playBoxMove(iter_23_3)

						return
					end)).uniqueId)
				end

				var_22_1 = var_22_1 + iter_23_3.count
			end

			table.insert(arg_22_0.tweenList, LeanTween.delayedCall(0.2 + 1 * (var_22_1 - 1), System.Action(function()
				setActive(arg_22_0.boxes, false)

				return
			end)).uniqueId)
			table.insert(arg_22_0.tweenList, LeanTween.delayedCall(0.2 + 1 * (var_22_1 - 1) + 2, System.Action(function()
				arg_22_0:endAnim()

				return
			end)).uniqueId)

			return
		end)
	end

	return
end

function var_0_0.Show(arg_27_0)
	setActive(arg_27_0._tf, true)
	setActive(arg_27_0.bg1, true)
	setActive(arg_27_0.bg2, false)

	arg_27_0.skip = false

	pg.UIMgr.GetInstance():BlurPanel(arg_27_0._tf)

	return
end

function var_0_0.Hide(arg_28_0)
	var_0_0.super.Hide(arg_28_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_28_0._tf, arg_28_0._parentTf)

	return
end

function var_0_0.playBoxMove(arg_29_0, arg_29_1)
	local var_29_0 = cloneTplTo(arg_29_0.boxTF, arg_29_0.boxMove)

	if arg_29_1.id == 20011 then
		var_29_0:GetComponent(typeof(Image)).sprite = arg_29_0.box1.sprite
	elseif arg_29_1.id == 20012 then
		var_29_0:GetComponent(typeof(Image)).sprite = arg_29_0.box2.sprite
	elseif arg_29_1.id == 20013 then
		var_29_0:GetComponent(typeof(Image)).sprite = arg_29_0.box3.sprite
	end

	var_29_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		Destroy(go(var_29_0))

		return
	end)

	return
end

function var_0_0.OnDestroy(arg_31_0)
	if arg_31_0:isShowing() then
		arg_31_0:Hide()
	end

	return
end

return var_0_0
