class = var_0_10000

local var_0_0 = "IslandOpView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseOpView"))

var_0_1.OperationType = {
	Plant = 2,
	MiningCollect = 3,
	FellCollect = 6,
	Fishing = 7,
	Harvest = 4,
	Interaction = 1,
	WildGather = 5,
	None = 0
}

function var_0_1.GetUIName(arg_1_0)
	return "IslandEmptyUI"
end

function var_0_1.OnInit(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:GetPoolMgr()

	arg_2_0.opUI = var_2.GetOpUI(var_2_0).transform
	setParent = var_2

	var_2(arg_2_0.opUI, arg_2_1)

	local var_2_1 = arg_2_0:GetView()
	local var_2_2

	if not var_2.GetCacheOpCount(var_2_1) then
		var_2_2 = 1
	end

	arg_2_0.showBalance = var_2_2
	IslandCameraMgr = var_2_2

	local var_2_3 = var_2_2.instance.gameObject
	local var_2_4 = var_2.GetComponent

	typeof = var_4
	InputController = var_1_10005
	arg_2_0.inputController = var_2_4(var_2_3, var_4(var_1_10005))
	arg_2_0._go = arg_2_1
	arg_2_0._tf = arg_2_1.transform

	local var_2_5 = arg_2_0.opUI

	arg_2_0.opPanel = var_2.Find(var_2_5, "op_btns")

	local var_2_6 = arg_2_0.opPanel

	arg_2_0.opBtn = var_2.Find(var_2_6, "op_btn")

	local var_2_7 = {}
	local var_2_8 = arg_2_0.opBtn

	var_2_7[1] = var_3.Find(var_2_8, "interaction")

	local var_2_9 = arg_2_0.opBtn

	var_2_7[2] = var_3.Find(var_2_9, "plant")

	local var_2_10 = arg_2_0.opBtn

	var_2_7[3] = var_3.Find(var_2_10, "miningCollect")

	local var_2_11 = arg_2_0.opBtn

	var_2_7[4] = var_3.Find(var_2_11, "harvest")

	local var_2_12 = arg_2_0.opBtn

	var_2_7[5] = var_3.Find(var_2_12, "wildgather")

	local var_2_13 = arg_2_0.opBtn

	var_2_7[6] = var_3.Find(var_2_13, "fellCollect")

	local var_2_14 = arg_2_0.opBtn

	var_2_7[7] = var_3.Find(var_2_14, "fishing")
	arg_2_0.opBtnList = var_2_7

	local var_2_15 = arg_2_0.opPanel

	arg_2_0.morphBtn = var_2.Find(var_2_15, "morph")

	local var_2_16 = arg_2_0.opPanel

	arg_2_0.seedBtn = var_2.Find(var_2_16, "seed")

	local var_2_17 = arg_2_0.seedBtn

	arg_2_0.seedEmpty = var_2.Find(var_2_17, "seedEmpty")

	local var_2_18 = arg_2_0.opPanel

	arg_2_0.areaChangeBtn = var_2.Find(var_2_18, "scope")

	local var_2_19 = arg_2_0.opPanel

	arg_2_0.run = var_2.Find(var_2_19, "run")

	local var_2_20 = arg_2_0.opUI

	arg_2_0.moveBtn = var_2.Find(var_2_20, "move")

	local var_2_21 = arg_2_0.opPanel

	arg_2_0.animationOpBtn = var_2.Find(var_2_21, "aniamtionop")

	local var_2_22 = arg_2_0.animationOpBtn

	arg_2_0.animationOpEffect = var_2.Find(var_2_22, "effect")

	local var_2_23 = arg_2_0.animationOpBtn

	arg_2_0.animationOpSkillTip = var_2.Find(var_2_23, "tip")

	local var_2_24 = arg_2_0.animationOpBtn

	arg_2_0.animationOpSkillEffect = var_2.Find(var_2_24, "effect_skill")

	local var_2_25 = arg_2_0.opPanel

	arg_2_0.followerBtn = var_2.Find(var_2_25, "follower")

	local var_2_26 = arg_2_0.opPanel

	arg_2_0.lureBtn = var_2.Find(var_2_26, "lure")

	local var_2_27 = arg_2_0.lureBtn

	arg_2_0.lureEmptyTr = var_2.Find(var_2_27, "empty")

	local var_2_28 = arg_2_0.lureBtn

	arg_2_0.lureIconTr = var_2.Find(var_2_28, "icon")

	local var_2_29 = arg_2_0.lureBtn
	local var_2_30 = var_2.Find(var_2_29, "icon/count")
	local var_2_31 = var_2.GetComponent

	typeof = var_4
	Text = var_5
	arg_2_0.lureIconTxt = var_2_31(var_2_30, var_4(var_5))
	arg_2_0.animationOpEffectCounter = {}
	arg_2_0.morphing = false

	local var_2_32 = arg_2_0.followerBtn

	arg_2_0.uiFollowerPanel = var_2.Find(var_2_32, "list")

	local var_2_33 = arg_2_0.uiFollowerPanel
	local var_2_34 = var_2.Find(var_2_33, "tpl")

	UIItemList = var_2_33
	arg_2_0.uiFollowerList = var_2_33.New(arg_2_0.uiFollowerPanel, var_2_34)
	setActive = var_3

	var_3(arg_2_0.opPanel, true)

	setActive = var_3

	var_3(arg_2_0.lureBtn, false)

	onButton = var_3

	local var_2_35 = arg_2_0
	local var_2_36 = arg_2_0.areaChangeBtn

	local function var_2_37()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.NotifiyCore

		ISLAND_EVT = var_2_10002

		var_3_1(var_3_0, var_2_10002.AREACHANGE)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_2_35, var_2_36, var_2_37, var_1_10007)

	onButton = var_3

	local var_2_38 = arg_2_0
	local var_2_39 = arg_2_0.morphBtn

	local function var_2_40()
		local var_4_0 = arg_2_0

		var_0.OnMorphBtnClick(var_4_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_2_38, var_2_39, var_2_40, var_1_10007)

	onButton = var_3

	local var_2_41 = arg_2_0
	local var_2_42 = arg_2_0.animationOpBtn

	local function var_2_43()
		local var_5_0 = arg_2_0
		local var_5_1 = var_0.NotifiyCore

		ISLAND_EVT = var_2_10002

		var_5_1(var_5_0, var_2_10002.OPEN_ANIMATION_OP)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_2_41, var_2_42, var_2_43, var_1_10007)

	onButton = var_3

	local var_2_44 = arg_2_0
	local var_2_45 = arg_2_0.followerBtn

	local function var_2_46()
		isActive = var_2_10000

		if var_2_10000(arg_2_0.uiFollowerPanel) then
			local var_6_0 = arg_2_0

			var_0.RemoveFollowerListTimer(var_6_0)

			setActive = var_0

			var_0(arg_2_0.uiFollowerPanel, false)
		else
			local var_6_1 = arg_2_0

			var_0.ShowFollowerList(var_6_1)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_2_44, var_2_45, var_2_46, var_1_10007)

	arg_2_0.operationType = var_0_1.OperationType.None

	arg_2_0:UpdateOperationButtonDisplay()

	local var_2_47 = arg_2_0.view

	arg_2_0.playerInputManager = var_3.GetController(var_2_47).playerInputManager

	arg_2_0:InitOpCustumPositon()
	arg_2_0:UpdateFollowBtn()
	arg_2_0:UpdateAnimationOpBtn()
	arg_2_0:UpdateLureBtn()
	arg_2_0:UpdateMorphBtn()

	return
