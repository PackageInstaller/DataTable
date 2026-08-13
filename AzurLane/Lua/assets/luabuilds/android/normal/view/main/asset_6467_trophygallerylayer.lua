class = var_0_10000

local var_0_0 = "TrophyGalleryLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.Filter = {
	"all",
	"claimed"
}
var_0_1.PAGE_COMMON = 1
var_0_1.PAGE_LIMITED = 2

function var_0_1.getUIName(arg_1_0)
	return "TrophyGalleryUI"
end

function var_0_1.setTrophyGroups(arg_2_0, arg_2_1)
	arg_2_0.trophyGroups = arg_2_1

	return
end

function var_0_1.setTrophyList(arg_3_0, arg_3_1)
	arg_3_0.trophyList = arg_3_1

	return
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0._bg = var_1.Find(var_4_0, "bg")

	local var_4_1 = arg_4_0._tf

	arg_4_0._blurPanel = var_1.Find(var_4_1, "blur_panel")

	local var_4_2 = arg_4_0._blurPanel

	arg_4_0._topPanel = var_1.Find(var_4_2, "adapt/top")

	local var_4_3 = arg_4_0._topPanel

	arg_4_0._backBtn = var_1.Find(var_4_3, "back_btn")

	local var_4_4 = arg_4_0._topPanel

	arg_4_0._helpBtn = var_1.Find(var_4_4, "help_btn")

	local var_4_5 = arg_4_0._tf

	arg_4_0._center = var_1.Find(var_4_5, "bg/taskBGCenter")
	arg_4_0._trophyUpperTpl = arg_4_0:getTpl("trophy_upper", arg_4_0._center)
	arg_4_0._trophyLowerTpl = arg_4_0:getTpl("trophy_lower", arg_4_0._center)

	local var_4_6 = arg_4_0._tf

	arg_4_0._trophyContainer = var_1.Find(var_4_6, "bg/taskBGCenter/right_panel/Grid")

	local var_4_7 = arg_4_0._tf

	arg_4_0._scrllPanel = var_1.Find(var_4_7, "bg/taskBGCenter/right_panel")

	local var_4_8 = arg_4_0._scrllPanel

	arg_4_0._scrollView = var_1.GetComponent(var_4_8, "LScrollRect")
	TrophyDetailPanel = var_1

	local var_4_9 = var_1.New
	local var_4_10 = arg_4_0._tf

	arg_4_0._trophyDetailPanel = var_4_9(var_2.Find(var_4_10, "trophyPanel"), arg_4_0._tf)

	local var_4_11 = arg_4_0._topPanel

	arg_4_0._filterBtn = var_1.Find(var_4_11, "filter/toggle")

	local var_4_12 = arg_4_0._topPanel

	arg_4_0._trophyCounter = var_1.Find(var_4_12, "filter/counter/Text")

	local var_4_13 = arg_4_0._tf

	arg_4_0._reminderRes = var_1.Find(var_4_13, "bg/resource")

	local var_4_14 = {}
	local var_4_15 = arg_4_0._tf

	var_4_14[1] = var_2.Find(var_4_15, "blur_panel/adapt/left_length/frame/root/common_toggle")

	local var_4_16 = arg_4_0._tf

	var_4_14[2] = var_2.Find(var_4_16, "blur_panel/adapt/left_length/frame/root/limited_toggle")
	var_4_14[3] = arg_4_0.toggleLoveLetter
	arg_4_0._pageToggle = var_4_14

	local var_4_17 = arg_4_0._tf

	arg_4_0._hideExpireBtn = var_1.Find(var_4_17, "blur_panel/adapt/top/expireCheckBox")

	local var_4_18 = arg_4_0._hideExpireBtn

	arg_4_0._hideExpireCheck = var_1.Find(var_4_18, "check")

	local var_4_19

	if not arg_4_0.contextData.index then
		var_4_19 = 1
	end

	arg_4_0._pageIndex = var_4_19
	arg_4_0._hideExpire = false
	arg_4_0._trophyTFList = {}
	arg_4_0._trophyViewCache = {}
	arg_4_0._trophyMatCache = {}
	arg_4_0.cardItems = {}

	local var_4_20 = arg_4_0.rtScrollContent

	arg_4_0.cardList = var_1.GetComponent(var_4_20, "LScrollRect")

	function arg_4_0.cardList.onInitItem(arg_5_0)
		local var_5_0 = arg_4_0

		var_1.onInitCard(var_5_0, arg_5_0)

		return
	end

	function arg_4_0.cardList.onUpdateItem(arg_6_0, arg_6_1)
		local var_6_0 = arg_4_0

		var_2.onUpdateCard(var_6_0, arg_6_0, arg_6_1)

		return
	end

	local var_4_21 = arg_4_0.cardList

	function var_4_21.onReturnItem(arg_7_0, arg_7_1)
		local var_7_0 = arg_4_0

		var_2.onReturnCard(var_7_0, arg_7_0, arg_7_1)

		return
	end

	AutoLoader = var_4_21
	arg_4_0._loader = var_4_21.New()

	return
