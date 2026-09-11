local MythicNewView = class("MythicNewView", ReduxView)

function MythicNewView:UIName()
	return "Widget/System/Challenge_Mythic/MythicUI"
end

function MythicNewView:UIParent()
	return manager.ui.uiMain.transform
end

function MythicNewView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MythicNewView:InitUI()
	self:BindCfgUI()

	self._affixHero = {}
	self._affixMonster = {}
	self.isStarController = ControllerUtil.GetController(self.transform_, "isStar")
	self.stageControllers = {}
	self.selectControllers = {}

	for iter_4_0 = 1, 3 do
		self.stageControllers[iter_4_0] = ControllerUtil.GetController(self["m_stage" .. iter_4_0].transform, "stage")
		self.selectControllers[iter_4_0] = ControllerUtil.GetController(self["m_stage" .. iter_4_0].transform, "select")
	end

	self.mainController = ControllerUtil.GetController(self.m_stageMain.transform, "stage")
	self.mainSelectController = ControllerUtil.GetController(self.m_stageMain.transform, "select")
	self.heroAffixController = ControllerUtil.GetController(self.m_heroAffixController, "affix")
	self.mosterAffixController = ControllerUtil.GetController(self.m_mosterAffixController, "affix")
end

function MythicNewView:AddUIListener()
	self:AddBtnListener(self.m_shopBtn, nil, function()
		self:CloseSectionInfo()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.BLACK_AREA
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.m_refreshBtn, nil, function()
		self:CloseSectionInfo()
		JumpTools.OpenPageByJump("popCostItem", {
			costCount = 1,
			costId = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
			content = string.format(GetTips("MYTHIC_REFRESH_CHECK"), GetI18NText(ItemCfg[MaterialConst.MYTHIC_REFRESH_ITEM_ID].name), 1),
			itemId = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
			popCostCallBack = handler(self, self.PopCostCallBack)
		})
	end)
	self:AddBtnListener(self.m_stageMain, nil, function()
		local var_8_0 = MythicData:GetDifficultyData(self.difficulty)

		if var_8_0 then
			self:OpenSectionInfoView(var_8_0.main_partition, true, 0)
		end
	end)
	self:AddBtnListener(self.m_stageMain_ball, nil, function()
		local var_9_0 = MythicData:GetDifficultyData(self.difficulty)

		if var_9_0 then
			self:OpenSectionInfoView(var_9_0.main_partition, true, 0)
		end
	end)

	for iter_5_0 = 1, 3 do
		if self["m_stage" .. iter_5_0] then
			self:AddBtnListener(self["m_stage" .. iter_5_0], nil, function()
				local var_10_0 = MythicData:GetDifficultyData(self.difficulty)

				if var_10_0 and var_10_0.sub_partition_list[iter_5_0] then
					self:OpenSectionInfoView(var_10_0.sub_partition_list[iter_5_0], false, iter_5_0)
				end
			end)
		end
	end

	self:AddBtnListener(self.m_difficultyBtn, nil, function()
		self:CloseSectionInfo()

		if MythicData:GetStarRewardCount() == 0 then
			JumpTools.OpenPageByJump("mythicDifficulty")
		end
	end)
	self:AddBtnListener(self.m_rewardBtn, nil, function()
		self:CloseSectionInfo()
		JumpTools.OpenPageByJump("mythicSectionReward", {
			difficulty = self.difficulty
		})
	end)
	self:AddBtnListener(self.m_btnMask, nil, function()
		self:CloseSectionInfo()
	end)
end

