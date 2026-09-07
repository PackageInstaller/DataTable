local ArchivesWorldBossListPage = class("ArchivesWorldBossListPage", import("view.base.BaseSubView"))
local var_0_1 = 1
local var_0_2 = 2

function ArchivesWorldBossListPage:getUIName()
	return "ArchivesWorldBossListUI"
end

function ArchivesWorldBossListPage:Setup(arg_2_1)
	self.proxy = arg_2_1

	return
end

function ArchivesWorldBossListPage:OnSwitchArchives()
	self.isInit = false

	if self.key then
		self:Filter(self.key)
	end

	return
end

function ArchivesWorldBossListPage:OnGetMetaAwards()
	if self.prevCard then
		self:UpdateAwards(self.prevCard.data)

		if self.key and not self.prevCard.data.progress.metaPtData:CanGetNextAward() then
			self:OnSwitchArchives()
		end

		self.prevCard:Update(self.prevCard.data)
	end

	return
end

function ArchivesWorldBossListPage:OnLoaded()
	self.toggles = {
		[var_0_2] = self._tf:Find("filter/finish"),
		[var_0_1] = self._tf:Find("filter/parse")
	}
	self.filterTr = self._tf:Find("filter")
	self.mainTr = self._tf:Find("main")
	self.scrollRect = self._tf:Find("main/list/scrollrect"):GetComponent("LScrollRect")
	self.paintingTr = self._tf:Find("main/paint")
	self.openTr = self._tf:Find("main/open")
	self.simulateBtn = self._tf:Find("main/simulate")
	self.ptIcon = self._tf:Find("main/award/pt/icon")
	self.ptTr = self._tf:Find("main/award/pt/Text"):GetComponent(typeof(Text))
	self.getAllBtn = self._tf:Find("main/award/get_all")
	self.awardScrollrect = self._tf:Find("main/award/scrollrect"):GetComponent("LScrollRect")
	self.awardArrTr = self._tf:Find("main/award/arr")
	self.emptyTr = self._tf:Find("empty")
	self.emptyFinishTr = self._tf:Find("empty_finsih")
	self.backBtn = self._tf:Find("blur_panel/adapt/top/back")
	self.msgBox = ArchivesWorldBossMsgboxPage.New(self._parentTf.parent, self.event)

	setText(self._tf:Find("main/award/pt/label"), i18n("meta_syn_value_label"))

	return
end

function ArchivesWorldBossListPage:OnInit()
	onButton(self, self.backBtn, function()
		self:emit(WorldBossScene.ON_QUIT_ARCHIVES_LIST)

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.world_archives_boss_list_help.tip
		})

		return
	end, SFX_CANCEL)

	self.cards = {}

	function self.scrollRect.onInitItem(arg_9_0)
		self:OnInitItem(arg_9_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_10_0, arg_10_1)
		self:OnUpdateItem(arg_10_0, arg_10_1)

		return
	end

	function self.awardScrollrect.onInitItem(arg_11_0)
		self:OnInitAwardItem(arg_11_0)

		return
	end

	function self.awardScrollrect.onUpdateItem(arg_12_0, arg_12_1)
		self:OnUpdateAwardItem(arg_12_0, arg_12_1)

		return
	end

	self.awardScrollrect.onValueChanged:AddListener(function(arg_13_0)
		setActive(self.awardArrTr, arg_13_0.x < 0.97)

		return
	end)

	for iter_6_0, iter_6_1 in pairs(self.toggles) do
		onToggle(self, iter_6_1, function(arg_14_0)
			self.isInit = false

			if arg_14_0 then
				self:Filter(iter_6_0)
			end

			return
		end, SFX_PANEL)
	end

	if self._tf:Find("empty_finsih") then
		GetComponent(self._tf:Find("empty_finsih"), typeof(Image)):SetNativeSize()
	end

	return
end

