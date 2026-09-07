local AmusementParkScene = class("AmusementParkScene", import("..TemplateMV.BackHillTemplate"))

AmusementParkScene.UIName = "AmusementParkUI"
AmusementParkScene.edge2area = {
	default = "map_middle",
	["1_1"] = "map_top"
}
AmusementParkScene.Buildings = {
	[9] = "xuanzhuanmuma",
	[10] = "guoshanche",
	[12] = "haidaochuan",
	[11] = "tiaolouji"
}

function AmusementParkScene:init()
	self.top = self._tf:Find("Top")
	self._map = self._tf:Find("map")

	for iter_1_0 = 0, self._map.childCount - 1 do
		local var_1_0 = self._map:GetChild(iter_1_0)

		self["map_" .. go(var_1_0).name] = var_1_0
	end

	self._shipTpl = self._map:Find("ship")
	self.containers = {
		self.map_middle,
		self.map_top
	}
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.AmusementParkGraph"))
	self._upper = self._tf:Find("upper")

	for iter_1_1 = 0, self._upper.childCount - 1 do
		local var_1_1 = self._upper:GetChild(iter_1_1)

		self["upper_" .. go(var_1_1).name] = var_1_1
	end

	self.gameCountTxt = self.top:Find("GameCount/text"):GetComponent(typeof(Text))
	self.materialTxt = self.top:Find("MaterialCount/text"):GetComponent(typeof(Text))

	setActive(self.map_huiyichengbao, PLATFORM_CODE == PLATFORM_CH)
	setActive(self.upper_huiyichengbao, PLATFORM_CODE == PLATFORM_CH)
	self:RegisterDataResponse()

	self.loader = AutoLoader.New()

	return
end

function AmusementParkScene:RegisterDataResponse()
	self.Respones = ResponsableTree.CreateShell({})

	self.Respones:SetRawData("view", self)

	for iter_2_0, iter_2_1 in ipairs({
		"guoshanche",
		"haidaochuan",
		"xuanzhuanmuma",
		"tiaolouji"
	}) do
		self.Respones:AddRawListener({
			"view",
			iter_2_1
		}, function(arg_3_0, arg_3_1)
			if not arg_3_1 then
				return
			end

			arg_3_0.loader:GetSpriteQuiet("ui/AmusementParkUI_atlas", "entrance_" .. iter_2_1 .. arg_3_1, arg_3_0["map_" .. iter_2_1])

			if not arg_3_0["upper_" .. iter_2_1] or IsNil(arg_3_0["upper_" .. iter_2_1]:Find("Level")) then
				return
			end

			setText(arg_3_0["upper_" .. iter_2_1]:Find("Level"), "LV." .. arg_3_1)

			return
		end)
	end

	for iter_2_2, iter_2_3 in ipairs({
		"guoshanche",
		"haidaochuan",
		"xuanzhuanmuma",
		"tiaolouji",
		"dangaobaoweizhan",
		"jiujiuduihuanwu"
	}) do
		self.Respones:AddRawListener({
			"view",
			iter_2_3 .. "Tip"
		}, function(arg_4_0, arg_4_1)
			if not arg_4_0["upper_" .. iter_2_3] or IsNil(arg_4_0["upper_" .. iter_2_3]:Find("Tip")) then
				return
			end

			setActive(arg_4_0["upper_" .. iter_2_3]:Find("Tip"), arg_4_1)

			return
		end)
	end

	self.Respones.hubData = {}

	self.Respones:AddRawListener({
		"view",
		"hubData"
	}, function(arg_5_0, arg_5_1)
		arg_5_0.gameCountTxt.text = "X" .. arg_5_1.count

		return
	end, {
		strict = true
	})
	self.Respones:AddRawListener({
		"view",
		"materialCount"
	}, function(arg_6_0, arg_6_1)
		arg_6_0.materialTxt.text = arg_6_1

		return
	end)

	return
end

