local var_0_0 = class("IslandOpView", import(".IslandBaseOpView"))

var_0_0.OperationType = {
	Plant = 2,
	MiningCollect = 3,
	FellCollect = 6,
	Fishing = 7,
	Harvest = 4,
	Interaction = 1,
	WildGather = 5,
	None = 0
}

function var_0_0.GetUIName(arg_1_0)
	return "IslandEmptyUI"
end

function var_0_0.OnInit(arg_2_0, arg_2_1)
	arg_2_0.opUI = arg_2_0:GetPoolMgr():GetOpUI().transform

	setParent(arg_2_0.opUI, arg_2_1)

	local var_2_0 = arg_2_0:GetView():GetCacheOpCount()

	var_2_0 = var_2_0 or 1
	arg_2_0.showBalance = var_2_0
	arg_2_0.inputController = IslandCameraMgr.instance.gameObject:GetComponent(typeof(InputController))
	arg_2_0._go = arg_2_1
	arg_2_0._tf = arg_2_1.transform
	arg_2_0.opPanel = arg_2_0.opUI:Find("op_btns")
	arg_2_0.opBtn = arg_2_0.opPanel:Find("op_btn")
	arg_2_0.opBtnList = {
		arg_2_0.opBtn:Find("interaction"),
		arg_2_0.opBtn:Find("plant"),
		arg_2_0.opBtn:Find("miningCollect"),
		arg_2_0.opBtn:Find("harvest"),
		arg_2_0.opBtn:Find("wildgather"),
		arg_2_0.opBtn:Find("fellCollect"),
		arg_2_0.opBtn:Find("fishing")
	}
	arg_2_0.morphBtn = arg_2_0.opPanel:Find("morph")
	arg_2_0.seedBtn = arg_2_0.opPanel:Find("seed")
	arg_2_0.seedEmpty = arg_2_0.seedBtn:Find("seedEmpty")
	arg_2_0.areaChangeBtn = arg_2_0.opPanel:Find("scope")
	arg_2_0.run = arg_2_0.opPanel:Find("run")
	arg_2_0.moveBtn = arg_2_0.opUI:Find("move")
	arg_2_0.animationOpBtn = arg_2_0.opPanel:Find("aniamtionop")
	arg_2_0.animationOpEffect = arg_2_0.animationOpBtn:Find("effect")
	arg_2_0.animationOpSkillTip = arg_2_0.animationOpBtn:Find("tip")
	arg_2_0.animationOpSkillEffect = arg_2_0.animationOpBtn:Find("effect_skill")
	arg_2_0.followerBtn = arg_2_0.opPanel:Find("follower")
	arg_2_0.lureBtn = arg_2_0.opPanel:Find("lure")
	arg_2_0.lureEmptyTr = arg_2_0.lureBtn:Find("empty")
	arg_2_0.lureIconTr = arg_2_0.lureBtn:Find("icon")
	arg_2_0.lureIconTxt = arg_2_0.lureBtn:Find("icon/count"):GetComponent(typeof(Text))
	arg_2_0.animationOpEffectCounter = {}
	arg_2_0.morphing = false
	arg_2_0.uiFollowerPanel = arg_2_0.followerBtn:Find("list")
	arg_2_0.uiFollowerList = UIItemList.New(arg_2_0.uiFollowerPanel, (arg_2_0.uiFollowerPanel:Find("tpl")))

	setActive(arg_2_0.opPanel, true)
	setActive(arg_2_0.lureBtn, false)
	onButton(arg_2_0, arg_2_0.areaChangeBtn, function()
		arg_2_0:NotifiyCore(ISLAND_EVT.AREACHANGE)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.morphBtn, function()
		arg_2_0:OnMorphBtnClick()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.animationOpBtn, function()
		arg_2_0:NotifiyCore(ISLAND_EVT.OPEN_ANIMATION_OP)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.followerBtn, function()
		if isActive(arg_2_0.uiFollowerPanel) then
			arg_2_0:RemoveFollowerListTimer()
			setActive(arg_2_0.uiFollowerPanel, false)
		else
			arg_2_0:ShowFollowerList()
		end

		return
	end, SFX_PANEL)

	arg_2_0.operationType = var_0_0.OperationType.None

	arg_2_0:UpdateOperationButtonDisplay()

	arg_2_0.playerInputManager = arg_2_0.view:GetController().playerInputManager

	arg_2_0:InitOpCustumPositon()
	arg_2_0:UpdateFollowBtn()
	arg_2_0:UpdateAnimationOpBtn()
	arg_2_0:UpdateLureBtn()
	arg_2_0:UpdateMorphBtn()

	return
