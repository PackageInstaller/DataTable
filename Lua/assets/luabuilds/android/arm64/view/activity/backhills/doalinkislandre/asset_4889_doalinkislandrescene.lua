local DOALinkIslandReScene = class("DOALinkIslandReScene", import("..TemplateMV.BackHillTemplate"))

function DOALinkIslandReScene:getUIName()
	return "DOALinkIslandReUI"
end

DOALinkIslandReScene.edge2area = {
	default = "map_middle",
	["2_2"] = "map_bridge"
}

function DOALinkIslandReScene:init()
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
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.DOAIslandGraph"))

	local var_2_2 = self._tf:GetComponentInParent(typeof(UnityEngine.Canvas))
	local var_2_3 = var_2_2 and var_2_2.sortingOrder

	self._map:GetComponent(typeof(UnityEngine.Canvas)).sortingOrder = (var_2_2 and var_2_2.sortingOrder) - 3
	self.map_tebiezuozhan:GetComponent(typeof(UnityEngine.Canvas)).sortingOrder = var_2_3 - 1
	self.map_bridge:GetComponent(typeof(UnityEngine.Canvas)).sortingOrder = var_2_3 - 1

	pg.ViewUtils.SetSortingOrder(self._map:Find("DOAhoushan_hailang"), var_2_3 - 2)

	self.mgProxy = getProxy(MiniGameProxy)
	self.loader = AutoLoader.New()

	return
end

function DOALinkIslandReScene:didEnter()
	onButton(self, self._tf:Find("top/return_btn"), function()
		self:emit(DOALinkIslandReScene.ON_BACK)

		return
	end)
	onButton(self, self._tf:Find("top/return_main_btn"), function()
		self:emit(DOALinkIslandReScene.ON_HOME)

		return
	end)
	onButton(self, self._tf:Find("top/help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.doa_main.tip
		})

		return
	end)
	self:InitStudents(ActivityConst.MINIGAME_VOLLEYBALL, 2, 3)

	local var_3_0 = self:GetDOA2MiniGameId(ActivityConst.MINIGAME_VOLLEYBALL)

	self:InitFacilityCross(self._map, self._upper, "shatanpaiqiu", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_3_0)

		return
	end)

	local var_3_1 = self:GetDOA2MiniGameId(ActivityConst.MINIGAME_PENGPENGDONG)

	onButton(self, self._upper:Find("pengpengdong"), function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_3_1)

		return
	end, SFX_PANEL)
	self:InitFacilityCross(self._map, self._upper, "daoyvjianshe", function()
		self:emit(DOALinkIslandReMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.DOA_PT_ID
		})

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "bujishangdian", function()
		self:emit(DOALinkIslandReMediator.GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "huanzhuangshangdian", function()
		self:emit(DOALinkIslandReMediator.GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "xianshijianzao", function()
		self:emit(DOALinkIslandReMediator.GO_SCENE, SCENE.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "jinianzhang", function()
		self:emit(DOALinkIslandReMediator.GO_SCENE, SCENE.DOA2_MEDAL_COLLECTION_SCENE)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "tebiezuozhan", function()
		local var_14_0 = getProxy(ChapterProxy)
		local var_14_1, var_14_2 = var_14_0:getLastMapForActivity(pg.activity_template[ActivityConst.DOA_PT_ID].config_client.fightLinkActID)

		if var_14_1 then
			if not var_14_0:getMapById(var_14_1):isUnlock() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				goto label_14_0
			end
		end

		self:emit(DOALinkIslandReMediator.GO_SCENE, SCENE.LEVEL, {
			chapterId = var_14_2,
			mapIdx = var_14_1
		})

		::label_14_0::

		return
	end)
	self:UpdateView()

	return
end

function DOALinkIslandReScene:UpdateView()
	local var_15_0 = getProxy(ActivityProxy)

	setActive(self.upper_shatanpaiqiu:Find("tip"), DOALinkIslandReScene.IsMiniActNeedTip(ActivityConst.MINIGAME_VOLLEYBALL))
	setActive(self.upper_pengpengdong:Find("tip"), DOALinkIslandReScene.IsMiniActNeedTip(ActivityConst.MINIGAME_PENGPENGDONG))

	local var_15_2 = var_15_0:getActivityById(ActivityConst.MINIGAME_VOLLEYBALL)

	assert(var_15_2)

	local var_15_3 = getProxy(MiniGameProxy):GetHubByHubId(var_15_2:getConfig("config_id"))

	assert(var_15_3)
	self.loader:GetSpriteQuiet("ui/DOALinkIslandUI_atlas", tostring(var_15_3.usedtime or 0), self.map_shatanpaiqiu:Find("Digit"), true)

	local var_15_4 = var_15_0:getActivityById(ActivityConst.DOA_PT_ID)

	assert(var_15_4)
	setActive(self.upper_daoyvjianshe:Find("tip"), var_15_4 and var_15_4:readyToAchieve())
	setActive(self.upper_jinianzhang:Find("tip"), (DOALinkIslandReScene.MedalTip()))

	return
end

function DOALinkIslandReScene:willExit()
	self:clearStudents()
	DOALinkIslandReScene.super.willExit(self)

	return
end

function DOALinkIslandReScene.MedalTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)))
end

function DOALinkIslandReScene:IsShowMainTip()
	if self and not self:isEnd() then
		local var_18_0 = getProxy(ActivityProxy)

		return (function()
			local var_19_0 = var_18_0:getActivityById(ActivityConst.DOA_PT_ID)

			return var_19_0 and not var_19_0:isEnd() and var_19_0:readyToAchieve()
		end)() or DOALinkIslandReScene.MedalTip() or (function()
			return DOALinkIslandReScene.IsMiniActNeedTip(ActivityConst.MINIGAME_VOLLEYBALL)
		end)() or (function()
			return DOALinkIslandReScene.IsMiniActNeedTip(ActivityConst.MINIGAME_PENGPENGDONG)
		end)()
	end

	return
end

function DOALinkIslandReScene:GetDOA2MiniGameId(arg_22_1)
	if not pg.activity_template[arg_22_1] then
		error("未找到对应DOA活动ID")

		return nil
	end

	local var_22_0 = pg.activity_template[arg_22_1].config_id

	for iter_22_0 = #pg.mini_game.all, 1, -1 do
		if pg.mini_game[pg.mini_game.all[iter_22_0]] and pg.mini_game[pg.mini_game.all[iter_22_0]].hub_id == var_22_0 then
			return pg.mini_game.all[iter_22_0]
		end
	end

	error("未找到对应DOA活动的miniGameID")

	return nil
end

return DOALinkIslandReScene
