local var_0_0 = class("ArchivesWorldBossListPage", import("view.base.BaseSubView"))
local var_0_1 = 1
local var_0_2 = 2

function var_0_0.getUIName(arg_1_0)
	return "ArchivesWorldBossListUI"
end

function var_0_0.Setup(arg_2_0, arg_2_1)
	arg_2_0.proxy = arg_2_1

	return
end

function var_0_0.OnSwitchArchives(arg_3_0)
	arg_3_0.isInit = false

	if arg_3_0.key then
		arg_3_0:Filter(arg_3_0.key)
	end

	return
end

function var_0_0.OnGetMetaAwards(arg_4_0)
	if arg_4_0.prevCard then
		arg_4_0:UpdateAwards(arg_4_0.prevCard.data)

		if arg_4_0.key and not arg_4_0.prevCard.data.progress.metaPtData:CanGetNextAward() then
			arg_4_0:OnSwitchArchives()
		end

		arg_4_0.prevCard:Update(arg_4_0.prevCard.data)
	end

	return
end

function var_0_0.OnLoaded(arg_5_0)
	arg_5_0.toggles = {
		[var_0_2] = arg_5_0._tf:Find("filter/finish"),
		[var_0_1] = arg_5_0._tf:Find("filter/parse")
	}
	arg_5_0.filterTr = arg_5_0._tf:Find("filter")
	arg_5_0.mainTr = arg_5_0._tf:Find("main")
	arg_5_0.scrollRect = arg_5_0._tf:Find("main/list/scrollrect"):GetComponent("LScrollRect")
	arg_5_0.paintingTr = arg_5_0._tf:Find("main/paint")
	arg_5_0.openTr = arg_5_0._tf:Find("main/open")
	arg_5_0.simulateBtn = arg_5_0._tf:Find("main/simulate")
	arg_5_0.ptIcon = arg_5_0._tf:Find("main/award/pt/icon")
	arg_5_0.ptTr = arg_5_0._tf:Find("main/award/pt/Text"):GetComponent(typeof(Text))
	arg_5_0.getAllBtn = arg_5_0._tf:Find("main/award/get_all")
	arg_5_0.awardScrollrect = arg_5_0._tf:Find("main/award/scrollrect"):GetComponent("LScrollRect")
	arg_5_0.awardArrTr = arg_5_0._tf:Find("main/award/arr")
	arg_5_0.emptyTr = arg_5_0._tf:Find("empty")
	arg_5_0.emptyFinishTr = arg_5_0._tf:Find("empty_finsih")
	arg_5_0.backBtn = arg_5_0._tf:Find("blur_panel/adapt/top/back")
	arg_5_0.msgBox = ArchivesWorldBossMsgboxPage.New(arg_5_0._parentTf.parent, arg_5_0.event)

	setText(arg_5_0._tf:Find("main/award/pt/label"), i18n("meta_syn_value_label"))

	return
end

function var_0_0.OnInit(arg_6_0)
	onButton(arg_6_0, arg_6_0.backBtn, function()
		arg_6_0:emit(WorldBossScene.ON_QUIT_ARCHIVES_LIST)

		return
	end, SFX_CANCEL)
	onButton(arg_6_0, arg_6_0._tf:Find("help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.world_archives_boss_list_help.tip
		})

		return
	end, SFX_CANCEL)

	arg_6_0.cards = {}

	function arg_6_0.scrollRect.onInitItem(arg_9_0)
		arg_6_0:OnInitItem(arg_9_0)

		return
	end

	function arg_6_0.scrollRect.onUpdateItem(arg_10_0, arg_10_1)
		arg_6_0:OnUpdateItem(arg_10_0, arg_10_1)

		return
	end

	function arg_6_0.awardScrollrect.onInitItem(arg_11_0)
		arg_6_0:OnInitAwardItem(arg_11_0)

		return
	end

	function arg_6_0.awardScrollrect.onUpdateItem(arg_12_0, arg_12_1)
		arg_6_0:OnUpdateAwardItem(arg_12_0, arg_12_1)

		return
	end

	arg_6_0.awardScrollrect.onValueChanged:AddListener(function(arg_13_0)
		setActive(arg_6_0.awardArrTr, arg_13_0.x < 0.97)

		return
	end)

	for iter_6_0, iter_6_1 in pairs(arg_6_0.toggles) do
		onToggle(arg_6_0, iter_6_1, function(arg_14_0)
			arg_6_0.isInit = false

			if arg_14_0 then
				arg_6_0:Filter(iter_6_0)
			end

			return
		end, SFX_PANEL)
	end

	if arg_6_0._tf:Find("empty_finsih") then
		GetComponent(arg_6_0._tf:Find("empty_finsih"), typeof(Image)):SetNativeSize()
	end

	return
