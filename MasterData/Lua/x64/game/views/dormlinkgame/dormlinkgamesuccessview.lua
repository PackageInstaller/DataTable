local DormLinkGameSuccessView = class("DormLinkGameSuccessView", ReduxView)

function DormLinkGameSuccessView:UIName()
	return "Widget/Version/Alone_LinkGame/Alone_LGPlayResult1"
end

function DormLinkGameSuccessView:UIParent()
	return manager.ui.uiMain.transform
end

function DormLinkGameSuccessView:OnCtor()
	return
end

function DormLinkGameSuccessView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormLinkGameSuccessView:InitUI()
	self:BindCfgUI()
end

function DormLinkGameSuccessView:AddUIListener()
	self:AddBtnListenerScale(self.confirmBtn_, nil, function()
		DormLinkGameTools:ExitGame()
	end)
end

function DormLinkGameSuccessView:OnEnter()
	self:RefreshView(self.params_.data)
end

function DormLinkGameSuccessView:RefreshView(arg_9_1)
	if arg_9_1 then
		self.scoreText_.text = string.format(GetTips("ACTIVITY_LINKGAME_SCORE") .. "<color=#76c844>(+%d)</color>", arg_9_1.totalPoint, arg_9_1.extendPoint)
		self.timeText_.text = string.format(GetTips("ACTIVITY_LINKGAME_TIME"), manager.time:DescCDTime(arg_9_1.time))
	end
end

function DormLinkGameSuccessView:OnExit()
	return
end

function DormLinkGameSuccessView:Dispose()
	DormLinkGameSuccessView.super.Dispose(self)
end

return DormLinkGameSuccessView
