class = var_0_10000

local var_0_0 = var_0_10000("SailBoatEquipUI")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	SailBoatGameVo = var_1_10003
	var_0_1 = var_1_10003
	findTF = var_1_10003
	arg_1_0._equipUI = var_1_10003(arg_1_0._tf, "ui/equipUI")
	findTF = var_3
	arg_1_0.btnBack = var_3(arg_1_0._equipUI, "back")
	findTF = var_3
	arg_1_0.btnBack1 = var_3(arg_1_0._equipUI, "back_1")
	findTF = var_3
	arg_1_0.btnStart = var_3(arg_1_0._equipUI, "btnStart")
	onButton = var_3

	local var_1_0 = arg_1_0._event
	local var_1_1 = arg_1_0.btnBack1

	local function var_1_2()
		local var_2_0 = arg_1_0

		var_0.show(var_2_0, false)

		local var_2_1 = arg_1_0._event
		local var_2_2 = var_0.emit

		SailBoatGameView = var_2

		var_2_2(var_2_1, var_2.BACK_MENU)

		return
	end

	SFX_CONFIRM = var_1_10007

	var_3(var_1_0, var_1_1, var_1_2, var_1_10007)

	onButton = var_3

	local var_1_3 = arg_1_0._event
	local var_1_4 = arg_1_0.btnStart

	local function var_1_5()
		local var_3_0 = arg_1_0._event
		local var_3_1 = var_0.emit

		SailBoatGameView = var_2_10002

		var_3_1(var_3_0, var_2_10002.READY_START)

		return
	end

	SFX_CONFIRM = var_1_10007

	var_3(var_1_3, var_1_4, var_1_5, var_1_10007)

	findTF = var_3
	arg_1_0.selectTpl = var_3(arg_1_0._equipUI, "selectItem")
	findTF = var_3
	arg_1_0.equipTpl = var_3(arg_1_0._equipUI, "equipItem")
	findTF = var_3
	arg_1_0.selectContent = var_3(arg_1_0._equipUI, "select/ad/list")
	findTF = var_3
	arg_1_0.equipContent = var_3(arg_1_0._equipUI, "equip/list")
	arg_1_0.unEquipFlag = false
	SailBoatGameConst = var_3
	arg_1_0.baseHp = var_3.game_char[var_0_1.char_id].hp
	SailBoatGameConst = var_3
	arg_1_0.baseSpeed = var_3.game_char[var_0_1.char_id].speed.x
	findTF = var_3
	arg_1_0.speedTf = var_3(arg_1_0._equipUI, "equip/speed")
	findTF = var_3
	arg_1_0.hpTf = var_3(arg_1_0._equipUI, "equip/hp")
	findTF = var_3
	arg_1_0.btnUnEquip = var_3(arg_1_0._equipUI, "btnUnEquip")
	onButton = var_3

	var_3(arg_1_0._event, arg_1_0.btnUnEquip, function()
		if arg_1_0.curSelectItem then
			arg_1_0.unEquipFlag = true
		else
			arg_1_0.unEquipFlag = not arg_1_0.unEquipFlag
		end

		if arg_1_0.unEquipFlag then
			arg_1_0.curSelectData = nil
			arg_1_0.curSelectItem = nil
		end

		local var_4_0 = arg_1_0

		var_0.updateUI(var_4_0)

		return
	end)

	arg_1_0.selects = {}

	local var_1_6 = 1

	SailBoatGameConst = var_4

	for iter_1_0 = var_1_6, #var_4.equip_data do
		SailBoatGameConst = var_1_10007
		var_1_10007 = var_1_10007.equip_data[iter_1_0]
		tf = var_1_10008
		instantiate = var_1_10009
		var_1_10008 = var_1_10008(var_1_10009(arg_1_0.selectTpl))
		onButton = var_1_10009

		local var_1_7 = arg_1_0._event
		local var_1_8 = var_1_10008

		local function var_1_9()
			if arg_1_0.curSelectItem == var_1_10008 then
				arg_1_0.curSelectItem = nil
				arg_1_0.curSelectData = nil
			else
				arg_1_0.curSelectItem = var_1_10008
				arg_1_0.curSelectData = var_1_10007

				if arg_1_0.unEquipFlag then
					arg_1_0.unEquipFlag = false
				end
			end

			local var_5_0 = arg_1_0

			var_0.updateUI(var_5_0)

			return
		end

		SFX_CANCEL = var_1_10013

		var_1_10009(var_1_7, var_1_8, var_1_9, var_1_10013)

		GetComponent = var_1_10009
		findTF = var_1_7

		local var_1_10 = var_1_7(var_1_10008, "icon")

		typeof = var_11
		Image = var_12
		var_1_10009 = var_1_10009(var_1_10, var_11(var_12))
		var_1_10009.sprite = var_0_1.GetEquipIcon(var_1_10007.icon)

		var_1_10009:SetNativeSize()

		SetParent = var_10

		var_10(var_1_10008, arg_1_0.selectContent)

		table = var_10

		var_10.insert(arg_1_0.selects, var_1_10008)
	end

	arg_1_0.equips = {}
	arg_1_0.equipItems = {}

	local var_1_11 = 1

	SailBoatGameConst = var_4

	for iter_1_1 = var_1_11, var_4.max_equip_count do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.equips, 0)
	end

	local var_1_12 = 1

	SailBoatGameConst = var_4

	for iter_1_2 = var_1_12, var_4.max_equip_count do
		local var_1_13 = iter_1_2

		tf = var_1_10008
		instantiate = var_1_10009
		var_1_10008 = var_1_10008(var_1_10009(arg_1_0.equipTpl))
		var_1_10009 = arg_1_0.equips[iter_1_2]
		onButton = var_10

		local var_1_14 = arg_1_0._event
		local var_1_15 = var_1_10008

		local function var_1_16()
			local var_6_0 = var_0_1.GetGameUseTimes()
			local var_6_1 = var_0_1.GetGameTimes()

			if 0 < var_6_1 then
				var_6_0 = var_6_0 + 1
			end

			SailBoatGameConst = var_2

			if var_2.game_round[var_6_0].equip_count >= var_1_13 then
				if arg_1_0.curSelectData then
					local var_6_2 = arg_1_0

					if not var_3.checkEquipAble(var_6_2, arg_1_0.curSelectData.id) then
						return
					end

					arg_1_0.equips[iter_1_2] = arg_1_0.curSelectData.id
				elseif arg_1_0.unEquipFlag then
					arg_1_0.equips[iter_1_2] = 0
				end

				local var_6_3 = arg_1_0

				var_3.updateUI(var_6_3)
			end

			return
		end

		SFX_CANCEL = var_1_10014

		var_10(var_1_14, var_1_15, var_1_16, var_1_10014)

		SetParent = var_10

		var_10(var_1_10008, arg_1_0.equipContent)

		table = var_10

		var_10.insert(arg_1_0.equipItems, var_1_10008)
	end

	findTF = var_1_12
	arg_1_0.descTf = var_1_12(arg_1_0._equipUI, "desc")
	findTF = var_3
	arg_1_0.descTextTf = var_3(arg_1_0._equipUI, "desc/bg/desc")
	arg_1_0.curSelectItem = nil
	arg_1_0.curSelectData = nil

	arg_1_0:showUI()
	arg_1_0:updateUI()

	return
