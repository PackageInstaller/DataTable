local SeaWarfareBattleReadyView = class("SeaWarfareBattleReadyView", ReduxView)

function SeaWarfareBattleReadyView:UIName()
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_Navigation/QuanZhou_NavigationStageBase"
end

function SeaWarfareBattleReadyView:UIParent()
	return manager.ui.uiMain.transform
end

function SeaWarfareBattleReadyView:Init()
	self:InitUI()
end

function SeaWarfareBattleReadyView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()
	self:InitMarinerList()
	self:InitSkillList()
	self:InitController()
end

function SeaWarfareBattleReadyView:AddUIListener()
	self:AddBtnListener(self.startBattle_, nil, function()
		if self.selectedSkillID_ == nil then
			ShowTips("NEED_EQUIP_SKILL")

			return
		end

		self:LaunchBattle()
	end)
end

function SeaWarfareBattleReadyView:InitMarinerList()
	self.marinerItemList_ = {}

	for iter_7_0 = 1, self.maerinerPanelTrans_.childCount do
		self.marinerItemList_[#self.marinerItemList_ + 1] = SeaWarfareMarinerItem.New(self.maerinerPanelTrans_:GetChild(iter_7_0 - 1).gameObject)
	end
end

function SeaWarfareBattleReadyView:InitSkillList()
	self.selectSkillHandler_ = handler(self, self.OnSelectSkill)
	self.skillItemList_ = {}

	for iter_8_0 = 1, self.skillPanelTrans_.childCount do
		local var_8_0 = SeaWarfareSkillItem.New(self.skillPanelTrans_:GetChild(iter_8_0 - 1).gameObject)

		var_8_0:SetClickCallback(self.selectSkillHandler_)

		self.skillItemList_[#self.skillItemList_ + 1] = var_8_0
	end
end

function SeaWarfareBattleReadyView:InitController()
	self.selectSkillController_ = self.selectSkillControllerEx_:GetController("select")
	self.battleBtnController_ = self.controllerEx_:GetController("battleBtn")
end

function SeaWarfareBattleReadyView:OnTop()
	self:UpdateBar()
end

function SeaWarfareBattleReadyView:OnBehind()
	manager.windowBar:HideBar()
end

function SeaWarfareBattleReadyView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self.needSkipUnloadModel_ = true

		self:Back()
	end)
end

function SeaWarfareBattleReadyView:OnEnter()
	self:InitCamera()
	self:InitParams()
	self:RefreshUI()
	self:PlayEnterAnim()
end

function SeaWarfareBattleReadyView:InitCamera()
	QWorldMgr:EnableCustomCamera(SeaWarfareConst.CAMERA_GROUP_ID, 1, QWorldCameraLayer.System)
end

function SeaWarfareBattleReadyView:InitParams()
	self.stageID_ = self.params_.stageID
	self.selectedSkillID_ = nil
	self.recommendSkillID_ = SeaWarfareStageCfg[self.stageID_].recommend_skill
	self.needSkipUnloadModel_ = false
end

function SeaWarfareBattleReadyView:OnExit()
	self:CloseCamera()

	for iter_17_0, iter_17_1 in pairs(self.marinerItemList_) do
		iter_17_1:ResetAnim()
	end

	for iter_17_2, iter_17_3 in pairs(self.skillItemList_) do
		iter_17_3:ResetAnim()
	end

	if not self.needSkipUnloadModel_ then
		SeaWarfareModelView:GetInstance():Unload()
	end

	self:StopAnim()
end

function SeaWarfareBattleReadyView:CloseCamera()
	QWorldMgr:ExitCustomCamera(SandplayCameraGroupCfg[SeaWarfareConst.CAMERA_GROUP_ID].camera[1])
end

function SeaWarfareBattleReadyView:RefreshUI()
	self:RefreshMarinerList()
	self:RefreshSkillList()
	self:RefreshStageInfo()
	self:RefreshSelectedSkillInfo()
	self:RefreshPopSkillInfo()
end

function SeaWarfareBattleReadyView:RefreshMarinerList()
	self.marinerIDList_ = SeaWarfareTools.GetMarinerIDList()

	for iter_20_0, iter_20_1 in ipairs(self.marinerItemList_) do
		iter_20_1:SetData(self.marinerIDList_[iter_20_0])
	end
end

function SeaWarfareBattleReadyView:RefreshSkillList()
	self.skillIDList_ = SeaWarfareTools.GetSkillIDList()

	for iter_21_0, iter_21_1 in ipairs(self.skillItemList_) do
		local var_21_0 = self.skillIDList_[iter_21_0]

		iter_21_1:SetData(self.skillIDList_[iter_21_0])
		iter_21_1:SetSelect(self.selectedSkillID_ == var_21_0)
		iter_21_1:SetRecommend(self.recommendSkillID_ == var_21_0)
	end
end

function SeaWarfareBattleReadyView:IndexMarinerItem(arg_22_1, arg_22_2)
	arg_22_2:SetData(self.marinerIDList_[arg_22_1])
end

function SeaWarfareBattleReadyView:IndexSkillItem(arg_23_1, arg_23_2)
	local var_23_0 = self.skillIDList_[arg_23_1]

	arg_23_2:SetData(self.skillIDList_[arg_23_1])
	arg_23_2:SetClickCallback(self.selectSkillHandler_)
	arg_23_2:SetSelect(self.selectedSkillID_ == var_23_0)
	arg_23_2:SetRecommend(self.recommendSkillID_ == var_23_0)
end

function SeaWarfareBattleReadyView:OnSelectSkill(arg_24_1)
	self.selectedSkillID_ = arg_24_1

	self:RefreshSelectedSkillInfo()
	self:RefreshSkillSelect()
	self:RefreshPopSkillInfo()
	self:RefreshSkillCamera()
	self:RefreshBattleBtn()
end

function SeaWarfareBattleReadyView:RefreshSkillSelect()
	for iter_25_0, iter_25_1 in pairs(self.skillItemList_) do
		iter_25_1:SetSelect(iter_25_1:GetSKillID() == self.selectedSkillID_)
	end
end

function SeaWarfareBattleReadyView:RefreshSkillCamera()
	SeaWarfareModelView:GetInstance():SwitchModelAnim((table.indexof(self.skillIDList_, self.selectedSkillID_)))
end

function SeaWarfareBattleReadyView:RefreshStageInfo()
	self.mechanismDesc_.text = SeaWarfareStageCfg[self.stageID_].desc
end

function SeaWarfareBattleReadyView:RefreshSelectedSkillInfo()
	if self.selectedSkillID_ then
		self.selectedSKillIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/SandPlay_QuanZhou/QuanZhou_Navigation/" .. SeaWarfareSkillCfg[self.selectedSkillID_].icon_show)
	end
end

function SeaWarfareBattleReadyView:RefreshPopSkillInfo()
	if self.selectedSkillID_ then
		self.selectedSkillName_.text = SeaWarfareSkillCfg[self.selectedSkillID_].name
		self.selectedSkillDesc_.text = SeaWarfareSkillCfg[self.selectedSkillID_].desc
		self.selectedSkillTag_.text = SeaWarfareSkillCfg[self.selectedSkillID_].tag
	end

	self.selectSkillController_:SetSelectedState(self.selectedSkillID_ and "on" or "off")
end

function SeaWarfareBattleReadyView:RefreshBattleBtn()
	self.battleBtnController_:SetSelectedState(self.selectedSkillID_ and "on" or "off")
end

function SeaWarfareBattleReadyView:Dispose()
	for iter_31_0, iter_31_1 in pairs(self.marinerItemList_) do
		iter_31_1:Dispose()
	end

	for iter_31_2, iter_31_3 in pairs(self.skillItemList_) do
		iter_31_3:Dispose()
	end

	SeaWarfareBattleReadyView.super.Dispose(self)
end

function SeaWarfareBattleReadyView:LaunchBattle()
	SeaWarfareTools.LaunchBattle(self.stageID_, self.selectedSkillID_, SeaWarfareTools.GetUnlockMarinerIDList())
end

function SeaWarfareBattleReadyView:PlayEnterAnim()
	self:StopAnim()

	self.enterAnimTimer_ = SeaWarfareTools.PlayAnim(self.enterAnim_, "UI_right_cx", handler(self, self.OnEnterAnimEnd))
end

function SeaWarfareBattleReadyView:OnEnterAnimEnd()
	self:StopAnim()

	for iter_34_0, iter_34_1 in pairs(self.marinerItemList_) do
		iter_34_1:PlayAnim()
	end

	for iter_34_2, iter_34_3 in pairs(self.skillItemList_) do
		iter_34_3:PlayFirstUnlockAnim()
	end
end

function SeaWarfareBattleReadyView:StopAnim()
	self.enterAnim_.enabled = false

	if self.enterAnimTimer_ then
		self.enterAnimTimer_:Stop()

		self.enterAnimTimer_ = nil
	end
end

return SeaWarfareBattleReadyView
