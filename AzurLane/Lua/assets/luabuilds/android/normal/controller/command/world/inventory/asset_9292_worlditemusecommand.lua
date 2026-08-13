class = var_0_10000

local var_0_0 = "WorldItemUseCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().itemID
	local var_1_1 = var_2.count
	local var_1_2 = var_2.args

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 21, {
		id = var_1_0,
		count = var_1_1,
		arg = var_1_2
	}, 22, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = {}
			nowWorld = var_2_10002

			local var_2_1 = var_2_10002()
			local var_2_2 = var_2_10002.GetInventoryProxy(var_2_1)

			var_2_10003.RemoveItem(var_2_2, var_1_0, var_1_1)

			WorldItem = var_4

			local var_2_3 = var_4.New({
				id = var_1_0,
				count = var_1_1
			})

			switch = var_5

			local var_2_4 = var_2_3:getWorldItemType()
			local var_2_5 = {}

			WorldItem = var_2_10008
			var_2_5[var_2_10008.UsageBuff] = function()
				local var_3_0 = var_2_3
				local var_3_1 = var_0.getItemBuffID(var_3_0)

				ipairs = var_3_0

				for iter_3_0, iter_3_1 in var_3_0(var_1_2) do
					local var_3_2 = var_2_10002
					local var_3_3 = var_6.GetShip(var_3_2, iter_3_1)

					var_6.AddBuff(var_3_3, var_3_1, var_2_3.count)
				end

				return
			end
			WorldItem = var_8
			var_2_5[var_8.UsageHPRegenerate] = function()
				local var_4_0 = var_2_3
				local var_4_1 = var_0.getItemRegenerate(var_4_0) * var_2_3.count

				ipairs = var_1

				for iter_4_0, iter_4_1 in var_1(var_1_2) do
					local var_4_2 = var_2_10002
					local var_4_3 = var_6.GetShip(var_4_2, iter_4_1)

					var_6.Regenerate(var_4_3, var_4_1)
				end

				return
			end
			WorldItem = var_8
			var_2_5[var_8.UsageHPRegenerateValue] = function()
				local var_5_0 = var_2_3
				local var_5_1 = var_0.getItemRegenerate(var_5_0) * var_2_3.count

				ipairs = var_1

				for iter_5_0, iter_5_1 in var_1(var_1_2) do
					local var_5_2 = var_2_10002
					local var_5_3 = var_6.GetShip(var_5_2, iter_5_1)

					var_6.RegenerateValue(var_5_3, var_5_1)
				end

				return
			end
			WorldItem = var_8
			var_2_5[var_8.UsageRecoverAp] = function()
				local var_6_0 = var_2_3
				local var_6_1 = var_0.getItemStaminaRecover(var_6_0) * var_2_3.count
				local var_6_2 = var_2_10002.staminaMgr

				var_1.ExchangeStamina(var_6_2, var_6_1)

				local var_6_3 = arg_1_0
				local var_6_4 = var_1.sendNotification

				GAME = var_3

				var_6_4(var_6_3, var_3.WORLD_STAMINA_EXCHANGE_DONE)

				return
			end
			WorldItem = var_8
			var_2_5[var_8.UsageWorldFlag] = function()
				switch = var_3_10000

				local var_7_0 = var_2_3

				var_3_10000(var_1.getItemFlagKey(var_7_0), {
					function()
						local var_8_0 = var_2_10002

						var_0.SetGlobalFlag(var_8_0, "treasure_flag", true)

						PlayerConst = var_0
						var_2_0 = var_0.addTranDrop(arg_2_0.drop_list)

						return
					end
				})

				return
			end

			var_5(var_2_4, var_2_5, function()
				PlayerConst = var_3_10000
				var_2_0 = var_3_10000.addTranDrop(arg_2_0.drop_list)

				return
			end)

			local var_2_6 = arg_1_0
			local var_2_7 = var_5.sendNotification

			GAME = var_2_5

			var_2_7(var_2_6, var_2_5.WORLD_ITEM_USE_DONE, {
				drops = var_2_0,
				item = var_2_3
			})
		else
			PLATFORM_CODE = var_2_0
			PLATFORM_CHT = var_2_10002

			if var_2_0 == var_2_10002 then
				pg = var_2_0

				local var_2_8 = var_2_0.TipsMgr.GetInstance()

				var_2_0 = var_2_0.ShowTips
				i18n1 = var_2_10003

				var_2_0(var_2_8, var_2_10003("大世界物品使用失敗：" .. arg_2_0.result))
			else
				pg = var_2_0

				local var_2_9 = var_2_0.TipsMgr.GetInstance()
				local var_2_10 = var_1.ShowTips

				i18n1 = var_2_10003

				var_2_10(var_2_9, var_2_10003("大世界物品使用失败：" .. arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_1
