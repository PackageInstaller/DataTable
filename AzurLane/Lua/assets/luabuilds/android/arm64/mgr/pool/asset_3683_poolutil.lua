local var_0_0 = {}

var_0_0.clearSprites = true

function var_0_0.Destroy(arg_1_0)
	UIUtil = var_1_10001

	if var_1_10001.IsGameObject(arg_1_0) then
		::label_1_0::

		UIUtil = var_1_10002
		var_1_10002 = var_1_10002.IsPrefab(arg_1_0)
	end

	if var_1 and not var_1_10002 then
		Object = var_3

		var_3.Destroy(arg_1_0)

		return true
	else
		return false
	end

	return
end

return var_0_0
