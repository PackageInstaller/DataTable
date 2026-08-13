class = var_0_10000

local var_0_0 = "WorldBossAwardPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "WorldBossAwardUI"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "frame/list/container1/tpl")

	UIItemList = var_3_0

	local var_3_2 = var_3_0.New
	local var_3_3 = arg_3_0._tf

	arg_3_0.uilist1 = var_3_2(var_3.Find(var_3_3, "frame/list/container1"), var_3_1)
	UIItemList = var_2

	local var_3_4 = var_2.New
	local var_3_5 = arg_3_0._tf

	arg_3_0.uilist2 = var_3_4(var_3.Find(var_3_5, "frame/list/container2"), var_3_1)
	onButton = var_2

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0._tf

	local function var_3_8()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_3_6, var_3_7, var_3_8, var_1_10006)

	return
end

function var_0_1.Update(arg_5_0, arg_5_1)
	arg_5_0.worldBoss = arg_5_1

	arg_5_0:UpdateAwards()
	arg_5_0:Show()

	return
end

function var_0_1.UpdateAwards(arg_6_0)
	local var_6_0 = arg_6_0.worldBoss
	local var_6_1 = var_1.GetAwards(var_6_0)

	local function var_6_2(arg_7_0, arg_7_1)
		local var_7_0 = var_6_1[arg_7_0 + 1]
		local var_7_1 = {
			count = 0,
			type = var_7_0[1],
			id = var_7_0[2]
		}

		updateDrop = var_4

		var_4(arg_7_1:Find("equipment/bg"), var_7_1)

		local var_7_2 = arg_7_1:Find("mask/name")
		local var_7_3 = var_4.GetComponent(var_7_2, "ScrollText")
		local var_7_4 = var_7_1:getConfig("name")

		var_7_3:SetText(var_7_4)

		onButton = var_6

		local var_7_5 = arg_6_0
		local var_7_6 = arg_7_1

		local function var_7_7()
			local var_8_0 = arg_6_0
			local var_8_1 = var_0.emit

			BaseUI = var_3_10002

			var_8_1(var_8_0, var_3_10002.ON_DROP, var_7_1)

			return
		end

		SFX_PANEL = var_2_10010

		var_6(var_7_5, var_7_6, var_7_7, var_2_10010)

		return
	end

	local var_6_3 = arg_6_0.uilist1

	var_4.make(var_6_3, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			var_6_2(arg_9_1, arg_9_2)
		end

		return
	end)

	local var_6_4 = arg_6_0.uilist2

	var_4.make(var_6_4, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			var_6_2(arg_10_1 + 4, arg_10_2)
		end

		return
	end)

	local var_6_5 = arg_6_0.uilist1
	local var_6_6 = var_4.align

	math = var_6

	var_6_6(var_6_5, var_6.min(#var_6_1, 4))

	local var_6_7 = arg_6_0.uilist2
	local var_6_8 = var_4.align

	math = var_6

	var_6_8(var_6_7, var_6.max(0, #var_6_1 - 4))

	return
end

function var_0_1.OnDestroy(arg_11_0)
	return
end

return var_0_1
