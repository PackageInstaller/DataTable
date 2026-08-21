local var_0_0 = class("DreamlandScene", import("view.base.BaseUI"))

var_0_0.EVENT_SWITCH_TIME = "DreamlandScene:EVENT_SWITCH_TIME"
var_0_0.ON_DATA_UPDATE = "DreamlandScene:ON_DATA_UPDATE"
var_0_0.ON_SPRING_DATA_UPDATE = "DreamlandScene:ON_SPRING_DATA_UPDATE"
var_0_0.ON_SPRING_OP = "DreamlandScene:ON_SPRING_OP"

local var_0_1 = {
	DAY = 1,
	NIGHT = 3,
	DUSK = 2
}

function var_0_0.getThemeName(arg_1_0, arg_1_1)
	if arg_1_1 == var_0_1.DAY then
		return "DreamlandDay", "story-fantasyland-summer"
	elseif arg_1_1 == var_0_1.DUSK then
		return "DreamlandDusk", "story-island-soft"
	elseif arg_1_1 == var_0_1.NIGHT then
		return "DreamlandNight", "story-fantasyland-light"
	end

	return ""
end

function var_0_0.getUIName(arg_2_0)
	return "DreamlandUI"
end

function var_0_0.PlayBGM(arg_3_0)
	return
end

function var_0_0._PlayBGM(arg_4_0)
	if arg_4_0._bgm then
		arg_4_0:StopBgm()

		arg_4_0._bgm = nil
	end

	local var_4_0, var_4_1 = arg_4_0:getThemeName(arg_4_0.period)

	pg.BgmMgr.GetInstance():Push(arg_4_0.__cname, var_4_1)

	arg_4_0._bgm = var_4_1

	return
end

function var_0_0.init(arg_5_0)
	arg_5_0.cg = GetOrAddComponent(arg_5_0._tf, typeof(CanvasGroup))
	arg_5_0.themeContainer = arg_5_0._tf:Find("scrollrect/content")
	arg_5_0.storyTpl = arg_5_0._tf:Find("scrollrect/content/story")
	arg_5_0.storyTplSub = arg_5_0._tf:Find("scrollrect/content/story/tpl")
	arg_5_0.storyTxt = arg_5_0.storyTpl:Find("tpl/Text"):GetComponent(typeof(Text))
	arg_5_0.scrollContent = arg_5_0._tf:Find("scrollrect/content")
	arg_5_0.scrollrectTr = arg_5_0._tf:Find("scrollrect")
	arg_5_0.scrollrect = arg_5_0.scrollrectTr:GetComponent(typeof(ScrollRect))
	arg_5_0.timeBtn = arg_5_0._tf:Find("adapt/time")
	arg_5_0.maskTr = arg_5_0._tf:Find("mask")
	arg_5_0.chatPage = DreamlandChatPage.New(arg_5_0._tf, arg_5_0.event)
	arg_5_0.switcherPage = DreamlandSwitcherPage.New(arg_5_0._tf, arg_5_0.event)
	arg_5_0.handBookPage = DreamlandHandbookPage.New(arg_5_0._tf, arg_5_0.event)
	arg_5_0.hotSpringPage = DreamlandHotSpringPage.New(arg_5_0._tf, arg_5_0.event)
	arg_5_0.spinePlayer = DreamlandSpinePlayer.New()
	arg_5_0.pages = {
		arg_5_0.chatPage,
		arg_5_0.switcherPage,
		arg_5_0.handBookPage,
		arg_5_0.hotSpringPage
	}
	arg_5_0.shipTpl = arg_5_0._tf:Find("root/ship")
	arg_5_0.handbookTip = arg_5_0._tf:Find("adapt/handbook/tip")
	arg_5_0.hotSpringTip = arg_5_0._tf:Find("adapt/hotspring/tip")

	return
end

function var_0_0.InitData(arg_6_0)
	arg_6_0.period = arg_6_0:GetDefaultTheme()

	local var_6_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_DREAMLAND)
	local var_6_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2)

	assert(var_6_0 and var_6_1)

	arg_6_0.gameData = DreamlandData.New(var_6_0, var_6_1)
	arg_6_0.shipAgentList = {}

	return
end