end

function var_0_0.GetMorphBodyIds(arg_7_0)
	local var_7_0 = getProxy(IslandProxy):GetIsland()

	if not var_7_0 then
		return 0, 0
	end

	local var_7_1 = var_7_0:GetDressUpAgency()

	if not var_7_1 then
		return 0, 0
	end

	local var_7_2 = var_7_1:GetDressByType(IslandShipDressHelperNew.DressType.Body) or 0
	local var_7_3

	if var_7_2 == 0 then
		do return 0, 0 end

		var_7_3 = var_7_1:GetMorphTargetId(var_7_2) or 0
	end

	return var_7_2, var_7_3
end

function var_0_0.CanShowMorphBtn(arg_8_0)
	local var_8_0, var_8_1 = arg_8_0:GetMorphBodyIds()

	return arg_8_0:IsSelfIsland() and var_8_1 ~= 0
end

function var_0_0.IsPlayerIdleForMorph(arg_9_0)
	local var_9_0 = arg_9_0:GetView().player

	if not var_9_0 then
		return false
	end

	if arg_9_0.morphing then
		return false
	end

	if var_9_0.cantMove then
		return false
	end

	if var_9_0.isNavigating then
		return false
	end

	if var_9_0.targetSpeed and not Mathf.Approximately(var_9_0.targetSpeed, 0) then
		return false
	end

	if var_9_0.OnGrouded and not var_9_0:OnGrouded() then
		return false
	end

	local var_9_1 = var_9_0.GetAnimator and var_9_0:GetAnimator() or var_9_0.animator

	if var_9_1 then
		local var_9_2 = var_9_1:GetCurrentAnimatorStateInfo(0)

		if var_9_1:IsInTransition(0) then
			return false
		end

		if _.any(IslandConst.CANT_SWITCH_TO_MOVEMENT_STATES, function(arg_10_0)
			return var_9_2:IsName(arg_10_0)
		end) then
			return false
		end
	end

	return true
end

function var_0_0.UpdateMorphBtn(arg_11_0)
	if not arg_11_0.morphBtn then
		return
	end

	local var_11_0 = arg_11_0:CanShowMorphBtn()

	setActive(arg_11_0.morphBtn, var_11_0)

	if not var_11_0 then
		return
	end

	local var_11_1 = arg_11_0:IsPlayerIdleForMorph()
	local var_11_2 = arg_11_0.morphBtn:GetComponent(typeof(UnityEngine.UI.Button))

	if var_11_2 then
		var_11_2.interactable = var_11_1
	end

	local var_11_3 = arg_11_0.morphBtn:Find("icon_normal")
	local var_11_4 = arg_11_0.morphBtn:Find("icon_gray")

	if var_11_3 then
		setActive(var_11_3, var_11_1)
	end

	if var_11_4 then
		setActive(var_11_4, not var_11_1)
	end

	return
end

function var_0_0.StartMorphFreeze(arg_12_0)
	if arg_12_0.morphFreeze then
		return
	end

	arg_12_0.morphFreeze = true

	arg_12_0:NotifiyCore(ISLAND_EVT.DISABLE_INPUT)
	pg.UIMgr.GetInstance():LoadingOn(false)

	return
end

function var_0_0.StopMorphFreeze(arg_13_0)
	if not arg_13_0.morphFreeze then
		return
	end

	arg_13_0.morphFreeze = false

	pg.UIMgr.GetInstance():LoadingOff()
	arg_13_0:NotifiyCore(ISLAND_EVT.ENABLE_INPUT)

	return
end

function var_0_0.ResetMorphing(arg_14_0)
	arg_14_0.morphing = false
	arg_14_0.morphTargetBodyId = nil

	arg_14_0:StopMorphFreeze()
	arg_14_0:UpdateMorphBtn()

	return
end

