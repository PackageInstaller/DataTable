local var_0_0 = class("ShipDetailCard")
local var_0_1 = 0.5

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	arg_1_0.tagFlags = arg_1_2 or {}
	arg_1_0.toggle = GetOrAddComponent(arg_1_0.tr, typeof(Toggle))
	arg_1_0.content = findTF(arg_1_0.tr, "content").gameObject
	arg_1_0.quit = findTF(arg_1_0.tr, "quit_button").gameObject
	arg_1_0.detail = findTF(arg_1_0.tr, "content/dockyard/detail").gameObject
	arg_1_0.detailLayoutTr = findTF(arg_1_0.detail, "layout")
	arg_1_0.imageQuit = arg_1_0.quit:GetComponent("Image")
	arg_1_0.imageFrame = findTF(arg_1_0.tr, "content/front/frame"):GetComponent("Image")
	arg_1_0.labelName = findTF(arg_1_0.tr, "content/info/name_mask/name")
	arg_1_0.npc = findTF(arg_1_0.tr, "content/dockyard/npc")

	setActive(arg_1_0.npc, false)

	arg_1_0.lock = findTF(arg_1_0.tr, "content/dockyard/container/lock")
	arg_1_0.maskStatusOb = findTF(arg_1_0.tr, "content/front/status_mask")
	arg_1_0.iconStatus = findTF(arg_1_0.tr, "content/dockyard/status")
	arg_1_0.iconStatusTxt = findTF(arg_1_0.tr, "content/dockyard/status/Text"):GetComponent("Text")
	arg_1_0.selectedGo = findTF(arg_1_0.tr, "content/front/selected").gameObject
	arg_1_0.energyTF = findTF(arg_1_0.tr, "content/dockyard/container/energy")
	arg_1_0.proposeTF = findTF(arg_1_0.tr, "content/dockyard/propose")

	arg_1_0.selectedGo:SetActive(false)

	arg_1_0.hpBar = findTF(arg_1_0.tr, "content/dockyard/blood")

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

	arg_3_0.selectedGo:SetActive(arg_3_0.selected)

	if arg_3_0.selected then
		arg_3_0.selectedTw = arg_3_0.selectedTw or LeanTween.alpha(arg_3_0.selectedGo.transform, 1, var_0_1):setFrom(0):setEase(LeanTweenType.easeInOutSine):setLoopPingPong()
	elseif arg_3_0.selectedTw then
		LeanTween.cancel(arg_3_0.selectedTw.uniqueId)

		arg_3_0.selectedTw = nil
	end

	return
end

function var_0_0.flush(arg_4_0)
	local var_4_0 = tobool(arg_4_0.shipVO)

	if var_4_0 then
		if not arg_4_0.shipVO:getConfigTable() then
			return
		end

		flushShipCard(arg_4_0.tr, arg_4_0.shipVO)

		local var_4_1 = arg_4_0.shipVO:isActivityNpc()

		setActive(arg_4_0.npc, var_4_1)

		if arg_4_0.lock then
			arg_4_0.lock.gameObject:SetActive(arg_4_0.shipVO:GetLockState() == Ship.LOCK_STATE_LOCK)
		end

		local var_4_2 = arg_4_0.shipVO.energy <= Ship.ENERGY_MID

		if arg_4_0.shipVO.energy <= Ship.ENERGY_MID then
			local var_4_3 = GetSpriteFromAtlas("energy", arg_4_0.shipVO:getEnergyPrint())

			if not var_4_3 then
				warning("找不到疲劳")
			end

			setImageSprite(arg_4_0.energyTF, var_4_3)
		end

		setActive(arg_4_0.energyTF, var_4_2)
		setScrollText(arg_4_0.labelName, arg_4_0.shipVO:getName())

		local var_4_4 = ShipStatus.ShipStatusToTag(arg_4_0.shipVO, arg_4_0.tagFlags)

		if var_4_4 then
			arg_4_0.iconStatusTxt.text = var_4_4[3]

			GetSpriteFromAtlasAsync(var_4_4[1], var_4_4[2], function(arg_5_0)
				setImageSprite(arg_4_0.iconStatus, arg_5_0, true)
				setActive(arg_4_0.iconStatus, true)

				if var_4_4[1] == "shipstatus" then
					arg_4_0.iconStatus.sizeDelta = Vector2(195, 36)
					arg_4_0.iconStatusTxt.fontSize = 30
				end

				return
			end)
		else
			setActive(arg_4_0.iconStatus, false)
		end

		local var_4_5, var_4_6 = arg_4_0.shipVO:getIntimacyIcon()

		setActive(arg_4_0.proposeTF, tobool(var_4_6 and not var_4_1))
	end

	arg_4_0.content:SetActive(var_4_0)

	return
end

function var_0_0.clear(arg_6_0)
	if arg_6_0.selectedTw then
		LeanTween.cancel(arg_6_0.selectedTw.uniqueId)

		arg_6_0.selectedTw = nil
	end

	return
end

return var_0_0
