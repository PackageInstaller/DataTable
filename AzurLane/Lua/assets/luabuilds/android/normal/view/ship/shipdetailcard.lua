class = var_0_10000

local var_0_0 = var_0_10000("ShipDetailCard")
local var_0_1 = 0.5

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	arg_1_0.tagFlags = arg_1_2 or {}
	GetOrAddComponent = var_3

	local var_1_0 = arg_1_0.tr

	typeof = var_1_10005
	Toggle = var_1_10006
	arg_1_0.toggle = var_3(var_1_0, var_1_10005(var_1_10006))
	findTF = var_3
	arg_1_0.content = var_3(arg_1_0.tr, "content").gameObject
	findTF = var_3
	arg_1_0.quit = var_3(arg_1_0.tr, "quit_button").gameObject
	findTF = var_3
	arg_1_0.detail = var_3(arg_1_0.tr, "content/dockyard/detail").gameObject
	findTF = var_3
	arg_1_0.detailLayoutTr = var_3(arg_1_0.detail, "layout")

	local var_1_1 = arg_1_0.quit

	arg_1_0.imageQuit = var_3.GetComponent(var_1_1, "Image")
	findTF = var_3

	local var_1_2 = var_3(arg_1_0.tr, "content/front/frame")

	arg_1_0.imageFrame = var_3.GetComponent(var_1_2, "Image")
	findTF = var_3
	arg_1_0.labelName = var_3(arg_1_0.tr, "content/info/name_mask/name")
	findTF = var_3
	arg_1_0.npc = var_3(arg_1_0.tr, "content/dockyard/npc")
	setActive = var_3

	var_3(arg_1_0.npc, false)

	findTF = var_3
	arg_1_0.lock = var_3(arg_1_0.tr, "content/dockyard/container/lock")
	findTF = var_3
	arg_1_0.maskStatusOb = var_3(arg_1_0.tr, "content/front/status_mask")
	findTF = var_3
	arg_1_0.iconStatus = var_3(arg_1_0.tr, "content/dockyard/status")
	findTF = var_3

	local var_1_3 = var_3(arg_1_0.tr, "content/dockyard/status/Text")

	arg_1_0.iconStatusTxt = var_3.GetComponent(var_1_3, "Text")
	findTF = var_3
	arg_1_0.selectedGo = var_3(arg_1_0.tr, "content/front/selected").gameObject
	findTF = var_3
	arg_1_0.energyTF = var_3(arg_1_0.tr, "content/dockyard/container/energy")
	findTF = var_3
	arg_1_0.proposeTF = var_3(arg_1_0.tr, "content/dockyard/propose")

	local var_1_4 = arg_1_0.selectedGo

	var_3.SetActive(var_1_4, false)

	findTF = var_3
	arg_1_0.hpBar = var_3(arg_1_0.tr, "content/dockyard/blood")

	return
end

function var_0_0.update(arg_2_0, arg_2_1)
	if arg_2_0.shipVO ~= arg_2_1 then
		arg_2_0.shipVO = arg_2_1

		arg_2_0:flush()
	end

	return
end

function var_0_0.updateSelected(arg_3_0, arg_3_1)
	arg_3_0.selected = arg_3_1

	local var_3_0 = arg_3_0.selectedGo

	var_2.SetActive(var_3_0, arg_3_0.selected)

	if arg_3_0.selected then
		if not arg_3_0.selectedTw then
			LeanTween = var_2

			local var_3_1 = var_2.alpha(arg_3_0.selectedGo.transform, 1, var_0_1)
			local var_3_2 = var_2.setFrom(var_3_1, 0)
			local var_3_3 = var_2.setEase

			LeanTweenType = var_4

			local var_3_4 = var_3_3(var_3_2, var_4.easeInOutSine)

			arg_3_0.selectedTw = var_2.setLoopPingPong(var_3_4)
		end
	elseif arg_3_0.selectedTw then
		LeanTween = var_2

		var_2.cancel(arg_3_0.selectedTw.uniqueId)

		arg_3_0.selectedTw = nil
	end

	return
end

function var_0_0.flush(arg_4_0)
	local var_4_0 = arg_4_0.shipVO

	tobool = var_1_10002

	if var_1_10002(var_4_0) then
		local var_4_1 = var_4_0

		if not var_4_0.getConfigTable(var_4_1) then
			return
		end

		flushShipCard = var_4_1

		var_4_1(arg_4_0.tr, var_4_0)

		local var_4_2 = var_4_0
		local var_4_3 = var_4_0.isActivityNpc(var_4_2)

		setActive = var_4_2

		var_4_2(arg_4_0.npc, var_4_3)

		local var_4_4

		if arg_4_0.lock then
			var_4_4 = arg_4_0.lock.gameObject

			local var_4_5 = var_5.SetActive
			local var_4_6 = var_4_0
			local var_4_7 = var_4_0.GetLockState(var_4_6)

			Ship = var_4_6

			var_4_5(var_4_4, var_4_7 == var_4_6.LOCK_STATE_LOCK)
		end

		local var_4_8 = var_4_0.energy

		Ship = var_4_4

		if var_4_8 <= var_4_4.ENERGY_MID then
			GetSpriteFromAtlas = var_6

			if not var_6("energy", var_4_0:getEnergyPrint()) then
				warning = var_7

				var_7("找不到疲劳")
			end

			setImageSprite = var_7

			var_7(arg_4_0.energyTF, var_6)
		end

		setActive = var_6

		var_6(arg_4_0.energyTF, var_5)

		setScrollText = var_6

		local var_4_9 = arg_4_0.labelName
		local var_4_10 = var_4_0

		var_6(var_4_9, var_4_0.getName(var_4_10))

		ShipStatus = var_6

		local var_4_11

		if var_6.ShipStatusToTag(var_4_0, arg_4_0.tagFlags) then
			var_4_11 = arg_4_0.iconStatusTxt
			var_4_11.text = var_6[3]
			GetSpriteFromAtlasAsync = var_4_11

			var_4_11(var_6[1], var_6[2], function(arg_5_0)
				setImageSprite = var_2_10001

				var_2_10001(arg_4_0.iconStatus, arg_5_0, true)

				setActive = var_2_10001

				var_2_10001(arg_4_0.iconStatus, true)

				if var_0[1] == "shipstatus" then
					local var_5_0 = arg_4_0.iconStatus

					Vector2 = var_2
					var_5_0.sizeDelta = var_2(195, 36)
					arg_4_0.iconStatusTxt.fontSize = 30
				end

				return
			end)
		else
			setActive = var_4_11

			var_4_11(arg_4_0.iconStatus, false)
		end

		local var_4_12, var_4_13 = var_4_0:getIntimacyIcon()

		setActive = var_4_10

		local var_4_14 = arg_4_0.proposeTF

		tobool = var_1_10011

		var_4_10(var_4_14, var_1_10011(var_4_13 and not var_4_3))
	end

	local var_4_15 = arg_4_0.content

	var_3.SetActive(var_4_15, var_2)

	return
end

function var_0_0.clear(arg_6_0)
	if arg_6_0.selectedTw then
		LeanTween = var_1

		var_1.cancel(arg_6_0.selectedTw.uniqueId)

		arg_6_0.selectedTw = nil
	end

	return
end

return var_0_0
