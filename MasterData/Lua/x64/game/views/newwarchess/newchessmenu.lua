local NewChessMenu = class("NewChessMenu", ReduxView)

function NewChessMenu:UIName()
	return "UI/WarChess/WarChessMenu"
end

function NewChessMenu:UIParent()
	return manager.ui.uiPop.transform
end

function NewChessMenu:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewChessMenu:InitUI()
	self:BindCfgUI()
	self:BindCfgUI(self.summercontextTrs_)

	self.themeCon_ = ControllerUtil.GetController(self.transform_, "name")
end

function NewChessMenu:AddUIListener()
	self:AddBtnListener(self.cancelbtnBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("CONFIRM_TO_QUIT_CHESS"),
			OkCallback = function()
				NewChessTools.ExitNewChessScene(true)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	self:AddBtnListener(self.okbtnBtn_, nil, function()
		NewChessTools.ExitNewChessScene(false)
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()

		if self.callback_ then
			self.callback_()
		end
	end)
end

function NewChessMenu:OnEnter()
	return
end

function NewChessMenu:RefreshUI()
	return
end

function NewChessMenu:OnExit()
	return
end

function NewChessMenu:Dispose()
	NewChessMenu.super.Dispose(self)
end

return NewChessMenu
