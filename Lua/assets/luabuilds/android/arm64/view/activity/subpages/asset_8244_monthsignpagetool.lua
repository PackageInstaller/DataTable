local MonthSignPageTool = class("MonthSignPageTool")

function MonthSignPageTool:Ctor(arg_1_1)
	self._event = arg_1_1

	return
end

function MonthSignPageTool:onAcheve(arg_2_1, arg_2_2)
	local var_2_0

	local function var_2_1()
		if var_2_0 and coroutine.status(var_2_0) == "suspended" then
			local var_3_0, var_3_1 = coroutine.resume(var_2_0)

			assert(var_3_0, var_3_1)
		end

		return
	end

	var_2_0 = coroutine.create(function()
		if table.getCount(arg_2_1) > 0 then
			local var_4_0 = getProxy(ActivityProxy)
			local var_4_1 = var_4_0:getActivityById(ActivityConst.MONTH_SIGN_ACTIVITY_ID)

			if var_4_1:getSpecialData("reMonthSignDay") ~= nil then
				if self.reMonthSignItems then
					self.reMonthSignItems = self.reMonthSignItems or {}
				end

				for iter_4_0, iter_4_1 in pairs(arg_2_1) do
					table.insert(self.reMonthSignItems, iter_4_1)
				end

				if pg.TimeMgr.GetInstance():STimeDescS(pg.TimeMgr.GetInstance().GetServerTime(var_4_0), "*t").day > #var_4_1.data1_list and pg.activity_month_sign[var_4_1.data2].resign_count > var_4_1.data3 then
					Timer.New(function()
						arg_2_2()

						return
					end, 0.3, 1):Start()

					return
				else
					self._event:emit(MonthSignPage.SHOW_RE_MONTH_SIGN, self.reMonthSignItems, var_2_1)

					arg_2_1 = self.reMonthSignItems
				end
			else
				self.reMonthSignItems = nil

				self._event:emit(BaseUI.ON_AWARD, {
					items = arg_2_1,
					removeFunc = var_2_1
				})
			end

			coroutine.yield()

			local var_4_4 = _.filter(arg_2_1, function(arg_7_0)
				return arg_7_0.type == DROP_TYPE_OPERATION
			end)
			local var_4_5 = #_.filter(arg_2_1, function(arg_6_0)
				return arg_6_0.type == DROP_TYPE_SHIP
			end) + #var_4_4
			local var_4_6 = getProxy(BayProxy)
			local var_4_7 = var_4_6:getNewShip(true)

			_.each(var_4_4, function(arg_8_0)
				table.insert(var_4_7, var_4_6:getShipById(arg_8_0.id))

				return
			end)

			if pg.gameset.award_ship_limit then
				if var_4_5 <= (pg.gameset.award_ship_limit.key_value or 20) then
					for iter_4_2 = math.max(1, #var_4_7 - var_4_5 + 1), #var_4_7 do
						self._event:emit(ActivityMediator.OPEN_LAYER, Context.New({
							mediator = NewShipMediator,
							viewComponent = NewShipLayer,
							data = {
								ship = var_4_7[iter_4_2]
							},
							onRemoved = var_2_1
						}))
						coroutine.yield()
					end
				end
			end

			for iter_4_3, iter_4_4 in pairs(arg_2_1) do
				if iter_4_4.type == DROP_TYPE_SKIN then
					if pg.ship_skin_template[iter_4_4.id].skin_type == ShipSkin.SKIN_TYPE_REMAKE then
						-- block empty
					else
						self._event:emit(ActivityMediator.OPEN_LAYER, Context.New({
							mediator = NewSkinMediator,
							viewComponent = NewSkinLayer,
							data = {
								skinId = iter_4_4.id
							},
							onRemoved = var_2_1
						}))
					end

					coroutine.yield()
				end
			end
		end

		if arg_2_2 then
			arg_2_2()
		end

		return
	end)

	var_2_1()

	return
end

return MonthSignPageTool
