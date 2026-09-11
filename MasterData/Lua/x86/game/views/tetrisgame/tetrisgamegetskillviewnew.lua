local TetrisGameGetSkillViewNew = class("TetrisGameGetSkillViewNew", ReduxView)

function TetrisGameGetSkillViewNew:UIName()
	return "Widget/Version/Alone_TetrisGameUI/TetrisGameeSkillDetailsPopUI"
end

function TetrisGameGetSkillViewNew:UIParent()
	return manager.ui.uiPop.transform
end

function TetrisGameGetSkillViewNew:Init()
	self:InitUI()
	self:AddUIListener()
end

function TetrisGameGetSkillViewNew:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()

		if self.params_.closeCallBack then
			self.params_.closeCallBack()

			self.params_.closeCallBack = nil
		end
	end)
end

function TetrisGameGetSkillViewNew:InitUI()
	self:BindCfgUI()

	self.skillScroll = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, TetrisGameSkillItem)
end

function TetrisGameGetSkillViewNew:IndexItem(arg_7_1, arg_7_2)
	if self.inGame then
		arg_7_2:RefreshUIInGame(self.skillList[arg_7_1])
	else
		arg_7_2:RefreshUIInCheckView(self.skillList[arg_7_1])
	end
end

function TetrisGameGetSkillViewNew:OnEnter()
	self.activityID = TetrisGameData:GetCurActivityID()

	self:EnterSelect()
end

function TetrisGameGetSkillViewNew:EnterSelect()
	self.inGame = self.params_.inGame
	self.stageID = self.params_.stageID
	self.skillList = {}
	self.skillList = self.stageID and self.stageID > 0 and (ActivityTetrisGameStageCfg[self.stageID].type == TetrisGameConst.stageType.endLess and TetrisGameData:GetEndlessSkillList() or ActivityTetrisGameStageCfg[self.stageID].skill_list) or self.params_.skillList

	self.skillScroll:StartScroll(#self.skillList)
end

function TetrisGameGetSkillViewNew:OnTop()
	manager.windowBar:HideBar()
end

function TetrisGameGetSkillViewNew:OnExit()
	manager.windowBar:HideBar()
end

function TetrisGameGetSkillViewNew:Dispose()
	if self.skillScroll then
		self.skillScroll:Dispose()

		self.skillScroll = nil
	end

	TetrisGameGetSkillViewNew.super.Dispose(self)
end

return TetrisGameGetSkillViewNew
