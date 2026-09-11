local OsirisPlayGameChallegeStageView = class("OsirisPlayGameChallegeStageView", ReduxView)
local var_0_1 = 7

function OsirisPlayGameChallegeStageView:UIName()
	return "Widget/System/Activity_Osiris/Activity_Osiris_CheckpointUI"
end

function OsirisPlayGameChallegeStageView:UIParent()
	return manager.ui.uiMain.transform
end

function OsirisPlayGameChallegeStageView:Init()
	self:InitUI()
	self:AddUIListener()
end

function OsirisPlayGameChallegeStageView:InitUI()
	self:BindCfgUI()

	self.items_ = {}

	for iter_4_0 = 1, 6 do
		self.items_[iter_4_0] = OsirisPlayGameChallegeStageItem.New(self["itemGo_" .. iter_4_0], iter_4_0)

		self.items_[iter_4_0]:RegisterClickFunc(function(arg_5_0)
			self:OnBtnClick(arg_5_0)
		end)
	end

	self.positionCon_ = self.transform_:GetComponent("ControllerExCollection"):GetController("position")
end

function OsirisPlayGameChallegeStageView:OnEnter()
	self.activityID_ = self.params_.activityID_
	self.stage_list = ActivityGeneralityStageCfg.get_id_list_by_chapter_id[var_0_1]

	self:RefreshItems()

	for iter_6_0, iter_6_1 in pairs((OsirisPlayGameData:GetPassStageClearTimes())) do
		if iter_6_1 == 0 then
			OsirisPlayGameData:SetPassStageClearTimes(iter_6_0)
		end
	end
end

function OsirisPlayGameChallegeStageView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		if self:IsOpenSectionView() then
			JumpTools.Back()
			self:ResetSelect()
		end
	end)
end

function OsirisPlayGameChallegeStageView:IsOpenSectionView()
	return self:IsOpenRoute("osirisPlayGameSectionInfoView")
end

function OsirisPlayGameChallegeStageView:RefreshItems()
	for iter_10_0 = 1, #self.items_ do
		self.items_[iter_10_0]:RefreshView(self.stage_list[iter_10_0])
	end
end

function OsirisPlayGameChallegeStageView:OnBtnClick(arg_11_1)
	for iter_11_0 = 1, #self.items_ do
		self.items_[iter_11_0]:RefreshState(arg_11_1 == iter_11_0 and 1 or 0)
	end

	self.positionCon_:SetSelectedIndex(arg_11_1)
	self:EnterLevel(arg_11_1)
end

function OsirisPlayGameChallegeStageView:EnterLevel(arg_12_1)
	self.selectLevel_ = arg_12_1

	self.positionCon_:SetSelectedIndex(arg_12_1)
	JumpTools.OpenPageByJump("osirisPlayGameSectionInfoView", {
		section = self.stage_list[arg_12_1],
		sectionType = BattleConst.STAGE_TYPE_NEW.OSIRIS_PLAY_GAME,
		mainActivityID = self.activityID_,
		activityId = self.activityID_,
		backCall = handler(self, self.ResetSelect)
	})
end

function OsirisPlayGameChallegeStageView:ResetSelect()
	self.positionCon_:SetSelectedState(0)

	self.selectLevel_ = 0

	for iter_13_0 = 1, #self.items_ do
		self.items_[iter_13_0]:RefreshState(0)
	end
end

function OsirisPlayGameChallegeStageView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_GENERALITY_DESC")
	manager.windowBar:RegistBackCallBack(function()
		if self:IsOpenSectionView() then
			self:ResetSelect()
		end

		JumpTools.Back()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		if self:IsOpenSectionView() then
			self:ResetSelect()
		end

		gameContext:Go("/home", nil, nil, true)
	end)
end

function OsirisPlayGameChallegeStageView:OnExit()
	OsirisPlayGameChallegeStageView.super.OnExit(self)
	manager.windowBar:HideBar()
end

function OsirisPlayGameChallegeStageView:Dispose()
	for iter_18_0 = 1, #self.items_ do
		self.items_[iter_18_0]:Dispose()
	end

	OsirisPlayGameChallegeStageView.super.Dispose(self)
end

return OsirisPlayGameChallegeStageView
