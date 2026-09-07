local SSSSLinkAcademyScene = class("SSSSLinkAcademyScene", import("..TemplateMV.BackHillTemplate"))

function SSSSLinkAcademyScene:getUIName()
	return "SSSSLinkAcademyUI"
end

SSSSLinkAcademyScene.edge2area = {
	default = "map_middle",
	["2_3"] = "map_front",
	["4_5"] = "map_front",
	["2_2"] = "map_front",
	["3_4"] = "map_front"
}

function SSSSLinkAcademyScene:init()
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
		self.map_front,
		self.map_middle
	}
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.SSSSLinkAcademyGraph"))

	return
end

function SSSSLinkAcademyScene:didEnter()
	onButton(self, self._tf:Find("top/return_btn"), function()
		self:emit(SSSSLinkAcademyScene.ON_BACK)

		return
	end)
	onButton(self, self._tf:Find("top/return_main_btn"), function()
		self:emit(SSSSLinkAcademyScene.ON_HOME)

		return
	end)
	onButton(self, self._tf:Find("top/help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.ssss_main_help.tip
		})

		return
	end)
	self:BindItemActivityShop()
	self:BindItemSkinShop()
	self:BindItemBuildShip()
	self:BindItemBattle()

	local var_3_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)

	self:InitStudents(var_3_0 and var_3_0.id, 3, 4)
	self:InitFacilityCross(self._map, self._upper, "xiaoyouxi", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 55)

		return
	end)

	local var_3_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.SSSS_PT)

	self:InitFacilityCross(self._map, self._upper, "huodongye", function()
		local var_8_0 = {}

		var_8_0.id = var_3_1 and var_3_1.id

		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.ACTIVITY, var_8_0)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "jinianzhang", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.SSSS_MEDAL_COLLECTION)

		return
	end)
	onButton(self, self.upper_huoyuehuodong, function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.MONOPOLY_WORLD)

		return
	end)
	self:UpdateView()

	return
end

function SSSSLinkAcademyScene:UpdateView()
	local var_11_0 = getProxy(ActivityProxy)
	local var_11_2 = var_11_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)

	setActive(self.upper_xiaoyouxi:Find("tip"), (SSSSLinkAcademyScene.IsMiniActNeedTip(var_11_2 and var_11_2.id)))

	local var_11_3 = var_11_0:getActivityById(ActivityConst.SSSS_PT)

	setActive(self.upper_huodongye:Find("tip"), var_11_3 and var_11_3:readyToAchieve())
	setActive(self.upper_jinianzhang:Find("tip"), (SSSSLinkAcademyScene.MedalTip()))

	local var_11_4 = var_11_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MONOPOLY)

	setActive(self.upper_huoyuehuodong:Find("tip"), var_11_4 and var_11_4:readyToAchieve())

	return
end

function SSSSLinkAcademyScene:willExit()
	self:clearStudents()

	return
end

function SSSSLinkAcademyScene.MedalTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)))
end

function SSSSLinkAcademyScene:IsShowMainTip()
	local var_14_0 = getProxy(ActivityProxy)

	return (function()
		return Activity.IsActivityReady((var_14_0:getActivityById(ActivityConst.SSSS_PT)))
	end)() or SSSSLinkAcademyScene.MedalTip()() or (function()
		return Activity.IsActivityReady((var_14_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)))
	end)() or (function()
		return Activity.IsActivityReady((var_14_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MONOPOLY)))
	end)()
end

return SSSSLinkAcademyScene