function ArchivesWorldBossListPage:Filter(arg_15_1)
	self.displays = {}

	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs((WorldBossConst.GetAchieveBossList())) do
		local var_15_1 = getProxy(MetaCharacterProxy):getMetaProgressVOByID(iter_15_1.meta_id)
		local var_15_2 = var_15_1:getMetaProgressPTState()
		local var_15_3 = not var_15_1.metaPtData:CanGetNextAward()

		if arg_15_1 == var_0_2 and var_15_3 then
			table.insert(self.displays, {
				id = iter_15_1.id,
				progress = var_15_1
			})
		elseif arg_15_1 == var_0_1 and not var_15_3 then
			table.insert(self.displays, {
				id = iter_15_1.id,
				progress = var_15_1
			})
		end

		var_15_0[iter_15_1.id] = var_15_2
	end

	local var_15_4 = WorldBossConst.GetArchivesId()

	table.sort(self.displays, function(arg_16_0, arg_16_1)
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

	self.key = arg_15_1

	local var_15_5 = #self.displays <= 0

	setActive(self.emptyTr, #self.displays <= 0 and arg_15_1 == var_0_1)
	setActive(self.emptyFinishTr, var_15_5 and arg_15_1 == var_0_2)
	setActive(self.mainTr, not var_15_5)
	self.scrollRect:SetTotalCount(#self.displays)

	return
end

function ArchivesWorldBossListPage:Update()
	self:Show()
	triggerToggle(self.toggles[var_0_1], true)

	return
end

function ArchivesWorldBossListPage:OnInitItem(arg_18_1)
	local var_18_0 = ArchivesWorldBossCard.New(arg_18_1)

	onButton(self, var_18_0._tf, function()
		if self.prevCard == var_18_0 and self.isInit then
			return
		end

		if self.prevCard then
			self.prevCard:UnSelect()
		end

		var_18_0:Select()
		self:ClickCard(var_18_0.data)

		self.prevCard = var_18_0
		self.prevBossId = var_18_0.bossId

		return
	end, SFX_PANEL)

	self.cards[arg_18_1] = var_18_0

	return
end

function ArchivesWorldBossListPage:OnUpdateItem(arg_20_1, arg_20_2)
	local var_20_0 = self.cards[arg_20_2]

	if not self.cards[arg_20_2] then
		self:OnInitItem(arg_20_2)

		var_20_0 = self.cards[arg_20_2]
	end

	var_20_0:Update(self.displays[arg_20_1 + 1])

	if self.prevBossId and self.prevBossId == var_20_0.bossId then
		var_20_0:Select()
	else
		var_20_0:UnSelect()
	end

	if arg_20_1 == 0 and not self.isInit then
		triggerButton(var_20_0._tf)

		self.isInit = true
	end

	return
end

function ArchivesWorldBossListPage:ClickCard(arg_21_1)
	self:UpdateMain(arg_21_1)
	self:UpdateAwards(arg_21_1)

	return
end

function ArchivesWorldBossListPage:UpdateMain(arg_22_1)
	setMetaPaintingPrefabAsync(self.paintingTr, arg_22_1.progress.id, "archives")

	local var_22_0 = arg_22_1.progress.metaPtData:IsMaxPt()
	local var_22_1 = arg_22_1.id == WorldBossConst.GetArchivesId() or var_22_0

	setActive(self.openTr, not var_22_1)
	setActive(self.simulateBtn, not arg_22_1.progress.metaPtData:CanGetNextAward())

	if var_22_1 then
		removeOnButton(self.openTr)
	else
		onButton(self, self.openTr, function()
			self:Switch(arg_22_1)

			return
		end, SFX_PANEL)
	end

	if var_22_0 then
		onButton(self, self.simulateBtn, function()
			self:Simulate(arg_22_1)

			return
		end)
	else
		removeOnButton(self.simulateBtn)
	end

	return
end

function ArchivesWorldBossListPage:Switch(arg_25_1)
	local var_25_0 = WorldBossConst.GetAchieveState()

	if var_25_0 == WorldBossConst.ACHIEVE_STATE_NOSTART then
		self:emit(WorldBossMediator.ON_SWITCH_ARCHIVES, arg_25_1.id)
	elseif var_25_0 == WorldBossConst.ACHIEVE_STATE_STARTING then
		self.msgBox:ExecuteAction("Show", {
			content = i18n("world_boss_switch_archives", pg.ship_data_statistics[pg.ship_strengthen_meta[WorldBossConst.BossId2MetaId((WorldBossConst.GetArchivesId()))].ship_id].name),
			onYes = function()
				self:emit(WorldBossMediator.ON_SWITCH_ARCHIVES, arg_25_1.id)

				return
			end
		})
	end

	return
end

function ArchivesWorldBossListPage:Simulate(arg_27_1)
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("meta_reproduce_btn"),
		onYes = function()
			self:emit(WorldBossMediator.ON_BATTLE, arg_27_1.id, false, 1, true)

			return
		end
	})

	return
end

function ArchivesWorldBossListPage:UpdateAwards(arg_29_1)
	local var_29_0 = arg_29_1.progress.metaPtData
	local var_29_1 = arg_29_1.progress.metaPtData.dropList
	local var_29_2 = arg_29_1.progress.metaPtData.targets

	setImageSprite(self.ptIcon, LoadSprite(arg_29_1.progress:getPtIconPath()))

	self.ptTr.text = var_29_0.count

	local var_29_3 = arg_29_1.progress.metaPtData:CanGetAward()

	setActive(self.getAllBtn, var_29_3)

	if not var_29_3 then
		removeOnButton(self.getAllBtn)
	else
		onButton(self, self.getAllBtn, function()
			local var_30_0, var_30_1 = self:getOneStepPTAwardLevelAndCount(arg_29_1.progress)

			pg.m02:sendNotification(GAME.GET_META_PT_AWARD, {
				groupID = arg_29_1.progress.id,
				targetCount = var_30_1
			})

			return
		end, SFX_PANEL)
	end

	self.awardCards = {}
	self.awardDisplays = {}

	for iter_29_0, iter_29_1 in ipairs(var_29_1) do
		table.insert(self.awardDisplays, {
			itemInfo = iter_29_1,
			target = var_29_2[iter_29_0],
			level = var_29_0.level,
			count = var_29_0.count,
			unlockPTNum = arg_29_1.progress.unlockPTNum
		})
	end

	self.awardScrollrect:SetTotalCount(#self.awardDisplays)
	self.awardScrollrect:ScrollTo((self.awardScrollrect:HeadIndexToValue((math.min(var_29_0.level, #var_29_2 - 5)))))

	return
end

function ArchivesWorldBossListPage:getOneStepPTAwardLevelAndCount(arg_31_1)
	local var_31_0 = arg_31_1.metaPtData:GetResProgress()
	local var_31_1 = arg_31_1:getStoryIndexList()
	local var_31_3 = 0

	for iter_31_0 = 1, #arg_31_1.metaPtData.targets do
		local var_31_4 = false
		local var_31_5 = false

		if var_31_0 >= arg_31_1.metaPtData.targets[iter_31_0] then
			var_31_4 = true
		end

		if var_31_1[iter_31_0] == 0 then
			var_31_5 = true
		elseif pg.NewStoryMgr.GetInstance():IsPlayed(var_31_1[iter_31_0]) then
			var_31_5 = true
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

function ArchivesWorldBossListPage:OnInitAwardItem(arg_32_1)
	local var_32_0 = ArchivesWorldBossAwardCard.New(arg_32_1)

	onButton(self, var_32_0.itemTF, function()
		self:emit(BaseUI.ON_DROP, var_32_0.dropInfo)

		return
	end, SFX_PANEL)

	self.awardCards[arg_32_1] = var_32_0

	return
end

function ArchivesWorldBossListPage:OnUpdateAwardItem(arg_34_1, arg_34_2)
	if not self.awardCards[arg_34_2] then
		self:OnInitAwardItem(arg_34_2)
	end

	self.awardCards[arg_34_2]:Update(self.awardDisplays[arg_34_1 + 1], arg_34_1 + 1)

	return
end

function ArchivesWorldBossListPage:OnDestroy()
	self.scrollRect.onInitItem = nil
	self.scrollRect.onUpdateItem = nil
	self.awardScrollrect.onInitItem = nil
	self.awardScrollrect.onUpdateItem = nil

	self.awardScrollrect.onValueChanged:RemoveAllListeners()

	if self.msgBox then
		self.msgBox:Destroy()

		self.msgBox = nil
	end

	for iter_35_0, iter_35_1 in pairs(self.cards) do
		iter_35_1:Dispose()
	end

	self.cards = nil

	for iter_35_2, iter_35_3 in pairs(self.awardCards or {}) do
		iter_35_3:Dispose()
	end

	self.awardCards = nil

	return
end

return ArchivesWorldBossListPage
