local var_0_0 = class("MythicUltimateView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Mythic/MythicFinalUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0._affixMonster = {}
	arg_4_0.isStarController = ControllerUtil.GetController(arg_4_0.transform_, "isStar")
	arg_4_0.mosterAffixController_ = ControllerUtil.GetController(arg_4_0.m_mosterAffixController, "affix")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("mythicFinalRewardView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_shopBtn, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.BLACK_AREA
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_refreshBtn, nil, function()
		JumpTools.OpenPageByJump("popCostItem", {
			costCount = 1,
			costId = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
			content = string.format(GetTips("MYTHIC_REFRESH_CHECK"), GetI18NText(ItemCfg[MaterialConst.MYTHIC_REFRESH_ITEM_ID].name), 1),
			itemId = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
			popCostCallBack = handler(arg_5_0, arg_5_0.PopCostCallBack)
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_difficultyBtn, nil, function()
		if MythicData:GetFinalIsReward() == 0 then
			JumpTools.OpenPageByJump("mythicDifficulty")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_startBtn, nil, function()
		if MythicData:GetIsBattleIng() then
			gameContext:Go("/mythicFinalTeamView")
		else
			JumpTools.OpenPageByJump("mythicFinalLevelView")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_rankBtn, nil, function()
		JumpTools.OpenPageByJump("/mythicFinalRankView", {
			reset = true
		})
	end)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:RegistEventListener(MATERIAL_MODIFY, handler(arg_12_0, arg_12_0.RefreshMaterial))

	if not RankData:GetCommonRank(RankConst.RANK_ID.MYTHIC) then
		RankAction.QueryOwnCommonRank(RankConst.RANK_ID.MYTHIC)
	end

	arg_12_0:RefreshUI()

	local var_12_0 = MythicData:GetNextRefreshTime()

	arg_12_0.cdText_.text = string.format(GetTips("TIME_DISPLAY_9"), "" .. manager.time:GetLostTimeStrWith2Unit(var_12_0))
	arg_12_0.updateTimer_ = Timer.New(function()
		local var_13_0 = MythicData:GetNextRefreshTime()

		arg_12_0.cdText_.text = string.format(GetTips("TIME_DISPLAY_9"), "" .. manager.time:GetLostTimeStrWith2Unit(var_13_0))
	end, 1, -1)

	arg_12_0.updateTimer_:Start()
	manager.redPoint:bindUIandKey(arg_12_0.m_rewardBtn.transform, RedPointConst.MYTHIC_FINAL_AWARD)
end

function var_0_0.PopCostCallBack(arg_14_0)
	if MythicData:GetFinalRewardNotGet() then
		ShowTips("ERROR_BATTLE_MYTHIC_REWARD_NO_RECEIVED")

		return
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

function var_0_0.OnTop(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("MYTHIC_FINAL_DESC")
	MythicData:SetIsNew(false)
	arg_15_0:RefreshUI()
	arg_15_0:CheckDifficultyChange()
end

function var_0_0.OnMyticUpdate(arg_16_0)
	arg_16_0:RefreshUI()

	if MythicData:GetDifficulty() == 0 then
		JumpTools.OpenPageByJump("/mythicUltimateView/mythicDifficulty", nil)
	end
end

function var_0_0.OnMythicFinalGetReward(arg_17_0)
	arg_17_0:RefreshUI()
end

function var_0_0.OnMythicFinalUpdate(arg_18_0)
	arg_18_0:RefreshUI()
end

function var_0_0.OnTryToUseItem(arg_19_0, arg_19_1, arg_19_2)
	if isSuccess(arg_19_1.result) then
		MythicAction.QueryMythicInfo()
	else
		ShowTips(arg_19_1.result)
	end
end

function var_0_0.CheckDifficultyChange(arg_20_0)
	if MythicData:GetIsNewDifficulty() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MYTHIC_NEW_LEVEL_UNLOCK"),
			OkCallback = function()
				MythicAction:QueryMythicRead()
				arg_20_0:CheckMail()
			end
		})
	elseif MythicData:GetIsNewHotLevel() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MYTHIC_FINAL_LEVEL_UNLOCK"),
			OkCallback = function()
				MythicAction:QueryMythicFinalRead()
				arg_20_0:CheckMail()
			end
		})
	else
		arg_20_0:CheckMail()
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
	end
end

function var_0_0.RefreshUI(arg_26_0)
	arg_26_0:RefreshMaterial()

	if MythicData:GetFinalIsReward() == 0 then
		arg_26_0.isStarController:SetSelectedIndex(0)
	else
		arg_26_0.isStarController:SetSelectedIndex(1)
	end

	arg_26_0.levelText_.text = string.format(MythicFinalCfg[MythicData:GetCurHotLevelId()].level_diffuculty)

	arg_26_0:RefreshAffixItems(MythicData:GetFinalMonsterAffix(), false, arg_26_0._affixMonsterParent, arg_26_0._affixMonster, arg_26_0.mosterAffixController_)
	arg_26_0:RefreshRank()
