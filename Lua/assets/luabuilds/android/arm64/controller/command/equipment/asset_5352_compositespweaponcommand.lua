local CompositeSpWeaponCommand = class("CompositeSpWeaponCommand", pm.SimpleCommand)

function CompositeSpWeaponCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.consumeItems
	local var_1_3 = var_1_0.consumeSpweapons
	local var_1_4 = getProxy(BagProxy)
	local var_1_5 = getProxy(PlayerProxy)
	local var_1_6 = getProxy(EquipmentProxy)
	local var_1_7 = getProxy(BayProxy)
	local var_1_8 = var_1_0.id
	local var_1_9 = 0
	local var_1_10 = 0
	local var_1_11 = 0
	local var_1_12 = 0
	local var_1_13 = {}

	seriesAsync({
		function(arg_2_0)
			local var_2_0 = var_1_4:getRawData()
			local var_2_1 = var_1_5:getData()

			var_1_9 = SpWeapon.CalculateHistoryPt(var_1_2, var_1_3)

			local function var_2_2(arg_3_0)
				for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
					local var_3_0 = iter_3_1[1]
					local var_3_1 = underscore.detect(var_1_13, function(arg_4_0)
						return arg_4_0.id == var_3_0
					end)

					if not var_3_1 then
						var_3_1 = Item.New({
							id = iter_3_1[1]
						})
						var_3_1.count = 0

						table.insert(var_1_13, var_3_1)
					end

					var_3_1.count = var_3_1.count + iter_3_1[2]
				end

				return
			end

			local var_2_3 = SpWeapon.New({
				id = var_1_8
			}):GetUpgradeConfig()

			var_1_11 = var_1_11 + var_2_3.create_use_pt

			var_2_2(var_2_3.create_use_item)

			var_1_12 = var_1_12 + var_2_3.create_use_gold

			if var_1_9 >= var_1_11 then
				while true do
					local var_2_4 = SpWeapon.New({
						id = var_1_8
					})
					local var_2_5 = var_2_4:GetNextUpgradeID()

					if var_2_5 == 0 then
						break
					end

					local var_2_6 = var_2_4:GetUpgradeConfig()

					var_1_10 = var_1_11
					var_1_11 = var_1_11 + var_2_6.upgrade_use_pt

					local var_2_7 = SpWeapon.New({
						id = var_2_5
					})

					if 0 > 0 and var_2_7:GetRarity() > var_2_4:GetRarity() then
						break
					end

					if var_1_9 < var_1_11 then
						break
					end

					var_2_2(var_2_6.upgrade_use_item)

					var_1_12 = var_1_12 + var_2_6.upgrade_use_gold
					var_1_8 = var_2_5

					if var_2_7:GetRarity() > var_2_4:GetRarity() then
						var_1_10 = var_1_11

						break
					end
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_creatept_no_enough"))

				return
			end

			local var_2_9 = var_1_9 - var_1_11

			var_1_9 = math.min(var_1_9, var_1_11)

			if getProxy(EquipmentProxy):GetSpWeaponCapacity() <= getProxy(EquipmentProxy):GetSpWeaponCount() then
				NoPosMsgBox(i18n("switch_to_shop_tip_noPos"), OpenSpWeaponPage, gotoChargeScene)

				return
			end

			if var_2_1.gold < var_1_12 then
				GoShoppingMsgBox(i18n("switch_to_shop_tip_2", i18n("word_gold")), ChargeScene.TYPE_ITEM, {
					{
						59001,
						var_1_12 - var_2_1.gold,
						var_1_12
					}
				})

				return
			end

			if not _.all(var_1_13, function(arg_5_0)
				return arg_5_0.count <= ((var_2_0[arg_5_0.id] or nil) and (var_2_0[arg_5_0.id].count or 0))
			end) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_materal_no_enough"))

				return
			end

			if not _.all(var_1_2, function(arg_6_0)
				return arg_6_0.count <= ((var_2_0[arg_6_0.id] or nil) and (var_2_0[arg_6_0.id].count or 0))
			end) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_materal_no_enough"))

				return
			end

			if not _.all(var_1_3, function(arg_7_0)
				local var_7_0 = arg_7_0:GetShipId()

				if var_7_0 then
					local var_7_1 = var_1_7:getShipById(var_7_0):GetSpWeapon()

					return var_7_1 and var_7_1:GetUID() == arg_7_0:GetUID()
				else
					return var_1_6:GetSpWeaponByUid(arg_7_0:GetUID())
				end

				return
			end) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_materal_no_enough"))

				return
			end

			if var_2_9 > 0 then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("spweapon_tip_breakout_overflow", var_2_9),
					onYes = arg_2_0
				})
			else
				arg_2_0()
			end

			return
		end,
		function(arg_8_0)
			pg.ConnectionMgr.GetInstance():Send(14209, {
				template_id = var_1_1,
				item_id_list = _.reduce(var_1_2, {}, function(arg_9_0, arg_9_1)
					for iter_9_0 = 1, arg_9_1.count do
						table.insert(arg_9_0, arg_9_1.id)
					end

					return arg_9_0
				end),
				spweapon_id_list = _.map(var_1_3, function(arg_10_0)
					return arg_10_0:GetUID()
				end)
			}, 14210, function(arg_11_0)
				if arg_11_0.result == 0 then
					local var_11_0 = SpWeapon.CreateByNet(arg_11_0.spweapon)
					local var_11_1 = var_1_5:getData()

					var_11_1:consume({
						gold = var_1_12
					})
					var_1_5:updatePlayer(var_11_1)
					_.each(var_1_13, function(arg_12_0)
						var_1_4:removeItemById(arg_12_0.id, arg_12_0.count)

						return
					end)
					_.each(var_1_2, function(arg_13_0)
						var_1_4:removeItemById(arg_13_0.id, arg_13_0.count)

						return
					end)
					_.each(var_1_3, function(arg_14_0)
						local var_14_0 = arg_14_0:GetShipId()

						if var_14_0 then
							local var_14_1 = var_1_7:getShipById(var_14_0)

							var_14_1:UpdateSpWeapon(nil)
							var_1_7:updateShip(var_14_1)
						else
							var_1_6:RemoveSpWeapon(arg_14_0)
						end

						return
					end)
					var_1_6:AddSpWeapon(var_11_0)
					self:sendNotification(GAME.COMPOSITE_SPWEAPON_DONE, var_11_0)
					pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_create_sussess", var_11_0:GetName()))
				else
					pg.TipsMgr.GetInstance():ShowTips(errorTip("equipment_compositeEquipment", arg_11_0.result))
				end

				return
			end)

			return
		end
	})

	return
end

return CompositeSpWeaponCommand
