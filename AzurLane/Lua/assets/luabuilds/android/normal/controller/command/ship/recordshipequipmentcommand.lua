class = var_0_10000

local var_0_0 = "RecordShipEquipmentCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)
local var_0_2 = {
	"#FFFFFF",
	"#60a9ff",
	"#966af6",
	"#fff157",
	"#EE799F"
}

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId
	local var_1_1 = var_2.index

	if not var_2.type then
		return
	end

	if not var_1_0 then
		return
	end

	if not var_1_1 then
		return
	end

	getProxy = var_1_10006
	PlayerProxy = var_1_10007

	local var_1_2 = var_1_10006(var_1_10007)
	local var_1_3 = var_6.getData(var_1_2)

	getProxy = var_1_2
	BayProxy = var_1_10008

	local var_1_4 = var_1_2(var_1_10008)
	local var_1_5 = var_7.getShipById(var_1_4, var_1_0)

	var_8.getEquipmentRecord(var_1_5, var_1_3.id)

	Clone = var_9

	local var_1_6 = var_9(var_8.equipments)
	local var_1_7 = var_8
	local var_1_8 = var_8.GetSpWeaponRecord(var_1_7, var_1_3.id)
	local var_1_10

	if var_5 == 1 then
		ipairs = var_1_7

		for iter_1_0, iter_1_1 in var_1_7(var_1_6) do
			var_1_10016 = var_8.equipmentRecords[var_1_1]

			local var_1_9

			if not iter_1_1 or not iter_1_1.id then
				var_1_9 = -1
			end

			var_1_10016[iter_1_0] = var_1_9
		end

		var_1_10 = var_8

		var_8.setEquipmentRecord(var_1_10, var_1_3.id, var_8.equipmentRecords)

		LOCK_SP_WEAPON = var_1_7

		if not var_1_7 then
			var_1_10 = var_8
			var_1_8[var_1_1] = var_8.GetSpWeapon(var_1_10)
			var_1_10013 = var_8

			var_8.SetSpWeaponRecord(var_1_10013, var_1_3.id, var_1_8)
		end

		var_1_10 = var_7

		var_7.updateShip(var_1_10, var_8)

		goto label_1_0
	end

	if var_5 == 2 then
		getProxy = var_1_7
		EquipmentProxy = var_1_10

		local var_1_11 = var_1_7(var_1_10)

		Clone = var_1_10

		local var_1_12 = var_1_10(var_8.equipmentRecords[var_1_1])

		var_1_10013 = var_1_8[var_1_1]

		if #var_1_12 ~= 0 then
			_ = var_14

			if var_14.all(var_1_12, function(arg_2_0)
				return arg_2_0 == -1
			end) and var_1_10013 == nil then
				return
			end

			do
				local function var_1_13(arg_3_0, arg_3_1)
					if var_1_6[arg_3_0] and var_1_6[arg_3_0].id == arg_3_1 then
						return true
					end

					return false
				end

				local var_1_14 = {}

				ipairs = var_1_10016

				for iter_1_2, iter_1_3 in var_1_10016(var_1_12) do
					if iter_1_3 ~= -1 and (not var_1_11:getEquipmentById(iter_1_3) or var_21.count <= 0) and not var_1_13(iter_1_2, iter_1_3) then
						Equipment = var_22

						local var_1_15 = var_22.New({
							id = iter_1_3
						})
						local var_1_16

						if not var_1_11:getSameTypeEquipmentId(var_1_15) then
							var_1_16 = 0
						end

						var_1_12[iter_1_2] = var_1_16

						local var_1_17 = var_0_2[var_1_15.config.rarity - 1]

						string = var_1_10025
						var_1_10025 = var_1_10025.format("<color=%s>%s+%s</color>", var_1_17, var_1_15.config.name, var_1_15.config.level - 1)
						table = var_26

						var_26.insert(var_1_14, var_1_10025)
					end
				end

				local var_1_18 = var_8:GetSpWeapon()
				local var_1_19

				if not var_1_10013 or not var_1_10013:GetConfigID() then
					var_1_19 = 0
				end

				local var_1_20

				if not var_1_18 or not var_1_18:GetConfigID() then
					var_1_20 = 0
				end

				local var_1_21

				if var_1_10013 and var_1_19 ~= var_1_20 and (not var_1_11:GetSameTypeSpWeapon(var_1_10013) or var_1_21:GetConfigID() ~= var_1_19) then
					local var_1_22 = var_0_2[var_1_10013:GetRarity()]

					string = var_21

					local var_1_23 = var_21.format
					local var_1_24 = "<color=%s>%s+%s</color>"
					local var_1_25 = var_1_22

					var_1_10025 = var_1_10013

					local var_1_26 = var_1_23(var_1_24, var_1_25, var_1_10013.GetName(var_1_10025), var_1_10013:GetLevel() - 1)

					table = var_1_24

					var_1_24.insert(var_1_14, var_1_26)
				end

				local function var_1_27(arg_4_0)
					local var_4_0 = {}

					ipairs = var_2_10002

					for iter_4_0, iter_4_1 in var_2_10002(arg_4_0) do
						if not var_1_6[iter_4_0] or var_1_6[iter_4_0].id ~= iter_4_1 then
							local var_4_2

							if iter_4_1 == 0 then
								pg = var_4_2

								local var_4_1 = var_4_2.TipsMgr.GetInstance()

								var_4_2 = var_4_2.ShowTips
								i18n = var_2_10009

								var_4_2(var_4_1, var_2_10009("ship_quick_change_noequip"))
							elseif iter_4_1 == -1 and var_1_6[iter_4_0] then
								table = var_4_2

								var_4_2.insert(var_4_0, function(arg_5_0)
									local var_5_0 = arg_1_0
									local var_5_1 = var_1.sendNotification

									GAME = var_3_10003

									var_5_1(var_5_0, var_3_10003.UNEQUIP_FROM_SHIP, {
										shipId = var_1_0,
										pos = iter_4_0,
										callback = arg_5_0
									})

									return
								end)
							elseif iter_4_1 ~= -1 then
								table = var_4_2

								var_4_2.insert(var_4_0, function(arg_6_0)
									local var_6_0 = arg_1_0
									local var_6_1 = var_1.sendNotification

									GAME = var_3_10003

									var_6_1(var_6_0, var_3_10003.EQUIP_TO_SHIP, {
										equipmentId = iter_4_1,
										shipId = var_1_0,
										pos = iter_4_0,
										callback = arg_6_0
									})

									return
								end)
							end
						end
					end

					LOCK_SP_WEAPON = var_2

					if not var_2 then
						table = var_2

						var_2.insert(var_4_0, function(arg_7_0)
							if var_1_10013 then
								if var_1_19 ~= var_1_20 then
									if not var_1_21 then
										pg = var_1

										local var_7_0 = var_1.TipsMgr.GetInstance()
										local var_7_1 = var_1.ShowTips

										i18n = var_3_10003

										var_7_1(var_7_0, var_3_10003("ship_quick_change_noequip"))

										return
									else
										local var_7_2 = arg_1_0
										local var_7_3 = var_1.sendNotification

										GAME = var_3_10003
										var_3_10003 = var_3_10003.EQUIP_SPWEAPON_TO_SHIP

										local var_7_4 = {}
										local var_7_5 = var_1_21

										var_7_4.spWeaponUid = var_5.GetUID(var_7_5)
										var_7_4.shipId = var_1_0
										var_7_4.callback = arg_7_0

										var_7_3(var_7_2, var_3_10003, var_7_4)

										return
									end
								end
							elseif var_1_18 then
								local var_7_6 = arg_1_0
								local var_7_7 = var_1.sendNotification

								GAME = var_3_10003

								var_7_7(var_7_6, var_3_10003.EQUIP_SPWEAPON_TO_SHIP, {
									shipId = var_1_0,
									callback = arg_7_0
								})

								return
							end

							arg_7_0()

							return
						end)
					end

					seriesAsync = var_2

					var_2(var_4_0)

					return
				end

				if #var_1_14 > 0 then
					local var_1_28 = ""
					local var_1_29 = #var_1_14

					if 2 < var_1_29 then
						table = var_1_29
						var_1_29 = var_1_29.concat
						_ = var_23
						var_1_29 = var_1_29(var_23.slice(var_1_14, 1, 2), "、")
						i18n = var_23
						var_1_28 = var_1_29 .. var_23("word_wait")
					else
						table = var_1_29
						var_1_28 = var_1_29.concat(var_1_14, "、")
					end

					pg = var_1_29

					local var_1_30 = var_1_29.MsgboxMgr.GetInstance()
					local var_1_31 = var_22.ShowMsgBox
					local var_1_32 = {}

					i18n = var_1_10025
					var_1_32.content = var_1_10025("no_found_record_equipment", var_1_28)

					function var_1_32.onYes()
						var_1_27(var_1_12)

						return
					end

					var_1_31(var_1_30, var_1_32)
				else
					var_1_27(var_1_12)
				end
			end

			::label_1_0::

			local var_1_33 = arg_1_0
			local var_1_34 = arg_1_0.sendNotification

			GAME = var_1_10013

			var_1_34(var_1_33, var_1_10013.RECORD_SHIP_EQUIPMENT_DONE, {
				shipId = var_1_0,
				index = var_1_1,
				type = var_5
			})

			return
		end
	end
end

return var_0_1