function AmusementParkScene:didEnter()
	onButton(self, self.top:Find("Back"), function()
		self:emit(AmusementParkScene.ON_BACK)

		return
	end)
	onButton(self, self.top:Find("Home"), function()
		self:emit(AmusementParkScene.ON_HOME)

		return
	end)
	onButton(self, self.top:Find("Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.amusementpark_help.tip
		})

		return
	end)
	onButton(self, self.top:Find("Invitation"), function()
		local var_11_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CLIENT_DISPLAY)

		if var_11_0 and not var_11_0:isEnd() then
			self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.ACTIVITY, {
				id = var_11_0.id
			})
		end

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "jiujiuduihuanwu", function()
		self:emit(AmusementParkMediator.GO_SUBLAYER, Context.New({
			mediator = AmusementParkShopMediator,
			viewComponent = AmusementParkShopPage
		}))

		return
	end)

	for iter_7_0, iter_7_1 in pairs(self.Buildings) do
		self:InitFacilityCross(self._map, self._upper, iter_7_1, function()
			self:emit(BackHillMediatorTemplate.GO_SUBLAYER, Context.New({
				mediator = BuildingUpgradeMediator,
				viewComponent = BuildingUpgradeLayer,
				data = {
					buildingID = iter_7_0
				}
			}))

			return
		end)
	end

	self:InitFacilityCross(self._map, self._upper, "dangaobaoweizhan", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 23)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "huiyichengbao", function()
		self:emit(AmusementParkMediator.GO_SCENE, SCENE.SUMMARY)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "xianshijianzao", function()
		self:emit(AmusementParkMediator.GO_SCENE, SCENE.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "huanzhuangshandian", function()
		self:emit(AmusementParkMediator.GO_SCENE, SCENE.SKINSHOP)

		return
	end)

	local var_7_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)

	self:InitStudents(var_7_0 and var_7_0.id, 2, 3)
	self:UpdateView()
	self.loader:LoadPrefab("ui/houshan_caidai", "", function(arg_18_0)
		setParent(arg_18_0, self._map)

		return
	end)

	return
end

function AmusementParkScene:UpdateActivity(arg_19_1)
	self.activity = arg_19_1
	self.Respones.xuanzhuanmuma = arg_19_1.data1KeyValueList[2][9] or 1
	self.Respones.guoshanche = arg_19_1.data1KeyValueList[2][10] or 1
	self.Respones.tiaolouji = arg_19_1.data1KeyValueList[2][11] or 1
	self.Respones.haidaochuan = arg_19_1.data1KeyValueList[2][12] or 1
	self.Respones.materialCount = arg_19_1.data1KeyValueList[1][next(arg_19_1.data1KeyValueList[1])] or 0

	self:UpdateView()

	return
end

function AmusementParkScene:UpdateView()
	self.Respones.xuanzhuanmumaTip = self:UpdateBuildingTip(self.activity, 9)
	self.Respones.guoshancheTip = self:UpdateBuildingTip(self.activity, 10)
	self.Respones.tiaoloujiTip = self:UpdateBuildingTip(self.activity, 11)
	self.Respones.haidaochuanTip = self:UpdateBuildingTip(self.activity, 12)

	local var_20_1 = getProxy(MiniGameProxy):GetHubByHubId(getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME):getConfig("config_id"))

	self.Respones.dangaobaoweizhanTip = var_20_1.count > 0

	self:UpdateHubData(var_20_1)

	self.Respones.jiujiuduihuanwuTip = AmusementParkShopPage.GetActivityShopTip()

	return
end

function AmusementParkScene:UpdateHubData(arg_21_1)
	self.Respones.hubData.count = arg_21_1.count
	self.Respones.hubData.usedtime = arg_21_1.usedtime
	self.Respones.hubData.id = arg_21_1.id

	self.Respones:PropertyChange("hubData")

	return
end

function AmusementParkScene:willExit()
	self:clearStudents()
	AmusementParkScene.super.willExit(self)

	return
end

return AmusementParkScene
