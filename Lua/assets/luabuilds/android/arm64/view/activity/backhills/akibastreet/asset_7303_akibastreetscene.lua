local AkibaStreetScene = class("AkibaStreetScene", import("..TemplateMV.BackHillTemplate"))

AkibaStreetScene.UIName = "AkibaStreetUI"
AkibaStreetScene.edge2area = {
	["4_5"] = "_bottom",
	default = "_middle",
	["5_6"] = "_bottom"
}
AkibaStreetScene.Buildings = {
	nil,
	nil,
	nil,
	nil,
	"shudian",
	"youxidian",
	"moxingdian",
	"kafeiting"
}

function AkibaStreetScene:init()
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
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.AkibaGraph"))
	self.usableTxt = self.top:Find("usable_count/text"):GetComponent(typeof(Text))
	self.materialTxt = self.top:Find("material/text"):GetComponent(typeof(Text))

	self:RegisterDataResponse()

	if PLATFORM_CODE ~= PLATFORM_JP then
		setActive(self._upper:Find("shujvhuigu"), false)

		GetOrAddComponent(self._map:Find("shujvhuigu"), typeof(Button)).enabled = false
	end

	return
end

function AkibaStreetScene:RegisterDataResponse()
	self.Respones = ResponsableTree.CreateShell({})

	self.Respones:SetRawData("view", self)

	for iter_2_0, iter_2_1 in ipairs({
		"shudian",
		"youxidian",
		"moxingdian",
		"kafeiting"
	}) do
		self.Respones:AddRawListener({
			"view",
			iter_2_1
		}, function(arg_3_0, arg_3_1)
			if not arg_3_1 then
				return
			end

			arg_3_0.loader:GetSpriteQuiet("ui/AkibaStreetUI_atlas", iter_2_1 .. arg_3_1, arg_3_0["map_" .. iter_2_1])

			if not arg_3_0["upper_" .. iter_2_1] or IsNil(arg_3_0["upper_" .. iter_2_1]:Find("level")) then
				return
			end

			setText(arg_3_0["upper_" .. iter_2_1]:Find("level"), "LV." .. arg_3_1)

			return
		end)
	end

	for iter_2_2, iter_2_3 in ipairs({
		"shudian",
		"youxidian",
		"moxingdian",
		"kafeiting",
		"jiejiting",
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

function AkibaStreetScene:didEnter()
	onButton(self, self._tf:Find("top/return_btn"), function()
		self:emit(AkibaStreetScene.ON_BACK)

		return
	end)
	onButton(self, self.top:Find("daka_count"), function()
		local var_9_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CLIENT_DISPLAY)

		if var_9_0 and not var_9_0:isEnd() then
			self:emit(ThirdAnniversarySquareMediator.GO_SCENE, SCENE.ACTIVITY, {
				id = var_9_0.id
			})
		end

		return
	end)
	onButton(self, self._tf:Find("top/return_main_btn"), function()
		self:emit(AkibaStreetScene.ON_HOME)

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

	self:InitFacilityCross(self._map, self._upper, "jiejiting", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 14)

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
	self.loader:GetPrefab("ui/zhuanzhu_caidai", "zhuanzhu_caidai", function(arg_17_0)
		setParent(arg_17_0, self._map)
		pg.ViewUtils.SetSortingOrder(tf(arg_17_0), GameObject.Find("UICamera/Canvas"):GetComponent(typeof(Canvas)).sortingOrder + 1)

		return
	end)
	pg.UIMgr.GetInstance():OverlayPanel(self.top, false)

	return
end

function AkibaStreetScene:UpdateActivity(arg_18_1)
	self.activity = arg_18_1
	self.Respones.shudian = arg_18_1.data1KeyValueList[2][5] or 1
	self.Respones.youxidian = arg_18_1.data1KeyValueList[2][6] or 1
	self.Respones.moxingdian = arg_18_1.data1KeyValueList[2][7] or 1
	self.Respones.kafeiting = arg_18_1.data1KeyValueList[2][8] or 1
	self.Respones.materialCount = arg_18_1.data1KeyValueList[1][next(arg_18_1.data1KeyValueList[1])] or 0

	self:UpdateView()

	return
end

function AkibaStreetScene:UpdateView()
	self.Respones.shudianTip = self:UpdateBuildingTip(self.activity, 5)
	self.Respones.youxidianTip = self:UpdateBuildingTip(self.activity, 6)
	self.Respones.moxingdianTip = self:UpdateBuildingTip(self.activity, 7)
	self.Respones.kafeitingTip = self:UpdateBuildingTip(self.activity, 8)
	self.Respones.shujvhuiguTip = false

	local var_19_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)
	local var_19_1 = getProxy(MiniGameProxy):GetHubByHubId(var_19_0:getConfig("config_id"))

	self.Respones.jiejitingTip = var_19_1.count > 0

	self:UpdateHubData(var_19_1)

	if not self.InitStudentBegin then
		self:InitStudents(var_19_0.id, 3, 4)

		self.InitStudentBegin = true
	end

	return
end

function AkibaStreetScene:UpdateHubData(arg_20_1)
	self.Respones.hubData.count = arg_20_1.count
	self.Respones.hubData.usedtime = arg_20_1.usedtime
	self.Respones.hubData.id = arg_20_1.id

	self.Respones:PropertyChange("hubData")

	return
end

function AkibaStreetScene:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.top, self._tf)
	self:clearStudents()

	self.Respones = nil

	AkibaStreetScene.super.willExit(self)

	return
end

return AkibaStreetScene
