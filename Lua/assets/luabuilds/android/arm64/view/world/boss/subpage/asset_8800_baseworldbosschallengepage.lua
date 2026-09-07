local BaseWorldBossChallengePage = class("BaseWorldBossChallengePage", import("view.base.BaseSubView"))

BaseWorldBossChallengePage.Listeners = {
	onCacheBossUpdated = "OnCacheBossUpdated",
	onRankListUpdated = "OnRankListUpdated"
}

local var_0_1 = {
	[970701] = {
		411,
		777
	},
	[970702] = {
		411,
		574
	},
	[970201] = {
		296,
		610,
		0.95,
		0.95
	},
	[970703] = {
		1424,
		1267.9,
		1.7,
		1.7
	},
	[970401] = {
		480,
		635
	},
	[970402] = {
		480,
		635
	},
	[970403] = {
		510,
		611.2,
		0.95,
		0.95
	}
}

function BaseWorldBossChallengePage:Setup(arg_1_1)
	for iter_1_0, iter_1_1 in pairs(BaseWorldBossChallengePage.Listeners) do
		self[iter_1_0] = function(...)
			BaseWorldBossChallengePage[iter_1_1](self, ...)

			return
		end
	end

	self.proxy = arg_1_1

	return
end

function BaseWorldBossChallengePage:OnLoaded()
	self.rankPage = WorldBossRankPage.New(self._tf.parent.parent, self.event)

	self:AddListeners(self.proxy)

	return
end

function BaseWorldBossChallengePage:OnInit()
	self:UpdateEmptyCard()

	self.scrollRect = WorldBossItemList.New(self._tf:Find("list_panel/mask/bg/container"), self._tf:Find("list_panel/mask/tpl"))

	self.scrollRect:Make(function(arg_5_0, arg_5_1)
		self:OnInitCard(arg_5_0, arg_5_1)

		return
	end, function(arg_6_0, arg_6_1)
		self:OnPreviewCard(arg_6_0, arg_6_1)

		return
	end, function(arg_7_0, arg_7_1)
		self:OnSelectCard(arg_7_0, arg_7_1)

		return
	end)

	self.hpSlider = self._tf:Find("main/hp/slider"):GetComponent(typeof(Slider))
	self.levelTxt = self._tf:Find("main/hp/level/Text"):GetComponent(typeof(Text))
	self.hpTxt = self._tf:Find("main/hp/Text"):GetComponent(typeof(Text))
	self.expiredTimeTxt = self._tf:Find("main/time/Text"):GetComponent(typeof(Text))
	self.mainPanel = self._tf:Find("main")
	self.painting = self._tf:Find("paint")

	setActive(self.painting, false)
	setActive(self.mainPanel, false)

	self.rankBtn = self.mainPanel:Find("rank_btn")
	self.startBtn = self.mainPanel:Find("start_btn")
	self.refreshBtn = self._tf:Find("list_panel/frame/filter/refresh_btn")
	self.refreshBtnGray = self._tf:Find("list_panel/frame/filter/refresh_btn_gray")
	self.cdTime = 0

	onButton(self, self.refreshBtn, function()
		if self.cdTime <= pg.TimeMgr.GetInstance():GetServerTime() then
			self.worldBossId = nil

			self:emit(WorldBossMediator.UPDATE_CACHE_BOSS_HP, function()
				self:OnCacheBossUpdated()

				return
			end)
			assert(pg.gameset.world_boss_resfresh, "gameset >>>>>>>>>>world_boss_resfresh")

			self.cdTime = pg.TimeMgr.GetInstance():GetServerTime() + pg.gameset.world_boss_resfresh.key_value

			self:RotateRefreshBtn(pg.gameset.world_boss_resfresh.key_value)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_not_refresh_frequently"))
		end

		return
	end, SFX_PANEL)
	onButton(self, self.refreshBtnGray, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_not_refresh_frequently"))

		return
	end, SFX_PANEL)

	self.filterToggle = self._tf:Find("list_panel/frame/filter/toggles")
	self.filterFlags = {
		WorldBoss.BOSS_TYPE_WORLD,
		WorldBoss.BOSS_TYPE_FRIEND,
		WorldBoss.BOSS_TYPE_GUILD
	}

	onToggle(self, self._tf:Find("list_panel/frame/filter/toggles/friend"), function(arg_11_0)
		if arg_11_0 then
			self.filterFlags[2] = WorldBoss.BOSS_TYPE_FRIEND or -1
		end

		self:CheckToggle()
		self:UpdateNonProcessList()

		return
	end, SFX_PANEL)
	GetComponent(self._tf:Find("list_panel/frame/filter/toggles/friend/unsel"), typeof(Image)):SetNativeSize()
	GetComponent(self._tf:Find("list_panel/frame/filter/toggles/friend/sel"), typeof(Image)):SetNativeSize()
	GetComponent(self._tf:Find("list_panel/frame/filter/toggles/guild/sel"), typeof(Image)):SetNativeSize()
	GetComponent(self._tf:Find("list_panel/frame/filter/toggles/guild/unsel"), typeof(Image)):SetNativeSize()
	onToggle(self, self._tf:Find("list_panel/frame/filter/toggles/guild"), function(arg_12_0)
		if arg_12_0 then
			self.filterFlags[3] = WorldBoss.BOSS_TYPE_GUILD or -1
		end

		self:CheckToggle()
		self:UpdateNonProcessList()

		return
	end, SFX_PANEL)

	return
