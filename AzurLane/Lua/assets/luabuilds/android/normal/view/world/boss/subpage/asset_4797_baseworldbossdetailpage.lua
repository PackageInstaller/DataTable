class = var_0_10000

local var_0_0 = "BaseWorldBossDetailPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseSubView"))
local var_0_2 = {
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

function var_0_1.Setup(arg_1_0, arg_1_1)
	local var_1_0 = {
		onBossUpdated = "OnBossUpdated",
		onRankListUpdated = "OnRankListUpdated",
		onPtUpdated = "OnPtUpdated",
		onBossProgressUpdate = "OnBossProgressUpdate"
	}

	pairs = var_1_10003

	for iter_1_0, iter_1_1 in var_1_10003(var_1_0) do
		arg_1_0[iter_1_0] = function(...)
			var_0_1[iter_1_1](arg_1_0, ...)

			return
		end
	end

	arg_1_0.proxy = arg_1_1

	arg_1_0:AddListeners(arg_1_0.proxy)

	return
end

function var_0_1.OnLoaded(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.supportBtn = var_1.Find(var_3_0, "btns/help_btn")

	local var_3_1 = arg_3_0._tf

	arg_3_0.startBtn = var_1.Find(var_3_1, "btns/start_btn")

	local var_3_2 = arg_3_0._tf

	arg_3_0.awardBtn = var_1.Find(var_3_2, "btns/award_btn")

	local var_3_3 = arg_3_0._tf

	arg_3_0.timeTF = var_1.Find(var_3_3, "btns/time")

	local var_3_4 = arg_3_0._tf
	local var_3_5 = var_1.Find(var_3_4, "btns/time/label/Text")
	local var_3_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_3_0.leftTime = var_3_6(var_3_5, var_3(var_1_10004))
	UIItemList = var_1

	local var_3_7 = var_1.New
	local var_3_8 = arg_3_0._tf
	local var_3_9 = var_2.Find(var_3_8, "award_panel/list")
	local var_3_10 = arg_3_0._tf

	arg_3_0.awardList = var_3_7(var_3_9, var_3.Find(var_3_10, "award_panel/list/tpl"))

	local var_3_11 = arg_3_0._tf
	local var_3_12 = var_1.Find(var_3_11, "hp/level/Text")
	local var_3_13 = var_1.GetComponent

	typeof = var_3
	Text = var_3_10
	arg_3_0.levelTxt = var_3_13(var_3_12, var_3(var_3_10))

	local var_3_14 = arg_3_0._tf
	local var_3_15 = var_1.Find(var_3_14, "hp/Text")
	local var_3_16 = var_1.GetComponent

	typeof = var_3
	Text = var_3_10
	arg_3_0.hpTxt = var_3_16(var_3_15, var_3(var_3_10))

	local var_3_17 = arg_3_0._tf
	local var_3_18 = var_1.Find(var_3_17, "hp/slider")
	local var_3_19 = var_1.GetComponent

	typeof = var_3
	Slider = var_3_10
	arg_3_0.hpSlider = var_3_19(var_3_18, var_3(var_3_10))

	local var_3_20 = arg_3_0._tf

	arg_3_0.painting = var_1.Find(var_3_20, "paint")
	WorldBossInfoAndRankPanel = var_1
	arg_3_0.infoAndRankPanel = var_1.New(arg_3_0._tf, arg_3_0.event)

	local var_3_21 = arg_3_0.infoAndRankPanel

	var_1.SetCallback(var_3_21, function(arg_4_0)
		setGray = var_2_10001

		var_2_10001(arg_3_0.awardBtn, arg_4_0, true)

		return
	end, function(arg_5_0, arg_5_1)
		setGray = var_2_10002

		var_2_10002(arg_3_0.supportBtn, arg_5_1 <= arg_5_0, true)

		onButton = var_2_10002

		local var_5_0 = arg_3_0
		local var_5_1 = arg_3_0.supportBtn

		local function var_5_2()
			if arg_5_0 >= arg_5_1 then
				pg = var_0

				local var_6_0 = var_0.TipsMgr.GetInstance()
				local var_6_1 = var_0.ShowTips

				i18n = var_3_10002

				var_6_1(var_6_0, var_3_10002("world_joint_max_challenge_people_cnt"))

				return
			end

			local var_6_2 = arg_3_0.boss

			if var_0.isDeath(var_6_2) then
				pg = var_0

				local var_6_3 = var_0.TipsMgr.GetInstance()
				local var_6_4 = var_0.ShowTips

				i18n = var_3_10002

				var_6_4(var_6_3, var_3_10002("world_joint_boss_is_death"))
			else
				local var_6_5 = arg_3_0

				var_0.OnRescue(var_6_5)
			end

			return
		end

		SFX_PANEL = var_2_10006

		var_2_10002(var_5_0, var_5_1, var_5_2, var_2_10006)

		return
	end)

	setText = var_1

	local var_3_22 = arg_3_0._tf
	local var_3_23 = var_2.Find(var_3_22, "btns/time/label")

	i18n = var_3_22

	var_1(var_3_23, var_3_22("time_remaining_tip"))

	return
end

function var_0_1.OnInit(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.startBtn

	local function var_7_2()
		local var_8_0 = arg_7_0

		var_0.OnStart(var_8_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10005)

	onButton = var_1_10001

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.awardBtn

	local function var_7_5()
		local var_9_0 = arg_7_0.boss

		if var_0.GetLeftTime(var_9_0) <= 0 then
			pg = var_0

			local var_9_1 = var_0.TipsMgr.GetInstance()
			local var_9_2 = var_0.ShowTips

			i18n = var_2_10002

			var_9_2(var_9_1, var_2_10002("world_joint_boss_award_expired"))
		else
			local var_9_3 = arg_7_0.boss

			if var_0.ShouldWaitForResult(var_9_3) then
				return
			end

			local var_9_4 = arg_7_0
			local var_9_5 = var_0.emit

			WorldBossMediator = var_2_10002

			var_9_5(var_9_4, var_2_10002.ON_SUBMIT_AWARD, arg_7_0.boss.id)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_3, var_7_4, var_7_5, var_1_10005)

	return
end

function var_0_1.OnStart(arg_10_0)
	local var_10_0 = arg_10_0.boss

	if var_1.isDeath(var_10_0) then
		pg = var_1

		local var_10_1 = var_1.TipsMgr.GetInstance()
		local var_10_2 = var_1.ShowTips

		i18n = var_1_10003

		var_10_2(var_10_1, var_1_10003("world_joint_boss_is_death"))
	else
		local var_10_3 = arg_10_0.boss

		if var_1.GetLeftTime(var_10_3) <= 0 then
			pg = var_1

			local var_10_4 = var_1.TipsMgr.GetInstance()
			local var_10_5 = var_1.ShowTips

			i18n = var_1_10003

			var_10_5(var_10_4, var_1_10003("world_joint_boss_is_death"))
		else
			local var_10_6 = arg_10_0
			local var_10_7 = arg_10_0.emit

			WorldBossMediator = var_1_10003

			var_10_7(var_10_6, var_1_10003.ON_BATTLE, arg_10_0.boss.id, false, arg_10_0.hpSlider.value)
		end
	end

	return
end

function var_0_1.AddListeners(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1
	local var_11_1 = arg_11_1.AddListener

	WorldBossProxy = var_1_10004

	var_11_1(var_11_0, var_1_10004.EventPtUpdated, arg_11_0.onPtUpdated)

	local var_11_2 = arg_11_1
	local var_11_3 = arg_11_1.AddListener

	WorldBossProxy = var_4

	var_11_3(var_11_2, var_4.EventBossUpdated, arg_11_0.onBossUpdated)

	local var_11_4 = arg_11_1
	local var_11_5 = arg_11_1.AddListener

	WorldBossProxy = var_4

	var_11_5(var_11_4, var_4.EventRankListUpdated, arg_11_0.onRankListUpdated)

	local var_11_6 = arg_11_1
	local var_11_7 = arg_11_1.AddListener

	WorldBossProxy = var_4

	var_11_7(var_11_6, var_4.EventUnlockProgressUpdated, arg_11_0.onBossProgressUpdate)

	return
end

function var_0_1.RemoveListeners(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1
	local var_12_1 = arg_12_1.RemoveListener

	WorldBossProxy = var_1_10004

	var_12_1(var_12_0, var_1_10004.EventPtUpdated, arg_12_0.onPtUpdated)

	local var_12_2 = arg_12_1
	local var_12_3 = arg_12_1.RemoveListener

	WorldBossProxy = var_4

	var_12_3(var_12_2, var_4.EventBossUpdated, arg_12_0.onBossUpdated)

	local var_12_4 = arg_12_1
	local var_12_5 = arg_12_1.RemoveListener

	WorldBossProxy = var_4

	var_12_5(var_12_4, var_4.EventRankListUpdated, arg_12_0.onRankListUpdated)

	local var_12_6 = arg_12_1
	local var_12_7 = arg_12_1.RemoveListener

	WorldBossProxy = var_4

	var_12_7(var_12_6, var_4.EventUnlockProgressUpdated, arg_12_0.onBossProgressUpdate)

	return
end

function var_0_1.OnBossUpdated(arg_13_0)
	if arg_13_0:isShowing() then
		arg_13_0:UpdateBoss()
	end

	return
end

function var_0_1.OnRankListUpdated(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_0:isShowing() and arg_14_0.boss and arg_14_0.boss.id == arg_14_3 and arg_14_0.infoAndRankPanel then
		local var_14_0 = arg_14_0.infoAndRankPanel

		if var_4.GetLoaded(var_14_0) then
			local var_14_1 = arg_14_0.infoAndRankPanel

			var_4.FlushRank(var_14_1)
		end
	end

	return
end

function var_0_1.OnBossProgressUpdate(arg_15_0)
	if arg_15_0:isShowing() then
		arg_15_0:OnUpdateRes()
	end

	return
end

function var_0_1.OnPtUpdated(arg_16_0)
	if arg_16_0:isShowing() then
		arg_16_0:OnUpdatePt()
	end

	return
end

function var_0_1.UpdatePainting(arg_17_0, arg_17_1)
	if not arg_17_1 then
		return
	end

	if arg_17_0.groupId ~= arg_17_1 then
		arg_17_0.groupId = arg_17_1

		local var_17_0 = arg_17_0._tf
		local var_17_1 = var_2.Find(var_17_0, "label")
		local var_17_2 = var_2.GetComponent

		typeof = var_4
		Image = var_1_10005

		local var_17_3 = var_17_2(var_17_1, var_4(var_1_10005))

		GetSpriteFromAtlas = var_17_1
		var_17_3.sprite = var_17_1("MetaWorldboss/" .. arg_17_0.groupId, "title" .. arg_17_0:GetResSuffix())

		var_17_3:SetNativeSize()

		setMetaPaintingPrefabAsync = var_3

		var_3(arg_17_0.painting, arg_17_0.groupId, "lihuisha", function()
			local var_18_0 = arg_17_0

			var_0.OnPaintingLoad(var_18_0)

			return
		end)

		local var_17_4

		WorldBossConst = var_4

		if var_4.MetaId2BossId(arg_17_1) then
			pg = var_5
			var_17_4 = var_5.world_joint_boss_template[var_4].p_offset or var_0_2[arg_17_1]
		else
			var_17_4 = var_0_2[arg_17_1]
		end

		if var_17_4 then
			setAnchoredPosition = var_5

			var_5(arg_17_0.painting, {
				x = var_17_4[1],
				y = var_17_4[2]
			})

			local var_17_5

			if not var_17_4[3] then
				var_17_5 = 1
			end

			local var_17_6

			if not var_17_4[4] then
				var_17_6 = 1
			end

			local var_17_7 = arg_17_0.painting

			Vector3 = var_8
			var_17_7.localScale = var_8(var_17_5, var_17_6, 1)
		end
	else
		arg_17_0:OnPaintingLoad()
	end

	return
end

function var_0_1.UpdateBoss(arg_19_0)
	local var_19_0 = arg_19_0.proxy

	arg_19_0.boss = var_1.GetBoss(var_19_0)

	if arg_19_0.boss then
		arg_19_0:UpdateMainInfo()
		arg_19_0:RemoveChallengeTimer()
		arg_19_0:AddChanllengTimer()
		arg_19_0:RemoveGetAwardTimer()
		arg_19_0:AddGetAwaradTimer()
	end

	return
end

function var_0_1.Update(arg_20_0)
	arg_20_0:UpdateBoss()
	arg_20_0:Show()

	if arg_20_0.boss then
		local var_20_0 = arg_20_0.infoAndRankPanel

		var_1.ExecuteAction(var_20_0, "Flush", arg_20_0.boss, arg_20_0.proxy)
		arg_20_0:UpdateAward()
		arg_20_0:OnUpdateRes()
		arg_20_0:OnUpdatePt()
	end

	return
end

function var_0_1.UpdateAward(arg_21_0)
	local var_21_0 = arg_21_0.boss
	local var_21_1 = var_1.GetAwards(var_21_0)
	local var_21_2 = arg_21_0.awardList

	var_3.make(var_21_2, function(arg_22_0, arg_22_1, arg_22_2)
		UIItemList = var_2_10003

		if arg_22_0 == var_2_10003.EventUpdate then
			local var_22_0 = var_21_1[arg_22_1 + 1]
			local var_22_1 = {
				count = 0,
				type = var_22_0[1],
				id = var_22_0[2]
			}

			updateDrop = var_5

			var_5(arg_22_2:Find("equipment/bg"), var_22_1)

			local var_22_2 = arg_22_2:Find("mask/name")
			local var_22_3 = var_5.GetComponent(var_22_2, "ScrollText")
			local var_22_4 = var_22_1:getConfig("name")

			var_22_3:SetText(var_22_4)

			onButton = var_7

			local var_22_5 = arg_21_0
			local var_22_6 = arg_22_2

			local function var_22_7()
				local var_23_0 = arg_21_0
				local var_23_1 = var_0.emit

				BaseUI = var_3_10002

				var_23_1(var_23_0, var_3_10002.ON_DROP, var_22_1)

				return
			end

			SFX_PANEL = var_2_10011

			var_7(var_22_5, var_22_6, var_22_7, var_2_10011)
		end

		return
	end)

	local var_21_3 = arg_21_0.awardList
	local var_21_4 = var_3.align

	math = var_5

	var_21_4(var_21_3, var_5.min(#var_21_1, 3))

	return
end

function var_0_1.UpdateMainInfo(arg_24_0)
	local var_24_0 = arg_24_0.boss
	local var_24_1 = arg_24_0.proxy
	local var_24_2 = var_24_0:GetHP()
	local var_24_3 = var_24_0:GetMaxHp()

	arg_24_0.levelTxt.text = var_24_0:GetLevel()
	arg_24_0.hpTxt.text = var_24_2 .. "/<color=#E31D15>" .. var_24_3 .. "</color>"
	arg_24_0.hpSlider.value = var_24_2 / var_24_3

	local var_24_4 = var_24_0:isDeath()
	local var_24_5 = var_24_0:IsExpired()
	local var_24_6 = var_24_1
	local var_24_7 = var_24_1.canGetSelfAward(var_24_6)

	setActive = var_24_6

	var_24_6(arg_24_0.supportBtn, not var_24_4 and not var_24_5)

	setActive = var_24_6
	tf = var_9

	var_24_6(var_9(arg_24_0.leftTime).parent, true)

	setActive = var_24_6

	var_24_6(arg_24_0.awardBtn, var_24_4 and var_24_7)

	setActive = var_24_6

	var_24_6(arg_24_0.startBtn, not var_24_4 and not var_24_5)
	arg_24_0:UpdatePainting(var_24_0.config.meta_id)

	return
end

function var_0_1.AddChanllengTimer(arg_25_0)
	local var_25_0 = arg_25_0.boss

	if var_1.isDeath(var_25_0) then
		return
	end

	pg = var_2

	local var_25_1 = var_2.TimeMgr.GetInstance()
	local var_25_2 = var_2.GetServerTime(var_25_1)
	local var_25_3 = var_1:GetExpiredTime()

	local function var_25_4()
		local var_26_0 = arg_25_0.leftTime

		i18n = var_2_10001
		var_26_0.text = var_2_10001("world_word_expired")
		onNextTick = var_26_0

		var_26_0(function()
			local var_27_0 = arg_25_0

			var_0.OnBossExpired(var_27_0)

			return
		end)

		return
	end

	if var_25_3 < var_25_2 then
		var_25_4()
	else
		Timer = var_1_10005
		arg_25_0.bossTimer = var_1_10005.New(function()
			local var_28_0 = var_25_3

			pg = var_2_10001

			local var_28_1 = var_2_10001.TimeMgr.GetInstance()

			if var_28_0 - var_1.GetServerTime(var_28_1) > 0 then
				local var_28_2 = arg_25_0.leftTime

				pg = var_28_1

				local var_28_3 = var_28_1.TimeMgr.GetInstance()

				var_28_2.text = var_2.DescCDTime(var_28_3, var_0)
			else
				var_25_4()

				local var_28_4 = arg_25_0

				var_1.RemoveChallengeTimer(var_28_4)
			end

			return
		end, 1, -1)

		local var_25_5 = arg_25_0.bossTimer

		var_5.Start(var_25_5)
		arg_25_0.bossTimer.func()
	end

	return
end

function var_0_1.RemoveChallengeTimer(arg_29_0)
	if arg_29_0.bossTimer then
		local var_29_0 = arg_29_0.bossTimer

		var_1.Stop(var_29_0)

		arg_29_0.bossTimer = nil
	end

	return
end

function var_0_1.AddGetAwaradTimer(arg_30_0)
	local var_30_0 = arg_30_0.boss

	if not var_1.isDeath(var_30_0) then
		return
	end

	pg = var_2

	local var_30_1 = var_2.TimeMgr.GetInstance()
	local var_30_2 = var_2.GetServerTime(var_30_1)
	local var_30_3 = var_1:GetExpiredTime()

	local function var_30_4()
		local var_31_0 = arg_30_0.leftTime

		i18n = var_2_10001
		var_31_0.text = var_2_10001("world_word_expired")
		onNextTick = var_31_0

		var_31_0(function()
			local var_32_0 = arg_30_0

			var_0.OnBossExpired(var_32_0)

			return
		end)

		return
	end

	if var_30_3 < var_30_2 then
		var_30_4()
	else
		Timer = var_1_10005
		arg_30_0.awardTimer = var_1_10005.New(function()
			local var_33_0 = var_30_3

			pg = var_2_10001

			local var_33_1 = var_2_10001.TimeMgr.GetInstance()

			if var_33_0 - var_1.GetServerTime(var_33_1) > 0 then
				local var_33_2 = arg_30_0.leftTime

				pg = var_33_1

				local var_33_3 = var_33_1.TimeMgr.GetInstance()

				var_33_2.text = var_2.DescCDTime(var_33_3, var_0)
			else
				var_30_4()

				local var_33_4 = arg_30_0

				var_1.RemoveGetAwardTimer(var_33_4)
			end

			return
		end, 1, -1)

		local var_30_5 = arg_30_0.awardTimer

		var_5.Start(var_30_5)
		arg_30_0.awardTimer.func()
	end

	return
end

function var_0_1.OnBossExpired(arg_34_0)
	local var_34_0 = arg_34_0
	local var_34_1 = arg_34_0.emit

	WorldBossMediator = var_1_10003

	var_34_1(var_34_0, var_1_10003.ON_SELF_BOSS_OVERTIME)

	return
end

function var_0_1.RemoveGetAwardTimer(arg_35_0)
	if arg_35_0.awardTimer then
		local var_35_0 = arg_35_0.awardTimer

		var_1.Stop(var_35_0)

		arg_35_0.awardTimer = nil
	end

	return
end

function var_0_1.OnDestroy(arg_36_0)
	if arg_36_0.groupId then
		arg_36_0:OnRetPaintingPrefab()

		retMetaPaintingPrefab = var_1

		var_1(arg_36_0.painting, arg_36_0.groupId)
	end

	arg_36_0:RemoveGetAwardTimer()
	arg_36_0:RemoveListeners(arg_36_0.proxy)
	arg_36_0:RemoveChallengeTimer()

	if arg_36_0.infoAndRankPanel then
		local var_36_0 = arg_36_0.infoAndRankPanel

		var_1.Destroy(var_36_0)

		arg_36_0.infoAndRankPanel = nil
	end

	if arg_36_0:isShowing() then
		arg_36_0:Hide()
	end

	return
end

function var_0_1.OnRetPaintingPrefab(arg_37_0)
	return
end

function var_0_1.GetResSuffix(arg_38_0)
	return ""
end

function var_0_1.OnPaintingLoad(arg_39_0)
	return
end

function var_0_1.OnUpdateRes(arg_40_0)
	return
end

function var_0_1.OnUpdatePt(arg_41_0)
	return
end

function var_0_1.OnRescue(arg_42_0)
	return
end

return var_0_1
