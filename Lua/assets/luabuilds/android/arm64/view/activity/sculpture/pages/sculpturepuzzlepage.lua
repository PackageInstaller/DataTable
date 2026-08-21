local var_0_0 = class("SculpturePuzzlePage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "SculpturePuzzleUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.backBtn = arg_2_0._tf:Find("back")
	arg_2_0.lineTr = arg_2_0._tf:Find("frame/line")
	arg_2_0.frameTr = arg_2_0._tf:Find("frame")
	arg_2_0.tipBtn = arg_2_0._tf:Find("frame/tip")
	arg_2_0.tipGrayBtn = arg_2_0._tf:Find("frame/tip_gray")
	arg_2_0.tipGrayBtnTxt = arg_2_0.tipGrayBtn:Find("Text"):GetComponent(typeof(Text))

	setActive(arg_2_0.tipGrayBtn, false)
	setText(arg_2_0._tf:Find("frame/tip_text"), i18n("sculpture_puzzle_tip"))

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.slots = {}

	return
end

function var_0_0.Show(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	var_0_0.super.Show(arg_4_0)
	arg_4_0:Clear()

	arg_4_0.id = arg_4_1
	arg_4_0.activity = arg_4_2

	if arg_4_3 then
		arg_4_3()
	end

	seriesAsync({
		function(arg_5_0)
			arg_4_0:LoadLine(arg_5_0)

			return
		end,
		function(arg_6_0)
			arg_4_0:LoadPuzzle(arg_6_0)

			return
		end
	}, function()
		arg_4_0:RegisterEvent()

		return
	end)
	pg.BgmMgr.GetInstance():Push(arg_4_0.__cname, "bar-soft")

	return
end

function var_0_0.LoadLine(arg_8_0, arg_8_1)
	ResourceMgr.Inst:getAssetAsync("ui/" .. arg_8_0.activity:GetResorceName(arg_8_0.id) .. "_puzzle_line", "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_9_0)
		local var_9_0 = Object.Instantiate(arg_9_0, arg_8_0.lineTr)

		eachChild(var_9_0, function(arg_10_0)
			arg_8_0.slots[arg_10_0.gameObject.name] = {
				flag = false,
				tr = arg_10_0
			}

			return
		end)

		arg_8_0.puzzleLine = var_9_0

		arg_8_1()

		return
	end), true, true)

	return
end

function Screen2Local(arg_11_0, arg_11_1)
	return (LuaHelper.ScreenToLocal(arg_11_0:GetComponent("RectTransform"), arg_11_1, (GameObject.Find("UICamera"):GetComponent("Camera"))))
end

function TrPosition2LocalPos(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0 == arg_12_1 then
		return arg_12_2
	else
		local var_12_0 = arg_12_1:InverseTransformPoint((arg_12_0:TransformPoint(arg_12_2)))

		return Vector3(var_12_0.x, var_12_0.y, 0)
	end

	return
end

function var_0_0.HandlePuzzlePart(arg_13_0, arg_13_1)
	eachChild(arg_13_1, function(arg_14_0)
		local var_14_0 = arg_14_0:GetComponent(typeof(EventTriggerListener))
		local var_14_1
		local var_14_2

		var_14_0:AddBeginDragFunc(function()
			var_14_2 = arg_14_0:GetSiblingIndex()

			arg_14_0:SetAsLastSibling()

			var_14_1 = arg_14_0.localPosition

			return
		end)
		var_14_0:AddDragFunc(function(arg_16_0, arg_16_1)
			arg_14_0.localPosition = Screen2Local(arg_14_0.parent, arg_16_1.position)

			return
		end)
		var_14_0:AddDragEndFunc(function(arg_17_0, arg_17_1)
			local var_17_0 = TrPosition2LocalPos(arg_13_0.slots[arg_14_0.gameObject.name].tr.parent, arg_14_0.parent, arg_13_0.slots[arg_14_0.gameObject.name].tr.localPosition)

			if Vector2.Distance(var_17_0, arg_14_0.localPosition) < 50 then
				arg_13_0.slots[arg_14_0.gameObject.name].flag = true
				arg_14_0.localPosition = var_17_0

				ClearEventTrigger(var_14_0)
				Object.Destroy(var_14_0)

				if arg_13_0:IsFinishAll() then
					arg_13_0:emit(SculptureMediator.ON_JOINT_SCULPTURE, arg_13_0.id)
				end
			else
				arg_14_0.localPosition = var_14_1
			end

			arg_14_0:SetSiblingIndex(var_14_2)

			return
		end)

		return
	end)

	return
end

function var_0_0.IsFinishAll(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.slots) do
		if iter_18_1.flag == false then
			return false
		end
	end

	return true
end

function var_0_0.LoadPuzzle(arg_19_0, arg_19_1)
	ResourceMgr.Inst:getAssetAsync("ui/" .. arg_19_0.activity:GetResorceName(arg_19_0.id) .. "_puzzle", "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_20_0)
		local var_20_0 = Object.Instantiate(arg_20_0, arg_19_0.frameTr)

		arg_19_0:HandlePuzzlePart(var_20_0.transform)

		arg_19_0.puzzle = var_20_0

		arg_19_1()

		return
	end), true, true)

	return
end

function var_0_0.RegisterEvent(arg_21_0)
	onButton(arg_21_0, arg_21_0.backBtn, function()
		arg_21_0.contextData.miniMsgBox:ExecuteAction("Show", {
			showNo = true,
			content = i18n("sculpture_drawline_exit"),
			onYes = function()
				arg_21_0:Hide()

				return
			end
		})

		return
	end, SFX_PANEL)

	local var_21_0 = 0

	onButton(arg_21_0, arg_21_0.tipBtn, function()
		if arg_21_0:IsFinishAll() or var_21_0 > 0 then
			return
		end

		local var_24_0 = {}

		for iter_24_0, iter_24_1 in pairs(arg_21_0.slots) do
			if iter_24_1.flag == false then
				table.insert(var_24_0, iter_24_1.tr)
			end
		end

		if #var_24_0 == 0 then
			return
		end

		var_21_0 = 10

		arg_21_0:BlinkSlots({
			var_24_0[math.random(1, #var_24_0)]
		})
		setActive(arg_21_0.tipBtn, false)
		setActive(arg_21_0.tipGrayBtn, true)
		arg_21_0:AddTimer(function()
			var_21_0 = 0

			setActive(arg_21_0.tipBtn, true)
			setActive(arg_21_0.tipGrayBtn, false)

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.AddTimer(arg_26_0, arg_26_1)
	arg_26_0:ClearTimer()

	local var_26_0 = 11

	arg_26_0.timer = Timer.New(function()
		var_26_0 = var_26_0 - 1
		arg_26_0.tipGrayBtnTxt.text = var_26_0 .. "s"

		if var_26_0 <= 0 then
			arg_26_1()
		end

		return
	end, 1, 10)

	arg_26_0.timer.func()
	arg_26_0.timer:Start()

	return
end

function var_0_0.ClearTimer(arg_28_0)
	if arg_28_0.timer then
		arg_28_0.timer:Stop()

		arg_28_0.timer = nil
	end

	return
end

function var_0_0.BlinkSlots(arg_29_0, arg_29_1, arg_29_2)
	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		local var_29_0 = iter_29_1:GetComponent(typeof(Image)).color

		table.insert({}, function(arg_30_0)
			LeanTween.value(iter_29_1.gameObject, 0.5, 1, 0.3):setLoopPingPong(3):setOnUpdate(System.Action_float(function(arg_31_0)
				var_0.color = Color.New(var_29_0.r, var_29_0.g, var_29_0.b, arg_31_0)

				return
			end)):setOnComplete(System.Action(function()
				var_0.color = Color.New(var_29_0.r, var_29_0.g, var_29_0.b, 0)

				arg_30_0()

				return
			end))

			return
		end)
	end

	parallelAsync({}, arg_29_2)

	return
end

function var_0_0.Clear(arg_33_0)
	if arg_33_0.puzzleLine then
		Object.Destroy(arg_33_0.puzzleLine.gameObject)

		arg_33_0.puzzleLine = nil
	end

	if arg_33_0.puzzle then
		Object.Destroy(arg_33_0.puzzle.gameObject)

		arg_33_0.puzzle = nil
	end

	arg_33_0.slots = {}

	return
end

function var_0_0.Hide(arg_34_0)
	var_0_0.super.Hide(arg_34_0)
	pg.BgmMgr.GetInstance():Pop(arg_34_0.__cname)

	return
end

function var_0_0.OnDestroy(arg_35_0)
	arg_35_0:ClearTimer()

	for iter_35_0, iter_35_1 in pairs(arg_35_0.slots) do
		if LeanTween.isTweening(iter_35_1.tr.gameObject) then
			LeanTween.cancel(iter_35_1.tr.gameObject)
		end
	end

	return
end

return var_0_0