end

function var_0_1.GetMorphBodyIds(arg_7_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_7_0 = var_1_10001(var_1_10002)

	if not var_1.GetIsland(var_7_0) then
		return 0, 0
	end

	if not var_1:GetDressUpAgency() then
		return 0, 0
	end

	local var_7_1 = var_2
	local var_7_2 = var_2.GetDressByType

	IslandShipDressHelperNew = var_1_10005

	local var_7_3

	if not var_7_2(var_7_1, var_1_10005.DressType.Body) then
		var_7_3 = 0
	end

	if var_7_3 == 0 then
		return 0, 0
	end

	local var_7_4 = var_7_3
	local var_7_5

	if not var_2:GetMorphTargetId(var_7_3) then
		var_7_5 = 0
	end

	return var_7_4, var_7_5
end

function var_0_1.CanShowMorphBtn(arg_8_0)
	local var_8_0, var_8_1 = arg_8_0:GetMorphBodyIds()
	local var_8_2

	if arg_8_0:IsSelfIsland() then
		var_8_2 = var_8_1 ~= 0
	end

	return var_8_2
end

function var_0_1.IsPlayerIdleForMorph(arg_9_0)
	if not arg_9_0:GetView().player then
		return false
	end

	if arg_9_0.morphing then
		return false
	end

	if var_1.cantMove then
		return false
	end

	if var_1.isNavigating then
		return false
	end

	if var_1.targetSpeed then
		Mathf = var_2

		if not var_2.Approximately(var_1.targetSpeed, 0) then
			return false
		end
	end

	if var_1.OnGrouded and not var_1:OnGrouded() then
		return false
	end

	local var_9_0

	if not var_1.GetAnimator or not var_1:GetAnimator() then
		var_9_0 = var_1.animator
	end

	if var_9_0 then
		local var_9_1 = var_9_0:GetCurrentAnimatorStateInfo(0)
		local var_9_2 = var_9_0

		if var_9_0.IsInTransition(var_9_2, 0) then
			return false
		end

		_ = var_4

		local var_9_3 = var_4.any

		IslandConst = var_9_2

		if var_9_3(var_9_2.CANT_SWITCH_TO_MOVEMENT_STATES, function(arg_10_0)
			local var_10_0 = var_9_1

			return var_1.IsName(var_10_0, arg_10_0)
		end) then
			return false
		end
	end

	return true
end

function var_0_1.UpdateMorphBtn(arg_11_0)
	if not arg_11_0.morphBtn then
		return
	end

	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.CanShowMorphBtn(var_11_0)

	setActive = var_11_0

	var_11_0(arg_11_0.morphBtn, var_11_1)

	if not var_11_1 then
		return
	end

	local var_11_2 = arg_11_0:IsPlayerIdleForMorph()
	local var_11_3 = arg_11_0.morphBtn
	local var_11_4 = var_3.GetComponent

	typeof = var_1_10005
	UnityEngine = var_1_10006

	if var_11_4(var_11_3, var_1_10005(var_1_10006.UI.Button)) then
		var_3.interactable = var_11_2
	end

	local var_11_5 = arg_11_0.morphBtn
	local var_11_6 = var_4.Find(var_11_5, "icon_normal")
	local var_11_7 = arg_11_0.morphBtn
	local var_11_8 = var_5.Find(var_11_7, "icon_gray")

	if var_11_6 then
		setActive = var_11_7

		var_11_7(var_11_6, var_11_2)
	end

	if var_11_8 then
		setActive = var_11_7

		var_11_7(var_11_8, not var_11_2)
	end

	return
end

function var_0_1.StartMorphFreeze(arg_12_0)
	if arg_12_0.morphFreeze then
		return
	end

	arg_12_0.morphFreeze = true

	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.NotifiyCore

	ISLAND_EVT = var_1_10003

	var_12_1(var_12_0, var_1_10003.DISABLE_INPUT)

	pg = var_12_1

	local var_12_2 = var_12_1.UIMgr.GetInstance()

	var_1.LoadingOn(var_12_2, false)

	return
end

function var_0_1.StopMorphFreeze(arg_13_0)
	if not arg_13_0.morphFreeze then
		return
	end

	arg_13_0.morphFreeze = false
	pg = var_1

	local var_13_0 = var_1.UIMgr.GetInstance()

	var_1.LoadingOff(var_13_0)

	local var_13_1 = arg_13_0
	local var_13_2 = arg_13_0.NotifiyCore

	ISLAND_EVT = var_1_10003

	var_13_2(var_13_1, var_1_10003.ENABLE_INPUT)

	return
end

function var_0_1.ResetMorphing(arg_14_0)
	arg_14_0.morphing = false
	arg_14_0.morphTargetBodyId = nil

	arg_14_0:StopMorphFreeze()
	arg_14_0:UpdateMorphBtn()

	return
end

function var_0_1.OnMorphBtnClick(arg_15_0)
	if not arg_15_0:CanShowMorphBtn() then
		return
	end

	if not arg_15_0:IsPlayerIdleForMorph() then
		pg = var_1

		local var_15_0 = var_1.TipsMgr.GetInstance()
		local var_15_1 = var_1.ShowTips

		i18n = var_1_10003

		var_15_1(var_15_0, var_1_10003("island_morph_not_idle"))

		return
	end

	local var_15_2, var_15_3 = arg_15_0:GetMorphBodyIds()

	if var_15_2 == 0 or var_15_3 == 0 then
		return
	end

	arg_15_0.morphing = true
	arg_15_0.morphTargetBodyId = var_15_3

	arg_15_0:StartMorphFreeze()
	arg_15_0:UpdateMorphBtn()

	pg = var_3

	local var_15_4 = var_3.m02
	local var_15_5 = var_3.sendNotification

	GAME = var_1_10005

	var_15_5(var_15_4, var_1_10005.ISLAND_MORPH_FORM_CHANGE, {
		fromBodyDressId = var_15_2,
		toBodyDressId = var_15_3,
		callback = function()
			local var_16_0 = arg_15_0

			var_0.ResetMorphing(var_16_0)

			return
		end
	})

	return
end

function var_0_1.UpdateLureBtn(arg_17_0)
	local var_17_0 = arg_17_0:GetSelfIsland()
	local var_17_1 = var_1.GetFishingAgency(var_17_0)
	local var_17_2 = var_2.GetBaitId(var_17_1)
	local var_17_3 = var_1:GetInventoryAgency()
	local var_17_4 = var_4.GetOwnCount(var_17_3, var_17_2)

	setActive = var_17_3

	var_17_3(arg_17_0.lureEmptyTr, var_17_4 <= 0)

	setActive = var_17_3

	var_17_3(arg_17_0.lureIconTr, var_17_4 > 0)

	local var_17_6

	if 0 < var_17_4 then
		local var_17_5 = var_4

		var_17_6 = var_4.GetItemById(var_17_5, var_17_2)
		GetImageSpriteFromAtlasAsync = var_17_5

		local var_17_7 = "island/"

		var_1_10010 = var_17_6

		var_17_5(var_17_7 .. var_17_6.GetIcon(var_1_10010), "", arg_17_0.lureIconTr)

		arg_17_0.lureIconTxt.text = ""
	end

	onButton = var_17_6

	local var_17_8 = arg_17_0
	local var_17_9 = arg_17_0.lureBtn

	local function var_17_10()
		local var_18_0 = var_0

		if #var_0.GetFishingItems(var_18_0) <= 0 then
			return
		end

		local var_18_1 = arg_17_0
		local var_18_2 = var_1.CreateSubView

		IslandSelectLureOpView = var_2_10003

		local var_18_3 = var_18_2(var_18_1, var_2_10003)

		var_1.Execute(var_18_3, "Show")

		return
	end

	SFX_PANEL = var_1_10010

	var_17_6(var_17_8, var_17_9, var_17_10, var_1_10010)

	return
end

function var_0_1.LaterInit(arg_19_0)
	if arg_19_0.showBalance < 1 then
		arg_19_0:DisablePlayerOp()
	end

	return
end

function var_0_1.UpdateAnimationOpBtn(arg_20_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_20_0 = var_1_10001(var_1_10002)
	local var_20_1 = var_1.GetIsland(var_20_0)
	local var_20_2 = var_1.GetAblityAgency(var_20_1)

	setActive = var_20_1

	local var_20_3 = arg_20_0.animationOpBtn
	local var_20_4 = var_20_2
	local var_20_5 = var_20_2.HasAbility

	IslandAblityAgency = var_1_10007

	var_20_1(var_20_3, var_20_5(var_20_4, var_1_10007.ANIMATION_OP_ID))

	return
end

function var_0_1.Update(arg_21_0)
	var_0_1.super.Update(arg_21_0)
	arg_21_0:UpdateMorphBtn()

	return
end

function var_0_1.UpdateAnimationOpEffect(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_2 then
		table = var_1_10003

		var_1_10003.insert(arg_22_0.animationOpEffectCounter, arg_22_1)
	else
		table = var_1_10003

		var_1_10003.removebyvalue(arg_22_0.animationOpEffectCounter, arg_22_1)
	end

	_ = var_1_10003

	local var_22_0 = var_1_10003.map(arg_22_0.animationOpEffectCounter, function(arg_23_0)
		IslandCalcUtil = var_2_10001

		local var_23_0, var_23_1 = var_2_10001.GetTypeAndIdByUniqueId(arg_23_0)
		local var_23_2 = arg_22_0
		local var_23_3 = var_3.GetView(var_23_2)

		return var_3.GetUnitModuleWithType(var_23_3, var_23_0, var_23_1)
	end)

	_ = var_4

	local var_22_2

	if var_4.detect(var_22_0, function(arg_24_0)
		local var_24_2

		if arg_24_0 then
			::label_24_0::

			isa = var_24_2

			local var_24_0 = arg_24_0

			IslandStrollNpcUnit = var_2_10003

			if var_24_2(var_24_0, var_2_10003) then
				local var_24_1 = arg_24_0.data

				var_24_2 = var_24_2.ExistGreetingActionFeedback(var_24_1)
			end
		end

		return var_24_2
	end) ~= nil then
		::label_22_0::

		local var_22_1 = var_4.data

		var_22_2 = var_6.OnlySkillActionFeedback(var_22_1)
	end

	local var_22_3

	if var_5 then
		::label_22_1::

		var_1_10008 = var_4.data
		var_22_3 = var_7.ExistSkillActionFeedback(var_1_10008)
	end

	setActive = var_1_10008

	var_1_10008(arg_22_0.animationOpSkillEffect, var_22_2)

	setActive = var_1_10008

	var_1_10008(arg_22_0.animationOpEffect, var_5 and not var_22_2)

	setActive = var_1_10008

	var_1_10008(arg_22_0.animationOpSkillTip, var_22_3)

	return
end

function var_0_1.UpdateFollowBtn(arg_25_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_25_0 = var_1_10001(var_1_10002)
	local var_25_1 = var_1.GetIsland(var_25_0)
	local var_25_2 = var_1.GetFollowerAgency(var_25_1)

	if #var_2.GetFollowers(var_25_2) <= 0 or not arg_25_0:IsSelfIsland() then
		setActive = var_4

		var_4(arg_25_0.followerBtn, false)

		return
	end

	setActive = var_4

	var_4(arg_25_0.followerBtn, true)

	return
end

function var_0_1.ShowFollowerList(arg_26_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_26_0 = var_1_10001(var_1_10002)
	local var_26_1 = var_1.GetIsland(var_26_0)
	local var_26_2 = var_1.GetFollowerAgency(var_26_1)
	local var_26_3 = var_2.GetFollowers(var_26_2)
	local var_26_4 = var_1:GetCharacterAgency()

	if #var_26_3 <= 0 then
		return
	end

	local var_26_5 = arg_26_0.uiFollowerList

	var_5.make(var_26_5, function(arg_27_0, arg_27_1, arg_27_2)
		UIItemList = var_2_10003

		if arg_27_0 == var_2_10003.EventUpdate then
			local var_27_0 = var_26_3[arg_27_1 + 1]
			local var_27_1 = var_26_4
			local var_27_2 = var_4.GetShipById(var_27_1, var_27_0)

			IslandShip = var_27_1

			local var_27_3 = var_27_1.StaticGetPrefab(var_27_2.configId)

			GetImageSpriteFromAtlasAsync = var_6

			local var_27_4 = "island/IslandShipIcon/" .. var_27_3
			local var_27_5 = ""
			local var_27_6 = arg_27_2

			var_6(var_27_4, var_27_5, arg_27_2.Find(var_27_6, "icon"))

			onButton = var_6

			local var_27_7 = arg_26_0
			local var_27_8 = arg_27_2

			local function var_27_9()
				local var_28_0 = arg_26_0
				local var_28_1 = var_0.NotifiyCore

				ISLAND_EVT = var_3_10002

				var_28_1(var_28_0, var_3_10002.WILL_DEL_FOLLOWER, var_27_2.id)

				return
			end

			SFX_PANEL = var_27_6

			var_6(var_27_7, var_27_8, var_27_9, var_27_6)
		end

		return
	end)

	local var_26_6 = arg_26_0.uiFollowerList

	var_5.align(var_26_6, #var_26_3)

	setActive = var_5

	var_5(arg_26_0.uiFollowerPanel, true)
	arg_26_0:AddDisableFollowerListTimer()

	return
end

function var_0_1.AddDisableFollowerListTimer(arg_29_0)
	arg_29_0:RemoveFollowerListTimer()

	Timer = var_1
	arg_29_0.followerTimer = var_1.New(function()
		local var_30_0 = arg_29_0

		var_0.RemoveFollowerListTimer(var_30_0)

		setActive = var_0

		var_0(arg_29_0.uiFollowerPanel, false)

		return
	end, 5, 1)

	local var_29_0 = arg_29_0.followerTimer

	var_1.Start(var_29_0)

	return
end

function var_0_1.RemoveFollowerListTimer(arg_31_0)
	if arg_31_0.followerTimer then
		local var_31_0 = arg_31_0.followerTimer

		var_1.Stop(var_31_0)

		arg_31_0.followerTimer = nil
	end

	return
end

function var_0_1.FlushFollowerList(arg_32_0)
	arg_32_0:UpdateFollowBtn()

	if not arg_32_0.followerTimer then
		return
	end

	arg_32_0:ShowFollowerList()

	return
end

function var_0_1.InitOpCustumPositon(arg_33_0)
	tf = var_1_10001
	GameObject = var_1_10002

	local var_33_0 = var_1_10001(var_1_10002.Find("UICamera/Canvas")).sizeDelta.x

	IslandSettingsConst = var_3

	local var_33_1 = var_33_0 / var_3.settingRectSize.x
	local var_33_2 = var_1.y

	IslandSettingsConst = var_1_10004

	local var_33_3 = var_33_2 / var_1_10004.settingRectSize.y

	IslandSettingsConst = var_4

	local var_33_4 = var_4.ISLAND_JOY_STICK_DEFAULT_PREFERENCE

	PlayerPrefs = var_1_10005

	local var_33_5 = var_1_10005.GetFloat

	IslandSettingsConst = var_1_10006

	local var_33_6 = var_33_5(var_1_10006.ISLAND_KEY_JOYSTICK_ANCHORX, var_33_4.x)

	PlayerPrefs = var_6

	local var_33_7 = var_6.GetFloat

	IslandSettingsConst = var_7

	local var_33_8 = var_33_7(var_7.ISLAND_KEY_JOYSTICK_ANCHORY, var_33_4.y)
	local var_33_9 = arg_33_0.moveBtn

	Vector2 = var_8
	var_33_9.anchoredPosition = var_8(var_33_6 * var_33_1, var_33_8 * var_33_3)

	local var_33_10 = {
		arg_33_0.opBtn
	}
	local var_33_11 = arg_33_0.opPanel

	var_33_10[2] = var_8.Find(var_33_11, "jump")
	var_33_10[3] = arg_33_0.areaChangeBtn
	var_33_10[4] = arg_33_0.seedBtn
	ipairs = var_8

	for iter_33_0, iter_33_1 in var_8(var_33_10) do
		IslandSettingsConst = var_1_10013
		var_1_10013 = var_1_10013.OPERATION_DEFAULT_PREFERENCE[iter_33_0]
		PlayerPrefs = var_1_10014
		var_1_10014 = var_1_10014.GetFloat
		IslandSettingsConst = var_1_10015
		var_1_10014 = var_1_10014(var_1_10015.ISLAND_KEY_OPERATION_ANCHORX[iter_33_0], var_1_10013.x)
		PlayerPrefs = var_1_10015
		var_1_10015 = var_1_10015.GetFloat
		IslandSettingsConst = var_16
		var_1_10015 = var_1_10015(var_16.ISLAND_KEY_OPERATION_ANCHORY[iter_33_0], var_1_10013.y)
		Vector2 = var_16
		iter_33_1.anchoredPosition = var_16(var_1_10014 * var_33_1, var_1_10015 * var_33_3)
	end

	arg_33_0.lureBtn.anchoredPosition = arg_33_0.seedBtn.anchoredPosition

	return
end

function var_0_1.UpdateOperationButton(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_1 == var_0_1.OperationType.None then
		if arg_34_0.unitId == arg_34_2 then
			arg_34_0.unitId = nil
			arg_34_0.operationType = arg_34_1
		end
	else
		arg_34_0.unitId = arg_34_2
		arg_34_0.operationType = arg_34_1
	end

	arg_34_0:UpdateOperationButtonDisplay()

	return
end

function var_0_1.UpdateOperationButtonDisplay(arg_35_0)
	setActive = var_1_10001

	var_1_10001(arg_35_0.lureBtn, false)

	local function var_35_0(arg_36_0)
		ipairs = var_2_10001

		for iter_36_0, iter_36_1 in var_2_10001(arg_35_0.opBtnList) do
			local var_36_0 = iter_36_0 == arg_36_0

			setActive = var_2_10007

			var_2_10007(iter_36_1, var_36_0)
		end

		return
	end

	local var_35_1 = OptionBtnDisplay

	if arg_35_0.operationType == var_0_1.OperationType.None then
		setActive = var_1

		var_1(arg_35_0.opBtn, false)

		setActive = var_1

		var_1(arg_35_0.areaChangeBtn, false)

		setActive = var_1

		var_1(arg_35_0.seedBtn, false)

		local var_35_2 = arg_35_0:GetView()
		local var_35_3 = var_1.GetSubView

		IslandSeedOpView = var_3

		local var_35_4 = var_35_3(var_35_2, var_3)

		var_1.ActiveSeedSelect(var_35_4, false)

		local var_35_5 = arg_35_0:GetView()
		local var_35_6 = var_1.GetSubView

		IslandSeedOpView = var_3

		local var_35_7 = var_35_6(var_35_5, var_3)

		var_1.ActiveSeedDetals(var_35_7, false)

		OptionBtnDisplay = var_1

		var_1(arg_35_0.operationType)

		return
	end

	local var_35_8 = arg_35_0.view
	local var_35_9 = var_1.GetUnitModuleWithType

	IslandConst = var_3

	local var_35_10 = var_35_9(var_35_8, var_3.UNIT_LIST_OBJ, arg_35_0.unitId)
	local var_35_12

	if arg_35_0.operationType ~= var_0_1.OperationType.Fishing and not var_35_10 then
		setActive = var_35_12

		var_35_12(arg_35_0.opBtn, false)

		setActive = var_35_12

		var_35_12(arg_35_0.areaChangeBtn, false)

		setActive = var_35_12

		var_35_12(arg_35_0.seedBtn, false)

		local var_35_11 = arg_35_0:GetView()

		var_35_12 = var_35_12.GetSubView
		IslandSeedOpView = var_4

		local var_35_13 = var_35_12(var_35_11, var_4)

		var_35_12.ActiveSeedSelect(var_35_13, false)

		local var_35_14 = arg_35_0:GetView()

		var_35_12 = var_35_12.GetSubView
		IslandSeedOpView = var_4

		local var_35_15 = var_35_12(var_35_14, var_4)

		var_35_12.ActiveSeedDetals(var_35_15, false)

		return
	end

	setActive = var_35_12

	var_35_12(arg_35_0.opBtn, true)

	local function var_35_16()
		OptionBtnDisplay = var_2_10000

		var_2_10000(arg_35_0.operationType)

		onButton = var_2_10000

		local var_37_0 = arg_35_0
		local var_37_1 = arg_35_0.opBtn

		local function var_37_2()
			local var_38_0 = arg_35_0.view
			local var_38_1 = var_0.GetCore(var_38_0)
			local var_38_2 = arg_35_0.view
			local var_38_3 = var_1.GetUnitModuleWithType

			IslandConst = var_3_10003

			local var_38_4 = var_38_3(var_38_2, var_3_10003.UNIT_LIST_OBJ, arg_35_0.unitId)
			local var_38_5 = var_1.GetAnimatorTrigger(var_38_4)

			if var_1:CheckCanStartColloct() then
				local var_38_6 = var_38_1.controller.playerInputManager

				var_4.UpdataWorkStateFunc(var_38_6, var_38_5, var_1)
			end

			return
		end

		SFX_PANEL = var_2_10004

		var_2_10000(var_37_0, var_37_1, var_37_2, var_2_10004)

		setActive = var_2_10000

		var_2_10000(arg_35_0.areaChangeBtn, false)

		setActive = var_2_10000

		var_2_10000(arg_35_0.seedBtn, false)

		return
	end

	switch = var_3

	var_3(arg_35_0.operationType, {
		[var_0_1.OperationType.Plant] = function()
			local var_39_0 = arg_35_0.view
			local var_39_1 = var_0.GetUnitModuleWithType

			IslandConst = var_2_10002

			local var_39_2 = var_39_1(var_39_0, var_2_10002.UNIT_LIST_OBJ, arg_35_0.unitId)
			local var_39_4

			if var_0.CanHarvest(var_39_2) then
				OptionBtnDisplay = var_1

				var_1(var_0_1.OperationType.Harvest)

				onButton = var_1

				local var_39_3 = arg_35_0

				var_39_4 = arg_35_0.opBtn

				function var_2_10004()
					local var_40_0 = arg_35_0.view
					local var_40_1 = var_0.GetCore(var_40_0).controller.playerInputManager
					local var_40_2 = var_1.UpdataWorkStateFunc

					IslandConst = var_3_10003

					var_40_2(var_40_1, var_3_10003.GAHTER_FLAG, var_0)

					local var_40_3 = {}

					ipairs = var_40_1

					local var_40_4 = arg_35_0.view.detectionSystem

					for iter_40_0, iter_40_1 in var_40_1(var_3.GetAreaList(var_40_4)) do
						local var_40_5 = arg_35_0.view
						local var_40_6 = var_7.GetUnitModuleWithType

						IslandConst = var_3_10009

						local var_40_7 = var_40_6(var_40_5, var_3_10009.UNIT_LIST_OBJ, iter_40_1)

						table = var_40_5

						var_40_5.insert(var_40_3, var_40_7.handDate.configId)
					end

					pg = var_2

					local var_40_8 = var_2.m02
					local var_40_9 = var_2.sendNotification

					GAME = var_4

					var_40_9(var_40_8, var_4.ISLAND_START_HANDLE_HARVEST, {
						slot_list = var_40_3
					})

					return
				end

				SFX_PANEL = var_2_10005

				var_1(var_39_3, var_39_4, var_2_10004, var_2_10005)

				setActive = var_1

				var_1(arg_35_0.seedBtn, false)
			else
				local var_39_8

				if var_0:CanPlant() then
					IslandGuideChecker = var_39_8

					var_39_8.CheckGuide("ISLAND_GUIDE_22")

					OptionBtnDisplay = var_39_8

					var_39_8(var_0_1.OperationType.Plant)

					onButton = var_39_8

					local var_39_5 = arg_35_0

					var_39_4 = arg_35_0.opBtn

					function var_2_10004()
						local var_41_0 = arg_35_0
						local var_41_1 = var_0.GetView(var_41_0)
						local var_41_2 = var_0.GetSubView

						IslandSeedOpView = var_3_10002

						local var_41_4

						if not var_41_2(var_41_1, var_3_10002).selectseedItemId then
							pg = var_41_4

							local var_41_3 = var_41_4.TipsMgr.GetInstance()

							var_41_4 = var_41_4.ShowTips
							i18n = var_3_10002

							var_41_4(var_41_3, var_3_10002("island_production_seeds_empty"))

							return
						end

						pg = var_41_4

						local var_41_5 = var_41_4.island_farm_seed
						local var_41_6 = arg_35_0
						local var_41_7 = var_1.GetView(var_41_6)
						local var_41_8 = var_1.GetSubView

						IslandSeedOpView = var_3_10003

						local var_41_9 = var_41_5[var_41_8(var_41_7, var_3_10003).selectseedItemId]

						pg = var_1

						local var_41_10 = var_1.island_formula[var_41_9.formulaid]
						local var_41_11 = arg_35_0.view.detectionSystem
						local var_41_12 = #var_2.GetAreaList(var_41_11)
						local var_41_13

						if not (function(arg_42_0)
							getProxy = var_4_10001
							IslandProxy = var_4_10002

							local var_42_0 = var_4_10001(var_4_10002)
							local var_42_1 = var_1.GetIsland(var_42_0)
							local var_42_2 = var_1.GetInventoryAgency(var_42_1)

							ipairs = var_42_1

							for iter_42_0, iter_42_1 in var_42_1(arg_42_0) do
								local var_42_3 = iter_42_1[1]
								local var_42_4 = iter_42_1[2]
								local var_42_5 = var_42_2:GetItemById(var_42_3)

								if var_9.GetCount(var_42_5) < var_42_4 * var_41_12 then
									return false
								end

								return true
							end

							return
						end)(var_41_10.cost) then
							pg = var_4
							var_41_13 = var_4.TipsMgr.GetInstance()

							local var_41_14 = var_4.ShowTips

							i18n = var_3_10006

							var_41_14(var_41_13, var_3_10006("island_production_seeds_notenough"))

							return
						end

						local var_41_15 = {}

						ipairs = var_41_13

						local var_41_16 = arg_35_0.view.detectionSystem

						for iter_41_0, iter_41_1 in var_41_13(var_6.GetAreaList(var_41_16)) do
							local var_41_17 = arg_35_0.view
							local var_41_18 = var_10.GetUnitModuleWithType

							IslandConst = var_3_10012

							local var_41_19 = var_41_18(var_41_17, var_3_10012.UNIT_LIST_OBJ, iter_41_1)

							table = var_41_17

							var_41_17.insert(var_41_15, var_41_19.handDate.configId)
						end

						pg = var_5

						local var_41_20 = var_5.m02
						local var_41_21 = var_5.sendNotification

						GAME = var_7

						var_41_21(var_41_20, var_7.ISLAND_START_HANDLE_PLANT, {
							slot_list = var_41_15,
							formula_id = var_41_9.formulaid
						})

						local var_41_22 = arg_35_0.view
						local var_41_23 = var_5.GetCore(var_41_22).controller.playerInputManager
						local var_41_24 = var_6.UpdataWorkStateFunc

						IslandConst = var_8

						var_41_24(var_41_23, var_8.SOW_FLAG, var_0)

						return
					end

					SFX_PANEL = var_2_10005

					var_39_8(var_39_5, var_39_4, var_2_10004, var_2_10005)

					local var_39_6 = arg_35_0
					local var_39_7 = var_39_8.GetView(var_39_6)

					var_39_8 = var_39_8.GetSubView
					IslandSeedOpView = var_39_4

					local var_39_9 = var_39_8(var_39_7, var_39_4)

					var_39_8 = var_39_8.CheckSeedEmpty(var_39_9, var_0)
					setActive = var_39_9

					var_39_9(arg_35_0.seedEmpty, var_39_8)

					setActive = var_39_9

					var_39_9(arg_35_0.seedBtn, true)

					setActive = var_39_9
					var_2_10004 = arg_35_0.seedBtn

					var_39_9(var_39_4.Find(var_2_10004, "seedItem"), not var_39_8)

					if not var_39_8 then
						onButton = var_39_9
						var_39_4 = arg_35_0
						var_2_10004 = arg_35_0.seedBtn

						function var_2_10005()
							local var_43_0 = arg_35_0
							local var_43_1 = var_0.GetView(var_43_0)
							local var_43_2 = var_0.GetSubView

							IslandSeedOpView = var_3_10002

							local var_43_3 = var_43_2(var_43_1, var_3_10002)

							var_0.ActiveSeedSelect(var_43_3, true)

							local var_43_4 = arg_35_0
							local var_43_5 = var_0.GetView(var_43_4)
							local var_43_6 = var_0.GetSubView

							IslandSeedOpView = var_2

							local var_43_7 = var_43_6(var_43_5, var_2)

							var_0.RefreshSeedPlane(var_43_7, var_0)

							return
						end

						SFX_PANEL = var_2_10006

						var_39_9(var_39_4, var_2_10004, var_2_10005, var_2_10006)

						var_39_4 = arg_35_0

						var_2.RefreshCurrentSlectSeed(var_39_4)
					end
				else
					OptionBtnDisplay = var_39_8

					var_39_8(var_0_1.OperationType.Interaction)

					onButton = var_39_8

					local var_39_10 = arg_35_0

					var_39_4 = arg_35_0.opBtn

					function var_2_10004()
						pg = var_3_10000

						local var_44_0 = var_3_10000.TipsMgr.GetInstance()
						local var_44_1 = var_0.ShowTips

						i18n = var_3_10002

						var_44_1(var_44_0, var_3_10002("island_production_being_planted"))

						return
					end

					SFX_PANEL = var_2_10005

					var_39_8(var_39_10, var_39_4, var_2_10004, var_2_10005)

					setActive = var_39_8

					var_39_8(arg_35_0.seedBtn, false)
				end
			end

			local var_39_11 = var_0
			local var_39_12 = var_0.GetDataVO(var_39_11).slotData.configId

			pg = var_39_11

			local var_39_13 = var_39_11.island_production_slot[var_39_12].place

			IslandProductConst = var_39_4

			local var_39_14 = var_39_13 == var_39_4.FarmlandPlaceId

			setActive = var_2_10004

			local var_39_15 = arg_35_0.areaChangeBtn

			if var_39_14 then
				::label_39_0::

				getProxy = var_2_10006
				IslandProxy = var_2_10007

				local var_39_16 = var_2_10006(var_2_10007)
				local var_39_17 = var_2_10006.GetIsland(var_39_16)
				local var_39_18 = var_2_10006.GetAblityAgency(var_39_17)

				var_2_10006 = var_2_10006.IsUnlockAreaPlant(var_39_18)
			end

			var_2_10004(var_39_15, var_2_10006)

			return
		end,
		[var_0_1.OperationType.MiningCollect] = function()
			var_35_16()

			return
		end,
		[var_0_1.OperationType.WildGather] = function()
			local var_46_0 = arg_35_0.view
			local var_46_1 = var_0.GetUnitModuleWithType

			IslandConst = var_2_10002

			local var_46_2 = var_46_1(var_46_0, var_2_10002.UNIT_LIST_OBJ, arg_35_0.unitId)
			local var_46_3 = arg_35_0.view
			local var_46_4 = var_1.GetIsland(var_46_3).id

			getProxy = var_3
			IslandProxy = var_2_10004

			local var_46_5 = var_3(var_2_10004)

			if var_46_4 == var_3.GetIsland(var_46_5).id then
				OptionBtnDisplay = var_3

				var_3(var_0_1.OperationType.WildGather)

				onButton = var_3

				local var_46_6 = arg_35_0
				local var_46_7 = arg_35_0.opBtn

				local function var_46_8()
					local var_47_0 = arg_35_0.view
					local var_47_1 = var_0.GetCore(var_47_0).controller.playerInputManager
					local var_47_2 = var_1.UpdataWorkStateFunc

					IslandConst = var_3_10003

					var_47_2(var_47_1, var_3_10003.GAHTERD_FLAG, var_46_2)

					local var_47_3 = var_46_2

					var_1.StartGather(var_47_3, var_0.id)

					return
				end

				SFX_PANEL = var_2_10007

				var_3(var_46_6, var_46_7, var_46_8, var_2_10007)
			elseif var_46_2:CheckGatherCanSign() then
				OptionBtnDisplay = var_3

				var_3(var_0_1.OperationType.WildGather)

				onButton = var_3

				local var_46_9 = arg_35_0
				local var_46_10 = arg_35_0.opBtn

				local function var_46_11()
					local var_48_0 = var_46_2

					var_0.StartGaherSign(var_48_0, var_0.id)

					return
				end

				SFX_PANEL = var_2_10007

				var_3(var_46_9, var_46_10, var_46_11, var_2_10007)
			else
				setActive = var_3

				var_3(arg_35_0.opBtn, false)
			end

			return
		end,
		[var_0_1.OperationType.FellCollect] = function()
			var_35_16()

			return
		end,
		[var_0_1.OperationType.Fishing] = function()
			IslandGuideChecker = var_2_10000

			var_2_10000.CheckGuide("ISLAND_GUIDE_33")

			local var_50_0 = arg_35_0

			var_0.UpdateLureBtn(var_50_0)

			OptionBtnDisplay = var_0

			var_0(arg_35_0.operationType)

			setActive = var_0

			var_0(arg_35_0.lureBtn, true)

			onButton = var_0

			local var_50_1 = arg_35_0
			local var_50_2 = arg_35_0.opBtn

			local function var_50_3()
				local var_51_0 = arg_35_0
				local var_51_1 = var_0.GetSelfIsland(var_51_0)
				local var_51_2 = var_0.GetFishingAgency(var_51_1)
				local var_51_3 = var_0.GetBaitId(var_51_2)
				local var_51_4 = arg_35_0
				local var_51_5 = var_1.GetSelfIsland(var_51_4)
				local var_51_6 = var_1.GetInventoryAgency(var_51_5)

				if var_1.GetOwnCount(var_51_6, var_51_3) <= 0 then
					pg = var_1

					local var_51_7 = var_1.TipsMgr.GetInstance()
					local var_51_8 = var_1.ShowTips

					i18n = var_3

					var_51_8(var_51_7, var_3("island_fishing_lure_empty"))
				else
					local var_51_9 = arg_35_0
					local var_51_10 = var_1.GetView(var_51_9).player

					if var_1.OnGrouded(var_51_10) then
						local var_51_11 = arg_35_0
						local var_51_12 = var_1.CreateSubView

						IslandFishingOPView = var_3

						local var_51_13 = var_51_12(var_51_11, var_3)

						var_1.Execute(var_51_13, "Show", arg_35_0.unitId, arg_35_0.opBtn.localPosition)
					end
				end

				return
			end

			SFX_PANEL = var_2_10004

			var_0(var_50_1, var_50_2, var_50_3, var_2_10004)

			return
		end
	})

	return
end

function var_0_1.RefreshCurrentSlectSeed(arg_52_0)
	local var_52_0 = arg_52_0.seedBtn
	local var_52_1 = var_1.Find(var_52_0, "seedItem")
	local var_52_2 = arg_52_0:GetView()
	local var_52_3 = var_2.GetSubView

	IslandSeedOpView = var_1_10004

	if not var_52_3(var_52_2, var_1_10004).selectseedItemId then
		setActive = var_52_2

		var_52_2(var_52_1, false)

		return
	end

	setActive = var_52_2

	var_52_2(var_52_1, true)

	getProxy = var_52_2
	IslandProxy = var_4

	local var_52_4 = var_52_2(var_4)
	local var_52_5 = var_3.GetIsland(var_52_4)
	local var_52_6 = var_3.GetInventoryAgency(var_52_5)

	pg = var_52_5

	local var_52_7 = var_52_5.island_farm_seed[var_2]
	local var_52_8 = var_52_6

	if not var_52_6.GetItemById(var_52_8, var_52_7.itemid) then
		local var_52_9

		setActive = var_52_8

		var_52_8(var_52_1, false)

		return
	end

	setText = var_52_8

	var_52_8(var_52_1:Find("count"), var_5:GetCount())

	local var_52_10 = "island/" .. var_5:GetIcon()

	GetImageSpriteFromAtlasAsync = var_7

	var_7(var_52_10, "", var_52_1:Find("icon"))

	return
end

function var_0_1.GetSeedBtnWorldPos(arg_53_0)
	return arg_53_0.seedBtn.position
end

function var_0_1.TryDisablePlayerOp(arg_54_0)
	arg_54_0.showBalance = arg_54_0.showBalance - 1

	if arg_54_0.showBalance == 0 then
		arg_54_0:DisablePlayerOp()
	end

	return
end

function var_0_1.TryEnablePlayerOp(arg_55_0)
	arg_55_0.showBalance = arg_55_0.showBalance + 1

	if arg_55_0.showBalance == 1 then
		arg_55_0:EnablePlayerOp()
	end

	return
end

function var_0_1.ResetShowBalance(arg_56_0)
	if arg_56_0.showBalance ~= 1 then
		arg_56_0.showBalance = 1

		arg_56_0:EnablePlayerOp()
	end

	return
end

function var_0_1.DisablePlayerOp(arg_57_0)
	arg_57_0:ShowOrHideGameObject(arg_57_0.opPanel, false)
	arg_57_0:ShowOrHideGameObject(arg_57_0.moveBtn, false)

	local var_57_0 = arg_57_0:GetView()
	local var_57_1 = var_1.GetSubView

	IslandInteractionView = var_3

	local var_57_2 = var_57_1(var_57_0, var_3)

	var_1.DisableInteraction(var_57_2)

	local var_57_3 = arg_57_0.playerInputManager

	var_1.DisableInput(var_57_3)

	local var_57_4 = arg_57_0:GetView()
	local var_57_5 = var_1.GetSubView

	IslandDistanceView = var_3

	local var_57_6 = var_57_5(var_57_4, var_3)

	var_1.TryDisable(var_57_6)

	local var_57_7 = arg_57_0:GetView().player

	var_1.ActiveOrDisactive(var_57_7, false)

	return
end

function var_0_1.EnablePlayerOp(arg_58_0)
	arg_58_0:ShowOrHideGameObject(arg_58_0.opPanel, true)
	arg_58_0:ShowOrHideGameObject(arg_58_0.moveBtn, true)

	local var_58_0 = arg_58_0:GetView()
	local var_58_1 = var_1.GetSubView

	IslandInteractionView = var_3

	local var_58_2 = var_58_1(var_58_0, var_3)

	var_1.EnableInteraction(var_58_2)

	local var_58_3 = arg_58_0.playerInputManager

	var_1.EnableInput(var_58_3)

	local var_58_4 = arg_58_0:GetView()
	local var_58_5 = var_1.GetSubView

	IslandDistanceView = var_3

	local var_58_6 = var_58_5(var_58_4, var_3)

	var_1.TryEnable(var_58_6)

	local var_58_7 = arg_58_0:GetView().player

	var_1.ActiveOrDisactive(var_58_7, true)

	if arg_58_0.inInteraction then
		arg_58_0:StartInteraction()
	end

	return
end

function var_0_1.StartInteraction(arg_59_0)
	arg_59_0.inInteraction = true

	arg_59_0:ShowOrHideGameObject(arg_59_0.moveBtn, false)
	arg_59_0:ShowOrHideGameObject(arg_59_0.opPanel, false)

	local var_59_0 = arg_59_0.playerInputManager

	var_1.DisablePlayerHandle(var_59_0)

	local var_59_1 = arg_59_0:GetView().player

	var_1.StopMoveHandle(var_59_1)

	return
end

function var_0_1.EndInteraction(arg_60_0)
	arg_60_0.inInteraction = false

	arg_60_0:ShowOrHideGameObject(arg_60_0.moveBtn, true)
	arg_60_0:ShowOrHideGameObject(arg_60_0.opPanel, true)

	local var_60_0 = arg_60_0.playerInputManager

	var_1.EnablePlayerHandle(var_60_0)

	return
end

function var_0_1.DisableInput(arg_61_0)
	local var_61_0 = arg_61_0.playerInputManager

	var_1.DisableInput(var_61_0)

	return
end

function var_0_1.EnableInput(arg_62_0)
	local var_62_0 = arg_62_0.playerInputManager

	var_1.EnableInput(var_62_0)

	return
end

function var_0_1.ChangeTakePhotoModel(arg_63_0, arg_63_1, arg_63_2)
	IslandConst = var_1_10003

	if arg_63_1 == var_1_10003.TakePhotoModel.None then
		if not arg_63_2 then
			arg_63_0:ShowOrHideMoveBtn(false)

			local var_63_0 = arg_63_0.playerInputManager

			var_3.DisableInput(var_63_0)

			local var_63_1 = arg_63_0:GetView().player

			var_3.ActiveOrDisactive(var_63_1, false)
		end
	else
		IslandConst = var_3

		if arg_63_1 == var_3.TakePhotoModel.First then
			arg_63_0:ShowOrHideMoveBtn(true)

			local var_63_2 = arg_63_0.playerInputManager

			var_3.EnableInput(var_63_2)

			local var_63_3 = arg_63_0:GetView().player

			var_3.ActiveOrDisactive(var_63_3, true)
		else
			arg_63_0:ShowOrHideMoveBtn(true)

			local var_63_4 = arg_63_0.playerInputManager

			var_3.EnableInput(var_63_4)

			local var_63_5 = arg_63_0:GetView().player

			var_3.ActiveOrDisactive(var_63_5, true)
		end
	end

	return
end

function var_0_1.ShowOrHideMoveBtn(arg_64_0, arg_64_1, arg_64_2)
	GetOrAddComponent = var_1_10003

	local var_64_0 = arg_64_0.moveBtn

	typeof = var_1_10005
	CanvasGroup = var_1_10006

	local var_64_1 = var_1_10003(var_64_0, var_1_10005(var_1_10006))

	var_64_1.alpha = arg_64_1 and 1 or 0
	var_64_1.blocksRaycasts = arg_64_1 or arg_64_2

	return
end

function var_0_1.OnDestroy(arg_65_0)
	arg_65_0:StopMorphFreeze()

	if arg_65_0.opUI then
		local var_65_0 = arg_65_0:GetPoolMgr()

		var_1.ReturnOpUI(var_65_0, arg_65_0.opUI.gameObject)

		arg_65_0.opUI = nil
	end

	arg_65_0:RemoveFollowerListTimer()

	arg_65_0.animationOpEffectCounter = {}

	return
end

return var_0_1
