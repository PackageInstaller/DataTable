local DreamlandScene = class("DreamlandScene", import("view.base.BaseUI"))

DreamlandScene.EVENT_SWITCH_TIME = "DreamlandScene:EVENT_SWITCH_TIME"
DreamlandScene.ON_DATA_UPDATE = "DreamlandScene:ON_DATA_UPDATE"
DreamlandScene.ON_SPRING_DATA_UPDATE = "DreamlandScene:ON_SPRING_DATA_UPDATE"
DreamlandScene.ON_SPRING_OP = "DreamlandScene:ON_SPRING_OP"

local var_0_1 = {
	DAY = 1,
	NIGHT = 3,
	DUSK = 2
}

function DreamlandScene:getThemeName(arg_1_1)
	if arg_1_1 == var_0_1.DAY then
		return "DreamlandDay", "story-fantasyland-summer"
	elseif arg_1_1 == var_0_1.DUSK then
		return "DreamlandDusk", "story-island-soft"
	elseif arg_1_1 == var_0_1.NIGHT then
		return "DreamlandNight", "story-fantasyland-light"
	end

	return ""
end

function DreamlandScene:getUIName()
	return "DreamlandUI"
end

function DreamlandScene:PlayBGM()
	return
end

function DreamlandScene:_PlayBGM()
	if self._bgm then
		self:StopBgm()

		self._bgm = nil
	end

	local var_4_0, var_4_1 = self:getThemeName(self.period)

	pg.BgmMgr.GetInstance():Push(self.__cname, var_4_1)

	self._bgm = var_4_1

	return
end

function DreamlandScene:init()
	self.cg = GetOrAddComponent(self._tf, typeof(CanvasGroup))
	self.themeContainer = self._tf:Find("scrollrect/content")
	self.storyTpl = self._tf:Find("scrollrect/content/story")
	self.storyTplSub = self._tf:Find("scrollrect/content/story/tpl")
	self.storyTxt = self.storyTpl:Find("tpl/Text"):GetComponent(typeof(Text))
	self.scrollContent = self._tf:Find("scrollrect/content")
	self.scrollrectTr = self._tf:Find("scrollrect")
	self.scrollrect = self.scrollrectTr:GetComponent(typeof(ScrollRect))
	self.timeBtn = self._tf:Find("adapt/time")
	self.maskTr = self._tf:Find("mask")
	self.chatPage = DreamlandChatPage.New(self._tf, self.event)
	self.switcherPage = DreamlandSwitcherPage.New(self._tf, self.event)
	self.handBookPage = DreamlandHandbookPage.New(self._tf, self.event)
	self.hotSpringPage = DreamlandHotSpringPage.New(self._tf, self.event)
	self.spinePlayer = DreamlandSpinePlayer.New()
	self.pages = {
		self.chatPage,
		self.switcherPage,
		self.handBookPage,
		self.hotSpringPage
	}
	self.shipTpl = self._tf:Find("root/ship")
	self.handbookTip = self._tf:Find("adapt/handbook/tip")
	self.hotSpringTip = self._tf:Find("adapt/hotspring/tip")

	return
end

function DreamlandScene:InitData()
	self.period = self:GetDefaultTheme()

	local var_6_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_DREAMLAND)
	local var_6_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2)

	assert(var_6_0 and var_6_1)

	self.gameData = DreamlandData.New(var_6_0, var_6_1)
	self.shipAgentList = {}

	return
end

function DreamlandScene:UpdateActivity(arg_7_1, arg_7_2)
	if not self.gameData then
		return
	end

	self.gameData:UpdateActivityData(arg_7_1)
	self:emit(DreamlandScene.ON_DATA_UPDATE, {
		data = self.gameData,
		cmd = arg_7_2
	})

	if arg_7_2 == DreamlandData.OP_RECORD_EXPLORE then
		self:InitExploreObjs()
	end

	self:UpdateTip()

	return
end

function DreamlandScene:UpdateSpringActivity(arg_8_1)
	if not self.gameData then
		return
	end

	self.gameData:UpdateSpringActivityData(arg_8_1)
	self:InitHotSpringCharacters()
	self:UpdateTimeBtn()
	self:UpdateTip()
	self:emit(DreamlandScene.ON_SPRING_DATA_UPDATE, {
		data = self.gameData
	})

	return
end

function DreamlandScene:didEnter()
	self:InitData()
	self:SetUp(true)
	self:EnableUpdate()
	self:UpdateTip()
	self:UpdateTimeBtn()

	return
end

