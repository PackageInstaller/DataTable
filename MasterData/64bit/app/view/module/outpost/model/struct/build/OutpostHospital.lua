local OutpostHospital = class("OutpostHospital", (require("app.view.module.outpost.model.struct.build.OutpostConsumptionBuild")))

function OutpostHospital:ctor(arg_1_1, arg_1_2)
	OutpostHospital.super.ctor(self, arg_1_1, arg_1_2)
end

function OutpostHospital:getEffectDes()
	return g.core.lang:get(432636)
end

function OutpostHospital:getJudgeValue(arg_3_1)
	if arg_3_1.hpRate then
		return arg_3_1.hpRate * 100
	end
end

return OutpostHospital
