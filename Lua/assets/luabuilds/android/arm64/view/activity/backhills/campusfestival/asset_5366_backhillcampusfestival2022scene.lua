local BackHillCampusFestival2022Scene = class("BackHillCampusFestival2022Scene", import("..TemplateMV.BackHillTemplate"))

function BackHillCampusFestival2022Scene:getUIName()
	return "BackHillCampusFestivalUI"
end

BackHillCampusFestival2022Scene.edge2area = {
	default = "_SDPlace"
}
BackHillCampusFestival2022Scene.Buildings = {
	[19] = "teachingbuilding",
	[20] = "astrologerstent",
	[21] = "stage",
	[22] = "shoppingstreet"
}

function BackHillCampusFestival2022Scene:init()
	BackHillCampusFestival2022Scene.super.init(self)

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

	setActive(self.map_Decoration, false)

	self._SDPlace = self._map:Find("SDPlace")
	self.containers = {
		self._SDPlace
	}
	self.gameCountTxt = self.top:Find("GameCount/Text"):GetComponent(typeof(Text))
	self.materialTxt = self.top:Find("Material/Text"):GetComponent(typeof(Text))
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.BackHillCampusFestiva2022Graph"))

	return
end

function BackHillCampusFestival2022Scene:didEnter()
	onButton(self, self._tf:Find("top/Back"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("top/Home"), function()
		self:emit(BackHillCampusFestival2022Scene.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.backhill_campusfestival_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/Invitation"), function()
		local var_7_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.INVITATION_JP_FIFTH)

		if var_7_0 and not var_7_0:isEnd() then
			self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.ACTIVITY, {
				id = var_7_0.id
			})
		end

		return
	end)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MINIGAME_CAKEMAKING)

	self:InitStudents(var_3_0 and var_3_0.id, 3, 4)
	self:InitFacilityCross(self._map, self._upper, "cakeshop", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 42)

		return
	end)

	for iter_3_0, iter_3_1 in pairs(self.Buildings) do
		self:InitFacilityCross(self._map, self._upper, iter_3_1, function()
			self:emit(BackHillMediatorTemplate.GO_SUBLAYER, Context.New({
				mediator = BuildingUpgradeMediator,
				viewComponent = BuildingUpgradeLayer,
				data = {
					buildingID = iter_3_0
				}
			}))

			return
		end)
	end

	setActive(self.upper_shujvhuigu, PLATFORM_CODE == PLATFORM_JP)

	if PLATFORM_CODE == PLATFORM_JP then
		self:InitFacilityCross(self._map, self._upper, "shujvhuigu", function()
			self:emit(NewYearFestivalMediator.GO_SCENE, SCENE.SUMMARY)

			return
		end)
	end

	self:BindItemSkinShop()
	self:BindItemBuildShip()
	self:RegisterDataResponse()
	self:UpdateView()

	return
end

function BackHillCampusFestival2022Scene:UpdateActivity(arg_11_1)
	if arg_11_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF then
		self:UpdateView()
	end

	return
end

local var_0_1 = {
	Vector2(-744, -187.3),
	Vector2(-744, -187.3),
	Vector2(-801.7, -149)
}

