local IslandOpView = class("IslandOpView", import(".IslandBaseOpView"))

IslandOpView.OperationType = {
	Plant = 2,
	MiningCollect = 3,
	FellCollect = 6,
	Fishing = 7,
	Harvest = 4,
	Interaction = 1,
	WildGather = 5,
	None = 0
}

function IslandOpView:GetUIName()
	return "IslandEmptyUI"
end

function IslandOpView:OnInit(arg_2_1)
	self.opUI = self:GetPoolMgr():GetOpUI().transform

	setParent(self.opUI, arg_2_1)

	local var_2_0 = self:GetView():GetCacheOpCount()

	var_2_0 = var_2_0 or 1
	self.showBalance = var_2_0
	self.inputController = IslandCameraMgr.instance.gameObject:GetComponent(typeof(InputController))
	self._go = arg_2_1
	self._tf = arg_2_1.transform
	self.opPanel = self.opUI:Find("op_btns")
	self.opBtn = self.opPanel:Find("op_btn")
	self.opBtnList = {
		self.opBtn:Find("interaction"),
		self.opBtn:Find("plant"),
		self.opBtn:Find("miningCollect"),
		self.opBtn:Find("harvest"),
		self.opBtn:Find("wildgather"),
		self.opBtn:Find("fellCollect"),
		self.opBtn:Find("fishing")
	}
	self.morphBtn = self.opPanel:Find("morph")
	self.seedBtn = self.opPanel:Find("seed")
	self.seedEmpty = self.seedBtn:Find("seedEmpty")
	self.areaChangeBtn = self.opPanel:Find("scope")
	self.run = self.opPanel:Find("run")
	self.moveBtn = self.opUI:Find("move")
	self.animationOpBtn = self.opPanel:Find("aniamtionop")
	self.animationOpEffect = self.animationOpBtn:Find("effect")
	self.animationOpSkillTip = self.animationOpBtn:Find("tip")
	self.animationOpSkillEffect = self.animationOpBtn:Find("effect_skill")
	self.followerBtn = self.opPanel:Find("follower")
	self.lureBtn = self.opPanel:Find("lure")
	self.lureEmptyTr = self.lureBtn:Find("empty")
	self.lureIconTr = self.lureBtn:Find("icon")
	self.lureIconTxt = self.lureBtn:Find("icon/count"):GetComponent(typeof(Text))
	self.animationOpEffectCounter = {}
	self.morphing = false
	self.uiFollowerPanel = self.followerBtn:Find("list")
	self.uiFollowerList = UIItemList.New(self.uiFollowerPanel, (self.uiFollowerPanel:Find("tpl")))

	setActive(self.opPanel, true)
	setActive(self.lureBtn, false)
	onButton(self, self.areaChangeBtn, function()
		self:NotifiyCore(ISLAND_EVT.AREACHANGE)

		return
	end, SFX_PANEL)
	onButton(self, self.morphBtn, function()
		self:OnMorphBtnClick()

		return
	end, SFX_PANEL)
	onButton(self, self.animationOpBtn, function()
		self:NotifiyCore(ISLAND_EVT.OPEN_ANIMATION_OP)

		return
	end, SFX_PANEL)
	onButton(self, self.followerBtn, function()
		if isActive(self.uiFollowerPanel) then
			self:RemoveFollowerListTimer()
			setActive(self.uiFollowerPanel, false)
		else
			self:ShowFollowerList()
		end

		return
	end, SFX_PANEL)

	self.operationType = IslandOpView.OperationType.None

	self:UpdateOperationButtonDisplay()

	self.playerInputManager = self.view:GetController().playerInputManager

	self:InitOpCustumPositon()
	self:UpdateFollowBtn()
	self:UpdateAnimationOpBtn()
	self:UpdateLureBtn()
	self:UpdateMorphBtn()

	return
end

function IslandOpView:GetMorphBodyIds()
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

function IslandOpView:CanShowMorphBtn()
	local var_8_0, var_8_1 = self:GetMorphBodyIds()

	return self:IsSelfIsland() and var_8_1 ~= 0
end

function IslandOpView:IsPlayerIdleForMorph()
	local var_9_0 = self:GetView().player

	if not var_9_0 then
		return false
	end

	if self.morphing then
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