end

function var_0_0.show(arg_7_0, arg_7_1)
	setActive = var_1_10002

	var_1_10002(arg_7_0._equipUI, arg_7_1)
	arg_7_0:showUI()
	arg_7_0:updateUI()

	return
end

function var_0_0.showUI(arg_8_0)
	local var_8_0 = var_0_1.GetGameUseTimes()
	local var_8_1 = var_0_1.GetGameTimes()

	if 0 < var_8_1 then
		var_8_0 = var_8_0 + 1
	end

	SailBoatGameConst = var_3
	arg_8_0.roundEquipData = var_3.game_equip_round[var_8_0]

	for iter_8_0 = 1, #arg_8_0.selects do
		if arg_8_0.roundEquipData[iter_8_0][2] == 0 then
			setActive = var_1_10008

			var_1_10008(arg_8_0.selects[iter_8_0], false)
		else
			setActive = var_1_10008

			var_1_10008(arg_8_0.selects[iter_8_0], true)
		end
	end

	return
end

function var_0_0.checkEquipAble(arg_9_0, arg_9_1)
	local var_9_0 = 0
	local var_9_1 = var_0_1.GetGameUseTimes()
	local var_9_2 = var_0_1.GetGameTimes()

	if 0 < var_9_2 then
		var_9_1 = var_9_1 + 1
	end

	SailBoatGameConst = var_5

	local var_9_3 = var_5.game_equip_round[var_9_1]

	for iter_9_0 = 1, #var_9_3 do
		if var_9_3[iter_9_0][1] == arg_9_1 then
			var_9_0 = var_9_3[iter_9_0][2]
		end
	end

	if var_9_0 == 0 then
		return false, 0, 0
	end

	local var_9_4 = 0

	for iter_9_1 = 1, #arg_9_0.equips do
		if arg_9_0.equips[iter_9_1] == arg_9_1 then
			var_9_4 = var_9_4 + 1
		end
	end

	if var_9_0 <= var_9_4 then
		return false, var_9_4, var_9_0
	end

	return true, var_9_4, var_9_0
end

