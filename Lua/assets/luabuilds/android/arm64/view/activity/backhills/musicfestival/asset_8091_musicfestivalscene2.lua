local MusicFestivalScene2 = class("MusicFestivalScene2", import("..TemplateMV.BackHillTemplate"))

function MusicFestivalScene2:getUIName()
	return "MusicFestivalUI2"
end

MusicFestivalScene2.edge2area = {
	default = "_middle"
}

function MusicFestivalScene2:init()
	self.top = self._tf:Find("top")
	self._map = self._tf:Find("map")

	for iter_2_0 = 0, self._map.childCount - 1 do
		local var_2_0 = self._map:GetChild(iter_2_0)

		self["map_" .. go(var_2_0).name] = var_2_0
	end

	self._stageShip = self._map:Find("stageship")
	self._shipTpl = self._map:Find("ship")
	self._upper = self._tf:Find("upper")

	for iter_2_1 = 0, self._upper.childCount - 1 do
		local var_2_1 = self._upper:GetChild(iter_2_1)

		self["upper_" .. go(var_2_1).name] = var_2_1
	end

	self.modelTip = self.upper_model:Find("tip")

	setActive(self.modelTip, false)

	self._middle = self._map:Find("middle")
	self.containers = {
		self._middle
	}
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.MusicFestivalGraph2"))

	local var_2_2 = self._tf:GetComponentInParent(typeof(UnityEngine.Canvas))

	self._map:GetComponent(typeof(UnityEngine.Canvas)).sortingOrder = (var_2_2 and var_2_2.sortingOrder) - 2
	self.loader = AutoLoader.New()

	return
end

function MusicFestivalScene2:didEnter()
	onButton(self, self._tf:Find("top/return_btn"), function()
		self:emit(MusicFestivalScene2.ON_BACK)

		return
	end)
	onButton(self, self._tf:Find("top/return_main_btn"), function()
		self:emit(MusicFestivalScene2.ON_HOME)

		return
	end)
	onButton(self, self._tf:Find("top/help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.music_main.tip
		})

		return
	end)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MUSIC_FESTIVAL_ID_2)

	self:InitStudents(var_3_0 and var_3_0.id, 3, 4)
	onButton(self, self.upper_model, function()
		self:emit(MusicFestivalMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = var_3_0.id
		})

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "jichangwutai", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 16)

		return
	end)

	local var_3_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PT_BUFF)

	self:InitFacilityCross(self._map, self._upper, "leijipt", function()
		self:emit(MusicFestivalMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = var_3_1.id
		})

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "bujishangdian", function()
		self:emit(MusicFestivalMediator.GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "huangzhuangshangdian", function()
		self:emit(MusicFestivalMediator.GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "xianshijianzao", function()
		self:emit(MusicFestivalMediator.GO_SCENE, SCENE.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "jinianzhang", function()
		self:emit(MusicFestivalMediator.GO_SUBLAYER, (Context.New({
			mediator = IdolMedalCollectionMediator,
			viewComponent = IdolMedalCollectionView2
		})))

		return
	end)
	self:BindItemBattle()
	self:updateStageShip()
	self:UpdateView()

	return
end

function MusicFestivalScene2:UpdateView()
	local var_14_0 = getProxy(ActivityProxy)
	local var_14_2 = getProxy(MiniGameProxy):GetHubByHubId(var_14_0:getActivityById(ActivityConst.MUSIC_FESTIVAL_ID_2):getConfig("config_id"))

	setActive(self.upper_jichangwutai:Find("tip"), var_14_2.count > 0)
	setActive(self.modelTip, var_14_2.usedtime >= var_14_2:getConfig("reward_need") and var_14_2.ultimate == 0)
	setActive(self.upper_leijipt:Find("tip"), (var_14_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_PT_BUFF):readyToAchieve()))
	setActive(self.upper_jinianzhang:Find("tip"), (MusicFestivalScene2.MedalTip()))

	return
end

function MusicFestivalScene2:getStageShip()
	local var_15_0 = getProxy(ActivityProxy)
	local var_15_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.MUSIC_FESTIVAL_ID_2)

	if not var_15_1 then
		return
	end

	local var_15_2 = var_15_1:getConfig("config_client")
	local var_15_3 = var_15_2 and var_15_2.stage_on_ship

	if var_15_2 and var_15_2.stage_on_ship then
		return var_15_3[math.random(1, #var_15_3)], var_15_3.action[1]
	end

	return
end

function MusicFestivalScene2:updateStageShip()
	local var_16_0, var_16_1 = self:getStageShip()

	if not var_16_0 then
		return
	end

	self.loader:GetSpine(var_16_0, function(arg_17_0)
		arg_17_0:SetLocalScale(Vector3(0.63, 0.63, 1))
		arg_17_0:SetLocalPosition(Vector3.zero)
		arg_17_0:SetParent(self._stageShip)
		arg_17_0:SetSiblingIndex(1)
		setActive(self._stageShip, true)
		arg_17_0:SetAction(var_16_1, 0)

		return
	end, self._stageShip)

	return
end

function MusicFestivalScene2:getStudents(arg_18_1, arg_18_2)
	local var_18_0 = {}
	local var_18_1 = getProxy(ActivityProxy):getActivityById(self)

	if not var_18_1 then
		return var_18_0
	end

	local var_18_2 = var_18_1:getConfig("config_client")

	var_18_2 = var_18_2 and var_18_2.stage_off_ship

	if var_18_2 then
		local var_18_3 = Clone(var_18_2)
		local var_18_4 = math.random(arg_18_1, arg_18_2)

		while var_18_4 > 0 and #var_18_3 > 0 do
			local var_18_5 = math.random(1, #var_18_3)

			table.insert(var_18_0, var_18_3[var_18_5])

			var_18_3[var_18_5] = var_18_3[#var_18_3]
			var_18_4 = var_18_4 - 1
		end
	end

	return var_18_0
end

function MusicFestivalScene2.MedalTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)))
end

function MusicFestivalScene2:IsShowMainTip()
	local var_20_0 = getProxy(ActivityProxy)
	local var_20_1 = var_20_0:getActivityById(ActivityConst.MUSIC_FESTIVAL_ID_2)

	assert(var_20_1)

	return (function()
		local var_21_0 = var_20_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_PT_BUFF)

		return var_21_0 and not var_21_0:isEnd() and var_21_0:readyToAchieve()
	end)() or MusicFestivalScene2.MedalTip() or (function()
		local var_22_0 = getProxy(MiniGameProxy):GetHubByHubId(var_20_1:getConfig("config_id"))

		return var_22_0.usedtime >= var_22_0:getConfig("reward_need") and var_22_0.ultimate == 0
	end)() or (function()
		return getProxy(MiniGameProxy):GetHubByHubId(var_20_1:getConfig("config_id")).count > 0
	end)()
end

function MusicFestivalScene2:willExit()
	self:clearStudents()
	MusicFestivalScene2.super.willExit(self)

	return
end

return MusicFestivalScene2