end

function var_0_1.checkTrophyVisible(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_1:GetTrophyPage() ~= arg_8_2 then
		return false
	end

	local var_8_0 = false

	if arg_8_3 == "all" then
		var_8_0 = true
	elseif arg_8_3 == "claimed" then
		var_8_0 = arg_8_1:getMaxClaimedTrophy() ~= nil
	end

	if arg_8_2 == var_0_1.PAGE_LIMITED and arg_8_0._hideExpire and arg_8_1:IsExpire() == 1 then
		local var_8_1 = arg_8_1:getProgressTrophy()

		if not var_5.isClaimed(var_8_1) then
			var_8_0 = false
		end
	end

	return var_8_0
end

function var_0_1.ensureTrophyViewCache(arg_9_0, arg_9_1)
	if arg_9_0._trophyViewCache[arg_9_1] then
		return var_2
	end

	cloneTplTo = var_1_10003

	local var_9_0 = var_1_10003(arg_9_0._trophyUpperTpl, arg_9_0._trophyContainer)

	cloneTplTo = var_4

	local var_9_1 = var_4(arg_9_0._trophyLowerTpl, arg_9_0._trophyContainer)

	TrophyView = var_5

	local var_9_2 = var_5.New(var_9_0)

	TrophyView = var_6

	local var_9_3 = var_6.New(var_9_1)

	local function var_9_4()
		local var_10_0 = arg_9_0.trophyGroups[arg_9_1]
		local var_10_1 = var_0.getProgressTrophy(var_10_0)

		if not arg_9_0._trophyTFList[arg_9_1] then
			return
		end

		if var_10_1:canClaimed() and not var_10_1:isClaimed() then
			if not var_2:IsPlaying() then
				local var_10_2 = arg_9_0
				local var_10_3 = var_3.emit

				TrophyGalleryMediator = var_2_10005

				var_10_3(var_10_2, var_2_10005.ON_TROPHY_CLAIM, var_10_1.id)
			end
		elseif not var_2:IsPlaying() then
			local var_10_4 = arg_9_0

			var_3.openTrophyDetail(var_10_4, var_0, var_10_1)
		end

		return
	end

	onButton = var_1_10008

	local var_9_5 = arg_9_0
	local var_9_6 = var_9_0.transform

	var_1_10008(var_9_5, var_10.Find(var_9_6, "frame"), var_9_4)

	onButton = var_1_10008

	local var_9_7 = arg_9_0
	local var_9_8 = var_9_1.transform

	var_1_10008(var_9_7, var_10.Find(var_9_8, "frame"), var_9_4)

	setActive = var_1_10008

	var_1_10008(var_9_0, false)

	setActive = var_1_10008

	var_1_10008(var_9_1, false)

	local var_9_9 = {
		upperGO = var_9_0,
		lowerGO = var_9_1,
		upperView = var_9_2,
		lowerView = var_9_3
	}

	arg_9_0._trophyViewCache[arg_9_1] = var_9_9

	return var_9_9
end

function var_0_1.updateTrophyViewByFilter(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_3 == "all" then
		arg_11_1:UpdateTrophyGroup(arg_11_2)
	elseif arg_11_3 == "claimed" then
		arg_11_1:ClaimForm(arg_11_2)
	elseif arg_11_3 == "unclaim" then
		arg_11_1:ProgressingForm(arg_11_2)
	end

	return
end

function var_0_1.updateTrophyReminderMaterial(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1:GetTrophyClaimTipsID()

	if arg_12_0._trophyMatCache[var_12_0] then
		arg_12_1:SetTrophyReminderMaterial(var_3)

		return
	end

	local var_12_1 = "artresource/effect/xunzhang/materials/" .. var_12_0

	checkABExist = var_5

	if var_5(var_12_1) then
		local var_12_2 = arg_12_0._loader

		var_5.LoadBundle(var_12_2, var_12_1, function(arg_13_0)
			local var_13_0 = arg_13_0
			local var_13_1 = arg_13_0.LoadAssetSync
			local var_13_2 = var_12_0

			typeof = var_2_10004
			Material = var_2_10005

			local var_13_3 = var_13_1(var_13_0, var_13_2, var_2_10004(var_2_10005), false, false)

			arg_12_0._trophyMatCache[var_12_0] = var_13_3

			local var_13_4 = arg_12_1

			var_2.SetTrophyReminderMaterial(var_13_4, var_13_3)

			return
		end)
	end

	return
end

function var_0_1.didEnter(arg_14_0)
	arg_14_0:OverlayPanel(arg_14_0._tf)

	onButton = var_1

	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0._backBtn

	local function var_14_2()
		local var_15_0 = arg_14_0

		var_0.emit(var_15_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_14_0, var_14_1, var_14_2, var_1_10005)

	onButton = var_1

	local var_14_3 = arg_14_0
	local var_14_4 = arg_14_0._filterBtn

	local function var_14_5()
		local var_16_0 = arg_14_0

		var_0.onFilter(var_16_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_14_3, var_14_4, var_14_5, var_1_10005)

	onButton = var_1

	local var_14_6 = arg_14_0
	local var_14_7 = arg_14_0._helpBtn

	local function var_14_8()
		pg = var_2_10000

		local var_17_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_17_1 = var_0.ShowMsgBox
		local var_17_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_17_2.type = var_2_10003
		pg = var_2_10003
		var_17_2.helps = var_2_10003.gametip.medal_help_tip.tip

		var_17_1(var_17_0, var_17_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_14_6, var_14_7, var_14_8, var_1_10005)

	onButton = var_1

	local var_14_9 = arg_14_0
	local var_14_10 = arg_14_0._hideExpireBtn

	local function var_14_11()
		local var_18_0 = arg_14_0

		var_18_0._hideExpire = not arg_14_0._hideExpire
		setActive = var_18_0

		var_18_0(arg_14_0._hideExpireCheck, not arg_14_0._hideExpire)

		local var_18_1 = arg_14_0

		var_0.updateTrophyList(var_18_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_14_9, var_14_10, var_14_11, var_1_10005)

	triggerButton = var_1

	var_1(arg_14_0._hideExpireBtn)

	ipairs = var_1

	for iter_14_0, iter_14_1 in var_1(arg_14_0._pageToggle) do
		onButton = var_1_10006

		local var_14_12 = arg_14_0
		local var_14_13 = iter_14_1

		local function var_14_14()
			local var_19_0 = arg_14_0

			var_0.updatePage(var_19_0, iter_14_0)

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_14_12, var_14_13, var_14_14, var_1_10010)
	end

	pg = var_1

	local var_14_15 = var_1.EasyRedDotMgr.GetInstance()
	local var_14_16 = var_1.RegisterRedDot
	local var_14_17 = arg_14_0.toggleLoveLetter

	var_14_16(var_14_15, var_3.Find(var_14_17, "tip"), {
		"love_letter_level_up",
		"love_letter_level_reward"
	}, function(arg_20_0)
		getProxy = var_2_10001
		LoveLetterProxy = var_2_10002

		local var_20_0 = var_2_10001(var_2_10002)

		setActive = var_2_10002

		local var_20_1 = arg_20_0
		local var_20_2

		if not var_20_0:IsTipLevelUp() then
			var_20_2 = var_20_0:IsTipAllLevelReward()
		end

		var_2_10002(var_20_1, var_20_2)

		return
	end)

	pg = var_14_16

	local var_14_18 = var_14_16.EasyRedDotMgr.GetInstance()
	local var_14_19 = var_1.RegisterRedDot
	local var_14_20 = arg_14_0.rtCountLevelPanel

	var_14_19(var_14_18, var_3.Find(var_14_20, "info/icon/tip"), {
		"love_letter_level_up",
		"love_letter_level_reward"
	}, function(arg_21_0)
		setActive = var_2_10001

		local var_21_0 = arg_21_0

		getProxy = var_2_10003
		LoveLetterProxy = var_2_10004

		local var_21_1 = var_2_10003(var_2_10004)

		var_2_10001(var_21_0, var_3.IsTipAllLevelReward(var_21_1))

		return
	end)

	arg_14_0._filterIndex = 0
	triggerButton = var_1

	var_1(arg_14_0._filterBtn)

	triggerButton = var_1

	var_1(arg_14_0._pageToggle[arg_14_0._pageIndex])
	arg_14_0:updateTrophyCounter()

	return
end

function var_0_1.updatePage(arg_22_0, arg_22_1)
	ipairs = var_1_10002

	for iter_22_0, iter_22_1 in var_1_10002(arg_22_0._pageToggle) do
		setActive = var_1_10007

		var_1_10007(iter_22_1:Find("selected"), iter_22_0 == arg_22_1)

		setActive = var_1_10007

		var_1_10007(iter_22_1:Find("Image"), iter_22_0 ~= arg_22_1)
	end

	arg_22_0._pageIndex = arg_22_1

	local var_22_0 = arg_22_1 == 3

	setActive = var_3

	var_3(arg_22_0._center, not var_22_0)

	setActive = var_3

	local var_22_1 = arg_22_0._topPanel

	var_3(var_4.Find(var_22_1, "filter"), not var_22_0)

	setActive = var_3

	var_3(arg_22_0.rtLoveLetterPanel, var_22_0)

	setActive = var_3

	var_3(arg_22_0.rtCountLevelPanel, var_22_0)

	setActive = var_3

	var_3(arg_22_0.rtCountLevelBg, var_22_0)

	if var_22_0 then
		arg_22_0:updateLoveLetterPage()
	else
		arg_22_0:updateTrophyList()
	end

	setActive = var_3

	var_3(arg_22_0._hideExpireBtn, arg_22_1 == var_0_1.PAGE_LIMITED)

	return
end

function var_0_1.updateTrophyList(arg_23_0)
	arg_23_0._trophyTFList = {}
	pairs = var_1

	for iter_23_0, iter_23_1 in var_1(arg_23_0._trophyViewCache) do
		setActive = var_1_10006

		var_1_10006(iter_23_1.upperGO, false)

		setActive = var_1_10006

		var_1_10006(iter_23_1.lowerGO, false)
	end

	local var_23_0 = var_0_1.Filter[arg_23_0._filterIndex]
	local var_23_1 = arg_23_0._pageIndex
	local var_23_2 = 1

	pairs = iter_23_0

	for iter_23_2, iter_23_3 in iter_23_0(arg_23_0.trophyGroups) do
		if arg_23_0:checkTrophyVisible(iter_23_3, var_23_1, var_23_0) then
			local var_23_3 = arg_23_0
			local var_23_4 = arg_23_0.ensureTrophyViewCache(var_23_3, iter_23_2)

			math = var_23_3

			local var_23_5

			if not (var_23_3.fmod(var_23_2, 2) == 1) or not var_23_4.upperGO then
				var_23_5 = var_23_4.lowerGO
			end

			local var_23_6

			if not var_10 or not var_23_4.lowerGO then
				var_23_6 = var_23_4.upperGO
			end

			local var_23_7

			if not var_10 or not var_23_4.upperView then
				var_23_7 = var_23_4.lowerView
			end

			setActive = var_1_10014

			var_1_10014(var_23_5, true)

			setActive = var_1_10014

			var_1_10014(var_23_6, false)

			local var_23_8 = var_23_5.transform

			var_1_10014.SetSiblingIndex(var_23_8, var_23_2 - 1)
			arg_23_0:updateTrophyViewByFilter(var_23_7, iter_23_3, var_23_0)
			arg_23_0:updateTrophyReminderMaterial(var_23_7)

			var_1_10014 = arg_23_0._trophyTFList
			var_1_10014[iter_23_2] = var_23_7
			var_23_2 = var_23_2 + 1
		end
	end

	return
end

function var_0_1.PlayTrophyClaim(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.trophyGroups[arg_24_1]
	local var_24_1 = arg_24_0._trophyTFList[arg_24_1]

	Instantiate = var_1_10004

	local var_24_2 = arg_24_0._reminderRes
	local var_24_3 = var_1_10004(var_5.Find(var_24_2, "claim_fx"))

	var_24_1:PlayClaimAnima(var_24_0, var_24_3, function()
		local var_25_0 = arg_24_0

		var_0.updateTrophyByGroup(var_25_0, arg_24_1)

		local var_25_1 = arg_24_0

		var_0.updateTrophyCounter(var_25_1)

		return
	end)

	return
end

function var_0_1.updateTrophyByGroup(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0.trophyGroups[arg_26_1]
	local var_26_1 = arg_26_0._trophyTFList[arg_26_1]

	var_3.UpdateTrophyGroup(var_26_1, var_26_0)

	return
end

function var_0_1.openTrophyDetail(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0._trophyDetailPanel

	var_3.SetTrophyGroup(var_27_0, arg_27_1)

	local var_27_1 = arg_27_0._trophyDetailPanel

	var_3.UpdateTrophy(var_27_1, arg_27_2)

	local var_27_2 = arg_27_0._trophyDetailPanel

	var_3.SetActive(var_27_2, true)

	return
end

function var_0_1.updateTrophyCounter(arg_28_0)
	local var_28_0 = 0

	pairs = var_1_10002

	for iter_28_0, iter_28_1 in var_1_10002(arg_28_0.trophyList) do
		if iter_28_1:isClaimed() and not iter_28_1:isHide() then
			var_28_0 = var_28_0 + 1
		end
	end

	setText = var_2

	var_2(arg_28_0._trophyCounter, var_28_0)

	return
end

function var_0_1.onFilter(arg_29_0)
	arg_29_0._filterIndex = arg_29_0._filterIndex + 1

	if arg_29_0._filterIndex > #var_0_1.Filter then
		arg_29_0._filterIndex = 1
	end

	for iter_29_0 = 1, #var_0_1.Filter do
		setActive = var_1_10005

		local var_29_0 = arg_29_0._filterBtn

		var_1_10005(var_6.GetChild(var_29_0, iter_29_0 - 1), iter_29_0 == arg_29_0._filterIndex)
	end

	arg_29_0:updateTrophyList()

	return
end

function var_0_1.updateLoveLetterPage(arg_30_0)
	local var_30_0

	if not arg_30_0.contextData.checkRalizeGift then
		var_30_0 = arg_30_0.contextData
		var_30_0.checkRalizeGift = true
		getProxy = var_30_0
		LoveLetterProxy = var_1_10002
		var_1_10002 = var_30_0(var_1_10002)

		if var_30_0.IsTipRealizeGift(var_1_10002) then
			var_1_10002 = arg_30_0
			var_30_0 = arg_30_0.emit
			TrophyGalleryMediator = var_1_10003

			var_30_0(var_1_10002, var_1_10003.OPEN_REALIZE_GIFT_LAYER)
		end
	end

	getProxy = var_30_0
	LoveLetterProxy = var_1_10002

	local var_30_1 = var_30_0(var_1_10002)

	arg_30_0.cardInfos = var_1.GetDisplayGroupList(var_30_1)

	local var_30_2 = arg_30_0.cardList

	var_1.SetTotalCount(var_30_2, #arg_30_0.cardInfos, -1)

	getProxy = var_1
	LoveLetterProxy = var_30_2

	local var_30_3 = var_1(var_30_2)
	local var_30_4 = arg_30_0.rtCountLevelPanel
	local var_30_5 = var_2.Find(var_30_4, "info")

	setText = var_30_4

	local var_30_6 = var_30_5
	local var_30_7 = var_30_5.Find(var_30_6, "word")

	i18n = var_30_6

	var_30_4(var_30_7, var_30_6("loveactivity_ui_10"))

	local var_30_8 = var_30_3
	local var_30_9 = var_30_3.GetAllLevel(var_30_8)

	setText = var_30_8

	var_30_8(var_30_5:Find("count"), var_30_9)

	local var_30_10, var_30_11 = var_30_3:GetAllLevelProgress()

	if var_30_11 == 0 then
		setSlider = var_6

		var_6(var_30_5:Find("Slider"), 0, 1, 1)
	else
		setSlider = var_6

		var_6(var_30_5:Find("Slider"), 0, var_30_11, var_30_10)
	end

	setText = var_6

	var_6(var_30_5:Find("Slider/Text"), var_30_10 .. "/" .. var_30_11)

	local var_30_12 = var_30_3
	local var_30_13 = var_30_3.GetAllLevelNextAward(var_30_12)

	updateDrop = var_30_12

	var_30_12(var_30_5:Find("icon/mask/IconTpl"), var_30_13[1])

	onButton = var_30_12

	local var_30_14 = arg_30_0
	local var_30_15 = var_30_5:Find("icon/mask/IconTpl")

	local function var_30_16()
		local var_31_0 = arg_30_0
		local var_31_1 = var_0.emit

		BaseUI = var_2_10002

		local var_31_2 = var_2_10002.ON_DROP

		drop = var_2_10003

		var_31_1(var_31_0, var_31_2, var_2_10003[1])

		return
	end

	SFX_PANEL = var_11

	var_30_12(var_30_14, var_30_15, var_30_16, var_11)

	setActive = var_30_12

	var_30_12(var_30_5:Find("icon/got"), var_30_11 == 0)

	onButton = var_30_12

	local var_30_17 = arg_30_0
	local var_30_18 = var_30_5:Find("click")

	local function var_30_19()
		getProxy = var_2_10000
		LoveLetterProxy = var_2_10001

		local var_32_0 = var_2_10000(var_2_10001)
		local var_32_1 = var_0.GetAllLevelReadyReward(var_32_0)

		pg = var_32_0

		local var_32_2 = var_32_0.NewStyleMsgboxMgr.GetInstance()
		local var_32_3 = var_1.Show

		pg = var_2_10003

		local var_32_4 = var_2_10003.NewStyleMsgboxMgr.TYPE_LOVE_LETTER_LEVEL_REWARD
		local var_32_5 = {}

		if #var_32_1 > 0 then
			local var_32_6 = {}
			local var_32_7 = {}

			pg = var_2_10007
			var_32_7.type = var_2_10007.NewStyleMsgboxMgr.BUTTON_TYPE.cancel
			i18n = var_7
			var_32_7.name = var_7("msgbox_text_cancel")
			SFX_CANCEL = var_7
			var_32_7.sound = var_7
			var_32_6[1] = var_32_7

			local var_32_8 = {}

			pg = var_7
			var_32_8.type = var_7.NewStyleMsgboxMgr.BUTTON_TYPE.confirm
			i18n = var_7
			var_32_8.name = var_7("mail_get_oneclick")

			function var_32_8.func()
				local var_33_0 = arg_30_0
				local var_33_1 = var_0.emit

				TrophyGalleryMediator = var_3_10002

				var_33_1(var_33_0, var_3_10002.ON_GET_ALL_LOVE_LETTER_REWARD, var_32_1)

				return
			end

			SFX_CONFIRM = var_7
			var_32_8.sound = var_7
			var_32_6[2] = var_32_8

			if not var_32_6 then
				var_32_6 = nil
			end

			var_32_5.btnList = var_32_6

			var_32_3(var_32_2, var_32_4, var_32_5)

			return
		end
	end

	SFX_PANEL = var_11

	var_30_12(var_30_17, var_30_18, var_30_19, var_11)

	return
end

function var_0_1.onInitCard(arg_34_0, arg_34_1)
	LoveLetterShipCard = var_1_10002

	local var_34_0 = var_1_10002.New(arg_34_1)

	onButton = var_3

	var_3(arg_34_0, var_34_0.go, function()
		if var_34_0.shipGroup then
			local var_35_0 = arg_34_0
			local var_35_1 = var_0.emit

			TrophyGalleryMediator = var_2_10002

			var_35_1(var_35_0, var_2_10002.OPEN_DISPLAY_WINDOW, var_34_0.shipGroup.id)
		end

		return
	end)

	arg_34_0.cardItems[arg_34_1] = var_34_0

	return
end

function var_0_1.onUpdateCard(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0

	if not arg_36_0.cardItems[arg_36_2] then
		arg_36_0:onInitCard(arg_36_2)

		var_36_0 = arg_36_0.cardItems[arg_36_2]
	end

	local var_36_1 = arg_36_1 + 1
	local var_36_2 = arg_36_0.cardInfos[var_36_1]

	var_36_0:update(var_36_2)

	pg = var_6

	local var_36_3 = var_6.EasyRedDotMgr.GetInstance()
	local var_36_4 = var_6.RegisterRedDot
	local var_36_5 = arg_36_2.transform

	var_36_4(var_36_3, var_8.Find(var_36_5, "content/pick_up"), {
		"love_letter_level_up"
	}, function(arg_37_0)
		getProxy = var_2_10001
		LoveLetterProxy = var_2_10002

		local var_37_0 = var_2_10001(var_2_10002)
		local var_37_1 = var_1.GetGroupData(var_37_0, var_36_2.id)

		setActive = var_37_0

		var_37_0(arg_37_0, var_37_1:GetDisplayLevel() < var_37_1:GetMaxLevel() and var_37_1:CanLevelUp())

		return
	end)

	return
end

function var_0_1.onReturnCard(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_0.exited then
		return
	end

	if arg_38_0.cardItems[arg_38_2] then
		var_3:clear()
	end

	arg_38_0.cardItems[arg_38_2] = nil

	return
end

function var_0_1.onBackPressed(arg_39_0)
	local var_39_0 = arg_39_0._trophyDetailPanel

	if var_1.IsActive(var_39_0) then
		local var_39_1 = arg_39_0._trophyDetailPanel

		var_1.SetActive(var_39_1, false)
	else
		var_0_1.super.onBackPressed(arg_39_0)
	end

	return
end

function var_0_1.willExit(arg_40_0)
	local var_40_0 = arg_40_0._loader

	var_1.Clear(var_40_0)

	pg = var_1

	local var_40_1 = var_1.EasyRedDotMgr.GetInstance()
	local var_40_2 = var_1.UnRegisterRedDot
	local var_40_3 = arg_40_0.toggleLoveLetter

	var_40_2(var_40_1, var_3.Find(var_40_3, "tip"))

	pg = var_40_2

	local var_40_4 = var_40_2.EasyRedDotMgr.GetInstance()
	local var_40_5 = var_1.UnRegisterRedDot
	local var_40_6 = arg_40_0.rtCountLevelPanel

	var_40_5(var_40_4, var_3.Find(var_40_6, "info/icon/tip"))

	pairs = var_40_5

	for iter_40_0, iter_40_1 in var_40_5(arg_40_0.cardItems) do
		pg = var_1_10006

		local var_40_7 = var_1_10006.EasyRedDotMgr.GetInstance()

		var_1_10006 = var_1_10006.UnRegisterRedDot

		local var_40_8 = iter_40_0.transform

		var_1_10006(var_40_7, var_8.Find(var_40_8, "content/pick_up"))
	end

	arg_40_0:UnOverlayPanel(arg_40_0._blurPanel, arg_40_0._tf)

	local var_40_9 = arg_40_0._trophyDetailPanel

	var_1.Dispose(var_40_9)

	return
end

return var_0_1
