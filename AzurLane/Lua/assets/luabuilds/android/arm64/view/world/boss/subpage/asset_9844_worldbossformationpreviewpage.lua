class = var_0_10000

local var_0_0 = "WorldBossFormationPreViewPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "WorldBossFormationPreViewPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = arg_2_0._tf

	var_2_0[1] = var_2.Find(var_2_1, "frame/ships/1")

	local var_2_2 = arg_2_0._tf

	var_2_0[2] = var_2.Find(var_2_2, "frame/ships/2")

	local var_2_3 = arg_2_0._tf

	var_2_0[3] = var_2.Find(var_2_3, "frame/ships/3")
	arg_2_0.shipList = var_2_0

	local var_2_4 = arg_2_0._tf

	arg_2_0.returnBtn = var_1.Find(var_2_4, "frame/return")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.returnBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onToggle = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0._tf
	local var_3_8 = var_4.Find(var_3_7, "frame/toggles/main")

	local function var_3_9(arg_6_0)
		if arg_6_0 then
			local var_6_0 = arg_3_0

			var_1.Switch(var_6_0, 1)
		end

		return
	end

	SFX_PANEL = var_3_7

	var_1_10001(var_3_6, var_3_8, var_3_9, var_3_7)

	onToggle = var_1_10001

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0._tf
	local var_3_12 = var_4.Find(var_3_11, "frame/toggles/vanguard")

	local function var_3_13(arg_7_0)
		if arg_7_0 then
			local var_7_0 = arg_3_0

			var_1.Switch(var_7_0, 2)
		end

		return
	end

	SFX_PANEL = var_3_11

	var_1_10001(var_3_10, var_3_12, var_3_13, var_3_11)

	return
end

