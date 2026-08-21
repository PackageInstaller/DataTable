local var_0_0 = class("UpgradeSpWeaponCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1

	if not var_1_0.uid then
		var_1_1 = 0
	end

	local var_1_2

	if not var_1_0.shipId then
		var_1_2 = 0
	end

	local var_1_3 = var_1_0.items
	local var_1_4 = var_1_0.consumes
	local var_1_5 = getProxy(BagProxy)
	local var_1_6 = getProxy(PlayerProxy)
	local var_1_7 = getProxy(BayProxy)
	local var_1_8 = getProxy(EquipmentProxy)
	local var_1_9
	local var_1_10 = 0
	local var_1_11 = 0
	local var_1_12 = 0
	local var_1_13 = 0
	local var_1_14 = {}

	seriesAsync({
		function(arg_2_0)
			local var_2_0, var_2_1 = EquipmentProxy.StaticGetSpWeapon(var_1_2, var_1_1)

			var_1_10 = var_2_0:GetPt()

			local var_2_2 = SpWeapon.CalculateHistoryPt(var_1_3, var_1_4)

			var_1_10 = var_1_10 + var_2_2

			local var_2_3 = 0

			var_1_9 = var_2_0:GetConfigID()

			while true do
				local var_2_4 = SpWeapon.New({
					id = var_1_9
				})
				local var_2_5 = var_2_4:GetNextUpgradeID()

				if var_2_5 == 0 then
					break
				end

				local var_2_6 = var_2_4:GetUpgradeConfig()

				var_1_11 = var_1_12
				var_1_12 = var_1_12 + var_2_6.upgrade_use_pt

				local var_2_7 = SpWeapon.New({
					id = var_2_5
				})

				if var_2_3 > 0 and var_2_7:GetRarity() > var_2_4:GetRarity() then
					break
				end

				if var_1_10 < var_1_12 then
					break
				end

				;(function(arg_3_0)
					for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
						local var_3_0 = iter_3_1[1]
						local var_3_1 = underscore.detect(var_1_14, function(arg_4_0)
							return arg_4_0.id == var_3_0
						end)

						if not var_3_1 then
							var_3_1 = Item.New({
								id = iter_3_1[1]
							})
							var_3_1.count = 0

							table.insert(var_1_14, var_3_1)
						end

						var_3_1.count = var_3_1.count + iter_3_1[2]
					end

					return
				end)(var_2_6.upgrade_use_item)

				var_1_13 = var_1_13 + var_2_6.upgrade_use_gold
				var_2_3 = var_2_3 + 1
				var_1_9 = var_2_5

				if var_2_7:GetRarity() > var_2_4:GetRarity() then
					var_1_11 = var_1_12

					break
				end
			end

			local var_2_8 = var_1_10 - var_1_12

			var_1_10 = math.min(var_1_10, var_1_12)

			if var_2_2 == 0 and var_2_3 == 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_pt_no_enough"))

				return
			end

			local var_2_9 = var_1_5:getRawData()
			local var_2_10 = var_1_6:getRawData()

			if var_2_10.gold < var_1_13 then
				GoShoppingMsgBox(i18n("switch_to_shop_tip_2", i18n("word_gold")), ChargeScene.TYPE_ITEM, {
					{
						59001,
						var_1_13 - var_2_10.gold,
						var_1_13
					}
				})

				return
			end

			if not _.all(var_1_14, function(arg_5_0)
				if var_2_9[arg_5_0.id] then
					local var_5_0 = var_2_9[arg_5_0.id].count or 0

					return arg_5_0.count <= var_5_0
				end
			end) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_materal_no_enough"))

				return
			end

			if not _.all(var_1_3, function(arg_6_0)
				if var_2_9[arg_6_0.id] then
					local var_6_0 = var_2_9[arg_6_0.id].count or 0

					return arg_6_0.count <= var_6_0
				end
			end) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_materal_no_enough"))

				return
			end

			if not _.all(var_1_4, function(arg_7_0)
				local var_7_0 = arg_7_0:GetShipId()

				if var_7_0 then
					local var_7_1 = var_1_7:getShipById(var_7_0):GetSpWeapon()

					return var_7_1 and var_7_1:GetUID() == arg_7_0:GetUID()
				else
					return var_1_8:GetSpWeaponByUid(arg_7_0:GetUID())
				end

				return
			end) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_materal_no_enough"))

				return
			end

			if var_2_8 > 0 and var_2_2 > 0 then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("spweapon_tip_breakout_overflow", var_2_8),
					onYes = arg_2_0
				})
			else
				arg_2_0()
			end

			return
		end,
		function(arg_8_0)
			pg.ConnectionMgr.GetInstance():Send(14203, {
				ship_id = var_1_2,
				spweapon_id = var_1_1,
				item_id_list = _.reduce(var_1_3, {}, function(arg_9_0, arg_9_1)
					for iter_9_0 = 1, arg_9_1.count do
						table.insert(arg_9_0, arg_9_1.id)
					end

					return arg_9_0
				end),
				spweapon_id_list = _.map(var_1_4, function(arg_10_0)
					return arg_10_0:GetUID()
				end)
			}, 14204, function(arg_11_0)
				if arg_11_0.result == 0 then
					local var_11_0, var_11_1 = EquipmentProxy.StaticGetSpWeapon(var_1_2, var_1_1)
					local var_11_2 = var_11_0:MigrateTo(var_1_9)

					var_11_2:SetPt(math.floor(var_1_10 - var_1_11))
					_.each(var_1_14, function(arg_12_0)
						var_1_5:removeItemById(arg_12_0.id, arg_12_0.count)

						return
					end)

					local var_11_3 = var_1_6:getData()

					var_11_3:consume({
						gold = var_1_13
					})
					var_1_6:updatePlayer(var_11_3)
					_.each(var_1_3, function(arg_13_0)
						var_1_5:removeItemById(arg_13_0.id, arg_13_0.count)

						return
					end)
					_.each(var_1_4, function(arg_14_0)
						local var_14_0 = arg_14_0:GetShipId()

						if var_14_0 then
							local var_14_1 = var_1_7:getShipById(var_14_0)

							var_14_1:UpdateSpWeapon(nil)
							var_1_7:updateShip(var_14_1)
						else
							var_1_8:RemoveSpWeapon(arg_14_0)
						end

						return
					end)

					if var_11_1 then
						var_11_1:UpdateSpWeapon(var_11_2)
						getProxy(BayProxy):updateShip(var_11_1)
					else
						getProxy(EquipmentProxy):AddSpWeapon(var_11_2)
					end

					arg_1_0:sendNotification(GAME.UPGRADE_SPWEAPON_DONE, var_11_2)
				else
					pg.TipsMgr.GetInstance():ShowTips(errorTip("equipment_upgrade_erro", arg_11_0.result))
				end

				return
			end)

			return
		end
	})

	return
end

return var_0_0
