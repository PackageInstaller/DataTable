class = var_0_10000

local var_0_0 = "TransformEquipmentCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().candicate

	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_2_0)
			local var_2_0 = var_1_0.type

			DROP_TYPE_ITEM = var_2_10002

			if var_2_0 == var_2_10002 then
				pg = var_2_0
				var_2_10002 = var_2_0.MsgboxMgr.GetInstance()

				local var_2_1 = var_1.ShowMsgBox

				var_2_10003 = {}
				i18n = var_2_10004
				var_2_10003.content = var_2_10004("equipment_upgrade_feedback_compose_tip")
				var_2_10003.onYes = arg_2_0

				var_2_1(var_2_10002, var_2_10003)

				return
			else
				local var_2_2 = var_1_0.type

				DROP_TYPE_EQUIP = var_2_10002

				if var_2_2 == var_2_10002 and var_1_0.template.shipId ~= nil then
					local var_2_3 = var_1_0.template.shipId

					getProxy = var_2_10002
					BayProxy = var_2_10003

					local var_2_4 = var_2_10002(var_2_10003)
					local var_2_5 = var_2.getShipById(var_2_4, var_2_3)

					ShipStatus = var_2_4

					local var_2_6, var_2_7 = var_2_4.ShipStatusCheck("onModify", var_2_5)

					if not var_2_6 then
						pg = var_5

						local var_2_8 = var_5.TipsMgr.GetInstance()

						var_5.ShowTips(var_2_8, var_2_7)

						return
					end

					pg = var_5

					local var_2_9 = var_5.MsgboxMgr.GetInstance()
					local var_2_10 = var_5.ShowMsgBox
					local var_2_11 = {}

					i18n = var_2_10008

					local var_2_12 = "equipment_upgrade_feedback_equipment_consume"
					local var_2_13 = var_2_5:getName()
					local var_2_14 = var_1_0.template

					var_2_11.content = var_2_10008(var_2_12, var_2_13, var_11.getConfig(var_2_14, "name"))
					var_2_11.onYes = arg_2_0

					var_2_10(var_2_9, var_2_11)

					return
				end
			end

			arg_2_0()

			return
		end,
		function(arg_3_0)
			local var_3_0 = var_1_0.type

			DROP_TYPE_EQUIP = var_2_10002

			if var_3_0 == var_2_10002 then
				return arg_3_0({
					shipId = var_1_0.template.shipId,
					pos = var_1_0.template.shipPos,
					equipmentId = var_1_0.template.id,
					formulaIds = var_0.formulaIds
				})
			end

			local var_3_1 = var_1_0.composeCfg.id
			local var_3_2 = 1

			getProxy = var_2_10003
			BagProxy = var_2_10004

			local var_3_3 = var_2_10003(var_2_10004)

			getProxy = var_2_10004
			PlayerProxy = var_2_10005

			local var_3_4 = var_2_10004(var_2_10005)
			local var_3_5 = var_4.getData(var_3_4)

			pg = var_3_4

			local var_3_6 = var_3_4.compose_data_template[var_3_1]

			getProxy = var_2_10007
			EquipmentProxy = var_2_10008

			local var_3_7 = var_2_10007(var_2_10008)
			local var_3_8 = var_7.getCapacity(var_3_7)

			if var_3_5:getMaxEquipmentBag() < var_3_8 + var_3_2 then
				NoPosMsgBox = var_9
				i18n = var_10

				local var_3_9 = var_10("switch_to_shop_tip_noPos")

				openDestroyEquip = var_11
				gotoChargeScene = var_2_10012

				var_9(var_3_9, var_11, var_2_10012)

				return
			end

			if var_3_5.gold < var_3_6.gold_num * var_3_2 then
				GoShoppingMsgBox = var_9
				i18n = var_10

				local var_3_10 = "switch_to_shop_tip_2"

				i18n = var_2_10012

				local var_3_11 = var_10(var_3_10, var_2_10012("word_gold"))

				ChargeScene = var_3_10

				var_9(var_3_11, var_3_10.TYPE_ITEM, {
					{
						59001,
						var_3_6.gold_num * var_3_2 - var_3_5.gold,
						var_3_6.gold_num * var_3_2
					}
				})

				return
			end

			local var_3_12 = var_3_3

			if not var_3_3.getItemById(var_3_12, var_3_6.material_id) or var_9.count < var_3_6.material_num * var_3_2 then
				pg = var_3_12

				local var_3_13 = var_3_12.TipsMgr.GetInstance()

				var_3_12 = var_3_12.ShowTips
				i18n = var_2_10012

				var_3_12(var_3_13, var_2_10012("word_materal_no_enough"))

				return
			end

			pg = var_3_12

			local var_3_14 = var_3_12.ConnectionMgr.GetInstance()

			var_10.Send(var_3_14, 14006, {
				id = var_3_1,
				num = var_3_2
			}, 14007, function(arg_4_0)
				local var_4_5

				if arg_4_0.result == 0 then
					local var_4_0 = var_0

					var_4_5.addEquipmentById(var_4_0, var_3_6.equip_id, var_3_2)

					local var_4_1 = var_3_5

					var_4_5.consume(var_4_1, {
						gold = var_3_6.gold_num * var_3_2
					})

					local var_4_2 = var_0

					var_4_5.updatePlayer(var_4_2, var_3_5)

					local var_4_3 = var_3_3

					var_4_5.removeItemById(var_4_3, var_3_6.material_id, var_3_6.material_num * var_3_2)

					local var_4_4 = arg_1_0

					var_4_5 = var_4_5.sendNotification
					GAME = var_3_10003
					var_3_10003 = var_3_10003.COMPOSITE_EQUIPMENT_DONE

					local var_4_6 = {}

					Equipment = var_5
					var_4_6.equipment = var_5.New({
						id = var_3_6.equip_id
					})
					var_4_6.count = var_3_2
					var_4_6.composeId = var_3_1

					var_4_5(var_4_4, var_3_10003, var_4_6)
					arg_3_0({
						equipmentId = var_3_6.equip_id,
						formulaIds = var_0.formulaIds
					})
				else
					pg = var_4_5

					local var_4_7 = var_4_5.TipsMgr.GetInstance()
					local var_4_8 = var_1.ShowTips

					errorTip = var_3_10003

					var_4_8(var_4_7, var_3_10003("equipment_compositeEquipment", arg_4_0.result))
				end

				return
			end)

			return
		end,
		function(arg_5_0, arg_5_1)
			local var_5_0 = arg_1_0

			var_2.ExecuteEquipTransform(var_5_0, arg_5_1)

			return
		end
	})

	return
