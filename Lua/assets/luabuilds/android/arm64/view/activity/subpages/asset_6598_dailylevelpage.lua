local DailyLevelPage = class("DailyLevelPage", import("view.activity.CorePage.CoreActivityPage"))

function DailyLevelPage:OnInit()
	self.goBtn = self._tf:Find("bg/goBtn")
	self.levelContant = self._tf:Find("bg/titleText/itemList")
	self.itemGO = self.levelContant:Find("levelItem")

	setText(self._tf:Find("bg/titleText"), i18n("open_today"))
	setText(self._tf:Find("bg/goBtn/Text"), i18n("daily_level_go"))

	self.itemList = UIItemList.New(self.levelContant, self.itemGO)

	return
end

function DailyLevelPage:OnFirstFlush()
	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.DAILYLEVEL)

		return
	end)
	self.itemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			setText(arg_4_2:Find("Text"), pg.expedition_daily_template[self.activeList[arg_4_1 + 1]].title)
		end

		return
	end)
	self.activity:SetLoginRedPoint()

	return
end

function DailyLevelPage:OnUpdateFlush()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(pg.expedition_daily_template.all) do
		if pg.expedition_daily_template[iter_5_1].limit_type == 1 then
			if table.contains(pg.expedition_daily_template[iter_5_1].weekday, tonumber(pg.TimeMgr.GetInstance():GetServerWeek())) and (not pg.expedition_daily_template[iter_5_1].limit_period or type(pg.expedition_daily_template[iter_5_1].limit_period) ~= "table") then
				table.insert(var_5_0, iter_5_1)
			end
		end
	end

	self.activeList = var_5_0

	self.itemList:align(#var_5_0)

	return
end

return DailyLevelPage