end

function var_0_0.Filter(arg_15_0, arg_15_1)
	arg_15_0.displays = {}

	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs((WorldBossConst.GetAchieveBossList())) do
		local var_15_1 = getProxy(MetaCharacterProxy):getMetaProgressVOByID(iter_15_1.meta_id)
		local var_15_2 = var_15_1:getMetaProgressPTState()
		local var_15_3 = not var_15_1.metaPtData:CanGetNextAward()

		if arg_15_1 == var_0_2 and var_15_3 then
			table.insert(arg_15_0.displays, {
				id = iter_15_1.id,
				progress = var_15_1
			})
		elseif arg_15_1 == var_0_1 and not var_15_3 then
			table.insert(arg_15_0.displays, {
				id = iter_15_1.id,
				progress = var_15_1
			})
		end

		var_15_0[iter_15_1.id] = var_15_2
	end

	local var_15_4 = WorldBossConst.GetArchivesId()

	table.sort(arg_15_0.displays, function(arg_16_0, arg_16_1)
		local var_16_0 = arg_16_0.id == var_15_4 and 1 or 0
		local var_16_1 = arg_16_1.id == var_15_4 and 1 or 0

		if (arg_16_0.id == var_15_4 and 1 or 0) == (arg_16_1.id == var_15_4 and 1 or 0) then
			local var_16_2 = var_15_0[arg_16_0.id]
			local var_16_3 = var_15_0[arg_16_1.id]

			if var_15_0[arg_16_0.id] == var_15_0[arg_16_1.id] then
				return arg_16_0.progress.configId < arg_16_1.progress.configId
			else
				return var_16_3 < var_16_2
			end
		else
			return var_16_1 < var_16_0
		end

		return
	end)

	arg_15_0.key = arg_15_1

	local var_15_5 = #arg_15_0.displays <= 0

	setActive(arg_15_0.emptyTr, #arg_15_0.displays <= 0 and arg_15_1 == var_0_1)
	setActive(arg_15_0.emptyFinishTr, var_15_5 and arg_15_1 == var_0_2)
	setActive(arg_15_0.mainTr, not var_15_5)
	arg_15_0.scrollRect:SetTotalCount(#arg_15_0.displays)

	return
end

function var_0_0.Update(arg_17_0)
	arg_17_0:Show()
	triggerToggle(arg_17_0.toggles[var_0_1], true)

	return
end

function var_0_0.OnInitItem(arg_18_0, arg_18_1)
	local var_18_0 = ArchivesWorldBossCard.New(arg_18_1)

	onButton(arg_18_0, var_18_0._tf, function()
		if arg_18_0.prevCard == var_18_0 and arg_18_0.isInit then
			return
		end

		if arg_18_0.prevCard then
			arg_18_0.prevCard:UnSelect()
		end

		var_18_0:Select()
		arg_18_0:ClickCard(var_18_0.data)

		arg_18_0.prevCard = var_18_0
		arg_18_0.prevBossId = var_18_0.bossId

		return
	end, SFX_PANEL)

	arg_18_0.cards[arg_18_1] = var_18_0

	return
end

function var_0_0.OnUpdateItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0.cards[arg_20_2]

	if not arg_20_0.cards[arg_20_2] then
		arg_20_0:OnInitItem(arg_20_2)

		var_20_0 = arg_20_0.cards[arg_20_2]
	end

	var_20_0:Update(arg_20_0.displays[arg_20_1 + 1])

	if arg_20_0.prevBossId and arg_20_0.prevBossId == var_20_0.bossId then
		var_20_0:Select()
	else
		var_20_0:UnSelect()
	end

	if arg_20_1 == 0 and not arg_20_0.isInit then
		triggerButton(var_20_0._tf)

		arg_20_0.isInit = true
	end

	return
end

function var_0_0.ClickCard(arg_21_0, arg_21_1)
	arg_21_0:UpdateMain(arg_21_1)
	arg_21_0:UpdateAwards(arg_21_1)

	return
end

function var_0_0.UpdateMain(arg_22_0, arg_22_1)
	setMetaPaintingPrefabAsync(arg_22_0.paintingTr, arg_22_1.progress.id, "archives")

	local var_22_0 = arg_22_1.progress.metaPtData:IsMaxPt()
	local var_22_1 = arg_22_1.id == WorldBossConst.GetArchivesId() or var_22_0

	setActive(arg_22_0.openTr, not var_22_1)
	setActive(arg_22_0.simulateBtn, not arg_22_1.progress.metaPtData:CanGetNextAward())

	if var_22_1 then
		removeOnButton(arg_22_0.openTr)
	else
		onButton(arg_22_0, arg_22_0.openTr, function()
			arg_22_0:Switch(arg_22_1)

			return
		end, SFX_PANEL)
	end

	if var_22_0 then
		onButton(arg_22_0, arg_22_0.simulateBtn, function()
			arg_22_0:Simulate(arg_22_1)

			return
		end)
	else
		removeOnButton(arg_22_0.simulateBtn)
	end

	return
end

function var_0_0.Switch(arg_25_0, arg_25_1)
	local var_25_0 = WorldBossConst.GetAchieveState()

	if var_25_0 == WorldBossConst.ACHIEVE_STATE_NOSTART then
		arg_25_0:emit(WorldBossMediator.ON_SWITCH_ARCHIVES, arg_25_1.id)
	elseif var_25_0 == WorldBossConst.ACHIEVE_STATE_STARTING then
		arg_25_0.msgBox:ExecuteAction("Show", {
			content = i18n("world_boss_switch_archives", pg.ship_data_statistics[pg.ship_strengthen_meta[WorldBossConst.BossId2MetaId((WorldBossConst.GetArchivesId()))].ship_id].name),
			onYes = function()
				arg_25_0:emit(WorldBossMediator.ON_SWITCH_ARCHIVES, arg_25_1.id)

				return
			end
		})
	end

	return
end

function var_0_0.Simulate(arg_27_0, arg_27_1)
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("meta_reproduce_btn"),
		onYes = function()
			arg_27_0:emit(WorldBossMediator.ON_BATTLE, arg_27_1.id, false, 1, true)

			return
		end
	})

	return
