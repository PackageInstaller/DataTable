class = var_0_10000

local var_0_0 = var_0_10000("GuildDonateCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.Find(var_1_0, "name")
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.title = var_1_2(var_1_1, var_4(var_1_10005))

	local var_1_3 = arg_1_0._tf

	arg_1_0.awardTF = var_2.Find(var_1_3, "item")

	local var_1_4 = arg_1_0._tf

	arg_1_0.awardTxtTF = var_2.Find(var_1_4, "item/Text")

	local var_1_5 = arg_1_0._tf
	local var_1_6 = var_2.Find(var_1_5, "award/Text")
	local var_1_7 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.res = var_1_7(var_1_6, var_4(var_1_10005))

	local var_1_8 = arg_1_0._tf

	arg_1_0.commitBtn = var_2.Find(var_1_8, "submit")

	return
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0.dtask = arg_2_1

	local var_2_0 = arg_2_1
	local var_2_1 = arg_2_1.getCommitItem(var_2_0)

	updateDrop = var_2_0

	var_2_0(arg_2_0.awardTF, {
		type = var_2_1[1],
		id = var_2_1[2],
		count = var_2_1[3]
	})

	arg_2_0.title.text = arg_2_1:getConfig("name")

	local var_2_2 = arg_2_0:GetResCntByAward(var_2_1)
	local var_2_3 = var_2_1[3]

	setText = var_5

	local var_2_4 = arg_2_0.awardTxtTF

	string = var_1_10007

	local var_2_5 = var_1_10007.format

	if var_2_2 < var_2_3 then
		local var_2_6 = "<color="

		COLOR_RED = var_1_10009

		local var_2_7

		if not (var_2_6 .. var_1_10009 .. ">%s</color>/%s") then
			var_2_7 = "%s/%s"
		end

		var_5(var_2_4, var_2_5(var_2_7, arg_2_0:WrapNum(var_2_2), arg_2_0:WrapNum(var_2_3)))

		arg_2_0.res.text = arg_2_1:getConfig("award_contribution")

		return
	end
end

function var_0_0.GetResCntByAward(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1[1]

	DROP_TYPE_RESOURCE = var_1_10003

	if var_3_0 == var_1_10003 then
		getProxy = var_3_0
		PlayerProxy = var_1_10003
		var_1_10003 = var_3_0(var_1_10003)
		var_1_10003 = var_2.getRawData(var_1_10003)

		return var_2.getResource(var_1_10003, arg_3_1[2])
	else
		local var_3_1 = arg_3_1[1]

		DROP_TYPE_ITEM = var_1_10003

		if var_3_1 == var_1_10003 then
			getProxy = var_3_1
			BagProxy = var_1_10003

			local var_3_2 = var_3_1(var_1_10003)

			return var_3_1.getItemCountById(var_3_2, arg_3_1[2])
		else
			assert = var_3_1

			var_3_1(false)
		end
	end

	return
end

function var_0_0.WrapNum(arg_4_0, arg_4_1)
	if 1000000 < arg_4_1 then
		math = var_2

		return var_2.floor(arg_4_1 / 1000000) .. "M"
	elseif 1000 < arg_4_1 then
		math = var_2

		return var_2.floor(arg_4_1 / 1000) .. "K"
	end

	return arg_4_1
end

function var_0_0.Dispose(arg_5_0)
	return
end

return var_0_0
