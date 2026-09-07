local BackHillFifthAnniversaryScene = class("BackHillFifthAnniversaryScene", import("..TemplateMV.BackHillTemplate"))

function BackHillFifthAnniversaryScene:getUIName()
	return "BackHillFifthAnniversaryUI"
end

BackHillFifthAnniversaryScene.edge2area = {
	default = "_sdPlace",
	["6_7"] = "_sdPlace2"
}

function BackHillFifthAnniversaryScene:init()
	BackHillFifthAnniversaryScene.super.init(self)

	self.top = self._tf:Find("top")
	self._bg = self._tf:Find("BG")
	self._map = self._tf:Find("map")

	for iter_2_0 = 0, self._map.childCount - 1 do
		local var_2_0 = self._map:GetChild(iter_2_0)

		self["map_" .. go(var_2_0).name] = var_2_0
	end

	self._shipTpl = self._tf:Find("ship")
	self._sdPlace = self._tf:Find("map/SDPlace")
	self._sdPlace2 = self._tf:Find("map/SDPlace2")
	self._upper = self._tf:Find("upper")

	for iter_2_1 = 0, self._upper.childCount - 1 do
		local var_2_1 = self._upper:GetChild(iter_2_1)

		self["upper_" .. go(var_2_1).name] = var_2_1
	end

	self.containers = {
		self._sdPlace,
		self._sdPlace2
	}
	self.usableTxt = self.top:Find("UsableCount/Text"):GetComponent(typeof(Text))
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.BackHillFifthAnniversaryGraph"))

	return
end

function BackHillFifthAnniversaryScene:didEnter()
	onButton(self, self._tf:Find("top/Back"), function()
		self:emit(BackHillFifthAnniversaryScene.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("top/Home"), function()
		self:emit(BackHillFifthAnniversaryScene.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/Invitation"), function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.FIFTH_ANNIVERSARY_INVITATION
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/UsableCount"), function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 40)

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.JIUJIU_DUOMAOMAO_ID)

	self:InitStudents(var_3_0 and var_3_0.id, 3, 4)
	self:InitFacilityCross(self._map, self._upper, "youxidian", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 40)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "kafeiting", function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.ACTIVITY_MAID_DAY
		})

		return
	end)
	setActive(self.map_longpaifangBanner, PLATFORM_CODE == PLATFORM_CH)

	if PLATFORM_CODE == PLATFORM_CH then
		local function var_3_1()
			self:emit(NewYearFestivalMediator.GO_SCENE, SCENE.SUMMARY)

			return
		end

		onButton(self, self.map_longpaifang, var_3_1, SFX_PANEL)
		onButton(self, self.map_longpaifangBanner, var_3_1, SFX_PANEL)
	end

	self:BindItemSkinShop()

	local function var_3_2()
		local var_11_0
		local var_11_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDSHIP_1)
		local var_11_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILD)

		if var_11_1 and not var_11_1:isEnd() then
			var_11_0 = BuildShipScene.PROJECTS.ACTIVITY
		elseif var_11_2 and not var_11_2:isEnd() then
			var_11_0 = ({
				BuildShipScene.PROJECTS.SPECIAL,
				BuildShipScene.PROJECTS.LIGHT,
				BuildShipScene.PROJECTS.HEAVY
			})[var_11_2:getConfig("config_client").id]
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_BUILD,
			projectName = var_11_0
		})

		return
	end

	onButton(self, self.map_xianshijianzao, var_3_2, SFX_PANEL)
	onButton(self, self.map_xianshijianzaoBanner, var_3_2, SFX_PANEL)
	self:UpdateView()

	return
end

function BackHillFifthAnniversaryScene:UpdateView()
	setActive(self.upper_youxidian:Find("Tip"), (function()
		return BackHillTemplate.IsMiniActNeedTip(ActivityConst.JIUJIU_DUOMAOMAO_ID)
	end)())

	local var_12_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.JIUJIU_DUOMAOMAO_ID)
	local var_12_1 = var_12_0 and getProxy(MiniGameProxy):GetHubByHubId(var_12_0:getConfig("config_id"))

	self.usableTxt.text = "X" .. ((var_12_1 or nil) and (var_12_1.count or 0))

	setActive(self.upper_kafeiting:Find("Tip"), (function()
		return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.ACTIVITY_MAID_DAY)))
	end)())
	setActive(self.map_longpaifangBanner:Find("Tip"), (function()
		if PLATFORM_CODE ~= PLATFORM_CH then
			return
		end

		return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SUMMARY)))
	end)())

	return
end

function BackHillFifthAnniversaryScene:IsShowMainTip()
	return (function()
		return BackHillTemplate.IsMiniActNeedTip(ActivityConst.JIUJIU_DUOMAOMAO_ID)
	end)() or (function()
		return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.ACTIVITY_MAID_DAY)))
	end)() or (function()
		if PLATFORM_CODE ~= PLATFORM_CH then
			return
		end

		return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SUMMARY)))
	end)()
end

function BackHillFifthAnniversaryScene:willExit()
	self:clearStudents()
	BackHillFifthAnniversaryScene.super.willExit(self)

	return
end

return BackHillFifthAnniversaryScene
