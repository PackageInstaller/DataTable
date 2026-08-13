class = var_0_10000

local var_0_0 = "HaloAttachmentView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".StaticCellView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.line = {
		row = arg_1_2,
		column = arg_1_3
	}

	return
end

function var_0_1.GetOrder(arg_2_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityUpperEffect
end

function var_0_1.Update(arg_3_0)
	local var_3_0 = arg_3_0.info.flag

	ChapterConst = var_1_10003

	if var_3_0 == var_1_10003.CellFlagTriggerActive then
		local var_3_1 = var_1.trait

		ChapterConst = var_3

		local var_3_2

		if var_3_1 == var_3.TraitLurk then
			var_3_2 = false
		else
			var_3_2 = true
		end

		IsNil = var_3

		local var_3_3

		if var_3(arg_3_0.go) then
			var_3_3 = arg_3_0.line.row

			local var_3_4 = arg_3_0.line.column
			local var_3_5 = "story_" .. var_3_3 .. "_" .. var_3_4 .. "_" .. var_1.attachmentId .. "_upper"

			arg_3_0:PrepareBase(var_3_5)

			pg = var_6

			if var_6.map_event_template[var_1.attachmentId].icon and #var_7 > 0 then
				local var_3_6 = var_7 .. "_1shangceng"
				local var_3_7 = "ui/" .. var_3_6
				local var_3_8 = var_3_6
				local var_3_9 = arg_3_0:GetLoader()

				var_11.GetPrefab(var_3_9, var_3_7, var_3_8, function(arg_4_0)
					tf = var_2_10001

					local var_4_0 = var_2_10001(arg_4_0)

					var_1.SetParent(var_4_0, arg_3_0.tf, false)

					local var_4_1 = arg_3_0

					var_1.ResetCanvasOrder(var_4_1)

					return
				end)
			end
		end

		setActive = var_3_3

		var_3_3(arg_3_0.tf, var_3_2)

		return
	end
end

return var_0_1
