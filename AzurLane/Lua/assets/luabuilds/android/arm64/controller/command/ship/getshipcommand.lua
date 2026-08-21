local var_0_0 = class("GetShipCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1, var_1_2

	if not var_1_0.type then
		var_1_1 = 1
		var_1_2 = getProxy(BuildShipProxy)
	end

	local var_1_3 = underscore.filter(var_1_0.pos_list, function(arg_2_0)
		return var_1_2:getBuildShip(arg_2_0).state == BuildShip.FINISH
	end)

	if #var_1_3 == 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_getShip_error_notFinish"))

		return
	end

	local var_1_4 = getProxy(BayProxy)
	local var_1_5 = getProxy(PlayerProxy):getData():getMaxShipBag() - var_1_4:getShipCount()

	if var_1_5 <= 0 then
		NoPosMsgBox(i18n("switch_to_shop_tip_noDockyard"), openDockyardClear, gotoChargeScene, openDockyardIntensify)

		return
	else
		var_1_3 = underscore.slice(var_1_3, 1, var_1_5)
	end

	local var_1_6 = {}

	table.insert({}, function(arg_3_0)
		pg.ConnectionMgr.GetInstance():Send(12043, {
			type = 0
		}, 12044, function(arg_4_0)
			local var_4_0 = {}

			for iter_4_0, iter_4_1 in ipairs(arg_4_0.infoList) do
				({})[iter_4_1.pos] = iter_4_1.tid
			end

			arg_3_0(underscore.map(var_1_3, function(arg_5_0)
				return var_4_0[arg_5_0]
			end))

			return
		end)

		return
	end)
	table.insert(var_1_6, function(arg_6_0, arg_6_1)
		for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
			PaintingGroupConst.AddPaintingNameByShipConfigID({}, iter_6_1)
		end

		PaintingGroupConst.PaintingDownload({
			isShowBox = true,
			paintingNameList = {},
			finishFunc = arg_6_0
		})

		return
	end)
	seriesAsync(var_1_6, function()
		local var_7_0 = var_1_2:getBuildShip(var_1_3[1]).type

		pg.ConnectionMgr.GetInstance():Send(12025, {
			type = var_1_1,
			pos_list = var_1_3
		}, 12026, function(arg_8_0)
			for iter_8_0, iter_8_1 in ipairs(arg_8_0.ship_list) do
				var_1_2:removeBuildShipByIndex(var_1_3[1])

				local var_8_0 = Ship.New(iter_8_1)

				table.insert({}, var_8_0)

				if var_8_0:isMetaShip() and not var_8_0.virgin and Player.isMetaShipNeedToTrans(var_8_0.configId) then
					local var_8_1 = MetaCharacterConst.addReMetaTransItem(var_8_0)

					if var_8_1 then
						var_8_0:setReMetaSpecialItemVO(var_8_1)
					end
				else
					var_1_4:addShip(var_8_0)
				end
			end

			if #{} > 0 then
				var_1_2:setBuildShipState()
				arg_1_0:sendNotification(GAME.GET_SHIP_DONE, {
					ships = {},
					type = var_7_0
				})
			end

			if arg_8_0.result == 0 then
				-- block empty
			else
				pg.TipsMgr.GetInstance():ShowTips(errorTip("ship_getShip", arg_8_0.result))
			end

			return
		end)

		return
	end)

	return
end

return var_0_0
