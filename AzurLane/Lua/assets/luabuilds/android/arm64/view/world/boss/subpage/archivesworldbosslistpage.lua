class = var_0_10000

local var_0_0 = "ArchivesWorldBossListPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))
local var_0_2 = 1
local var_0_3 = 2

function var_0_1.getUIName(arg_1_0)
	return "ArchivesWorldBossListUI"
end

function var_0_1.Setup(arg_2_0, arg_2_1)
	arg_2_0.proxy = arg_2_1

	return
end

function var_0_1.OnSwitchArchives(arg_3_0)
	arg_3_0.isInit = false

	if arg_3_0.key then
		arg_3_0:Filter(arg_3_0.key)
	end

	return
end

function var_0_1.OnGetMetaAwards(arg_4_0)
	if arg_4_0.prevCard then
		local var_4_0 = arg_4_0.prevCard.data

		arg_4_0:UpdateAwards(var_4_0)

		if arg_4_0.key then
			local var_4_1 = var_4_0.progress.metaPtData

			if not var_2.CanGetNextAward(var_4_1) then
				arg_4_0:OnSwitchArchives()
			end
		end

		local var_4_2 = arg_4_0.prevCard

		var_2.Update(var_4_2, arg_4_0.prevCard.data)
	end

	return
end

function var_0_1.OnLoaded(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = var_0_3
	local var_5_2 = arg_5_0._tf

	var_5_0[var_5_1] = var_3.Find(var_5_2, "filter/finish")

	local var_5_3 = var_0_2
	local var_5_4 = arg_5_0._tf

	var_5_0[var_5_3] = var_3.Find(var_5_4, "filter/parse")
	arg_5_0.toggles = var_5_0

	local var_5_5 = arg_5_0._tf

	arg_5_0.filterTr = var_1.Find(var_5_5, "filter")

	local var_5_6 = arg_5_0._tf

	arg_5_0.mainTr = var_1.Find(var_5_6, "main")

	local var_5_7 = arg_5_0._tf
	local var_5_8 = var_1.Find(var_5_7, "main/list/scrollrect")

	arg_5_0.scrollRect = var_1.GetComponent(var_5_8, "LScrollRect")

	local var_5_9 = arg_5_0._tf

	arg_5_0.paintingTr = var_1.Find(var_5_9, "main/paint")

	local var_5_10 = arg_5_0._tf

	arg_5_0.openTr = var_1.Find(var_5_10, "main/open")

	local var_5_11 = arg_5_0._tf

	arg_5_0.simulateBtn = var_1.Find(var_5_11, "main/simulate")

	local var_5_12 = arg_5_0._tf

	arg_5_0.ptIcon = var_1.Find(var_5_12, "main/award/pt/icon")

	local var_5_13 = arg_5_0._tf
	local var_5_14 = var_1.Find(var_5_13, "main/award/pt/Text")
	local var_5_15 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_5_0.ptTr = var_5_15(var_5_14, var_4(var_6))

	local var_5_16 = arg_5_0._tf

	arg_5_0.getAllBtn = var_1.Find(var_5_16, "main/award/get_all")

	local var_5_17 = arg_5_0._tf
	local var_5_18 = var_1.Find(var_5_17, "main/award/scrollrect")

	arg_5_0.awardScrollrect = var_1.GetComponent(var_5_18, "LScrollRect")

	local var_5_19 = arg_5_0._tf

	arg_5_0.awardArrTr = var_1.Find(var_5_19, "main/award/arr")

	local var_5_20 = arg_5_0._tf

	arg_5_0.emptyTr = var_1.Find(var_5_20, "empty")

	local var_5_21 = arg_5_0._tf

	arg_5_0.emptyFinishTr = var_1.Find(var_5_21, "empty_finsih")

	local var_5_22 = arg_5_0._tf

	arg_5_0.backBtn = var_1.Find(var_5_22, "blur_panel/adapt/top/back")
	ArchivesWorldBossMsgboxPage = var_1
	arg_5_0.msgBox = var_1.New(arg_5_0._parentTf.parent, arg_5_0.event)
	setText = var_1

	local var_5_23 = arg_5_0._tf
	local var_5_24 = var_3.Find(var_5_23, "main/award/pt/label")

	i18n = var_4

	var_1(var_5_24, var_4("meta_syn_value_label"))

	return
end

function var_0_1.OnInit(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.backBtn

	local function var_6_2()
		local var_7_0 = arg_6_0
		local var_7_1 = var_0.emit

		WorldBossScene = var_2_10003

		var_7_1(var_7_0, var_2_10003.ON_QUIT_ARCHIVES_LIST)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10006)

	onButton = var_1_10001

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0._tf
	local var_6_5 = var_4.Find(var_6_4, "help")

	local function var_6_6()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_8_2.type = var_2_10004
		pg = var_2_10004
		var_8_2.helps = var_2_10004.gametip.world_archives_boss_list_help.tip

		var_8_1(var_8_0, var_8_2)

		return
	end

	SFX_CANCEL = var_6_4

	var_1_10001(var_6_3, var_6_5, var_6_6, var_6_4)

	arg_6_0.cards = {}

	function arg_6_0.scrollRect.onInitItem(arg_9_0)
		local var_9_0 = arg_6_0

		var_1.OnInitItem(var_9_0, arg_9_0)

		return
	end

	function arg_6_0.scrollRect.onUpdateItem(arg_10_0, arg_10_1)
		local var_10_0 = arg_6_0

		var_2.OnUpdateItem(var_10_0, arg_10_0, arg_10_1)

		return
	end

	function arg_6_0.awardScrollrect.onInitItem(arg_11_0)
		local var_11_0 = arg_6_0

		var_1.OnInitAwardItem(var_11_0, arg_11_0)

		return
	end

	function arg_6_0.awardScrollrect.onUpdateItem(arg_12_0, arg_12_1)
		local var_12_0 = arg_6_0

		var_2.OnUpdateAwardItem(var_12_0, arg_12_0, arg_12_1)

		return
	end

	local var_6_7 = arg_6_0.awardScrollrect.onValueChanged

	var_1.AddListener(var_6_7, function(arg_13_0)
		setActive = var_2_10001

		var_2_10001(arg_6_0.awardArrTr, arg_13_0.x < 0.97)

		return
	end)

	pairs = var_1

	for iter_6_0, iter_6_1 in var_1(arg_6_0.toggles) do
		onToggle = var_6_4

		local var_6_8 = arg_6_0
		local var_6_9 = iter_6_1

		local function var_6_10(arg_14_0)
			arg_6_0.isInit = false

			if arg_14_0 then
				local var_14_0 = arg_6_0

				var_1.Filter(var_14_0, iter_6_0)
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_6_4(var_6_8, var_6_9, var_6_10, var_1_10011)
	end

	local var_6_11 = arg_6_0._tf

	if var_1.Find(var_6_11, "empty_finsih") then
		GetComponent = var_1

		local var_6_12 = arg_6_0._tf
		local var_6_13 = var_3.Find(var_6_12, "empty_finsih")

		typeof = var_4
		Image = var_6

		local var_6_14 = var_1(var_6_13, var_4(var_6))

		var_1.SetNativeSize(var_6_14)
	end

	return
end

function var_0_1.Filter(arg_15_0, arg_15_1)
	WorldBossConst = var_1_10002

	local var_15_0 = var_1_10002.GetAchieveBossList()

	arg_15_0.displays = {}

	local var_15_1 = {}

	pairs = var_1_10004

	for iter_15_0, iter_15_1 in var_1_10004(var_15_0) do
		getProxy = var_1_10009
		MetaCharacterProxy = var_1_10011
		var_1_10011 = var_1_10009(var_1_10011)

		local var_15_2 = var_1_10009.getMetaProgressVOByID(var_1_10011, iter_15_1.meta_id)
		local var_15_3 = var_1_10009.getMetaProgressPTState(var_15_2)
		local var_15_4 = var_1_10009.metaPtData

		var_1_10011 = not var_1_10011.CanGetNextAward(var_15_4)

		if arg_15_1 == var_0_3 and var_1_10011 then
			table = var_12

			var_12.insert(arg_15_0.displays, {
				id = iter_15_1.id,
				progress = var_1_10009
			})
		elseif arg_15_1 == var_0_2 and not var_1_10011 then
			table = var_12

			var_12.insert(arg_15_0.displays, {
				id = iter_15_1.id,
				progress = var_1_10009
			})
		end

		var_15_1[iter_15_1.id] = var_15_3
	end

	WorldBossConst = var_4

	local var_15_5 = var_4.GetArchivesId()

	table = var_5

	var_5.sort(arg_15_0.displays, function(arg_16_0, arg_16_1)
		if (arg_16_0.id == var_15_5 and 1 or 0) == (arg_16_1.id == var_15_5 and 1 or 0) then
			if var_15_1[arg_16_0.id] == var_15_1[arg_16_1.id] then
				return arg_16_0.progress.configId < arg_16_1.progress.configId
			else
				return var_5 < var_4
			end
		else
			return var_3 < var_2
		end

		return
	end)

	arg_15_0.key = arg_15_1

	local var_15_6 = #arg_15_0.displays <= 0

	setActive = var_6

	var_6(arg_15_0.emptyTr, var_15_6 and arg_15_1 == var_0_2)

	setActive = var_6

	var_6(arg_15_0.emptyFinishTr, var_15_6 and arg_15_1 == var_0_3)

	setActive = var_6

	var_6(arg_15_0.mainTr, not var_15_6)

	local var_15_7 = arg_15_0.scrollRect

	var_6.SetTotalCount(var_15_7, #arg_15_0.displays)

	return
end

function var_0_1.Update(arg_17_0)
	arg_17_0:Show()

	triggerToggle = var_1

	var_1(arg_17_0.toggles[var_0_2], true)

	return
end

function var_0_1.OnInitItem(arg_18_0, arg_18_1)
	ArchivesWorldBossCard = var_1_10002

	local var_18_0 = var_1_10002.New(arg_18_1)

	onButton = var_1_10003

	local var_18_1 = arg_18_0
	local var_18_2 = var_18_0._tf

	local function var_18_3()
		if arg_18_0.prevCard == var_18_0 and arg_18_0.isInit then
			return
		end

		if arg_18_0.prevCard then
			local var_19_0 = arg_18_0.prevCard

			var_0.UnSelect(var_19_0)
		end

		local var_19_1 = var_18_0

		var_0.Select(var_19_1)

		local var_19_2 = arg_18_0

		var_0.ClickCard(var_19_2, var_18_0.data)

		arg_18_0.prevCard = var_18_0
		arg_18_0.prevBossId = var_18_0.bossId

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_18_1, var_18_2, var_18_3, var_1_10008)

	arg_18_0.cards[arg_18_1] = var_18_0

	return
end

function var_0_1.OnUpdateItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0

	if not arg_20_0.cards[arg_20_2] then
		arg_20_0:OnInitItem(arg_20_2)

		var_20_0 = arg_20_0.cards[arg_20_2]
	end

	local var_20_1 = arg_20_0.displays[arg_20_1 + 1]

	var_20_0:Update(var_20_1)

	if arg_20_0.prevBossId and arg_20_0.prevBossId == var_20_0.bossId then
		var_20_0:Select()
	else
		var_20_0:UnSelect()
	end

	if arg_20_1 == 0 and not arg_20_0.isInit then
		triggerButton = var_5

		var_5(var_20_0._tf)

		arg_20_0.isInit = true
	end

	return
end

function var_0_1.ClickCard(arg_21_0, arg_21_1)
	arg_21_0:UpdateMain(arg_21_1)
	arg_21_0:UpdateAwards(arg_21_1)

	return
end

function var_0_1.UpdateMain(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1.progress.id

	setMetaPaintingPrefabAsync = var_1_10003

	var_1_10003(arg_22_0.paintingTr, var_22_0, "archives")

	WorldBossConst = var_1_10003

	local var_22_1 = var_1_10003.GetArchivesId()
	local var_22_2 = arg_22_1.progress.metaPtData
	local var_22_3 = var_4.IsMaxPt(var_22_2)
	local var_22_4 = arg_22_1.id == var_22_1 or var_22_3

	setActive = var_22_2

	var_22_2(arg_22_0.openTr, not var_22_4)

	setActive = var_22_2

	local var_22_5 = arg_22_0.simulateBtn
	local var_22_6 = arg_22_1.progress.metaPtData

	var_22_2(var_22_5, not var_9.CanGetNextAward(var_22_6))

	if var_22_4 then
		removeOnButton = var_22_2

		var_22_2(arg_22_0.openTr)
	else
		onButton = var_22_2

		local var_22_7 = arg_22_0
		local var_22_8 = arg_22_0.openTr

		local function var_22_9()
			local var_23_0 = arg_22_0

			var_0.Switch(var_23_0, arg_22_1)

			return
		end

		SFX_PANEL = var_22_6

		var_22_2(var_22_7, var_22_8, var_22_9, var_22_6)
	end

	if var_22_3 then
		onButton = var_22_2

		var_22_2(arg_22_0, arg_22_0.simulateBtn, function()
			local var_24_0 = arg_22_0

			var_0.Simulate(var_24_0, arg_22_1)

			return
		end)
	else
		removeOnButton = var_22_2

		var_22_2(arg_22_0.simulateBtn)
	end

	return
end

function var_0_1.Switch(arg_25_0, arg_25_1)
	WorldBossConst = var_1_10002

	local var_25_0 = var_1_10002.GetAchieveState()

	WorldBossConst = var_1_10003

	local var_25_1

	if var_25_0 == var_1_10003.ACHIEVE_STATE_NOSTART then
		var_1_10005 = arg_25_0
		var_25_1 = arg_25_0.emit
		WorldBossMediator = var_1_10006

		var_25_1(var_1_10005, var_1_10006.ON_SWITCH_ARCHIVES, arg_25_1.id)
	else
		WorldBossConst = var_25_1

		if var_25_0 == var_25_1.ACHIEVE_STATE_STARTING then
			WorldBossConst = var_3

			local var_25_2 = var_3.GetArchivesId()

			WorldBossConst = var_1_10004

			local var_25_3 = var_1_10004.BossId2MetaId(var_25_2)

			pg = var_1_10005

			local var_25_4 = var_1_10005.ship_strengthen_meta[var_25_3].ship_id

			pg = var_6

			local var_25_5 = var_6.ship_data_statistics[var_25_4].name
			local var_25_6 = arg_25_0.msgBox
			local var_25_7 = var_7.ExecuteAction
			local var_25_8 = "Show"
			local var_25_9 = {}

			i18n = var_1_10012
			var_25_9.content = var_1_10012("world_boss_switch_archives", var_25_5)

			function var_25_9.onYes()
				local var_26_0 = arg_25_0
				local var_26_1 = var_0.emit

				WorldBossMediator = var_2_10003

				var_26_1(var_26_0, var_2_10003.ON_SWITCH_ARCHIVES, arg_25_1.id)

				return
			end

			var_25_7(var_25_6, var_25_8, var_25_9)
		end
	end

	return
end

function var_0_1.Simulate(arg_27_0, arg_27_1)
	pg = var_1_10002

	local var_27_0 = var_1_10002.MsgboxMgr.GetInstance()
	local var_27_1 = var_2.ShowMsgBox
	local var_27_2 = {}

	i18n = var_1_10006
	var_27_2.content = var_1_10006("meta_reproduce_btn")

	function var_27_2.onYes()
		local var_28_0 = arg_27_0
		local var_28_1 = var_0.emit

		WorldBossMediator = var_2_10003

		var_28_1(var_28_0, var_2_10003.ON_BATTLE, arg_27_1.id, false, 1, true)

		return
	end

	var_27_1(var_27_0, var_27_2)

	return
end

function var_0_1.UpdateAwards(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1.progress.metaPtData.dropList
	local var_29_1 = var_2.targets

	setImageSprite = var_1_10005

	local var_29_2 = arg_29_0.ptIcon

	LoadSprite = var_1_10008

	local var_29_3 = arg_29_1.progress

	var_1_10005(var_29_2, var_1_10008(var_10.getPtIconPath(var_29_3)))

	arg_29_0.ptTr.text = var_2.count

	local var_29_4 = arg_29_1.progress.metaPtData
	local var_29_5 = var_5.CanGetAward(var_29_4)

	setActive = var_6

	var_6(arg_29_0.getAllBtn, var_29_5)

	if not var_29_5 then
		removeOnButton = var_6

		var_6(arg_29_0.getAllBtn)
	else
		onButton = var_6

		local var_29_6 = arg_29_0
		local var_29_7 = arg_29_0.getAllBtn

		local function var_29_8()
			local var_30_0 = arg_29_0
			local var_30_1, var_30_2 = var_0.getOneStepPTAwardLevelAndCount(var_30_0, arg_29_1.progress)

			pg = var_30_0

			local var_30_3 = var_30_0.m02
			local var_30_4 = var_2.sendNotification

			GAME = var_2_10005

			var_30_4(var_30_3, var_2_10005.GET_META_PT_AWARD, {
				groupID = arg_29_1.progress.id,
				targetCount = var_30_2
			})

			return
		end

		SFX_PANEL = var_1_10011

		var_6(var_29_6, var_29_7, var_29_8, var_1_10011)
	end

	arg_29_0.awardCards = {}
	arg_29_0.awardDisplays = {}
	ipairs = var_6

	for iter_29_0, iter_29_1 in var_6(var_29_0) do
		table = var_1_10011

		var_1_10011.insert(arg_29_0.awardDisplays, {
			itemInfo = iter_29_1,
			target = var_29_1[iter_29_0],
			level = var_2.level,
			count = var_2.count,
			unlockPTNum = arg_29_1.progress.unlockPTNum
		})
	end

	local var_29_9 = arg_29_0.awardScrollrect

	var_6.SetTotalCount(var_29_9, #arg_29_0.awardDisplays)

	math = var_6

	local var_29_10 = var_6.min(var_2.level, #var_29_1 - 5)
	local var_29_11 = arg_29_0.awardScrollrect
	local var_29_12 = var_7.HeadIndexToValue(var_29_11, var_29_10)
	local var_29_13 = arg_29_0.awardScrollrect

	var_8.ScrollTo(var_29_13, var_29_12)

	return
end

function var_0_1.getOneStepPTAwardLevelAndCount(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_1.metaPtData
	local var_31_1 = var_2.GetResProgress(var_31_0)
	local var_31_2 = arg_31_1.metaPtData.targets
	local var_31_3 = arg_31_1:getStoryIndexList()
	local var_31_4 = arg_31_1.unlockPTLevel
	local var_31_5 = 0

	for iter_31_0 = 1, #var_31_2 do
		local var_31_6 = false
		local var_31_7 = false

		if var_31_1 >= var_31_2[iter_31_0] then
			var_31_6 = true
		end

		if var_31_3[iter_31_0] == 0 then
			var_31_7 = true
		else
			pg = var_1_10015

			local var_31_8 = var_1_10015.NewStoryMgr.GetInstance()

			if var_1_10015.IsPlayed(var_31_8, var_14) then
				var_31_7 = true
			end
		end

		if var_31_6 and var_31_7 then
			var_31_5 = iter_31_0
		else
			break
		end
	end

	print = var_7

	var_7("calc max level", var_31_5, var_31_2[var_31_5])

	return var_31_5, var_31_2[var_31_5]
end

function var_0_1.OnInitAwardItem(arg_32_0, arg_32_1)
	ArchivesWorldBossAwardCard = var_1_10002

	local var_32_0 = var_1_10002.New(arg_32_1)

	onButton = var_1_10003

	local var_32_1 = arg_32_0
	local var_32_2 = var_32_0.itemTF

	local function var_32_3()
		local var_33_0 = arg_32_0
		local var_33_1 = var_0.emit

		BaseUI = var_2_10003

		var_33_1(var_33_0, var_2_10003.ON_DROP, var_32_0.dropInfo)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_32_1, var_32_2, var_32_3, var_1_10008)

	arg_32_0.awardCards[arg_32_1] = var_32_0

	return
end

function var_0_1.OnUpdateAwardItem(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0

	if not arg_34_0.awardCards[arg_34_2] then
		arg_34_0:OnInitAwardItem(arg_34_2)

		var_34_0 = arg_34_0.awardCards[arg_34_2]
	end

	local var_34_1 = arg_34_0.awardDisplays[arg_34_1 + 1]

	var_34_0:Update(var_34_1, arg_34_1 + 1)

	return
end

function var_0_1.OnDestroy(arg_35_0)
	arg_35_0.scrollRect.onInitItem = nil
	arg_35_0.scrollRect.onUpdateItem = nil
	arg_35_0.awardScrollrect.onInitItem = nil
	arg_35_0.awardScrollrect.onUpdateItem = nil

	local var_35_0 = arg_35_0.awardScrollrect.onValueChanged

	var_1.RemoveAllListeners(var_35_0)

	if arg_35_0.msgBox then
		local var_35_1 = arg_35_0.msgBox

		var_1.Destroy(var_35_1)

		arg_35_0.msgBox = nil
	end

	pairs = var_1

	for iter_35_0, iter_35_1 in var_1(arg_35_0.cards) do
		iter_35_1:Dispose()
	end

	arg_35_0.cards = nil
	pairs = var_1

	local var_35_2

	if not arg_35_0.awardCards then
		var_35_2 = {}
	end

	for iter_35_2, iter_35_3 in var_1(var_35_2) do
		iter_35_3:Dispose()
	end

	arg_35_0.awardCards = nil

	return
end

return var_0_1
