local var_0_0 = class("MonthSignPageTool")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._event = arg_1_1

	return
end

function var_0_0.onAcheve(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = coroutine.create(function()
		local var_4_9000

		if table.getCount(arg_2_1) > 0 then
			local var_4_0 = getProxy(ActivityProxy)
			local var_4_1 = var_4_0.getActivityById(var_4_9000, ActivityConst.MONTH_SIGN_ACTIVITY_ID)
			local var_4_2 = pg.activity_month_sign[var_4_1.data2].resign_count
			local var_4_3 = pg.TimeMgr.GetInstance():STimeDescS(pg.TimeMgr.GetInstance().GetServerTime(var_4_0), "*t")

			if var_4_1:getSpecialData("reMonthSignDay") ~= nil then
				local var_4_4 = arg_2_0

				if arg_2_0.reMonthSignItems then
					var_4_4.reMonthSignItems = arg_2_0.reMonthSignItems or {}

					for iter_4_0, iter_4_1 in pairs(arg_2_1) do
						table.insert(arg_2_0.reMonthSignItems, iter_4_1)
					end

					if var_4_3.day > #var_4_1.data1_list and var_4_2 > var_4_1.data3 then
						Timer.New(function()
							arg_2_2()

							return
						end, 0.3, 1):Start()

						return
					else
						arg_2_0._event:emit(MonthSignPage.SHOW_RE_MONTH_SIGN, arg_2_0.reMonthSignItems, var_0)

						arg_2_1 = arg_2_0.reMonthSignItems
					end

					if false then
						arg_2_0.reMonthSignItems = nil

						arg_2_0._event:emit(BaseUI.ON_AWARD, {
							items = arg_2_1,
							removeFunc = var_0
						})
					end

					coroutine.yield()

					local var_4_5 = _.filter(arg_2_1, function(arg_7_0)
						return arg_7_0.type == DROP_TYPE_OPERATION
					end)
					local var_4_6 = #_.filter(arg_2_1, function(arg_6_0)
						return arg_6_0.type == DROP_TYPE_SHIP
					end) + #var_4_5
					local var_4_7 = getProxy(BayProxy)
					local var_4_8 = getProxy(BayProxy):getNewShip(true)

					_.each(var_4_5, function(arg_8_0)
						table.insert(var_4_8, var_4_7:getShipById(arg_8_0.id))

						return
					end)

					if pg.gameset.award_ship_limit then
						local var_4_9 = pg.gameset.award_ship_limit.key_value or 20

						if var_4_6 <= var_4_9 then
							for iter_4_2 = math.max(1, #var_4_8 - var_4_6 + 1), #var_4_8 do
								arg_2_0._event:emit(ActivityMediator.OPEN_LAYER, Context.New({
									mediator = NewShipMediator,
									viewComponent = NewShipLayer,
									data = {
										ship = var_4_8[iter_4_2]
									},
									onRemoved = var_0
								}))
								coroutine.yield()
							end
						end

						for iter_4_3, iter_4_4 in pairs(arg_2_1) do
							if iter_4_4.type == DROP_TYPE_SKIN then
								if pg.ship_skin_template[iter_4_4.id].skin_type == ShipSkin.SKIN_TYPE_REMAKE then
									-- block empty
								else
									arg_2_0._event:emit(ActivityMediator.OPEN_LAYER, Context.New({
										mediator = NewSkinMediator,
										viewComponent = NewSkinLayer,
										data = {
											skinId = iter_4_4.id
										},
										onRemoved = var_0
									}))
								end

								coroutine.yield()
							end
						end

						if arg_2_2 then
							arg_2_2()
						end

						return
					end
				end
			end
		end
	end)

	;(function()
		if var_2_0 and coroutine.status(var_2_0) == "suspended" then
			local var_3_0, var_3_1 = coroutine.resume(var_2_0)

			assert(var_3_0, var_3_1)
		end

		return
	end)()

	return
end

return var_0_0
