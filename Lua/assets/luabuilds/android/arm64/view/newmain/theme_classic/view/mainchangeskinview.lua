local var_0_0 = class("MainChangeSkinView", import("...base.MainBaseView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._changeSkinToggle = ChangeSkinToggle.New(findTF(arg_1_1, "toggleUI"))

	arg_1_0._changeSkinToggle:SetAsmrTurnning(true)

	arg_1_0.inChange = false
	arg_1_0._parentTF = arg_1_0._tf.parent
	arg_1_0._anchoredPosition = arg_1_0._tf.anchoredPosition

	onButton(arg_1_0, findTF(arg_1_0._tf, "click"), function()
		if arg_1_0.inChange then
			return
		end

		if arg_1_0._changeSkinToggle:IsAsmrSkin() then
			getProxy(SettingsProxy):setCharacterSetting(arg_1_0._flagShip.id, SHIP_FLAG_L2D, true)
			getProxy(SettingsProxy):setCharacterSetting(arg_1_0._flagShip.id, SHIP_FLAG_SP, true)
		end

		arg_1_0.inChange = true

		arg_1_0.event:emit(NewMainMediator.CHANGE_SKIN_TOGGLE, {
			skin_id = arg_1_0._flagShip:getSkinId()
		})

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.Init(arg_3_0, arg_3_1)
	arg_3_0._flagShip = arg_3_1

	arg_3_0:updateUI()

	return
end

function var_0_0.Refresh(arg_4_0, arg_4_1)
	arg_4_0.inChange = false
	arg_4_0._flagShip = arg_4_1

	arg_4_0:updateUI()

	return
end

function var_0_0.updateUI(arg_5_0)
	local var_5_0 = arg_5_0._flagShip:getSkinId()
	local var_5_1 = ShipSkin.GetChangeSkinGroupId(var_5_0)

	if not var_5_1 then
		setActive(arg_5_0._tf, false)
	else
		setActive(arg_5_0._tf, true)
	end

	if arg_5_0._changeSkinToggle and var_5_1 and var_5_1 > 0 then
		arg_5_0._changeSkinToggle:setShipData(var_5_0, arg_5_0._flagShip:GetShipPhantomMark())
	end

	if arg_5_0._asmrTurnningParent then
		if ShipSkin.GetChangeSkinCustomDataId(var_5_0, "asmr") == 1 then
			setParent(arg_5_0._tf, arg_5_0._asmrTurnningParent)

			arg_5_0._tf.anchoredPosition = Vector2(0, 0)
		else
			setParent(arg_5_0._tf, arg_5_0._parentTF)

			arg_5_0._tf.anchoredPosition = arg_5_0._anchoredPosition
		end
	end

	return
end

function var_0_0.SetAsmrTurnningParent(arg_6_0, arg_6_1)
	arg_6_0._asmrTurnningParent = arg_6_1

	return
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)

	arg_7_0._asmrTurnningParent = nil

	return
end

return var_0_0
