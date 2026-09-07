local NewYearFestival2024Scene = class("NewYearFestival2024Scene", import("view.activity.BackHills.TemplateMV.BackHillTemplate"))

function NewYearFestival2024Scene:getUIName()
	return "NewYearFestival2024UI"
end

NewYearFestival2024Scene.edge2area = {
	default = "_SDPlace"
}

function NewYearFestival2024Scene:init()
	NewYearFestival2024Scene.super.init(self)

	self.top = self._tf:Find("top")
	self._bg = self._tf:Find("BG")
	self._map = self._tf:Find("map")

	for iter_2_0 = 0, self._map.childCount - 1 do
		local var_2_0 = self._map:GetChild(iter_2_0)

		self["map_" .. go(var_2_0).name] = var_2_0
	end

	self._upper = self._tf:Find("upper")

	for iter_2_1 = 0, self._upper.childCount - 1 do
		local var_2_1 = self._upper:GetChild(iter_2_1)

		self["upper_" .. go(var_2_1).name] = var_2_1
	end

	self._SDPlace = self._tf:Find("SDPlace")
	self.containers = {
		self._SDPlace
	}
	self._shipTpl = self._map:Find("ship")
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.NewyearFestival2024Graph"))

	return
end

function NewYearFestival2024Scene:didEnter()
	onButton(self, self._tf:Find("top/Back"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("top/Home"), function()
		self:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.newyear2024_backhill_help.tip
		})

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MINIGAME_COOKGAME2_ID)

	self:InitStudents(var_3_0 and var_3_0.id, 2, 3)
	self:InitFacilityCross(self._map, self._upper, "nvpudian", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 60)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "huimaqiyuan", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 62)

		return
	end)
	self:BindItemSkinShop()
	self:BindItemBuildShip()
	self:UpdateView()

	return
end

function NewYearFestival2024Scene:UpdateView()
	setActive(self.upper_nvpudian:Find("Tip"), NewYearFestival2024Scene.MiniGameTip())
	setActive(self.upper_huimaqiyuan:Find("Tip"), NewYearFestival2024Scene.ShrineTip())

	return
end

function NewYearFestival2024Scene.ShrineTip()
	return Shrine2024View.IsNeedShowTipWithoutActivityFinalReward()
end

function NewYearFestival2024Scene.MiniGameTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.MINIGAME_COOKGAME2_ID)))
end

function NewYearFestival2024Scene:willExit()
	self:clearStudents()
	NewYearFestival2024Scene.super.willExit(self)

	return
end

function NewYearFestival2024Scene:IsShowMainTip()
	if self and not self:isEnd() then
		return NewYearFestival2024Scene.MiniGameTip() or NewYearFestival2024Scene.ShrineTip()
	end

	return
end

return NewYearFestival2024Scene
