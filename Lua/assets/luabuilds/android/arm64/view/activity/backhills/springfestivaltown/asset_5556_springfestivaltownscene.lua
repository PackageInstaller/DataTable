local SpringFestivalTownScene = class("SpringFestivalTownScene", import("..TemplateMV.BackHillTemplate"))

function SpringFestivalTownScene:getUIName()
	return "SpringFestivalTownUI"
end

function SpringFestivalTownScene:getBGM()
	return "story-china"
end

SpringFestivalTownScene.HUB_ID = 5
SpringFestivalTownScene.edge2area = {
	default = "_middle",
	["9_9"] = "_bottom",
	["4_4"] = "_front"
}

function SpringFestivalTownScene:init()
	self.top = self._tf:Find("top")
	self._closeBtn = self._tf:Find("top/return_btn")
	self._homeBtn = self._tf:Find("top/return_main_btn")
	self._helpBtn = self._tf:Find("top/help_btn")
	self._map = self._tf:Find("map")

	for iter_3_0 = 0, self._map.childCount - 1 do
		local var_3_0 = self._map:GetChild(iter_3_0)

		self["_" .. go(var_3_0).name] = var_3_0
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
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.SpringFestivalTownGraph"))
	self._upper = self._tf:Find("upper")
	self.usableTxt = self.top:Find("usable_count/Text"):GetComponent(typeof(Text))
	self.diedieleTF = self.top:Find("diediele_count")
	self.diedieleTxt = self.diedieleTF:Find("Text"):GetComponent(typeof(Text))
	self.effectReq = LoadPrefabRequestPackage.New("ui/map_donghuangchunjie", "map_donghuangchunjie", function(arg_4_0)
		setParent(arg_4_0, self._map, false)

		local var_4_0 = GameObject.Find("UICamera/Canvas")
		local var_4_1 = var_4_0:GetComponent(typeof(Canvas)).sortingOrder

		for iter_4_0, iter_4_1 in ipairs((arg_4_0:GetComponentsInChildren(typeof(Renderer)).ToTable(var_4_0))) do
			iter_4_1.sortingOrder = var_4_1 + 1
		end

		self.mapeffect = arg_4_0

		return
	end):Start()

	self:managedTween(LeanTween.value, nil, go(self._map), System.Action_UnityEngine_Color(function(arg_5_0)
		go(self._map):GetComponent(typeof(Image)).material:SetColor("_Color", arg_5_0)

		return
	end), Color(0, 0, 0, 0), Color(1, 1, 0, 0), 1.5):setLoopPingPong(-1)

	return
end

function SpringFestivalTownScene:didEnter()
	local var_6_0 = getProxy(MiniGameProxy)

	onButton(self, self._closeBtn, function()
		self:emit(SpringFestivalTownScene.ON_BACK)

		return
	end)
	onButton(self, self.diedieleTF, function()
		self:emit(NewYearFestivalMediator.ON_OPEN_PILE_SIGNED)

		return
	end)
	onButton(self, self._homeBtn, function()
		self:emit(SpringFestivalTownScene.ON_HOME)

		return
	end)
	onButton(self, self._helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_chunjie_feast.tip
		})

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "kaihongbao", function()
		self:emit(NewYearFestivalMediator.GO_SUBLAYER, Context.New({
			mediator = RedPacketMediator,
			viewComponent = RedPacketLayer,
			onRemoved = function()
				if self.mapeffect then
					setActive(self.mapeffect, true)
				end

				return
			end
		}), function()
			if self.mapeffect then
				setActive(self.mapeffect, false)
			end

			return
		end)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "danianshou", function()
		self:emit(NewYearFestivalMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.BEAT_MONSTER_NIAN_2020
		})

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "dafuweng", function()
		self:emit(NewYearFestivalMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.MONOPOLY_2020
		})

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "diediele", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 9)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "jianzao", function()
		self:emit(NewYearFestivalMediator.GO_SCENE, SCENE.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "sishu", function()
		self:emit(NewYearFestivalMediator.GO_SCENE, SCENE.COLORING)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "pifushangdian", function()
		self:emit(NewYearFestivalMediator.GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	pg.UIMgr.GetInstance():OverlayPanel(self.top)
	self:InitStudents(ActivityConst.ACTIVITY_478, 3, 5)
	self:UpdateView()

	return
end

function SpringFestivalTownScene:UpdateView()
	local var_20_1 = getProxy(ActivityProxy)
	local var_20_2 = var_20_1:getActivityById(ActivityConst.BEAT_MONSTER_NIAN_2020)

	setActive(self._upper:Find("danianshou/tip"), nil and (nil):readyToAchieve())

	local var_20_3 = var_20_1:getActivityById(ActivityConst.MONOPOLY_2020)

	setActive(self._upper:Find("dafuweng/tip"), nil and (nil):readyToAchieve())
	setActive(self._upper:Find("sishu/tip"), getProxy(ColoringProxy):CheckTodayTip())
	setActive(self._upper:Find("jianzao/tip"), false)
	setActive(self._upper:Find("pifushangdian/tip"), false)
	setActive(self._upper:Find("kaihongbao/tip"), RedPacketLayer.isShowRedPoint())

	local var_20_4 = getProxy(MiniGameProxy):GetHubByHubId(self.HUB_ID)

	setActive(self._upper:Find("diediele/tip"), var_20_4.count > 0)
	self:UpdateDieDieleCnt(var_20_4)

	return
end

function SpringFestivalTownScene:UpdateDieDieleCnt(arg_21_1)
	self.usableTxt.text = "X" .. arg_21_1.count
	self.diedieleTxt.text = arg_21_1.usedtime .. "/" .. arg_21_1:getConfig("reward_need")

	return
end

function SpringFestivalTownScene:TryPlayStory()
	return
end

function SpringFestivalTownScene:willExit()
	self.effectReq:Stop()

	self.mapeffect = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(self.top, self._tf)
	self:clearStudents()

	return
end

return SpringFestivalTownScene