function var_0_0.OnMorphBtnClick(arg_15_0)
	if not arg_15_0:CanShowMorphBtn() then
		return
	end

	if not arg_15_0:IsPlayerIdleForMorph() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_morph_not_idle"))

		return
	end

	local var_15_0, var_15_1 = arg_15_0:GetMorphBodyIds()

	if var_15_0 == 0 or var_15_1 == 0 then
		return
	end

	arg_15_0.morphing = true
	arg_15_0.morphTargetBodyId = var_15_1

	arg_15_0:StartMorphFreeze()
	arg_15_0:UpdateMorphBtn()
	pg.m02:sendNotification(GAME.ISLAND_MORPH_FORM_CHANGE, {
		fromBodyDressId = var_15_0,
		toBodyDressId = var_15_1,
		callback = function()
			arg_15_0:ResetMorphing()

			return
		end
	})

	return
end

function var_0_0.UpdateLureBtn(arg_17_0)
	local var_17_0 = arg_17_0:GetSelfIsland()
	local var_17_1 = var_17_0:GetFishingAgency():GetBaitId()
	local var_17_2 = var_17_0:GetInventoryAgency()
	local var_17_3 = var_17_2:GetOwnCount(var_17_1)

	setActive(arg_17_0.lureEmptyTr, var_17_3 <= 0)
	setActive(arg_17_0.lureIconTr, var_17_3 > 0)

	if var_17_3 > 0 then
		GetImageSpriteFromAtlasAsync("island/" .. var_17_2:GetItemById(var_17_1):GetIcon(), "", arg_17_0.lureIconTr)

		arg_17_0.lureIconTxt.text = ""
	end

	onButton(arg_17_0, arg_17_0.lureBtn, function()
		if #var_17_2:GetFishingItems() <= 0 then
			return
		end

		arg_17_0:CreateSubView(IslandSelectLureOpView):Execute("Show")

		return
	end, SFX_PANEL)

	return
end

function var_0_0.LaterInit(arg_19_0)
	if arg_19_0.showBalance < 1 then
		arg_19_0:DisablePlayerOp()
	end

	return
end

function var_0_0.UpdateAnimationOpBtn(arg_20_0)
	setActive(arg_20_0.animationOpBtn, getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(IslandAblityAgency.ANIMATION_OP_ID))

	return
end

function var_0_0.Update(arg_21_0)
	var_0_0.super.Update(arg_21_0)
	arg_21_0:UpdateMorphBtn()

	return
end