function BackHillCampusFestival2022Scene:RegisterDataResponse()
	self.Respones = ResponsableTree.CreateShell({})

	self.Respones:SetRawData("view", self)

	local var_12_0 = _.values(self.Buildings)

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		self.Respones:AddRawListener({
			"view",
			iter_12_1
		}, function(arg_13_0, arg_13_1)
			if not arg_13_1 then
				return
			end

			arg_13_0.loader:GetSpriteQuiet("ui/" .. self:getUIName() .. "_atlas", "entrance_" .. iter_12_1 .. arg_13_1, arg_13_0["map_" .. iter_12_1], true)

			if not arg_13_0["upper_" .. iter_12_1] or IsNil(arg_13_0["upper_" .. iter_12_1]:Find("Lv")) then
				return
			end

			setText(arg_13_0["upper_" .. iter_12_1]:Find("Lv"), arg_13_1)

			return
		end)
	end

	self.Respones:AddRawListener({
		"view",
		"stage"
	}, function(arg_14_0, arg_14_1)
		setAnchoredPosition(arg_14_0.map_stage, var_0_1[arg_14_1])

		return
	end)

	local var_12_1 = {
		"cakeshop",
		"shujvhuigu"
	}

	table.insertto(var_12_1, var_12_0)

	for iter_12_2, iter_12_3 in ipairs(var_12_1) do
		self.Respones:AddRawListener({
			"view",
			iter_12_3 .. "Tip"
		}, function(arg_15_0, arg_15_1)
			if not arg_15_0["upper_" .. iter_12_3] or IsNil(arg_15_0["upper_" .. iter_12_3]:Find("Tip")) then
				return
			end

			setActive(arg_15_0["upper_" .. iter_12_3]:Find("Tip"), arg_15_1)

			return
		end)
	end

	self.Respones.hubData = {}

	self.Respones:AddRawListener({
		"view",
		"hubData"
	}, function(arg_16_0, arg_16_1)
		arg_16_0.gameCountTxt.text = "X " .. arg_16_1.count

		return
	end, {
		strict = true
	})
	self.Respones:AddRawListener({
		"view",
		"materialCount"
	}, function(arg_17_0, arg_17_1)
		arg_17_0.materialTxt.text = arg_17_1

		return
	end)

	return
end

function BackHillCampusFestival2022Scene:UpdateView()
	local var_18_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF)

	for iter_18_0, iter_18_1 in pairs(self.Buildings) do
		self.Respones[iter_18_1] = var_18_0.data1KeyValueList[2][iter_18_0] or 1
		self.Respones[iter_18_1 .. "Tip"] = self:UpdateBuildingTip(var_18_0, iter_18_0)
	end

	setActive(self.map_Decoration, (_.all(_.keys(self.Buildings), function(arg_19_0)
		return pg.activity_event_building[arg_19_0] and (var_18_0.data1KeyValueList[2][arg_19_0] or 1) >= #pg.activity_event_building[arg_19_0].buff
	end)))

	self.Respones.materialCount = var_18_0.data1KeyValueList[1][next(var_18_0.data1KeyValueList[1])] or 0
	self.Respones.cakeshopTip = tobool((function()
		return BackHillTemplate.IsMiniActNeedTip(ActivityConst.MINIGAME_CAKEMAKING)
	end)())

	self:UpdateHubData((getProxy(MiniGameProxy):GetHubByHubId(getProxy(ActivityProxy):getActivityById(ActivityConst.MINIGAME_CAKEMAKING):getConfig("config_id"))))

	self.Respones.shujvhuiguTip = tobool((function()
		if PLATFORM_CODE ~= PLATFORM_JP then
			return
		end

		return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SUMMARY)))
	end)())

	return
end

function BackHillCampusFestival2022Scene:UpdateHubData(arg_22_1)
	self.Respones.hubData.count = arg_22_1.count
	self.Respones.hubData.usedtime = arg_22_1.usedtime
	self.Respones.hubData.id = arg_22_1.id

	self.Respones:PropertyChange("hubData")

	return
end

function BackHillCampusFestival2022Scene:IsShowMainTip()
	return (function()
		return BackHillTemplate.IsMiniActNeedTip(ActivityConst.MINIGAME_CAKEMAKING)
	end)() or (function()
		return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF)))
	end)() or (function()
		if PLATFORM_CODE ~= PLATFORM_JP then
			return
		end

		return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SUMMARY)))
	end)()
end

function BackHillCampusFestival2022Scene:willExit()
	self:clearStudents()
	BackHillCampusFestival2022Scene.super.willExit(self)

	return
end

return BackHillCampusFestival2022Scene