end

function var_0_1.ExecuteEquipTransform(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.shipId
	local var_6_1 = arg_6_1.pos
	local var_6_2 = arg_6_1.equipmentId
	local var_6_3 = arg_6_1.formulaIds
	local var_6_4

	if var_2 then
		getProxy = var_1_10008
		BayProxy = var_1_10009

		local var_6_5 = var_1_10008(var_1_10009)
		local var_6_6 = var_1_10008.getShipById(var_6_5, var_2)

		var_6_4 = var_1_10009.getEquip(var_6_6, var_6_1)
		assert = var_10

		var_10(var_6_4, "can not find equipment at ship.")

		var_6_2 = var_6_4.id
	elseif var_6_2 ~= 0 then
		getProxy = var_1_10008
		EquipmentProxy = var_1_10009

		local var_6_7 = var_1_10008(var_1_10009)

		var_6_4 = var_1_10008.getEquipmentById(var_6_7, var_6_2)
		assert = var_9

		var_9(var_6_4, "can not find equipment: " .. var_6_2)

		var_6_2 = var_6_4.id
	end

	EquipmentTransformUtil = var_1_10008

	local var_6_8, var_6_9 = var_1_10008.CheckEquipmentFormulasSucceed(var_6_3, var_6_2)

	if not var_6_8 then
		pg = var_10

		local var_6_10 = var_10.TipsMgr.GetInstance()
		local var_6_11 = var_10.ShowTips

		i18n = var_1_10012

		var_6_11(var_6_10, var_1_10012("common_no_x", var_6_9))

		return
	end

	local var_6_12 = {}
	local var_6_13 = {}

	local function var_6_14()
		getProxy = var_2_10000
		BagProxy = var_2_10001

		local var_7_0 = var_2_10000(var_2_10001)

		getProxy = var_2_10001
		PlayerProxy = var_2_10002

		local var_7_1 = var_2_10001(var_2_10002)

		pairs = var_2_10002

		for iter_7_0, iter_7_1 in var_2_10002(var_6_12) do
			if iter_7_0 == "gold" then
				local var_7_2 = var_7_1:getData()
				local var_7_3 = {}

				math = var_2_10009
				var_7_3.gold = var_2_10009.abs(iter_7_1)

				if 0 < iter_7_1 then
					var_7_2:consume(var_7_3)
					var_7_1:updatePlayer(var_7_2)
				elseif iter_7_1 < 0 then
					var_7_2:addResources(var_7_3)
					var_7_1:updatePlayer(var_7_2)
				end
			elseif iter_7_1 > 0 then
				var_7_0:removeItemById(iter_7_0, iter_7_1)
			elseif iter_7_1 < 0 then
				var_7_0:addItemById(iter_7_0, -iter_7_1)
			end
		end

		table = var_2

		var_2.clear(var_6_12)

		return
	end

	local var_6_15 = var_6_2

	local function var_6_16()
		var_6_14()

		getProxy = var_0
		BayProxy = var_2_10001

		local var_8_0 = var_0(var_2_10001)

		getProxy = var_2_10001
		EquipmentProxy = var_2_10002

		local var_8_1 = var_2_10001(var_2_10002)
		local var_8_2
		local var_8_3

		if var_0 then
			local var_8_4 = var_8_0:getShipById(var_0)

			var_8_3 = var_8_2.getEquip(var_8_4, var_6_1)
		else
			var_8_3 = var_8_1:getEquipmentById(var_6_2)
		end

		assert = var_4

		local var_8_5 = var_8_3
		local var_8_6 = "Cant Get Equip "
		local var_8_7

		if not var_0 or not ("Ship " .. var_0 .. " Pos " .. var_6_1) then
			var_8_7 = "ID " .. var_6_2
		end

		var_4(var_8_5, var_8_6 .. var_8_7)

		local var_8_8 = var_8_3:MigrateTo(var_6_15)

		if var_8_2 then
			if not var_8_2:isForbiddenAtPos(var_8_8, var_6_1) then
				var_8_2:updateEquip(var_6_1, var_8_8)
				var_8_0:updateShip(var_8_2)
			else
				var_8_2:updateEquip(var_6_1, nil)
				var_8_0:updateShip(var_8_2)

				var_0 = nil

				var_8_1:addEquipment(var_8_8)
			end
		else
			var_8_1:removeEquipmentById(var_8_3.id, 1)
			var_8_1:addEquipmentById(var_8_8.id, 1)
		end

		return var_8_2, var_8_3, var_8_8
	end

	local var_6_17 = var_6_4
	local var_6_18
	local var_6_19
	local var_6_20

	table = var_1_10019

	var_1_10019.SerialIpairsAsync(var_6_3, function(arg_9_0, arg_9_1, arg_9_2)
		seriesAsync = var_2_10003

		var_2_10003({
			function(arg_10_0)
				local var_10_0 = var_0 and 14013 or 14015
				local var_10_1 = var_0 and 14014 or 14016
				local var_10_2

				if not var_0 or not {
					ship_id = var_0,
					pos = var_6_1,
					upgrade_id = arg_9_1
				} then
					var_10_2 = {
						equip_id = var_6_15,
						upgrade_id = arg_9_1
					}
				end

				pg = var_3_10004

				local var_10_3 = var_3_10004.ConnectionMgr.GetInstance()

				var_4.Send(var_10_3, var_10_0, var_10_2, var_10_1, arg_10_0)

				return
			end,
			function(arg_11_0, arg_11_1)
				if arg_11_1.result == 0 then
					pg = var_2

					local var_11_0 = var_2.equip_upgrade_data[arg_9_1].material_consume

					ipairs = var_3_10004

					for iter_11_0, iter_11_1 in var_3_10004(var_11_0) do
						local var_11_1 = iter_11_1[1]
						local var_11_2 = iter_11_1[2]
						local var_11_3 = var_6_12
						local var_11_4

						if not var_6_12[var_11_1] then
							var_11_4 = 0
						end

						var_11_3[var_11_1] = var_11_4 + var_11_2
					end

					var_3_10004 = var_6_12

					local var_11_5

					if not var_6_12.gold then
						var_11_5 = 0
					end

					var_3_10004.gold = var_11_5 + var_2.coin_consume
					Equipment = var_3_10004
					var_3_10004 = var_3_10004.GetRevertRewardsStatic(var_6_15)
					pairs = var_5

					for iter_11_2, iter_11_3 in var_5(var_3_10004) do
						if iter_11_2 ~= "gold" then
							local var_11_6 = var_6_12
							local var_11_7

							if not var_6_12[iter_11_2] then
								var_11_7 = 0
							end

							var_11_6[iter_11_2] = var_11_7 - iter_11_3

							local var_11_8 = var_6_13
							local var_11_9

							if not var_6_13[iter_11_2] then
								var_11_9 = 0
							end

							var_11_8[iter_11_2] = var_11_9 + iter_11_3
						end
					end

					assert = var_5
					Equipment = var_6

					local var_11_10 = var_6.CanInBag(var_6_15)
					local var_11_11 = "Missing equip_data_template ID: "
					local var_11_12

					if not var_6_15 then
						var_11_12 = "NIL"
					end

					var_5(var_11_10, var_11_11 .. var_11_12)

					Equipment = var_5

					if var_5.CanInBag(var_6_15) then
						Equipment = var_5

						local var_11_13

						if not var_5.getConfigData(var_6_15).destory_gold then
							var_11_13 = 0
						end

						local var_11_14 = var_6_12
						local var_11_15

						if not var_6_12.gold then
							var_11_15 = 0
						end

						var_11_14.gold = var_11_15 - var_11_13

						local var_11_16 = var_6_13
						local var_11_17

						if not var_6_13.gold then
							var_11_17 = 0
						end

						var_11_16.gold = var_11_17 + var_11_13
					end

					var_6_2 = var_6_15
					var_6_15 = var_2.target_id
					var_6_18, var_6_19, var_6_20 = var_6_16()

					arg_9_2()
				else
					pg = var_2

					local var_11_18 = var_2.TipsMgr.GetInstance()
					local var_11_19 = var_2.ShowTips

					ERROR_MESSAGE = var_3_10004

					var_11_19(var_11_18, var_3_10004[arg_11_1.result] .. arg_11_1.result)

					local var_11_20 = arg_6_0
					local var_11_21 = var_2.sendNotification

					GAME = var_4

					var_11_21(var_11_20, var_4.TRANSFORM_EQUIPMENT_FAIL)
				end

				return
			end
		})

		return
	end, function()
		if not var_0 and var_6_0 then
			getProxy = var_0
			BayProxy = var_2_10001

			local var_12_0 = var_0(var_2_10001)
			local var_12_1 = var_0.getShipById(var_12_0, var_6_0)

			pg = var_12_0

			local var_12_2 = var_12_0.TipsMgr.GetInstance()
			local var_12_3 = var_1.ShowTips

			i18n = var_2_10003

			local var_12_4 = "equipment_upgrade_equipped_unavailable"
			local var_12_5 = var_12_1:getName()
			local var_12_6 = var_6_20

			var_12_3(var_12_2, var_2_10003(var_12_4, var_12_5, var_6.getConfig(var_12_6, "name")))
		end

		local var_12_7 = {
			ship = var_6_18,
			equip = var_6_19,
			newEquip = var_6_20
		}
		local var_12_8 = arg_6_0
		local var_12_9 = var_1.sendNotification

		GAME = var_2_10003

		var_12_9(var_12_8, var_2_10003.TRANSFORM_EQUIPMENT_DONE, var_12_7)

		LoadContextCommand = var_12_9

		local var_12_10 = var_12_9.LoadLayerOnTopContext

		Context = var_12_8

		local var_12_11 = var_12_8.New
		local var_12_12 = {}

		EquipmentTransformInfoMediator = var_4
		var_12_12.mediator = var_4
		EquipmentTransformInfoLayer = var_4
		var_12_12.viewComponent = var_4
		var_12_12.data = {
			equipVO = var_6_17
		}

		function var_12_12.onRemoved()
			getProxy = var_3_10000
			ContextProxy = var_3_10001

			local var_13_0 = var_3_10000(var_3_10001)
			local var_13_1 = var_0.getCurrentContext(var_13_0)
			local var_13_2 = var_1.getContextByMediator

			EquipmentInfoMediator = var_3_10004

			if var_13_2(var_13_1, var_3_10004) then
				pg = var_13_1

				local var_13_3 = var_13_1.m02
				local var_13_4 = var_13_1.retrieveMediator(var_13_3, var_2.mediator.__cname)
				local var_13_5 = var_13_1.getViewComponent(var_13_4)

				var_4.closeView(var_13_5)
			end

			pg = var_13_1

			local var_13_6 = var_13_1.m02
			local var_13_7 = var_3.retrieveMediator(var_13_6, var_1.mediator.__cname)
			local var_13_8 = var_3.getViewComponent(var_13_7)

			seriesAsync = var_13_7

			var_13_7({
				function(arg_14_0)
					local var_14_0 = var_13_8
					local var_14_1 = var_1.emit

					BaseUI = var_4_10003

					local var_14_2 = var_4_10003.ON_ACHIEVE
					local var_14_3 = {}
					local var_14_4 = {
						count = 1
					}
					local var_14_5

					if not var_6_20 or not var_6_20.id then
						var_14_5 = 0
					end

					var_14_4.id = var_14_5
					DROP_TYPE_EQUIP = var_14_5
					var_14_4.type = var_14_5
					var_14_3[1] = var_14_4

					var_14_1(var_14_0, var_14_2, var_14_3, arg_14_0)

					return
				end,
				function(arg_15_0)
					onNextTick = var_4_10001

					var_4_10001(arg_15_0)

					return
				end,
				function(arg_16_0)
					next = var_4_10001

					if not var_4_10001(var_6_13) then
						arg_16_0()

						return
					end

					local var_16_0 = {}

					pairs = var_2

					for iter_16_0, iter_16_1 in var_2(var_6_13) do
						if iter_16_0 == "gold" then
							table = var_4_10007
							var_4_10007 = var_4_10007.insert

							local var_16_1 = var_16_0
							local var_16_2 = {}

							DROP_TYPE_RESOURCE = var_4_10010
							var_16_2.type = var_4_10010
							res2id = var_4_10010
							var_16_2.id = var_4_10010(iter_16_0)
							var_16_2.count = iter_16_1

							var_4_10007(var_16_1, var_16_2)
						else
							table = var_4_10007
							var_4_10007 = var_4_10007.insert

							local var_16_3 = var_16_0
							local var_16_4 = {}

							DROP_TYPE_ITEM = var_4_10010
							var_16_4.type = var_4_10010
							var_16_4.id = iter_16_0
							var_16_4.count = iter_16_1

							var_4_10007(var_16_3, var_16_4)
						end
					end

					local var_16_5 = var_13_8
					local var_16_6 = var_2.emit

					BaseUI = var_4

					local var_16_7 = var_4.ON_AWARD
					local var_16_8 = {
						items = var_16_0
					}

					AwardInfoLayer = iter_16_1
					var_16_8.title = iter_16_1.TITLE.REVERT
					var_16_8.removeFunc = arg_16_0

					var_16_6(var_16_5, var_16_7, var_16_8)

					return
				end,
				function(arg_17_0)
					local var_17_0 = arg_6_0
					local var_17_1 = var_1.sendNotification

					GAME = var_4_10003

					var_17_1(var_17_0, var_4_10003.TRANSFORM_EQUIPMENT_AWARD_FINISHED, var_12_7)

					return
				end
			})

			return
		end

		var_12_10(var_12_11(var_12_12))

		return
	end)

	return
end

return var_0_1