function var_0_0.UpdateAnimationOpEffect(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_2 then
		table.insert(arg_22_0.animationOpEffectCounter, arg_22_1)
	else
		table.removebyvalue(arg_22_0.animationOpEffectCounter, arg_22_1)
	end

	local var_22_0 = _.detect(_.map(arg_22_0.animationOpEffectCounter, function(arg_23_0)
		local var_23_0, var_23_1 = IslandCalcUtil.GetTypeAndIdByUniqueId(arg_23_0)

		return arg_22_0:GetView():GetUnitModuleWithType(var_23_0, var_23_1)
	end), function(arg_24_0)
		return arg_24_0 and isa(arg_24_0, IslandStrollNpcUnit) and arg_24_0.data:ExistGreetingActionFeedback()
	end)
	local var_22_1 = var_22_0 ~= nil
	local var_22_2 = var_22_0 ~= nil and var_22_0.data:OnlySkillActionFeedback()
	local var_22_3 = var_22_1 and var_22_0.data:ExistSkillActionFeedback()

	setActive(arg_22_0.animationOpSkillEffect, var_22_2)
	setActive(arg_22_0.animationOpEffect, var_22_1 and not var_22_2)
	setActive(arg_22_0.animationOpSkillTip, var_22_3)

	return
end

function var_0_0.UpdateFollowBtn(arg_25_0)
	if #getProxy(IslandProxy):GetIsland():GetFollowerAgency():GetFollowers() <= 0 or not arg_25_0:IsSelfIsland() then
		setActive(arg_25_0.followerBtn, false)

		return
	end

	setActive(arg_25_0.followerBtn, true)

	return
end

function var_0_0.ShowFollowerList(arg_26_0)
	local var_26_9000
	local var_26_0 = getProxy(IslandProxy)
	local var_26_1 = var_26_0.GetIsland(var_26_9000)
	local var_26_2 = var_26_1:GetFollowerAgency():GetFollowers()
	local var_26_3 = var_26_1:GetCharacterAgency()

	if #var_26_0 <= 0 then
		return
	end

	arg_26_0.uiFollowerList:make(function(arg_27_0, arg_27_1, arg_27_2)
		if arg_27_0 == UIItemList.EventUpdate then
			GetImageSpriteFromAtlasAsync("island/IslandShipIcon/" .. IslandShip.StaticGetPrefab(var_26_3:GetShipById(var_26_2[arg_27_1 + 1]).configId), "", arg_27_2:Find("icon"))
			onButton(arg_26_0, arg_27_2, function()
				arg_26_0:NotifiyCore(ISLAND_EVT.WILL_DEL_FOLLOWER, var_0.id)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_26_0.uiFollowerList:align(#var_26_1:GetFollowerAgency():GetFollowers())
	setActive(arg_26_0.uiFollowerPanel, true)
	arg_26_0:AddDisableFollowerListTimer()

	return
end

function var_0_0.AddDisableFollowerListTimer(arg_29_0)
	arg_29_0:RemoveFollowerListTimer()

	arg_29_0.followerTimer = Timer.New(function()
		arg_29_0:RemoveFollowerListTimer()
		setActive(arg_29_0.uiFollowerPanel, false)

		return
	end, 5, 1)

	arg_29_0.followerTimer:Start()

	return
end

function var_0_0.RemoveFollowerListTimer(arg_31_0)
	if arg_31_0.followerTimer then
		arg_31_0.followerTimer:Stop()

		arg_31_0.followerTimer = nil
	end

	return
end

function var_0_0.FlushFollowerList(arg_32_0)
	arg_32_0:UpdateFollowBtn()

	if not arg_32_0.followerTimer then
		return
	end

	arg_32_0:ShowFollowerList()

	return
end

function var_0_0.InitOpCustumPositon(arg_33_0)
	local var_33_0 = tf(GameObject.Find("UICamera/Canvas")).sizeDelta

	arg_33_0.moveBtn.anchoredPosition = Vector2(PlayerPrefs.GetFloat(IslandSettingsConst.ISLAND_KEY_JOYSTICK_ANCHORX, IslandSettingsConst.ISLAND_JOY_STICK_DEFAULT_PREFERENCE.x) * (var_33_0.x / IslandSettingsConst.settingRectSize.x), PlayerPrefs.GetFloat(IslandSettingsConst.ISLAND_KEY_JOYSTICK_ANCHORY, IslandSettingsConst.ISLAND_JOY_STICK_DEFAULT_PREFERENCE.y) * (var_33_0.y / IslandSettingsConst.settingRectSize.y))

	for iter_33_0, iter_33_1 in ipairs({
		arg_33_0.opBtn,
		arg_33_0.opPanel:Find("jump"),
		arg_33_0.areaChangeBtn,
		arg_33_0.seedBtn
	}) do
		iter_33_1.anchoredPosition = Vector2(PlayerPrefs.GetFloat(IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORX[iter_33_0], IslandSettingsConst.OPERATION_DEFAULT_PREFERENCE[iter_33_0].x) * (var_33_0.x / IslandSettingsConst.settingRectSize.x), PlayerPrefs.GetFloat(IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORY[iter_33_0], IslandSettingsConst.OPERATION_DEFAULT_PREFERENCE[iter_33_0].y) * (var_33_0.y / IslandSettingsConst.settingRectSize.y))
	end

	arg_33_0.lureBtn.anchoredPosition = arg_33_0.seedBtn.anchoredPosition

	return
end

function var_0_0.UpdateOperationButton(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_1 == var_0_0.OperationType.None then
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

function var_0_0.UpdateOperationButtonDisplay(arg_35_0)
	setActive(arg_35_0.lureBtn, false)

	function OptionBtnDisplay(arg_36_0)
		for iter_36_0, iter_36_1 in ipairs(arg_35_0.opBtnList) do
			setActive(iter_36_1, iter_36_0 == arg_36_0)
		end

		return
	end

	if arg_35_0.operationType == var_0_0.OperationType.None then
		setActive(arg_35_0.opBtn, false)
		setActive(arg_35_0.areaChangeBtn, false)
		setActive(arg_35_0.seedBtn, false)
		arg_35_0:GetView():GetSubView(IslandSeedOpView):ActiveSeedSelect(false)
		arg_35_0:GetView():GetSubView(IslandSeedOpView):ActiveSeedDetals(false)
		OptionBtnDisplay(arg_35_0.operationType)

		return
	end

	local var_35_0 = arg_35_0.view:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, arg_35_0.unitId)

	if arg_35_0.operationType ~= var_0_0.OperationType.Fishing and not var_35_0 then
		setActive(arg_35_0.opBtn, false)
		setActive(arg_35_0.areaChangeBtn, false)
		setActive(arg_35_0.seedBtn, false)
		arg_35_0:GetView():GetSubView(IslandSeedOpView):ActiveSeedSelect(false)
		arg_35_0:GetView():GetSubView(IslandSeedOpView):ActiveSeedDetals(false)

		return
	end

	setActive(arg_35_0.opBtn, true)

	local function var_35_1()
		OptionBtnDisplay(arg_35_0.operationType)
		onButton(arg_35_0, arg_35_0.opBtn, function()
			local var_38_0 = arg_35_0.view:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, arg_35_0.unitId)

			if var_38_0:CheckCanStartColloct() then
				arg_35_0.view:GetCore().controller.playerInputManager:UpdataWorkStateFunc(var_38_0:GetAnimatorTrigger(), var_38_0)
			end

			return
		end, SFX_PANEL)
		setActive(arg_35_0.areaChangeBtn, false)
		setActive(arg_35_0.seedBtn, false)

		return
	end

	switch(arg_35_0.operationType, {
		[var_0_0.OperationType.Plant] = function()
			local var_39_0 = arg_35_0.view:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, arg_35_0.unitId)
			local var_39_2

			if var_39_0:CanHarvest() then
				OptionBtnDisplay(var_0_0.OperationType.Harvest)
				onButton(arg_35_0, arg_35_0.opBtn, function()
					arg_35_0.view:GetCore().controller.playerInputManager:UpdataWorkStateFunc(IslandConst.GAHTER_FLAG, var_39_0)

					for iter_40_0, iter_40_1 in ipairs(arg_35_0.view.detectionSystem:GetAreaList()) do
						table.insert({}, arg_35_0.view:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, iter_40_1).handDate.configId)
					end

					pg.m02:sendNotification(GAME.ISLAND_START_HANDLE_HARVEST, {
						slot_list = {}
					})

					return
				end, SFX_PANEL)
				setActive(arg_35_0.seedBtn, false)
			elseif var_39_0:CanPlant() then
				IslandGuideChecker.CheckGuide("ISLAND_GUIDE_22")
				OptionBtnDisplay(var_0_0.OperationType.Plant)
				onButton(arg_35_0, arg_35_0.opBtn, function()
					if not arg_35_0:GetView():GetSubView(IslandSeedOpView).selectseedItemId then
						pg.TipsMgr.GetInstance():ShowTips(i18n("island_production_seeds_empty"))

						return
					end

					local var_41_0 = pg.island_farm_seed[arg_35_0:GetView():GetSubView(IslandSeedOpView).selectseedItemId]
					local var_41_1 = #arg_35_0.view.detectionSystem:GetAreaList()

					if not (function(arg_42_0)
						local var_42_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

						for iter_42_0, iter_42_1 in ipairs(arg_42_0) do
							local var_42_1 = var_42_0:GetItemById(iter_42_1[1])

							if var_42_1:GetCount() < iter_42_1[2] * var_41_1 then
								return false
							end

							return true
						end

						return
					end)(pg.island_formula[var_41_0.formulaid].cost) then
						pg.TipsMgr.GetInstance():ShowTips(i18n("island_production_seeds_notenough"))

						return
					end

					local var_41_2 = {}

					for iter_41_0, iter_41_1 in ipairs(arg_35_0.view.detectionSystem:GetAreaList()) do
						table.insert(var_41_2, arg_35_0.view:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, iter_41_1).handDate.configId)
					end

					pg.m02:sendNotification(GAME.ISLAND_START_HANDLE_PLANT, {
						slot_list = var_41_2,
						formula_id = var_41_0.formulaid
					})
					arg_35_0.view:GetCore().controller.playerInputManager:UpdataWorkStateFunc(IslandConst.SOW_FLAG, var_39_0)

					return
				end, SFX_PANEL)

				local var_39_1 = arg_35_0:GetView():GetSubView(IslandSeedOpView):CheckSeedEmpty(var_39_0)

				setActive(arg_35_0.seedEmpty, var_39_1)
				setActive(arg_35_0.seedBtn, true)
				setActive(arg_35_0.seedBtn:Find("seedItem"), not var_39_1)

				if not var_39_1 then
					onButton(arg_35_0, arg_35_0.seedBtn, function()
						arg_35_0:GetView():GetSubView(IslandSeedOpView):ActiveSeedSelect(true)
						arg_35_0:GetView():GetSubView(IslandSeedOpView):RefreshSeedPlane(var_39_0)

						return
					end, SFX_PANEL)
					arg_35_0:RefreshCurrentSlectSeed()
				end
			else
				OptionBtnDisplay(var_0_0.OperationType.Interaction)
				onButton(arg_35_0, arg_35_0.opBtn, function()
					pg.TipsMgr.GetInstance():ShowTips(i18n("island_production_being_planted"))

					return
				end, SFX_PANEL)
				setActive(arg_35_0.seedBtn, false)

				var_39_2 = setActive
			end

			local var_39_3 = pg.island_production_slot[var_39_0:GetDataVO().slotData.configId].place == IslandProductConst.FarmlandPlaceId and getProxy(IslandProxy):GetIsland():GetAblityAgency():IsUnlockAreaPlant()

			var_39_2(arg_35_0.areaChangeBtn, var_39_3)

			return
		end,
		[var_0_0.OperationType.MiningCollect] = function()
			var_35_1()

			return
		end,
		[var_0_0.OperationType.WildGather] = function()
			local var_46_0 = arg_35_0.view:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, arg_35_0.unitId)
			local var_46_1 = getProxy(IslandProxy)

			if arg_35_0.view:GetIsland().id == var_46_1:GetIsland().id then
				OptionBtnDisplay(var_0_0.OperationType.WildGather)
				onButton(arg_35_0, arg_35_0.opBtn, function()
					arg_35_0.view:GetCore().controller.playerInputManager:UpdataWorkStateFunc(IslandConst.GAHTERD_FLAG, var_46_0)
					var_46_0:StartGather(var_0.id)

					return
				end, SFX_PANEL)
			elseif var_46_0:CheckGatherCanSign() then
				OptionBtnDisplay(var_0_0.OperationType.WildGather)
				onButton(arg_35_0, arg_35_0.opBtn, function()
					var_46_0:StartGaherSign(var_0.id)

					return
				end, SFX_PANEL)
			else
				setActive(arg_35_0.opBtn, false)
			end

			return
		end,
		[var_0_0.OperationType.FellCollect] = function()
			var_35_1()

			return
		end,
		[var_0_0.OperationType.Fishing] = function()
			IslandGuideChecker.CheckGuide("ISLAND_GUIDE_33")
			arg_35_0:UpdateLureBtn()
			OptionBtnDisplay(arg_35_0.operationType)
			setActive(arg_35_0.lureBtn, true)
			onButton(arg_35_0, arg_35_0.opBtn, function()
				if arg_35_0:GetSelfIsland():GetInventoryAgency():GetOwnCount((arg_35_0:GetSelfIsland():GetFishingAgency():GetBaitId())) <= 0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("island_fishing_lure_empty"))
				else
					local var_51_0 = arg_35_0:GetView().player

					if var_51_0:OnGrouded() then
						arg_35_0:CreateSubView(IslandFishingOPView):Execute("Show", arg_35_0.unitId, arg_35_0.opBtn.localPosition)
					end
				end

				return
			end, SFX_PANEL)

			return
		end
	})

	return
