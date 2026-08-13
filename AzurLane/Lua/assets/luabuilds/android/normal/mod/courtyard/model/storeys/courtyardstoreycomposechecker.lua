class = var_0_10000

local var_0_0 = var_0_10000("CourtYardStoreyComposeChecker")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.storey = arg_1_1
	pg = var_1_10002
	arg_1_0.config = var_1_10002.furniture_compose_template
	arg_1_0.list = {}

	return
end

function var_0_0.Check(arg_2_0)
	ipairs = var_1_10001

	for iter_2_0, iter_2_1 in var_1_10001(arg_2_0.config.all) do
		if arg_2_0:IsMatch(arg_2_0.config[iter_2_1].furniture_ids) then
			arg_2_0:Add(iter_2_1)
		else
			arg_2_0:Remove(iter_2_1)
		end
	end

	return
end

function var_0_0.Add(arg_3_0, arg_3_1)
	table = var_1_10002

	if not var_1_10002.contains(arg_3_0.list, arg_3_1) then
		table = var_2

		var_2.insert(arg_3_0.list, arg_3_1)

		local var_3_0 = arg_3_0.storey
		local var_3_1 = var_2.DispatchEvent

		CourtYardEvent = var_4

		var_3_1(var_3_0, var_4.ON_ADD_EFFECT, arg_3_0.config[arg_3_1].effect_name)
	end

	return
end

function var_0_0.Remove(arg_4_0, arg_4_1)
	table = var_1_10002

	if var_1_10002.contains(arg_4_0.list, arg_4_1) then
		table = var_2

		var_2.removebyvalue(arg_4_0.list, arg_4_1)

		local var_4_0 = arg_4_0.storey
		local var_4_1 = var_2.DispatchEvent

		CourtYardEvent = var_4

		var_4_1(var_4_0, var_4.ON_REMOVE_EFFECT, arg_4_0.config[arg_4_1].effect_name)
	end

	return
end

function var_0_0.IsMatch(arg_5_0, arg_5_1)
	local function var_5_0(arg_6_0)
		if arg_5_0.storey.furnitures[arg_6_0] == nil and (not arg_5_0.storey.wallPaper or arg_5_0.storey.wallPaper.configId ~= arg_6_0) then
			local var_6_0

			if arg_5_0.storey.floorPaper then
				if arg_5_0.storey.floorPaper.configId ~= arg_6_0 then
					var_6_0 = false

					goto label_6_0
				end

				var_6_0 = true
			end

			::label_6_0::

			return var_6_0
		end
	end

	_ = var_1_10003

	return var_1_10003.all(arg_5_1, var_5_0)
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.config = nil
	arg_7_0.list = nil
	arg_7_0.storey = nil

	return
end

return var_0_0
