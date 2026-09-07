local BaseWorldBossDetailPage = class("BaseWorldBossDetailPage", import("....base.BaseSubView"))
local var_0_1 = {
	[970701] = {
		-36.45481,
		717.0379
	},
	[970702] = {
		-36.45481,
		629.5
	},
	[970201] = {
		-36.45481,
		610.5,
		0.95,
		0.95
	},
	[970703] = {
		818,
		1268.1,
		1.7,
		1.7
	},
	[970401] = {
		-58.2,
		634.2
	},
	[970402] = {
		-58.2,
		634.2
	},
	[970403] = {
		-28.2,
		609.2,
		0.95,
		0.95
	}
}

function BaseWorldBossDetailPage:Setup(arg_1_1)
	for iter_1_0, iter_1_1 in pairs({
		onBossUpdated = "OnBossUpdated",
		onRankListUpdated = "OnRankListUpdated",
		onPtUpdated = "OnPtUpdated",
		onBossProgressUpdate = "OnBossProgressUpdate"
	}) do
		self[iter_1_0] = function(...)
			BaseWorldBossDetailPage[iter_1_1](self, ...)

			return
		end
	end

	self.proxy = arg_1_1

	self:AddListeners(self.proxy)

	return
end

function BaseWorldBossDetailPage:OnLoaded()
	self.supportBtn = self._tf:Find("btns/help_btn")
	self.startBtn = self._tf:Find("btns/start_btn")
	self.awardBtn = self._tf:Find("btns/award_btn")
	self.timeTF = self._tf:Find("btns/time")
	self.leftTime = self._tf:Find("btns/time/label/Text"):GetComponent(typeof(Text))
	self.awardList = UIItemList.New(self._tf:Find("award_panel/list"), self._tf:Find("award_panel/list/tpl"))
	self.levelTxt = self._tf:Find("hp/level/Text"):GetComponent(typeof(Text))
	self.hpTxt = self._tf:Find("hp/Text"):GetComponent(typeof(Text))
	self.hpSlider = self._tf:Find("hp/slider"):GetComponent(typeof(Slider))
	self.painting = self._tf:Find("paint")
	self.infoAndRankPanel = WorldBossInfoAndRankPanel.New(self._tf, self.event)

	self.infoAndRankPanel:SetCallback(function(arg_4_0)
		setGray(self.awardBtn, arg_4_0, true)

		return
	end, function(arg_5_0, arg_5_1)
		setGray(self.supportBtn, arg_5_1 <= arg_5_0, true)
		onButton(self, self.supportBtn, function()
			if arg_5_0 >= arg_5_1 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_max_challenge_people_cnt"))

				return
			end

			if self.boss:isDeath() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_boss_is_death"))
			else
				self:OnRescue()
			end

			return
		end, SFX_PANEL)

		return
	end)
	setText(self._tf:Find("btns/time/label"), i18n("time_remaining_tip"))

	return
end

function BaseWorldBossDetailPage:OnInit()
	onButton(self, self.startBtn, function()
		self:OnStart()

		return
	end, SFX_PANEL)
	onButton(self, self.awardBtn, function()
		if self.boss:GetLeftTime() <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_boss_award_expired"))
		else
			if self.boss:ShouldWaitForResult() then
				return
			end

			self:emit(WorldBossMediator.ON_SUBMIT_AWARD, self.boss.id)
		end

		return
	end, SFX_PANEL)

	return
end

function BaseWorldBossDetailPage:OnStart()
	if self.boss:isDeath() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_boss_is_death"))
	elseif self.boss:GetLeftTime() <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_boss_is_death"))
	else
		self:emit(WorldBossMediator.ON_BATTLE, self.boss.id, false, self.hpSlider.value)
	end

	return
end

function BaseWorldBossDetailPage:AddListeners(arg_11_1)
	arg_11_1:AddListener(WorldBossProxy.EventPtUpdated, self.onPtUpdated)
	arg_11_1:AddListener(WorldBossProxy.EventBossUpdated, self.onBossUpdated)
	arg_11_1:AddListener(WorldBossProxy.EventRankListUpdated, self.onRankListUpdated)
	arg_11_1:AddListener(WorldBossProxy.EventUnlockProgressUpdated, self.onBossProgressUpdate)

	return