end

function var_0_0.RefreshCurrentSlectSeed(arg_52_0)
	local var_52_9000
	local var_52_0 = arg_52_0.seedBtn:Find("seedItem")
	local var_52_1 = arg_52_0:GetView():GetSubView(IslandSeedOpView).selectseedItemId

	if not var_52_1 then
		setActive(var_52_0, false)

		return
	end

	setActive(var_52_0, true)

	local var_52_2 = getProxy(IslandProxy):GetIsland()
	local var_52_3 = var_52_2.GetInventoryAgency(var_52_9000):GetItemById(pg.island_farm_seed[var_52_1].itemid)

	if not var_52_2 then
		setActive(var_52_0, false)

		return
	end

	setText(var_52_0:Find("count"), var_52_3:GetCount())
	GetImageSpriteFromAtlasAsync("island/" .. var_52_3:GetIcon(), "", var_52_0:Find("icon"))

	return
end

function var_0_0.GetSeedBtnWorldPos(arg_53_0)
	return arg_53_0.seedBtn.position
end

function var_0_0.TryDisablePlayerOp(arg_54_0)
	arg_54_0.showBalance = arg_54_0.showBalance - 1

	if arg_54_0.showBalance == 0 then
		arg_54_0:DisablePlayerOp()
	end

	return
