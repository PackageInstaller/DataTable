local var_0_0 = class("FeastGiveGiftPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "FeastGiveGiftPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.mask = arg_2_0._tf:Find("mask")
	arg_2_0.back = arg_2_0._tf:Find("back")
	arg_2_0.charContainer = arg_2_0._tf:Find("char")
	arg_2_0.charRect = arg_2_0._tf:Find("char/rect")
	arg_2_0.nameTxt = arg_2_0._tf:Find("dialogue/name/Text"):GetComponent(typeof(Text))
	arg_2_0.dialogueTxt = arg_2_0._tf:Find("dialogue/Text"):GetComponent(typeof(Text))
	arg_2_0.typer = arg_2_0._tf:Find("dialogue/Text"):GetComponent(typeof(Typewriter))
	arg_2_0.giftTr = arg_2_0._tf:Find("dialogue/item/icon")
	arg_2_0.effectTr = arg_2_0._tf:Find("char/effect")
	arg_2_0.giftTrPos = arg_2_0.giftTr.localPosition
	arg_2_0.tipTr = arg_2_0._tf:Find("dialogue/tip"):GetComponent(typeof(Text))

	return
end

function var_0_0.BindEvents(arg_3_0)
	arg_3_0.eventId = arg_3_0:bind(FeastScene.ON_GOT_GIFT, function(arg_4_0, arg_4_1)
		arg_3_0:OnGotGift(arg_4_1)

		return
	end)

	return
end

function var_0_0.ClearBindEvents(arg_5_0)
	if arg_5_0.eventId then
		arg_5_0:disconnect(arg_5_0.eventId)

		arg_5_0.eventId = nil
	end

	return
end

function var_0_0.OnGotGift(arg_6_0, arg_6_1)
	if arg_6_0.feastShip then
		arg_6_0:BlockEvents()
		setActive(arg_6_0.effectTr, true)
		seriesAsync({
			function(arg_7_0)
				arg_6_0:UpdateGiftState(arg_6_0.feastShip, arg_7_0)

				return
			end,
			function(arg_8_0)
				onButton(arg_6_0, arg_6_0.mask, function()
					arg_6_0:UnBlockEvents()
					arg_8_0()

					return
				end, SFX_PANEL)

				return
			end,
			function(arg_10_0)
				arg_6_0:emit(BaseUI.ON_ACHIEVE, arg_6_1, arg_10_0)

				return
			end,
			function(arg_11_0)
				pg.NewStoryMgr.GetInstance():Play(arg_6_0.feastShip:GetGiftStory(), arg_11_0)

				return
			end
		}, function()
			setActive(arg_6_0.effectTr, false)
			arg_6_0:emit(FeastScene.ON_BACK_FEAST)

			return
		end)
	end

	return
end

function var_0_0.Show(arg_13_0, arg_13_1)
	var_0_0.super.Show(arg_13_0)
	arg_13_0:UnBlockEvents()
	setActive(arg_13_0.effectTr, false)

	arg_13_0.feastShip = arg_13_1

	arg_13_0:SetTipContent()
	seriesAsync({
		function(arg_14_0)
			arg_13_0:LoadChar(arg_13_1, arg_14_0)

			return
		end,
		function(arg_15_0)
			arg_13_0.giftTr.localPosition = arg_13_0.giftTrPos

			arg_13_0:LoadItem(arg_13_1, arg_15_0)

			return
		end
	}, function()
		arg_13_0:BindEvents()
		arg_13_0:UpdateShipName(arg_13_1)
		arg_13_0:UpdateGiftState(arg_13_1)
		arg_13_0:RegisterEvent()

		return
	end)

	return
end

function var_0_0.SetTipContent(arg_17_0)
	arg_17_0.tipTr.text = i18n("feast_drag_gift_tip")

	return
end

function var_0_0.CanInterAction(arg_18_0)
	return not isActive(arg_18_0.mask)
end

function var_0_0.BlockEvents(arg_19_0)
	setActive(arg_19_0.mask, true)

	return
end

function var_0_0.UnBlockEvents(arg_20_0)
	setActive(arg_20_0.mask, false)
	removeOnButton(arg_20_0.mask)

	return
end

function var_0_0.RegisterEvent(arg_21_0)
	onButton(arg_21_0, arg_21_0.back, function()
		arg_21_0:Hide()

		return
	end, SFX_PANEL)

	return
end

local function var_0_1(arg_23_0, arg_23_1)
	return (LuaHelper.ScreenToLocal(arg_23_0:GetComponent("RectTransform"), arg_23_1, pg.UIMgr.GetInstance().overlayCameraComp))
end

function var_0_0.LoadChar(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_1:GetPrefab()

	PoolMgr.GetInstance():GetPrefab("feastChar/" .. var_24_0, var_24_0, true, function(arg_25_0)
		if arg_24_0.exited then
			PoolMgr.GetInstance():ReturnPrefab("feastChar/" .. var_24_0, var_24_0, arg_25_0)

			return
		end

		arg_25_0.transform:SetParent(arg_24_0.charContainer)

		arg_25_0.transform.localScale = Vector3(1, 1, 0)
		arg_25_0.transform.localPosition = Vector3(0, 0, 0)
		arg_24_0.loadedChar = {
			spineAnimUI = arg_25_0:GetComponent(typeof(SpineAnimUI)),
			name = var_24_0
		}

		if arg_24_2 then
			arg_24_2()
		end

		return
	end)

	return
end

function var_0_0.LoadItem(arg_26_0, arg_26_1, arg_26_2)
	LoadSpriteAsync("FeastCharGift/" .. arg_26_1:GetPrefab(), function(arg_27_0)
		local var_27_0 = arg_26_0.giftTr:GetComponent(typeof(Image))

		var_27_0.sprite = arg_27_0

		var_27_0:SetNativeSize()
		arg_26_2()

		return
	end)

	return
end

function var_0_0.UpdateShipName(arg_28_0, arg_28_1)
	arg_28_0.nameTxt.text = arg_28_1:GetShipName()

	return
end

function var_0_0.UpdateGiftState(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0:ClearGiftEvent()
	parallelAsync({
		function(arg_30_0)
			arg_29_0:UpdateContent(arg_29_1:GetDialogueForGift(), 4, arg_30_0)

			return
		end,
		function(arg_31_0)
			local var_31_0 = arg_29_0.loadedChar.spineAnimUI

			if not arg_29_1:GotGift() then
				setActive(arg_29_0.giftTr, true)
				arg_29_0:AddGiftEvent()
				arg_29_0.loadedChar.spineAnimUI:SetAction("activity_wait", 0)
			else
				setActive(arg_29_0.giftTr, false)
				arg_29_0.loadedChar.spineAnimUI:SetActionCallBack(function(arg_32_0)
					if arg_32_0 == "finish" then
						var_31_0:SetActionCallBack(nil)
						var_31_0:SetAction("activity_wait", 0)
						arg_31_0()
					end

					return
				end)
				arg_29_0.loadedChar.spineAnimUI:SetAction("activity_getgift", 0)
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

function var_0_0.UpdateContent(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	arg_34_0.typer:setSpeed(31)

	arg_34_0.dialogueTxt.text = arg_34_1

	arg_34_0.typer:setSpeed(arg_34_2 / System.String.New(arg_34_1).Length)

	function arg_34_0.typer.endFunc()
		if arg_34_3 then
			arg_34_3()
		end

		return
	end

	arg_34_0.typer:Play()

	return
end

function var_0_0.AddGiftEvent(arg_36_0)
	local var_36_0 = GetOrAddComponent(arg_36_0.giftTr, typeof(EventTriggerListener))
	local var_36_1

	var_36_0:AddBeginDragFunc(function()
		var_0:SetAsLastSibling()

		var_36_1 = var_0.localPosition

		return
	end)
	var_36_0:AddDragFunc(function(arg_38_0, arg_38_1)
		var_0.localPosition = var_0_1(var_0.parent, arg_38_1.position)

		return
	end)
	var_36_0:AddDragEndFunc(function(arg_39_0, arg_39_1)
		if getBounds(arg_36_0.charRect):Intersects((getBounds(var_0))) then
			arg_36_0:Send()
		else
			var_0.localPosition = arg_36_0.giftTrPos
		end

		return
	end)

	return
end

function var_0_0.ClearGiftEvent(arg_40_0)
	local var_40_0 = GetOrAddComponent(arg_40_0.giftTr, typeof(EventTriggerListener))

	var_40_0:AddBeginDragFunc(nil)
	var_40_0:AddDragFunc(nil)
	var_40_0:AddDragEndFunc(nil)
	var_40_0:RemoveBeginDragFunc()
	var_40_0:RemoveDragFunc()
	var_40_0:RemoveDragEndFunc()

	return
end

function var_0_0.Send(arg_41_0)
	arg_41_0:emit(FeastMediator.GIVE_GIFT, arg_41_0.feastShip.tid)

	return
end

function var_0_0.Hide(arg_42_0)
	var_0_0.super.Hide(arg_42_0)
	arg_42_0:ClearBindEvents()

	if arg_42_0.loadedChar then
		arg_42_0.loadedChar.spineAnimUI:SetActionCallBack(nil)
		PoolMgr.GetInstance():ReturnPrefab("feastChar/" .. arg_42_0.loadedChar.name, arg_42_0.loadedChar.name, arg_42_0.loadedChar.spineAnimUI.gameObject)

		arg_42_0.loadedChar = nil
	end

	arg_42_0:ClearGiftEvent()

	return
end

function var_0_0.OnDestroy(arg_43_0)
	return
end

return var_0_0
