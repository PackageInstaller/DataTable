local OutpostHostel = class("OutpostHostel", (require("app.view.module.outpost.model.struct.build.OutpostConsumptionBuild")))

function OutpostHostel:ctor(arg_1_1, arg_1_2)
	OutpostHostel.super.ctor(self, arg_1_1, arg_1_2)
end

function OutpostHostel:getEffectDes()
	return g.core.lang:get(432637)
end

function OutpostHostel:getJudgeValue(arg_3_1)
	return arg_3_1.fatigue
end

return OutpostHostel
