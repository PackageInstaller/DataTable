class = var_0_10000

local var_0_0 = "BaseWorldBossChallengePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

var_0_1.Listeners = {
	onCacheBossUpdated = "OnCacheBossUpdated",
	onRankListUpdated = "OnRankListUpdated"
}

local var_0_2 = {
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

function var_0_1.Setup(arg_1_0, arg_1_1)
	pairs = var_1_10002

	for iter_1_0, iter_1_1 in var_1_10002(var_0_1.Listeners) do
		arg_1_0[iter_1_0] = function(...)
			var_0_1[iter_1_1](arg_1_0, ...)

			return
		end
	end

	arg_1_0.proxy = arg_1_1

	return
end

function var_0_1.OnLoaded(arg_3_0)
	WorldBossRankPage = var_1_10001
	arg_3_0.rankPage = var_1_10001.New(arg_3_0._tf.parent.parent, arg_3_0.event)

	arg_3_0:AddListeners(arg_3_0.proxy)

	return
end

function var_0_1.OnInit(arg_4_0)
	arg_4_0:UpdateEmptyCard()

	WorldBossItemList = var_1

	local var_4_0 = var_1.New
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_2.Find(var_4_1, "list_panel/mask/bg/container")
	local var_4_3 = arg_4_0._tf

	arg_4_0.scrollRect = var_4_0(var_4_2, var_3.Find(var_4_3, "list_panel/mask/tpl"))

	local var_4_4 = arg_4_0.scrollRect

	var_1.Make(var_4_4, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_4_0

		var_2.OnInitCard(var_5_0, arg_5_0, arg_5_1)

		return
	end, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_4_0

		var_2.OnPreviewCard(var_6_0, arg_6_0, arg_6_1)

		return
	end, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_4_0

		var_2.OnSelectCard(var_7_0, arg_7_0, arg_7_1)

		return
	end)

	local var_4_5 = arg_4_0._tf
	local var_4_6 = var_1.Find(var_4_5, "main/hp/slider")
	local var_4_7 = var_1.GetComponent

	typeof = var_3
	Slider = var_4
	arg_4_0.hpSlider = var_4_7(var_4_6, var_3(var_4))

	local var_4_8 = arg_4_0._tf
	local var_4_9 = var_1.Find(var_4_8, "main/hp/level/Text")
	local var_4_10 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_4_0.levelTxt = var_4_10(var_4_9, var_3(var_4))

	local var_4_11 = arg_4_0._tf
	local var_4_12 = var_1.Find(var_4_11, "main/hp/Text")
	local var_4_13 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_4_0.hpTxt = var_4_13(var_4_12, var_3(var_4))

	local var_4_14 = arg_4_0._tf
	local var_4_15 = var_1.Find(var_4_14, "main/time/Text")
	local var_4_16 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_4_0.expiredTimeTxt = var_4_16(var_4_15, var_3(var_4))

	local var_4_17 = arg_4_0._tf

	arg_4_0.mainPanel = var_1.Find(var_4_17, "main")

	local var_4_18 = arg_4_0._tf

	arg_4_0.painting = var_1.Find(var_4_18, "paint")
	setActive = var_1

	var_1(arg_4_0.painting, false)

	setActive = var_1

	var_1(arg_4_0.mainPanel, false)

	local var_4_19 = arg_4_0.mainPanel

	arg_4_0.rankBtn = var_1.Find(var_4_19, "rank_btn")

	local var_4_20 = arg_4_0.mainPanel

	arg_4_0.startBtn = var_1.Find(var_4_20, "start_btn")

	local var_4_21 = arg_4_0._tf

	arg_4_0.refreshBtn = var_1.Find(var_4_21, "list_panel/frame/filter/refresh_btn")

	local var_4_22 = arg_4_0._tf

	arg_4_0.refreshBtnGray = var_1.Find(var_4_22, "list_panel/frame/filter/refresh_btn_gray")
	arg_4_0.cdTime = 0
	onButton = var_1

	local var_4_23 = arg_4_0
	local var_4_24 = arg_4_0.refreshBtn

	local function var_4_25()
		local var_8_0 = arg_4_0.cdTime

		pg = var_2_10001

		local var_8_1 = var_2_10001.TimeMgr.GetInstance()

		if var_8_0 <= var_1.GetServerTime(var_8_1) then
			var_8_0 = arg_4_0
			var_8_0.worldBossId = nil

			local var_8_2 = arg_4_0

			var_8_0 = var_8_0.emit
			WorldBossMediator = var_8_1

			var_8_0(var_8_2, var_8_1.UPDATE_CACHE_BOSS_HP, function()
				local var_9_0 = arg_4_0

				var_0.OnCacheBossUpdated(var_9_0)

				return
			end)

			assert = var_8_0
			pg = var_8_2

			var_8_0(var_8_2.gameset.world_boss_resfresh, "gameset >>>>>>>>>>world_boss_resfresh")

			pg = var_8_0
			var_8_0 = var_8_0.gameset.world_boss_resfresh.key_value

			local var_8_3 = arg_4_0

			pg = var_8_1

			local var_8_4 = var_8_1.TimeMgr.GetInstance()

			var_8_3.cdTime = var_8_1.GetServerTime(var_8_4) + var_8_0
			var_8_1 = arg_4_0

			var_1.RotateRefreshBtn(var_8_1, var_8_0)
		else
			pg = var_8_0

			local var_8_5 = var_8_0.TipsMgr.GetInstance()
			local var_8_6 = var_0.ShowTips

			i18n = var_8_1

			var_8_6(var_8_5, var_8_1("world_joint_not_refresh_frequently"))
		end

		return
	end

	SFX_PANEL = var_5

	var_1(var_4_23, var_4_24, var_4_25, var_5)

	onButton = var_1

	local var_4_26 = arg_4_0
	local var_4_27 = arg_4_0.refreshBtnGray

	local function var_4_28()
		pg = var_2_10000

		local var_10_0 = var_2_10000.TipsMgr.GetInstance()
		local var_10_1 = var_0.ShowTips

		i18n = var_2_10002

		var_10_1(var_10_0, var_2_10002("world_joint_not_refresh_frequently"))

		return
	end

	SFX_PANEL = var_5

	var_1(var_4_26, var_4_27, var_4_28, var_5)

	local var_4_29 = arg_4_0._tf

	arg_4_0.filterToggle = var_1.Find(var_4_29, "list_panel/frame/filter/toggles")

	local var_4_30 = {}

	WorldBoss = var_4_29
	var_4_30[1] = var_4_29.BOSS_TYPE_WORLD
	WorldBoss = var_2
	var_4_30[2] = var_2.BOSS_TYPE_FRIEND
	WorldBoss = var_2
	var_4_30[3] = var_2.BOSS_TYPE_GUILD
	arg_4_0.filterFlags = var_4_30
	onToggle = var_4_30

	local var_4_31 = arg_4_0
	local var_4_32 = arg_4_0._tf
	local var_4_33 = var_3.Find(var_4_32, "list_panel/frame/filter/toggles/friend")

	local function var_4_34(arg_11_0)
		local var_11_0 = arg_4_0.filterFlags

		if arg_11_0 then
			WorldBoss = var_2_10002

			local var_11_1

			if not var_2_10002.BOSS_TYPE_FRIEND then
				var_11_1 = -1
			end

			var_11_0[2] = var_11_1

			local var_11_2 = arg_4_0

			var_1.CheckToggle(var_11_2)

			local var_11_3 = arg_4_0

			var_1.UpdateNonProcessList(var_11_3)

			return
		end
	end

	SFX_PANEL = var_5

	var_4_30(var_4_31, var_4_33, var_4_34, var_5)

	GetComponent = var_4_30

	local var_4_35 = arg_4_0._tf
	local var_4_36 = var_2.Find(var_4_35, "list_panel/frame/filter/toggles/friend/unsel")

	typeof = var_4_35
	Image = var_4

	local var_4_37 = var_4_30(var_4_36, var_4_35(var_4))

	var_1.SetNativeSize(var_4_37)

	GetComponent = var_1

	local var_4_38 = arg_4_0._tf
	local var_4_39 = var_2.Find(var_4_38, "list_panel/frame/filter/toggles/friend/sel")

	typeof = var_4_38
	Image = var_4

	local var_4_40 = var_1(var_4_39, var_4_38(var_4))

	var_1.SetNativeSize(var_4_40)

	GetComponent = var_1

	local var_4_41 = arg_4_0._tf
	local var_4_42 = var_2.Find(var_4_41, "list_panel/frame/filter/toggles/guild/sel")

	typeof = var_4_41
	Image = var_4

	local var_4_43 = var_1(var_4_42, var_4_41(var_4))

	var_1.SetNativeSize(var_4_43)

	GetComponent = var_1

	local var_4_44 = arg_4_0._tf
	local var_4_45 = var_2.Find(var_4_44, "list_panel/frame/filter/toggles/guild/unsel")

	typeof = var_4_44
	Image = var_4

	local var_4_46 = var_1(var_4_45, var_4_44(var_4))

	var_1.SetNativeSize(var_4_46)

	onToggle = var_1

	local var_4_47 = arg_4_0
	local var_4_48 = arg_4_0._tf
	local var_4_49 = var_3.Find(var_4_48, "list_panel/frame/filter/toggles/guild")

	local function var_4_50(arg_12_0)
		local var_12_0 = arg_4_0.filterFlags

		if arg_12_0 then
			WorldBoss = var_2_10002

			local var_12_1

			if not var_2_10002.BOSS_TYPE_GUILD then
				var_12_1 = -1
			end

			var_12_0[3] = var_12_1

			local var_12_2 = arg_4_0

			var_1.CheckToggle(var_12_2)

			local var_12_3 = arg_4_0

			var_1.UpdateNonProcessList(var_12_3)

			return
		end
	end

	SFX_PANEL = var_5

	var_1(var_4_47, var_4_49, var_4_50, var_5)

	return
end

function var_0_1.UpdateEmptyCard(arg_13_0)
	local var_13_0 = arg_13_0._tf
	local var_13_1 = var_1.Find(var_13_0, "list_panel/mask/tpl")

	WorldBossConst = var_13_0

	local var_13_2 = var_13_0.GetCurrBossGroup()
	local var_13_3 = var_13_1:Find("empty")
	local var_13_4 = var_3.GetComponent

	typeof = var_5
	Image = var_1_10006

	local var_13_5 = var_13_4(var_13_3, var_5(var_1_10006))

	GetSpriteFromAtlas = var_13_3
	var_13_5.sprite = var_13_3("MetaWorldboss/" .. var_13_2, "item_04")

	var_13_5:SetNativeSize()

	return
end

function var_0_1.CheckToggle(arg_14_0)
	_ = var_1_10001

	if var_1_10001.all(arg_14_0.filterFlags, function(arg_15_0)
		return arg_15_0 == -1
	end) then
		triggerToggle = var_1

		local var_14_0 = arg_14_0._tf

		var_1(var_2.Find(var_14_0, "list_panel/frame/filter/toggles/friend"), true)

		triggerToggle = var_1

		local var_14_1 = arg_14_0._tf

		var_1(var_2.Find(var_14_1, "list_panel/frame/filter/toggles/guild"), true)
	end

	return
end

function var_0_1.GetResSuffix(arg_16_0)
	return ""
end

function var_0_1.UpdatePainting(arg_17_0, arg_17_1)
	if arg_17_0.groupId ~= arg_17_1 then
		arg_17_0.groupId = arg_17_1

		local var_17_0 = arg_17_0._tf
		local var_17_1 = var_2.Find(var_17_0, "main/label")
		local var_17_2 = var_2.GetComponent

		typeof = var_4
		Image = var_1_10005

		local var_17_3 = var_17_2(var_17_1, var_4(var_1_10005))

		GetSpriteFromAtlas = var_17_1
		var_17_3.sprite = var_17_1("MetaWorldboss/" .. arg_17_1, "title" .. arg_17_0:GetResSuffix())

		var_17_3:SetNativeSize()

		setMetaPaintingPrefabAsync = var_3

		var_3(arg_17_0.painting, arg_17_0.groupId, "lihuisha")

		WorldBossConst = var_3

		local var_17_4 = var_3.MetaId2BossId(arg_17_0.groupId)

		pg = var_4

		local var_17_5

		if not var_4.world_joint_boss_template[var_17_4].p_offset_other then
			var_17_5 = var_0_2[arg_17_0.groupId]
		end

		if var_17_5 then
			setAnchoredPosition = var_5

			var_5(arg_17_0.painting, {
				x = var_17_5[1],
				y = var_17_5[2]
			})

			local var_17_6

			if not var_17_5[3] then
				var_17_6 = 1
			end

			local var_17_7

			if not var_17_5[4] then
				var_17_7 = 1
			end

			local var_17_8 = arg_17_0.painting

			Vector3 = var_8
			var_17_8.localScale = var_8(var_17_6, var_17_7, 1)
		end
	end

	return
end

function var_0_1.RotateRefreshBtn(arg_18_0, arg_18_1)
	LeanTween = var_1_10002

	local var_18_0 = var_1_10002.rotate

	rtf = var_1_10003

	local var_18_1 = var_18_0(var_1_10003(arg_18_0.refreshBtn), -360, 0.5)
	local var_18_2 = var_2.setOnComplete

	System = var_5

	var_18_2(var_18_1, var_5.Action(function()
		local var_19_0 = arg_18_0.refreshBtn

		Vector3 = var_2_10001
		var_19_0.localEulerAngles = var_2_10001(0, 0, 0)
		setActive = var_19_0

		var_19_0(arg_18_0.refreshBtnGray, false)

		setActive = var_19_0

		var_19_0(arg_18_0.refreshBtnGray, true)

		return
	end))

	if arg_18_0.refreshtimer then
		local var_18_3 = arg_18_0.refreshtimer

		var_3.Stop(var_18_3)

		arg_18_0.refreshtimer = nil
	end

	Timer = var_3
	arg_18_0.refreshtimer = var_3.New(function()
		setActive = var_2_10000

		var_2_10000(arg_18_0.refreshBtnGray, true)

		setActive = var_2_10000

		var_2_10000(arg_18_0.refreshBtnGray, false)

		return
	end, arg_18_1, 1)

	local var_18_4 = arg_18_0.refreshtimer

	var_3.Start(var_18_4)

	return
end

function var_0_1.AddListeners(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1
	local var_21_1 = arg_21_1.AddListener

	WorldBossProxy = var_1_10004

	var_21_1(var_21_0, var_1_10004.EventRankListUpdated, arg_21_0.onRankListUpdated)

	local var_21_2 = arg_21_1
	local var_21_3 = arg_21_1.AddListener

	WorldBossProxy = var_4

	var_21_3(var_21_2, var_4.EventCacheBossListUpdated, arg_21_0.onCacheBossUpdated)

	return
end

function var_0_1.RemoveListeners(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1
	local var_22_1 = arg_22_1.RemoveListener

	WorldBossProxy = var_1_10004

	var_22_1(var_22_0, var_1_10004.EventRankListUpdated, arg_22_0.onRankListUpdated)

	local var_22_2 = arg_22_1
	local var_22_3 = arg_22_1.RemoveListener

	WorldBossProxy = var_4

	var_22_3(var_22_2, var_4.EventCacheBossListUpdated, arg_22_0.onCacheBossUpdated)

	return
end

function var_0_1.OnCacheBossUpdated(arg_23_0)
	arg_23_0:UpdateNonProcessList()

	return
end

function var_0_1.OnRankListUpdated(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_0.boss and arg_24_0.boss.id == arg_24_3 then
		local var_24_0 = arg_24_0.rankPage

		if var_4.GetLoaded(var_24_0) then
			local var_24_1 = arg_24_0.rankPage

			if var_4.isActive(var_24_1) then
				local var_24_2 = arg_24_0.rankPage

				var_4.ExecuteAction(var_24_2, "Update", arg_24_0.proxy, arg_24_0.boss.id)
			end
		end
	end

	return
end

function var_0_1.Update(arg_25_0)
	local var_25_0 = arg_25_0
	local var_25_1 = arg_25_0.emit

	WorldBossMediator = var_1_10003

	var_25_1(var_25_0, var_1_10003.UPDATE_CACHE_BOSS_HP, function()
		local var_26_0 = arg_25_0

		var_0.UpdateNonProcessList(var_26_0)

		local var_26_1 = arg_25_0

		var_0.Show(var_26_1)

		return
	end)

	return
end

function var_0_1.UpdateNonProcessList(arg_27_0)
	local var_27_0 = arg_27_0.proxy
	local var_27_1 = var_1.GetCacheBossList(var_27_0)

	local function var_27_2(arg_28_0)
		_ = var_2_10001

		local var_28_0 = var_2_10001.select(arg_27_0.filterFlags, function(arg_29_0)
			return arg_29_0 >= 0
		end)

		_ = var_2

		return var_2.any(var_28_0, function(arg_30_0)
			local var_30_0 = arg_28_0

			return var_1.GetType(var_30_0) == arg_30_0
		end)
	end

	arg_27_0.displays = {}
	ipairs = var_4

	for iter_27_0, iter_27_1 in var_4(var_27_1) do
		if not iter_27_1:isDeath() and not iter_27_1:IsExpired() and var_27_2(iter_27_1) and not iter_27_1:IsFullPeople() and arg_27_0:OnFilterBoss(iter_27_1) then
			table = var_9

			var_9.insert(arg_27_0.displays, iter_27_1)
		end
	end

	table = var_4

	var_4.sort(arg_27_0.displays, function(arg_31_0, arg_31_1)
		return arg_31_0:GetJoinTime() > arg_31_1:GetJoinTime()
	end)

	local var_27_3 = 1

	ipairs = var_5

	for iter_27_2, iter_27_3 in var_5(arg_27_0.displays) do
		if iter_27_3.id == arg_27_0.contextData.worldBossId or iter_27_3.id == arg_27_0.worldBossId then
			var_27_3 = iter_27_2

			break
		end
	end

	local var_27_4 = arg_27_0.contextData

	var_27_4.worldBossId = nil
	WorldBossScene = var_27_4
	var_27_4.inOtherBossBattle = nil

	local var_27_5 = arg_27_0.scrollRect

	var_5.Align(var_27_5, #arg_27_0.displays, var_27_3)

	setActive = var_5

	var_5(arg_27_0.filterToggle, true)

	setActive = var_5

	var_5(arg_27_0.refreshBtn, true)

	return
end

function var_0_1.OnFilterBoss(arg_32_0, arg_32_1)
	return true
end

function var_0_1.OnInitCard(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0.displays[arg_33_2 + 1]
	local var_33_1 = false
	local var_33_2 = arg_33_1
	local var_33_3 = arg_33_1.Find(var_33_2, "tags")

	removeOnButton = var_33_2

	var_33_2(arg_33_1)

	setText = var_33_2

	var_33_2(arg_33_1:Find("tags/friend/Text"), "")

	setText = var_33_2

	var_33_2(arg_33_1:Find("tags/guild/Text"), "")

	if var_33_0 then
		var_33_1 = var_33_0:isDeath()

		local var_33_4 = var_33_0

		var_33_2 = var_33_0.GetType(var_33_4)
		setActive = var_33_4

		local var_33_5 = arg_33_1
		local var_33_6 = arg_33_1.Find(var_33_5, "tags/friend")

		WorldBoss = var_33_5

		var_33_4(var_33_6, var_33_2 == var_33_5.BOSS_TYPE_FRIEND)

		setActive = var_33_4

		local var_33_7 = arg_33_1
		local var_33_8 = arg_33_1.Find(var_33_7, "tags/guild")

		WorldBoss = var_33_7

		var_33_4(var_33_8, var_33_2 == var_33_7.BOSS_TYPE_GUILD)

		setActive = var_33_4

		local var_33_9 = arg_33_1
		local var_33_10 = arg_33_1.Find(var_33_9, "tags/world")

		WorldBoss = var_33_9

		var_33_4(var_33_10, var_33_2 == var_33_9.BOSS_TYPE_WORLD)

		Vector3 = var_33_4
		var_33_3.anchoredPosition = var_33_4(0, 14, 0)
		setText = var_7

		var_7(arg_33_1:Find("tags/friend/Text"), var_33_0:GetRoleName())

		setText = var_7

		var_7(arg_33_1:Find("tags/guild/Text"), var_33_0:GetRoleName())

		onButton = var_7

		local var_33_11 = arg_33_0
		local var_33_12 = arg_33_1

		local function var_33_13()
			local var_34_0 = arg_33_0.scrollRect

			var_0.SliceTo(var_34_0, arg_33_1)

			return
		end

		SFX_PANEL = var_1_10011

		var_7(var_33_11, var_33_12, var_33_13, var_1_10011)
		arg_33_0:UpdateCardStyle(arg_33_1, var_33_0.config.meta_id)
	end

	setActive = var_33_2

	var_33_2(arg_33_1:Find("complete"), var_33_0 and var_33_1)

	setActive = var_33_2

	var_33_2(arg_33_1:Find("raiding"), var_33_0 and not var_33_1)

	setActive = var_33_2

	var_33_2(arg_33_1:Find("empty"), not var_33_0)

	setActive = var_33_2

	var_33_2(var_33_3, var_33_0)

	setActive = var_33_2

	var_33_2(arg_33_1:Find("tags/friend/Text"), false)

	setActive = var_33_2

	var_33_2(arg_33_1:Find("tags/guild/Text"), false)

	return
end

function var_0_1.UpdateCardStyle(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_1:Find("raiding")
	local var_35_1 = var_3.GetComponent

	typeof = var_5
	Image = var_1_10006

	local var_35_2 = var_35_1(var_35_0, var_5(var_1_10006))

	GetSpriteFromAtlas = var_35_0
	var_35_2.sprite = var_35_0("MetaWorldboss/" .. arg_35_2, "item_03")

	local var_35_3 = arg_35_1:Find("empty")
	local var_35_4 = var_3.GetComponent

	typeof = var_5
	Image = var_6

	local var_35_5 = var_35_4(var_35_3, var_5(var_6))

	GetSpriteFromAtlas = var_35_3
	var_35_5.sprite = var_35_3("MetaWorldboss/" .. arg_35_2, "item_04")

	var_35_5:SetNativeSize()

	local var_35_6 = arg_35_1:Find("selected/challenging")
	local var_35_7 = var_4.GetComponent

	typeof = var_6
	Image = var_1_10007

	local var_35_8 = var_35_7(var_35_6, var_6(var_1_10007))

	GetSpriteFromAtlas = var_35_6
	var_35_8.sprite = var_35_6("MetaWorldboss/" .. arg_35_2, "item_01" .. arg_35_0:GetResSuffix())

	return
end

function var_0_1.OnPreviewCard(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_0.prevSelected and arg_36_0.prevSelected.boss then
		local var_36_0 = arg_36_0.prevSelected.childTF
		local var_36_1 = var_3.Find(var_36_0, "tags")

		Vector3 = var_36_0
		var_36_1.anchoredPosition = var_36_0(0, 14, 0)
		setActive = var_36_1

		local var_36_2 = arg_36_0.prevSelected.childTF

		var_36_1(var_4.Find(var_36_2, "tags/friend/Text"), false)

		setActive = var_36_1

		local var_36_3 = arg_36_0.prevSelected.childTF

		var_36_1(var_4.Find(var_36_3, "tags/guild/Text"), false)

		setActive = var_36_1

		local var_36_4 = arg_36_0.prevSelected.childTF

		var_36_1(var_4.Find(var_36_4, "selected"), false)
	end

	local var_36_6

	if arg_36_0.displays[arg_36_2 + 1] then
		local var_36_5 = var_3

		var_36_6 = var_3.isDeath(var_36_5)
		setActive = var_36_5

		var_36_5(arg_36_1:Find("selected/challenging"), not var_36_6)

		setActive = var_36_5

		var_36_5(arg_36_1:Find("selected/finished"), var_36_6)

		local var_36_7 = arg_36_1
		local var_36_8 = arg_36_1.Find(var_36_7, "tags")

		Vector3 = var_36_7
		var_36_8.anchoredPosition = var_36_7(-17, 41.69, 0)
		setActive = var_36_8

		var_36_8(arg_36_1:Find("tags/friend/Text"), true)

		setActive = var_36_8

		var_36_8(arg_36_1:Find("tags/guild/Text"), true)
		arg_36_0:UpdateMainView(var_3)
	end

	setActive = var_36_6

	var_36_6(arg_36_1:Find("selected"), var_3)

	arg_36_0.prevSelected = {
		childTF = arg_36_1,
		boss = var_3
	}

	return
end

function var_0_1.OnSelectCard(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0.boss = arg_37_0.displays[arg_37_2 + 1]
	arg_37_0.worldBossId = nil

	if arg_37_0.boss then
		arg_37_0.worldBossId = var_3.id

		arg_37_0:UpdateMainView(var_3)
	else
		setActive = var_4

		var_4(arg_37_0.mainPanel, false)

		setActive = var_4

		var_4(arg_37_0.painting, false)
	end

	return
end

function var_0_1.UpdateMainView(arg_38_0, arg_38_1, arg_38_2)
	setActive = var_1_10003

	var_1_10003(arg_38_0.mainPanel, true)

	setActive = var_1_10003

	var_1_10003(arg_38_0.painting, true)

	local var_38_0 = arg_38_0.proxy
	local var_38_1 = arg_38_1:isDeath()
	local var_38_2 = arg_38_1
	local var_38_3 = arg_38_1.GetLeftTime(var_38_2)

	onButton = var_38_2

	local var_38_4 = arg_38_0
	local var_38_5 = arg_38_0.rankBtn

	local function var_38_6()
		local var_39_0 = arg_38_0.rankPage

		var_0.ExecuteAction(var_39_0, "Update", arg_38_0.proxy, arg_38_1.id)

		return
	end

	SFX_PANEL = var_1_10010

	var_38_2(var_38_4, var_38_5, var_38_6, var_1_10010)

	local var_38_7 = arg_38_1:GetMaxHp()

	arg_38_0.hpSlider.value = 1
	arg_38_0.levelTxt.text = arg_38_1:GetLevel()

	local var_38_8 = arg_38_0.hpTxt

	var_38_8.text = "HP:" .. var_38_7
	onButton = var_38_8

	local var_38_9 = arg_38_0
	local var_38_10 = arg_38_0.startBtn

	local function var_38_11()
		local var_40_0 = arg_38_0
		local var_40_1 = var_0.emit

		WorldBossMediator = var_2_10002

		var_40_1(var_40_0, var_2_10002.ON_BATTLE, arg_38_1.id, true)

		return
	end

	SFX_PANEL = var_1_10011

	var_38_8(var_38_9, var_38_10, var_38_11, var_1_10011)

	setActive = var_38_8

	var_38_8(arg_38_0.startBtn, not var_38_1 and var_38_3 > 0)
	arg_38_0:removeBattleTimer()

	if not var_38_1 and not arg_38_2 then
		arg_38_0:addBattleTimer(arg_38_1)
	end

	arg_38_0:UpdatePainting(arg_38_1.config.meta_id)

	return
end

function var_0_1.addBattleTimer(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_1
	local var_41_1 = arg_41_1.GetExpiredTime(var_41_0)

	pg = var_41_0

	local var_41_2 = var_41_0.TimeMgr.GetInstance()
	local var_41_3 = var_41_1 - var_3.GetServerTime(var_41_2)

	if 0 <= var_41_3 then
		Timer = var_5
		arg_41_0.timer = var_5.New(function()
			if arg_41_0.exited then
				var_2_10001 = arg_41_0

				var_0.removeBattleTimer(var_2_10001)

				return
			end

			local var_42_0 = var_41_1

			pg = var_2_10001

			local var_42_1 = var_2_10001.TimeMgr.GetInstance()

			if var_42_0 - var_1.GetServerTime(var_42_1) <= 0 then
				local var_42_2 = arg_41_0.expiredTimeTxt

				i18n = var_42_1
				var_42_2.text = var_42_1("world_word_expired")
				var_42_1 = arg_41_0

				var_1.removeBattleTimer(var_42_1)

				var_42_1 = arg_41_0

				var_1.UpdateMainView(var_42_1, arg_41_1, true)
			else
				local var_42_3 = arg_41_0.expiredTimeTxt

				pg = var_42_1

				local var_42_4 = var_42_1.TimeMgr.GetInstance()

				var_42_3.text = var_2.DescCDTime(var_42_4, var_0)
			end

			return
		end, 1, -1)
		var_1_10006 = arg_41_0.timer

		var_5.Start(var_1_10006)
		arg_41_0.timer.func()
	else
		local var_41_4 = arg_41_0.expiredTimeTxt

		i18n = var_1_10006
		var_41_4.text = var_1_10006("world_word_expired")

		arg_41_0:UpdateMainView(arg_41_1, true)
	end

	return
end

function var_0_1.removeBattleTimer(arg_43_0)
	if arg_43_0.timer then
		local var_43_0 = arg_43_0.timer

		var_1.Stop(var_43_0)

		arg_43_0.timer = nil
	end

	return
end

function var_0_1.OnDestroy(arg_44_0)
	retMetaPaintingPrefab = var_1_10001

	var_1_10001(arg_44_0.painting, arg_44_0.groupId)
	arg_44_0:RemoveListeners(arg_44_0.proxy)
	arg_44_0:removeBattleTimer()

	local var_44_0 = arg_44_0.scrollRect

	var_1.Dispose(var_44_0)

	local var_44_1 = arg_44_0.rankPage

	var_1.Destroy(var_44_1)

	if arg_44_0.refreshtimer then
		local var_44_2 = arg_44_0.refreshtimer

		var_1.Stop(var_44_2)

		arg_44_0.refreshtimer = nil
	end

	arg_44_0.exited = true

	return
end

return var_0_1