function IslandOpView:UpdateMorphBtn()
	if not self.morphBtn then
		return
	end

	local var_11_0 = self:CanShowMorphBtn()

	setActive(self.morphBtn, var_11_0)

	if not var_11_0 then
		return
	end

	local var_11_1 = self:IsPlayerIdleForMorph()
	local var_11_2 = self.morphBtn:GetComponent(typeof(UnityEngine.UI.Button))

	if var_11_2 then
		var_11_2.interactable = var_11_1
	end

	local var_11_3 = self.morphBtn:Find("icon_normal")
	local var_11_4 = self.morphBtn:Find("icon_gray")

	if var_11_3 then
		setActive(var_11_3, var_11_1)
	end

	if var_11_4 then
		setActive(var_11_4, not var_11_1)
	end

	return
end

function IslandOpView:StartMorphFreeze()
	if self.morphFreeze then
		return
	end

	self.morphFreeze = true

	self:NotifiyCore(ISLAND_EVT.DISABLE_INPUT)
	pg.UIMgr.GetInstance():LoadingOn(false)

	return
end

function IslandOpView:StopMorphFreeze()
	if not self.morphFreeze then
		return
	end

	self.morphFreeze = false

	pg.UIMgr.GetInstance():LoadingOff()
	self:NotifiyCore(ISLAND_EVT.ENABLE_INPUT)

	return
end

function IslandOpView:ResetMorphing()
	self.morphing = false
	self.morphTargetBodyId = nil

	self:StopMorphFreeze()
	self:UpdateMorphBtn()

	return
end

function IslandOpView:OnMorphBtnClick()
	if not self:CanShowMorphBtn() then
		return
	end

	if not self:IsPlayerIdleForMorph() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_morph_not_idle"))

		return
	end

	local var_15_0, var_15_1 = self:GetMorphBodyIds()

	if var_15_0 == 0 or var_15_1 == 0 then
		return
	end

	self.morphing = true
	self.morphTargetBodyId = var_15_1

	self:StartMorphFreeze()
	self:UpdateMorphBtn()
	pg.m02:sendNotification(GAME.ISLAND_MORPH_FORM_CHANGE, {
		fromBodyDressId = var_15_0,
		toBodyDressId = var_15_1,
		callback = function()
			self:ResetMorphing()

			return
		end
	})

	return
end

function IslandOpView:UpdateLureBtn()
	local var_17_0 = self:GetSelfIsland()
	local var_17_1 = var_17_0:GetFishingAgency():GetBaitId()
	local var_17_2 = var_17_0:GetInventoryAgency()
	local var_17_3 = var_17_2:GetOwnCount(var_17_1)

	setActive(self.lureEmptyTr, var_17_3 <= 0)
	setActive(self.lureIconTr, var_17_3 > 0)

	if var_17_3 > 0 then
		GetImageSpriteFromAtlasAsync("island/" .. var_17_2:GetItemById(var_17_1):GetIcon(), "", self.lureIconTr)

		self.lureIconTxt.text = ""
	end

	onButton(self, self.lureBtn, function()
		if #var_17_2:GetFishingItems() <= 0 then
			return
		end

		self:CreateSubView(IslandSelectLureOpView):Execute("Show")

		return
	end, SFX_PANEL)

	return
end

function IslandOpView:LaterInit()
	if self.showBalance < 1 then
		self:DisablePlayerOp()
	end

	return
end

function IslandOpView:UpdateAnimationOpBtn()
	setActive(self.animationOpBtn, getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(IslandAblityAgency.ANIMATION_OP_ID))

	return
end

function IslandOpView:Update()
	IslandOpView.super.Update(self)
	self:UpdateMorphBtn()

	return
end