end

function BaseWorldBossChallengePage:UpdateEmptyCard()
	local var_13_0 = self._tf:Find("list_panel/mask/tpl"):Find("empty"):GetComponent(typeof(Image))

	var_13_0.sprite = GetSpriteFromAtlas("MetaWorldboss/" .. WorldBossConst.GetCurrBossGroup(), "item_04")

	var_13_0:SetNativeSize()

	return
end

function BaseWorldBossChallengePage:CheckToggle()
	if _.all(self.filterFlags, function(arg_15_0)
		return arg_15_0 == -1
	end) then
		triggerToggle(self._tf:Find("list_panel/frame/filter/toggles/friend"), true)
		triggerToggle(self._tf:Find("list_panel/frame/filter/toggles/guild"), true)
	end

	return
end

function BaseWorldBossChallengePage:GetResSuffix()
	return ""
end

function BaseWorldBossChallengePage:UpdatePainting(arg_17_1)
	if self.groupId ~= arg_17_1 then
		self.groupId = arg_17_1

		local var_17_0 = self._tf:Find("main/label"):GetComponent(typeof(Image))

		var_17_0.sprite = GetSpriteFromAtlas("MetaWorldboss/" .. arg_17_1, "title" .. self:GetResSuffix())

		var_17_0:SetNativeSize()
		setMetaPaintingPrefabAsync(self.painting, self.groupId, "lihuisha")

		local var_17_1 = pg.world_joint_boss_template[WorldBossConst.MetaId2BossId(self.groupId)].p_offset_other or var_0_1[self.groupId]

		if var_17_1 then
			setAnchoredPosition(self.painting, {
				x = var_17_1[1],
				y = var_17_1[2]
			})

			self.painting.localScale = Vector3(var_17_1[3] or 1, var_17_1[4] or 1, 1)
		end
	end

	return
end

function BaseWorldBossChallengePage:RotateRefreshBtn(arg_18_1)
	LeanTween.rotate(rtf(self.refreshBtn), -360, 0.5):setOnComplete(System.Action(function()
		self.refreshBtn.localEulerAngles = Vector3(0, 0, 0)

		setActive(self.refreshBtnGray, false)
		setActive(self.refreshBtnGray, true)

		return
	end))

	if self.refreshtimer then
		self.refreshtimer:Stop()

		self.refreshtimer = nil
	end

	self.refreshtimer = Timer.New(function()
		setActive(self.refreshBtnGray, true)
		setActive(self.refreshBtnGray, false)

		return
	end, arg_18_1, 1)

	self.refreshtimer:Start()

	return
end

function BaseWorldBossChallengePage:AddListeners(arg_21_1)
	arg_21_1:AddListener(WorldBossProxy.EventRankListUpdated, self.onRankListUpdated)
	arg_21_1:AddListener(WorldBossProxy.EventCacheBossListUpdated, self.onCacheBossUpdated)

	return
end

function BaseWorldBossChallengePage:RemoveListeners(arg_22_1)
	arg_22_1:RemoveListener(WorldBossProxy.EventRankListUpdated, self.onRankListUpdated)
	arg_22_1:RemoveListener(WorldBossProxy.EventCacheBossListUpdated, self.onCacheBossUpdated)

	return
end

function BaseWorldBossChallengePage:OnCacheBossUpdated()
	self:UpdateNonProcessList()

	return
end

