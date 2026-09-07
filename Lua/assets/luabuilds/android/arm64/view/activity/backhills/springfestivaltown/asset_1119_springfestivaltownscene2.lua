local SpringFestivalTownScene2 = class("SpringFestivalTownScene2", import("..TemplateMV.BackHillTemplate"))

function SpringFestivalTownScene2:getUIName()
	return "SpringFestivalTownUI2"
end

SpringFestivalTownScene2.edge2area = {
	default = "map_middle"
}

function SpringFestivalTownScene2:init()
	SpringFestivalTownScene2.super.init(self)

	self.top = self._tf:Find("top")
	self._bg = self._tf:Find("BG")
	self._map = self._tf:Find("map")

	for iter_2_0 = 0, self._map.childCount - 1 do
		local var_2_0 = self._map:GetChild(iter_2_0)

		self["map_" .. go(var_2_0).name] = var_2_0
	end

	self._shipTpl = self._map:Find("ship")
	self._upper = self._tf:Find("upper")

	for iter_2_1 = 0, self._upper.childCount - 1 do
		local var_2_1 = self._upper:GetChild(iter_2_1)

		self["upper_" .. go(var_2_1).name] = var_2_1
	end

	self.containers = {
		self.map_middle
	}
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.SpringFestivalTownGraph2"))

	local var_2_2 = self._tf:GetComponentInParent(typeof(UnityEngine.Canvas))

	self._bg:GetComponent(typeof(UnityEngine.Canvas)).sortingOrder = ((var_2_2 or nil) and (var_2_2.sortingOrder or 0)) - 2

	return
end

function SpringFestivalTownScene2:didEnter()
	onButton(self, self._tf:Find("top/back"), function()
		self:emit(SpringFestivalTownScene2.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("top/home"), function()
		self:emit(SpringFestivalTownScene2.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_chunjie2021_feast.tip
		})

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.SPRING_FES_MINIGAME_SECOND)

	self:InitStudents(var_3_0 and var_3_0.id, 2, 3)
	self:InitFacilityCross(self._map, self._upper, "damaoxian", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 21)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "chunyouji", function()
		local var_8_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MONOPOLY)

		self:emit(NewYearFestivalMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = var_8_0 and var_8_0.id
		})

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "huituriji", function()
		self:emit(NewYearFestivalMediator.GO_SCENE, SCENE.COLORING)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "dajiulou", function()
		self:emit(NewYearFestivalMediator.GO_SUBLAYER, Context.New({
			mediator = RedPacketMediator,
			viewComponent = RedPacketLayer
		}))

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "fuzhuang", function()
		self:emit(NewYearFestivalMediator.GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "jianzao", function()
		self:emit(NewYearFestivalMediator.GO_SCENE, SCENE.GETBOAT, {
			page = 1,
			projectName = BuildShipScene.PROJECTS.LIGHT
		})

		return
	end)
	self:UpdateView()

	return
end

function SpringFestivalTownScene2:UpdateView()
	local var_13_1 = getProxy(ActivityProxy)
	local var_13_2 = getProxy(MiniGameProxy)

	setActive(self.upper_huituriji:Find("Tip"), (getProxy(ColoringProxy):CheckTodayTip()))
	setActive(self.upper_dajiulou:Find("Tip"), (RedPacketLayer.isShowRedPoint()))

	local var_13_3 = var_13_1:getActivityByType(ActivityConst.ACTIVITY_TYPE_MONOPOLY)

	setActive(self.upper_chunyouji:Find("Tip"), nil and not (nil):isEnd() and (nil):readyToAchieve())

	local var_13_4 = var_13_1:getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)

	setActive(self.upper_damaoxian:Find("Tip"), nil and not (nil):isEnd() and (nil):readyToAchieve())

	return
end

function SpringFestivalTownScene2:willExit()
	self:clearStudents()
	SpringFestivalTownScene2.super.willExit(self)

	return
end

return SpringFestivalTownScene2