function IslandOpView:UpdateAnimationOpEffect(arg_22_1, arg_22_2)
	if arg_22_2 then
		table.insert(self.animationOpEffectCounter, arg_22_1)
	else
		table.removebyvalue(self.animationOpEffectCounter, arg_22_1)
	end

	local var_22_0 = _.detect(_.map(self.animationOpEffectCounter, function(arg_23_0)
		local var_23_0, var_23_1 = IslandCalcUtil.GetTypeAndIdByUniqueId(arg_23_0)

		return self:GetView():GetUnitModuleWithType(var_23_0, var_23_1)
	end), function(arg_24_0)
		return arg_24_0 and isa(arg_24_0, IslandStrollNpcUnit) and arg_24_0.data:ExistGreetingActionFeedback()
	end)
	local var_22_1 = var_22_0 ~= nil
	local var_22_2 = var_22_0 ~= nil and var_22_0.data:OnlySkillActionFeedback()
	local var_22_3 = var_22_1 and var_22_0.data:ExistSkillActionFeedback()

	setActive(self.animationOpSkillEffect, var_22_2)
	setActive(self.animationOpEffect, var_22_1 and not var_22_2)
	setActive(self.animationOpSkillTip, var_22_3)

	return
end

function IslandOpView:UpdateFollowBtn()
	if #getProxy(IslandProxy):GetIsland():GetFollowerAgency():GetFollowers() <= 0 or not self:IsSelfIsland() then
		setActive(self.followerBtn, false)

		return
	end

	setActive(self.followerBtn, true)

	return
end

