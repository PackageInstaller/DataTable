local AnniversaryIsland2023Scene = class("AnniversaryIsland2023Scene", import("view.activity.BackHills.TemplateMV.BackHillTemplate"))

function AnniversaryIsland2023Scene:getUIName()
	return "AnniversaryIsland2023UI"
end

AnniversaryIsland2023Scene.edge2area = {
	default = "_SDPlace"
}
AnniversaryIsland2023Scene.Buildings = {
	[24] = "craft",
	[25] = "adventure",
	[26] = "dining",
	[23] = "living"
}

function AnniversaryIsland2023Scene:Ctor()
	AnniversaryIsland2023Scene.super.Ctor(self)

	self.loader = AutoLoader.New()

	return
end

function AnniversaryIsland2023Scene:preload(arg_3_1)
	self.loader:LoadBundle("ui/" .. self:getUIName() .. "_level" .. self:CalculateSceneLevel(), arg_3_1)

	return
end

function AnniversaryIsland2023Scene:init()
	self.top = self._tf:Find("top")
	self._bg = self._tf:Find("BG")
	self._map = self._tf:Find("map")

	for iter_4_0 = 0, self._map.childCount - 1 do
		local var_4_0 = self._map:GetChild(iter_4_0)

		self["map_" .. go(var_4_0).name] = var_4_0
	end

	self._upper = self._tf:Find("upper")

	for iter_4_1 = 0, self._upper.childCount - 1 do
		local var_4_1 = self._upper:GetChild(iter_4_1)

		self["upper_" .. go(var_4_1).name] = var_4_1
	end

	self._SDPlace = self._tf:Find("SDPlace")
	self.containers = {
		self._SDPlace
	}
	self._shipTpl = self._map:Find("ship")
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.AnniversaryIsland2023Graph"))

	return
end

function AnniversaryIsland2023Scene:didEnter()
	onButton(self, self._tf:Find("top/Back"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("top/Home"), function()
		self:emit(AnniversaryIsland2023Scene.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.haidaojudian_help.tip
		})

		return
	end, SFX_PANEL)

	local var_5_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2)

	self:InitStudents(var_5_0 and var_5_0.id, 3, 4)

	for iter_5_0, iter_5_1 in pairs(self.Buildings) do
		self:InitFacilityCross(self._map, self._upper, iter_5_1, function()
			self:emit(BackHillMediatorTemplate.GO_SUBLAYER, Context.New({
				mediator = AnniversaryIslandBuildingUpgrade2023WindowMediator,
				viewComponent = AnniversaryIslandBuildingUpgrade2023Window,
				data = {
					buildingID = iter_5_0
				}
			}))

			return
		end)
		eachChild(self._map:Find(iter_5_1), function(arg_10_0)
			GetComponent(arg_10_0, typeof(Image)).alphaHitTestMinimumThreshold = 0.5

			setActive(arg_10_0, false)

			return
		end)
	end

	eachChild(self._map:Find("xianshijianzao"), function(arg_11_0)
		GetComponent(arg_11_0, typeof(Image)).alphaHitTestMinimumThreshold = 0.5

		return
	end)
	eachChild(self._map:Find("huanzhuangshangdian"), function(arg_12_0)
		GetComponent(arg_12_0, typeof(Image)).alphaHitTestMinimumThreshold = 0.5

		return
	end)
	eachChild(self._map:Find("taskboard"), function(arg_13_0)
		GetComponent(arg_13_0, typeof(Image)).alphaHitTestMinimumThreshold = 0.5

		return
	end)

	GetComponent(self._map:Find("bigmap"), typeof(Image)).alphaHitTestMinimumThreshold = 0.5

	self:InitFacilityCross(self._map, self._upper, "craft", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.ANNIVERSARY_ISLAND_WORKBENCH)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "taskboard", function()
		local var_15_0 = Context.New()

		SCENE.SetSceneInfo(var_15_0, SCENE.ISLAND_TASK)
		self:emit(BackHillMediatorTemplate.GO_SUBLAYER, var_15_0)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "bigmap", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.ANNIVERSARY_ISLAND_SEA, {
			checkMain = true
		})

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "giftmake", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.SCULPTURE)

		return
	end)
	self:BindItemSkinShop()
	self:BindItemBuildShip()
	self:RegisterDataResponse()
	self:UpdateView()

	return