function MythicNewView:PopCostCallBack()
	if MythicData:GetStarCount() == 0 then
		ShowMessageBox({
			content = GetTips("ERROR_MYTHIC_REFRESH"),
			OkCallback = function()
				CommonAction.TryToUseItem({
					{
						item_info = {
							num = 1,
							id = MaterialConst.MYTHIC_REFRESH_ITEM_ID
						},
						use_list = {}
					}
				})
			end
		})
	else
		for iter_14_0 = 1, MythicData:GetStarCount() do
			if not MythicData:GetStarRewardState(iter_14_0) then
				ShowTips("ERROR_BATTLE_MYTHIC_REWARD_NO_RECEIVED")

				return
			end
		end

		CommonAction.TryToUseItem({
			{
				item_info = {
					num = 1,
					id = MaterialConst.MYTHIC_REFRESH_ITEM_ID
				},
				use_list = {}
			}
		})
	end
end

function MythicNewView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("MYTHIC_DESCRIPE")
	manager.windowBar:RegistBackCallBack(function()
		if self:IsOpenRoute("mythicSectionInfo") then
			self:CloseSectionInfo()
		else
			JumpTools.Back()
		end
	end)
	self:CheckDifficultyChange()

	if not self:IsOpenRoute("mythicSectionInfo") then
		self:OnMyticContentShow(false)
	end

	self:RefreshUI()
end

function MythicNewView:OnEnter()
	self:RegistEventListener(MATERIAL_MODIFY, handler(self, self.RefreshMaterial))
	manager.redPoint:bindUIandKey(self.m_rewardBtn.transform, RedPointConst.MYTHIC_TIMES_AWARD)

	self.cdText_.text = string.format(GetTips("TIME_DISPLAY_9"), "" .. manager.time:GetLostTimeStrWith2Unit((MythicData:GetNextRefreshTime())))
	self.updateTimer_ = Timer.New(function()
		self.cdText_.text = string.format(GetTips("TIME_DISPLAY_9"), "" .. manager.time:GetLostTimeStrWith2Unit((MythicData:GetNextRefreshTime())))
	end, 1, -1)

	self.updateTimer_:Start()
	self:RefreshUI()
end

function MythicNewView:OnExit()
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(self.m_rewardBtn.transform, RedPointConst.MYTHIC_TIMES_AWARD)
	self:HideAffixInfo()

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end
end

function MythicNewView:CheckDifficultyChange()
	if MythicData:GetIsNewDifficulty() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MYTHIC_NEW_LEVEL_UNLOCK"),
			OkCallback = function()
				MythicAction:QueryMythicRead()
				self:CheckMail()
			end
		})
	else
		self:CheckMail()
	end
end

function MythicNewView:CheckMail()
	if PlayerData:GetUnclaimed(3) ~= nil then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("UNCLAIMED_BONUS_MAIL_TIP"),
			OkCallback = function()
				PlayerAction.ReadUnclaimedMessage(3)

				if MythicData:IsShowDifficultySelectView() then
					TimeTools.StartAfterSeconds(0.033, function()
						JumpTools.OpenPageByJump("mythicDifficulty")
					end, {})
				end
			end
		})
	elseif MythicData:IsShowDifficultySelectView() then
		TimeTools.StartAfterSeconds(0.033, function()
			JumpTools.OpenPageByJump("mythicDifficulty")
		end, {})
	end
end

function MythicNewView:RefreshUI(arg_27_1)
	self.curDifficulty = MythicData:GetDifficulty()
	self.difficulty = self.curDifficulty

	self:RefreshMaterial()

	if self.difficulty == 0 then
		return
	end

	if MythicData:GetStarRewardCount() == 0 then
		self.isStarController:SetSelectedIndex(0)
	else
		self.isStarController:SetSelectedIndex(1)
	end

	self.m_romamLab.text = NumberTools.IntToRomam(self.difficulty)

	self:RefreshAffixItems(MythicData:GetAllHeroAffix(), true, self._affixHeroParent, self._affixHero, self.heroAffixController)
	self:RefreshAffixItems(MythicData:GetMonsterAffix(), false, self._affixMonsterParent, self._affixMonster, self.mosterAffixController)

	local var_27_0 = MythicData:GetDifficultyData(self.difficulty)

	if var_27_0 then
		if MythicData:GetIsFirstClear(var_27_0.main_partition.partition) then
			self.mainController:SetSelectedIndex(0)
		else
			self.mainController:SetSelectedIndex(1)
		end

		for iter_27_0 = 1, 3 do
			if self.stageControllers[iter_27_0] and var_27_0 and var_27_0.sub_partition_list[iter_27_0] then
				if MythicData:GetIsFirstClear(var_27_0.sub_partition_list[iter_27_0].partition) then
					self.stageControllers[iter_27_0]:SetSelectedIndex(0)
				else
					self.stageControllers[iter_27_0]:SetSelectedIndex(1)
				end
			end
		end
	end

	if not self:IsOpenRoute("mythicSectionInfo") then
		for iter_27_1, iter_27_2 in ipairs(self.selectControllers) do
			iter_27_2:SetSelectedIndex(0)
		end

		self.mainSelectController:SetSelectedIndex(0)
	end