function IslandOpView:ShowFollowerList()
	local var_26_0 = getProxy(IslandProxy)
	local var_26_1 = var_26_0:GetIsland()
	local var_26_2 = var_26_1:GetFollowerAgency():GetFollowers()
	local var_26_3 = var_26_1:GetCharacterAgency()

	if #var_26_0 <= 0 then
		return
	end

	self.uiFollowerList:make(function(arg_27_0, arg_27_1, arg_27_2)
		if arg_27_0 == UIItemList.EventUpdate then
			local var_27_0 = var_26_3:GetShipById(var_26_2[arg_27_1 + 1])

			GetImageSpriteFromAtlasAsync("island/IslandShipIcon/" .. IslandShip.StaticGetPrefab(var_27_0.configId), "", arg_27_2:Find("icon"))
			onButton(self, arg_27_2, function()
				self:NotifiyCore(ISLAND_EVT.WILL_DEL_FOLLOWER, var_27_0.id)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.uiFollowerList:align(#var_26_2)
	setActive(self.uiFollowerPanel, true)
	self:AddDisableFollowerListTimer()

	return
end

function IslandOpView:AddDisableFollowerListTimer()
	self:RemoveFollowerListTimer()

	self.followerTimer = Timer.New(function()
		self:RemoveFollowerListTimer()
		setActive(self.uiFollowerPanel, false)

		return
	end, 5, 1)

	self.followerTimer:Start()

	return
end

function IslandOpView:RemoveFollowerListTimer()
	if self.followerTimer then
		self.followerTimer:Stop()

		self.followerTimer = nil
	end

	return
end

function IslandOpView:FlushFollowerList()
	self:UpdateFollowBtn()

	if not self.followerTimer then
		return
	end

	self:ShowFollowerList()

	return
end

function IslandOpView:InitOpCustumPositon()
	local var_33_0 = tf(GameObject.Find("UICamera/Canvas")).sizeDelta

	self.moveBtn.anchoredPosition = Vector2(PlayerPrefs.GetFloat(IslandSettingsConst.ISLAND_KEY_JOYSTICK_ANCHORX, IslandSettingsConst.ISLAND_JOY_STICK_DEFAULT_PREFERENCE.x) * (var_33_0.x / IslandSettingsConst.settingRectSize.x), PlayerPrefs.GetFloat(IslandSettingsConst.ISLAND_KEY_JOYSTICK_ANCHORY, IslandSettingsConst.ISLAND_JOY_STICK_DEFAULT_PREFERENCE.y) * (var_33_0.y / IslandSettingsConst.settingRectSize.y))

	for iter_33_0, iter_33_1 in ipairs({
		self.opBtn,
		self.opPanel:Find("jump"),
		self.areaChangeBtn,
		self.seedBtn
	}) do
		iter_33_1.anchoredPosition = Vector2(PlayerPrefs.GetFloat(IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORX[iter_33_0], IslandSettingsConst.OPERATION_DEFAULT_PREFERENCE[iter_33_0].x) * (var_33_0.x / IslandSettingsConst.settingRectSize.x), PlayerPrefs.GetFloat(IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORY[iter_33_0], IslandSettingsConst.OPERATION_DEFAULT_PREFERENCE[iter_33_0].y) * (var_33_0.y / IslandSettingsConst.settingRectSize.y))
	end

	self.lureBtn.anchoredPosition = self.seedBtn.anchoredPosition

	return
end

function IslandOpView:UpdateOperationButton(arg_34_1, arg_34_2)
	if arg_34_1 == IslandOpView.OperationType.None then
		if self.unitId == arg_34_2 then
			self.unitId = nil
			self.operationType = arg_34_1
		end
	else
		self.unitId = arg_34_2
		self.operationType = arg_34_1
	end

	self:UpdateOperationButtonDisplay()

	return
end

function IslandOpView:UpdateOperationButtonDisplay()
	setActive(self.lureBtn, false)

	function OptionBtnDisplay(arg_36_0)
		for iter_36_0, iter_36_1 in ipairs(self.opBtnList) do
			setActive(iter_36_1, iter_36_0 == arg_36_0)
		end

		return
	end

	if self.operationType == IslandOpView.OperationType.None then
		setActive(self.opBtn, false)
		setActive(self.areaChangeBtn, false)
		setActive(self.seedBtn, false)
		self:GetView():GetSubView(IslandSeedOpView):ActiveSeedSelect(false)
		self:GetView():GetSubView(IslandSeedOpView):ActiveSeedDetals(false)
		OptionBtnDisplay(self.operationType)

		return
	end

	if self.operationType ~= IslandOpView.OperationType.Fishing and not self.view:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, self.unitId) then
		setActive(self.opBtn, false)
		setActive(self.areaChangeBtn, false)
		setActive(self.seedBtn, false)
		self:GetView():GetSubView(IslandSeedOpView):ActiveSeedSelect(false)
		self:GetView():GetSubView(IslandSeedOpView):ActiveSeedDetals(false)

		return
	end

	setActive(self.opBtn, true)

	local function var_35_0()
		OptionBtnDisplay(self.operationType)
		onButton(self, self.opBtn, function()
			local var_38_0 = self.view:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, self.unitId)

			if var_38_0:CheckCanStartColloct() then
				self.view:GetCore().controller.playerInputManager:UpdataWorkStateFunc(var_38_0:GetAnimatorTrigger(), var_38_0)
			end

			return
		end, SFX_PANEL)
		setActive(self.areaChangeBtn, false)
		setActive(self.seedBtn, false)

		return
	end

	switch(self.operationType, {
		[IslandOpView.OperationType.Plant] = function()
			local var_39_0 = self.view:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, self.unitId)

			if var_39_0:CanHarvest() then
				OptionBtnDisplay(IslandOpView.OperationType.Harvest)
				onButton(self, self.opBtn, function()
					self.view:GetCore().controller.playerInputManager:UpdataWorkStateFunc(IslandConst.GAHTER_FLAG, var_39_0)

					local var_40_0 = {}

					for iter_40_0, iter_40_1 in ipairs(self.view.detectionSystem:GetAreaList()) do
						table.insert(var_40_0, self.view:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, iter_40_1).handDate.configId)
					end

					pg.m02:sendNotification(GAME.ISLAND_START_HANDLE_HARVEST, {
						slot_list = var_40_0
					})

					return
				end, SFX_PANEL)
				setActive(self.seedBtn, false)
			else
				if var_39_0:CanPlant() then
					IslandGuideChecker.CheckGuide("ISLAND_GUIDE_22")
					OptionBtnDisplay(IslandOpView.OperationType.Plant)
					onButton(self, self.opBtn, function()
						if not self:GetView():GetSubView(IslandSeedOpView).selectseedItemId then
							pg.TipsMgr.GetInstance():ShowTips(i18n("island_production_seeds_empty"))

							return
						end

						local var_41_0 = pg.island_farm_seed[self:GetView():GetSubView(IslandSeedOpView).selectseedItemId]
						local var_41_1 = #self.view.detectionSystem:GetAreaList()

						if not (function(arg_42_0)
							local var_42_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

							for iter_42_0, iter_42_1 in ipairs(arg_42_0) do
								if var_42_0:GetItemById(iter_42_1[1]):GetCount() < iter_42_1[2] * var_41_1 then
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

						for iter_41_0, iter_41_1 in ipairs(self.view.detectionSystem:GetAreaList()) do
							table.insert(var_41_2, self.view:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, iter_41_1).handDate.configId)
						end

						pg.m02:sendNotification(GAME.ISLAND_START_HANDLE_PLANT, {
							slot_list = var_41_2,
							formula_id = var_41_0.formulaid
						})
						self.view:GetCore().controller.playerInputManager:UpdataWorkStateFunc(IslandConst.SOW_FLAG, var_39_0)

						return
					end, SFX_PANEL)

					local var_39_1 = self:GetView():GetSubView(IslandSeedOpView):CheckSeedEmpty(var_39_0)

					setActive(self.seedEmpty, var_39_1)
					setActive(self.seedBtn, true)
					setActive(self.seedBtn:Find("seedItem"), not var_39_1)

					if not var_39_1 then
						onButton(self, self.seedBtn, function()
							self:GetView():GetSubView(IslandSeedOpView):ActiveSeedSelect(true)
							self:GetView():GetSubView(IslandSeedOpView):RefreshSeedPlane(var_39_0)

							return
						end, SFX_PANEL)
						self:RefreshCurrentSlectSeed()
					end
				end

				local var_39_2

				do
					OptionBtnDisplay(IslandOpView.OperationType.Interaction)
					onButton(self, self.opBtn, function()
						pg.TipsMgr.GetInstance():ShowTips(i18n("island_production_being_planted"))

						return
					end, SFX_PANEL)
					setActive(self.seedBtn, false)

					var_39_2 = setActive
				end
			end

			var_39_2(self.areaChangeBtn, pg.island_production_slot[var_39_0:GetDataVO().slotData.configId].place == IslandProductConst.FarmlandPlaceId and getProxy(IslandProxy):GetIsland():GetAblityAgency():IsUnlockAreaPlant())

			return
		end,
		[IslandOpView.OperationType.MiningCollect] = function()
			var_35_0()

			return
		end,
		[IslandOpView.OperationType.WildGather] = function()
			local var_46_0 = self.view:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, self.unitId)
			local var_46_1 = self.view:GetIsland()

			if var_46_1.id == getProxy(IslandProxy):GetIsland().id then
				OptionBtnDisplay(IslandOpView.OperationType.WildGather)
				onButton(self, self.opBtn, function()
					self.view:GetCore().controller.playerInputManager:UpdataWorkStateFunc(IslandConst.GAHTERD_FLAG, var_46_0)
					var_46_0:StartGather(var_46_1.id)

					return
				end, SFX_PANEL)
			elseif var_46_0:CheckGatherCanSign() then
				OptionBtnDisplay(IslandOpView.OperationType.WildGather)
				onButton(self, self.opBtn, function()
					var_46_0:StartGaherSign(var_46_1.id)

					return
				end, SFX_PANEL)
			else
				setActive(self.opBtn, false)
			end

			return
		end,
		[IslandOpView.OperationType.FellCollect] = function()
			var_35_0()

			return
		end,
		[IslandOpView.OperationType.Fishing] = function()
			IslandGuideChecker.CheckGuide("ISLAND_GUIDE_33")
			self:UpdateLureBtn()
			OptionBtnDisplay(self.operationType)
			setActive(self.lureBtn, true)
			onButton(self, self.opBtn, function()
				if self:GetSelfIsland():GetInventoryAgency():GetOwnCount((self:GetSelfIsland():GetFishingAgency():GetBaitId())) <= 0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("island_fishing_lure_empty"))
				elseif self:GetView().player:OnGrouded() then
					self:CreateSubView(IslandFishingOPView):Execute("Show", self.unitId, self.opBtn.localPosition)
				end

				return
			end, SFX_PANEL)

			return
		end
	})

	return
