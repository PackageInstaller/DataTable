class = var_0_10000

local var_0_0 = "PublicGuildTechnologyPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "PublicGuildTechnologyPage"
end

function var_0_1.OnTechGroupUpdate(arg_2_0, arg_2_1)
	arg_2_0:UpdateUpgradeList()

	return
end

function var_0_1.OnLoaded(arg_3_0)
	UIItemList = var_1_10001

	local var_3_0 = var_1_10001.New
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_2.Find(var_3_1, "frame/upgrade/content")
	local var_3_3 = arg_3_0._tf

	arg_3_0.upgradeList = var_3_0(var_3_2, var_3.Find(var_3_3, "frame/upgrade/content/tpl"))

	return
end

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = arg_4_0.upgradeList

	var_1.make(var_4_0, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_4_0.technologyVOs[arg_5_1 + 1]

			PublicGuildTechnologyCard = var_4

			local var_5_1 = var_4.New(arg_5_2:Find("content"), arg_4_0)

			var_4.Update(var_5_1, var_5_0)

			setActive = var_5

			var_5(arg_5_2:Find("back"), false)
		end

		return
	end)

	return
end

function var_0_1.Show(arg_6_0, arg_6_1)
	arg_6_0.guildVO = arg_6_1

	arg_6_0:UpdateUpgradeList()
	var_0_1.super.Show(arg_6_0)

	return
end

function var_0_1.UpdateUpgradeList(arg_7_0)
	arg_7_0.technologyVOs = {}

	local var_7_0 = arg_7_0.guildVO
	local var_7_1 = var_1.GetTechnologys(var_7_0)

	pairs = var_7_0

	for iter_7_0, iter_7_1 in var_7_0(var_7_1) do
		if not iter_7_1:IsGuildMember() then
			table = var_7

			var_7.insert(arg_7_0.technologyVOs, iter_7_1)
		end
	end

	table = var_2

	var_2.sort(arg_7_0.technologyVOs, function(arg_8_0, arg_8_1)
		return arg_8_0.id < arg_8_1.id
	end)

	local var_7_2 = arg_7_0.upgradeList

	var_2.align(var_7_2, #arg_7_0.technologyVOs)

	return
end

function var_0_1.OnDestroy(arg_9_0)
	return
end

return var_0_1