function var_0_0.UpdateActivity(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0.gameData then
		return
	end

	arg_7_0.gameData:UpdateActivityData(arg_7_1)
	arg_7_0:emit(var_0_0.ON_DATA_UPDATE, {
		data = arg_7_0.gameData,
		cmd = arg_7_2
	})

	if arg_7_2 == DreamlandData.OP_RECORD_EXPLORE then
		arg_7_0:InitExploreObjs()
	end

	arg_7_0:UpdateTip()

	return
end

function var_0_0.UpdateSpringActivity(arg_8_0, arg_8_1)
	if not arg_8_0.gameData then
		return
	end

	arg_8_0.gameData:UpdateSpringActivityData(arg_8_1)
	arg_8_0:InitHotSpringCharacters()
	arg_8_0:UpdateTimeBtn()
	arg_8_0:UpdateTip()
	arg_8_0:emit(var_0_0.ON_SPRING_DATA_UPDATE, {
		data = arg_8_0.gameData
	})

	return
end

function var_0_0.didEnter(arg_9_0)
	arg_9_0:InitData()
	arg_9_0:SetUp(true)
	arg_9_0:EnableUpdate()
	arg_9_0:UpdateTip()
	arg_9_0:UpdateTimeBtn()

	return
end

function var_0_0.UpdateTip(arg_10_0)
	setActive(arg_10_0.handbookTip, arg_10_0.gameData:ExistAnyMapOrExploreAward())
	setActive(arg_10_0.hotSpringTip, false)

	return
end

function var_0_0.EnableUpdate(arg_11_0)
	arg_11_0.handle = arg_11_0.handle or UpdateBeat:CreateListener(arg_11_0.Update, arg_11_0)

	UpdateBeat:AddListener(arg_11_0.handle)

	return
end

function var_0_0.DisableUpdate(arg_12_0)
	if arg_12_0.handle then
		UpdateBeat:RemoveListener(arg_12_0.handle)
	end

	return
end

function var_0_0.SetUp(arg_13_0, arg_13_1)
	arg_13_0.cg.blocksRaycasts = false

	seriesAsync({
		function(arg_14_0)
			arg_13_0:SwitchTheme(arg_13_0.period, arg_13_1, arg_14_0)

			return
		end,
		function(arg_15_0)
			if not arg_13_1 then
				arg_15_0()

				return
			end

			arg_13_0:GenPlayableStoryPoint(arg_15_0)

			return
		end,
		function(arg_16_0)
			arg_13_0:InitThemeMask()
			arg_13_0:InitExploreObjs()
			onNextTick(arg_16_0)

			return
		end,
		function(arg_17_0)
			arg_13_0:FocusStory(arg_17_0)

			return
		end,
		function(arg_18_0)
			arg_13_0:InitHotSpringCharacters(arg_18_0)

			return
		end
	}, function()
		arg_13_0.isSetUp = true

		if arg_13_1 then
			arg_13_0:RegisterEvent()
		end

		arg_13_0.cg.blocksRaycasts = true

		return
	end)

	return
end

function var_0_0.RegisterEvent(arg_20_0)
	arg_20_0:BindEvent()
	onButton(arg_20_0, arg_20_0._tf:Find("adapt/back"), function()
		arg_20_0:emit(BaseUI.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(arg_20_0, arg_20_0._tf:Find("adapt/home"), function()
		arg_20_0:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(arg_20_0, arg_20_0._tf:Find("adapt/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.dream_land_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_20_0, arg_20_0._tf:Find("adapt/handbook"), function()
		arg_20_0.handBookPage:ExecuteAction("Show", arg_20_0.gameData)

		return
	end, SFX_PANEL)
	onButton(arg_20_0, arg_20_0._tf:Find("adapt/hotspring"), function()
		arg_20_0.hotSpringPage:ExecuteAction("Show", arg_20_0.gameData)

		return
	end, SFX_PANEL)
	onButton(arg_20_0, arg_20_0.timeBtn, function()
		arg_20_0.switcherPage:ExecuteAction("Show", arg_20_0.period)

		return
	end, SFX_PANEL)

	if arg_20_0.gameData:IsFirstEvent() or arg_20_0.gameData:IsLastEvent() then
		triggerButton(arg_20_0.storyTpl)
	end

	return
end

function var_0_0.UpdateTimeBtn(arg_27_0)
	setActive(arg_27_0.timeBtn, (arg_27_0.gameData:IsFinishAllEvent()))

	return
end

function var_0_0.BindEvent(arg_28_0)
	arg_28_0:bind(var_0_0.EVENT_SWITCH_TIME, function(arg_29_0, arg_29_1)
		if arg_28_0.period == arg_29_1 then
			return
		end

		arg_28_0.period = arg_29_1

		arg_28_0:SetUp(false)

		return
	end)
	arg_28_0:bind(var_0_0.ON_SPRING_OP, function(arg_30_0)
		if arg_28_0.spinePlayer then
			arg_28_0.spinePlayer:ClearEffects()
		end

		return
	end)

	return
end

function var_0_0.InitThemeMask(arg_31_0)
	if not arg_31_0.themeMask then
		return
	end

	local var_31_0 = DreamlandUtil.List2Map(arg_31_0.gameData:FindUnlockMaps(), "id")

	arg_31_0.themeMask.transform:SetAsLastSibling()
	eachChild(arg_31_0.themeMask, function(arg_32_0)
		setActive(arg_32_0, var_31_0[tonumber(arg_32_0.name)] == nil)

		return
	end)

	return
end

function var_0_0.InitExploreObjs(arg_33_0)
	local var_33_0 = DreamlandUtil.List2Map(arg_33_0.gameData:FindCanInteractionExploreObj(), "pic")

	eachChild(arg_33_0.theme, function(arg_34_0)
		if arg_34_0.name ~= "bgs" then
			local var_34_0 = var_33_0[string.split(arg_34_0.name, "#")[1]]

			arg_33_0:EnableOrDisableInteraction(arg_34_0, var_34_0, var_34_0 ~= nil)
		end

		return
	end)

	return
end

function var_0_0.EnableOrDisableInteraction(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	removeOnButton(arg_35_1)

	local var_35_0 = arg_35_1:Find("effect")

	if not arg_35_3 or not arg_35_0.spineAnimUIList[arg_35_1.name] then
		if var_35_0 then
			setActive(var_35_0, false)
		end

		return
	end

	onButton(arg_35_0, arg_35_1, function()
		arg_35_0.spinePlayer:Play(arg_35_0.theme, arg_35_1, arg_35_0.spineAnimUIList, arg_35_2)

		if arg_35_0.gameData:ShouldShowChatTip(arg_35_2.id) then
			arg_35_0.chatPage:ExecuteAction("Show", arg_35_2)

			local var_36_0 = arg_35_0.gameData:FindMapIdByExploreId(arg_35_2.id)

			assert(var_36_0)
			arg_35_0:emit(DreamlandMediator.RECORD_EXPLORE, arg_35_0.gameData:GetActivityId(), var_36_0, arg_35_2.id)
		end

		return
	end, SFX_PANEL)

	if var_35_0 then
		setActive(var_35_0, arg_35_0.gameData:ShouldShowChatTip(arg_35_2.id))
	end

	return
end

function var_0_0.GenPlayableStoryPoint(arg_37_0, arg_37_1)
	arg_37_0:ClearStoryPoint()

	local var_37_0 = arg_37_0.gameData:FindPlayableStory()

	if not var_37_0 then
		arg_37_1()

		return
	end

	setActive(arg_37_0.storyTplSub, false)
	setActive(arg_37_0.storyTpl, true)

	arg_37_0.storyTpl.localPosition = Vector3(var_37_0.pos.x, var_37_0.pos.y, 0)
	arg_37_0.storyTxt.text = var_37_0.name

	onButton(arg_37_0, arg_37_0.storyTpl, function()
		arg_37_0:PlayStory(var_37_0)

		return
	end, SFX_PANEL)

	if arg_37_1 then
		arg_37_1()
	end

	return
end

function var_0_0.FocusStory(arg_39_0, arg_39_1)
	if not isActive(arg_39_0.storyTpl) then
		arg_39_1()

		return
	end

	arg_39_0.storyTpl:SetAsLastSibling()

	arg_39_0.scrollrect.enabled = false

	LeanTween.moveLocal(arg_39_0.scrollContent.gameObject, DreamlandUtil.CalcFocusPosition(arg_39_0.scrollContent, arg_39_0.scrollrectTr, arg_39_0.storyTpl.localPosition), 0.5):setEase(LeanTweenType.easeOutExpo):setOnComplete(System.Action(function()
		setActive(arg_39_0.storyTplSub, true)

		arg_39_0.scrollrect.enabled = true

		arg_39_1()

		return
	end))

	return
end

function var_0_0.PlayStory(arg_41_0, arg_41_1)
	table.insert({}, function(arg_42_0)
		pg.NewStoryMgr.GetInstance():Play(arg_41_1.story, arg_42_0)

		return
	end)

	if arg_41_1.bg ~= arg_41_0.period then
		table.insert({}, function(arg_43_0)
			arg_41_0:GenPlayableStoryPoint(arg_43_0)

			return
		end)
		table.insert({}, function(arg_44_0)
			arg_41_0.period = arg_41_1.bg

			arg_41_0:SetUp(false)
			arg_44_0()

			return
		end)
	else
		table.insert({}, function(arg_45_0)
			arg_41_0.cg.blocksRaycasts = false

			arg_45_0()

			return
		end)
		table.insert({}, function(arg_46_0)
			arg_41_0:PlayUnlockAnimation(arg_46_0)

			return
		end)
		table.insert({}, function(arg_47_0)
			arg_41_0:InitThemeMask()
			arg_41_0:InitExploreObjs()
			arg_41_0:GenPlayableStoryPoint(arg_47_0)

			return
		end)
		table.insert({}, function(arg_48_0)
			arg_41_0:FocusStory(arg_48_0)

			return
		end)
		table.insert({}, function(arg_49_0)
			arg_41_0.cg.blocksRaycasts = true

			arg_49_0()

			return
		end)
	end

	seriesAsync({}, function()
		if arg_41_0.gameData:IsLastEvent() then
			triggerButton(arg_41_0.storyTpl)
		end

		return
	end)

	return
end

function var_0_0.PlayUnlockAnimation(arg_51_0, arg_51_1)
	arg_51_1()

	return
end

function var_0_0.ClearStoryPoint(arg_52_0)
	setActive(arg_52_0.storyTpl, false)

	return
end

function var_0_0.SetUpSpine(arg_53_0, arg_53_1)
	for iter_53_0, iter_53_1 in ipairs((arg_53_1:GetComponentsInChildren(typeof(Spine.Unity.SkeletonGraphic)):ToTable())) do
		local var_53_0 = GetOrAddComponent(iter_53_1.gameObject, typeof(SpineAnimUI))

		var_53_0:SetAction(DreamlandUtil.GetSpineNormalAction((arg_53_0.gameData:GetExploreSubType(string.split(iter_53_1.gameObject.gameObject.transform.parent.name, "#")[1]))), 0)

		;({})[iter_53_1.gameObject.transform.parent.name] = var_53_0
	end

	return {}
end

function var_0_0.SwitchTheme(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = false

	if arg_54_0.cg.blocksRaycasts then
		arg_54_0.cg.blocksRaycasts = false
		var_54_0 = true
	end

	local var_54_1 = arg_54_0:getThemeName(arg_54_1)

	if var_54_1 == "" or arg_54_0.theme and arg_54_0.theme.name == var_54_1 then
		arg_54_3()

		return
	end

	arg_54_0:RecordTheme(arg_54_1)
	setActive(arg_54_0.maskTr, true)
	seriesAsync({
		function(arg_55_0)
			if arg_54_2 then
				arg_55_0()

				return
			end

			arg_54_0:SwitchAnim(0, 1, arg_55_0)

			return
		end,
		function(arg_56_0)
			arg_54_0:LoadThemeMask(arg_56_0)

			return
		end,
		function(arg_57_0)
			arg_54_0:UnloadTheme()
			arg_54_0:_PlayBGM(arg_54_0.period)
			arg_54_0:LoadTheme(var_54_1, arg_57_0)

			return
		end,
		function(arg_58_0)
			if arg_54_2 then
				arg_58_0()

				return
			end

			arg_54_0:SwitchAnim(1, 0, arg_58_0)

			return
		end
	}, function()
		setActive(arg_54_0.maskTr, false)

		if var_54_0 then
			arg_54_0.cg.blocksRaycasts = true
		end

		arg_54_3()

		return
	end)

	return
end

function var_0_0.SwitchAnim(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	LeanTween.value(arg_60_0.maskTr.gameObject, arg_60_1, arg_60_2, 0.5):setOnUpdate(System.Action_float(function(arg_61_0)
		GetOrAddComponent(arg_60_0.maskTr, typeof(CanvasGroup)).alpha = arg_61_0

		return
	end)):setOnComplete(System.Action(arg_60_3))

	return
end

function var_0_0.RecordTheme(arg_62_0, arg_62_1)
	PlayerPrefs.SetInt("dreamland_theme_id" .. getProxy(PlayerProxy):getRawData().id, arg_62_1)
	PlayerPrefs.Save()

	return
end

function var_0_0.GetDefaultTheme(arg_63_0)
	return (PlayerPrefs.GetInt("dreamland_theme_id" .. getProxy(PlayerProxy):getRawData().id, 1))
end

function var_0_0.LoadThemeMask(arg_64_0, arg_64_1)
	if arg_64_0.themeMask then
		arg_64_1()

		return
	end

	if arg_64_0.gameData:IsUnlockAll() then
		arg_64_1()

		return
	end

	PoolMgr.GetInstance():GetUI("DreamlandMask", true, function(arg_65_0)
		arg_64_0.themeMask = arg_65_0

		setParent(arg_65_0, arg_64_0.themeContainer)
		arg_64_1()

		return
	end)

	return
end

function var_0_0.UnLoadThemeMask(arg_66_0)
	if arg_66_0.themeMask then
		PoolMgr.GetInstance():ReturnUI("DreamlandMask", arg_66_0.themeMask)

		arg_66_0.themeMask = nil
	end

	return
end

function var_0_0.GetNodeInfoFromTheme(arg_67_0, arg_67_1)
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
	table.sort({}, function(arg_69_0, arg_69_1)
		return arg_69_0.position.y < arg_69_1.position.y
	end)

	return {}
end

function var_0_0.LoadTheme(arg_70_0, arg_70_1, arg_70_2)
	PoolMgr.GetInstance():GetUI(arg_70_1, true, function(arg_71_0)
		arg_70_0.theme = arg_71_0
		arg_70_0.theme.name = arg_70_1

		arg_70_0.spinePlayer:Clear()

		arg_70_0.spineAnimUIList = arg_70_0:SetUpSpine(arg_71_0)
		arg_70_0.themeNodeInfoList = arg_70_0:GetNodeInfoFromTheme(arg_71_0)

		setParent(arg_71_0, arg_70_0.themeContainer)

		for iter_71_0, iter_71_1 in pairs(arg_70_0.shipAgentList) do
			setParent(iter_71_1._tf, arg_71_0)
		end

		arg_70_2()

		return
	end)

	return
end

function var_0_0.UnloadTheme(arg_72_0)
	arg_72_0.isSetUp = false

	for iter_72_0, iter_72_1 in pairs(arg_72_0.shipAgentList) do
		setParent(iter_72_1._tf, arg_72_0._tf)
		iter_72_1._tf:SetAsFirstSibling()
	end

	if arg_72_0.theme then
		for iter_72_2, iter_72_3 in ipairs(arg_72_0.spineAnimUIList) do
			iter_72_3:SetActionCallBack(nil)
		end

		PoolMgr.GetInstance():ReturnUI(arg_72_0.theme.name, arg_72_0.theme)

		arg_72_0.theme = nil
	end

	arg_72_0.spineAnimUIList = {}
	arg_72_0.themeNodeInfoList = {}

	arg_72_0.spinePlayer:Clear()

	return
end

function var_0_0.InitHotSpringCharacters(arg_73_0, arg_73_1)
	for iter_73_0, iter_73_1 in pairs((arg_73_0.gameData:GetAllSpringShip())) do
		for iter_73_2, iter_73_3 in ipairs(iter_73_1) do
			({})[iter_73_3.id] = true

			table.insert({}, function(arg_74_0)
				local var_74_0 = arg_73_0.gameData:MapId2MapGraph(iter_73_0)

				if var_74_0 then
					arg_73_0:InitHotSpringCharacter(iter_73_3, var_74_0, arg_74_0)
				else
					print("不存在路径", iter_73_0)
					arg_74_0()
				end

				return
			end)
		end
	end

	arg_73_0:RemoveInvalidShips({})
	seriesAsync({}, arg_73_1)

	return
end

function var_0_0.RemoveInvalidShips(arg_75_0, arg_75_1)
	local var_75_0 = arg_75_0.shipAgentList or {}

	for iter_75_0, iter_75_1 in pairs(var_75_0) do
		if not arg_75_1[iter_75_0] then
			iter_75_1:detach()
			Destroy(iter_75_1._go)

			arg_75_0.shipAgentList[iter_75_0] = nil
		end
	end

	return
end

function var_0_0.InitHotSpringCharacter(arg_76_0, arg_76_1, arg_76_2, arg_76_3)
	if arg_76_0.shipAgentList[arg_76_1.id] then
		arg_76_3()

		return
	end

	local var_76_0 = NavalAcademyStudent.New(cloneTplTo(arg_76_0.shipTpl, arg_76_0.theme).gameObject)

	var_76_0:attach()
	var_76_0:setPathFinder(GraphPath.New(arg_76_2))
	var_76_0:setCallBack(function(arg_77_0)
		return
	end, function()
		return
	end)
	var_76_0:updateStudent(arg_76_1, {})

	arg_76_0.shipAgentList[arg_76_1.id] = var_76_0

	onNextTick(arg_76_3)

	return
end

local function var_0_2(arg_79_0, arg_79_1)
	for iter_79_0, iter_79_1 in ipairs(arg_79_0) do
		if iter_79_1.position.y > arg_79_1.y then
			table.insert({}, iter_79_1.tf:GetSiblingIndex() + 1)
		end
	end

	table.sort({}, function(arg_80_0, arg_80_1)
		return arg_80_1 < arg_80_0
	end)

	local var_79_0 = ({})[1]

	if not ({})[1] then
		var_79_0 = #arg_79_0
	end

	return var_79_0
end

function var_0_0.UpdateShipLayer(arg_81_0)
	local var_81_0 = arg_81_0.themeNodeInfoList or {}
	local var_81_1 = arg_81_0.shipAgentList or {}
	local var_81_2 = {}

	for iter_81_0, iter_81_1 in pairs(var_81_1) do
		table.insert(var_81_2, {
			pos = iter_81_1._tf.localPosition,
			agent = iter_81_1,
			siblingIndex = var_0_2(var_81_0, iter_81_1._tf.localPosition)
		})
		iter_81_1._tf:SetAsLastSibling()
	end

	table.sort(var_81_2, function(arg_82_0, arg_82_1)
		if arg_82_0.siblingIndex == arg_82_1.siblingIndex then
			return arg_82_0.pos.y < arg_82_1.pos.y
		else
			return arg_82_0.siblingIndex > arg_82_1.siblingIndex
		end

		return
	end)

	for iter_81_2, iter_81_3 in ipairs(var_81_2) do
		iter_81_3.agent._tf:SetSiblingIndex(iter_81_3.siblingIndex)
	end

	return
end

local var_0_3 = 0

function var_0_0.Update(arg_83_0)
	if not arg_83_0.isSetUp then
		return
	end

	var_0_3 = var_0_3 + Time.deltaTime

	if var_0_3 > 0.3 then
		var_0_3 = 0

		arg_83_0:UpdateShipLayer()
	end

	return
end

function var_0_0.onBackPressed(arg_84_0)
	for iter_84_0, iter_84_1 in ipairs(arg_84_0.pages) do
		if iter_84_1:isShowing() then
			iter_84_1:Hide()

			return
		end
	end

	var_0_0.super.onBackPressed(arg_84_0)

	return
end

function var_0_0.willExit(arg_85_0)
	arg_85_0.isSetUp = false

	arg_85_0:DisableUpdate()

	if arg_85_0.gameData then
		arg_85_0.gameData = nil
	end

	arg_85_0:UnLoadThemeMask()
	arg_85_0:UnloadTheme()
	arg_85_0:ClearStoryPoint()

	local var_85_0 = arg_85_0.shipAgentList or {}

	for iter_85_0, iter_85_1 in pairs(var_85_0) do
		iter_85_1:detach()
		Destroy(iter_85_1._go)
	end

	arg_85_0.shipAgentList = nil

	if arg_85_0.spinePlayer then
		arg_85_0.spinePlayer:Dispose()

		arg_85_0.spinePlayer = nil
	end

	for iter_85_2, iter_85_3 in ipairs(arg_85_0.pages) do
		iter_85_3:Destroy()
	end

	arg_85_0.pages = nil

	return
end

return var_0_0
