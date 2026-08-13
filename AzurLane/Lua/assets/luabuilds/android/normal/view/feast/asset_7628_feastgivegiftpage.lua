class = var_0_10000

local var_0_0 = "FeastGiveGiftPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "FeastGiveGiftPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.mask = var_1.Find(var_2_0, "mask")

	local var_2_1 = arg_2_0._tf

	arg_2_0.back = var_1.Find(var_2_1, "back")

	local var_2_2 = arg_2_0._tf

	arg_2_0.charContainer = var_1.Find(var_2_2, "char")

	local var_2_3 = arg_2_0._tf

	arg_2_0.charRect = var_1.Find(var_2_3, "char/rect")

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "dialogue/name/Text")
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nameTxt = var_2_6(var_2_5, var_3(var_1_10004))

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.Find(var_2_7, "dialogue/Text")
	local var_2_9 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.dialogueTxt = var_2_9(var_2_8, var_3(var_1_10004))

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_1.Find(var_2_10, "dialogue/Text")
	local var_2_12 = var_1.GetComponent

	typeof = var_3
	Typewriter = var_1_10004
	arg_2_0.typer = var_2_12(var_2_11, var_3(var_1_10004))

	local var_2_13 = arg_2_0._tf

	arg_2_0.giftTr = var_1.Find(var_2_13, "dialogue/item/icon")

	local var_2_14 = arg_2_0._tf

	arg_2_0.effectTr = var_1.Find(var_2_14, "char/effect")
	arg_2_0.giftTrPos = arg_2_0.giftTr.localPosition

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_1.Find(var_2_15, "dialogue/tip")
	local var_2_17 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.tipTr = var_2_17(var_2_16, var_3(var_1_10004))

	return
end

