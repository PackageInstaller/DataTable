class = var_0_10000

local var_0_0 = "RemouldShipCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId
	local var_1_1 = var_2.remouldId
	local var_1_2

	if not var_2.materialIds then
		var_1_2 = {}
	end

	if not var_1_0 or not var_1_1 then
		return
	end

	getProxy = var_1_10006
	PlayerProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)
	local var_1_4 = var_6.getData(var_1_3)

	pg = var_1_10008

	local var_1_5 = var_1_10008.transform_data_template[var_1_1]

	assert = var_1_3

	var_1_3(var_1_5, "transform_data_template>>>." .. var_1_1)

	local var_1_6 = var_1_5.use_gold
	local var_1_7, var_1_8

	if var_1_4.gold < var_1_6 then
		pg = var_1_8
		var_1_7 = var_1_8.TipsMgr.GetInstance()
		var_1_8 = var_1_8.ShowTips
		i18n = var_13

		var_1_8(var_1_7, var_13("common_no_resource"))

		return
	end

	getProxy = var_1_8
	BayProxy = var_1_7

	local var_1_9 = var_1_8(var_1_7)
	local var_1_10 = var_10.getShipById(var_1_9, var_1_0).transforms[var_1_1]
	local var_1_11 = 0

	if var_1_10 and var_11.transforms[var_1_1].level == #var_1_5.effect then
		pg = var_14
		var_1_10016 = var_14.TipsMgr.GetInstance()

		local var_1_12 = var_14.ShowTips

		i18n = var_1_10017

		var_1_12(var_1_10016, var_1_10017("ship_remould_max_level"))

		return
	end

	local var_1_13 = var_1_11 + 1
	local var_1_14

	if not var_1_5.use_item[var_1_13] then
		var_1_14 = {}
	end

	getProxy = var_1_10015
	BagProxy = var_1_10017

	local var_1_15 = var_1_10015(var_1_10017)

	ipairs = var_1_10016

	for iter_1_0, iter_1_1 in var_1_10016(var_1_14) do
		var_1_10023 = var_1_15

		if var_1_15.getItemCountById(var_1_10023, iter_1_1[1]) < iter_1_1[2] then
			pg = var_21
			var_1_10023 = var_21.TipsMgr.GetInstance()

			local var_1_16 = var_21.ShowTips

			i18n = var_24

			var_1_16(var_1_10023, var_24("common_no_item_1"))

			return
		end
	end

	local var_1_18

	if var_1_5.use_ship ~= 0 then
		table = var_1_18

		if var_1_18.getCount(var_1_2) ~= var_1_5.use_ship then
			pg = var_1_18

			local var_1_17 = var_1_18.TipsMgr.GetInstance()

			var_1_18 = var_1_18.ShowTips
			i18n = iter_1_0

			var_1_18(var_1_17, iter_1_0("ship_remould_material_ship_no_enough"))

			return
		end

		ipairs = var_1_18

		for iter_1_2, iter_1_3 in var_1_18(var_1_2) do
			var_1_10023 = var_10

			if not var_10.getShipById(var_1_10023, iter_1_3) then
				pg = var_21
				var_1_10023 = var_21.TipsMgr.GetInstance()

				local var_1_19 = var_21.ShowTips

				i18n = var_24

				var_1_19(var_1_10023, var_24("ship_remould_material_ship_on_exist"))

				return
			end
		end
	end

	ipairs = var_1_18

	for iter_1_4, iter_1_5 in var_1_18(var_1_5.ship_id) do
		if iter_1_5[1] == var_11.configId then
			getProxy = var_21
			EquipmentProxy = var_1_10023
			var_1_10023 = var_21(var_1_10023)

			local var_1_20 = var_21.getCapacity(var_1_10023)

			if var_1_4:getMaxEquipmentBag() <= var_1_20 then
				Clone = var_22

				local var_1_21 = var_22(var_11)

				var_1_21.configId = iter_1_5[2]
				ipairs = var_1_10023

				for iter_1_6, iter_1_7 in var_1_10023(var_1_21.equipments) do
					if iter_1_7 and var_1_21:isForbiddenAtPos(iter_1_7, iter_1_6) then
						pg = var_28

						local var_1_22 = var_28.TipsMgr.GetInstance()
						local var_1_23 = var_28.ShowTips

						i18n = var_31

						var_1_23(var_1_22, var_31("equipment_cant_unload"))

						return
					end
				end
			end
		end
	end

	local var_1_24
	local var_1_25
	local var_1_26

	ipairs = iter_1_4

	for iter_1_8, iter_1_9 in iter_1_4(var_1_5.ship_id) do
		if var_11.configId == iter_1_9[1] then
			unpack = var_24

			local var_1_27

			var_1_27, var_1_10025 = var_24(iter_1_9)
			var_1_25 = var_1_10025
			var_1_24 = var_1_27

			break
		end
	end

	local var_1_30

	if var_1_24 and var_1_25 then
		ShipType = var_19

		local var_1_28 = var_19.GetTeamFromShipType

		pg = var_21

		local var_1_29 = var_1_28(var_21.ship_data_statistics[var_1_24].type)

		ShipType = var_1_30
		var_1_30 = var_1_30.GetTeamFromShipType
		pg = iter_1_8
		var_1_26 = var_1_29 ~= var_1_30(iter_1_8.ship_data_statistics[var_1_25].type)
	end

	local var_1_31 = {}

	if var_1_26 then
		local var_1_32 = var_11

		if var_11.getFlag(var_1_32, "inFleet") then
			getProxy = var_1_30
			FleetProxy = var_1_32

			local var_1_33 = var_1_30(var_1_32)
			local var_1_34 = var_1_30.GetRegularFleetByShip(var_1_33, var_11)

			if not var_1_30.canRemove(var_1_34, var_11) then
				pg = var_21

				local var_1_35 = var_21.MsgboxMgr.GetInstance()
				local var_1_36 = var_21.ShowMsgBox
				local var_1_37 = {
					yesText = "text_forward"
				}

				i18n = var_1_10025
				var_1_37.content = var_1_10025("shipmodechange_reject_1stfleet_only")

				function var_1_37.onYes()
					local var_2_0 = arg_1_0
					local var_2_1 = var_0.sendNotification

					GAME = var_2_10003

					local var_2_2 = var_2_10003.GO_SCENE

					SCENE = var_2_10004

					var_2_1(var_2_0, var_2_2, var_2_10004.BIANDUI)

					return
				end

				var_1_36(var_1_35, var_1_37)

				return
			end
		end

		table = var_1_30

		var_1_30.insert(var_1_31, function(arg_3_0)
			local var_3_0

			;(function()
				ShipStatus = var_3_10000

				local var_4_0, var_4_1 = var_3_10000.ShipStatusCheck("onTeamChange", var_0, var_0)

				if var_4_0 then
					arg_3_0()
				elseif var_4_1 then
					pg = var_2

					local var_4_2 = var_2.TipsMgr.GetInstance()

					var_2.ShowTips(var_4_2, var_4_1)
				end

				return
			end)()

			return
		end)

		if var_11:getFlag("inWorld") then
			table = var_1_30

			var_1_30.insert(var_1_31, function(arg_5_0)
				pg = var_2_10001

				local var_5_0 = var_2_10001.MsgboxMgr.GetInstance()
				local var_5_1 = var_1.ShowMsgBox
				local var_5_2 = {}

				i18n = var_2_10005
				var_5_2.content = var_2_10005("shipchange_alert_inworld")
				var_5_2.onYes = arg_5_0

				var_5_1(var_5_0, var_5_2)

				return
			end)
		end

		if var_11:getFlag("inElite") then
			table = var_1_30

			var_1_30.insert(var_1_31, function(arg_6_0)
				pg = var_2_10001

				local var_6_0 = var_2_10001.MsgboxMgr.GetInstance()
				local var_6_1 = var_1.ShowMsgBox
				local var_6_2 = {}

				i18n = var_2_10005
				var_6_2.content = var_2_10005("shipchange_alert_indiff")

				function var_6_2.onYes()
					local var_7_0 = arg_1_0
					local var_7_1 = var_0.sendNotification

					GAME = var_3_10003

					var_7_1(var_7_0, var_3_10003.REMOVE_ELITE_TARGET_SHIP, {
						shipId = var_0.id,
						callback = arg_6_0
					})

					return
				end

				var_6_1(var_6_0, var_6_2)

				return
			end)
		end
	end

	table = var_1_30

	var_1_30.insert(var_1_31, function(arg_8_0)
		local var_8_0 = {}

		if var_1_5.skin_id and var_2 ~= 0 then
			PaintingGroupConst = var_2_10003

			var_2_10003.AddPaintingNameBySkinID(var_8_0, var_2)
		end

		local var_8_1 = {
			isShowBox = true,
			paintingNameList = var_8_0,
			finishFunc = arg_8_0
		}

		PaintingGroupConst = var_2_10004

		var_2_10004.PaintingDownload(var_8_1)

		return
	end)

	seriesAsync = var_20

	var_20(var_1_31, function()
		pg = var_2_10000

		local var_9_0 = var_2_10000.ConnectionMgr.GetInstance()

		var_0.Send(var_9_0, 12011, {
			ship_id = var_1_0,
			remould_id = var_1_1,
			material_id = var_1_2
		}, 12012, function(arg_10_0)
			local var_10_1

			if arg_10_0.result == 0 then
				pg = var_10_1

				local var_10_0 = var_10_1.TrackerMgr.GetInstance()

				var_10_1 = var_10_1.Tracking
				TRACKING_REMOULD_SHIP = iter_10_0

				var_10_1(var_10_0, iter_10_0, var_0.groupId)

				if var_1_26 then
					local var_10_2 = var_0

					if var_10_1.getFlag(var_10_2, "inWorld") then
						nowWorld = var_10_1
						iter_10_0 = var_10_1()

						local var_10_3 = var_10_1.GetFleet

						var_3_10007 = var_10_1

						local var_10_4 = var_10_3(iter_10_0, var_10_1.GetShip(var_3_10007, var_0.id).fleetId)

						underscore = var_10_2

						local var_10_5 = var_10_2.filter

						var_3_10007 = var_10_4

						local var_10_6 = var_10_5(var_10_4.GetShips(var_3_10007, true), function(arg_11_0)
							return arg_11_0.id ~= var_0.id
						end)

						var_10_4:UpdateShips(var_10_6)

						pg = iter_10_0

						local var_10_7 = iter_10_0.ShipFlagMgr.GetInstance()

						iter_10_0.UpdateFlagShips(var_10_7, "inWorld")
					end
				end

				if var_1_10 then
					var_10_1 = var_0.transforms[var_1_1].level
					var_0.transforms[var_1_1].level = var_10_1 + 1
				else
					var_10_1 = var_0.transforms
					var_10_1[var_1_1] = {
						level = 1,
						id = var_1_1
					}
				end

				ipairs = var_10_1

				for iter_10_0, iter_10_1 in var_10_1(var_1_5.edit_trans) do
					if var_0.transforms[iter_10_1] then
						var_0.transforms[iter_10_1] = nil
					end
				end

				getProxy = var_10_1
				NavalAcademyProxy = var_3
				iter_10_0 = var_10_1(var_3)

				local var_10_8 = var_10_1.getStudentByShipId(iter_10_0, var_1_0) and var_2:getSkillId(var_0)

				if var_1_24 and var_1_25 then
					iter_10_0 = var_0
					iter_10_0.configId = var_1_25
					pg = iter_10_0
					iter_10_0 = iter_10_0.ship_data_template[var_1_24].buff_list
					pg = var_5

					local var_10_9 = var_5.ship_data_template[var_1_25].buff_list
					local var_10_10 = 1

					math = var_3_10007

					for iter_10_2 = var_10_10, var_3_10007.max(#iter_10_0, #var_10_9) do
						if iter_10_0[iter_10_2] == var_10_9[iter_10_2] then
							-- block empty
						else
							local var_10_11

							if var_10 then
								var_10_11 = var_0.skills[var_10]
								var_10_11.id = var_3_10011
								var_0.skills[var_10] = nil
							else
								var_10_11 = {
									exp = 0,
									level = 1,
									id = var_3_10011
								}
							end

							local var_10_12 = var_0.skills

							var_10_12[var_3_10011] = var_10_11
							pg = var_10_12
							var_3_10015 = var_10_12.TipsMgr.GetInstance()

							local var_10_13 = var_13.ShowTips

							i18n = var_3_10016

							local var_10_14 = "ship_remould_material_unlock_skill"

							pg = var_3_10019

							var_10_13(var_3_10015, var_3_10016(var_10_14, var_3_10019.skill_data_template[var_3_10011].name))

							if var_2 and var_10_8 == var_10 then
								var_3_10015 = var_2

								var_2.updateSkillId(var_3_10015, var_3_10011)

								var_3_10015 = var_10_1

								var_10_1.updateStudent(var_3_10015, var_2)
							end
						end
					end
				end

				_ = iter_10_0

				iter_10_0.each(var_1_5.ship_id, function(arg_12_0)
					if arg_12_0[1] == var_0.configId then
						-- block empty
					end

					return
				end)

				pairs = iter_10_0

				local var_10_15

				if not var_1_5.use_item[var_1_13] then
					var_10_15 = {}
				end

				for iter_10_3, iter_10_4 in iter_10_0(var_10_15) do
					var_3_10011 = var_1_15

					var_9.removeItemById(var_3_10011, iter_10_4[1], iter_10_4[2])
				end

				getProxy = iter_10_0
				PlayerProxy = var_6

				local var_10_16 = iter_10_0(var_6)
				local var_10_17 = iter_10_0.getData(var_10_16)

				var_5.consume(var_10_17, {
					gold = var_1_5.use_gold
				})
				iter_10_0:updatePlayer(var_5)

				local var_10_18 = {}

				if var_1_5.skin_id ~= 0 then
					local var_10_19 = var_0

					var_7.updateSkinId(var_10_19, var_1_5.skin_id, 0)

					table = var_7

					local var_10_20 = var_7.insert
					local var_10_21 = var_10_18
					local var_10_22 = {
						count = 1
					}

					DROP_TYPE_SKIN = var_3_10011
					var_10_22.type = var_3_10011
					var_10_22.id = var_1_5.skin_id

					var_10_20(var_10_21, var_10_22)

					getProxy = var_10_20
					CollectionProxy = var_10_21

					local var_10_23 = var_10_20(var_10_21)

					if var_7.getShipGroup(var_10_23, var_0.groupId) and not var_8.trans then
						var_8.trans = true
						var_3_10011 = var_7

						var_7.updateShipGroup(var_3_10011, var_8)
					end
				end

				if var_1_5.skill_id ~= 0 and not var_0.skills[var_1_5.skill_id] then
					local var_10_24 = var_0.skills

					var_10_24[var_1_5.skill_id] = {
						exp = 0,
						level = 1,
						id = var_1_5.skill_id
					}
					pg = var_10_24

					local var_10_25 = var_10_24.skill_data_template[var_1_5.skill_id].name

					pg = var_8

					local var_10_26 = var_8.TipsMgr.GetInstance()
					local var_10_27 = var_8.ShowTips

					i18n = var_3_10011

					var_10_27(var_10_26, var_3_10011("ship_remould_material_unlock_skill", var_10_25))
				end

				local var_10_28 = var_0

				var_7.updateName(var_10_28)

				local var_10_29 = var_0

				if var_7.GetSpWeapon(var_10_29) then
					local var_10_30 = var_0

					if not var_8.CanEquipSpWeapon(var_10_30, var_7) then
						local var_10_31 = var_0

						var_8.UpdateSpWeapon(var_10_31, nil)

						getProxy = var_8
						EquipmentProxy = var_10_31

						local var_10_32 = var_8(var_10_31)

						var_8.AddSpWeapon(var_10_32, var_7)

						pg = var_8

						local var_10_33 = var_8.TipsMgr.GetInstance()
						local var_10_34 = var_8.ShowTips

						i18n = var_11

						var_10_34(var_10_33, var_11("ship_unequipFromShip_ok", var_7:GetName()), "red")
					end
				end

				local var_10_35 = var_0

				var_8.updateShip(var_10_35, var_0)

				getProxy = var_8
				EquipmentProxy = var_10_35

				local var_10_36 = var_8(var_10_35)

				ipairs = var_10_29

				local var_10_37

				if not var_1_2 then
					var_10_37 = {}
				end

				for iter_10_5, iter_10_6 in var_10_29(var_10_37) do
					local var_10_38 = var_0
					local var_10_39 = var_14.getShipById(var_10_38, iter_10_6)

					ipairs = var_3_10015

					for iter_10_7, iter_10_8 in var_3_10015(var_10_39.equipments) do
						if iter_10_8 then
							var_10_36:addEquipment(iter_10_8)
						end

						if var_10_39:getEquipSkin(iter_10_7) ~= 0 then
							var_10_36:addEquipmentSkin(var_10_39:getEquipSkin(iter_10_7), 1)

							pg = var_20

							local var_10_40 = var_20.TipsMgr.GetInstance()
							local var_10_41 = var_20.ShowTips

							i18n = var_23

							var_10_41(var_10_40, var_23("equipment_skin_unload"))
						end
					end

					if var_10_39:GetSpWeapon() then
						var_10_39:UpdateSpWeapon(nil)
						var_10_36:AddSpWeapon(var_3_10015)
					end

					local var_10_42 = var_0

					var_16.removeShipById(var_10_42, iter_10_6)
				end

				local var_10_43 = {}

				ipairs = var_10

				for iter_10_9, iter_10_10 in var_10(var_0.equipments) do
					if iter_10_10 then
						local var_10_44 = var_0

						if not var_15.canEquipAtPos(var_10_44, iter_10_10, iter_10_9) then
							table = var_15

							var_15.insert(var_10_43, function(arg_13_0)
								local var_13_0 = arg_1_0
								local var_13_1 = var_1.sendNotification

								GAME = var_4_10004

								var_13_1(var_13_0, var_4_10004.UNEQUIP_FROM_SHIP, {
									shipId = var_0.id,
									pos = iter_10_9,
									callback = arg_13_0
								})

								return
							end)
						end
					end
				end

				seriesAsync = var_10

				var_10(var_10_43, function()
					local var_14_0 = arg_1_0
					local var_14_1 = var_0.sendNotification

					GAME = var_4_10003

					local var_14_2 = var_4_10003.REMOULD_SHIP_DONE
					local var_14_3 = {}
					local var_14_4 = var_0

					var_14_3.ship = var_5.getShipById(var_14_4, var_1_0)
					var_14_3.awards = var_10_18

					var_14_1(var_14_0, var_14_2, var_14_3)

					nowWorld = var_14_1

					if var_14_1() and var_0:GetBossProxy() and var_1.isSetup then
						var_1:CheckRemouldShip()
					end

					return
				end)
			else
				pg = var_10_1

				local var_10_45 = var_10_1.TipsMgr.GetInstance()
				local var_10_46 = var_1.ShowTips

				errorTip = iter_10_0

				var_10_46(var_10_45, iter_10_0("ship_remouldShip", arg_10_0.result))
			end

			return
		end)

		return
	end)

	return
end

return var_0_1