function BaseWorldBossChallengePage:OnRankListUpdated(arg_24_1, arg_24_2, arg_24_3)
	if self.boss and self.boss.id == arg_24_3 and self.rankPage:GetLoaded() and self.rankPage:isActive() then
		self.rankPage:ExecuteAction("Update", self.proxy, self.boss.id)
	end

	return
end

function BaseWorldBossChallengePage:Update()
	self:emit(WorldBossMediator.UPDATE_CACHE_BOSS_HP, function()
		self:UpdateNonProcessList()
		self:Show()

		return
	end)

	return
end

function BaseWorldBossChallengePage:UpdateNonProcessList()
	local function var_27_0(arg_28_0)
		return _.any(_.select(self.filterFlags, function(arg_29_0)
			return arg_29_0 >= 0
		end), function(arg_30_0)
			return arg_28_0:GetType() == arg_30_0
		end)
	end

	self.displays = {}

	for iter_27_0, iter_27_1 in ipairs((self.proxy:GetCacheBossList())) do
		if not iter_27_1:isDeath() and not iter_27_1:IsExpired() and var_27_0(iter_27_1) and not iter_27_1:IsFullPeople() and self:OnFilterBoss(iter_27_1) then
			table.insert(self.displays, iter_27_1)
		end
	end

	table.sort(self.displays, function(arg_31_0, arg_31_1)
		return arg_31_0:GetJoinTime() > arg_31_1:GetJoinTime()
	end)

	local var_27_1 = 1

	for iter_27_2, iter_27_3 in ipairs(self.displays) do
		if iter_27_3.id == self.contextData.worldBossId or iter_27_3.id == self.worldBossId then
			var_27_1 = iter_27_2

			break
		end
	end

	self.contextData.worldBossId = nil
	WorldBossScene.inOtherBossBattle = nil

	self.scrollRect:Align(#self.displays, var_27_1)
	setActive(self.filterToggle, true)
	setActive(self.refreshBtn, true)

	return
end

function BaseWorldBossChallengePage:OnFilterBoss(arg_32_1)
	return true
end

function BaseWorldBossChallengePage:OnInitCard(arg_33_1, arg_33_2)
	local var_33_0 = self.displays[arg_33_2 + 1]
	local var_33_1 = false
	local var_33_2 = arg_33_1:Find("tags")

	removeOnButton(arg_33_1)
	setText(arg_33_1:Find("tags/friend/Text"), "")
	setText(arg_33_1:Find("tags/guild/Text"), "")

	if var_33_0 then
		var_33_1 = var_33_0:isDeath()

		local var_33_3 = var_33_0:GetType()

		setActive(arg_33_1:Find("tags/friend"), var_33_3 == WorldBoss.BOSS_TYPE_FRIEND)
		setActive(arg_33_1:Find("tags/guild"), var_33_3 == WorldBoss.BOSS_TYPE_GUILD)
		setActive(arg_33_1:Find("tags/world"), var_33_3 == WorldBoss.BOSS_TYPE_WORLD)

		var_33_2.anchoredPosition = Vector3(0, 14, 0)

		setText(arg_33_1:Find("tags/friend/Text"), var_33_0:GetRoleName())
		setText(arg_33_1:Find("tags/guild/Text"), var_33_0:GetRoleName())
		onButton(self, arg_33_1, function()
			self.scrollRect:SliceTo(arg_33_1)

			return
		end, SFX_PANEL)
		self:UpdateCardStyle(arg_33_1, var_33_0.config.meta_id)
	end

	setActive(arg_33_1:Find("complete"), var_33_0 and var_33_1)
	setActive(arg_33_1:Find("raiding"), var_33_0 and not var_33_1)
	setActive(arg_33_1:Find("empty"), not var_33_0)
	setActive(var_33_2, var_33_0)
	setActive(arg_33_1:Find("tags/friend/Text"), false)
	setActive(arg_33_1:Find("tags/guild/Text"), false)

	return
end

function BaseWorldBossChallengePage:UpdateCardStyle(arg_35_1, arg_35_2)
	arg_35_1:Find("raiding"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("MetaWorldboss/" .. arg_35_2, "item_03")

	local var_35_0 = arg_35_1:Find("empty"):GetComponent(typeof(Image))

	var_35_0.sprite = GetSpriteFromAtlas("MetaWorldboss/" .. arg_35_2, "item_04")

	var_35_0:SetNativeSize()

	arg_35_1:Find("selected/challenging"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("MetaWorldboss/" .. arg_35_2, "item_01" .. self:GetResSuffix())

	return
end

function BaseWorldBossChallengePage:OnPreviewCard(arg_36_1, arg_36_2)
	if self.prevSelected and self.prevSelected.boss then
		self.prevSelected.childTF:Find("tags").anchoredPosition = Vector3(0, 14, 0)

		setActive(self.prevSelected.childTF:Find("tags/friend/Text"), false)
		setActive(self.prevSelected.childTF:Find("tags/guild/Text"), false)
		setActive(self.prevSelected.childTF:Find("selected"), false)
	end

	local var_36_0 = self.displays[arg_36_2 + 1]

	if self.displays[arg_36_2 + 1] then
		local var_36_1 = var_36_0:isDeath()

		setActive(arg_36_1:Find("selected/challenging"), not var_36_1)
		setActive(arg_36_1:Find("selected/finished"), var_36_1)

		arg_36_1:Find("tags").anchoredPosition = Vector3(-17, 41.69, 0)

		setActive(arg_36_1:Find("tags/friend/Text"), true)
		setActive(arg_36_1:Find("tags/guild/Text"), true)
		self:UpdateMainView(var_36_0)
	end

	setActive(arg_36_1:Find("selected"), var_36_0)

	self.prevSelected = {
		childTF = arg_36_1,
		boss = var_36_0
	}

	return
end

function BaseWorldBossChallengePage:OnSelectCard(arg_37_1, arg_37_2)
	self.boss = self.displays[arg_37_2 + 1]
	self.worldBossId = nil

	if self.boss then
		self.worldBossId = self.displays[arg_37_2 + 1].id

		self:UpdateMainView(self.displays[arg_37_2 + 1])
	else
		setActive(self.mainPanel, false)
		setActive(self.painting, false)
	end

	return
end

function BaseWorldBossChallengePage:UpdateMainView(arg_38_1, arg_38_2)
	setActive(self.mainPanel, true)
	setActive(self.painting, true)

	local var_38_1 = arg_38_1:isDeath()
	local var_38_2 = arg_38_1:GetLeftTime()

	onButton(self, self.rankBtn, function()
		self.rankPage:ExecuteAction("Update", self.proxy, arg_38_1.id)

		return
	end, SFX_PANEL)

	self.hpSlider.value = 1
	self.levelTxt.text = arg_38_1:GetLevel()
	self.hpTxt.text = "HP:" .. arg_38_1:GetMaxHp()

	onButton(self, self.startBtn, function()
		self:emit(WorldBossMediator.ON_BATTLE, arg_38_1.id, true)

		return
	end, SFX_PANEL)
	setActive(self.startBtn, not var_38_1 and var_38_2 > 0)
	self:removeBattleTimer()

	if not var_38_1 and not arg_38_2 then
		self:addBattleTimer(arg_38_1)
	end

	self:UpdatePainting(arg_38_1.config.meta_id)

	return
end

function BaseWorldBossChallengePage:addBattleTimer(arg_41_1)
	local var_41_0 = arg_41_1:GetExpiredTime()

	if var_41_0 - pg.TimeMgr.GetInstance():GetServerTime() >= 0 then
		self.timer = Timer.New(function()
			if self.exited then
				self:removeBattleTimer()

				return
			end

			local var_42_0 = var_41_0 - pg.TimeMgr.GetInstance():GetServerTime()

			if var_42_0 <= 0 then
				self.expiredTimeTxt.text = i18n("world_word_expired")

				self:removeBattleTimer()
				self:UpdateMainView(arg_41_1, true)
			else
				self.expiredTimeTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_42_0)
			end

			return
		end, 1, -1)

		self.timer:Start()
		self.timer.func()
	else
		self.expiredTimeTxt.text = i18n("world_word_expired")

		self:UpdateMainView(arg_41_1, true)
	end

	return
end

function BaseWorldBossChallengePage:removeBattleTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function BaseWorldBossChallengePage:OnDestroy()
	retMetaPaintingPrefab(self.painting, self.groupId)
	self:RemoveListeners(self.proxy)
	self:removeBattleTimer()
	self.scrollRect:Dispose()
	self.rankPage:Destroy()

	if self.refreshtimer then
		self.refreshtimer:Stop()

		self.refreshtimer = nil
	end

	self.exited = true

	return
end

return BaseWorldBossChallengePage