function var_0_0.updateUI(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.selects do
		var_1_10005 = arg_10_0.selects[iter_10_0]
		setActive = var_1_10006
		findTF = var_1_10007

		var_1_10006(var_1_10007(var_1_10005, "select"), arg_10_0.curSelectItem == var_1_10005)

		var_1_10007 = arg_10_0

		local var_10_0

		var_1_10006, var_1_10007, var_10_0 = arg_10_0.checkEquipAble(var_1_10007, iter_10_0)
		setText = var_9
		findTF = var_1_10010

		var_9(var_1_10010(var_1_10005, "amount"), var_10_0 - var_1_10007)
	end

	setActive = var_1

	var_1(arg_10_0.descTf, arg_10_0.curSelectItem ~= nil)

	if arg_10_0.curSelectItem then
		local var_10_1 = arg_10_0.descTf
		local var_10_2 = arg_10_0._equipUI

		var_10_1.anchoredPosition = var_2.InverseTransformPoint(var_10_2, arg_10_0.curSelectItem.position)
		setText = var_10_1

		local var_10_3 = arg_10_0.descTextTf

		i18n = var_10_2

		var_10_1(var_10_3, var_10_2(arg_10_0.curSelectData.desc))
	end

	local var_10_4 = var_0_1.GetGameUseTimes()
	local var_10_5 = var_0_1.GetGameTimes()

	if 0 < var_10_5 then
		var_10_4 = var_10_4 + 1
	end

	SailBoatGameConst = var_3

	local var_10_6 = var_3.game_round[var_10_4].equip_count
	local var_10_7 = 1

	SailBoatGameConst = var_1_10005

	for iter_10_1 = var_10_7, var_1_10005.max_equip_count do
		local var_10_8 = iter_10_1
		local var_10_9 = arg_10_0.equips[iter_10_1]
		local var_10_10 = arg_10_0.equipItems[iter_10_1]

		setActive = var_1_10011
		findTF = var_1_10012

		var_1_10011(var_1_10012(var_10_10, "lock"), var_10_6 < iter_10_1)

		setActive = var_1_10011
		findTF = var_1_10012

		var_1_10011(var_1_10012(var_10_10, "empty"), false)

		setActive = var_1_10011
		findTF = var_1_10012

		var_1_10011(var_1_10012(var_10_10, "bg"), false)

		setActive = var_1_10011
		findTF = var_1_10012

		var_1_10011(var_1_10012(var_10_10, "icon"), false)

		setActive = var_1_10011
		findTF = var_1_10012

		var_1_10011(var_1_10012(var_10_10, "unEquip"), false)

		setActive = var_1_10011
		findTF = var_1_10012

		var_1_10011(var_1_10012(var_10_10, "add"), false)

		setActive = var_1_10011
		findTF = var_1_10012

		var_1_10011(var_1_10012(var_10_10, "add_2"), false)

		var_1_10011 = true

		local var_10_12

		if var_10_9 ~= 0 then
			SailBoatGameConst = var_1_10012
			var_1_10012 = var_1_10012.equip_data[var_10_9]
			GetComponent = var_10_12
			findTF = var_14

			local var_10_11 = var_14(var_10_10, "icon")

			typeof = var_15
			Image = var_16
			var_10_12 = var_10_12(var_10_11, var_15(var_16))
			var_10_12.sprite = var_0_1.GetEquipIcon(var_1_10012.icon)

			local var_10_13 = var_10_12

			var_10_12.SetNativeSize(var_10_13)

			setActive = var_14
			findTF = var_10_13

			var_14(var_10_13(var_10_10, "bg"), true)

			setActive = var_14
			findTF = var_15

			var_14(var_15(var_10_10, "icon"), true)

			if arg_10_0.unEquipFlag then
				setActive = var_14
				findTF = var_15

				var_14(var_15(var_10_10, "unEquip"), true)
			end

			var_1_10011 = false
		else
			setActive = var_1_10012
			findTF = var_10_12

			var_1_10012(var_10_12(var_10_10, "empty"), true)
		end

		if arg_10_0.curSelectItem and iter_10_1 <= var_10_6 then
			if var_1_10011 then
				setActive = var_1_10012
				findTF = var_10_12

				var_1_10012(var_10_12(var_10_10, "add"), true)
			else
				setActive = var_1_10012
				findTF = var_10_12

				var_1_10012(var_10_12(var_10_10, "add_2"), true)
			end
		end
	end

	local var_10_14 = arg_10_0.baseHp
	local var_10_15 = arg_10_0.baseSpeed

	for iter_10_2 = 1, #arg_10_0.equips do
		if arg_10_0.equips[iter_10_2] ~= 0 then
			SailBoatGameConst = var_1_10011
			var_10_14 = var_10_14 + var_1_10011.equip_data[var_10].hp
			var_10_15 = var_10_15 + var_1_10011.speed
		end
	end

	setText = var_6

	local var_10_16 = arg_10_0.speedTf

	tostring = var_8

	var_6(var_10_16, var_8(var_10_15))

	setText = var_6

	local var_10_17 = arg_10_0.hpTf

	tostring = var_8

	var_6(var_10_17, var_8(var_10_14))

	var_0_1.equips = arg_10_0.equips

	return
end

return var_0_0
