local SummerFeastScene = class("SummerFeastScene", import("view.base.BaseUI"))

function SummerFeastScene:getUIName()
	return "SummerFeastUI"
end

SummerFeastScene.HUB_ID = 1
SummerFeastScene.Elements = {
	[0] = {
		color = "ffffff",
		name = "none"
	},
	{
		color = "ffed95",
		name = "na"
	},
	{
		color = "feb8ff",
		name = "k"
	},
	{
		color = "ad92ff",
		name = "rb"
	},
	{
		color = "affff4",
		name = "zn"
	},
	{
		color = "ffa685",
		name = "ca"
	},
	{
		color = "c1ffa7",
		name = "cu"
	}
}

function SummerFeastScene.GetCurrentDay()
	return pg.TimeMgr.GetInstance():STimeDescS(pg.TimeMgr.GetInstance():GetServerTime(), "*t").yday
end

function SummerFeastScene.GetTheDay()
	return os.date("*t", (os.time({
		hour = 0,
		month = 8,
		year = 2019,
		min = 0,
		sec = 0,
		isdst = false,
		day = 29
	}))).yday
end

function SummerFeastScene:TransformColor()
	return Color.New(tonumber(string.sub(self, 1, 2), 16) / 255, tonumber(string.sub(self, 3, 4), 16) / 255, tonumber(string.sub(self, 5, 6), 16) / 255, ((string.len(self) > 6 and string.len(self) <= 8 or nil) and tonumber(string.sub(self, 7, 8), 16)) / 255)
end

function SummerFeastScene:GenerateRandomFanPosition(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	local var_5_0 = {}

	for iter_5_0 = 1, arg_5_6 do
		table.insert(var_5_0, math.lerp(arg_5_4, arg_5_5, math.random(1, 100) / 100))
	end

	local var_5_1 = math.sin(arg_5_3 / (arg_5_6 - 1))
	local var_5_2 = math.cos(arg_5_3 / (arg_5_6 - 1))
	local var_5_3 = Vector2.Normalize(arg_5_2 - arg_5_1)
	local var_5_4 = {}
	local var_5_5 = var_5_3.x
	local var_5_6 = var_5_3.y

	table.insert(var_5_4, Vector2.New(arg_5_1.x + var_5_0[1] * var_5_3.x, arg_5_1.y + var_5_0[1] * var_5_3.y))

	for iter_5_1 = 2, arg_5_6 do
		var_5_6 = var_5_6 * var_5_2 - var_5_5 * var_5_1
		var_5_5 = var_5_5 * var_5_2 + var_5_6 * var_5_1

		table.insert(var_5_4, Vector2.New(arg_5_1.x + var_5_0[iter_5_1] * var_5_5, arg_5_1.y + var_5_0[iter_5_1] * var_5_6))
	end

	return var_5_4
end

function SummerFeastScene:init()
	self.top = self._tf:Find("top")
	self._closeBtn = self._tf:Find("top/back")
	self._homeBtn = self._tf:Find("top/home")
	self._helpBtn = self._tf:Find("top/help")
	self.ticketTimes = self.top:Find("ticket/text")
	self.yinhuace = self.top:Find("yinhuace")
	self.yinhuaceTimes = self.yinhuace:Find("get")
	self.yinhuaceTips = self.yinhuace:Find("tip")
	self.shouce = self._tf:Find("yinhuashouceye")
	self.shouce_bg = self.shouce:Find("bg")
	self.layout_shouce = self.shouce:Find("yinhuace/go/layout")
	self.group_get = CustomIndexLayer.Clone2Full(self.layout_shouce, 14)
	self.btn_receive = self.shouce:Find("yinhuace/receive")
	self.btn_shouce_help = self.shouce:Find("yinhuace/help")
	self.img_get = self.shouce:Find("yinhuace/get")

	setActive(self.shouce, false)

	self.sakura = self._tf:Find("effect")
	self._map = self._tf:Find("scrollRect/map")
	self.wave = self._map:Find("effect_wave")
	self.shrine = self._map:Find("shrine")
	self.snack_street = self._map:Find("snack_street")
	self.entertainment_street = self._map:Find("entertainment_street")
	self.firework_factory = self._map:Find("firework_factory")
	self.btn_fire = self.firework_factory:Find("fire")
	self.bottom = self._map:Find("bottom")
	self.middle = self._map:Find("middle")
	self.front = self._map:Find("front")
	self._shipTpl = self._map:Find("ship")
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.SummerFeastGraph"))

	pg.PoolMgr.GetInstance():GetPrefab("ui/firework", "", true, function(arg_7_0)
		pg.PoolMgr.GetInstance():ReturnPrefab("ui/firework", "", arg_7_0)

		return
	end)

	self.workingEffect = {}

	return
end

function SummerFeastScene:didEnter()
	local var_8_0 = getProxy(MiniGameProxy)

	onButton(self, self._closeBtn, function()
		self:emit(SummerFeastScene.ON_BACK)

		return
	end)
	onButton(self, self._homeBtn, function()
		self:emit(SummerFeastScene.ON_HOME)

		return
	end)
	onButton(self, self._helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_summer_feast.tip
		})

		return
	end)
	onButton(self, self.yinhuace, function()
		pg.UIMgr.GetInstance():OverlayPanel(self.shouce)
		setActive(self.shouce, true)

		return
	end)
	onButton(self, self.shouce_bg, function()
		pg.UIMgr.GetInstance():UnOverlayPanel(self.shoucem, self._tf)
		setActive(self.shouce, false)

		return
	end)
	onButton(self, self.btn_shouce_help, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_summer_stamp.tip
		})

		return
	end)
	onButton(self, self.btn_receive, function()
		local var_15_0 = var_8_0:GetHubByHubId(self.HUB_ID)

		if var_15_0.ultimate ~= 0 or var_15_0.usedtime < var_15_0:getConfig("reward_need") then
			return
		end

		self:emit(SummerFeastMediator.MINI_GAME_OPERATOR, {
			hubid = var_15_0.id,
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
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 2)

		return
	end)
	self:InitFacility(self.entertainment_street, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 5)

		return
	end)
	self:InitFacility(self.firework_factory, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 4)

		return
	end)
	onButton(self, self.btn_fire, function()
		local var_20_0 = var_8_0:GetMiniGameData(4):GetRuntimeData("elements")

		if not var_20_0 or #var_20_0 < 4 or var_20_0[4] ~= self.GetCurrentDay() then
			return
		end

		self:PlayFirework(var_20_0)
		setActive(self.btn_fire, false)

		return
	end)
	pg.UIMgr.GetInstance():OverlayPanel(self.top)

	self.academyStudents = {}

	self:InitAreaTransFunc()
	self:updateStudents()
	self:UpdateView()

	return
