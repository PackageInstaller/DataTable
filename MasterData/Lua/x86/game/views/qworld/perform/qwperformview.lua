local QWPerformView = class("QWPerformView", ReduxView)

function QWPerformView:UIName()
	return "Widget/System/SandPlay/SandPlay_Furniture/SandPlay_InFurniture_HUDUI"
end

function QWPerformView:UIParent()
	return manager.ui.uiMain.transform
end

function QWPerformView:Init()
	self:InitUI()
end

function QWPerformView:InitUI()
	self:BindCfgUI()

	self.isInView = false

	self:AddUIListener()
end

function QWPerformView:AddUIListener()
	self:AddBtnListener(self.exitBtn_, nil, function()
		self:ExitPerform()
	end)
	self:RegistEventListener(QWORLD_ENTER_PERFORM, function(arg_7_0)
		if not arg_7_0 and self.isInView then
			self:Back()
		end
	end)
end

function QWPerformView:OnEnter()
	CursorTools.LuaSwitchCursor(false)

	self.isInView = true
end

function QWPerformView:OnExit()
	CursorTools.LuaSwitchCursor(true)

	self.isInView = false
end

function QWPerformView:ExitPerform()
	QWorldMgr:GetQWorldPerformMgr():ForceStopPlayerPerform()
end

function QWPerformView:Dispose()
	QWPerformView.super.Dispose(self)
end

return QWPerformView
