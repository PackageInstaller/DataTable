local SpringFestivalBackHill2022Scene = class("SpringFestivalBackHill2022Scene", import("..TemplateMV.BackHillTemplate"))

function SpringFestivalBackHill2022Scene:getUIName()
	return "SpringFestivalBackHill2022UI"
end

SpringFestivalBackHill2022Scene.edge2area = {
	default = "_sdPlace"
}

function SpringFestivalBackHill2022Scene:init()
	SpringFestivalBackHill2022Scene.super.init(self)

	self.top = self._tf:Find("top")
	self._bg = self._tf:Find("BG")
	self._map = self._tf:Find("map")

	for iter_2_0 = 0, self._map.childCount - 1 do
		local var_2_0 = self._map:GetChild(iter_2_0)

		self["map_" .. go(var_2_0).name] = var_2_0
	end

	self._shipTpl = self._tf:Find("ship")
	self._sdPlace = self._tf:Find("SDPlace")
	self._upper = self._tf:Find("upper")

	for iter_2_1 = 0, self._upper.childCount - 1 do
		local var_2_1 = self._upper:GetChild(iter_2_1)

		self["upper_" .. go(var_2_1).name] = var_2_1
	end

	self.containers = {
		self._sdPlace
	}
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.SpringFestival2022Graph"))

	return
end

function SpringFestivalBackHill2022Scene:didEnter()
	onButton(self, self._tf:Find("top/back"), function()
		self:emit(SpringFestivalBackHill2022Scene.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("top/home"), function()
		self:emit(SpringFestivalBackHill2022Scene.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.springfes_tips1.tip
		})

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MINIGAME_SPRINGFESTIVAL_2022)

	self:InitStudents(var_3_0 and var_3_0.id, 3, 3)
	self:InitFacilityCross(self._map, self._upper, "fushundamaoxian", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 37)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "longtenghuyue", function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.ANSHAN_CHANGCHUN_GAIZAO_ID
		})

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "huazhongshijie", function()
		local var_9_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_WORLDINPICTURE)
		local var_9_1

		if not var_9_0 or var_9_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			do return end

			var_9_1 = {}
		end

		var_9_1.id = var_9_0:getConfig("config_client").linkActID

		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, var_9_1)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "huituriji", function()
		self:emit(NewYearFestivalMediator.GO_SCENE, SCENE.COLORING)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "jiulou", function()
		self:emit(NewYearFestivalMediator.GO_SUBLAYER, Context.New({
			mediator = RedPacketMediator,
			viewComponent = RedPacketLayer
		}))

		return
	end)
	self:BindItemSkinShop()
	self:BindItemBuildShip()
	self:UpdateView()

	return
end

function SpringFestivalBackHill2022Scene:UpdateView()
	local var_12_2 = getProxy(ActivityProxy)

	setActive(self.upper_huituriji:Find("Tip"), (getProxy(ColoringProxy):CheckTodayTip()))
	setActive(self.upper_fushundamaoxian:Find("Tip"), (BackHillTemplate.IsMiniActNeedTip(ActivityConst.MINIGAME_SPRINGFESTIVAL_2022)))
	setActive(self.upper_jiulou:Find("Tip"), (RedPacketLayer.isShowRedPoint()))
	setActive(self.upper_huazhongshijie:Find("Tip"), (Activity.IsActivityReady((var_12_2:getActivityByType(ActivityConst.ACTIVITY_TYPE_WORLDINPICTURE)))))
	setActive(self.upper_longtenghuyue:Find("Tip"), (Activity.IsActivityReady((var_12_2:getActivityById(ActivityConst.ANSHAN_CHANGCHUN_GAIZAO_ID)))))

	return
end

function SpringFestivalBackHill2022Scene:willExit()
	self:clearStudents()
	SpringFestivalBackHill2022Scene.super.willExit(self)

	return
end

return SpringFestivalBackHill2022Scene