end

function MythicNewView:RefreshMaterial()
	self.m_refreshCountText.text = "x1"

	if ItemTools.getItemNum(MaterialConst.MYTHIC_REFRESH_ITEM_ID) > 0 then
		SetActive(self.m_refreshBtn.gameObject, true)
	else
		SetActive(self.m_refreshBtn.gameObject, false)
	end
end

function MythicNewView:RefreshAffixItems(arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5)
	local var_29_0 = {}

	arg_29_1 = arg_29_1 or {}

	local var_29_1 = 0
	local var_29_2 = math.min(#arg_29_1, 3)
	local var_29_3

	if MythicNormalCfg[self.difficulty] then
		var_29_3 = MythicNormalCfg[self.difficulty].sub_partition_list or {}
	end

	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		local var_29_4 = clone(iter_29_1)

		var_29_4.lock = arg_29_2 and not not (var_29_3[iter_29_0] and MythicData:GetIsFirstClear(var_29_3[iter_29_0])) or false

		if iter_29_1[3] == 3 then
			table.insert(var_29_0, 1, var_29_4)
		else
			var_29_1 = var_29_1 + 1

			table.insert(var_29_0, var_29_4)
		end
	end

	arg_29_5:SetSelectedState(var_29_2 .. "_" .. var_29_1)

	for iter_29_2, iter_29_3 in ipairs(var_29_0) do
		if arg_29_4[iter_29_2] == nil then
			arg_29_4[iter_29_2] = MythicAffixItem.New(self._affixItem, arg_29_3, iter_29_3)
		end

		arg_29_4[iter_29_2]:SetData(iter_29_3)

		local var_29_5 = arg_29_4[iter_29_2].transform_:GetComponent(typeof(Button))

		var_29_5.onClick:RemoveAllListeners()
		self:AddBtnListener(var_29_5, nil, function()
			self:ShowAffixInfo(arg_29_4[iter_29_2].transform_, iter_29_3)
		end)
	end

	for iter_29_4 = #var_29_0 + 1, #arg_29_4 do
		arg_29_4[iter_29_4]:Show(false)
	end
end

function MythicNewView:OpenSectionInfoView(arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = arg_31_1.stage_id

	MythicData:SetIsNew(false)
	self:OnMyticContentShow(true)

	local var_31_1

	if arg_31_2 then
		var_31_1 = MythicData:GetHeroAffixWithStatus()
	else
		local var_31_2 = MythicData:GetAllHeroAffix()[arg_31_3]

		var_31_2.isLock = not not MythicData:GetIsFirstClear(arg_31_1.partition)
		var_31_1 = {
			var_31_2
		}
	end

	self:Go("mythicSectionInfo", {
		stageID = var_31_0,
		partition = arg_31_1.partition,
		difficulty = self.difficulty,
		isMain = arg_31_2,
		affix = var_31_1
	})

	for iter_31_0, iter_31_1 in ipairs(self.selectControllers) do
		iter_31_1:SetSelectedIndex(0)
	end

	self.mainSelectController:SetSelectedIndex(0)

	if arg_31_2 then
		self.mainSelectController:SetSelectedIndex(1)
	else
		self.selectControllers[arg_31_3]:SetSelectedIndex(1)
	end
end

function MythicNewView:OnMyticUpdate()
	self:RefreshUI()

	if MythicData:GetDifficulty() == 0 then
		JumpTools.OpenPageByJump("/mythic/mythicDifficulty", nil)
	end
end

function MythicNewView:OnTryToUseItem(arg_33_1, arg_33_2)
	if isSuccess(arg_33_1.result) then
		MythicAction.QueryMythicInfo()
	else
		ShowTips(arg_33_1.result)
	end
end

function MythicNewView:Dispose()
	self:RemoveTween()

	for iter_34_0, iter_34_1 in pairs(self._affixHero) do
		iter_34_1:Dispose()
	end

	self._affixHero = {}

	for iter_34_2, iter_34_3 in pairs(self._affixMonster) do
		iter_34_3:Dispose()
	end

	self._affixMonster = {}

	MythicNewView.super.Dispose(self)
end

function MythicNewView:OnMyticContentShow(arg_35_1)
	if arg_35_1 then
		self:RemoveTween()

		self.tween_ = LeanTween.value(self.m_middleContent.gameObject, self.m_middleContent.localPosition.x, -300, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
			self.m_middleContent.localPosition = Vector3(arg_36_0, 0, 0)
		end))
	else
		self:RemoveTween()

		self.tween_ = LeanTween.value(self.m_middleContent.gameObject, self.m_middleContent.localPosition.x, 0, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
			self.m_middleContent.localPosition = Vector3(arg_37_0, 0, 0)
		end))
	end
