class = var_0_10000

local var_0_0 = var_0_10000("RandomDockYardCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	findTF = var_2
	arg_1_0.npcTr = var_2(arg_1_0._tf, "content/dockyard/npc")
	findTF = var_2
	arg_1_0.nameTF = var_2(arg_1_0._tf, "content/info/name_mask/name")
	findTF = var_2
	arg_1_0.lockTr = var_2(arg_1_0._tf, "content/dockyard/container/lock")
	findTF = var_2
	arg_1_0.selected = var_2(arg_1_0._tf, "content/front/selected")
	arg_1_0.existAnim = false
	ClearTweenItemAlphaAndWhite = var_2

	var_2(arg_1_0._go)

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	TweenItemAlphaAndWhite = var_1_10003

	var_1_10003(arg_2_0._go)

	if not arg_2_0.ship or arg_2_0.ship.id ~= arg_2_1.id then
		arg_2_0.ship = arg_2_1

		arg_2_0:Flush()
	end

	arg_2_0:UpdateSelected(arg_2_2)

	return
end

function var_0_0.UpdateSelected(arg_3_0, arg_3_1)
	setActive = var_1_10002

	var_1_10002(arg_3_0.selected, arg_3_1)

	if not arg_3_1 then
		arg_3_0.existAnim = false
		LeanTween = var_2

		var_2.cancel(arg_3_0.selected.gameObject)
	elseif arg_3_0.existAnim then
		-- block empty
	else
		arg_3_0.existAnim = true
		blinkAni = var_2

		local var_3_0 = var_2(arg_3_0.selected, 0.6, -1, 0.3)

		var_2.setFrom(var_3_0, 1)
	end

	return
end

function var_0_0.Flush(arg_4_0)
	local var_4_0 = arg_4_0.ship

	flushShipCard = var_1_10002

	var_1_10002(arg_4_0._tf, var_4_0)

	setActive = var_1_10002

	var_1_10002(arg_4_0.npcTr, var_4_0:isActivityNpc())

	setText = var_1_10002

	local var_4_1 = arg_4_0.nameTF
	local var_4_2 = var_4_0
	local var_4_3 = var_4_0.GetColorName

	shortenString = var_1_10008

	local var_4_4 = var_4_0
	local var_4_5 = var_4_0.getName(var_4_4)

	PLATFORM_CODE = var_1_10011
	PLATFORM_US = var_4_4

	var_1_10002(var_4_1, var_4_3(var_4_2, var_1_10008(var_4_5, var_1_10011 == var_4_4 and 6 or 7)))

	local var_4_6 = arg_4_0.lockTr.gameObject
	local var_4_7 = var_2.SetActive
	local var_4_8 = var_4_0:GetLockState()

	Ship = var_1_10006

	var_4_7(var_4_6, var_4_8 == var_1_10006.LOCK_STATE_LOCK)

	return
end

function var_0_0.Dispose(arg_5_0)
	ClearTweenItemAlphaAndWhite = var_1_10001

	var_1_10001(arg_5_0._go)
	arg_5_0:UpdateSelected(false)

	return
end

return var_0_0
