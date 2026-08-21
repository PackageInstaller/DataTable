local var_0_0 = class("GuildDonateCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	arg_1_0.title = arg_1_0._tf:Find("name"):GetComponent(typeof(Text))
	arg_1_0.awardTF = arg_1_0._tf:Find("item")
	arg_1_0.awardTxtTF = arg_1_0._tf:Find("item/Text")
	arg_1_0.res = arg_1_0._tf:Find("award/Text"):GetComponent(typeof(Text))
	arg_1_0.commitBtn = arg_1_0._tf:Find("submit")

	return
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0.dtask = arg_2_1

	local var_2_0 = arg_2_1:getCommitItem()

	updateDrop(arg_2_0.awardTF, {
		type = var_2_0[1],
		id = var_2_0[2],
		count = var_2_0[3]
	})

	arg_2_0.title.text = arg_2_1:getConfig("name")

	local var_2_1 = arg_2_0:GetResCntByAward(var_2_0)
	local var_2_4 = arg_2_0.awardTxtTF

	if var_2_1 < var_2_0[3] then
		var_2_3(var_2_4, var_2_5(var_2_6, arg_2_0:WrapNum(var_2_1), arg_2_0:WrapNum(var_2_2)))

		arg_2_0.res.text = arg_2_1:getConfig("award_contribution")

		return
	end
end

function var_0_0.GetResCntByAward(arg_3_0, arg_3_1)
	if arg_3_1[1] == DROP_TYPE_RESOURCE then
		return getProxy(PlayerProxy):getRawData():getResource(arg_3_1[2])
	elseif arg_3_1[1] == DROP_TYPE_ITEM then
		return getProxy(BagProxy):getItemCountById(arg_3_1[2])
	else
		assert(false)
	end

	return
end

function var_0_0.WrapNum(arg_4_0, arg_4_1)
	if arg_4_1 > 1000000 then
		return math.floor(arg_4_1 / 1000000) .. "M"
	elseif arg_4_1 > 1000 then
		return math.floor(arg_4_1 / 1000) .. "K"
	end

	return arg_4_1
end

function var_0_0.Dispose(arg_5_0)
	return
end

return var_0_0
