local ThirdAnniversarySquareScene = class("ThirdAnniversarySquareScene", import("..TemplateMV.BackHillTemplate"))

ThirdAnniversarySquareScene.UIName = "ThirdAnniversarySquareUI"
ThirdAnniversarySquareScene.HUB_ID = 9
ThirdAnniversarySquareScene.edge2area = {
	default = "_middle",
	["3_4"] = "_bottom",
	["4_5"] = "_bottom",
	["7_7"] = "_front"
}
ThirdAnniversarySquareScene.Buildings = {
	"nvpukafeiting",
	"xiaolongbaodian",
	"zhajihanbaodian",
	"heguozidian"
}

function ThirdAnniversarySquareScene:init()
	self.loader = AutoLoader.New()
	self.top = self._tf:Find("top")
	self._map = self._tf:Find("map")

	for iter_1_0 = 0, self._map.childCount - 1 do
		local var_1_0 = self._map:GetChild(iter_1_0)

		self["map_" .. go(var_1_0).name] = var_1_0
	end

	self._upper = self._tf:Find("upper")

	for iter_1_1 = 0, self._upper.childCount - 1 do
		local var_1_1 = self._upper:GetChild(iter_1_1)

		self["upper_" .. go(var_1_1).name] = var_1_1
	end

	self._front = self._map:Find("top")
	self._middle = self._map:Find("middle")
	self._bottom = self._map:Find("bottom")
	self.containers = {
		self._front,
		self._middle,
		self._bottom
	}
	self._shipTpl = self._map:Find("ship")
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.ThirdAnniversarySquareGraph"))
	self.usableTxt = self.top:Find("usable_count/text"):GetComponent(typeof(Text))
	self.materialTxt = self.top:Find("material/text"):GetComponent(typeof(Text))

	self:RegisterDataResponse()

	return
end

function ThirdAnniversarySquareScene:RegisterDataResponse()
	self.Respones = ResponsableTree.CreateShell({})

	self.Respones:SetRawData("view", self)

	for iter_2_0, iter_2_1 in ipairs({
		"xiaolongbaodian",
		"heguozidian",
		"nvpukafeiting",
		"zhajihanbaodian"
	}) do
		self.Respones:AddRawListener({
			"view",
			iter_2_1
		}, function(arg_3_0, arg_3_1)
			if not arg_3_1 then
				return
			end

			arg_3_0.loader:GetSpriteQuiet("ui/thirdanniversarysquareui_atlas", iter_2_1 .. arg_3_1, arg_3_0["map_" .. iter_2_1])

			if not arg_3_0["upper_" .. iter_2_1] or IsNil(arg_3_0["upper_" .. iter_2_1]:Find("level")) then
				return
			end

			setText(arg_3_0["upper_" .. iter_2_1]:Find("level"), "LV." .. arg_3_1)

			return
		end)
	end

	for iter_2_2, iter_2_3 in ipairs({
		"xiaolongbaodian",
		"heguozidian",
		"nvpukafeiting",
		"zhajihanbaodian",
		"gangqvchenlieshi",
		"huanzhuangshandian",
		"shujvhuigu",
		"xianshijianzao"
	}) do
		self.Respones:AddRawListener({
			"view",
			iter_2_3 .. "Tip"
		}, function(arg_4_0, arg_4_1)
			if not arg_4_0["upper_" .. iter_2_3] or IsNil(arg_4_0["upper_" .. iter_2_3]:Find("tip")) then
				return
			end

			setActive(arg_4_0["upper_" .. iter_2_3]:Find("tip"), arg_4_1)

			return
		end)
	end

	self.Respones.hubData = {}

	self.Respones:AddRawListener({
		"view",
		"hubData"
	}, function(arg_5_0, arg_5_1)
		arg_5_0.usableTxt.text = "X" .. arg_5_1.count

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

function ThirdAnniversarySquareScene:didEnter()
	onButton(self, self._tf:Find("top/return_btn"), function()
		self:emit(ThirdAnniversarySquareScene.ON_BACK)

		return
	end)
	onButton(self, self.top:Find("daka_count"), function()
		self:emit(ThirdAnniversarySquareMediator.ON_OPEN_TOWERCLIMBING_SIGNED)

		return
	end)
	onButton(self, self._tf:Find("top/return_main_btn"), function()
		self:emit(ThirdAnniversarySquareScene.ON_HOME)

		return
	end)
	onButton(self, self._tf:Find("top/help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.qingdianguangchang_help.tip
		})

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

	self:InitFacilityCross(self._map, self._upper, "gangqvchenlieshi", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 13)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "shujvhuigu", function()
		self:emit(ThirdAnniversarySquareMediator.GO_SCENE, SCENE.SUMMARY)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "xianshijianzao", function()
		self:emit(ThirdAnniversarySquareMediator.GO_SCENE, SCENE.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "huanzhuangshandian", function()
		self:emit(ThirdAnniversarySquareMediator.GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	pg.UIMgr.GetInstance():OverlayPanel(self.top)

	return
end

function ThirdAnniversarySquareScene:UpdateActivity(arg_17_1)
	self.activity = arg_17_1
	self.Respones.nvpukafeiting = arg_17_1.data1KeyValueList[2][1] or 1
	self.Respones.xiaolongbaodian = arg_17_1.data1KeyValueList[2][2] or 1
	self.Respones.zhajihanbaodian = arg_17_1.data1KeyValueList[2][3] or 1
	self.Respones.heguozidian = arg_17_1.data1KeyValueList[2][4] or 1
	self.Respones.materialCount = arg_17_1.data1KeyValueList[1][next(arg_17_1.data1KeyValueList[1])] or 0

	self:UpdateView()

	return
end

function ThirdAnniversarySquareScene:UpdateView()
	self.Respones.nvpukafeitingTip = self:UpdateBuildingTip(self.activity, 1)
	self.Respones.xiaolongbaodianTip = self:UpdateBuildingTip(self.activity, 2)
	self.Respones.zhajihanbaodianTip = self:UpdateBuildingTip(self.activity, 3)
	self.Respones.heguozidianTip = self:UpdateBuildingTip(self.activity, 4)
	self.Respones.shujvhuiguTip = false

	local var_18_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)
	local var_18_1 = getProxy(MiniGameProxy):GetHubByHubId(var_18_0:getConfig("config_id"))

	self.Respones.gangqvchenlieshiTip = var_18_1.count > 0

	self:UpdateHubData(var_18_1)

	if not self.InitStudentBegin then
		self:InitStudents(var_18_0.id, 2, 3)

		self.InitStudentBegin = true
	end

	return
end

function ThirdAnniversarySquareScene:UpdateHubData(arg_19_1)
	self.Respones.hubData.count = arg_19_1.count
	self.Respones.hubData.usedtime = arg_19_1.usedtime
	self.Respones.hubData.id = arg_19_1.id

	self.Respones:PropertyChange("hubData")

	return
end

function ThirdAnniversarySquareScene:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.top, self._tf)
	self:clearStudents()

	self.Respones = nil

	ThirdAnniversarySquareScene.super.willExit(self)

	return
end

return ThirdAnniversarySquareScene
