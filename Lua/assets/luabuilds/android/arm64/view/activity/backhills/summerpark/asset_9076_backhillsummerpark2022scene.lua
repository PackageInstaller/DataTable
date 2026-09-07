local BackHillSummerPark2022Scene = class("BackHillSummerPark2022Scene", import("..TemplateMV.BackHillTemplate"))

function BackHillSummerPark2022Scene:getUIName()
	return "BackHillSummerParkUI"
end

BackHillSummerPark2022Scene.edge2area = {
	default = "_SDPlace"
}

function BackHillSummerPark2022Scene:init()
	BackHillSummerPark2022Scene.super.init(self)

	self.top = self._tf:Find("top")
	self._bg = self._tf:Find("BG")
	self._map = self._tf:Find("map")

	for iter_2_0 = 0, self._map.childCount - 1 do
		local var_2_0 = self._map:GetChild(iter_2_0)

		self["map_" .. go(var_2_0).name] = var_2_0
	end

	self._shipTpl = self._tf:Find("ship")
	self._upper = self._tf:Find("upper")

	for iter_2_1 = 0, self._upper.childCount - 1 do
		local var_2_1 = self._upper:GetChild(iter_2_1)

		self["upper_" .. go(var_2_1).name] = var_2_1
	end

	self._SDPlace = self._tf:Find("SDPlace")
	self.containers = {
		self._SDPlace
	}
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.BackHillSummerParkGraph"))

	return
end

function BackHillSummerPark2022Scene:didEnter()
	onButton(self, self._tf:Find("top/Back"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("top/Home"), function()
		self:emit(BackHillSummerPark2022Scene.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.summerland_tip.tip
		})

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MINIGAME_ICECREAM)

	self:InitStudents(var_3_0 and var_3_0.id, 2, 4)
	self:InitFacilityCross(self._map, self._upper, "bingqilin", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 41)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "qimazhan", function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.ISUZU_SPORTS_SKIN_ID
		})

		return
	end)
	setActive(self.map_shujvhuigu, PLATFORM_CODE == PLATFORM_US)
	setActive(self.upper_shujvhuigu, PLATFORM_CODE == PLATFORM_US)

	if PLATFORM_CODE == PLATFORM_US then
		self:InitFacilityCross(self._map, self._upper, "shujvhuigu", function()
			self:emit(NewYearFestivalMediator.GO_SCENE, SCENE.SUMMARY)

			return
		end)
	end

	self:BindItemSkinShop()
	self:BindItemBuildShip()
	self:UpdateView()

	return
end

function BackHillSummerPark2022Scene:UpdateView()
	setActive(self.upper_bingqilin:Find("Tip"), (function()
		return BackHillTemplate.IsMiniActNeedTip(ActivityConst.MINIGAME_ICECREAM)
	end)())
	setActive(self.upper_qimazhan:Find("Tip"), (function()
		return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.ISUZU_SPORTS_SKIN_ID)))
	end)())
	setActive(self.upper_shujvhuigu:Find("Tip"), (function()
		if PLATFORM_CODE ~= PLATFORM_US then
			return
		end

		return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SUMMARY)))
	end)())

	return
end

function BackHillSummerPark2022Scene:IsShowMainTip()
	return (function()
		return BackHillTemplate.IsMiniActNeedTip(ActivityConst.MINIGAME_ICECREAM)
	end)() or (function()
		return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.ISUZU_SPORTS_SKIN_ID)))
	end)() or (function()
		if PLATFORM_CODE ~= PLATFORM_US then
			return
		end

		return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SUMMARY)))
	end)()
end

function BackHillSummerPark2022Scene:willExit()
	self:clearStudents()
	BackHillSummerPark2022Scene.super.willExit(self)

	return
end

return BackHillSummerPark2022Scene
