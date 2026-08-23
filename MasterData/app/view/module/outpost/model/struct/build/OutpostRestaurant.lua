local OutpostRestaurant = class("OutpostRestaurant", (require("app.view.module.outpost.model.struct.build.OutpostConsumptionBuild")))

function OutpostRestaurant:ctor(arg_1_1, arg_1_2)
	OutpostRestaurant.super.ctor(self, arg_1_1, arg_1_2)
end

function OutpostRestaurant:getEffectDes()
	return g.core.lang:get(432638)
end

function OutpostRestaurant:getJudgeValue(arg_3_1)
	return arg_3_1.hunger
end

return OutpostRestaurant
