local MythicUltimateView = class("MythicUltimateView", ReduxView)

function MythicUltimateView:UIName()
	return "Widget/System/Challenge_Mythic/MythicFinalUI"
end

function MythicUltimateView:UIParent()
	return manager.ui.uiMain.transform
end

function MythicUltimateView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function MythicUltimateView:InitUI()
	self:BindCfgUI()

	self._affixMonster = {}
	self.isStarController = ControllerUtil.GetController(self.transform_, "isStar")
	self.mosterAffixController_ = ControllerUtil.GetController(self.m_mosterAffixController, "affix")
end

function MythicUltimateView:AddUIListeners()
	self:AddBtnListener(self.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("mythicFinalRewardView")
	end)
	self:AddBtnListener(self.m_shopBtn, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.BLACK_AREA
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.m_refreshBtn, nil, function()
		JumpTools.OpenPageByJump("popCostItem", {
			costCount = 1,
			costId = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
			content = string.format(GetTips("MYTHIC_REFRESH_CHECK"), GetI18NText(ItemCfg[MaterialConst.MYTHIC_REFRESH_ITEM_ID].name), 1),
			itemId = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
			popCostCallBack = handler(self, self.PopCostCallBack)
		})
	end)
	self:AddBtnListener(self.m_difficultyBtn, nil, function()
		if MythicData:GetFinalIsReward() == 0 then
			JumpTools.OpenPageByJump("mythicDifficulty")
		end
	end)
	self:AddBtnListener(self.m_startBtn, nil, function()
		if MythicData:GetIsBattleIng() then
			gameContext:Go("/mythicFinalTeamView")
		else
			JumpTools.OpenPageByJump("mythicFinalLevelView")
		end
	end)
	self:AddBtnListener(self.m_rankBtn, nil, function()
		JumpTools.OpenPageByJump("/mythicFinalRankView", {
			reset = true
		})
	end)
end

function MythicUltimateView:OnEnter()
	self:RegistEventListener(MATERIAL_MODIFY, handler(self, self.RefreshMaterial))

	if not RankData:GetCommonRank(RankConst.RANK_ID.MYTHIC) then
		RankAction.QueryOwnCommonRank(RankConst.RANK_ID.MYTHIC)
	end

	self:RefreshUI()

	self.cdText_.text = string.format(GetTips("TIME_DISPLAY_9"), "" .. manager.time:GetLostTimeStrWith2Unit((MythicData:GetNextRefreshTime())))
	self.updateTimer_ = Timer.New(function()
		self.cdText_.text = string.format(GetTips("TIME_DISPLAY_9"), "" .. manager.time:GetLostTimeStrWith2Unit((MythicData:GetNextRefreshTime())))
	end, 1, -1)

	self.updateTimer_:Start()
	manager.redPoint:bindUIandKey(self.m_rewardBtn.transform, RedPointConst.MYTHIC_FINAL_AWARD)
end

function MythicUltimateView:PopCostCallBack()
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

function MythicUltimateView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("MYTHIC_FINAL_DESC")
	MythicData:SetIsNew(false)
	self:RefreshUI()
	self:CheckDifficultyChange()
end

function MythicUltimateView:OnMyticUpdate()
	self:RefreshUI()

	if MythicData:GetDifficulty() == 0 then
		JumpTools.OpenPageByJump("/mythicUltimateView/mythicDifficulty", nil)
	end
end

function MythicUltimateView:OnMythicFinalGetReward()
	self:RefreshUI()
end

function MythicUltimateView:OnMythicFinalUpdate()
	self:RefreshUI()
end

function MythicUltimateView:OnTryToUseItem(arg_19_1, arg_19_2)
	if isSuccess(arg_19_1.result) then
		MythicAction.QueryMythicInfo()
	else
		ShowTips(arg_19_1.result)
	end
end

function MythicUltimateView:CheckDifficultyChange()
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
	elseif MythicData:GetIsNewHotLevel() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MYTHIC_FINAL_LEVEL_UNLOCK"),
			OkCallback = function()
				MythicAction:QueryMythicFinalRead()
				self:CheckMail()
			end
		})
	else
		self:CheckMail()
	end
end

