class = var_0_10000

local var_0_0 = "DailyLevelPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.goBtn = var_1.Find(var_1_0, "bg/goBtn")

	local var_1_1 = arg_1_0._tf

	arg_1_0.levelContant = var_1.Find(var_1_1, "bg/titleText/itemList")

	local var_1_2 = arg_1_0.levelContant

	arg_1_0.itemGO = var_1.Find(var_1_2, "levelItem")
	setText = var_1

	local var_1_3 = arg_1_0._tf
	local var_1_4 = var_3.Find(var_1_3, "bg/titleText")

	i18n = var_4

	var_1(var_1_4, var_4("open_today"))

	setText = var_1

	local var_1_5 = arg_1_0._tf
	local var_1_6 = var_3.Find(var_1_5, "bg/goBtn/Text")

	i18n = var_4

	var_1(var_1_6, var_4("daily_level_go"))

	UIItemList = var_1
	arg_1_0.itemList = var_1.New(arg_1_0.levelContant, arg_1_0.itemGO)

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	onButton = var_1_10001

	var_1_10001(arg_2_0, arg_2_0.goBtn, function()
		pg = var_2_10000

		local var_3_0 = var_2_10000.m02
		local var_3_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_3_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_3_1(var_3_0, var_3_2, var_2_10004.DAILYLEVEL)

		return
	end)

	local var_2_0 = arg_2_0.itemList

	var_1.make(var_2_0, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_2_0.activeList[arg_4_1 + 1]

			setText = var_4

			local var_4_1 = arg_4_2:Find("Text")

			pg = var_2_10007

			var_4(var_4_1, var_2_10007.expedition_daily_template[var_4_0].title)
		end

		return
	end)

	local var_2_1 = arg_2_0.activity

	var_1.SetLoginRedPoint(var_2_1)

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.expedition_daily_template.all
	local var_5_1 = {}

	ipairs = var_1_10003

	for iter_5_0, iter_5_1 in var_1_10003(var_5_0) do
		pg = var_1_10008

		local var_5_2 = var_1_10008.expedition_daily_template[iter_5_1].limit_period

		if var_1_10008.limit_type == 1 then
			table = var_10

			local var_5_3 = var_10.contains
			local var_5_4 = var_1_10008.weekday

			tonumber = var_1_10013
			pg = var_1_10015

			local var_5_5 = var_1_10015.TimeMgr.GetInstance()

			if var_5_3(var_5_4, var_1_10013(var_1_10015.GetServerWeek(var_5_5))) then
				if var_5_2 then
					type = var_10

					if var_10(var_5_2) ~= "table" then
						table = var_10

						var_10.insert(var_5_1, iter_5_1)
					end
				end
			end
		end
	end

	arg_5_0.activeList = var_5_1

	local var_5_6 = arg_5_0.itemList

	var_3.align(var_5_6, #var_5_1)

	return
end

return var_0_1