end

function var_0_0.TryEnablePlayerOp(arg_55_0)
	arg_55_0.showBalance = arg_55_0.showBalance + 1

	if arg_55_0.showBalance == 1 then
		arg_55_0:EnablePlayerOp()
	end

	return
end

function var_0_0.ResetShowBalance(arg_56_0)
	if arg_56_0.showBalance ~= 1 then
		arg_56_0.showBalance = 1

		arg_56_0:EnablePlayerOp()
	end

	return
end

function var_0_0.DisablePlayerOp(arg_57_0)
	arg_57_0:ShowOrHideGameObject(arg_57_0.opPanel, false)
	arg_57_0:ShowOrHideGameObject(arg_57_0.moveBtn, false)
	arg_57_0:GetView():GetSubView(IslandInteractionView):DisableInteraction()
	arg_57_0.playerInputManager:DisableInput()
	arg_57_0:GetView():GetSubView(IslandDistanceView):TryDisable()
	arg_57_0:GetView().player:ActiveOrDisactive(false)

	return
end

function var_0_0.EnablePlayerOp(arg_58_0)
	arg_58_0:ShowOrHideGameObject(arg_58_0.opPanel, true)
	arg_58_0:ShowOrHideGameObject(arg_58_0.moveBtn, true)
	arg_58_0:GetView():GetSubView(IslandInteractionView):EnableInteraction()
	arg_58_0.playerInputManager:EnableInput()
	arg_58_0:GetView():GetSubView(IslandDistanceView):TryEnable()
	arg_58_0:GetView().player:ActiveOrDisactive(true)

	if arg_58_0.inInteraction then
		arg_58_0:StartInteraction()
	end

	return
