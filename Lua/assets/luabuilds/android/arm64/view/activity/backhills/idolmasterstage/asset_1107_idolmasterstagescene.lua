local IdolMasterStageScene = class("IdolMasterStageScene", import("..TemplateMV.BackHillTemplate"))

function IdolMasterStageScene:getUIName()
	return "IdolMasterStageUI"
end

IdolMasterStageScene.edge2area = {
	default = "map_middle"
}

function IdolMasterStageScene:init()
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
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.IdolMasterStageGraph"))
	self.loader = AutoLoader.New()

	return
end

function IdolMasterStageScene:didEnter()
	onButton(self, self._tf:Find("top/return_btn"), function()
		self:emit(IdolMasterStageScene.ON_BACK)

		return
	end)
	onButton(self, self._tf:Find("top/return_main_btn"), function()
		self:emit(IdolMasterStageScene.ON_HOME)

		return
	end)
	onButton(self, self._tf:Find("top/help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.idolmaster_main.tip
		})

		return
	end)

	local var_3_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)

	self:InitStudents(var_3_0 and var_3_0.id, 2, 3)
	self:InitFacilityCross(self._map, self._upper, "jiujiuwoshouhui", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 24)

		return
	end)

	local var_3_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.IDOL_MASTER_PT_ID)

	self:InitFacilityCross(self._map, self._upper, "leijijiangli", function()
		local var_8_0 = {}

		var_8_0.id = var_3_1 and var_3_1.id

		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.ACTIVITY, var_8_0)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "jinianzhang", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.IDOLMASTER_MEDAL_COLLECTION_SCENE)

		return
	end)
	self:BindItemActivityShop()
	self:BindItemSkinShop()
	self:BindItemBuildShip()
	self:BindItemBattle()
	self:UpdateView()

	return
end

function IdolMasterStageScene:UpdateView()
	local var_10_0 = getProxy(ActivityProxy)
	local var_10_2 = var_10_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)
	local var_10_3 = var_10_2 and getProxy(MiniGameProxy):GetHubByHubId(var_10_2:getConfig("config_id"))

	setActive(self.upper_jiujiuwoshouhui:Find("tip"), var_10_3 and var_10_3.count > 0 or not (var_10_3.usedtime < var_10_3:getConfig("reward_need") or var_10_3.ultimate ~= 0))

	local var_10_5 = var_10_0:getActivityById(ActivityConst.IDOL_MASTER_PT_ID)

	setActive(self.upper_leijijiangli:Find("tip"), var_10_5 and var_10_5:readyToAchieve())
	setActive(self.upper_jinianzhang:Find("tip"), (IdolMasterStageScene.MedalTip()))

	return
end

function IdolMasterStageScene.MedalTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)))
end

function IdolMasterStageScene:willExit()
	self:clearStudents()
	IdolMasterStageScene.super.willExit(self)

	return
end

return IdolMasterStageScene