end

function IslandOpView:RefreshCurrentSlectSeed()
	local var_52_0 = self.seedBtn:Find("seedItem")
	local var_52_1 = self:GetView():GetSubView(IslandSeedOpView).selectseedItemId

	if not var_52_1 then
		setActive(var_52_0, false)

		return
	end

	setActive(var_52_0, true)

	local var_52_2 = getProxy(IslandProxy):GetIsland()
	local var_52_3 = var_52_2:GetInventoryAgency():GetItemById(pg.island_farm_seed[var_52_1].itemid)

	if not var_52_2 then
		setActive(var_52_0, false)

		return
	end

	setText(var_52_0:Find("count"), var_52_3:GetCount())
	GetImageSpriteFromAtlasAsync("island/" .. var_52_3:GetIcon(), "", var_52_0:Find("icon"))

	return
end

function IslandOpView:GetSeedBtnWorldPos()
	return self.seedBtn.position
end

function IslandOpView:TryDisablePlayerOp()
	self.showBalance = self.showBalance - 1

	if self.showBalance == 0 then
		self:DisablePlayerOp()
	end

	return
end

function IslandOpView:TryEnablePlayerOp()
	self.showBalance = self.showBalance + 1

	if self.showBalance == 1 then
		self:EnablePlayerOp()
	end

	return
