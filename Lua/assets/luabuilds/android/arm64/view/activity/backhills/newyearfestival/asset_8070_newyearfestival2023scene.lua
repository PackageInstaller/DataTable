local NewYearFestival2023Scene = class("NewYearFestival2023Scene", import("..TemplateMV.BackHillTemplate"))

NewYearFestival2023Scene.edge2area = {
	default = "map_middle",
	["4_4"] = "map_bottom"
}

function NewYearFestival2023Scene:getUIName()
	return "NewYearFestival2023UI"
end

function NewYearFestival2023Scene:init()
	self.top = self._tf:Find("Top")
	self._map = self._tf:Find("map")

	for iter_2_0 = 0, self._map.childCount - 1 do
		local var_2_0 = self._map:GetChild(iter_2_0)

		self["map_" .. go(var_2_0).name] = var_2_0
	end

	self._shipTpl = self._map:Find("ship")
	self.containers = {
		self.map_middle
	}
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.NewyearFestival2023Graph"))
	self._upper = self._tf:Find("upper")

	for iter_2_1 = 0, self._upper.childCount - 1 do
		local var_2_1 = self._upper:GetChild(iter_2_1)

		self["upper_" .. go(var_2_1).name] = var_2_1
	end

	self.tipTfs = _.map(_.range(self._upper.childCount), function(arg_3_0)
		local var_3_0 = self._upper:GetChild(arg_3_0 - 1)

		return {
			name = var_3_0.name,
			trans = var_3_0:Find("Tip")
		}
	end)

	pg.ViewUtils.SetSortingOrder(self._map:GetChild(self._map.childCount - 1), 1)

	self.loader = AutoLoader.New()

	return
end

function NewYearFestival2023Scene:didEnter()
	onButton(self, self.top:Find("Back"), function()
		self:emit(NewYearFestival2023Scene.ON_BACK)

		return
	end)
	onButton(self, self.top:Find("Home"), function()
		self:emit(NewYearFestival2023Scene.ON_HOME)

		return
	end)
	onButton(self, self.top:Find("Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.resorts_help.tip
		})

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "hotspring", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.HOTSPRING)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "duihuanwu", function()
		local var_9_0 = Context.New()

		SCENE.SetSceneInfo(var_9_0, SCENE.HOTSPRING_SHOP)
		self:emit(BackHillMediatorTemplate.GO_SUBLAYER, var_9_0)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "firework", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 44)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "shrine", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 45)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "fudai", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.HOTSPRING_REDPACKET)

		return
	end)
	self:BindItemBuildShip()
	self:BindItemSkinShop()
	self:InitStudents(ActivityConst.MINIGAME_FIREWORK_VS_SAIREN, 3, 4)
	self:UpdateView()

	return
end

function NewYearFestival2023Scene:UpdateActivity(arg_13_1)
	self:UpdateView()

	return
end

function NewYearFestival2023Scene:UpdateView()
	_.each(self.tipTfs, function(arg_15_0)
		setActive(arg_15_0.trans, tobool((switch(arg_15_0.name, {
			fudai = function()
				return BeachPacketLayer.isShowRedPoint()
			end,
			hotspring = function()
				return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING)))
			end,
			shrine = function()
				return Shrine2023View.IsNeedShowTipWithoutActivityFinalReward()
			end,
			duihuanwu = function()
				return AmusementParkShopPage.GetActivityShopTip()
			end,
			firework = function()
				return BackHillTemplate.IsMiniActNeedTip(ActivityConst.MINIGAME_FIREWORK_VS_SAIREN)
			end
		}, function()
			return false
		end))))

		return
	end)

	return
end

function NewYearFestival2023Scene:IsShowMainTip()
	return _.any(_.values({
		fudai = function()
			return BeachPacketLayer.isShowRedPoint()
		end,
		hotspring = function()
			return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING)))
		end,
		shrine = function()
			return Shrine2023View.IsNeedShowTipWithoutActivityFinalReward()
		end,
		duihuanwu = function()
			return AmusementParkShopPage.GetActivityShopTip()
		end,
		firework = function()
			return BackHillTemplate.IsMiniActNeedTip(ActivityConst.MINIGAME_FIREWORK_VS_SAIREN)
		end
	}), function(arg_28_0)
		return arg_28_0()
	end)
end

function NewYearFestival2023Scene:willExit()
	self:clearStudents()
	NewYearFestival2023Scene.super.willExit(self)

	return
end

return NewYearFestival2023Scene
