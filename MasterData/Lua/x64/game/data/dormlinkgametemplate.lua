local DormLinkGameCustomerTemplate = class("DormLinkGameCustomerTemplate")
local var_0_1

function DormLinkGameCustomerTemplate:Ctor(arg_1_1)
	self.ID = arg_1_1.customerID
	self.eid = arg_1_1.customerEID
	self.posIndex = arg_1_1.posIndex
	var_0_1 = 0
	self.satietyNum, self.curPreference = ActivityLinkGameCustomerCfg[self.ID].satiety_limit[1]
	self.satietyAddition = 0
	self.priority = ActivityLinkGameCustomerCfg[self.ID].seat_priority

	self:CalSatietyExtendAddition()
	self:RefreshNextPreferenceFood()
end

function DormLinkGameCustomerTemplate:FoodComplate()
	if self.curPreference then
		self:ReviseSatiety(ActivityLinkGameComposeCfg[self.curPreference].satiety_up)
		self:RefreshNextPreferenceFood()
		manager.notify:Invoke(LIANLIANKAN_CUSTOMER_EAT, self.posIndex)
	end
end

function DormLinkGameCustomerTemplate:RefreshNextPreferenceFood()
	if ActivityLinkGameCustomerCfg[self.ID].compose_list then
		local var_3_0 = ActivityLinkGameCustomerCfg[self.ID].compose_list[math.random(#ActivityLinkGameCustomerCfg[self.ID].compose_list)]

		while var_3_0 == self.curPreference and #ActivityLinkGameCustomerCfg[self.ID].compose_list > 1 do
			var_3_0 = ActivityLinkGameCustomerCfg[self.ID].compose_list[math.random(#ActivityLinkGameCustomerCfg[self.ID].compose_list)]
		end

		self.curPreference = var_3_0

		DormLinkGameData:UpdataCustomerNeed()
	end
end

function DormLinkGameCustomerTemplate:ReviseSatiety(arg_4_1)
	self.satietyNum = self.satietyNum + ActivityLinkGameCustomerCfg[self.ID].satiety_limit[2] * arg_4_1 / 100

	if ActivityLinkGameCustomerCfg[self.ID].satiety_limit[1] > self.satietyNum then
		self.satietyNum = ActivityLinkGameCustomerCfg[self.ID].satiety_limit[1]
	end

	if ActivityLinkGameCustomerCfg[self.ID].satiety_limit[2] < self.satietyNum then
		self.satietyNum = ActivityLinkGameCustomerCfg[self.ID].satiety_limit[2]
	end

	self:CalSatietyExtendAddition()
	manager.notify:Invoke(DORM_LINK_REFRESH_CUSTOMER_SATIETY, self.ID)
end

function DormLinkGameCustomerTemplate:CalSatietyExtendAddition()
	for iter_5_0, iter_5_1 in ipairs(ActivityLinkGameCustomerCfg[self.ID].satiety_score_up) do
		if iter_5_1[2][1] <= self.satietyNum and iter_5_1[2][2] > self.satietyNum then
			self.satietyAddition = iter_5_1[1]

			break
		end

		if iter_5_0 == #ActivityLinkGameCustomerCfg[self.ID].satiety_score_up and iter_5_1[2][2] <= self.satietyAddition then
			self.satietyAddition = iter_5_1[1]
		end
	end

	if self.satietyAddition ~= self.satietyAddition then
		DormLinkGameData:RefreshCustomerExtendAddition()
	end
end

function DormLinkGameCustomerTemplate:GetSatiety()
	if var_0_1 then
		return var_0_1
	else
		print(self.ID .. "号客人不存在饱食度数据")
	end
end

function DormLinkGameCustomerTemplate:RefreshCustomerBubble(arg_7_1)
	DormLuaBridge.SetUIFollow(arg_7_1, self.eid, "root")
end

return DormLinkGameCustomerTemplate