end

function AnniversaryIsland2023Scene:UpdateActivity(arg_18_1)
	self:UpdateView()

	return
end

function AnniversaryIsland2023Scene:RegisterDataResponse()
	self.Respones = ResponsableTree.CreateShell({})

	self.Respones:SetRawData("view", self)

	local var_19_0 = _.values(self.Buildings)

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		self.Respones:AddRawListener({
			"view",
			iter_19_1
		}, function(arg_20_0, arg_20_1)
			if not arg_20_1 then
				return
			end

			setActive(arg_20_0["map_" .. iter_19_1]:Find(tostring(arg_20_1)), true)

			if arg_20_1 - 1 > 0 then
				setActive(arg_20_0["map_" .. iter_19_1]:Find(tostring(arg_20_1 - 1)), false)
			end

			local var_20_0 = arg_20_0["map_" .. iter_19_1]:Find(tostring(arg_20_1))

			arg_20_0.loader:GetSpriteQuiet("ui/" .. self:getUIName() .. "_atlas", iter_19_1 .. "_" .. arg_20_1, var_20_0, true)

			GetComponent(arg_20_0["map_" .. iter_19_1], typeof(Button)).targetGraphic = GetComponent(var_20_0, typeof(Image))

			if not arg_20_0["upper_" .. iter_19_1] or IsNil(arg_20_0["upper_" .. iter_19_1]:Find("Level")) then
				return
			end

			arg_20_0.loader:GetSpriteQuiet("ui/" .. self:getUIName() .. "_atlas", tostring(arg_20_1), arg_20_0["upper_" .. iter_19_1]:Find("Level"), true)

			return
		end)
	end

	self.Respones:AddRawListener(_.values(self.Buildings), function(...)
		local var_21_0 = 0
		local var_21_1 = {
			...
		}

		for iter_21_0 = 1, table.getCount(self.Buildings) do
			var_21_0 = var_21_0 + (var_21_1[iter_21_0] or 1)
		end

		self.Respones.sceneLevel = math.floor(var_21_0 / 4)

		return
	end)
	self.Respones:AddRawListener({
		"sceneLevel",
		"view"
	}, function(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
		local var_22_0 = arg_22_1[1]
		local var_22_1 = arg_22_1[2]

		local function var_22_2(arg_23_0)
			setActive(var_22_1["map_" .. arg_23_0]:Find(tostring(var_22_0)), true)

			local var_23_0

			if arg_22_2[1] then
				setActive(var_22_1["map_" .. arg_23_0]:Find(tostring(arg_22_2[1])), false)

				var_23_0 = var_22_1["map_" .. arg_23_0]:Find(tostring(var_22_0))
			end

			var_22_1.loader:GetSpriteQuiet("ui/" .. self:getUIName() .. "_level" .. var_22_0, ({
				xianshijianzao = "buildship",
				huanzhuangshangdian = "skinshop",
				taskboard = "taskboard"
			})[arg_23_0], var_23_0, true)

			GetComponent(var_22_1["map_" .. arg_23_0], typeof(Button)).targetGraphic = GetComponent(var_23_0, typeof(Image))

			return
		end

		var_22_2("xianshijianzao")
		var_22_2("huanzhuangshangdian")
		var_22_2("taskboard")
		arg_22_1[2].loader:GetSpriteQuiet("ui/" .. self:getUIName() .. "_atlas", "title_" .. arg_22_1[1], arg_22_1[2]._tf:Find("top/Title/Number"), true)
		arg_22_1[2].loader:GetSpriteQuiet("ui/" .. self:getUIName() .. "_level" .. arg_22_1[1], "bg", arg_22_1[2]._tf:Find("map"))

		return
	end, {
		useOldRef = true
	})

	local var_19_1 = {
		"taskboard",
		"bigmap",
		"giftmake"
	}

	table.insertto(var_19_1, var_19_0)

	for iter_19_2, iter_19_3 in ipairs(var_19_1) do
		self.Respones:AddRawListener({
			"view",
			iter_19_3 .. "Tip"
		}, function(arg_24_0, arg_24_1)
			if not arg_24_0["upper_" .. iter_19_3] or IsNil(arg_24_0["upper_" .. iter_19_3]:Find("Tip")) then
				return
			end

			setActive(arg_24_0["upper_" .. iter_19_3]:Find("Tip"), arg_24_1)

			return
		end)
	end

	self.Respones.hubData = {}

	self.Respones:AddRawListener({
		"view",
		"hubData"
	}, function(arg_25_0, arg_25_1)
		arg_25_0.gameCountTxt.text = "X " .. arg_25_1.count

		return
	end, {
		strict = true
	})
	self.Respones:AddRawListener({
		"view",
		"materialCount"
	}, function(arg_26_0, arg_26_1)
		arg_26_0.materialTxt.text = arg_26_1

		return
	end)

	return
end

function AnniversaryIsland2023Scene.PlayStory()
	local var_27_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2)
	local var_27_1 = var_27_0:GetTotalBuildingLevel()

	table.SerialIpairsAsync({
		false,
		var_27_0:getConfig("config_client").lv2Story,
		var_27_0:getConfig("config_client").lv3Story,
		var_27_0:getConfig("config_client").lv4Story
	}, function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 <= var_27_1 and arg_28_1 then
			pg.NewStoryMgr.GetInstance():Play(arg_28_1, arg_28_2)
		else
			arg_28_2()
		end

		return
	end)

	return
