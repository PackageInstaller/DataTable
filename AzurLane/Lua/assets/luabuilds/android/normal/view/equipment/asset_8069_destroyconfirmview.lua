class = var_0_10000

local var_0_0 = "DestroyConfirmView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "StoreHouseDestroyConfirmView"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.destroyBonusList = var_1.Find(var_2_0, "frame/bg/scrollview/list")

	local var_2_1 = arg_2_0.destroyBonusList

	arg_2_0.destroyBonusItem = var_1.Find(var_2_1, "equipment_tpl")

	local var_2_2 = arg_2_0._tf

	arg_2_0.destroyNoGotTip = var_1.Find(var_2_2, "frame/bg/tip")
	setText = var_1

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_2.Find(var_2_3, "frame/title_text/Text")

	i18n = var_2_3

	var_1(var_2_4, var_2_3("equipment_select_device_destroy_bonus_tip"))

	setText = var_1

	local var_2_5 = arg_2_0.destroyNoGotTip

	i18n = var_3

	var_1(var_2_5, var_3("equipment_select_device_destroy_nobonus_tip"))

	onButton = var_1

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_3.Find(var_2_7, "frame/actions/cancel_btn")

	local function var_2_9()
		local var_3_0 = arg_2_0

		var_0.Hide(var_3_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_6, var_2_8, var_2_9, var_5)

	onButton = var_1

	local var_2_10 = arg_2_0
	local var_2_11 = arg_2_0._tf

	local function var_2_12()
		local var_4_0 = arg_2_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_10, var_2_11, var_2_12, var_5)

	onButton = var_1

	local var_2_13 = arg_2_0
	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_3.Find(var_2_14, "frame/top/btnBack")

	local function var_2_16()
		local var_5_0 = arg_2_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_13, var_2_15, var_2_16, var_5)

	onButton = var_1

	local var_2_17 = arg_2_0
	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_3.Find(var_2_18, "frame/actions/confirm_btn")

	local function var_2_20()
		local var_6_0 = arg_2_0
		local var_6_1 = var_0.emit

		EquipmentMediator = var_2_10002

		var_6_1(var_6_0, var_2_10002.ON_DESTROY, arg_2_0.selectedIds)
		arg_2_0.confirmBtnCB()

		local var_6_2 = arg_2_0

		var_0.Hide(var_6_2)

		return
	end

	SFX_UI_EQUIPMENT_RESOLVE = var_5

	var_1(var_2_17, var_2_19, var_2_20, var_5)

	return
end

function var_0_1.Show(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_7_0, arg_7_0._tf)

	setActive = var_1

	var_1(arg_7_0._tf, true)

	return
end

function var_0_1.Hide(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_8_0, arg_8_0._tf, arg_8_0._parentTf)

	setActive = var_1

	var_1(arg_8_0._tf, false)

	return
end

function var_0_1.SetConfirmBtnCB(arg_9_0, arg_9_1)
	arg_9_0.confirmBtnCB = arg_9_1

	return
end

