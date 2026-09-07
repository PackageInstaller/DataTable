local RecordShipEquipmentCommand = class("RecordShipEquipmentCommand", pm.SimpleCommand)
local var_0_1 = {
	"#FFFFFF",
	"#60a9ff",
	"#966af6",
	"#fff157",
	"#EE799F"
}

function RecordShipEquipmentCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.shipId
	local var_1_2 = var_1_0.index
	local var_1_3 = var_1_0.type

	if not var_1_0.type then
		return
	end

	if not var_1_1 then
		return
	end

	if not var_1_2 then
		return
	end

	local var_1_4 = getProxy(PlayerProxy)
	local var_1_5 = var_1_4:getData()
	local var_1_6 = getProxy(BayProxy)
	local var_1_7 = var_1_6:getShipById(var_1_1)

	var_1_7.getEquipmentRecord(var_1_4, var_1_5.id)

	local var_1_8 = Clone(var_1_7.equipments)
	local var_1_9 = var_1_7:GetSpWeaponRecord(var_1_5.id)

	if var_1_3 == 1 then
		for iter_1_0, iter_1_1 in ipairs(var_1_8) do
			if iter_1_1 then
				var_1_7.equipmentRecords[var_1_2][iter_1_0] = iter_1_1.id or -1
			end
		end

		var_1_7:setEquipmentRecord(var_1_5.id, var_1_7.equipmentRecords)

		if not LOCK_SP_WEAPON then
			var_1_9[var_1_2] = var_1_7:GetSpWeapon()

			var_1_7:SetSpWeaponRecord(var_1_5.id, var_1_9)
		end

		var_1_6:updateShip(var_1_7)
	elseif var_1_3 == 2 then
		local var_1_11 = getProxy(EquipmentProxy)
		local var_1_12 = Clone(var_1_7.equipmentRecords[var_1_2])
		local var_1_13 = var_1_9[var_1_2]

		if #var_1_12 == 0 or _.all(var_1_12, function(arg_2_0)
			return arg_2_0 == -1
		end) and var_1_13 == nil then
			return
		end

		local function var_1_14(arg_3_0, arg_3_1)
			if var_1_8[arg_3_0] and var_1_8[arg_3_0].id == arg_3_1 then
				return true
			end

			return false
		end

		local var_1_15 = {}

		for iter_1_2, iter_1_3 in ipairs(var_1_12) do
			if iter_1_3 ~= -1 then
				local var_1_16 = var_1_11:getEquipmentById(iter_1_3)

				if (not var_1_16 or var_1_16.count <= 0) and not var_1_14(iter_1_2, iter_1_3) then
					local var_1_17 = Equipment.New({
						id = iter_1_3
					})

					var_1_12[iter_1_2] = var_1_11:getSameTypeEquipmentId(var_1_17) or 0

					table.insert(var_1_15, (string.format("<color=%s>%s+%s</color>", var_0_1[var_1_17.config.rarity - 1], var_1_17.config.name, var_1_17.config.level - 1)))
				end
			end
		end

		local var_1_18 = var_1_7:GetSpWeapon()
		local var_1_19 = var_1_13 and var_1_13:GetConfigID() or 0
		local var_1_20 = var_1_18 and var_1_18:GetConfigID() or 0
		local var_1_21

		if var_1_13 and var_1_19 ~= var_1_20 then
			var_1_21 = var_1_11:GetSameTypeSpWeapon(var_1_13)

			if var_1_21 then
				if var_1_21:GetConfigID() ~= var_1_19 then
					table.insert(var_1_15, (string.format("<color=%s>%s+%s</color>", var_0_1[var_1_13:GetRarity()], var_1_13:GetName(), var_1_13:GetLevel() - 1)))
				end
			end
		end

		local function var_1_22(arg_4_0)
			local var_4_0 = {}

			for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
				if not var_1_8[iter_4_0] or var_1_8[iter_4_0].id ~= iter_4_1 then
					if iter_4_1 == 0 then
						pg.TipsMgr.GetInstance():ShowTips(i18n("ship_quick_change_noequip"))
					elseif iter_4_1 == -1 and var_1_8[iter_4_0] then
						table.insert(var_4_0, function(arg_5_0)
							self:sendNotification(GAME.UNEQUIP_FROM_SHIP, {
								shipId = var_1_1,
								pos = iter_4_0,
								callback = arg_5_0
							})

							return
						end)
					elseif iter_4_1 ~= -1 then
						table.insert(var_4_0, function(arg_6_0)
							self:sendNotification(GAME.EQUIP_TO_SHIP, {
								equipmentId = iter_4_1,
								shipId = var_1_1,
								pos = iter_4_0,
								callback = arg_6_0
							})

							return
						end)
					end
				end
			end

			if not LOCK_SP_WEAPON then
				table.insert(var_4_0, function(arg_7_0)
					if var_1_13 then
						if var_1_19 ~= var_1_20 then
							if not var_1_21 then
								pg.TipsMgr.GetInstance():ShowTips(i18n("ship_quick_change_noequip"))

								return
							else
								self:sendNotification(GAME.EQUIP_SPWEAPON_TO_SHIP, {
									spWeaponUid = var_1_21:GetUID(),
									shipId = var_1_1,
									callback = arg_7_0
								})

								return
							end
						end
					elseif var_1_18 then
						self:sendNotification(GAME.EQUIP_SPWEAPON_TO_SHIP, {
							shipId = var_1_1,
							callback = arg_7_0
						})

						return
					end

					arg_7_0()

					return
				end)
			end

			seriesAsync(var_4_0)

			return
		end

		if #var_1_15 > 0 then
			local var_1_23 = ""

			var_1_23 = #var_1_15 > 2 and table.concat(_.slice(var_1_15, 1, 2), "、") .. i18n("word_wait") or table.concat(var_1_15, "、")

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("no_found_record_equipment", var_1_23),
				onYes = function()
					var_1_22(var_1_12)

					return
				end
			})
		else
			var_1_22(var_1_12)
		end
	end

	self:sendNotification(GAME.RECORD_SHIP_EQUIPMENT_DONE, {
		shipId = var_1_1,
		index = var_1_2,
		type = var_1_3
	})

	return
end

return RecordShipEquipmentCommand
