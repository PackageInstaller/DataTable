local ActivitySelectableCommodity = class("ActivitySelectableCommodity", import(".ActivityCommodity"))

function ActivitySelectableCommodity:Selectable()
	local var_1_0 = self:getConfig("commodity_id_list")

	return var_1_0 and var_1_0 ~= "" and #var_1_0 > 0
end

function ActivitySelectableCommodity:GetFirstDropId()
	return self:getConfig("commodity_id_list")
end

return ActivitySelectableCommodity
