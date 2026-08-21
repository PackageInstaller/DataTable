local var_0_0 = class("BaseWorldBossDetailPage", import("....base.BaseSubView"))
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

function var_0_0.Setup(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in pairs({
		onBossUpdated = "OnBossUpdated",
		onRankListUpdated = "OnRankListUpdated",
		onPtUpdated = "OnPtUpdated",
		onBossProgressUpdate = "OnBossProgressUpdate"
	}) do
		arg_1_0[iter_1_0] = function(...)
			var_0_0[iter_1_1](arg_1_0, ...)

			return
		end
	end

	arg_1_0.proxy = arg_1_1

	arg_1_0:AddListeners(arg_1_0.proxy)

	return
end

function var_0_0.OnLoaded(arg_3_0)
	arg_3_0.supportBtn = arg_3_0._tf:Find("btns/help_btn")
	arg_3_0.startBtn = arg_3_0._tf:Find("btns/start_btn")
	arg_3_0.awardBtn = arg_3_0._tf:Find("btns/award_btn")
	arg_3_0.timeTF = arg_3_0._tf:Find("btns/time")
	arg_3_0.leftTime = arg_3_0._tf:Find("btns/time/label/Text"):GetComponent(typeof(Text))
	arg_3_0.awardList = UIItemList.New(arg_3_0._tf:Find("award_panel/list"), arg_3_0._tf:Find("award_panel/list/tpl"))
	arg_3_0.levelTxt = arg_3_0._tf:Find("hp/level/Text"):GetComponent(typeof(Text))
	arg_3_0.hpTxt = arg_3_0._tf:Find("hp/Text"):GetComponent(typeof(Text))
	arg_3_0.hpSlider = arg_3_0._tf:Find("hp/slider"):GetComponent(typeof(Slider))
	arg_3_0.painting = arg_3_0._tf:Find("paint")
	arg_3_0.infoAndRankPanel = WorldBossInfoAndRankPanel.New(arg_3_0._tf, arg_3_0.event)

	arg_3_0.infoAndRankPanel:SetCallback(function(arg_4_0)
		setGray(arg_3_0.awardBtn, arg_4_0, true)

		return
	end, function(arg_5_0, arg_5_1)
		setGray(arg_3_0.supportBtn, arg_5_1 <= arg_5_0, true)
		onButton(arg_3_0, arg_3_0.supportBtn, function()
			if arg_5_0 >= arg_5_1 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_max_challenge_people_cnt"))

				return
			end

			if arg_3_0.boss:isDeath() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_boss_is_death"))
			else
				arg_3_0:OnRescue()
			end

			return
		end, SFX_PANEL)

		return
	end)
	setText(arg_3_0._tf:Find("btns/time/label"), i18n("time_remaining_tip"))

	return
end

function var_0_0.OnInit(arg_7_0)
	onButton(arg_7_0, arg_7_0.startBtn, function()
		arg_7_0:OnStart()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.awardBtn, function()
		if arg_7_0.boss:GetLeftTime() <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_boss_award_expired"))
		else
			if arg_7_0.boss:ShouldWaitForResult() then
				return
			end

			arg_7_0:emit(WorldBossMediator.ON_SUBMIT_AWARD, arg_7_0.boss.id)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnStart(arg_10_0)
	if arg_10_0.boss:isDeath() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_boss_is_death"))
	elseif arg_10_0.boss:GetLeftTime() <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_boss_is_death"))
	else
		arg_10_0:emit(WorldBossMediator.ON_BATTLE, arg_10_0.boss.id, false, arg_10_0.hpSlider.value)
	end

	return
end

function var_0_0.AddListeners(arg_11_0, arg_11_1)
	arg_11_1:AddListener(WorldBossProxy.EventPtUpdated, arg_11_0.onPtUpdated)
	arg_11_1:AddListener(WorldBossProxy.EventBossUpdated, arg_11_0.onBossUpdated)
	arg_11_1:AddListener(WorldBossProxy.EventRankListUpdated, arg_11_0.onRankListUpdated)
	arg_11_1:AddListener(WorldBossProxy.EventUnlockProgressUpdated, arg_11_0.onBossProgressUpdate)

	return
end

function var_0_0.RemoveListeners(arg_12_0, arg_12_1)
	arg_12_1:RemoveListener(WorldBossProxy.EventPtUpdated, arg_12_0.onPtUpdated)
	arg_12_1:RemoveListener(WorldBossProxy.EventBossUpdated, arg_12_0.onBossUpdated)
	arg_12_1:RemoveListener(WorldBossProxy.EventRankListUpdated, arg_12_0.onRankListUpdated)
	arg_12_1:RemoveListener(WorldBossProxy.EventUnlockProgressUpdated, arg_12_0.onBossProgressUpdate)

	return
end

function var_0_0.OnBossUpdated(arg_13_0)
	if arg_13_0:isShowing() then
		arg_13_0:UpdateBoss()
	end

	return
end

function var_0_0.OnRankListUpdated(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_0:isShowing() and arg_14_0.boss and arg_14_0.boss.id == arg_14_3 and arg_14_0.infoAndRankPanel and arg_14_0.infoAndRankPanel:GetLoaded() then
		arg_14_0.infoAndRankPanel:FlushRank()
	end

	return
end

function var_0_0.OnBossProgressUpdate(arg_15_0)
	if arg_15_0:isShowing() then
		arg_15_0:OnUpdateRes()
	end

	return
end

function var_0_0.OnPtUpdated(arg_16_0)
	if arg_16_0:isShowing() then
		arg_16_0:OnUpdatePt()
	end

	return
end

function var_0_0.UpdatePainting(arg_17_0, arg_17_1)
	if not arg_17_1 then
		return
	end

	if arg_17_0.groupId ~= arg_17_1 then
		arg_17_0.groupId = arg_17_1

		local var_17_0 = arg_17_0._tf:Find("label"):GetComponent(typeof(Image))

		var_17_0.sprite = GetSpriteFromAtlas("MetaWorldboss/" .. arg_17_0.groupId, "title" .. arg_17_0:GetResSuffix())

		var_17_0:SetNativeSize()
		setMetaPaintingPrefabAsync(arg_17_0.painting, arg_17_0.groupId, "lihuisha", function()
			arg_17_0:OnPaintingLoad()

			return
		end)

		local var_17_1
		local var_17_2 = WorldBossConst.MetaId2BossId(arg_17_1)

		var_17_1 = var_17_2 and (pg.world_joint_boss_template[var_17_2].p_offset or var_0_1[arg_17_1]) or var_0_1[arg_17_1]

		if var_17_1 then
			setAnchoredPosition(arg_17_0.painting, {
				x = var_17_1[1],
				y = var_17_1[2]
			})

			local var_17_3 = var_17_1[3] or 1
			local var_17_4 = var_17_1[4] or 1

			arg_17_0.painting.localScale = Vector3(var_17_3, var_17_4, 1)
		end
	else
		arg_17_0:OnPaintingLoad()
	end

	return
end

function var_0_0.UpdateBoss(arg_19_0)
	arg_19_0.boss = arg_19_0.proxy:GetBoss()

	if arg_19_0.boss then
		arg_19_0:UpdateMainInfo()
		arg_19_0:RemoveChallengeTimer()
		arg_19_0:AddChanllengTimer()
		arg_19_0:RemoveGetAwardTimer()
		arg_19_0:AddGetAwaradTimer()
	end

	return
end

function var_0_0.Update(arg_20_0)
	arg_20_0:UpdateBoss()
	arg_20_0:Show()

	if arg_20_0.boss then
		arg_20_0.infoAndRankPanel:ExecuteAction("Flush", arg_20_0.boss, arg_20_0.proxy)
		arg_20_0:UpdateAward()
		arg_20_0:OnUpdateRes()
		arg_20_0:OnUpdatePt()
	end

	return
end

function var_0_0.UpdateAward(arg_21_0)
	local var_21_0 = arg_21_0.boss:GetAwards()

	arg_21_0.awardList:make(function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			local var_22_0 = {
				count = 0,
				type = var_21_0[arg_22_1 + 1][1],
				id = var_21_0[arg_22_1 + 1][2]
			}

			updateDrop(arg_22_2:Find("equipment/bg"), {
				count = 0,
				type = var_21_0[arg_22_1 + 1][1],
				id = var_21_0[arg_22_1 + 1][2]
			})
			arg_22_2:Find("mask/name"):GetComponent("ScrollText"):SetText((({
				count = 0,
				type = var_21_0[arg_22_1 + 1][1],
				id = var_21_0[arg_22_1 + 1][2]
			}):getConfig("name")))
			onButton(arg_21_0, arg_22_2, function()
				arg_21_0:emit(BaseUI.ON_DROP, var_22_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_21_0.awardList:align(math.min(#arg_21_0.boss:GetAwards(), 3))

	return
end

function var_0_0.UpdateMainInfo(arg_24_0)
	local var_24_0 = arg_24_0.boss:GetHP()
	local var_24_1 = arg_24_0.boss:GetMaxHp()

	arg_24_0.levelTxt.text = arg_24_0.boss:GetLevel()
	arg_24_0.hpTxt.text = var_24_0 .. "/<color=#E31D15>" .. var_24_1 .. "</color>"
	arg_24_0.hpSlider.value = var_24_0 / var_24_1

	local var_24_2 = arg_24_0.boss:isDeath()
	local var_24_3 = arg_24_0.boss:IsExpired()
	local var_24_4 = arg_24_0.proxy:canGetSelfAward()

	setActive(arg_24_0.supportBtn, not var_24_2 and not var_24_3)
	setActive(tf(arg_24_0.leftTime).parent, true)
	setActive(arg_24_0.awardBtn, var_24_2 and var_24_4)
	setActive(arg_24_0.startBtn, not var_24_2 and not var_24_3)
	arg_24_0:UpdatePainting(arg_24_0.boss.config.meta_id)

	return
end

function var_0_0.AddChanllengTimer(arg_25_0)
	if arg_25_0.boss:isDeath() then
		return
	end

	local var_25_0 = pg.TimeMgr.GetInstance()

	local function var_25_1()
		arg_25_0.leftTime.text = i18n("world_word_expired")

		onNextTick(function()
			arg_25_0:OnBossExpired()

			return
		end)

		return
	end

	if arg_25_0.boss:GetExpiredTime() < var_25_0:GetServerTime() then
		(function()
			arg_25_0.leftTime.text = i18n("world_word_expired")

			onNextTick(function()
				arg_25_0:OnBossExpired()

				return
			end)

			return
		end)()
	else
		arg_25_0.bossTimer = Timer.New(function()
			local var_28_0 = var_0 - pg.TimeMgr.GetInstance():GetServerTime()

			if var_28_0 > 0 then
				arg_25_0.leftTime.text = pg.TimeMgr.GetInstance():DescCDTime(var_28_0)
			else
				var_25_1()
				arg_25_0:RemoveChallengeTimer()
			end

			return
		end, 1, -1)

		arg_25_0.bossTimer:Start()
		arg_25_0.bossTimer.func()
	end

	return
end

function var_0_0.RemoveChallengeTimer(arg_29_0)
	if arg_29_0.bossTimer then
		arg_29_0.bossTimer:Stop()

		arg_29_0.bossTimer = nil
	end

	return
end

function var_0_0.AddGetAwaradTimer(arg_30_0)
	if not arg_30_0.boss:isDeath() then
		return
	end

	local var_30_0 = pg.TimeMgr.GetInstance()

	local function var_30_1()
		arg_30_0.leftTime.text = i18n("world_word_expired")

		onNextTick(function()
			arg_30_0:OnBossExpired()

			return
		end)

		return
	end

	if arg_30_0.boss:GetExpiredTime() < var_30_0:GetServerTime() then
		(function()
			arg_30_0.leftTime.text = i18n("world_word_expired")

			onNextTick(function()
				arg_30_0:OnBossExpired()

				return
			end)

			return
		end)()
	else
		arg_30_0.awardTimer = Timer.New(function()
			local var_33_0 = var_0 - pg.TimeMgr.GetInstance():GetServerTime()

			if var_33_0 > 0 then
				arg_30_0.leftTime.text = pg.TimeMgr.GetInstance():DescCDTime(var_33_0)
			else
				var_30_1()
				arg_30_0:RemoveGetAwardTimer()
			end

			return
		end, 1, -1)

		arg_30_0.awardTimer:Start()
		arg_30_0.awardTimer.func()
	end

	return
end

function var_0_0.OnBossExpired(arg_34_0)
	arg_34_0:emit(WorldBossMediator.ON_SELF_BOSS_OVERTIME)

	return
end

function var_0_0.RemoveGetAwardTimer(arg_35_0)
	if arg_35_0.awardTimer then
		arg_35_0.awardTimer:Stop()

		arg_35_0.awardTimer = nil
	end

	return
end

function var_0_0.OnDestroy(arg_36_0)
	if arg_36_0.groupId then
		arg_36_0:OnRetPaintingPrefab()
		retMetaPaintingPrefab(arg_36_0.painting, arg_36_0.groupId)
	end

	arg_36_0:RemoveGetAwardTimer()
	arg_36_0:RemoveListeners(arg_36_0.proxy)
	arg_36_0:RemoveChallengeTimer()

	if arg_36_0.infoAndRankPanel then
		arg_36_0.infoAndRankPanel:Destroy()

		arg_36_0.infoAndRankPanel = nil
	end

	if arg_36_0:isShowing() then
		arg_36_0:Hide()
	end

	return
end

function var_0_0.OnRetPaintingPrefab(arg_37_0)
	return
end

function var_0_0.GetResSuffix(arg_38_0)
	return ""
end

function var_0_0.OnPaintingLoad(arg_39_0)
	return
end

function var_0_0.OnUpdateRes(arg_40_0)
	return
end

function var_0_0.OnUpdatePt(arg_41_0)
	return
end

function var_0_0.OnRescue(arg_42_0)
	return
end

return var_0_0
