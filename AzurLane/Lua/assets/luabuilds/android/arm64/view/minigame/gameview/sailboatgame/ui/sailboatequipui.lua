local var_0_0 = class("SailBoatEquipUI")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	var_0_1 = SailBoatGameVo
	arg_1_0._equipUI = findTF(arg_1_0._tf, "ui/equipUI")
	arg_1_0.btnBack = findTF(arg_1_0._equipUI, "back")
	arg_1_0.btnBack1 = findTF(arg_1_0._equipUI, "back_1")
	arg_1_0.btnStart = findTF(arg_1_0._equipUI, "btnStart")

	onButton(arg_1_0._event, arg_1_0.btnBack1, function()
		arg_1_0:show(false)
		arg_1_0._event:emit(SailBoatGameView.BACK_MENU)

		return
	end, SFX_CONFIRM)
	onButton(arg_1_0._event, arg_1_0.btnStart, function()
		arg_1_0._event:emit(SailBoatGameView.READY_START)

		return
	end, SFX_CONFIRM)

	arg_1_0.selectTpl = findTF(arg_1_0._equipUI, "selectItem")
	arg_1_0.equipTpl = findTF(arg_1_0._equipUI, "equipItem")
	arg_1_0.selectContent = findTF(arg_1_0._equipUI, "select/ad/list")
	arg_1_0.equipContent = findTF(arg_1_0._equipUI, "equip/list")
	arg_1_0.unEquipFlag = false
	arg_1_0.baseHp = SailBoatGameConst.game_char[var_0_1.char_id].hp
	arg_1_0.baseSpeed = SailBoatGameConst.game_char[var_0_1.char_id].speed.x
	arg_1_0.speedTf = findTF(arg_1_0._equipUI, "equip/speed")
	arg_1_0.hpTf = findTF(arg_1_0._equipUI, "equip/hp")
	arg_1_0.btnUnEquip = findTF(arg_1_0._equipUI, "btnUnEquip")

	onButton(arg_1_0._event, arg_1_0.btnUnEquip, function()
		arg_1_0.unEquipFlag = arg_1_0.curSelectItem and true or not arg_1_0.unEquipFlag

		if arg_1_0.unEquipFlag then
			arg_1_0.curSelectData = nil
			arg_1_0.curSelectItem = nil
		end

		arg_1_0:updateUI()

		return
	end)

	arg_1_0.selects = {}

	for iter_1_0 = 1, #SailBoatGameConst.equip_data do
		local var_1_0 = SailBoatGameConst.equip_data[iter_1_0]
		local var_1_1 = tf(instantiate(arg_1_0.selectTpl))

		onButton(arg_1_0._event, var_1_1, function()
			if arg_1_0.curSelectItem == var_1_1 then
				arg_1_0.curSelectItem = nil
				arg_1_0.curSelectData = nil
			else
				arg_1_0.curSelectItem = var_1_1
				arg_1_0.curSelectData = var_1_0

				if arg_1_0.unEquipFlag then
					arg_1_0.unEquipFlag = false
				end
			end

			arg_1_0:updateUI()

			return
		end, SFX_CANCEL)

		local var_1_2 = GetComponent(findTF(var_1_1, "icon"), typeof(Image))

		var_1_2.sprite = var_0_1.GetEquipIcon(SailBoatGameConst.equip_data[iter_1_0].icon)

		var_1_2:SetNativeSize()
		SetParent(var_1_1, arg_1_0.selectContent)
		table.insert(arg_1_0.selects, var_1_1)
	end

	arg_1_0.equips = {}
	arg_1_0.equipItems = {}

	for iter_1_1 = 1, SailBoatGameConst.max_equip_count do
		table.insert(arg_1_0.equips, 0)
	end

	for iter_1_2 = 1, SailBoatGameConst.max_equip_count do
		local var_1_3 = iter_1_2
		local var_1_4 = tf(instantiate(arg_1_0.equipTpl))

		onButton(arg_1_0._event, var_1_4, function()
			local var_6_0 = var_0_1.GetGameUseTimes()

			if var_0_1.GetGameTimes() > 0 then
				var_6_0 = var_6_0 + 1
			end

			if SailBoatGameConst.game_round[var_6_0].equip_count >= var_1_3 then
				if arg_1_0.curSelectData then
					if not arg_1_0:checkEquipAble(arg_1_0.curSelectData.id) then
						return
					end

					arg_1_0.equips[iter_1_2] = arg_1_0.curSelectData.id
				elseif arg_1_0.unEquipFlag then
					arg_1_0.equips[iter_1_2] = 0
				end

				arg_1_0:updateUI()
			end

			return
		end, SFX_CANCEL)
		SetParent(var_1_4, arg_1_0.equipContent)
		table.insert(arg_1_0.equipItems, var_1_4)
	end

	arg_1_0.descTf = findTF(arg_1_0._equipUI, "desc")
	arg_1_0.descTextTf = findTF(arg_1_0._equipUI, "desc/bg/desc")
	arg_1_0.curSelectItem = nil
	arg_1_0.curSelectData = nil

	arg_1_0:showUI()
	arg_1_0:updateUI()

	return
end

