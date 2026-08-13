class = var_0_10000

local var_0_0 = "ActivityBossSurugaScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".ActivityBossSceneTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "ActivityBossUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	PoolMgr = var_1_10002

	local var_2_0 = var_1_10002.GetInstance()

	var_2.GetPrefab(var_2_0, "ui/cysx_fk", "cysx_fk", true, function(arg_3_0)
		local var_3_0 = var_0

		var_1.ReturnPrefab(var_3_0, "ui/cysx_fk", "cysx_fk", arg_3_0)
		arg_2_1()

		return
	end)

	return
end

function var_0_1.init(arg_4_0)
	var_0_1.super.init(arg_4_0)

	setText = var_1

	local var_4_0 = arg_4_0.rankTF
	local var_4_1 = var_2.Find(var_4_0, "title/Text")

	i18n = var_4_0

	var_1(var_4_1, var_4_0("word_billboard"))

	AutoLoader = var_1
	arg_4_0.loader = var_1.New()

	return
end

function var_0_1.didEnter(arg_5_0)
	var_0_1.super.didEnter(arg_5_0)

	local var_5_0 = arg_5_0.loader

	var_1.GetPrefab(var_5_0, "ui/cysx_fk", "cysx_fk", function(arg_6_0)
		setParent = var_2_10001

		var_2_10001(arg_6_0, arg_5_0.left)

		setAnchoredPosition = var_2_10001

		local var_6_0 = arg_6_0

		Vector2 = var_3

		var_2_10001(var_6_0, var_3(69, 295))

		local var_6_1 = arg_6_0.transform

		var_1.SetAsFirstSibling(var_6_1)

		return
	end)

	return
end

function var_0_1.UpdateRank(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or {}

	for iter_7_0 = 1, #arg_7_0.rankList do
		local var_7_0 = arg_7_0.rankList[iter_7_0]

		setActive = var_1_10007

		var_1_10007(var_7_0, iter_7_0 <= #arg_7_1)

		if iter_7_0 <= #arg_7_1 then
			local var_7_1 = var_7_0

			var_1_10007 = var_7_0.Find(var_7_1, "name/Text")
			setText = var_7_1

			local var_7_2 = var_1_10007

			tostring = var_1_10010

			var_7_1(var_7_2, var_1_10010(arg_7_1[iter_7_0].name))

			setText = var_7_1
			var_1_10010 = var_7_0

			var_7_1(var_7_0.Find(var_1_10010, "num/Text"), "NO." .. iter_7_0)
		end
	end

	return
end

function var_0_1.UpdateDropItems(arg_8_0)
	ipairs = var_1_10001

	local var_8_0

	if not arg_8_0.contextData.DisplayItems then
		var_8_0 = {}
	end

	for iter_8_0, iter_8_1 in var_1_10001(var_8_0) do
		local var_8_1 = arg_8_0.barList[iter_8_0]
		local var_8_2 = var_6.Find(var_8_1, "milestone/item")
		local var_8_3 = {
			type = arg_8_0.contextData.DisplayItems[5 - iter_8_0][1],
			id = arg_8_0.contextData.DisplayItems[5 - iter_8_0][2],
			count = arg_8_0.contextData.DisplayItems[5 - iter_8_0][3]
		}

		updateDrop = var_8

		var_8(var_8_2, var_8_3)

		onButton = var_8

		local var_8_4 = arg_8_0
		local var_8_5 = var_8_2

		local function var_8_6()
			local var_9_0 = arg_8_0

			var_0.emit(var_9_0, var_0_1.ON_DROP, var_8_3)

			return
		end

		SFX_PANEL = var_1_10012

		var_8(var_8_4, var_8_5, var_8_6, var_1_10012)
	end

	return
end

function var_0_1.willExit(arg_10_0)
	var_0_1.super.willExit(arg_10_0)

	local var_10_0 = arg_10_0.loader

	var_1.Clear(var_10_0)

	return
end

return var_0_1
