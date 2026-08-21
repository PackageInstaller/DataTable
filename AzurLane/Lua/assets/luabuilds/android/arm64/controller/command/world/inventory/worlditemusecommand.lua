local var_0_0 = class("WorldItemUseCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(21, {
		id = var_1_0.itemID,
		count = var_1_0.count,
		arg = var_1_0.args
	}, 22, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = {}
			local var_2_1 = nowWorld()

			nowWorld():GetInventoryProxy():RemoveItem(var_0, var_0)

			local var_2_2 = WorldItem.New({
				id = var_0,
				count = var_0
			})

			switch(var_2_2:getWorldItemType(), {
				[WorldItem.UsageBuff] = function()
					local var_3_0 = var_2_2:getItemBuffID()

					for iter_3_0, iter_3_1 in ipairs(var_0) do
						var_2_1:GetShip(iter_3_1):AddBuff(var_3_0, var_2_2.count)
					end

					return
				end,
				[WorldItem.UsageHPRegenerate] = function()
					local var_4_0 = var_2_2:getItemRegenerate() * var_2_2.count

					for iter_4_0, iter_4_1 in ipairs(var_0) do
						var_2_1:GetShip(iter_4_1):Regenerate(var_4_0)
					end

					return
				end,
				[WorldItem.UsageHPRegenerateValue] = function()
					local var_5_0 = var_2_2:getItemRegenerate() * var_2_2.count

					for iter_5_0, iter_5_1 in ipairs(var_0) do
						var_2_1:GetShip(iter_5_1):RegenerateValue(var_5_0)
					end

					return
				end,
				[WorldItem.UsageRecoverAp] = function()
					var_2_1.staminaMgr:ExchangeStamina(var_2_2:getItemStaminaRecover() * var_2_2.count)
					arg_1_0:sendNotification(GAME.WORLD_STAMINA_EXCHANGE_DONE)

					return
				end,
				[WorldItem.UsageWorldFlag] = function()
					switch(var_2_2:getItemFlagKey(), {
						function()
							var_2_1:SetGlobalFlag("treasure_flag", true)

							var_2_0 = PlayerConst.addTranDrop(arg_2_0.drop_list)

							return
						end
					})

					return
				end
			}, function()
				var_2_0 = PlayerConst.addTranDrop(arg_2_0.drop_list)

				return
			end)
			arg_1_0:sendNotification(GAME.WORLD_ITEM_USE_DONE, {
				drops = {},
				item = var_2_2
			})
		elseif PLATFORM_CODE == PLATFORM_CHT then
			pg.TipsMgr.GetInstance():ShowTips(i18n1("大世界物品使用失敗：" .. arg_2_0.result))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n1("大世界物品使用失败：" .. arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
