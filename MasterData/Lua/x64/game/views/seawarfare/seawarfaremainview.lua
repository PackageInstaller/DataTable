local SeaWarfareMainView = class("SeaWarfareMainView", ReduxView)

function SeaWarfareMainView:UIName()
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_Navigation/QuanZhou_NavigationEnter"
end

function SeaWarfareMainView:UIParent()
	return manager.ui.uiMain.transform
end

function SeaWarfareMainView:Init()
	self:InitUI()
end

function SeaWarfareMainView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()
	self:InitRewardList()
	self:InitStageList()
	self:InitController()
end

function SeaWarfareMainView:AddUIListener()
	self:AddBtnListener(self.startBattle_, nil, function()
		self.needSkipUnloadModel_ = true

		self:Go("/seaWarfareBattleReady", {
			stageID = self.selectStageID_
		})
	end)
end

function SeaWarfareMainView:InitRewardList()
	self.rewardItemList_ = {}
	self.itemDataList_ = {}

	for iter_7_0 = 1, self.rewardPanelTrans_.childCount do
		self.rewardItemList_[iter_7_0] = CommonItemView.New(self.rewardPanelTrans_:GetChild(iter_7_0 - 1).gameObject, true)
		self.itemDataList_[iter_7_0] = clone(ItemTemplateData)
		self.itemDataList_[iter_7_0].clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end
	end
end

function SeaWarfareMainView:InitStageList()
	self.stageItemList_ = {}
	self.selectStageHandler_ = handler(self, self.OnSelectStage)
end

function SeaWarfareMainView:InitController()
	self.completeController_ = self.controllerEx_:GetController("complete")
end

function SeaWarfareMainView:OnEnter()
	self:InitCamera()
	self:InitModel()
	self:GetStageIDList()

	local var_11_0 = SeaWarfareTools.GetNeedFirstCompleteAnimStageID()

	self.selectStageID_ = var_11_0 ~= nil and var_11_0 or self:GetDefaultSelectStageID()

	self:RefreshUI()
	self:PlayEnterAnim()
end

function SeaWarfareMainView:InitCamera()
	QWorldMgr:EnableCustomCamera(SeaWarfareConst.CAMERA_GROUP_ID, 1, QWorldCameraLayer.System)
end

function SeaWarfareMainView:InitModel()
	self.needSkipUnloadModel_ = false

	if not self.params_.isBack then
		SeaWarfareModelView:GetInstance():Load()
	else
		SeaWarfareModelView:GetInstance():SwitchModelAnim(0)
	end
end

function SeaWarfareMainView:OnExit()
	self:CloseCamera()

	for iter_14_0, iter_14_1 in pairs(self.stageItemList_) do
		iter_14_1:ResetAnim()
	end

	if not self.needSkipUnloadModel_ then
		SeaWarfareModelView:GetInstance():Unload()
	end

	self.params_.lastSelectStageID = self.selectStageID_

	self:StopAnim()
end

function SeaWarfareMainView:CloseCamera()
	QWorldMgr:ExitCustomCamera(SandplayCameraGroupCfg[SeaWarfareConst.CAMERA_GROUP_ID].camera[1])
end

function SeaWarfareMainView:OnTop()
	self:UpdateBar()
end

function SeaWarfareMainView:OnBehind()
	manager.windowBar:HideBar()
end

function SeaWarfareMainView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if SeaWarfareTools.GetIsGoBackFromBattle() then
			SeaWarfareTools.SetIsGoBackFromBattle(false)
			self:Back()
		else
			JumpTools.OpenPageByJump("/qWorldBookletEntry")
		end
	end)
end

function SeaWarfareMainView:GetStageIDList()
	self.stageIDList_ = SeaWarfareTools.GetStageIDList(SeaWarfareConst.STAGE_TYPE.CHALLENGE)
end

function SeaWarfareMainView:GetDefaultSelectStageID()
	if self.params_.isBack then
		return self.params_.lastSelectStageID
	else
		local var_21_0 = clone(self.stageIDList_)

		table.sort(var_21_0, function(arg_22_0, arg_22_1)
			local var_22_0 = SeaWarfareTools.IsStageLock(arg_22_0)

			if var_22_0 ~= SeaWarfareTools.IsStageLock(arg_22_1) then
				return not var_22_0
			else
				local var_22_1 = SeaWarfareTools.IsStageCompleted(arg_22_0)

				if var_22_1 ~= SeaWarfareTools.IsStageCompleted(arg_22_1) then
					return not var_22_1
				else
					return arg_22_0 < arg_22_1
				end
			end
		end)

		return var_21_0[1]
	end
end

function SeaWarfareMainView:RefreshUI()
	self:RefreshStageList()
	self:RefreshStageSelect()
	self:RefreshStage()
end

function SeaWarfareMainView:RefreshStageList()
	for iter_24_0, iter_24_1 in ipairs(self.stageIDList_) do
		if not self.stageItemList_[iter_24_0] then
			local var_24_0 = Object.Instantiate(self.stageItemGo_, self.stageItemContentTrans_)

			SetActive(var_24_0, true)

			self.stageItemList_[iter_24_0] = SeaWarfareStageItem.New(var_24_0)
		end

		self:IndexItem(iter_24_0, self.stageItemList_[iter_24_0])
	end
end

