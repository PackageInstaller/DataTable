local NewYearFestivalScene2 = class("NewYearFestivalScene2", import("..TemplateMV.BackHillTemplate"))

function NewYearFestivalScene2:getUIName()
	return "NewyearFestivalUI2"
end

NewYearFestivalScene2.edge2area = {
	default = "map_middle",
	["3_4"] = "map_bottom",
	["5_6"] = "map_bottom"
}

function NewYearFestivalScene2:init()
	NewYearFestivalScene2.super.init(self)

	self.top = self._tf:Find("top")
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
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.NewyearFestivalGraph2"))

	local var_2_2 = self._tf:GetComponentInParent(typeof(UnityEngine.Canvas))
	local var_2_3

	if var_2_2 then
		var_2_3 = var_2_2.sortingOrder or 0
	end

	self._map:GetComponent(typeof(UnityEngine.Canvas)).sortingOrder = var_2_3 - 2

	pg.ViewUtils.SetSortingOrder(self._map:Find("xuehezhan_snow01"), var_2_3 - 1)

	return
end

function NewYearFestivalScene2:didEnter()
	onButton(self, self._tf:Find("top/back"), function()
		self:emit(NewYearFestivalScene2.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("top/home"), function()
		self:emit(NewYearFestivalScene2.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_xinnian2021_feast.tip
		})

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.NEWYEAR_SNACKSTREET_MINIGAME)

	self:InitStudents(var_3_0 and var_3_0.id, 3, 4)
	self:InitFacilityCross(self._map, self._upper, "daxuezhang", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 18)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "xiaochijie", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 19)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "qiaozhong", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 20)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "fuzhuangdian", function()
		self:emit(NewYearFestivalMediator.GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "mofang", function()
		self:emit(NewYearFestivalMediator.GO_SCENE, SCENE.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)
	self:UpdateView()

	return
end

function NewYearFestivalScene2:UpdateView()
	setActive(self.upper_daxuezhang:Find("Tip"), NewYearFestivalScene2.IsMiniActNeedTip(ActivityConst.NEWYEAR_SNOWBALL_FIGHT))
	setActive(self.upper_xiaochijie:Find("Tip"), NewYearSnackPage.IsTip())
	setActive(self.upper_qiaozhong:Find("Tip"), NewYearShrineView.IsNeedShowTipWithoutActivityFinalReward())

	return
end

function NewYearFestivalScene2:willExit()
	self:clearStudents()
	NewYearFestivalScene2.super.willExit(self)

	return
end

return NewYearFestivalScene2