end

function MythicNewView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil)
		LeanTween.cancel(self.m_middleContent.gameObject)

		self.tween_ = nil
	end
end

function MythicNewView:CloseSectionInfo()
	if self:IsOpenRoute("mythicSectionInfo") then
		self:OnMyticContentShow(false)
		JumpTools.Back()
	end

	for iter_39_0, iter_39_1 in ipairs(self.selectControllers) do
		iter_39_1:SetSelectedIndex(0)
	end

	self.mainSelectController:SetSelectedIndex(0)
end

function MythicNewView:ShowAffixInfo(arg_40_1, arg_40_2)
	self:CloseSectionInfo()
	self.affixinfoTrs_:SetParent(arg_40_1)

	self.affixinfoTrs_.localPosition = Vector3(0, -60, 0)

	SetActive(self.affixinfoTrs_.gameObject, true)

	self.affixcontentTrs_.transform.localPosition = Vector3(261.505, self.affixcontentTrs_.transform.localPosition.y, 0)

	local var_40_0 = self.endPoint_:TransformPoint(Vector3(0, 0, 0))

	self.affixcontentTrs_.transform.localPosition = self.affixcontentTrs_:TransformPoint(Vector3(0, 0, 0)).x >= var_40_0.x and Vector3(self.affixinfoTrs_:InverseTransformPoint(var_40_0).x, self.affixcontentTrs_.transform.localPosition.y, 0) or Vector3(261.505, self.affixcontentTrs_.transform.localPosition.y, 0)
	self.affixcontentText_.text = getAffixDesc(arg_40_2)
	self.affixnameText_.text = getAffixName(arg_40_2)

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.affixcontentTrs_)

	if self.countdownTimer_ then
		self.countdownTimer_:Stop()

		self.countdownTimer_ = nil
	end

	self.countdownTimer_ = Timer.New(function()
		SetActive(self.affixinfoTrs_.gameObject, false)
	end, 2, 1)

	self.countdownTimer_:Start()
end

function MythicNewView:HideAffixInfo()
	if self.countdownTimer_ then
		self.countdownTimer_:Stop()

		self.countdownTimer_ = nil
	end

	SetActive(self.affixinfoTrs_.gameObject, false)
end

return MythicNewView
