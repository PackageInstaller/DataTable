local var_0_0 = class("FeastMakeTicketPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "FeastPuzzlePage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.back = arg_2_0._tf:Find("back")
	arg_2_0.finishTr = arg_2_0._tf:Find("finish")
	arg_2_0.envelopesAnim = arg_2_0.finishTr:Find("envelopes"):GetComponent(typeof(SpineAnimUI))
	arg_2_0.sendBtn = arg_2_0.finishTr:Find("send")
	arg_2_0.titleTr = arg_2_0.finishTr:Find("label1")
	arg_2_0.failedTip = arg_2_0._tf:Find("failed_tip")
	arg_2_0.descTr = arg_2_0._tf:Find("desc_panel")
	arg_2_0.descTxt = arg_2_0.descTr:Find("frame/Text"):GetComponent(typeof(Text))
	arg_2_0.homeBtn = arg_2_0._tf:Find("home")
	arg_2_0.helpBtn = arg_2_0._tf:Find("help")
	arg_2_0.tipTopTr = arg_2_0._tf:Find("tip")

	setText(arg_2_0._tf:Find("tip/Text"), i18n("feast_label_make_ticket_tip"))
	setText(arg_2_0._tf:Find("tip/label"), i18n("feast_label_make_ticket_click_tip"))
	setText(arg_2_0._tf:Find("failed_tip/Text"), i18n("feast_label_make_ticket_failed_tip"))

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0:bind(FeastScene.ON_MAKE_TICKET, function(arg_4_0, arg_4_1)
		arg_3_0:OnMakeTicket(arg_4_1)

		return
	end)

	return
end

function var_0_0.OnMakeTicket(arg_5_0, arg_5_1)
	if arg_5_0.feastShip and arg_5_0.feastShip.id == arg_5_1 then
		setActive(arg_5_0.finishTr, true)
		setActive(arg_5_0.tipTopTr, false)

		arg_5_0.sendBtn.localScale = Vector3.zero
		arg_5_0.titleTr.localScale = Vector3.zero

		arg_5_0.envelopesAnim:SetActionCallBack(function(arg_6_0)
			if arg_6_0 == "finish" then
				LeanTween.scale(arg_5_0.sendBtn, Vector3(1, 1, 1), 0.3)
				LeanTween.scale(arg_5_0.titleTr, Vector3(1, 1, 1), 0.3)
				arg_5_0.envelopesAnim:SetActionCallBack(nil)
				arg_5_0.envelopesAnim:SetAction("action2", 0)
			end

			return
		end)
		arg_5_0.envelopesAnim:SetAction("action1", 0)
	end

	return
end

function var_0_0.Show(arg_7_0, arg_7_1)
	Input.multiTouchEnabled = false

	var_0_0.super.Show(arg_7_0)
	arg_7_0:CloseTip()
	setActive(arg_7_0.tipTopTr, true)
	setActive(arg_7_0.finishTr, false)

	arg_7_0.feastShip = arg_7_1

	seriesAsync({
		function(arg_8_0)
			arg_7_0:LoadPuzzleRes(arg_7_1:GetPrefab(), arg_8_0)

			return
		end
	}, function()
		arg_7_0:InitPuzzle()
		arg_7_0:RegisterEvent()

		return
	end)

	return
end

function var_0_0.LoadPuzzleRes(arg_10_0, arg_10_1, arg_10_2)
	ResourceMgr.Inst:getAssetAsync("FeastPuzzle/" .. arg_10_1, "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_11_0)
		if arg_10_0.exited then
			return
		end

		arg_10_0.puzzleGo = Object.Instantiate(arg_11_0, arg_10_0._tf:Find("container"))
		arg_10_0.rect = arg_10_0.puzzleGo.transform:Find("nodes")
		arg_10_0.items = {}

		eachChild(arg_10_0.rect, function(arg_12_0)
			local var_12_0 = tonumber(arg_12_0.name)

			table.insert(arg_10_0.items, {
				level = var_12_0,
				tr = arg_12_0,
				isCompletion = var_12_0 == 1
			})

			return
		end)
		arg_10_2()

		return
	end), true, true)

	return
