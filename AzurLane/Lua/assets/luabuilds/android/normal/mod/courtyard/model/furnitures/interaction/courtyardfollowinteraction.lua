class = var_0_10000

local var_0_0 = "CourtYardFollowInteraction"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardInteraction"))

function var_0_1.OnStepEnd(arg_1_0)
	if arg_1_0:IsCompleteOwnerStep() then
		arg_1_0:DoStep()
	end

	return
end

return var_0_1
