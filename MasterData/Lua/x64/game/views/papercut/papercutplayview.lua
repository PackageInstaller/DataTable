local PaperCutPlayView = class("PaperCutPlayView", ReduxView)

function PaperCutPlayView:UIName()
	return "UI/EmptyDream/PaperCut/PaperCutPlayUI"
end

function PaperCutPlayView:UIParent()
	return manager.ui.uiMain.transform
end

function PaperCutPlayView:Init()
	self:InitUI()
end

function PaperCutPlayView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
end

function PaperCutPlayView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		PaperCutTool:GameOver()
		self:Back()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		PaperCutTool:GameOver()

		if self.params_.goHomeHandler ~= nil then
			self.params_.goHomeHandler()
		end
	end)
	self.statusController_:SetSelectedState("prepare")

	self.activityID_ = self.params_.activityID
	self.titleText_.text = GetI18NText(PaperCutCfg[self.activityID_].name)

	PaperCutTool:RegisterCompleteHandler(handler(self, self.OnCompleted))
	PaperCutTool:RegisterStartDrawHandler(handler(self, self.OnStartDraw))
end

function PaperCutPlayView:OnCompleted()
	JumpTools.OpenPageByJump("paperCutResult", {
		activityID = self.activityID_
	})
end

function PaperCutPlayView:OnStartDraw()
	manager.windowBar:HideBar()
	self.statusController_:SetSelectedState("playing")
end

function PaperCutPlayView:OnExit()
	manager.windowBar:HideBar()
end

return PaperCutPlayView
