local MusicFestivalScene = class("MusicFestivalScene", import("view.base.BaseUI"))

function MusicFestivalScene:getUIName()
	return "MusicFestivalUI"
end

MusicFestivalScene.HUB_ID = 2

function MusicFestivalScene:init()
	self.top = self._tf:Find("top")
	self._closeBtn = self._tf:Find("top/back")
	self._helpBtn = self._tf:Find("top/help")
	self.btn_actskin = self.top:Find("idol_jump")
	self.btn_ins = self.top:Find("ins_jump")
	self._map = self._tf:Find("scrollRect/map")
	self.stage = self._map:Find("stage")
	self.screen = self._map:Find("screen")
	self.shop = self._map:Find("shop")
	self.painting = self._map:Find("painting")
	self.cube = self._map:Find("cube")
	self.foutain = self._map:Find("foutain")
	self.door = self._map:Find("door")
	self.bottom = self._map:Find("bottom")
	self.front = self._map:Find("front")
	self._shipTpl = self._map:Find("ship")
	self._xiefei = self._map:Find("model/xiefei")
	self._modeltip = self._xiefei:Find("tip")
	self._stageShip = self._map:Find("stageship")

	setActive(self._modeltip, false)

	self.graphPath = GraphPath.New(import("GameCfg/BackHillGraphs/MusicFestivalGraph"))
	self._loadingRequest = {}
	self._ReturnRequest = {}

	table.insert(self._loadingRequest, (LoadPrefabRequestPackage.New("ui/" .. "ouxiangxiaoditu", "ouxiangxiaoditu", function(arg_3_0)
		setParent(arg_3_0, self._map)

		local var_3_0 = GameObject.Find("UICamera/Canvas")
		local var_3_1 = var_3_0:GetComponent(typeof(Canvas)).sortingOrder

		for iter_3_0, iter_3_1 in ipairs((arg_3_0:GetComponentsInChildren(typeof(Renderer)).ToTable(var_3_0))) do
			iter_3_1.sortingOrder = var_3_1 + 1
		end

		return
	end):Start()))

	return
end

