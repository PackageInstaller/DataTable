local AutoChessOpenCardBoxBaseItem = class("AutoChessOpenCardBoxBaseItem", ReduxView)

function AutoChessOpenCardBoxBaseItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function AutoChessOpenCardBoxBaseItem:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddListeners()
end

function AutoChessOpenCardBoxBaseItem:InitUI()
	self.GuideLineController_ = self.controller_:GetController("default0")
	self.LightController_ = self.controller_:GetController("light")
end

function AutoChessOpenCardBoxBaseItem:AddListeners()
	return
end

function AutoChessOpenCardBoxBaseItem:SetData()
	return
end

function AutoChessOpenCardBoxBaseItem:SetGuideState(arg_6_1)
	self.GuideLineController_:SetSelectedState(arg_6_1)
end

function AutoChessOpenCardBoxBaseItem:PlayAnim(arg_7_1)
	if arg_7_1 then
		AnimatorTools.PlayAnimatorWithCallback(self.anim_, "Activity_Unpack_CardAni_Open", arg_7_1, false, 0, 0)
	else
		self.anim_:Play("Activity_Unpack_CardAni_Open", 0, 0)
	end
end

function AutoChessOpenCardBoxBaseItem:SetActive(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

function AutoChessOpenCardBoxBaseItem:SetLightState(arg_9_1)
	self.LightController_:SetSelectedState(arg_9_1 and "show" or "hide")
end

function AutoChessOpenCardBoxBaseItem:StopTimer()
	AnimatorTools.Stop()
end

function AutoChessOpenCardBoxBaseItem:OnExit()
	self.anim_:Rebind()
end

function AutoChessOpenCardBoxBaseItem:Dispose()
	self:StopTimer()
	AutoChessOpenCardBoxBaseItem.super.Dispose(self)
end

return AutoChessOpenCardBoxBaseItem
