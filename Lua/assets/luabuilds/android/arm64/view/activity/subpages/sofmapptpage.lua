local var_0_0 = class("SofmapPTPage", import(".TemplatePage.PtTemplatePage"))

var_0_0.FADE_TIME = 0.5
var_0_0.SHOW_TIME = 1
var_0_0.FADE_OUT_TIME = 0.5
var_0_0.SpineActionByStep = {
	4,
	8,
	12,
	16,
	20
}

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)

	arg_1_0.shop = arg_1_0.bg:Find("shop")
	arg_1_0.shopAnim = GetComponent(arg_1_0.shop, "SpineAnimUI")
	arg_1_0.sdContainer = arg_1_0.bg:Find("sdcontainer")
	arg_1_0.spine = nil
	arg_1_0.spineLRQ = GetSpineRequestPackage.New("mingshi_5", function(arg_2_0)
		SetParent(arg_2_0, arg_1_0.sdContainer)

		arg_1_0.spine = arg_2_0
		arg_1_0.spine.transform.localScale = Vector3.one

		local var_2_0 = arg_1_0.spine:GetComponent("SpineAnimUI")

		if var_2_0 then
			var_2_0:SetAction("stand", 0)
		end

		arg_1_0.spineLRQ = nil

		return
	end):Start()

	onButton(arg_1_0, arg_1_0.bg:Find("sdBtn"), function()
		arg_1_0:showBubble()

		return
	end, SFX_PANEL)

	arg_1_0.levelBtn = arg_1_0.bg:Find("level_btn")
	arg_1_0.ptBtn = arg_1_0.bg:Find("pt_btn")
	arg_1_0.bubble = arg_1_0.bg:Find("bubble")
	arg_1_0.bubbleText = arg_1_0.bubble:Find("Text")
	arg_1_0.bubbleCG = GetComponent(arg_1_0.bubble, "CanvasGroup")
	arg_1_0.showBubbleTag = false

	onButton(arg_1_0, arg_1_0.getBtn, function()
		local var_4_0, var_4_1 = arg_1_0.ptData:GetResProgress()

		arg_1_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = arg_1_0.ptData:GetId(),
			arg1 = var_4_1,
			callback = function()
				arg_1_0:showBubble(i18n("sofmapsd_3"))

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.levelBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.sofmap_attention.tip
		})

		return
	end, SFX_PANEL)

	local var_1_0 = {
		count = 0,
		type = DROP_TYPE_RESOURCE,
		id = arg_1_0.ptData.resId
	}

	onButton(arg_1_0, arg_1_0.ptBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_SINGLE_ITEM,
			drop = var_1_0
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_8_0)
	var_0_0.super.OnUpdateFlush(arg_8_0)

	local var_8_0, var_8_1, var_8_2 = arg_8_0.ptData:GetResProgress()
	local var_8_3 = var_8_2 >= 1 and setColorStr(var_8_0, "#68E9F4FF") or var_8_0

	setText(arg_8_0.progress, var_8_3 .. "/" .. var_8_1)

	local var_8_4, var_8_5, var_8_6 = arg_8_0.ptData:GetLevelProgress()

	if var_8_4 <= var_0_0.SpineActionByStep[1] then
		arg_8_0.shopAnim:SetAction("stand2", 0)
	elseif var_8_4 <= var_0_0.SpineActionByStep[2] then
		arg_8_0.shopAnim:SetAction("stand1", 0)
	elseif var_8_4 <= var_0_0.SpineActionByStep[3] then
		arg_8_0.shopAnim:SetAction("stand1x2", 0)
	elseif var_8_4 <= var_0_0.SpineActionByStep[4] then
		arg_8_0.shopAnim:SetAction("stand1x4", 0)
	elseif var_8_4 <= var_0_0.SpineActionByStep[5] then
		arg_8_0.shopAnim:SetAction("stand1x8", 0)
	end

	if not arg_8_0.showBubbleTag then
		arg_8_0:showBubble()

		arg_8_0.showBubbleTag = true
	end

	return
end

function var_0_0.OnDestroy(arg_9_0)
	if arg_9_0.spineLRQ then
		arg_9_0.spineLRQ:Stop()

		arg_9_0.spineLRQ = nil
	end

	if arg_9_0.spine then
		arg_9_0.spine.transform.localScale = Vector3.one

		pg.PoolMgr.GetInstance():ReturnSpineChar("mingshi_5", arg_9_0.spine)

		arg_9_0.spine = nil
	end

	return
end

function var_0_0.showBubble(arg_10_0, arg_10_1)
	local var_10_0

	if not arg_10_1 then
		if isActive(arg_10_0.battleBtn) then
			var_10_0 = i18n("sofmapsd_1")
		elseif isActive(arg_10_0.getBtn) then
			var_10_0 = i18n("sofmapsd_2")
		elseif isActive(arg_10_0.gotBtn) then
			var_10_0 = i18n("sofmapsd_4")
		end
	else
		var_10_0 = arg_10_1
	end

	setText(arg_10_0.bubbleText, var_10_0)

	local function var_10_1(arg_11_0)
		arg_10_0.bubbleCG.alpha = arg_11_0

		setLocalScale(arg_10_0.bubble, Vector3.one * arg_11_0)

		return
	end

	local function var_10_2()
		LeanTween.value(go(arg_10_0.bubble), 1, 0, var_0_0.FADE_OUT_TIME):setOnUpdate(System.Action_float(var_10_1)):setOnComplete(System.Action(function()
			setActive(arg_10_0.bubble, false)

			return
		end))

		return
	end

	LeanTween.cancel(go(arg_10_0.bubble))
	setActive(arg_10_0.bubble, true)
	LeanTween.value(go(arg_10_0.bubble), 0, 1, var_0_0.FADE_TIME):setOnUpdate(System.Action_float(function(arg_11_0)
		arg_10_0.bubbleCG.alpha = arg_11_0

		setLocalScale(arg_10_0.bubble, Vector3.one * arg_11_0)

		return
	end)):setOnComplete(System.Action(function()
		LeanTween.delayedCall(go(arg_10_0.bubble), var_0_0.SHOW_TIME, System.Action(var_10_2))

		return
	end))

	return
end

return var_0_0
