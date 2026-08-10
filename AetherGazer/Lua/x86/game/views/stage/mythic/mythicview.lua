local var_0_0 = class("MythicNewView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Mythic/MythicUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0._affixHero = {}
	arg_4_0._affixMonster = {}
	arg_4_0.isStarController = ControllerUtil.GetController(arg_4_0.transform_, "isStar")
	arg_4_0.stageControllers = {}
	arg_4_0.selectControllers = {}

	for iter_4_0 = 1, 3 do
		local var_4_0 = arg_4_0["m_stage" .. iter_4_0]

		arg_4_0.stageControllers[iter_4_0] = ControllerUtil.GetController(var_4_0.transform, "stage")
		arg_4_0.selectControllers[iter_4_0] = ControllerUtil.GetController(var_4_0.transform, "select")
	end

	arg_4_0.mainController = ControllerUtil.GetController(arg_4_0.m_stageMain.transform, "stage")
	arg_4_0.mainSelectController = ControllerUtil.GetController(arg_4_0.m_stageMain.transform, "select")
	arg_4_0.heroAffixController = ControllerUtil.GetController(arg_4_0.m_heroAffixController, "affix")
	arg_4_0.mosterAffixController = ControllerUtil.GetController(arg_4_0.m_mosterAffixController, "affix")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_shopBtn, nil, function()
		arg_5_0:CloseSectionInfo()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.BLACK_AREA
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_refreshBtn, nil, function()
		arg_5_0:CloseSectionInfo()
		JumpTools.OpenPageByJump("popCostItem", {
			costCount = 1,
			costId = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
			content = string.format(GetTips("MYTHIC_REFRESH_CHECK"), GetI18NText(ItemCfg[MaterialConst.MYTHIC_REFRESH_ITEM_ID].name), 1),
			itemId = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
			popCostCallBack = handler(arg_5_0, arg_5_0.PopCostCallBack)
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_stageMain, nil, function()
		local var_8_0 = MythicData:GetDifficultyData(arg_5_0.difficulty)

		if var_8_0 then
			local var_8_1 = var_8_0.main_partition

			arg_5_0:OpenSectionInfoView(var_8_1, true, 0)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_stageMain_ball, nil, function()
		local var_9_0 = MythicData:GetDifficultyData(arg_5_0.difficulty)

		if var_9_0 then
			local var_9_1 = var_9_0.main_partition

			arg_5_0:OpenSectionInfoView(var_9_1, true, 0)
		end
	end)

	for iter_5_0 = 1, 3 do
		local var_5_0 = arg_5_0["m_stage" .. iter_5_0]

		if var_5_0 then
			arg_5_0:AddBtnListener(var_5_0, nil, function()
				local var_10_0 = MythicData:GetDifficultyData(arg_5_0.difficulty)

				if var_10_0 and var_10_0.sub_partition_list[iter_5_0] then
					local var_10_1 = var_10_0.sub_partition_list[iter_5_0]

					arg_5_0:OpenSectionInfoView(var_10_1, false, iter_5_0)
				end
			end)
		end
	end

	arg_5_0:AddBtnListener(arg_5_0.m_difficultyBtn, nil, function()
		arg_5_0:CloseSectionInfo()

		if MythicData:GetStarRewardCount() == 0 then
			JumpTools.OpenPageByJump("mythicDifficulty")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_rewardBtn, nil, function()
		arg_5_0:CloseSectionInfo()
		JumpTools.OpenPageByJump("mythicSectionReward", {
			difficulty = arg_5_0.difficulty
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_btnMask, nil, function()
		arg_5_0:CloseSectionInfo()
	end)
end

function var_0_0.PopCostCallBack(arg_14_0)
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
		local var_14_0 = MythicData:GetStarCount()

		for iter_14_0 = 1, var_14_0 do
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

function var_0_0.OnTop(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("MYTHIC_DESCRIPE")
	manager.windowBar:RegistBackCallBack(function()
		if arg_16_0:IsOpenRoute("mythicSectionInfo") then
			arg_16_0:CloseSectionInfo()
		else
			JumpTools.Back()
		end
	end)
	arg_16_0:CheckDifficultyChange()

	if not arg_16_0:IsOpenRoute("mythicSectionInfo") then
		arg_16_0:OnMyticContentShow(false)
	end

	arg_16_0:RefreshUI()
end

function var_0_0.OnEnter(arg_18_0)
	arg_18_0:RegistEventListener(MATERIAL_MODIFY, handler(arg_18_0, arg_18_0.RefreshMaterial))
	manager.redPoint:bindUIandKey(arg_18_0.m_rewardBtn.transform, RedPointConst.MYTHIC_TIMES_AWARD)

	local var_18_0 = MythicData:GetNextRefreshTime()

	arg_18_0.cdText_.text = string.format(GetTips("TIME_DISPLAY_9"), "" .. manager.time:GetLostTimeStrWith2Unit(var_18_0))
	arg_18_0.updateTimer_ = Timer.New(function()
		local var_19_0 = MythicData:GetNextRefreshTime()

		arg_18_0.cdText_.text = string.format(GetTips("TIME_DISPLAY_9"), "" .. manager.time:GetLostTimeStrWith2Unit(var_19_0))
	end, 1, -1)

	arg_18_0.updateTimer_:Start()
	arg_18_0:RefreshUI()
end

function var_0_0.OnExit(arg_20_0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(arg_20_0.m_rewardBtn.transform, RedPointConst.MYTHIC_TIMES_AWARD)
	arg_20_0:HideAffixInfo()

	if arg_20_0.updateTimer_ then
		arg_20_0.updateTimer_:Stop()

		arg_20_0.updateTimer_ = nil
	end
end

function var_0_0.CheckDifficultyChange(arg_21_0)
	if MythicData:GetIsNewDifficulty() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MYTHIC_NEW_LEVEL_UNLOCK"),
			OkCallback = function()
				MythicAction:QueryMythicRead()
				arg_21_0:CheckMail()
			end
		})
	else
		arg_21_0:CheckMail()
	end
end

function var_0_0.CheckMail(arg_23_0)
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

function var_0_0.RefreshUI(arg_27_0, arg_27_1)
	arg_27_0.curDifficulty = MythicData:GetDifficulty()
	arg_27_0.difficulty = arg_27_0.curDifficulty

	arg_27_0:RefreshMaterial()

	if arg_27_0.difficulty == 0 then
		return
	end

	if MythicData:GetStarRewardCount() == 0 then
		arg_27_0.isStarController:SetSelectedIndex(0)
	else
		arg_27_0.isStarController:SetSelectedIndex(1)
	end

	arg_27_0.m_romamLab.text = NumberTools.IntToRomam(arg_27_0.difficulty)

	arg_27_0:RefreshAffixItems(MythicData:GetAllHeroAffix(), true, arg_27_0._affixHeroParent, arg_27_0._affixHero, arg_27_0.heroAffixController)
	arg_27_0:RefreshAffixItems(MythicData:GetMonsterAffix(), false, arg_27_0._affixMonsterParent, arg_27_0._affixMonster, arg_27_0.mosterAffixController)

	local var_27_0 = MythicData:GetDifficultyData(arg_27_0.difficulty)

	if var_27_0 then
		local var_27_1 = var_27_0.main_partition.partition

		if MythicData:GetIsFirstClear(var_27_1) then
			arg_27_0.mainController:SetSelectedIndex(0)
		else
			arg_27_0.mainController:SetSelectedIndex(1)
		end

		for iter_27_0 = 1, 3 do
			local var_27_2 = arg_27_0.stageControllers[iter_27_0]

			if var_27_2 and var_27_0 and var_27_0.sub_partition_list[iter_27_0] then
				local var_27_3 = var_27_0.sub_partition_list[iter_27_0].partition

				if MythicData:GetIsFirstClear(var_27_3) then
					var_27_2:SetSelectedIndex(0)
				else
					var_27_2:SetSelectedIndex(1)
				end
			end
		end
	end

	if not arg_27_0:IsOpenRoute("mythicSectionInfo") then
		for iter_27_1, iter_27_2 in ipairs(arg_27_0.selectControllers) do
			iter_27_2:SetSelectedIndex(0)
		end

		arg_27_0.mainSelectController:SetSelectedIndex(0)
	end
end

function var_0_0.RefreshMaterial(arg_28_0)
	local var_28_0 = ItemTools.getItemNum(MaterialConst.MYTHIC_REFRESH_ITEM_ID)

	arg_28_0.m_refreshCountText.text = "x1"

	if var_28_0 > 0 then
		SetActive(arg_28_0.m_refreshBtn.gameObject, true)
	else
		SetActive(arg_28_0.m_refreshBtn.gameObject, false)
	end
end

function var_0_0.RefreshAffixItems(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5)
	local var_29_0 = {}

	arg_29_1 = arg_29_1 or {}

	local var_29_1 = 0
	local var_29_2 = math.min(#arg_29_1, 3)
	local var_29_3 = MythicNormalCfg[arg_29_0.difficulty] and MythicNormalCfg[arg_29_0.difficulty].sub_partition_list or {}

	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		local var_29_4 = clone(iter_29_1)

		if arg_29_2 then
			if var_29_3[iter_29_0] and MythicData:GetIsFirstClear(var_29_3[iter_29_0]) then
				var_29_4.lock = true
			else
				var_29_4.lock = false
			end
		else
			var_29_4.lock = false
		end

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
			arg_29_4[iter_29_2] = MythicAffixItem.New(arg_29_0._affixItem, arg_29_3, iter_29_3)
		end

		arg_29_4[iter_29_2]:SetData(iter_29_3)

		local var_29_5 = arg_29_4[iter_29_2].transform_:GetComponent(typeof(Button))

		var_29_5.onClick:RemoveAllListeners()
		arg_29_0:AddBtnListener(var_29_5, nil, function()
			arg_29_0:ShowAffixInfo(arg_29_4[iter_29_2].transform_, iter_29_3)
		end)
	end

	for iter_29_4 = #var_29_0 + 1, #arg_29_4 do
		arg_29_4[iter_29_4]:Show(false)
	end
end

function var_0_0.OpenSectionInfoView(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = arg_31_1.partition
	local var_31_1 = arg_31_1.stage_id

	MythicData:SetIsNew(false)
	arg_31_0:OnMyticContentShow(true)

	local var_31_2

	if arg_31_2 then
		var_31_2 = MythicData:GetHeroAffixWithStatus()
	else
		local var_31_3 = MythicData:GetAllHeroAffix()[arg_31_3]
		local var_31_4

		var_31_3.isLock = MythicData:GetIsFirstClear(var_31_0) and true or false
		var_31_2 = {
			var_31_3
		}
	end

	arg_31_0:Go("mythicSectionInfo", {
		stageID = var_31_1,
		partition = var_31_0,
		difficulty = arg_31_0.difficulty,
		isMain = arg_31_2,
		affix = var_31_2
	})

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.selectControllers) do
		iter_31_1:SetSelectedIndex(0)
	end

	arg_31_0.mainSelectController:SetSelectedIndex(0)

	if arg_31_2 then
		arg_31_0.mainSelectController:SetSelectedIndex(1)
	else
		arg_31_0.selectControllers[arg_31_3]:SetSelectedIndex(1)
	end
end

function var_0_0.OnMyticUpdate(arg_32_0)
	arg_32_0:RefreshUI()

	if MythicData:GetDifficulty() == 0 then
		JumpTools.OpenPageByJump("/mythic/mythicDifficulty", nil)
	end
end

function var_0_0.OnTryToUseItem(arg_33_0, arg_33_1, arg_33_2)
	if isSuccess(arg_33_1.result) then
		MythicAction.QueryMythicInfo()
	else
		ShowTips(arg_33_1.result)
	end
end

function var_0_0.Dispose(arg_34_0)
	arg_34_0:RemoveTween()

	for iter_34_0, iter_34_1 in pairs(arg_34_0._affixHero) do
		iter_34_1:Dispose()
	end

	arg_34_0._affixHero = {}

	for iter_34_2, iter_34_3 in pairs(arg_34_0._affixMonster) do
		iter_34_3:Dispose()
	end

	arg_34_0._affixMonster = {}

	var_0_0.super.Dispose(arg_34_0)
end

function var_0_0.OnMyticContentShow(arg_35_0, arg_35_1)
	if arg_35_1 then
		local var_35_0 = -300

		arg_35_0:RemoveTween()

		arg_35_0.tween_ = LeanTween.value(arg_35_0.m_middleContent.gameObject, arg_35_0.m_middleContent.localPosition.x, var_35_0, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
			arg_35_0.m_middleContent.localPosition = Vector3(arg_36_0, 0, 0)
		end))
	else
		arg_35_0:RemoveTween()

		arg_35_0.tween_ = LeanTween.value(arg_35_0.m_middleContent.gameObject, arg_35_0.m_middleContent.localPosition.x, 0, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
			arg_35_0.m_middleContent.localPosition = Vector3(arg_37_0, 0, 0)
		end))
	end
end

function var_0_0.RemoveTween(arg_38_0)
	if arg_38_0.tween_ then
		arg_38_0.tween_:setOnUpdate(nil)
		LeanTween.cancel(arg_38_0.m_middleContent.gameObject)

		arg_38_0.tween_ = nil
	end
end

function var_0_0.CloseSectionInfo(arg_39_0)
	if arg_39_0:IsOpenRoute("mythicSectionInfo") then
		arg_39_0:OnMyticContentShow(false)
		JumpTools.Back()
	end

	for iter_39_0, iter_39_1 in ipairs(arg_39_0.selectControllers) do
		iter_39_1:SetSelectedIndex(0)
	end

	arg_39_0.mainSelectController:SetSelectedIndex(0)
end

function var_0_0.ShowAffixInfo(arg_40_0, arg_40_1, arg_40_2)
	arg_40_0:CloseSectionInfo()
	arg_40_0.affixinfoTrs_:SetParent(arg_40_1)

	arg_40_0.affixinfoTrs_.localPosition = Vector3(0, -60, 0)

	SetActive(arg_40_0.affixinfoTrs_.gameObject, true)

	local var_40_0 = arg_40_0.affixcontentTrs_.transform.localPosition

	arg_40_0.affixcontentTrs_.transform.localPosition = Vector3(261.505, var_40_0.y, 0)

	local var_40_1 = arg_40_0.endPoint_:TransformPoint(Vector3(0, 0, 0))

	if arg_40_0.affixcontentTrs_:TransformPoint(Vector3(0, 0, 0)).x >= var_40_1.x then
		local var_40_2 = arg_40_0.affixinfoTrs_:InverseTransformPoint(var_40_1)

		arg_40_0.affixcontentTrs_.transform.localPosition = Vector3(var_40_2.x, var_40_0.y, 0)
	else
		arg_40_0.affixcontentTrs_.transform.localPosition = Vector3(261.505, var_40_0.y, 0)
	end

	arg_40_0.affixcontentText_.text = getAffixDesc(arg_40_2)
	arg_40_0.affixnameText_.text = getAffixName(arg_40_2)

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_0.affixcontentTrs_)

	if arg_40_0.countdownTimer_ then
		arg_40_0.countdownTimer_:Stop()

		arg_40_0.countdownTimer_ = nil
	end

	arg_40_0.countdownTimer_ = Timer.New(function()
		SetActive(arg_40_0.affixinfoTrs_.gameObject, false)
	end, 2, 1)

	arg_40_0.countdownTimer_:Start()
end

function var_0_0.HideAffixInfo(arg_42_0)
	if arg_42_0.countdownTimer_ then
		arg_42_0.countdownTimer_:Stop()

		arg_42_0.countdownTimer_ = nil
	end

	SetActive(arg_42_0.affixinfoTrs_.gameObject, false)
end

return var_0_0
