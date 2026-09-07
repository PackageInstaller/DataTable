local GuideHideUIStep = class("GuideHideUIStep", import(".GuideStep"))

function GuideHideUIStep:Ctor(arg_1_1)
	GuideHideUIStep.super.Ctor(self, arg_1_1)

	self.nodes = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.hideui) do
		local var_1_0 = {
			path = iter_1_1.path
		}

		var_1_0.delay = iter_1_1.delay or 0
		var_1_0.pathIndex = iter_1_1.pathIndex or -1
		var_1_0.hideFlag = iter_1_1.ishide
		var_1_0.type = iter_1_1.type

		table.insert(self.nodes, var_1_0)
	end

	return
end

function GuideHideUIStep:GetType()
	return GuideStep.TYPE_HIDEUI
end

function GuideHideUIStep:GetHideNodes()
	return self.nodes
end

return GuideHideUIStep
