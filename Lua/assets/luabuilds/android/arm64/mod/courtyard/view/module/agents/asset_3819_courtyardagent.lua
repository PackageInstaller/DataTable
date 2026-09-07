local CourtYardAgent = class("CourtYardAgent")

function CourtYardAgent:Ctor(arg_1_1)
	setmetatable(self, {
		__index = function(arg_2_0, arg_2_1)
			local var_2_0 = rawget(arg_2_0, "class")

			return (var_2_0[arg_2_1] or nil) and (var_2_0[arg_2_1] or arg_1_1[arg_2_1])
		end
	})

	return
end

function CourtYardAgent:Dispose()
	return
end

return CourtYardAgent
