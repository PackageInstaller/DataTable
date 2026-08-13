class = var_0_10000

local var_0_0 = "AttachmentLBAirport"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.level.cell.StaticCellView"))

var_0_1.StateOutControl = 1
var_0_1.StateUnderControl = 2

function var_0_1.GetOrder(arg_1_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityAttachment
end

function var_0_1.Update(arg_2_0)
	local var_2_0 = arg_2_0.extraFlagList

	IsNil = var_1_10002

	if var_1_10002(arg_2_0.go) then
		arg_2_0:PrepareBase("airport")
	end

	table = var_2

	local var_2_1 = var_2.contains
	local var_2_2 = var_2_0

	ChapterConst = var_1_10004

	local var_2_4, var_2_5

	if var_2_1(var_2_2, var_1_10004.StatusAirportOutControl) and arg_2_0.state ~= var_0_1.StateOutControl then
		arg_2_0.state = var_0_1.StateOutControl

		local var_2_3 = arg_2_0:GetLoader()

		var_2_4 = var_2_4.ClearRequest
		var_2_5 = "Dead"
		AutoLoader = var_1_10005

		var_2_4(var_2_3, var_2_5, var_1_10005.PartLoading)

		local var_2_6 = arg_2_0:GetLoader()

		var_2_4.GetPrefab(var_2_6, "chapter/dexiv3_2x2_2", "dexiv3_2x2_2", function(arg_3_0)
			local var_3_0 = arg_2_0
			local var_3_1 = var_1.GetLoader(var_3_0)

			var_1.ClearRequest(var_3_1, "Dead")

			setParent = var_1

			var_1(arg_3_0, arg_2_0.tf)

			return
		end, "Enemy")
	else
		table = var_2_4

		local var_2_7 = var_2_4.contains
		local var_2_8 = var_2_0

		ChapterConst = var_2_5

		if var_2_7(var_2_8, var_2_5.StatusAirportUnderControl) and arg_2_0.state ~= var_0_1.StateUnderControl then
			arg_2_0.state = var_0_1.StateUnderControl

			local var_2_9 = arg_2_0:GetLoader()
			local var_2_10 = var_2.ClearRequest
			local var_2_11 = "Enemy"

			AutoLoader = var_1_10005

			var_2_10(var_2_9, var_2_11, var_1_10005.PartLoading)

			local var_2_12 = arg_2_0:GetLoader()

			var_2.GetPrefab(var_2_12, "chapter/dexiv3_2x2_1", "dexiv3_2x2_1", function(arg_4_0)
				local var_4_0 = arg_2_0
				local var_4_1 = var_1.GetLoader(var_4_0)

				var_1.ClearRequest(var_4_1, "Enemy")

				setParent = var_1

				var_1(arg_4_0, arg_2_0.tf)

				return
			end, "Dead")
		end
	end

	return
end

return var_0_1
