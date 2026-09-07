local AnniversaryIslandHotSpringMediator = class("AnniversaryIslandHotSpringMediator", import("view.activity.BackHills.NewYearFestival.NewYearHotSpringMediator"))

function AnniversaryIslandHotSpringMediator:register()
	self:bind(AnniversaryIslandHotSpringMediator.OPEN_CHUANWU, function(arg_2_0, arg_2_1, arg_2_2)
		self:OnSelShips(arg_2_1, arg_2_2)

		return
	end)

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2)

	self.activity = var_1_0

	self.viewComponent:SetActivity(var_1_0)
	self:bind(AnniversaryIslandHotSpringMediator.OPEN_INFO, function()
		self:addSubLayers(Context.New({
			mediator = AnniversaryIslandSpringShipSelectMediator,
			viewComponent = AnniversaryIslandSpringShipSelectLayer,
			data = {
				actId = var_1_0.id
			}
		}))

		return
	end)

	return
end

function AnniversaryIslandHotSpringMediator:OnSelected(arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = Clone(self.activity:GetShipIds())

	_.each(_.range(self.activity:GetSlotCount()), function(arg_5_0)
		var_4_0[arg_5_0] = var_4_0[arg_5_0] or 0

		return
	end)

	if arg_4_2 == nil or #arg_4_2 == 0 then
		if var_4_0[arg_4_1] > 0 then
			self:sendNotification(GAME.ACTIVITY_OPERATION, {
				activity_id = self.activity.id,
				cmd = Spring2Activity.OPERATION_SETSHIP,
				kvargs1 = {
					{
						value = 0,
						key = arg_4_1
					}
				}
			})
		end

		existCall(arg_4_3)

		return
	end

	local var_4_1 = _.filter(arg_4_2, function(arg_6_0)
		return not table.contains(var_4_0, arg_6_0)
	end)

	table.Foreach(var_4_0, function(arg_7_0, arg_7_1)
		if arg_7_1 == 0 or table.contains(arg_4_2, arg_7_1) then
			return
		end

		var_4_0[arg_7_0] = 0

		return
	end)

	if #var_4_1 == 1 and var_4_0[arg_4_1] == 0 then
		var_4_0[arg_4_1] = var_4_1[1]
	else
		local var_4_2 = 0

		_.each(var_4_1, function(arg_8_0)
			while var_4_2 <= #var_4_0 do
				var_4_2 = var_4_2 + 1

				if var_4_0[var_4_2] == 0 then
					break
				end
			end

			var_4_0[var_4_2] = arg_8_0

			return
		end)
	end

	local var_4_3 = {}
	local var_4_4 = self.activity:GetShipIds()

	table.Foreach(var_4_0, function(arg_9_0, arg_9_1)
		if (var_4_4[arg_9_0] or 0) ~= arg_9_1 then
			table.insert(var_4_3, {
				key = arg_9_0,
				value = arg_9_1
			})
		end

		return
	end)

	if #var_4_3 > 0 then
		self:sendNotification(GAME.ACTIVITY_OPERATION, {
			activity_id = self.activity.id,
			cmd = Spring2Activity.OPERATION_SETSHIP,
			kvargs1 = var_4_3
		})
	end

	arg_4_3()

	return
end

function AnniversaryIslandHotSpringMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED,
		ActivityProxy.ACTIVITY_UPDATED,
		ActivityProxy.ACTIVITY_SHOW_AWARDS,
		AnniversaryIslandHotSpringMediator.OPEN_CHUANWU
	}
end

function AnniversaryIslandHotSpringMediator:handleNotification(arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1:getBody()

	if var_11_0 == nil then
		-- block empty
	elseif var_11_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_11_1.awards, var_11_1.callback)
	elseif var_11_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_11_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_HOTSPRING_2 then
			self.activity = var_11_1

			self.viewComponent:SetActivity(var_11_1)
			self.viewComponent:UpdateView()
		end
	elseif var_11_0 == AnniversaryIslandHotSpringMediator.OPEN_CHUANWU then
		self.viewComponent:emit(AnniversaryIslandHotSpringMediator.OPEN_CHUANWU, unpack(var_11_1))
	end

	return
end

return AnniversaryIslandHotSpringMediator
