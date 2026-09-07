local AmusementParkScene2 = class("AmusementParkScene2", import("..TemplateMV.BackHillTemplate"))

AmusementParkScene2.UIName = "AmusementParkUI2"
AmusementParkScene2.edge2area = {
	default = "map_middle"
}
AmusementParkScene2.Buildings = {
	[16] = "jiujiupubu",
	[15] = "huahuashijie",
	[13] = "jiujiuchonglang",
	[14] = "jiujiutiaoshui"
}

local var_0_1 = 23

function AmusementParkScene2:init()
	self.top = self._tf:Find("Top")
	self._map = self._tf:Find("map")

	for iter_1_0 = 0, self._map.childCount - 1 do
		local var_1_0 = self._map:GetChild(iter_1_0)

		self["map_" .. go(var_1_0).name] = var_1_0
	end

	self._shipTpl = self._map:Find("ship")
	self.containers = {
		self.map_middle
	}
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.AmusementParkGraph2"))
	self._upper = self._tf:Find("upper")

	for iter_1_1 = 0, self._upper.childCount - 1 do
		local var_1_1 = self._upper:GetChild(iter_1_1)

		self["upper_" .. go(var_1_1).name] = var_1_1
	end

	self.gameCountTxt = self.top:Find("GameCount/text"):GetComponent(typeof(Text))
	self.materialTxt = self.top:Find("MaterialCount/text"):GetComponent(typeof(Text))

	if PLATFORM_CODE ~= PLATFORM_JP then
		setActive(self.upper_jinianchengbao, false)

		GetOrAddComponent(self.map_jinianchengbao, typeof(Button)).enabled = false
	end

	self:RegisterDataResponse()

	self.loader = AutoLoader.New()

	return
end

function AmusementParkScene2:RegisterDataResponse()
	self.Respones = ResponsableTree.CreateShell({})

	self.Respones:SetRawData("view", self)

	local var_2_0 = _.values(self.Buildings)

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		self.Respones:AddRawListener({
			"view",
			iter_2_1
		}, function(arg_3_0, arg_3_1)
			if not arg_3_1 then
				return
			end

			arg_3_0.loader:GetSpriteQuiet("ui/AmusementParkUI2_atlas", "entrance_" .. iter_2_1 .. arg_3_1, arg_3_0["map_" .. iter_2_1])

			if not arg_3_0["upper_" .. iter_2_1] or IsNil(arg_3_0["upper_" .. iter_2_1]:Find("Level")) then
				return
			end

			setText(arg_3_0["upper_" .. iter_2_1]:Find("Level"), "LV." .. arg_3_1)

			return
		end)
	end

	local var_2_1 = {
		"jiujiudalaotuan"
	}

	table.insertto(var_2_1, var_2_0)

	for iter_2_2, iter_2_3 in ipairs(var_2_1) do
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

function AmusementParkScene2:didEnter()
	onButton(self, self.top:Find("Back"), function()
		self:emit(AmusementParkScene2.ON_BACK)

		return
	end)
	onButton(self, self.top:Find("Home"), function()
		self:emit(AmusementParkScene2.ON_HOME)

		return
	end)
	onButton(self, self.top:Find("Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.activity_event_building.tip
		})

		return
	end)
	onButton(self, self.top:Find("Invitation"), function()
		local var_11_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.JP_CEREMONY_INVITATION_ID)

		if var_11_0 and not var_11_0:isEnd() then
			self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.ACTIVITY, {
				id = var_11_0.id
			})
		end

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

	self:InitFacilityCross(self._map, self._upper, "jiujiudalaotuan", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 30)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "jinianchengbao", function()
		self:emit(AmusementParkMediator.GO_SCENE, SCENE.SUMMARY)

		return
	end)
	self:BindItemSkinShop()
	self:BindItemBuildShip()

	local var_7_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)

	self:InitStudents(var_7_0 and var_7_0.id, 3, 4)
	self:UpdateView()

	return
end

function AmusementParkScene2:UpdateActivity(arg_15_1)
	self.activity = arg_15_1

	for iter_15_0, iter_15_1 in pairs(self.Buildings) do
		self.Respones[iter_15_1] = arg_15_1.data1KeyValueList[2][iter_15_0] or 1
	end

	self.Respones.materialCount = arg_15_1.data1KeyValueList[1][next(arg_15_1.data1KeyValueList[1])] or 0

	self:UpdateView()

	return
end

function AmusementParkScene2:UpdateView()
	for iter_16_0, iter_16_1 in pairs(self.Buildings) do
		self.Respones[iter_16_1 .. "Tip"] = self:UpdateBuildingTip(self.activity, iter_16_0)
	end

	local var_16_1 = getProxy(MiniGameProxy):GetHubByHubId(var_0_1)

	self.Respones.jiujiudalaotuanTip = var_16_1.count > 0

	self:UpdateHubData(var_16_1)

	return
end

function AmusementParkScene2:UpdateHubData(arg_17_1)
	self.Respones.hubData.count = arg_17_1.count
	self.Respones.hubData.usedtime = arg_17_1.usedtime
	self.Respones.hubData.id = arg_17_1.id

	self.Respones:PropertyChange("hubData")

	return
end

function AmusementParkScene2:willExit()
	self:clearStudents()
	AmusementParkScene2.super.willExit(self)

	return
end

return AmusementParkScene2