function SeaWarfareMainView:IndexItem(arg_25_1, arg_25_2)
	local var_25_0 = self.stageIDList_[arg_25_1]

	arg_25_2:SetData(self.stageIDList_[arg_25_1], arg_25_1)
	arg_25_2:SetSelect(var_25_0 == self.selectStageID_)
	arg_25_2:SetClickCallback(self.selectStageHandler_)
end

function SeaWarfareMainView:OnSelectStage(arg_26_1)
	if self.selectStageID_ == arg_26_1 then
		return
	end

	self.selectStageID_ = arg_26_1

	self:RefreshStageSelect()
	self:RefreshStage()
end

function SeaWarfareMainView:RefreshStageSelect()
	for iter_27_0, iter_27_1 in pairs(self.stageItemList_) do
		iter_27_1:SetSelect(iter_27_1:GetStageID() == self.selectStageID_)
	end
end

function SeaWarfareMainView:RefreshStage()
	self:RefreshStageInfo()
	self:RefreshReward()
end

function SeaWarfareMainView:RefreshStageInfo()
	self.stageName_.text = BattleSeaWarfareStageCfg[SeaWarfareStageCfg[self.selectStageID_].stage_id].name
	self.stageDesc_.text = BattleSeaWarfareStageCfg[SeaWarfareStageCfg[self.selectStageID_].stage_id].tips
end

function SeaWarfareMainView:RefreshReward()
	self:RefreshRewardState()
	self:RefreshRewardItem()
end

function SeaWarfareMainView:RefreshRewardState()
	self.completeController_:SetSelectedState(SeaWarfareTools.IsStageCompleted(self.selectStageID_) and "on" or "off")
end

function SeaWarfareMainView:RefreshRewardItem()
	local var_32_0 = getRewardFromDropCfg(SeaWarfareStageCfg[self.selectStageID_].reward, true)
	local var_32_1 = SeaWarfareTools.IsStageCompleted(self.selectStageID_)

	for iter_32_0, iter_32_1 in ipairs(var_32_0) do
		self.itemDataList_[iter_32_0].id = iter_32_1.id
		self.itemDataList_[iter_32_0].number = iter_32_1.num

		self.rewardItemList_[iter_32_0]:SetData(self.itemDataList_[iter_32_0])
		self.rewardItemList_[iter_32_0]:RefreshGray(var_32_1)
		self.rewardItemList_[iter_32_0]:RefreshCompleted(var_32_1)
	end

	for iter_32_2 = #var_32_0 + 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_32_2]:SetData(nil)
	end
end

function SeaWarfareMainView:Dispose()
	for iter_33_0, iter_33_1 in ipairs(self.stageItemList_) do
		iter_33_1:Dispose()
	end

	for iter_33_2, iter_33_3 in pairs(self.rewardItemList_) do
		iter_33_3:Dispose()
	end

	SeaWarfareMainView.super.Dispose(self)
end

function SeaWarfareMainView:StopAnim()
	if self.enterAnimTimer_ then
		self.enterAnimTimer_:Stop()

		self.enterAnimTimer_ = nil
	end

	if self.checkActiveTimer_ then
		self.checkActiveTimer_:Stop()

		self.checkActiveTimer_ = nil
	end
end

function SeaWarfareMainView:PlayEnterAnim()
	self:StopAnim()

	self.checkActiveTimer_ = FrameTimer.New(function()
		if self.gameObject_.activeInHierarchy then
			self.checkActiveTimer_:Stop()

			self.checkActiveTimer_ = nil
			self.enterAnimTimer_ = SeaWarfareTools.PlayAnim(self.enterAnim_, "UI_right_cx", handler(self, self.PlayStageCompletedAnim))
		end
	end, 1, -1)

	self.checkActiveTimer_:Start()
end

function SeaWarfareMainView:PlayStageCompletedAnim()
	self.firstCompleteStageID_ = SeaWarfareTools.GetNeedFirstCompleteAnimStageID()

	if not self.firstCompleteStageID_ then
		return
	end

	for iter_37_0, iter_37_1 in pairs(self.stageItemList_) do
		if iter_37_1:GetStageID() == self.firstCompleteStageID_ then
			SeaWarfareTools.SetNeedFirstCompleteAnimStageID(nil)
			iter_37_1:PlayCompletedAnim(handler(self, self.OnStageCompletedAnimEnd))

			break
		end
	end
end

function SeaWarfareMainView:OnStageCompletedAnimEnd()
	self.firstUnlockStageID_ = SeaWarfareTools.GetNeedFirstUnlockAnimStageID()

	if not self.firstUnlockStageID_ then
		return
	end

	for iter_38_0, iter_38_1 in pairs(self.stageItemList_) do
		if iter_38_1:GetStageID() == self.firstUnlockStageID_ then
			SeaWarfareTools.SetNeedFirstUnlockAnimStageID(nil)
			iter_38_1:PlayUnlockAnim(handler(self, self.OnStageUnlockAnimEnd))

			break
		end
	end
end

function SeaWarfareMainView:OnStageUnlockAnimEnd()
	if self.selectStageID_ == self.firstCompleteStageID_ and self.firstUnlockStageID_ then
		self.selectStageID_ = self.firstUnlockStageID_

		self:RefreshUI()
	end
end

return SeaWarfareMainView