function MusicFestivalScene:didEnter()
	onButton(self, self._closeBtn, function()
		self:emit(MusicFestivalScene.ON_BACK)

		return
	end)
	onButton(self, self._helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.music_main.tip
		})

		return
	end)
	onButton(self, self.btn_actskin, function()
		self:emit(MusicFestivalMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.MUSIC_CHUIXUE7DAY_ID
		})

		return
	end)
	onButton(self, self.btn_ins, function()
		self:emit(MusicFestivalMediator.GO_SUBLAYER, Context.New({
			viewComponent = InstagramLayer,
			mediator = InstagramMediator,
			data = {
				id = ActivityConst.IDOL_INS_ID
			}
		}))

		return
	end)
	onButton(self, self._xiefei, function()
		self:emit(MusicFestivalMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.MUSIC_FESTIVAL_ID
		})

		return
	end)
	self:InitFacility(self.stage, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 6)

		return
	end)
	self:InitFacility(self.screen, function()
		self:emit(MusicFestivalMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.IDOL_PT_ID
		})

		return
	end)
	self:InitFacility(self.shop, function()
		self:emit(MusicFestivalMediator.GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end)
	self:InitFacility(self.painting, function()
		self:emit(MusicFestivalMediator.GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	self:InitFacility(self.cube, function()
		self:emit(MusicFestivalMediator.GO_SCENE, SCENE.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)
	self:InitFacility(self.foutain, function()
		self:emit(MusicFestivalMediator.GO_SUBLAYER, Context.New({
			mediator = IdolMedalCollectionMediator,
			viewComponent = IdolMedalCollectionView,
			data = {},
			onRemoved = function()
				setActive(self._tf, true)

				return
			end
		}), function()
			setActive(self._tf, false)

			return
		end)

		return
	end)
	self:InitFacility(self.door, function()
		local var_18_0 = getProxy(ChapterProxy)
		local var_18_1, var_18_2 = var_18_0:getLastMapForActivity()

		if var_18_1 then
			if not var_18_0:getMapById(var_18_1):isUnlock() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				goto label_18_0
			end
		end

		self:emit(MusicFestivalMediator.GO_SCENE, SCENE.LEVEL, {
			chapterId = var_18_2,
			mapIdx = var_18_1
		})

		::label_18_0::

		return
	end)

	self.academyStudents = {}

	self:InitAreaTransFunc()
	self:updateStudents()
	self:updateStageShip()
	self:UpdateView()

	return
end

function MusicFestivalScene:UpdateView()
	local var_19_0 = getProxy(ActivityProxy)
	local var_19_1 = var_19_0:getActivityById(ActivityConst.MUSIC_FESTIVAL_ID)

	setActive(self._modeltip, (var_19_1 and not var_19_1:isEnd() or nil) and var_19_1:readyToAchieve())

	local var_19_3 = var_19_0:getActivityById(ActivityConst.MUSIC_CHUIXUE7DAY_ID)

	setActive(self.btn_actskin:Find("tip"), var_19_3 and not var_19_3:isEnd() and var_19_3:readyToAchieve())
	setActive(self.btn_ins:Find("tip"), (getProxy(InstagramProxy):ShouldShowTip()))
	setActive(self.screen:Find("tip"), (IdolPTPage.NeedTip()))
	setActive(self.foutain:Find("tip"), (MusicFestivalScene.MedalTip()))
	setActive(self.stage:Find("tip"), getProxy(MiniGameProxy):GetHubByHubId(self.HUB_ID).count > 0)

	return
end

function MusicFestivalScene:InitFacility(arg_20_1, arg_20_2)
	onButton(self, arg_20_1, arg_20_2)
	onButton(self, arg_20_1:Find("button"), arg_20_2)

	return
end

function MusicFestivalScene:getStudents()
	local var_21_0 = {}
	local var_21_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.MUSIC_FESTIVAL_ID)

	if not var_21_1 then
		return var_21_0
	end

	local var_21_2 = var_21_1:getConfig("config_client")

	var_21_2 = var_21_2 and var_21_2.stage_off_ship

	if var_21_2 then
		local var_21_3 = Clone(var_21_2)

		while 0 < 3 and #var_21_3 > 0 do
			local var_21_4 = math.random(1, #var_21_3)

			table.insert(var_21_0, var_21_3[var_21_4])

			var_21_3[var_21_4] = var_21_3[#var_21_3]
		end
	end

	return var_21_0
end

function MusicFestivalScene:InitAreaTransFunc()
	self.edge2area = {
		["1_2"] = self.bottom,
		["2_3"] = self.bottom,
		["3_4"] = self.bottom
	}

	return
end

function MusicFestivalScene:updateStudents()
	local var_23_0 = self:getStudents()

	for iter_23_0, iter_23_1 in pairs(var_23_0) do
		if not self.academyStudents[iter_23_0] then
			local var_23_1 = cloneTplTo(self._shipTpl, self._map)

			var_23_1.gameObject.name = iter_23_0

			local var_23_2 = SummerFeastNavigationAgent.New(var_23_1.gameObject)

			var_23_2:attach()
			var_23_2:setPathFinder(self.graphPath)
			var_23_2:SetOnTransEdge(function(arg_24_0, arg_24_1, arg_24_2)
				arg_24_2 = math.max(arg_24_1, arg_24_2)
				arg_24_1 = math.min(arg_24_1, arg_24_2)

				arg_24_0._tf:SetParent(self.edge2area[arg_24_1 .. "_" .. arg_24_2] or self.front)

				return
			end)
			var_23_2:updateStudent(iter_23_1)

			self.academyStudents[iter_23_0] = var_23_2
		end
	end

	if #var_23_0 > 0 then
		self.sortTimer = Timer.New(function()
			self:sortStudents()

			return
		end, 0.2, -1)

		self.sortTimer:Start()
		self.sortTimer.func()
	end

	return
end

function MusicFestivalScene:getStageShip()
	local var_26_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MUSIC_FESTIVAL_ID)

	if not var_26_0 then
		return
	end

	local var_26_1 = var_26_0:getConfig("config_client")
	local var_26_2 = var_26_1 and var_26_1.stage_on_ship

	if var_26_1 and var_26_1.stage_on_ship then
		return var_26_2[math.random(1, #var_26_2)], var_26_2.action[1]
	end

	return
end

function MusicFestivalScene:updateStageShip()
	local var_27_0, var_27_1 = self:getStageShip()

	if var_27_0 then
		self._loadingRequest[var_27_0] = GetSpineRequestPackage.New(var_27_0, function(arg_28_0)
			arg_28_0:SetLocalScale(Vector3(0.5, 0.5, 1))
			arg_28_0:SetLocalPosition(Vector3.zero)
			arg_28_0:SetParent(self._stageShip)
			arg_28_0:SetSiblingIndex(1)
			setActive(self._stageShip, true)
			arg_28_0:SetAction(var_27_1, 0)

			self._loadingRequest[var_27_0] = nil
			self._ReturnRequest[var_27_0] = ReturnSpineRequestPackage.New(var_27_0, arg_28_0)

			return
		end):Start()
	end

	return
end

function MusicFestivalScene:sortStudents()
	for iter_29_0, iter_29_1 in pairs({
		self.front,
		self.middle,
		self.bottom
	}) do
		if iter_29_1.childCount > 1 then
			local var_29_0 = {}

			for iter_29_2 = 1, iter_29_1.childCount do
				table.insert(var_29_0, {
					tf = iter_29_1:GetChild(iter_29_2 - 1),
					index = iter_29_2
				})
			end

			table.sort(var_29_0, function(arg_30_0, arg_30_1)
				local var_30_0 = arg_30_0.tf.anchoredPosition.y - arg_30_1.tf.anchoredPosition.y

				if math.abs(arg_30_0.tf.anchoredPosition.y - arg_30_1.tf.anchoredPosition.y) < 1 then
					return arg_30_0.index < arg_30_1.index
				else
					return var_30_0 > 0
				end

				return
			end)

			for iter_29_3, iter_29_4 in ipairs(var_29_0) do
				iter_29_4.tf:SetSiblingIndex(iter_29_3 - 1)
			end
		end
	end

	return
end

function MusicFestivalScene:clearStudents()
	if self.sortTimer then
		self.sortTimer:Stop()

		self.sortTimer = nil
	end

	for iter_31_0, iter_31_1 in pairs(self.academyStudents) do
		iter_31_1:detach()
		Destroy(iter_31_1._go)
	end

	self.academyStudents = {}

	return
end

function MusicFestivalScene:TryPlayStory()
	if "TIANHOUYUYI2" then
		pg.NewStoryMgr.GetInstance():Play("TIANHOUYUYI2")
	end

	return
end

function MusicFestivalScene.MedalTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)))
end

function MusicFestivalScene:willExit()
	self:clearStudents()

	for iter_34_0, iter_34_1 in pairs(self._loadingRequest) do
		iter_34_1:Stop()
	end

	table.clear(self._loadingRequest)

	for iter_34_2, iter_34_3 in pairs(self._ReturnRequest) do
		iter_34_3()
	end

	table.clear(self._ReturnRequest)

	return
end

return MusicFestivalScene