end

local function var_0_1(arg_13_0, arg_13_1)
	return (LuaHelper.ScreenToLocal(arg_13_0:GetComponent("RectTransform"), arg_13_1, pg.UIMgr.GetInstance().overlayCameraComp))
end

function var_0_0.InitPuzzle(arg_14_0, arg_14_1)
	arg_14_0.dragging = false

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.items) do
		local var_14_0 = iter_14_1.tr:GetComponent(typeof(EventTriggerListener))
		local var_14_1 = Vector3.zero

		var_14_0:AddBeginDragFunc(function(arg_15_0, arg_15_1)
			arg_14_0.dragging = true
			var_14_1 = iter_14_1.tr.localPosition

			iter_14_1.tr:SetAsLastSibling()

			return
		end)
		var_14_0:AddDragFunc(function(arg_16_0, arg_16_1)
			iter_14_1.tr.localPosition = var_0_1(arg_14_0.rect, arg_16_1.position)

			return
		end)
		var_14_0:AddDragEndFunc(function(arg_17_0, arg_17_1)
			arg_14_0.dragging = false

			local var_17_0 = arg_14_0:FindMatcher(iter_14_1)

			if var_17_0 then
				arg_14_0:Merge(iter_14_1, var_17_0, var_14_1)

				if arg_14_0:CheckFinish() then
					arg_14_0:OnPass()
				end
			else
				arg_14_0:ShowTip()

				iter_14_1.tr.localPosition = var_14_1
			end

			return
		end)
		var_14_0:AddPointUpFunc(function(arg_18_0, arg_18_1)
			if arg_14_0.dragging then
				return
			end

			arg_14_0:ShowDesc(iter_14_1)

			return
		end)
	end

	return
end

function var_0_0.ShowTip(arg_19_0)
	arg_19_0:CloseTip()
	setActive(arg_19_0.failedTip, true)

	arg_19_0.timer = Timer.New(function()
		arg_19_0:CloseTip()

		return
	end, 2, 1)

	arg_19_0.timer:Start()

	return
end

function var_0_0.CloseTip(arg_21_0)
	if arg_21_0.timer then
		setActive(arg_21_0.failedTip, false)
		arg_21_0.timer:Stop()

		arg_21_0.timer = nil
	end

	return
end

function var_0_0.CheckFinish(arg_22_0)
	return arg_22_0.rect.childCount == 1
end