end

function var_0_0.StartInteraction(arg_59_0)
	arg_59_0.inInteraction = true

	arg_59_0:ShowOrHideGameObject(arg_59_0.moveBtn, false)
	arg_59_0:ShowOrHideGameObject(arg_59_0.opPanel, false)
	arg_59_0.playerInputManager:DisablePlayerHandle()
	arg_59_0:GetView().player:StopMoveHandle()

	return
end

function var_0_0.EndInteraction(arg_60_0)
	arg_60_0.inInteraction = false

	arg_60_0:ShowOrHideGameObject(arg_60_0.moveBtn, true)
	arg_60_0:ShowOrHideGameObject(arg_60_0.opPanel, true)
	arg_60_0.playerInputManager:EnablePlayerHandle()

	return
end

function var_0_0.DisableInput(arg_61_0)
	arg_61_0.playerInputManager:DisableInput()

	return
end

function var_0_0.EnableInput(arg_62_0)
	arg_62_0.playerInputManager:EnableInput()

	return
end

function var_0_0.ChangeTakePhotoModel(arg_63_0, arg_63_1, arg_63_2)
	if arg_63_1 == IslandConst.TakePhotoModel.None then
		if not arg_63_2 then
			arg_63_0:ShowOrHideMoveBtn(false)
			arg_63_0.playerInputManager:DisableInput()
			arg_63_0:GetView().player:ActiveOrDisactive(false)
		end
	elseif arg_63_1 == IslandConst.TakePhotoModel.First then
		arg_63_0:ShowOrHideMoveBtn(true)
		arg_63_0.playerInputManager:EnableInput()
		arg_63_0:GetView().player:ActiveOrDisactive(true)
	else
		arg_63_0:ShowOrHideMoveBtn(true)
		arg_63_0.playerInputManager:EnableInput()
		arg_63_0:GetView().player:ActiveOrDisactive(true)
	end

	return
end

function var_0_0.ShowOrHideMoveBtn(arg_64_0, arg_64_1, arg_64_2)
	local var_64_0 = GetOrAddComponent(arg_64_0.moveBtn, typeof(CanvasGroup))

	var_64_0.alpha = arg_64_1 and 1 or 0
	var_64_0.blocksRaycasts = arg_64_1 or arg_64_2

	return
end

function var_0_0.OnDestroy(arg_65_0)
	arg_65_0:StopMorphFreeze()

	if arg_65_0.opUI then
		arg_65_0:GetPoolMgr():ReturnOpUI(arg_65_0.opUI.gameObject)

		arg_65_0.opUI = nil
	end

	arg_65_0:RemoveFollowerListTimer()

	arg_65_0.animationOpEffectCounter = {}

	return
end

return var_0_0
