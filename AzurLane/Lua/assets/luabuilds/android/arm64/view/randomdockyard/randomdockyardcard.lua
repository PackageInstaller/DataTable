local var_0_0 = class("RandomDockYardCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.npcTr = findTF(arg_1_0._tf, "content/dockyard/npc")
	arg_1_0.nameTF = findTF(arg_1_0._tf, "content/info/name_mask/name")
	arg_1_0.lockTr = findTF(arg_1_0._tf, "content/dockyard/container/lock")
	arg_1_0.selected = findTF(arg_1_0._tf, "content/front/selected")
	arg_1_0.existAnim = false

	ClearTweenItemAlphaAndWhite(arg_1_0._go)

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	TweenItemAlphaAndWhite(arg_2_0._go)

	if not arg_2_0.ship or arg_2_0.ship.id ~= arg_2_1.id then
		arg_2_0.ship = arg_2_1

		arg_2_0:Flush()
	end

	arg_2_0:UpdateSelected(arg_2_2)

	return
end

function var_0_0.UpdateSelected(arg_3_0, arg_3_1)
	setActive(arg_3_0.selected, arg_3_1)

	if not arg_3_1 then
		arg_3_0.existAnim = false

		LeanTween.cancel(arg_3_0.selected.gameObject)
	elseif arg_3_0.existAnim then
		-- block empty
	else
		arg_3_0.existAnim = true

		blinkAni(arg_3_0.selected, 0.6, -1, 0.3):setFrom(1)
	end

	return
end

function var_0_0.Flush(arg_4_0)
	flushShipCard(arg_4_0._tf, arg_4_0.ship)
	setActive(arg_4_0.npcTr, arg_4_0.ship:isActivityNpc())
	setText(arg_4_0.nameTF, arg_4_0.ship:GetColorName(shortenString(arg_4_0.ship:getName(), PLATFORM_CODE == PLATFORM_US and 6 or 7)))
	arg_4_0.lockTr.gameObject:SetActive(arg_4_0.ship:GetLockState() == Ship.LOCK_STATE_LOCK)

	return
end

function var_0_0.Dispose(arg_5_0)
	ClearTweenItemAlphaAndWhite(arg_5_0._go)
	arg_5_0:UpdateSelected(false)

	return
end

return var_0_0