function MythicUltimateView:CheckMail()
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

function MythicUltimateView:RefreshUI()
	self:RefreshMaterial()

	if MythicData:GetFinalIsReward() == 0 then
		self.isStarController:SetSelectedIndex(0)
	else
		self.isStarController:SetSelectedIndex(1)
	end

	self.levelText_.text = string.format(MythicFinalCfg[MythicData:GetCurHotLevelId()].level_diffuculty)

	self:RefreshAffixItems(MythicData:GetFinalMonsterAffix(), false, self._affixMonsterParent, self._affixMonster, self.mosterAffixController_)
	self:RefreshRank()
end

function MythicUltimateView:RefreshMaterial()
	self.m_refreshCountText.text = "x1"

	if ItemTools.getItemNum(MaterialConst.MYTHIC_REFRESH_ITEM_ID) > 0 then
		SetActive(self.m_refreshBtn.gameObject, true)
	else
		SetActive(self.m_refreshBtn.gameObject, false)
	end
end

function MythicUltimateView:RefreshAffixItems(arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5)
	local var_28_0 = {}

	arg_28_1 = arg_28_1 or {}

	local var_28_1 = 0

	for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
		local var_28_2 = clone(iter_28_1)

		var_28_2.lock = false
		var_28_1 = var_28_1 + 1

		table.insert(var_28_0, var_28_2)
	end

	arg_28_5:SetSelectedState(math.min(#arg_28_1, 3) .. "_" .. var_28_1)

	for iter_28_2, iter_28_3 in ipairs(var_28_0) do
		self["affixname_" .. iter_28_2].text = getAffixName(iter_28_3)
		self["affixdes_" .. iter_28_2].text = getAffixDesc(iter_28_3)
		self["affiximage_" .. iter_28_2].sprite = getAffixSprite(iter_28_3)
	end

	for iter_28_4 = #var_28_0 + 1, #arg_28_4 do
		arg_28_4[iter_28_4]:Show(false)
	end
end

function MythicUltimateView:ShowAffixInfo(arg_29_1, arg_29_2)
	self.affixinfoTrs_:SetParent(arg_29_1)

	self.affixinfoTrs_.localPosition = Vector3(0, -60, 0)

	SetActive(self.affixinfoTrs_.gameObject, true)

	self.affixcontentTrs_.transform.localPosition = Vector3(261.505, self.affixcontentTrs_.transform.localPosition.y, 0)

	local var_29_0 = self.endPoint_:TransformPoint(Vector3(0, 0, 0))

	self.affixcontentTrs_.transform.localPosition = self.affixcontentTrs_:TransformPoint(Vector3(0, 0, 0)).x >= var_29_0.x and Vector3(self.affixinfoTrs_:InverseTransformPoint(var_29_0).x, self.affixcontentTrs_.transform.localPosition.y, 0) or Vector3(261.505, self.affixcontentTrs_.transform.localPosition.y, 0)
	self.affixcontentText_.text = getAffixDesc(arg_29_2)
	self.affixnameText_.text = getAffixName(arg_29_2)

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

function MythicUltimateView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	manager.redPoint:unbindUIandKey(self.m_rewardBtn.transform, RedPointConst.MYTHIC_FINAL_AWARD)
end

function MythicUltimateView:Dispose()
	for iter_32_0, iter_32_1 in pairs(self._affixMonster) do
		iter_32_1:Dispose()
	end

	self._affixMonster = {}

	self.super.Dispose(self)
end

function MythicUltimateView:OnMatrixCurRankUpdate()
	self:RefreshRank()
end

function MythicUltimateView:RefreshRank()
	local var_34_0 = RankData:GetCommonRank(RankConst.RANK_ID.MYTHIC)
	local var_34_1 = var_34_0 and var_34_0.curRank

	self.m_score.text = var_34_0 and var_34_0.curRank and var_34_1.rank ~= 0 and var_34_1.score or GetTips("MATRIX_RANK_NO_INFO")
end

function MythicUltimateView:OnMythicCurRankUpdate()
	self:RefreshRank()
end

function MythicUltimateView:OnRankUpdate()
	self:RefreshRank()
end

return MythicUltimateView