function DreamlandScene:UpdateTip()
	setActive(self.handbookTip, self.gameData:ExistAnyMapOrExploreAward())
	setActive(self.hotSpringTip, false)

	return
end

function DreamlandScene:EnableUpdate()
	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function DreamlandScene:DisableUpdate()
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	return
end

function DreamlandScene:SetUp(arg_13_1)
	self.cg.blocksRaycasts = false

	seriesAsync({
		function(arg_14_0)
			self:SwitchTheme(self.period, arg_13_1, arg_14_0)

			return
		end,
		function(arg_15_0)
			if not arg_13_1 then
				arg_15_0()

				return
			end

			self:GenPlayableStoryPoint(arg_15_0)

			return
		end,
		function(arg_16_0)
			self:InitThemeMask()
			self:InitExploreObjs()
			onNextTick(arg_16_0)

			return
		end,
		function(arg_17_0)
			self:FocusStory(arg_17_0)

			return
		end,
		function(arg_18_0)
			self:InitHotSpringCharacters(arg_18_0)

			return
		end
	}, function()
		self.isSetUp = true

		if arg_13_1 then
			self:RegisterEvent()
		end

		self.cg.blocksRaycasts = true

		return
	end)

	return
end

function DreamlandScene:RegisterEvent()
	self:BindEvent()
	onButton(self, self._tf:Find("adapt/back"), function()
		self:emit(BaseUI.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("adapt/home"), function()
		self:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("adapt/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.dream_land_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("adapt/handbook"), function()
		self.handBookPage:ExecuteAction("Show", self.gameData)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("adapt/hotspring"), function()
		self.hotSpringPage:ExecuteAction("Show", self.gameData)

		return
	end, SFX_PANEL)
	onButton(self, self.timeBtn, function()
		self.switcherPage:ExecuteAction("Show", self.period)

		return
	end, SFX_PANEL)

	if self.gameData:IsFirstEvent() or self.gameData:IsLastEvent() then
		triggerButton(self.storyTpl)
	end

	return
end

function DreamlandScene:UpdateTimeBtn()
	setActive(self.timeBtn, (self.gameData:IsFinishAllEvent()))

	return
end

function DreamlandScene:BindEvent()
	self:bind(DreamlandScene.EVENT_SWITCH_TIME, function(arg_29_0, arg_29_1)
		if self.period == arg_29_1 then
			return
		end

		self.period = arg_29_1

		self:SetUp(false)

		return
	end)
	self:bind(DreamlandScene.ON_SPRING_OP, function(arg_30_0)
		if self.spinePlayer then
			self.spinePlayer:ClearEffects()
		end

		return
	end)

	return
end

function DreamlandScene:InitThemeMask()
	if not self.themeMask then
		return
	end

	local var_31_0 = DreamlandUtil.List2Map(self.gameData:FindUnlockMaps(), "id")

	self.themeMask.transform:SetAsLastSibling()
	eachChild(self.themeMask, function(arg_32_0)
		setActive(arg_32_0, var_31_0[tonumber(arg_32_0.name)] == nil)

		return
	end)

	return
end

function DreamlandScene:InitExploreObjs()
	local var_33_0 = DreamlandUtil.List2Map(self.gameData:FindCanInteractionExploreObj(), "pic")

	eachChild(self.theme, function(arg_34_0)
		if arg_34_0.name ~= "bgs" then
			local var_34_0 = var_33_0[string.split(arg_34_0.name, "#")[1]]

			self:EnableOrDisableInteraction(arg_34_0, var_34_0, var_34_0 ~= nil)
		end

		return
	end)

	return
end

function DreamlandScene:EnableOrDisableInteraction(arg_35_1, arg_35_2, arg_35_3)
	removeOnButton(arg_35_1)

	local var_35_0 = arg_35_1:Find("effect")

	if not arg_35_3 or not self.spineAnimUIList[arg_35_1.name] then
		if var_35_0 then
			setActive(var_35_0, false)
		end

		return
	end

	onButton(self, arg_35_1, function()
		self.spinePlayer:Play(self.theme, arg_35_1, self.spineAnimUIList, arg_35_2)

		if self.gameData:ShouldShowChatTip(arg_35_2.id) then
			self.chatPage:ExecuteAction("Show", arg_35_2)

			local var_36_0 = self.gameData:FindMapIdByExploreId(arg_35_2.id)

			assert(var_36_0)
			self:emit(DreamlandMediator.RECORD_EXPLORE, self.gameData:GetActivityId(), var_36_0, arg_35_2.id)
		end

		return
	end, SFX_PANEL)

	if var_35_0 then
		setActive(var_35_0, self.gameData:ShouldShowChatTip(arg_35_2.id))
	end

	return
end

function DreamlandScene:GenPlayableStoryPoint(arg_37_1)
	self:ClearStoryPoint()

	local var_37_0 = self.gameData:FindPlayableStory()

	if not var_37_0 then
		arg_37_1()

		return
	end

	setActive(self.storyTplSub, false)
	setActive(self.storyTpl, true)

	self.storyTpl.localPosition = Vector3(var_37_0.pos.x, var_37_0.pos.y, 0)
	self.storyTxt.text = var_37_0.name

	onButton(self, self.storyTpl, function()
		self:PlayStory(var_37_0)

		return
	end, SFX_PANEL)

	if arg_37_1 then
		arg_37_1()
	end

	return
end

function DreamlandScene:FocusStory(arg_39_1)
	if not isActive(self.storyTpl) then
		arg_39_1()

		return
	end

	self.storyTpl:SetAsLastSibling()

	self.scrollrect.enabled = false

	LeanTween.moveLocal(self.scrollContent.gameObject, DreamlandUtil.CalcFocusPosition(self.scrollContent, self.scrollrectTr, self.storyTpl.localPosition), 0.5):setEase(LeanTweenType.easeOutExpo):setOnComplete(System.Action(function()
		setActive(self.storyTplSub, true)

		self.scrollrect.enabled = true

		arg_39_1()

		return
	end))

	return
end

function DreamlandScene:PlayStory(arg_41_1)
	local var_41_0 = {}

	table.insert(var_41_0, function(arg_42_0)
		pg.NewStoryMgr.GetInstance():Play(arg_41_1.story, arg_42_0)

		return
	end)

	if arg_41_1.bg ~= self.period then
		table.insert(var_41_0, function(arg_43_0)
			self:GenPlayableStoryPoint(arg_43_0)

			return
		end)
		table.insert(var_41_0, function(arg_44_0)
			self.period = arg_41_1.bg

			self:SetUp(false)
			arg_44_0()

			return
		end)
	else
		table.insert(var_41_0, function(arg_45_0)
			self.cg.blocksRaycasts = false

			arg_45_0()

			return
		end)
		table.insert(var_41_0, function(arg_46_0)
			self:PlayUnlockAnimation(arg_46_0)

			return
		end)
		table.insert(var_41_0, function(arg_47_0)
			self:InitThemeMask()
			self:InitExploreObjs()
			self:GenPlayableStoryPoint(arg_47_0)

			return
		end)
		table.insert(var_41_0, function(arg_48_0)
			self:FocusStory(arg_48_0)

			return
		end)
		table.insert(var_41_0, function(arg_49_0)
			self.cg.blocksRaycasts = true

			arg_49_0()

			return
		end)
	end

	seriesAsync(var_41_0, function()
		if self.gameData:IsLastEvent() then
			triggerButton(self.storyTpl)
		end

		return
	end)

	return
end

function DreamlandScene:PlayUnlockAnimation(arg_51_1)
	arg_51_1()

	return
end

function DreamlandScene:ClearStoryPoint()
	setActive(self.storyTpl, false)

	return
end

function DreamlandScene:SetUpSpine(arg_53_1)
	local var_53_0 = {}

	for iter_53_0, iter_53_1 in ipairs((arg_53_1:GetComponentsInChildren(typeof(Spine.Unity.SkeletonGraphic)):ToTable())) do
		local var_53_1 = GetOrAddComponent(iter_53_1.gameObject, typeof(SpineAnimUI))

		var_53_1:SetAction(DreamlandUtil.GetSpineNormalAction((self.gameData:GetExploreSubType(string.split(iter_53_1.gameObject.gameObject.transform.parent.name, "#")[1]))), 0)

		var_53_0[iter_53_1.gameObject.transform.parent.name] = var_53_1
	end

	return var_53_0
end

function DreamlandScene:SwitchTheme(arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = false

	if self.cg.blocksRaycasts then
		self.cg.blocksRaycasts = false
		var_54_0 = true
	end

	local var_54_1 = self:getThemeName(arg_54_1)

	if var_54_1 == "" or self.theme and self.theme.name == var_54_1 then
		arg_54_3()

		return
	end

	self:RecordTheme(arg_54_1)
	setActive(self.maskTr, true)
	seriesAsync({
		function(arg_55_0)
			if arg_54_2 then
				arg_55_0()

				return
			end

			self:SwitchAnim(0, 1, arg_55_0)

			return
		end,
		function(arg_56_0)
			self:LoadThemeMask(arg_56_0)

			return
		end,
		function(arg_57_0)
			self:UnloadTheme()
			self:_PlayBGM(self.period)
			self:LoadTheme(var_54_1, arg_57_0)

			return
		end,
		function(arg_58_0)
			if arg_54_2 then
				arg_58_0()

				return
			end

			self:SwitchAnim(1, 0, arg_58_0)

			return
		end
	}, function()
		setActive(self.maskTr, false)

		if var_54_0 then
			self.cg.blocksRaycasts = true
		end

		arg_54_3()

		return
	end)

	return
end

function DreamlandScene:SwitchAnim(arg_60_1, arg_60_2, arg_60_3)
	LeanTween.value(self.maskTr.gameObject, arg_60_1, arg_60_2, 0.5):setOnUpdate(System.Action_float(function(arg_61_0)
		GetOrAddComponent(self.maskTr, typeof(CanvasGroup)).alpha = arg_61_0

		return
	end)):setOnComplete(System.Action(arg_60_3))

	return
end

function DreamlandScene:RecordTheme(arg_62_1)
	PlayerPrefs.SetInt("dreamland_theme_id" .. getProxy(PlayerProxy):getRawData().id, arg_62_1)
	PlayerPrefs.Save()

	return
end

function DreamlandScene:GetDefaultTheme()
	return (PlayerPrefs.GetInt("dreamland_theme_id" .. getProxy(PlayerProxy):getRawData().id, 1))
end

function DreamlandScene:LoadThemeMask(arg_64_1)
	if self.themeMask then
		arg_64_1()

		return
	end

	if self.gameData:IsUnlockAll() then
		arg_64_1()

		return
	end

	PoolMgr.GetInstance():GetUI("DreamlandMask", true, function(arg_65_0)
		self.themeMask = arg_65_0

		setParent(arg_65_0, self.themeContainer)
		arg_64_1()

		return
	end)

	return
end

function DreamlandScene:UnLoadThemeMask()
	if self.themeMask then
		PoolMgr.GetInstance():ReturnUI("DreamlandMask", self.themeMask)

		self.themeMask = nil
	end

	return
end

function DreamlandScene:GetNodeInfoFromTheme(arg_67_1)
	local var_67_0 = {}

	eachChild(tf(arg_67_1), function(arg_68_0)
		if arg_68_0.name ~= "bgs" then
			local var_68_0 = arg_68_0:GetSiblingIndex()

			table.insert(var_67_0, {
				tf = arg_68_0,
				position = arg_68_0.localPosition
			})
		end

		return
	end)
	table.sort(var_67_0, function(arg_69_0, arg_69_1)
		return arg_69_0.position.y < arg_69_1.position.y
	end)

	return var_67_0
end

function DreamlandScene:LoadTheme(arg_70_1, arg_70_2)
	PoolMgr.GetInstance():GetUI(arg_70_1, true, function(arg_71_0)
		self.theme = arg_71_0
		self.theme.name = arg_70_1

		self.spinePlayer:Clear()

		self.spineAnimUIList = self:SetUpSpine(arg_71_0)
		self.themeNodeInfoList = self:GetNodeInfoFromTheme(arg_71_0)

		setParent(arg_71_0, self.themeContainer)

		for iter_71_0, iter_71_1 in pairs(self.shipAgentList) do
			setParent(iter_71_1._tf, arg_71_0)
		end

		arg_70_2()

		return
	end)

	return
end

function DreamlandScene:UnloadTheme()
	self.isSetUp = false

	for iter_72_0, iter_72_1 in pairs(self.shipAgentList) do
		setParent(iter_72_1._tf, self._tf)
		iter_72_1._tf:SetAsFirstSibling()
	end

	if self.theme then
		for iter_72_2, iter_72_3 in ipairs(self.spineAnimUIList) do
			iter_72_3:SetActionCallBack(nil)
		end

		PoolMgr.GetInstance():ReturnUI(self.theme.name, self.theme)

		self.theme = nil
	end

	self.spineAnimUIList = {}
	self.themeNodeInfoList = {}

	self.spinePlayer:Clear()

	return
end

function DreamlandScene:InitHotSpringCharacters(arg_73_1)
	local var_73_0 = {}
	local var_73_1 = {}

	for iter_73_0, iter_73_1 in pairs((self.gameData:GetAllSpringShip())) do
		for iter_73_2, iter_73_3 in ipairs(iter_73_1) do
			var_73_1[iter_73_3.id] = true

			table.insert(var_73_0, function(arg_74_0)
				local var_74_0 = self.gameData:MapId2MapGraph(iter_73_0)

				if var_74_0 then
					self:InitHotSpringCharacter(iter_73_3, var_74_0, arg_74_0)
				else
					print("不存在路径", iter_73_0)
					arg_74_0()
				end

				return
			end)
		end
	end

	self:RemoveInvalidShips(var_73_1)
	seriesAsync(var_73_0, arg_73_1)

	return
end

function DreamlandScene:RemoveInvalidShips(arg_75_1)
	for iter_75_0, iter_75_1 in pairs(self.shipAgentList or {}) do
		if not arg_75_1[iter_75_0] then
			iter_75_1:detach()
			Destroy(iter_75_1._go)

			self.shipAgentList[iter_75_0] = nil
		end
	end

	return
end

function DreamlandScene:InitHotSpringCharacter(arg_76_1, arg_76_2, arg_76_3)
	if self.shipAgentList[arg_76_1.id] then
		arg_76_3()

		return
	end

	local var_76_0 = NavalAcademyStudent.New(cloneTplTo(self.shipTpl, self.theme).gameObject)

	var_76_0:attach()
	var_76_0:setPathFinder(GraphPath.New(arg_76_2))
	var_76_0:setCallBack(function(arg_77_0)
		return
	end, function()
		return
	end)
	var_76_0:updateStudent(arg_76_1, {})

	self.shipAgentList[arg_76_1.id] = var_76_0

	onNextTick(arg_76_3)

	return
end

local function var_0_2(arg_79_0, arg_79_1)
	local var_79_0 = {}

	for iter_79_0, iter_79_1 in ipairs(arg_79_0) do
		if iter_79_1.position.y > arg_79_1.y then
			table.insert(var_79_0, iter_79_1.tf:GetSiblingIndex() + 1)
		end
	end

	table.sort(var_79_0, function(arg_80_0, arg_80_1)
		return arg_80_1 < arg_80_0
	end)

	return var_79_0[1] or #arg_79_0
end

function DreamlandScene:UpdateShipLayer()
	local var_81_0 = self.themeNodeInfoList or {}
	local var_81_1 = {}

	for iter_81_0, iter_81_1 in pairs(self.shipAgentList or {}) do
		table.insert(var_81_1, {
			pos = iter_81_1._tf.localPosition,
			agent = iter_81_1,
			siblingIndex = var_0_2(var_81_0, iter_81_1._tf.localPosition)
		})
		iter_81_1._tf:SetAsLastSibling()
	end

	table.sort(var_81_1, function(arg_82_0, arg_82_1)
		if arg_82_0.siblingIndex == arg_82_1.siblingIndex then
			return arg_82_0.pos.y < arg_82_1.pos.y
		else
			return arg_82_0.siblingIndex > arg_82_1.siblingIndex
		end

		return
	end)

	for iter_81_2, iter_81_3 in ipairs(var_81_1) do
		iter_81_3.agent._tf:SetSiblingIndex(iter_81_3.siblingIndex)
	end

	return
end

local var_0_3 = 0

function DreamlandScene:Update()
	if not self.isSetUp then
		return
	end

	var_0_3 = var_0_3 + Time.deltaTime

	if var_0_3 > 0.3 then
		var_0_3 = 0

		self:UpdateShipLayer()
	end

	return
end

function DreamlandScene:onBackPressed()
	for iter_84_0, iter_84_1 in ipairs(self.pages) do
		if iter_84_1:isShowing() then
			iter_84_1:Hide()

			return
		end
	end

	DreamlandScene.super.onBackPressed(self)

	return
end

function DreamlandScene:willExit()
	self.isSetUp = false

	self:DisableUpdate()

	if self.gameData then
		self.gameData = nil
	end

	self:UnLoadThemeMask()
	self:UnloadTheme()
	self:ClearStoryPoint()

	for iter_85_0, iter_85_1 in pairs(self.shipAgentList or {}) do
		iter_85_1:detach()
		Destroy(iter_85_1._go)
	end

	self.shipAgentList = nil

	if self.spinePlayer then
		self.spinePlayer:Dispose()

		self.spinePlayer = nil
	end

	for iter_85_2, iter_85_3 in ipairs(self.pages) do
		iter_85_3:Destroy()
	end

	self.pages = nil

	return
end

return DreamlandScene