function var_0_0.Merge(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if arg_23_2.level < arg_23_1.level then
		arg_23_1.tr.localPosition = arg_23_3

		setParent(arg_23_2.tr, arg_23_1.tr:Find("slot"))

		arg_23_2.tr.localPosition = Vector3.zero

		arg_23_0:ClearEvent(arg_23_2.tr)

		arg_23_1.isCompletion = true
	else
		setParent(arg_23_1.tr, arg_23_2.tr:Find("slot"))

		arg_23_1.tr.localPosition = Vector3.zero

		arg_23_0:ClearEvent(arg_23_1.tr)

		arg_23_2.isCompletion = true
	end

	return
end

local function var_0_2(arg_24_0, arg_24_1)
	return getBounds(arg_24_0.tr):Intersects((getBounds(arg_24_1.tr)))
end

local function var_0_3(arg_25_0, arg_25_1)
	if arg_25_0.level < arg_25_1.level then
		return arg_25_0.isCompletion
	else
		return arg_25_1.isCompletion
	end

	return
end

function var_0_0.FindMatcher(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.items) do
		if (arg_26_1.level + 1 == iter_26_1.level or arg_26_1.level - 1 == iter_26_1.level) and var_0_3(arg_26_1, iter_26_1) and var_0_2(arg_26_1, iter_26_1) then
			return iter_26_1
		end
	end

	return nil
end

function var_0_0.OnPass(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0.items) do
		arg_27_0:ClearEvent(iter_27_1.tr)
	end

	setActive(arg_27_0.rect, false)
	arg_27_0:emit(FeastMediator.MAKE_TICKET, arg_27_0.feastShip.tid)

	return
end

function var_0_0.RegisterEvent(arg_28_0, arg_28_1)
	onButton(arg_28_0, arg_28_0.back, function()
		arg_28_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_28_0, arg_28_0.sendBtn, function()
		arg_28_0:Hide()
		arg_28_0:emit(FeastScene.ON_SKIP_GIVE_GIFT, arg_28_0.feastShip)

		return
	end, SFX_PANEL)
	onButton(arg_28_0, arg_28_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.feast_make_invitation_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_28_0, arg_28_0.homeBtn, function()
		arg_28_0:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.ShowDesc(arg_33_0, arg_33_1)
	arg_33_0.isShowDesc = true

	pg.UIMgr.GetInstance():BlurPanel(arg_33_0.descTr)
	setActive(arg_33_0.descTr, true)

	arg_33_0.descNode = Object.Instantiate(arg_33_1.tr.gameObject, arg_33_0.descTr)
	arg_33_0.descNode.transform.localPosition = Vector3(0, 100, 0)
	arg_33_0.descTxt.text = i18n("feast_invitation_part" .. arg_33_1.level)

	onButton(arg_33_0, arg_33_0.descTr, function()
		arg_33_0:HideDesc()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.HideDesc(arg_35_0)
	if not arg_35_0.isShowDesc then
		return
	end

	arg_35_0.isShowDesc = false

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_35_0.descTr, arg_35_0._tf)

	if arg_35_0.descNode then
		Object.Destroy(arg_35_0.descNode.gameObject)

		arg_35_0.descNode = nil
	end

	setActive(arg_35_0.descTr, false)

	return
end

function var_0_0.Clear(arg_36_0)
	arg_36_0.envelopesAnim:SetActionCallBack(nil)
	arg_36_0:CloseTip()

	for iter_36_0, iter_36_1 in ipairs(arg_36_0.items) do
		arg_36_0:ClearEvent(iter_36_1.tr)
	end

	arg_36_0.items = {}

	if arg_36_0.puzzleGo then
		Object.Destroy(arg_36_0.puzzleGo)

		arg_36_0.puzzleGo = nil
	end

	removeOnButton(arg_36_0.back)

	if LeanTween.isTweening(arg_36_0.sendBtn.gameObject) then
		LeanTween.cancel(arg_36_0.sendBtn.gameObject)
	end

	if LeanTween.isTweening(arg_36_0.titleTr.gameObject) then
		LeanTween.cancel(arg_36_0.titleTr.gameObject)
	end

	arg_36_0:HideDesc()

	return
end

function var_0_0.ClearEvent(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_1:GetComponent(typeof(EventTriggerListener))

	var_37_0:AddBeginDragFunc(nil)
	var_37_0:AddDragFunc(nil)
	var_37_0:AddDragEndFunc(nil)
	var_37_0:AddPointUpFunc(nil)

	for iter_37_0, iter_37_1 in ipairs((arg_37_1:GetComponentsInChildren(typeof(Image)):ToTable())) do
		iter_37_1.raycastTarget = false
	end

	return
end

function var_0_0.Hide(arg_38_0)
	Input.multiTouchEnabled = true

	var_0_0.super.Hide(arg_38_0)
	arg_38_0:Clear()

	return
end

function var_0_0.OnDestroy(arg_39_0)
	arg_39_0.exited = true

	arg_39_0:Clear()

	if arg_39_0:isShowing() then
		arg_39_0:Hide()
	end

	return
end

return var_0_0