end

function var_0_0.RefreshMaterial(arg_27_0)
	local var_27_0 = ItemTools.getItemNum(MaterialConst.MYTHIC_REFRESH_ITEM_ID)

	arg_27_0.m_refreshCountText.text = "x1"

	if var_27_0 > 0 then
		SetActive(arg_27_0.m_refreshBtn.gameObject, true)
	else
		SetActive(arg_27_0.m_refreshBtn.gameObject, false)
	end
end

function var_0_0.RefreshAffixItems(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5)
	local var_28_0 = {}

	arg_28_1 = arg_28_1 or {}

	local var_28_1 = 0
	local var_28_2 = math.min(#arg_28_1, 3)

	for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
		local var_28_3 = clone(iter_28_1)

		var_28_3.lock = false
		var_28_1 = var_28_1 + 1

		table.insert(var_28_0, var_28_3)
	end

	arg_28_5:SetSelectedState(var_28_2 .. "_" .. var_28_1)

	for iter_28_2, iter_28_3 in ipairs(var_28_0) do
		arg_28_0["affixname_" .. iter_28_2].text = getAffixName(iter_28_3)
		arg_28_0["affixdes_" .. iter_28_2].text = getAffixDesc(iter_28_3)
		arg_28_0["affiximage_" .. iter_28_2].sprite = getAffixSprite(iter_28_3)
	end

	for iter_28_4 = #var_28_0 + 1, #arg_28_4 do
		arg_28_4[iter_28_4]:Show(false)
	end
end

function var_0_0.ShowAffixInfo(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0.affixinfoTrs_:SetParent(arg_29_1)

	arg_29_0.affixinfoTrs_.localPosition = Vector3(0, -60, 0)

	SetActive(arg_29_0.affixinfoTrs_.gameObject, true)

	local var_29_0 = arg_29_0.affixcontentTrs_.transform.localPosition

	arg_29_0.affixcontentTrs_.transform.localPosition = Vector3(261.505, var_29_0.y, 0)

	local var_29_1 = arg_29_0.endPoint_:TransformPoint(Vector3(0, 0, 0))

	if arg_29_0.affixcontentTrs_:TransformPoint(Vector3(0, 0, 0)).x >= var_29_1.x then
		local var_29_2 = arg_29_0.affixinfoTrs_:InverseTransformPoint(var_29_1)

		arg_29_0.affixcontentTrs_.transform.localPosition = Vector3(var_29_2.x, var_29_0.y, 0)
	else
		arg_29_0.affixcontentTrs_.transform.localPosition = Vector3(261.505, var_29_0.y, 0)
	end

	arg_29_0.affixcontentText_.text = getAffixDesc(arg_29_2)
	arg_29_0.affixnameText_.text = getAffixName(arg_29_2)

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_0.affixcontentTrs_)

	if arg_29_0.countdownTimer_ then
		arg_29_0.countdownTimer_:Stop()

		arg_29_0.countdownTimer_ = nil
	end

	arg_29_0.countdownTimer_ = Timer.New(function()
		SetActive(arg_29_0.affixinfoTrs_.gameObject, false)
	end, 2, 1)

	arg_29_0.countdownTimer_:Start()
end

function var_0_0.OnExit(arg_31_0)
	arg_31_0:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if arg_31_0.updateTimer_ then
		arg_31_0.updateTimer_:Stop()

		arg_31_0.updateTimer_ = nil
	end

	manager.redPoint:unbindUIandKey(arg_31_0.m_rewardBtn.transform, RedPointConst.MYTHIC_FINAL_AWARD)
end

function var_0_0.Dispose(arg_32_0)
	for iter_32_0, iter_32_1 in pairs(arg_32_0._affixMonster) do
		iter_32_1:Dispose()
	end

	arg_32_0._affixMonster = {}

	arg_32_0.super.Dispose(arg_32_0)
end

function var_0_0.OnMatrixCurRankUpdate(arg_33_0)
	arg_33_0:RefreshRank()
end

function var_0_0.RefreshRank(arg_34_0)
	local var_34_0 = RankData:GetCommonRank(RankConst.RANK_ID.MYTHIC)
	local var_34_1 = var_34_0 and var_34_0.curRank

	if var_34_1 and var_34_1.rank ~= 0 then
		arg_34_0.m_score.text = var_34_1.score
	else
		arg_34_0.m_score.text = GetTips("MATRIX_RANK_NO_INFO")
	end
end

function var_0_0.OnMythicCurRankUpdate(arg_35_0)
	arg_35_0:RefreshRank()
end

function var_0_0.OnRankUpdate(arg_36_0)
	arg_36_0:RefreshRank()
end

return var_0_0