function var_0_1.DisplayDestroyBonus(arg_10_0, arg_10_1)
	arg_10_0.selectedIds = arg_10_1

	local var_10_0 = {}
	local var_10_1 = 0

	ipairs = var_1_10004

	for iter_10_0, iter_10_1 in var_1_10004(arg_10_0.selectedIds) do
		Equipment = var_1_10009

		if var_1_10009.CanInBag(iter_10_1[1]) then
			Equipment = var_1_10009

			local var_10_2

			if not var_1_10009.getConfigData(iter_10_1[1]).destory_item then
				var_10_2 = {}
			end

			local var_10_3

			if not var_1_10009.destory_gold then
				var_10_3 = 0
			end

			var_10_1 = var_10_1 + var_10_3 * iter_10_1[2]
			ipairs = var_12

			for iter_10_2, iter_10_3 in var_12(var_10_2) do
				local var_10_4 = false

				ipairs = var_1_10018

				for iter_10_4, iter_10_5 in var_1_10018(var_10_0) do
					if iter_10_3[1] == var_10_0[iter_10_4].id then
						var_10_0[iter_10_4].count = var_10_0[iter_10_4].count + iter_10_3[2] * iter_10_1[2]
						var_10_4 = true

						break
					end
				end

				if not var_10_4 then
					table = var_1_10018
					var_1_10018 = var_1_10018.insert

					local var_10_5 = var_10_0
					local var_10_6 = {}

					DROP_TYPE_ITEM = iter_10_4
					var_10_6.type = iter_10_4
					var_10_6.id = iter_10_3[1]
					var_10_6.count = iter_10_3[2] * iter_10_1[2]

					var_1_10018(var_10_5, var_10_6)
				end
			end
		end
	end

	local var_10_7

	if 0 < var_10_1 then
		table = var_10_7
		var_10_7 = var_10_7.insert

		local var_10_8 = var_10_0
		local var_10_9 = {
			id = 1
		}

		DROP_TYPE_RESOURCE = iter_10_0
		var_10_9.type = iter_10_0
		var_10_9.count = var_10_1

		var_10_7(var_10_8, var_10_9)
	end

	setActive = var_10_7

	var_10_7(arg_10_0.destroyNoGotTip, #var_10_0 <= 0)

	if not arg_10_0.destroyList then
		UIItemList = var_4
		arg_10_0.destroyList = var_4.New(arg_10_0.destroyBonusList, arg_10_0.destroyBonusItem)
	end

	local var_10_10 = arg_10_0.destroyList

	var_4.make(var_10_10, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = var_10_0[arg_11_1 + 1].type

			DROP_TYPE_SHIP = var_2_10005

			if var_11_0 == var_2_10005 then
				var_11_0 = arg_10_0
				var_11_0.hasShip = true
			end

			updateDrop = var_11_0

			var_11_0(arg_11_2, var_3)

			contentWrap = var_11_0

			local var_11_1, var_11_2 = var_11_0(var_3:getConfig("name"), 10, 2)

			if var_11_1 then
				var_11_2 = var_11_2 .. "..."
			end

			setText = var_6

			var_6(arg_11_2:Find("name"), var_11_2)

			onButton = var_6

			local var_11_3 = arg_10_0
			local var_11_4 = arg_11_2

			local function var_11_5()
				local var_12_0 = var_0.type

				DROP_TYPE_RESOURCE = var_3_10001

				if var_12_0 ~= var_3_10001 then
					local var_12_1 = var_0.type

					DROP_TYPE_ITEM = var_3_10001

					if var_12_1 == var_3_10001 then
						var_3_10001 = arg_10_0

						local var_12_2 = var_0.emit

						BaseUI = var_3_10002
						var_3_10002 = var_3_10002.ON_ITEM

						local var_12_3 = var_0

						var_12_2(var_3_10001, var_3_10002, var_3.getConfig(var_12_3, "id"))
					else
						local var_12_4 = var_0.type

						DROP_TYPE_EQUIP = var_3_10001

						if var_12_4 == var_3_10001 then
							local var_12_5 = arg_10_0
							local var_12_6 = var_0.emit

							BaseUI = var_3_10002

							local var_12_7 = var_3_10002.ON_EQUIPMENT
							local var_12_8 = {}
							local var_12_9 = var_0

							var_12_8.equipmentId = var_4.getConfig(var_12_9, "id")
							EquipmentInfoMediator = var_4
							var_12_8.type = var_4.TYPE_DISPLAY

							var_12_6(var_12_5, var_12_7, var_12_8)
						end
					end

					return
				end
			end

			SFX_PANEL = var_2_10010

			var_6(var_11_3, var_11_4, var_11_5, var_2_10010)
		end

		return
	end)

	local var_10_11 = arg_10_0.destroyList

	var_4.align(var_10_11, #var_10_0)

	return
end

return var_0_1