end

function var_0_0.UpdateAwards(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1.progress.metaPtData
	local var_29_1 = arg_29_1.progress.metaPtData.dropList
	local var_29_2 = arg_29_1.progress.metaPtData.targets

	setImageSprite(arg_29_0.ptIcon, LoadSprite(arg_29_1.progress:getPtIconPath()))

	arg_29_0.ptTr.text = var_29_0.count

	local var_29_3 = arg_29_1.progress.metaPtData:CanGetAward()

	setActive(arg_29_0.getAllBtn, var_29_3)

	if not var_29_3 then
		removeOnButton(arg_29_0.getAllBtn)
	else
		onButton(arg_29_0, arg_29_0.getAllBtn, function()
			local var_30_0, var_30_1 = arg_29_0:getOneStepPTAwardLevelAndCount(arg_29_1.progress)

			pg.m02:sendNotification(GAME.GET_META_PT_AWARD, {
				groupID = arg_29_1.progress.id,
				targetCount = var_30_1
			})

			return
		end, SFX_PANEL)
	end

	arg_29_0.awardCards = {}
	arg_29_0.awardDisplays = {}

	for iter_29_0, iter_29_1 in ipairs(var_29_1) do
		table.insert(arg_29_0.awardDisplays, {
			itemInfo = iter_29_1,
			target = var_29_2[iter_29_0],
			level = var_29_0.level,
			count = var_29_0.count,
			unlockPTNum = arg_29_1.progress.unlockPTNum
		})
	end

	arg_29_0.awardScrollrect:SetTotalCount(#arg_29_0.awardDisplays)
	arg_29_0.awardScrollrect:ScrollTo((arg_29_0.awardScrollrect:HeadIndexToValue((math.min(var_29_0.level, #var_29_2 - 5)))))

	return
end

function var_0_0.getOneStepPTAwardLevelAndCount(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_1.metaPtData:GetResProgress()
	local var_31_1 = arg_31_1:getStoryIndexList()
	local var_31_3 = 0

	for iter_31_0 = 1, #arg_31_1.metaPtData.targets do
		local var_31_4 = false
		local var_31_5 = false

		if var_31_0 >= arg_31_1.metaPtData.targets[iter_31_0] then
			var_31_4 = true
		end

		local var_31_6 = var_31_1[iter_31_0]

		if var_31_1[iter_31_0] == 0 then
			var_31_5 = true
		else
			local var_31_7 = pg.NewStoryMgr.GetInstance()

			if var_31_7:IsPlayed(var_31_6) then
				var_31_5 = true
			end
		end

		if var_31_4 and var_31_5 then
			var_31_3 = iter_31_0
		else
			break
		end
	end

	print("calc max level", var_31_3, arg_31_1.metaPtData.targets[var_31_3])

	return var_31_3, arg_31_1.metaPtData.targets[var_31_3]
end

function var_0_0.OnInitAwardItem(arg_32_0, arg_32_1)
	local var_32_0 = ArchivesWorldBossAwardCard.New(arg_32_1)

	onButton(arg_32_0, var_32_0.itemTF, function()
		arg_32_0:emit(BaseUI.ON_DROP, var_32_0.dropInfo)

		return
	end, SFX_PANEL)

	arg_32_0.awardCards[arg_32_1] = var_32_0

	return
end

function var_0_0.OnUpdateAwardItem(arg_34_0, arg_34_1, arg_34_2)
	if not arg_34_0.awardCards[arg_34_2] then
		arg_34_0:OnInitAwardItem(arg_34_2)
	end

	arg_34_0.awardCards[arg_34_2]:Update(arg_34_0.awardDisplays[arg_34_1 + 1], arg_34_1 + 1)

	return
end

function var_0_0.OnDestroy(arg_35_0)
	arg_35_0.scrollRect.onInitItem = nil
	arg_35_0.scrollRect.onUpdateItem = nil
	arg_35_0.awardScrollrect.onInitItem = nil
	arg_35_0.awardScrollrect.onUpdateItem = nil

	arg_35_0.awardScrollrect.onValueChanged:RemoveAllListeners()

	if arg_35_0.msgBox then
		arg_35_0.msgBox:Destroy()

		arg_35_0.msgBox = nil
	end

	for iter_35_0, iter_35_1 in pairs(arg_35_0.cards) do
		iter_35_1:Dispose()
	end

	arg_35_0.cards = nil

	local var_35_0 = arg_35_0.awardCards or {}

	for iter_35_2, iter_35_3 in pairs(var_35_0) do
		iter_35_3:Dispose()
	end

	arg_35_0.awardCards = nil

	return
end

return var_0_0
