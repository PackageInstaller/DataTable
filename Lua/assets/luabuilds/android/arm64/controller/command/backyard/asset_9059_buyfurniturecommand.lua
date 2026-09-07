local BuyFurnitureCommand = class("BuyFurnitureCommand", pm.SimpleCommand)

function BuyFurnitureCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.furnitureIds
	local var_1_2 = var_1_0.type
	local var_1_3 = getProxy(DormProxy)
	local var_1_4 = getProxy(PlayerProxy)
	local var_1_5 = var_1_4:getData()

	if #var_1_0.furnitureIds == 0 or not var_1_0.type then
		return
	end

	local var_1_6 = 0

	for iter_1_0, iter_1_1 in ipairs(var_1_0.furnitureIds) do
		local var_1_7 = Furniture.New({
			id = iter_1_1
		})

		if not var_1_7:inTime() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("buy_furniture_overtime"))

			return
		elseif var_1_0.type == 4 then
			local var_1_8 = var_1_7:getPrice(4)

			assert(var_1_8 > 0, "furniture price should more than zero>>" .. var_1_7.id)

			var_1_6 = var_1_6 + var_1_8
		elseif var_1_0.type == 6 then
			local var_1_9 = var_1_7:getPrice(6)

			assert(var_1_9 > 0, "furniture price should more than zero>>" .. var_1_7.id)

			var_1_6 = var_1_6 + var_1_9
		end
	end

	if var_1_6 > var_1_5:getResById(var_1_0.type) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	local function var_1_10()
		pg.ConnectionMgr.GetInstance():Send(19006, {
			furniture_id = var_1_1,
			currency = var_1_2
		}, 19007, function(arg_3_0)
			if arg_3_0.result == 0 then
				var_1_5:consume({
					[id2res(var_1_2)] = var_1_6
				})
				var_1_4:updatePlayer(var_1_5)

				if pg.furniture_data_template[var_1_1[1]] and pg.furniture_data_template[var_1_1[1]].themeId > 0 then
					var_1_3:ResetSystemTheme(pg.furniture_data_template[var_1_1[1]].themeId)
				end

				local var_3_0 = var_1_3:getRawData()

				var_3_0:AddFurnitrues(var_1_1)
				var_1_3:updateDrom(var_3_0, BackYardConst.DORM_UPDATE_TYPE_FURNITURE)

				for iter_3_0, iter_3_1 in ipairs(var_1_1) do
					-- block empty
				end

				PlayerConst.UpdateLinkActivity(underscore.map(var_1_1, function(arg_4_0)
					return Drop.New({
						count = 1,
						type = DROP_TYPE_FURNITURE,
						id = arg_4_0
					})
				end))
				self:sendNotification(GAME.BUY_FURNITURE_DONE, var_1_3:getData(), var_1_1)
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_buy_success"))
			else
				pg.TipsMgr.GetInstance():ShowTips(errorTip("backyard_buyFurniture_error", arg_3_0.result))
			end

			return
		end)

		return
	end

	if var_1_0.type == 4 then
		local var_1_11 = i18n("word_furniture")

		if #var_1_0.furnitureIds == 1 then
			var_1_11 = Furniture.New({
				id = var_1_0.furnitureIds[1]
			}):getConfig("name")
		end

		if _BackyardMsgBoxMgr then
			_BackyardMsgBoxMgr:Show({
				content = i18n("charge_scene_buy_confirm_backyard", var_1_6, var_1_11),
				onYes = function()
					var_1_10()

					return
				end
			})
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("charge_scene_buy_confirm", var_1_6, var_1_11),
				onYes = function()
					var_1_10()

					return
				end
			})
		end
	else
		var_1_10()
	end

	return
end

return BuyFurnitureCommand