end

function BaseWorldBossDetailPage:RemoveListeners(arg_12_1)
	arg_12_1:RemoveListener(WorldBossProxy.EventPtUpdated, self.onPtUpdated)
	arg_12_1:RemoveListener(WorldBossProxy.EventBossUpdated, self.onBossUpdated)
	arg_12_1:RemoveListener(WorldBossProxy.EventRankListUpdated, self.onRankListUpdated)
	arg_12_1:RemoveListener(WorldBossProxy.EventUnlockProgressUpdated, self.onBossProgressUpdate)

	return
end

function BaseWorldBossDetailPage:OnBossUpdated()
	if self:isShowing() then
		self:UpdateBoss()
	end

	return
end

function BaseWorldBossDetailPage:OnRankListUpdated(arg_14_1, arg_14_2, arg_14_3)
	if self:isShowing() and self.boss and self.boss.id == arg_14_3 and self.infoAndRankPanel and self.infoAndRankPanel:GetLoaded() then
		self.infoAndRankPanel:FlushRank()
	end

	return
end

function BaseWorldBossDetailPage:OnBossProgressUpdate()
	if self:isShowing() then
		self:OnUpdateRes()
	end

	return
end

function BaseWorldBossDetailPage:OnPtUpdated()
	if self:isShowing() then
		self:OnUpdatePt()
	end

	return
end

function BaseWorldBossDetailPage:UpdatePainting(arg_17_1)
	if not arg_17_1 then
		return
	end

	if self.groupId ~= arg_17_1 then
		self.groupId = arg_17_1

		local var_17_0 = self._tf:Find("label"):GetComponent(typeof(Image))

		var_17_0.sprite = GetSpriteFromAtlas("MetaWorldboss/" .. self.groupId, "title" .. self:GetResSuffix())

		var_17_0:SetNativeSize()
		setMetaPaintingPrefabAsync(self.painting, self.groupId, "lihuisha", function()
			self:OnPaintingLoad()

			return
		end)

		local var_17_1
		local var_17_2 = WorldBossConst.MetaId2BossId(arg_17_1)

		var_17_1 = var_17_2 and (pg.world_joint_boss_template[var_17_2].p_offset or var_0_1[arg_17_1]) or var_0_1[arg_17_1]

		if var_17_1 then
			setAnchoredPosition(self.painting, {
				x = var_17_1[1],
				y = var_17_1[2]
			})

			self.painting.localScale = Vector3(var_17_1[3] or 1, var_17_1[4] or 1, 1)
		end
	else
		self:OnPaintingLoad()
	end

	return
end

function BaseWorldBossDetailPage:UpdateBoss()
	self.boss = self.proxy:GetBoss()

	if self.boss then
		self:UpdateMainInfo()
		self:RemoveChallengeTimer()
		self:AddChanllengTimer()
		self:RemoveGetAwardTimer()
		self:AddGetAwaradTimer()
	end

	return
end

function BaseWorldBossDetailPage:Update()
	self:UpdateBoss()
	self:Show()

	if self.boss then
		self.infoAndRankPanel:ExecuteAction("Flush", self.boss, self.proxy)
		self:UpdateAward()
		self:OnUpdateRes()
		self:OnUpdatePt()
	end

	return
end