end

function SummerFeastScene:UpdateView()
	local var_21_0 = getProxy(MiniGameProxy)
	local var_21_1 = var_21_0:GetHubByHubId(self.HUB_ID)
	local var_21_2 = var_21_1.usedtime

	setText(self.ticketTimes, var_21_1.count)
	setText(self.yinhuaceTimes, var_21_2)

	for iter_21_0, iter_21_1 in ipairs(self.group_get) do
		setActive(iter_21_1, iter_21_0 <= var_21_2)
	end

	local var_21_3 = var_21_2 >= #self.group_get and var_21_1.ultimate == 0

	setActive(self.btn_receive, var_21_2 >= #self.group_get and var_21_1.ultimate == 0)
	setActive(self.yinhuaceTips, var_21_3)
	setActive(self.img_get, var_21_1.ultimate ~= 0)

	if var_21_1.ultimate == 1 then
		self:TryPlayStory()
	end

	local var_21_4 = var_21_0:GetMiniGameData(4):GetRuntimeData("elements")

	setActive(self.btn_fire, var_21_4 and #var_21_4 >= 4 and var_21_4[4] == self.GetCurrentDay())

	return
end

function SummerFeastScene:InitFacility(arg_22_1, arg_22_2)
	onButton(self, arg_22_1, arg_22_2)
	onButton(self, arg_22_1:Find("button"), arg_22_2)

	return
end

function SummerFeastScene:PlayFirework(arg_23_1)
	if #self.workingEffect > 0 then
		return
	end

	if not arg_23_1 then
		arg_23_1 = {
			0,
			0,
			0
		}

		local var_23_0 = UnityEngine.ParticleSystem.MinMaxGradient.New
	end

	for iter_23_0, iter_23_1 in pairs({
		Vector2(215, 150)
	}) do
		pg.PoolMgr.GetInstance():GetPrefab("ui/firework", "", false, function(arg_24_0)
			tf(arg_24_0):Find("Fire"):GetComponent("ParticleSystem").main.startColor = var_23_0(self.TransformColor(SummerFeastScene.Elements[arg_23_1[1]].color))
			tf(arg_24_0):Find("Fire/par_small"):GetComponent("ParticleSystem").main.startColor = var_23_0(self.TransformColor(SummerFeastScene.Elements[arg_23_1[2]].color))
			tf(arg_24_0):Find("Fire/par_small/par_big"):GetComponent("ParticleSystem").main.startColor = var_23_0(self.TransformColor(SummerFeastScene.Elements[arg_23_1[3]].color))

			table.insert(self.workingEffect, arg_24_0)
			setParent(arg_24_0, self._map)

			arg_24_0.transform.localPosition = iter_23_1

			return
		end)
	end

	self:PlaySE()

	return
end

function SummerFeastScene:ClearEffectFirework()
	self:StopSE()

	local var_25_0 = pg.PoolMgr.GetInstance()

	for iter_25_0, iter_25_1 in pairs(self.workingEffect) do
		var_25_0:ReturnPrefab("ui/firework", "", iter_25_1)
	end

	var_25_0:DestroyPrefab("ui/firework", "")

	self.workingEffect = {}

	return
end

function SummerFeastScene:PlaySE()
	if self.SETimer then
		return
	end

	self.SECount = 10
	self.SETimer = Timer.New(function()
		self.SECount = self.SECount - 1

		if self.SECount <= 0 then
			self.SECount = math.random(5, 20)

			pg.CriMgr.GetInstance():PlaySE_V3("battle-firework")
		end

		return
	end, 0.1, -1)

	self.SETimer:Start()

	return
end

function SummerFeastScene:StopSE()
	if self.SETimer then
		pg.CriMgr.GetInstance():StopSEBattle_V3()
		self.SETimer:Stop()

		self.SETimer = nil
	end

	return
end

function SummerFeastScene:getStudents()
	local var_29_0 = {}
	local var_29_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.SUMMER_FEAST_ID)

	if not var_29_1 then
		return var_29_0
	end

	local var_29_2 = var_29_1:getConfig("config_client")

	var_29_2 = var_29_2 and var_29_2.ships

	if var_29_2 then
		local var_29_3 = Clone(var_29_2)

		while 0 < 15 and #var_29_3 > 0 do
			local var_29_4 = math.random(1, #var_29_3)

			table.insert(var_29_0, var_29_3[var_29_4])

			var_29_3[var_29_4] = var_29_3[#var_29_3]

			local var_29_6 = 0 + math.random(3, 5)
		end
	end

	return var_29_0
end

function SummerFeastScene:InitAreaTransFunc()
	self.edge2area = {
		["1_4"] = self.bottom,
		["1_5"] = self.bottom,
		["4_5"] = self.bottom,
		["3_5"] = self.middle
	}
	self.graphPath.points[5].isBan = true

	return
end

function SummerFeastScene:updateStudents()
	local var_31_0 = self:getStudents()

	for iter_31_0, iter_31_1 in pairs(var_31_0) do
		if not self.academyStudents[iter_31_0] then
			local var_31_1 = cloneTplTo(self._shipTpl, self._map)

			var_31_1.gameObject.name = iter_31_0

			local var_31_2 = SummerFeastNavigationAgent.New(var_31_1.gameObject)

			var_31_2:attach()
			var_31_2:setPathFinder(self.graphPath)
			var_31_2:SetOnTransEdge(function(arg_32_0, arg_32_1, arg_32_2)
				arg_32_2 = math.max(arg_32_1, arg_32_2)
				arg_32_1 = math.min(arg_32_1, arg_32_2)

				arg_32_0._tf:SetParent(self.edge2area[arg_32_1 .. "_" .. arg_32_2] or self.front)

				return
			end)
			var_31_2:updateStudent(iter_31_1)

			self.academyStudents[iter_31_0] = var_31_2
		end
	end

	if #var_31_0 > 0 then
		self.sortTimer = Timer.New(function()
			self:sortStudents()

			return
		end, 0.2, -1)

		self.sortTimer:Start()
		self.sortTimer.func()
	end

	return
end

function SummerFeastScene:sortStudents()
	for iter_34_0, iter_34_1 in pairs({
		self.front,
		self.middle,
		self.bottom
	}) do
		if iter_34_1.childCount > 1 then
			local var_34_0 = {}

			for iter_34_2 = 1, iter_34_1.childCount do
				table.insert(var_34_0, {
					tf = iter_34_1:GetChild(iter_34_2 - 1),
					index = iter_34_2
				})
			end

			table.sort(var_34_0, function(arg_35_0, arg_35_1)
				local var_35_0 = arg_35_0.tf.anchoredPosition.y - arg_35_1.tf.anchoredPosition.y

				if math.abs(arg_35_0.tf.anchoredPosition.y - arg_35_1.tf.anchoredPosition.y) < 1 then
					return arg_35_0.index < arg_35_1.index
				else
					return var_35_0 > 0
				end

				return
			end)

			for iter_34_3, iter_34_4 in ipairs(var_34_0) do
				iter_34_4.tf:SetSiblingIndex(iter_34_3 - 1)
			end
		end
	end

	return
end

function SummerFeastScene:clearStudents()
	if self.sortTimer then
		self.sortTimer:Stop()

		self.sortTimer = nil
	end

	for iter_36_0, iter_36_1 in pairs(self.academyStudents) do
		iter_36_1:detach()
		Destroy(iter_36_1._go)
	end

	self.academyStudents = {}

	return
end

function SummerFeastScene:TryPlayStory()
	if "TIANHOUYUYI2" then
		pg.NewStoryMgr.GetInstance():Play("TIANHOUYUYI2")
	end

	return
end

function SummerFeastScene:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.top, self._tf)

	if isActive(self.shouce) then
		pg.UIMgr.GetInstance():UnOverlayPanel(self.shoucem, self._tf)
		setActive(self.shouce, false)
	end

	self:clearStudents()
	self:ClearEffectFirework()

	return
end

return SummerFeastScene
