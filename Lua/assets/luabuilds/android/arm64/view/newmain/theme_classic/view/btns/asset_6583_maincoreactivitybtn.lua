local MainCoreActivityBtn = class("MainCoreActivityBtn", import(".MainBaseActivityBtn"))

function MainCoreActivityBtn:Register()
	MainCoreActivityBtn.super.Register(self)
	self.event:connect(MainBaseActivityBtn.UPDATED_TIP, handler(self, self.OnRefreshBtn))

	return
end

function MainCoreActivityBtn:GetEventName()
	return "event_core"
end

function MainCoreActivityBtn:OnInit()
	self:PickPriortyActAsyn(function(arg_4_0, arg_4_1)
		self.priority = arg_4_0

		if arg_4_1 > 0 then
			self.tipTxt.text = arg_4_1
		end

		setActive(self.tipTr.gameObject, arg_4_1 > 0)

		return
	end)

	return
end

function MainCoreActivityBtn:PickPriortyActAsyn(arg_5_1)
	local var_5_0 = {}
	local var_5_1 = 0
	local var_5_2

	table.insert(var_5_0, function(arg_6_0)
		local var_6_0, var_6_1 = self:CollectActivity()

		var_5_2 = var_6_1
		var_5_1 = var_5_1 + var_6_0

		onNextTick(arg_6_0)

		return
	end)
	seriesAsync(var_5_0, function()
		arg_5_1(var_5_2, var_5_1)

		return
	end)

	return
end

function MainCoreActivityBtn:CollectActivity()
	local var_8_0 = 0
	local var_8_1

	for iter_8_0, iter_8_1 in pairs((getProxy(ActivityProxy):getCorePanelActivities(pg.activity_template[self:GetLinkConfig().time[2]].page_core))) do
		if iter_8_1:readyToAchieve() then
			var_8_0 = var_8_0 + 1

			if not var_8_1 or var_8_1 and var_8_1.id > iter_8_1.id then
				var_8_1 = iter_8_1
			end
		end
	end

	return var_8_0, var_8_1
end

function MainCoreActivityBtn:GetTipImage()
	return "tip_1920"
end

function MainCoreActivityBtn:OnRefreshBtn()
	self:OnInit()

	return
end

function MainCoreActivityBtn:Dispose()
	self.event:disconnect(MainBaseActivityBtn.UPDATED_TIP, handler(self, self.OnRefreshBtn))
	MainCoreActivityBtn.super.Dispose(self)

	return
end

return MainCoreActivityBtn
