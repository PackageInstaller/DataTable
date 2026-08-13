local var_0_0 = {}

var_0_0.clearSprites = true

function var_0_0.Destroy(arg_1_0)
	UIUtil = var_1_10001

	local var_1_0

	if var_1_10001.IsGameObject(arg_1_0) then
		::label_1_0::

		UIUtil = var_1_0
		var_1_0 = var_1_0.IsPrefab(arg_1_0)
	end

	if var_1 and not var_1_0 then
		Object = var_1_10003

		var_1_10003.Destroy(arg_1_0)

		return true
	else
		return false
	end

	return
end

return var_0_0
