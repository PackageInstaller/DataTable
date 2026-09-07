local DOACoreActivityMainPage = class("DOACoreActivityMainPage", import("view.activity.CorePage.Helena.HelenaMainPage"))

function DOACoreActivityMainPage:OnFirstFlush()
	DOACoreActivityMainPage.super.OnFirstFlush(self)
	onButton(self, self.Manual, function()
		self:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = DOAYearHotSpringMediator,
			viewComponent = DOAYearHotSpringScene
		})))

		return
	end)

	return
end

function DOACoreActivityMainPage:updateUI()
	if self.shop_id then
		local var_3_0, var_3_1 = self.timeMgr:inTime(pg.shop_template[self.shop_id].time)
		local var_3_2

		if var_3_1 then
			var_3_2 = DOACoreActivityMainPage:skinCommdityTimeStamps((self.timeMgr:Table2ServerTime(var_3_1)))
		end

		setActive(self.shop_bgtime, var_3_2 and var_3_2 ~= 0)
		setText(self.shop_time, var_3_2)
		onButton(self, self.shop, function()
			if var_3_2 == nil then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end

			self:emit(ActivityMediator.GO_CHANGE_SHOP)

			return
		end)
	end

	local var_3_3, var_3_4 = self.timeMgr:inTime(pg.activity_template[self.activity.id].time)
	local var_3_5

	if var_3_4 then
		var_3_5 = DOACoreActivityMainPage:skinCommdityTimeStamps((self.timeMgr:Table2ServerTime(var_3_4)))
	end

	setActive(self.build_bgtime, var_3_5 and var_3_5 ~= 0)
	setText(self.build_time, i18n("tolovemainpage_build_countdown"))
	onButton(self, self.build, function()
		if var_3_5 == nil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_BUILD,
			projectName = BuildShipScene.PROJECTS.ACTIVITY
		})

		return
	end)
	onButton(self, self.fight, function()
		self:emit(ActivityMediator.SKIP_ACTIVITY_MAP, 6036)

		return
	end)

	return
end

return DOACoreActivityMainPage
