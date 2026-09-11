local QWorldStageInfoView = class("QWorldStageInfoView", ReduxView)

function QWorldStageInfoView:UIName()
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_Com/QuanZhou_ChapterSectionInfoUI"
end

function QWorldStageInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function QWorldStageInfoView:Init()
	self:InitUI()
end

function QWorldStageInfoView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()
	self:InitRewardList()
end

function QWorldStageInfoView:InitRewardList()
	self.rewardItemList_ = LuaList.New(handler(self, self.IndexRewardItem), self.rewardListGo_, CommonItemView)
	self.itemDataList_ = {}
end

function QWorldStageInfoView:AddUIListener()
	self:AddBtnListener(self.startBattle_, nil, handler(self, self.OnClickStartBattle))
	self:AddBtnListener(self.backBtn_, nil, handler(self, self.OnClickBackBtn))
end

function QWorldStageInfoView:OnTop()
	self:UpdateBar()
end

function QWorldStageInfoView:OnBehind()
	manager.windowBar:HideBar()
end

function QWorldStageInfoView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function QWorldStageInfoView:OnEnter()
	self:UpdateBar()
	self:InitParams()
	self:RefreshUI()
end

function QWorldStageInfoView:InitParams()
	self.stageType_ = self.params_.stageType
	self.stageID_ = self.params_.stageID
end

function QWorldStageInfoView:RefreshUI()
	self:RefreshStageInfo()
	self:RefreshReward()
end

function QWorldStageInfoView:RefreshStageInfo()
	self:RefreshTitle()
	self:RefreshDesc()
end

function QWorldStageInfoView:RefreshTitle()
	self.title_.text = self:GetStageTitle()
end

function QWorldStageInfoView:GetStageTitle()
	return BattleStageTools.GetStageCfg(self.stageType_, self.stageID_).name
end

function QWorldStageInfoView:RefreshDesc()
	self.desc_.text = self:GetStageDesc()
end

function QWorldStageInfoView:GetStageDesc()
	return BattleStageTools.GetStageCfg(self.stageType_, self.stageID_).tips
end

function QWorldStageInfoView:RefreshReward()
	self.rewardCfgList_ = self:GetRewardCfgList()

	self.rewardItemList_:StartScroll(#self.rewardCfgList_)
end

function QWorldStageInfoView:GetRewardCfgList()
	return {}
end

function QWorldStageInfoView:IndexRewardItem(arg_20_1, arg_20_2)
	if not self.itemDataList_[arg_20_1] then
		self.itemDataList_[arg_20_1] = clone(ItemTemplateData)
		self.itemDataList_[arg_20_1].clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end
	end

	self.itemDataList_[arg_20_1].id = self.rewardCfgList_[arg_20_1].id
	self.itemDataList_[arg_20_1].number = self.rewardCfgList_[arg_20_1].num

	arg_20_2:SetData(self.itemDataList_[arg_20_1])
end

function QWorldStageInfoView:OnClickStartBattle()
	self:LaunchBattle()
end

function QWorldStageInfoView:LaunchBattle()
	BattleController.GetInstance():LaunchBattle((self:GetStageData()))
end

function QWorldStageInfoView:GetStageData()
	return (BattleStageFactory.Produce(self.stageType_, self.stageID_))
end

function QWorldStageInfoView:Dispose()
	self.rewardItemList_:Dispose()
	QWorldStageInfoView.super.Dispose(self)
end

function QWorldStageInfoView:OnClickBackBtn()
	self:Back()
end

return QWorldStageInfoView