end

function IslandOpView:ResetShowBalance()
	if self.showBalance ~= 1 then
		self.showBalance = 1

		self:EnablePlayerOp()
	end

	return
end

function IslandOpView:DisablePlayerOp()
	self:ShowOrHideGameObject(self.opPanel, false)
	self:ShowOrHideGameObject(self.moveBtn, false)
	self:GetView():GetSubView(IslandInteractionView):DisableInteraction()
	self.playerInputManager:DisableInput()
	self:GetView():GetSubView(IslandDistanceView):TryDisable()
	self:GetView().player:ActiveOrDisactive(false)

	return
end

function IslandOpView:EnablePlayerOp()
	self:ShowOrHideGameObject(self.opPanel, true)
	self:ShowOrHideGameObject(self.moveBtn, true)
	self:GetView():GetSubView(IslandInteractionView):EnableInteraction()
	self.playerInputManager:EnableInput()
	self:GetView():GetSubView(IslandDistanceView):TryEnable()
	self:GetView().player:ActiveOrDisactive(true)

	if self.inInteraction then
		self:StartInteraction()
	end

	return
end

function IslandOpView:StartInteraction()
	self.inInteraction = true

	self:ShowOrHideGameObject(self.moveBtn, false)
	self:ShowOrHideGameObject(self.opPanel, false)
	self.playerInputManager:DisablePlayerHandle()
	self:GetView().player:StopMoveHandle()

	return
end

function IslandOpView:EndInteraction()
	self.inInteraction = false

	self:ShowOrHideGameObject(self.moveBtn, true)
	self:ShowOrHideGameObject(self.opPanel, true)
	self.playerInputManager:EnablePlayerHandle()

	return
end

function IslandOpView:DisableInput()
	self.playerInputManager:DisableInput()

	return
end

function IslandOpView:EnableInput()
	self.playerInputManager:EnableInput()

	return
end

function IslandOpView:ChangeTakePhotoModel(arg_63_1, arg_63_2)
	if arg_63_1 == IslandConst.TakePhotoModel.None then
		if not arg_63_2 then
			self:ShowOrHideMoveBtn(false)
			self.playerInputManager:DisableInput()
			self:GetView().player:ActiveOrDisactive(false)
		end
	elseif arg_63_1 == IslandConst.TakePhotoModel.First then
		self:ShowOrHideMoveBtn(true)
		self.playerInputManager:EnableInput()
		self:GetView().player:ActiveOrDisactive(true)
	else
		self:ShowOrHideMoveBtn(true)
		self.playerInputManager:EnableInput()
		self:GetView().player:ActiveOrDisactive(true)
	end

	return
end

function IslandOpView:ShowOrHideMoveBtn(arg_64_1, arg_64_2)
	local var_64_0 = GetOrAddComponent(self.moveBtn, typeof(CanvasGroup))

	var_64_0.alpha = arg_64_1 and 1 or 0
	var_64_0.blocksRaycasts = arg_64_1 or arg_64_2

	return
end

function IslandOpView:OnDestroy()
	self:StopMorphFreeze()

	if self.opUI then
		self:GetPoolMgr():ReturnOpUI(self.opUI.gameObject)

		self.opUI = nil
	end

	self:RemoveFollowerListTimer()

	self.animationOpEffectCounter = {}

	return
end

return IslandOpView
