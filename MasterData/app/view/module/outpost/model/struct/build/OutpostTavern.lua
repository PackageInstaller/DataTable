local OutpostTavern = class("OutpostTavern", (require("app.view.module.outpost.model.struct.build.OutpostConsumptionBuild")))

function OutpostTavern:ctor(arg_1_1, arg_1_2)
	OutpostTavern.super.ctor(self, arg_1_1, arg_1_2)
end

function OutpostTavern:getEffectDes()
	return g.core.lang:get(432639)
end

function OutpostTavern:getJudgeValue(arg_3_1)
	return arg_3_1.mood
end

return OutpostTavern