function var_0_1.BindEvents(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.bind

	FeastScene = var_1_10003
	arg_3_0.eventId = var_3_1(var_3_0, var_1_10003.ON_GOT_GIFT, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_3_0

		var_2.OnGotGift(var_4_0, arg_4_1)

		return
	end)

	return
end

function var_0_1.ClearBindEvents(arg_5_0)
	if arg_5_0.eventId then
		arg_5_0:disconnect(arg_5_0.eventId)

		arg_5_0.eventId = nil
	end

	return
end

function var_0_1.OnGotGift(arg_6_0, arg_6_1)
	if arg_6_0.feastShip then
		arg_6_0:BlockEvents()

		setActive = var_2

		var_2(arg_6_0.effectTr, true)

		seriesAsync = var_2

		var_2({
			function(arg_7_0)
				local var_7_0 = arg_6_0

				var_1.UpdateGiftState(var_7_0, arg_6_0.feastShip, arg_7_0)

				return
			end,
			function(arg_8_0)
				onButton = var_2_10001

				local var_8_0 = arg_6_0
				local var_8_1 = arg_6_0.mask

				local function var_8_2()
					local var_9_0 = arg_6_0

					var_0.UnBlockEvents(var_9_0)
					arg_8_0()

					return
				end

				SFX_PANEL = var_2_10005

				var_2_10001(var_8_0, var_8_1, var_8_2, var_2_10005)

				return
			end,
			function(arg_10_0)
				local var_10_0 = arg_6_0
				local var_10_1 = var_1.emit

				BaseUI = var_2_10003

				var_10_1(var_10_0, var_2_10003.ON_ACHIEVE, arg_6_1, arg_10_0)

				return
			end,
			function(arg_11_0)
				local var_11_0 = arg_6_0.feastShip
				local var_11_1 = var_1.GetGiftStory(var_11_0)

				pg = var_11_0

				local var_11_2 = var_11_0.NewStoryMgr.GetInstance()

				var_2.Play(var_11_2, var_11_1, arg_11_0)

				return
			end
		}, function()
			setActive = var_2_10000

			var_2_10000(arg_6_0.effectTr, false)

			local var_12_0 = arg_6_0
			local var_12_1 = var_0.emit

			FeastScene = var_2

			var_12_1(var_12_0, var_2.ON_BACK_FEAST)

			return
		end)
	end

	return
end

function var_0_1.Show(arg_13_0, arg_13_1)
	var_0_1.super.Show(arg_13_0)
	arg_13_0:UnBlockEvents()

	setActive = var_2

	var_2(arg_13_0.effectTr, false)

	arg_13_0.feastShip = arg_13_1

	arg_13_0:SetTipContent()

	seriesAsync = var_2

	var_2({
		function(arg_14_0)
			local var_14_0 = arg_13_0

			var_1.LoadChar(var_14_0, arg_13_1, arg_14_0)

			return
		end,
		function(arg_15_0)
			arg_13_0.giftTr.localPosition = arg_13_0.giftTrPos

			local var_15_0 = arg_13_0

			var_1.LoadItem(var_15_0, arg_13_1, arg_15_0)

			return
		end
	}, function()
		local var_16_0 = arg_13_0

		var_0.BindEvents(var_16_0)

		local var_16_1 = arg_13_0

		var_0.UpdateShipName(var_16_1, arg_13_1)

		local var_16_2 = arg_13_0

		var_0.UpdateGiftState(var_16_2, arg_13_1)

		local var_16_3 = arg_13_0

		var_0.RegisterEvent(var_16_3)

		return
	end)

	return
end

function var_0_1.SetTipContent(arg_17_0)
	local var_17_0 = arg_17_0.tipTr

	i18n = var_1_10002
	var_17_0.text = var_1_10002("feast_drag_gift_tip")

	return
end

function var_0_1.CanInterAction(arg_18_0)
	isActive = var_1_10001

	return not var_1_10001(arg_18_0.mask)
end

function var_0_1.BlockEvents(arg_19_0)
	setActive = var_1_10001

	var_1_10001(arg_19_0.mask, true)

	return
end

function var_0_1.UnBlockEvents(arg_20_0)
	setActive = var_1_10001

	var_1_10001(arg_20_0.mask, false)

	removeOnButton = var_1_10001

	var_1_10001(arg_20_0.mask)

	return
end

function var_0_1.RegisterEvent(arg_21_0)
	onButton = var_1_10001

	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.back

	local function var_21_2()
		local var_22_0 = arg_21_0

		var_0.Hide(var_22_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_21_0, var_21_1, var_21_2, var_1_10005)

	return
end

local function var_0_2(arg_23_0, arg_23_1)
	pg = var_1_10002

	local var_23_0 = var_1_10002.UIMgr.GetInstance().overlayCameraComp
	local var_23_1 = arg_23_0
	local var_23_2 = arg_23_0.GetComponent(var_23_1, "RectTransform")

	LuaHelper = var_23_1

	return (var_23_1.ScreenToLocal(var_23_2, arg_23_1, var_23_0))
end

function var_0_1.LoadChar(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_1
	local var_24_1 = arg_24_1.GetPrefab(var_24_0)

	PoolMgr = var_24_0

	local var_24_2 = var_24_0.GetInstance()

	var_4.GetPrefab(var_24_2, "feastChar/" .. var_24_1, var_24_1, true, function(arg_25_0)
		if arg_24_0.exited then
			PoolMgr = var_1

			local var_25_0 = var_1.GetInstance()

			var_1.ReturnPrefab(var_25_0, "feastChar/" .. var_24_1, var_24_1, arg_25_0)

			return
		end

		local var_25_1 = arg_25_0.transform

		var_1.SetParent(var_25_1, arg_24_0.charContainer)

		local var_25_2 = arg_25_0.transform

		Vector3 = var_25_1
		var_25_2.localScale = var_25_1(1, 1, 0)

		local var_25_3 = arg_25_0.transform

		Vector3 = var_2
		var_25_3.localPosition = var_2(0, 0, 0)

		local var_25_4 = arg_25_0
		local var_25_5 = arg_25_0.GetComponent

		typeof = var_3
		SpineAnimUI = var_4

		local var_25_6 = var_25_5(var_25_4, var_3(var_4))

		arg_24_0.loadedChar = {
			spineAnimUI = var_25_6,
			name = var_24_1
		}

		if arg_24_2 then
			arg_24_2()
		end

		return
	end)

	return
end

function var_0_1.LoadItem(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_1
	local var_26_1 = arg_26_1.GetPrefab(var_26_0)

	LoadSpriteAsync = var_26_0

	var_26_0("FeastCharGift/" .. var_26_1, function(arg_27_0)
		local var_27_0 = arg_26_0.giftTr
		local var_27_1 = var_1.GetComponent

		typeof = var_2_10003
		Image = var_2_10004

		local var_27_2 = var_27_1(var_27_0, var_2_10003(var_2_10004))

		var_27_2.sprite = arg_27_0

		var_27_2:SetNativeSize()
		arg_26_2()

		return
	end)

	return
end

function var_0_1.UpdateShipName(arg_28_0, arg_28_1)
	arg_28_0.nameTxt.text = arg_28_1:GetShipName()

	return
end

function var_0_1.UpdateGiftState(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0:ClearGiftEvent()

	parallelAsync = var_3

	var_3({
		function(arg_30_0)
			local var_30_0 = arg_29_0
			local var_30_1 = var_1.UpdateContent
			local var_30_2 = arg_29_1

			var_30_1(var_30_0, var_3.GetDialogueForGift(var_30_2), 4, arg_30_0)

			return
		end,
		function(arg_31_0)
			local var_31_0 = arg_29_0.loadedChar.spineAnimUI
			local var_31_1 = arg_29_1

			if not var_2.GotGift(var_31_1) then
				setActive = var_2

				var_2(arg_29_0.giftTr, true)

				local var_31_2 = arg_29_0

				var_2.AddGiftEvent(var_31_2)
				var_31_0:SetAction("activity_wait", 0)
			else
				setActive = var_2

				var_2(arg_29_0.giftTr, false)
				var_31_0:SetActionCallBack(function(arg_32_0)
					if arg_32_0 == "finish" then
						local var_32_0 = var_31_0

						var_1.SetActionCallBack(var_32_0, nil)

						local var_32_1 = var_31_0

						var_1.SetAction(var_32_1, "activity_wait", 0)
						arg_31_0()
					end

					return
				end)
				var_31_0:SetAction("activity_getgift", 0)
			end

			return
		end
	}, function()
		if arg_29_2 then
			arg_29_2()
		end

		return
	end)

	return
end

function var_0_1.UpdateContent(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	System = var_1_10004

	local var_34_0 = arg_34_2 / var_1_10004.String.New(arg_34_1).Length
	local var_34_1 = arg_34_0.typer

	var_6.setSpeed(var_34_1, 31)

	arg_34_0.dialogueTxt.text = arg_34_1

	local var_34_2 = arg_34_0.typer

	var_6.setSpeed(var_34_2, var_34_0)

	function arg_34_0.typer.endFunc()
		if arg_34_3 then
			arg_34_3()
		end

		return
	end

	local var_34_3 = arg_34_0.typer

	var_6.Play(var_34_3)

	return
end

function var_0_1.AddGiftEvent(arg_36_0)
	local var_36_0 = arg_36_0.giftTr

	GetOrAddComponent = var_1_10002

	local var_36_1 = var_36_0

	typeof = var_1_10004
	EventTriggerListener = var_1_10005

	local var_36_2 = var_1_10002(var_36_1, var_1_10004(var_1_10005))
	local var_36_3

	var_36_2:AddBeginDragFunc(function()
		local var_37_0 = var_36_0

		var_0.SetAsLastSibling(var_37_0)

		var_36_3 = var_36_0.localPosition

		return
	end)
	var_36_2:AddDragFunc(function(arg_38_0, arg_38_1)
		local var_38_0 = var_0_2(var_36_0.parent, arg_38_1.position)

		var_36_0.localPosition = var_38_0

		return
	end)
	var_36_2:AddDragEndFunc(function(arg_39_0, arg_39_1)
		local var_39_0 = arg_36_0.charRect

		getBounds = var_2_10003

		local var_39_1 = var_2_10003(var_39_0)

		getBounds = var_4

		local var_39_2 = var_4(var_36_0)

		if var_39_1:Intersects(var_39_2) then
			local var_39_3 = arg_36_0

			var_5.Send(var_39_3)
		else
			var_36_0.localPosition = arg_36_0.giftTrPos
		end

		return
	end)

	return
end

function var_0_1.ClearGiftEvent(arg_40_0)
	local var_40_0

	var_40_0, GetOrAddComponent = arg_40_0.giftTr, var_1_10002
	typeof = var_1_10004
	EventTriggerListener = var_1_10005

	local var_40_1 = var_1_10002(var_40_0, var_1_10004(var_1_10005))

	var_2.AddBeginDragFunc(var_40_1, nil)
	var_2:AddDragFunc(nil)
	var_2:AddDragEndFunc(nil)
	var_2:RemoveBeginDragFunc()
	var_2:RemoveDragFunc()
	var_2:RemoveDragEndFunc()

	return
end

function var_0_1.Send(arg_41_0)
	local var_41_0 = arg_41_0.feastShip
	local var_41_1 = arg_41_0
	local var_41_2 = arg_41_0.emit

	FeastMediator = var_1_10004

	var_41_2(var_41_1, var_1_10004.GIVE_GIFT, var_41_0.tid)

	return
end

function var_0_1.Hide(arg_42_0)
	var_0_1.super.Hide(arg_42_0)
	arg_42_0:ClearBindEvents()

	if arg_42_0.loadedChar then
		local var_42_0 = arg_42_0.loadedChar.spineAnimUI

		var_1.SetActionCallBack(var_42_0, nil)

		PoolMgr = var_1

		local var_42_1 = var_1.GetInstance()

		var_1.ReturnPrefab(var_42_1, "feastChar/" .. arg_42_0.loadedChar.name, arg_42_0.loadedChar.name, arg_42_0.loadedChar.spineAnimUI.gameObject)

		arg_42_0.loadedChar = nil
	end

	arg_42_0:ClearGiftEvent()

	return
end

function var_0_1.OnDestroy(arg_43_0)
	return
end

return var_0_1