end

function AnniversaryIsland2023Scene:UpdateView()
	AnniversaryIsland2023Scene.PlayStory()

	local var_29_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2)

	for iter_29_0, iter_29_1 in pairs(self.Buildings) do
		self.Respones[iter_29_1] = var_29_0.data1KeyValueList[2][iter_29_0] or 1
		self.Respones[iter_29_1 .. "Tip"] = self:UpdateBuildingTip(var_29_0, iter_29_0)
	end

	local var_29_1 = self.Respones.craftTip

	if not self.Respones.craftTip then
		var_29_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_WORKBENCH):HasAvaliableFormula()
		var_29_1 = var_29_1 and getProxy(SettingsProxy):IsTipWorkbenchDaily()
	end

	self.Respones.craftTip = var_29_1
	self.Respones.bigmapTip = tobool((function()
		return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ISLAND)))
	end)())
	self.Respones.taskboardTip = tobool((function()
		return getProxy(ActivityTaskProxy):getActTaskTip(ActivityConst.ISLAND_TASK_ID)
	end)())
	self.Respones.giftmakeTip = tobool((function()
		return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SCULPTURE)))
	end)())

	return
end

function AnniversaryIsland2023Scene:CalculateSceneLevel()
	return getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2):GetTotalBuildingLevel()
end

function AnniversaryIsland2023Scene:UpdateBuildingTip(arg_34_1, arg_34_2)
	local var_34_0 = AnniversaryIsland2023Scene.super.UpdateBuildingTip(self, arg_34_1, arg_34_2)

	if var_34_0 then
		var_34_0 = var_34_0 and (arg_34_1.data1KeyValueList[2][arg_34_2] or 1) <= arg_34_1:GetTotalBuildingLevel()
	end

	return var_34_0
end

function AnniversaryIsland2023Scene:willExit()
	self:clearStudents()
	AnniversaryIsland2023Scene.super.willExit(self)

	return
end

function AnniversaryIsland2023Scene:IsShowMainTip()
	if self and not self:isEnd() then
		return (function()
			return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ISLAND)))
		end)() or (function()
			local var_38_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2)

			for iter_38_0, iter_38_1 in ipairs(var_38_0:GetBuildingIds()) do
				if AnniversaryIsland2023Scene.UpdateBuildingTip(nil, var_38_0, iter_38_1) then
					return true
				end
			end

			if getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_WORKBENCH):HasAvaliableFormula() then
				if getProxy(SettingsProxy):IsTipWorkbenchDaily() then
					return true
				end
			end

			return
		end)() or (function()
			return getProxy(ActivityTaskProxy):getActTaskTip(ActivityConst.ISLAND_TASK_ID)
		end)() or (function()
			return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SCULPTURE)))
		end)()
	end

	return
end

return AnniversaryIsland2023Scene
