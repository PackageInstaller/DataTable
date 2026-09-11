local TangramGameCluePopView = class("TangramGameCluePopView", ReduxView)

function TangramGameCluePopView:UIName()
	return "Widget/System/Summer2024/Summer2024_Tangram/TangramResultPopUI"
end

function TangramGameCluePopView:UIParent()
	return manager.ui.uiPop.transform
end

function TangramGameCluePopView:Init()
	self:InitUI()

	self.animator = self.gameObject_:GetComponent("Animator")
end

function TangramGameCluePopView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()
end

function TangramGameCluePopView:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		if manager.ChessBoardManager and manager.ChessBoardManager:IsBattleBack() then
			ChessBoardAction.GoBackFromSmallGame(0, 0)
		else
			local var_6_0 = {}

			var_6_0.chapterID = ActivityTangramGameChapterCfg.get_id_list_by_puzzle_stage_list[self.stageID][1]
			var_6_0.stageID = self.stageID
			var_6_0.playAni = self.playAni

			JumpTools.OpenPageByJump("/tangramGameMainView", var_6_0)
		end
	end)
end

function TangramGameCluePopView:OnEnter()
	self.stageID = self.params_.stageID
	self.playAni = self.params_.playAni

	if self.playAni then
		self.animator:Play("once", -1, 0)
		self.animator:Update(0)
	else
		self.animator:Play("TangramResultPopUI", -1, 0)
		self.animator:Update(0)
	end

	self.name.text = ActivityTangramGameStageCfg[self.stageID].name
	self.desc.text = ActivityTangramGameStageCfg[self.stageID].desc
	self.imgiconImg_.sprite = getSpriteViaConfig("TangramGameStageIcon", self.stageID)
	self.params_ = nil

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.desc.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.name.transform)
end

function TangramGameCluePopView:OnExit()
	self.animator:Update(99999)
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()

	self.playAni = nil
end

function TangramGameCluePopView:Dispose()
	TangramGameCluePopView.super.Dispose(self)
end

return TangramGameCluePopView
