local var_0_0 = class("DailyLevelPage", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.goBtn = arg_1_0._tf:Find("bg/goBtn")
	arg_1_0.levelContant = arg_1_0._tf:Find("bg/titleText/itemList")
	arg_1_0.itemGO = arg_1_0.levelContant:Find("levelItem")

	setText(arg_1_0._tf:Find("bg/titleText"), i18n("open_today"))
	setText(arg_1_0._tf:Find("bg/goBtn/Text"), i18n("daily_level_go"))

	arg_1_0.itemList = UIItemList.New(arg_1_0.levelContant, arg_1_0.itemGO)

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.goBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.DAILYLEVEL)

		return
	end)
	arg_2_0.itemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			setText(arg_4_2:Find("Text"), pg.expedition_daily_template[arg_2_0.activeList[arg_4_1 + 1]].title)
		end

		return
	end)
	arg_2_0.activity:SetLoginRedPoint()

	return
end

function var_0_0.OnUpdateFlush(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(pg.expedition_daily_template.all) do
		if pg.expedition_daily_template[iter_5_1].limit_type == 1 then
			local var_5_0 = pg.TimeMgr.GetInstance()

			if table.contains(pg.expedition_daily_template[iter_5_1].weekday, tonumber(var_5_0:GetServerWeek())) and (not pg.expedition_daily_template[iter_5_1].limit_period or type(pg.expedition_daily_template[iter_5_1].limit_period) ~= "table") then
				table.insert({}, iter_5_1)
			end
		end
	end

	arg_5_0.activeList = {}

	arg_5_0.itemList:align(#{})

	return
end

return var_0_0
