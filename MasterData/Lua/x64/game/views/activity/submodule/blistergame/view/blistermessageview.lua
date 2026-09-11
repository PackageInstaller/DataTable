local BlisterMessageView = class("BlisterMessageView", ReduxView)

function BlisterMessageView:Init()
	self:InitUI()

	self.nodeList = {}

	self:AddListeners()
end

function BlisterMessageView:InitUI()
	self:BindCfgUI()
end

function BlisterMessageView:UIParent()
	return manager.ui.uiPop.transform
end

function BlisterMessageView:UIName()
	return "Widget/System/Summer2024/Summer2024_Bubble/BubbleresultPop02UI"
end

function BlisterMessageView:AddListeners()
	self:AddBtnListener(self.suminibtn01Btn_, nil, function()
		self:Back()
		BlisterGameTool.ReStartGame()
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.suminibtn02Btn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.suminibtn03Btn_, nil, function()
		self:Back()

		if self.params_ and self.params_.OkCallback then
			self.params_.OkCallback()
		end
	end)
end

function BlisterMessageView:OnEnter()
	BlisterMessageView.super.OnEnter(self)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.btncontentTrs_)
end

function BlisterMessageView:OnExit()
	BlisterMessageView.super.OnExit(self)
	BlisterGameLuaBridge.PauseGame()
end

function BlisterMessageView:Dispose()
	BlisterMessageView.super.Dispose(self)
end

return BlisterMessageView