function BaseWorldBossDetailPage:UpdateAward()
	local var_21_0 = self.boss:GetAwards()

	self.awardList:make(function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			local var_22_0 = {
				count = 0,
				type = var_21_0[arg_22_1 + 1][1],
				id = var_21_0[arg_22_1 + 1][2]
			}

			updateDrop(arg_22_2:Find("equipment/bg"), var_22_0)
			arg_22_2:Find("mask/name"):GetComponent("ScrollText"):SetText((var_22_0:getConfig("name")))
			onButton(self, arg_22_2, function()
				self:emit(BaseUI.ON_DROP, var_22_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.awardList:align(math.min(#var_21_0, 3))

	return
end

function BaseWorldBossDetailPage:UpdateMainInfo()
	local var_24_0 = self.boss:GetHP()
	local var_24_1 = self.boss:GetMaxHp()

	self.levelTxt.text = self.boss:GetLevel()
	self.hpTxt.text = var_24_0 .. "/<color=#E31D15>" .. var_24_1 .. "</color>"
	self.hpSlider.value = var_24_0 / var_24_1

	local var_24_2 = self.boss:isDeath()
	local var_24_3 = self.boss:IsExpired()
	local var_24_4 = self.proxy:canGetSelfAward()

	setActive(self.supportBtn, not var_24_2 and not var_24_3)
	setActive(tf(self.leftTime).parent, true)
	setActive(self.awardBtn, var_24_2 and var_24_4)
	setActive(self.startBtn, not var_24_2 and not var_24_3)
	self:UpdatePainting(self.boss.config.meta_id)

	return
end

function BaseWorldBossDetailPage:AddChanllengTimer()
	if self.boss:isDeath() then
		return
	end

	local var_25_0 = pg.TimeMgr.GetInstance()
	local var_25_1 = self.boss:GetExpiredTime()

	local function var_25_2()
		self.leftTime.text = i18n("world_word_expired")

		onNextTick(function()
			self:OnBossExpired()

			return
		end)

		return
	end

	if var_25_1 < var_25_0:GetServerTime() then
		var_25_2()
	else
		self.bossTimer = Timer.New(function()
			local var_28_0 = var_25_1 - pg.TimeMgr.GetInstance():GetServerTime()

			if var_28_0 > 0 then
				self.leftTime.text = pg.TimeMgr.GetInstance():DescCDTime(var_28_0)
			else
				var_25_2()
				self:RemoveChallengeTimer()
			end

			return
		end, 1, -1)

		self.bossTimer:Start()
		self.bossTimer.func()
	end

	return
end

function BaseWorldBossDetailPage:RemoveChallengeTimer()
	if self.bossTimer then
		self.bossTimer:Stop()

		self.bossTimer = nil
	end

	return
end

function BaseWorldBossDetailPage:AddGetAwaradTimer()
	if not self.boss:isDeath() then
		return
	end

	local var_30_0 = pg.TimeMgr.GetInstance()
	local var_30_1 = self.boss:GetExpiredTime()

	local function var_30_2()
		self.leftTime.text = i18n("world_word_expired")

		onNextTick(function()
			self:OnBossExpired()

			return
		end)

		return
	end

	if var_30_1 < var_30_0:GetServerTime() then
		var_30_2()
	else
		self.awardTimer = Timer.New(function()
			local var_33_0 = var_30_1 - pg.TimeMgr.GetInstance():GetServerTime()

			if var_33_0 > 0 then
				self.leftTime.text = pg.TimeMgr.GetInstance():DescCDTime(var_33_0)
			else
				var_30_2()
				self:RemoveGetAwardTimer()
			end

			return
		end, 1, -1)

		self.awardTimer:Start()
		self.awardTimer.func()
	end

	return
end

function BaseWorldBossDetailPage:OnBossExpired()
	self:emit(WorldBossMediator.ON_SELF_BOSS_OVERTIME)

	return
end

function BaseWorldBossDetailPage:RemoveGetAwardTimer()
	if self.awardTimer then
		self.awardTimer:Stop()

		self.awardTimer = nil
	end

	return
end

function BaseWorldBossDetailPage:OnDestroy()
	if self.groupId then
		self:OnRetPaintingPrefab()
		retMetaPaintingPrefab(self.painting, self.groupId)
	end

	self:RemoveGetAwardTimer()
	self:RemoveListeners(self.proxy)
	self:RemoveChallengeTimer()

	if self.infoAndRankPanel then
		self.infoAndRankPanel:Destroy()

		self.infoAndRankPanel = nil
	end

	if self:isShowing() then
		self:Hide()
	end

	return
end

function BaseWorldBossDetailPage:OnRetPaintingPrefab()
	return
end

function BaseWorldBossDetailPage:GetResSuffix()
	return ""
end

function BaseWorldBossDetailPage:OnPaintingLoad()
	return
end

function BaseWorldBossDetailPage:OnUpdateRes()
	return
end

function BaseWorldBossDetailPage:OnUpdatePt()
	return
end

function BaseWorldBossDetailPage:OnRescue()
	return
end

return BaseWorldBossDetailPage
