local NewyearFestivalScene = class("NewyearFestivalScene", import("..TemplateMV.BackHillTemplate"))

function NewyearFestivalScene:getUIName()
	return "NewyearFestivalUI"
end

NewyearFestivalScene.HUB_ID = 4

function NewyearFestivalScene:init()
	self.top = self._tf:Find("top")
	self._closeBtn = self._tf:Find("top/back")
	self._homeBtn = self._tf:Find("top/home")
	self._helpBtn = self._tf:Find("top/help")
	self.ticketTimes = self.top:Find("ticket/text")
	self.yinhuace = self.top:Find("sign")
	self.yinhuaceTimes = self.yinhuace:Find("get")
	self.yinhuaceTips = self.yinhuace:Find("tip")
	self.shouce = self._tf:Find("yinhuashouceye")
	self.shouce_bg = self.shouce:Find("bg")
	self.layout_shouce = self.shouce:Find("yinhuace/layout")
	self.group_get = CustomIndexLayer.Clone2Full(self.layout_shouce, 7)
	self.btn_receive = self.shouce:Find("yinhuace/receive")
	self.btn_shouce_help = self.shouce:Find("yinhuace/help")
	self.img_get = self.shouce:Find("yinhuace/get")

	setActive(self.shouce, false)

	self._map = self._tf:Find("map")
	self.shrine = self._map:Find("shrine")
	self.snack_street = self._map:Find("snack")
	self.divination = self._map:Find("divination")
	self.shop = self._map:Find("shop")
	self.cube = self._map:Find("magiccube")
	self.bottom2 = self._map:Find("bottom2")
	self.bottom = self._map:Find("bottom")
	self.middle = self._map:Find("middle")
	self.front = self._map:Find("top")
	self.containers = {
		self.front,
		self.middle,
		self.bottom,
		self.bottom2
	}
	self._shipTpl = self._map:Find("ship")
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.NewyearFestivalGraph"))
	self.effectReq = LoadPrefabRequestPackage.New("ui/xuedichangjing", "xuedichangjing", function(arg_3_0)
		setParent(arg_3_0, self._map, false)

		local var_3_0 = GameObject.Find("UICamera/Canvas")
		local var_3_1 = var_3_0:GetComponent(typeof(Canvas)).sortingOrder

		for iter_3_0, iter_3_1 in ipairs((arg_3_0:GetComponentsInChildren(typeof(Renderer)).ToTable(var_3_0))) do
			iter_3_1.sortingOrder = var_3_1 + 1
		end

		return
	end):Start()

	return
end

function NewyearFestivalScene:didEnter()
	local var_4_0 = getProxy(MiniGameProxy)

	onButton(self, self._closeBtn, function()
		self:emit(NewyearFestivalScene.ON_BACK)

		return
	end)
	onButton(self, self._homeBtn, function()
		self:emit(NewyearFestivalScene.ON_HOME)

		return
	end)
	onButton(self, self._helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_newyear_feast.tip
		})

		return
	end)
	onButton(self, self.yinhuace, function()
		pg.UIMgr.GetInstance():OverlayPanel(self.shouce)
		setActive(self.shouce, true)

		return
	end)
	onButton(self, self.shouce_bg, function()
		pg.UIMgr.GetInstance():UnOverlayPanel(self.shouce, self._tf)
		setActive(self.shouce, false)

		return
	end)
	onButton(self, self.btn_shouce_help, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_newyear_stamp.tip
		})

		return
	end)
	onButton(self, self.btn_receive, function()
		local var_11_0 = var_4_0:GetHubByHubId(self.HUB_ID)

		if var_11_0.ultimate ~= 0 or var_11_0.usedtime < var_11_0:getConfig("reward_need") then
			return
		end

		self:emit(NewYearFestivalMediator.MINI_GAME_OPERATOR, {
			hubid = var_11_0.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})

		return
	end)
	self:InitFacility(self.shrine, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 3)

		return
	end)
	self:InitFacility(self.snack_street, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 8)

		return
	end)
	self:InitFacility(self.divination, function()
		self:emit(NewYearFestivalMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.CYGNET_BATHROBE_PAGE_ID
		})

		return
	end)
	self:InitFacility(self.shop, function()
		self:emit(NewYearFestivalMediator.GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	self:InitFacility(self.cube, function()
		self:emit(NewYearFestivalMediator.GO_SCENE, SCENE.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)
	pg.UIMgr.GetInstance():OverlayPanel(self.top)

	self.academyStudents = {}

	self:InitStudents(ActivityConst.NEWYEAR_ACTIVITY, 3, 5)
	self:UpdateView()

	if self.contextData.isOpenShrine then
		self.contextData.isOpenShrine = nil

		pg.m02:sendNotification(GAME.GO_MINI_GAME, 3)
	end

	local var_4_1 = var_4_0:GetMiniGameData(3)

	if var_4_1 and not var_4_1:GetRuntimeData("isInited") then
		self:emit(NewYearFestivalMediator.MINIGAME_OPERATION, self.HUB_ID, MiniGameOPCommand.CMD_SPECIAL_GAME, {
			3,
			1
		})
	end

	return
end

function NewyearFestivalScene:UpdateView()
	local var_17_0 = getProxy(MiniGameProxy)
	local var_17_1 = var_17_0:GetHubByHubId(self.HUB_ID)
	local var_17_2 = var_17_1.usedtime

	setText(self.ticketTimes, "X " .. var_17_1.count)
	setText(self.yinhuaceTimes, string.format("%02d", var_17_2))

	for iter_17_0, iter_17_1 in ipairs(self.group_get) do
		setActive(iter_17_1, iter_17_0 <= var_17_2)
	end

	local var_17_3 = var_17_2 >= #self.group_get and var_17_1.ultimate == 0

	setActive(self.btn_receive, var_17_2 >= #self.group_get and var_17_1.ultimate == 0)
	setActive(self.yinhuaceTips, var_17_3)
	setActive(self.img_get, var_17_1.ultimate ~= 0)

	local var_17_4

	if var_17_1.ultimate == 1 then
		self:TryPlayStory()

		var_17_4 = setActive
	end

	var_17_4(self.snack_street:Find("tip"), var_17_1.count > 0)

	local var_17_5 = var_17_0:GetMiniGameData(3)

	setActive(self.shrine:Find("tip"), (var_17_5 or nil) and (var_17_5:GetRuntimeData("count") or 0) > 0 and NewYearShrinePage.IsTip())
	setActive(self.divination:Find("tip"), CygnetBathrobePage.IsTip())

	return
end

NewyearFestivalScene.edge2area = {
	["3_8"] = "bottom",
	["7_8"] = "bottom2",
	["5_6"] = "front"
}

function NewyearFestivalScene:TryPlayStory()
	return
end

function NewyearFestivalScene:willExit()
	self.effectReq:Stop()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.top, self._tf)

	if isActive(self.shouce) then
		pg.UIMgr.GetInstance():UnOverlayPanel(self.shouce, self._tf)
		setActive(self.shouce, false)
	end

	self:clearStudents()

	return
end

return NewyearFestivalScene