function var_0_1.Switch(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.ships[arg_8_1]

	ipairs = var_1_10003

	for iter_8_0, iter_8_1 in var_1_10003(arg_8_0.shipList) do
		local var_8_1 = var_8_0[iter_8_0]

		arg_8_0:UpdateShip(iter_8_1, var_8_1)
	end

	return
end

function var_0_1.Show(arg_9_0, arg_9_1)
	var_0_1.super.Show(arg_9_0)

	setParent = var_2

	local var_9_0 = arg_9_0._tf

	pg = var_1_10005

	var_2(var_9_0, var_1_10005.UIMgr.GetInstance().UIMain)

	local var_9_1 = {}
	local var_9_2 = {}

	ipairs = var_9_0

	for iter_9_0, iter_9_1 in var_9_0(arg_9_1) do
		local var_9_3 = iter_9_1:getTeamType()

		TeamType = var_1_10010

		if var_9_3 == var_1_10010.Vanguard then
			table = var_1_10010

			var_1_10010.insert(var_9_2, iter_9_1)
		else
			TeamType = var_1_10010

			if var_9_3 == var_1_10010.Main then
				table = var_1_10010

				var_1_10010.insert(var_9_1, iter_9_1)
			end
		end
	end

	arg_9_0.ships = {
		var_9_1,
		var_9_2
	}
	triggerToggle = var_4

	local var_9_4 = arg_9_0._tf

	var_4(var_6.Find(var_9_4, "frame/toggles/main"), true)

	return
end

function var_0_1.OnHide(arg_10_0)
	var_0_1.super.OnHide(arg_10_0)

	return
end

function var_0_1.UpdateShip(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1
	local var_11_1 = arg_11_1.Find(var_11_0, "bg/info")

	setActive = var_1_10004

	var_1_10004(var_11_1, arg_11_2)

	if arg_11_2 then
		local var_11_2 = var_11_1:Find("name")
		local var_11_3 = var_4.GetComponent

		typeof = var_7
		Text = var_1_10009

		local var_11_4 = var_11_3(var_11_2, var_7(var_1_10009))
		local var_11_5 = var_11_1:Find("ship_type")

		var_11_0 = var_11_0.GetComponent
		typeof = var_8
		Image = var_1_10010
		var_11_0 = var_11_0(var_11_5, var_8(var_1_10010))
		UIItemList = var_11_2

		local var_11_6 = var_11_2.New(var_11_1:Find("stars"), var_11_1:Find("stars/star_tpl"))
		local var_11_7 = var_11_1:Find("lv")
		local var_11_8 = var_7.GetComponent

		typeof = var_10
		Text = var_12

		local var_11_9 = var_11_8(var_11_7, var_10(var_12))

		shortenString = var_8

		local var_11_10 = arg_11_2

		var_11_4.text = var_8(arg_11_2.getName(var_11_10), 6)
		pg = var_8

		local var_11_11 = var_8.ship_data_statistics[arg_11_2.configId]

		GetSpriteFromAtlas = var_9

		local var_11_12 = "shiptype"

		shipType2print = var_11_10
		var_11_0.sprite = var_9(var_11_12, var_11_10(var_11_11.type))

		local var_11_13 = arg_11_2:getMaxStar()
		local var_11_14 = arg_11_2:getStar()

		var_11_6:make(function(arg_12_0, arg_12_1, arg_12_2)
			UIItemList = var_2_10003

			if arg_12_0 == var_2_10003.EventUpdate then
				setActive = var_3

				var_3(arg_12_2:Find("star_tpl"), arg_12_1 <= var_11_14)
			end

			return
		end)
		var_11_6:align(var_11_13)

		var_11_9.text = "Lv." .. arg_11_2.level

		local var_11_15 = var_11_1:Find("mask/icon")
		local var_11_16 = var_11.GetComponent

		typeof = var_14
		Image = var_1_10016

		local var_11_17 = var_11_16(var_11_15, var_14(var_1_10016))

		LoadSprite = var_12
		var_11_17.sprite = var_12("HeroHrzIcon/" .. arg_11_2:getPainting())
	end

	local var_11_18 = arg_11_1:Find("bg/line")

	if arg_11_2 then
		Vector2 = var_11_0

		if not var_11_0(235, 2) then
			Vector2 = var_11_0
			var_11_0 = var_11_0(461, 2)
		end

		var_11_18.sizeDelta = var_11_0

		arg_11_0:UpdateEquipments(var_11_1, arg_11_2)

		return
	end
end

function var_0_1.UpdateEquipments(arg_13_0, arg_13_1, arg_13_2)
	UIItemList = var_1_10003

	local var_13_0 = var_1_10003.New
	local var_13_1 = arg_13_1.parent
	local var_13_2 = var_5.Find(var_13_1, "equipemtns")
	local var_13_3 = arg_13_1.parent
	local var_13_4 = var_13_0(var_13_2, var_6.Find(var_13_3, "equipemtns/equipment_tpl"))
	local var_13_5

	if not arg_13_2 or not arg_13_2:getActiveEquipments() then
		var_13_5 = {}
	end

	var_13_4:make(function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			local var_14_0 = var_13_5[arg_14_1 + 1]

			setActive = var_4

			var_4(arg_14_2:Find("info"), var_14_0)

			setActive = var_4

			var_4(arg_14_2:Find("empty"), not var_14_0)

			if var_14_0 then
				updateEquipment = var_4

				var_4(arg_14_2:Find("info"), var_14_0)

				onButton = var_4

				local var_14_1 = arg_13_0
				local var_14_2 = arg_14_2

				local function var_14_3()
					local var_15_0 = arg_13_0
					local var_15_1 = var_0.emit

					BaseUI = var_3_10003

					local var_15_2 = var_3_10003.ON_EQUIPMENT
					local var_15_3 = {}

					EquipmentInfoMediator = var_3_10005
					var_15_3.type = var_3_10005.TYPE_DISPLAY
					var_15_3.equipment = var_14_0

					var_15_1(var_15_0, var_15_2, var_15_3)

					return
				end

				SFX_PANEL = var_9

				var_4(var_14_1, var_14_2, var_14_3, var_9)
			else
				removeOnButton = var_4

				var_4(arg_14_2)
			end
		end

		return
	end)
	var_13_4:align(5)

	return
end

function var_0_1.OnDestroy(arg_16_0)
	return
end

return var_0_1
