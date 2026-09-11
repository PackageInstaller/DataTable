local MultHeartDemonOverView = class("MultHeartDemonOverView", ReduxView)

function MultHeartDemonOverView:UIName()
	return "Widget/System/Activity_Resident/Acitvity_SoloHeartDemon/SoloHeartDemon_victory"
end

function MultHeartDemonOverView:UIParent()
	return manager.ui.uiMain.transform
end

function MultHeartDemonOverView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MultHeartDemonOverView:InitUI()
	self:BindCfgUI()
end

function MultHeartDemonOverView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self.Back()
	end)
end

function MultHeartDemonOverView:Dispose()
	MultHeartDemonOverView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return MultHeartDemonOverView