function var_0_0.show(arg_7_0, arg_7_1)
	setActive(arg_7_0._equipUI, arg_7_1)
	arg_7_0:showUI()
	arg_7_0:updateUI()

	return
end

function var_0_0.showUI(arg_8_0)
	local var_8_0 = var_0_1.GetGameUseTimes()

	if var_0_1.GetGameTimes() > 0 then
		var_8_0 = var_8_0 + 1
	end

	arg_8_0.roundEquipData = SailBoatGameConst.game_equip_round[var_8_0]

	for iter_8_0 = 1, #arg_8_0.selects do
		if arg_8_0.roundEquipData[iter_8_0][2] == 0 then
			setActive(arg_8_0.selects[iter_8_0], false)
		else
			setActive(arg_8_0.selects[iter_8_0], true)
		end
	end

	return
end

function var_0_0.checkEquipAble(arg_9_0, arg_9_1)
	local var_9_0 = 0
	local var_9_1 = var_0_1.GetGameUseTimes()

	if var_0_1.GetGameTimes() > 0 then
		var_9_1 = var_9_1 + 1
	end

	local var_9_2 = SailBoatGameConst.game_equip_round[var_9_1]

	for iter_9_0 = 1, #SailBoatGameConst.game_equip_round[var_9_1] do
		if var_9_2[iter_9_0][1] == arg_9_1 then
			var_9_0 = var_9_2[iter_9_0][2]
		end
	end

	if var_9_0 == 0 then
		return false, 0, 0
	end

	local var_9_3 = 0

	for iter_9_1 = 1, #arg_9_0.equips do
		if arg_9_0.equips[iter_9_1] == arg_9_1 then
			var_9_3 = var_9_3 + 1
		end
	end

	if var_9_0 <= var_9_3 then
		return false, var_9_3, var_9_0
	end

	return true, var_9_3, var_9_0
end

function var_0_0.updateUI(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.selects do
		local var_10_0 = arg_10_0.selects[iter_10_0]

		setActive(findTF(arg_10_0.selects[iter_10_0], "select"), arg_10_0.curSelectItem == arg_10_0.selects[iter_10_0])

		local var_10_1, var_10_2, var_10_3 = arg_10_0:checkEquipAble(iter_10_0)

		setText(findTF(var_10_0, "amount"), var_10_3 - var_10_2)
	end

	setActive(arg_10_0.descTf, arg_10_0.curSelectItem ~= nil)

	if arg_10_0.curSelectItem then
		arg_10_0.descTf.anchoredPosition = arg_10_0._equipUI:InverseTransformPoint(arg_10_0.curSelectItem.position)

		setText(arg_10_0.descTextTf, i18n(arg_10_0.curSelectData.desc))
	end

	local var_10_4 = var_0_1.GetGameUseTimes()

	if var_0_1.GetGameTimes() > 0 then
		var_10_4 = var_10_4 + 1
	end

	local var_10_5 = SailBoatGameConst.game_round[var_10_4].equip_count

	for iter_10_1 = 1, SailBoatGameConst.max_equip_count do
		local var_10_7 = arg_10_0.equips[iter_10_1]
		local var_10_8 = arg_10_0.equipItems[iter_10_1]

		setActive(findTF(arg_10_0.equipItems[iter_10_1], "lock"), var_10_5 < iter_10_1)
		setActive(findTF(var_10_8, "empty"), false)
		setActive(findTF(var_10_8, "bg"), false)
		setActive(findTF(var_10_8, "icon"), false)
		setActive(findTF(var_10_8, "unEquip"), false)
		setActive(findTF(var_10_8, "add"), false)
		setActive(findTF(var_10_8, "add_2"), false)

		local var_10_9 = true

		if var_10_7 ~= 0 then
			local var_10_10 = GetComponent(findTF(var_10_8, "icon"), typeof(Image))

			var_10_10.sprite = var_0_1.GetEquipIcon(SailBoatGameConst.equip_data[var_10_7].icon)

			var_10_10:SetNativeSize()
			setActive(findTF(var_10_8, "bg"), true)
			setActive(findTF(var_10_8, "icon"), true)

			if arg_10_0.unEquipFlag then
				setActive(findTF(var_10_8, "unEquip"), true)
			end

			var_10_9 = false
		else
			setActive(findTF(var_10_8, "empty"), true)
		end

		if arg_10_0.curSelectItem and iter_10_1 <= var_10_5 then
			if var_10_9 then
				setActive(findTF(var_10_8, "add"), true)
			else
				setActive(findTF(var_10_8, "add_2"), true)
			end
		end
	end

	local var_10_11 = arg_10_0.baseHp
	local var_10_12 = arg_10_0.baseSpeed

	for iter_10_2 = 1, #arg_10_0.equips do
		if arg_10_0.equips[iter_10_2] ~= 0 then
			var_10_11 = var_10_11 + SailBoatGameConst.equip_data[arg_10_0.equips[iter_10_2]].hp
			var_10_12 = var_10_12 + SailBoatGameConst.equip_data[arg_10_0.equips[iter_10_2]].speed
		end
	end

	setText(arg_10_0.speedTf, tostring(var_10_12))
	setText(arg_10_0.hpTf, tostring(var_10_11))

	var_0_1.equips = arg_10_0.equips

	return
end

return var_0_0
