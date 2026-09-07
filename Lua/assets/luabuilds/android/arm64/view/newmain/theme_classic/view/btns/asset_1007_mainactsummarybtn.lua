local MainActSummaryBtn = class("MainActSummaryBtn", import(".MainBaseActivityBtn"))

function MainActSummaryBtn:GetEventName()
	return "event_all"
end

function MainActSummaryBtn:GetTipImage()
	return "tip_1920"
end

function MainActSummaryBtn:GetActivityID()
	return nil
end

function MainActSummaryBtn:OnInit()
	self:PickPriortyActAsyn(function(arg_5_0, arg_5_1)
		self.priority = arg_5_0

		if arg_5_1 > 0 then
			self.tipTxt.text = arg_5_1
		end

		setActive(self.tipTr.gameObject, arg_5_1 > 0)

		return
	end)

	return
end

function MainActSummaryBtn:PickPriortyActAsyn(arg_6_1)
	local var_6_0 = {}
	local var_6_1 = 0
	local var_6_2

	table.insert(var_6_0, function(arg_7_0)
		local var_7_0, var_7_1 = self:CollectActivity()

		var_6_2 = var_7_1
		var_6_1 = var_6_1 + var_7_0

		onNextTick(arg_7_0)

		return
	end)
	table.insert(var_6_0, function(arg_8_0)
		var_6_1 = var_6_1 + self:CollectActEntrance()

		onNextTick(arg_8_0)

		return
	end)
	seriesAsync(var_6_0, function()
		arg_6_1(var_6_2, var_6_1)

		return
	end)

	return
end

function MainActSummaryBtn:CollectActivity()
	local var_10_0 = 0
	local var_10_1

	for iter_10_0, iter_10_1 in pairs((getProxy(ActivityProxy):getPanelActivities())) do
		if iter_10_1:readyToAchieve() then
			var_10_0 = var_10_0 + 1

			if not var_10_1 or var_10_1 and var_10_1.id > iter_10_1.id then
				var_10_1 = iter_10_1
			end
		end
	end

	return var_10_0, var_10_1
end

function MainActSummaryBtn:CollectActEntrance()
	return #_.filter(ActivityMainScene.GetOnShowEntranceData(), function(arg_12_0)
		return arg_12_0.isTip and arg_12_0.isTip()
	end)
end

function MainActSummaryBtn:CustomOnClick()
	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CARD_TOWER_MODE_SELECT)

	return
end

return MainActSummaryBtn
