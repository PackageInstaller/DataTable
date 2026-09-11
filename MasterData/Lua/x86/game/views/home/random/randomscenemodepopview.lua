local RandomSceneModePopView = class("RandomSceneModePopView", ReduxView)

function RandomSceneModePopView:UIName()
	return "Widget/System/Random/RandomScenePopUI"
end

function RandomSceneModePopView:UIParent()
	return manager.ui.uiPop.transform
end

function RandomSceneModePopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RandomSceneModePopView:InitUI()
	self:BindCfgUI()
end

function RandomSceneModePopView:AddUIListener()
	for iter_5_0 = 1, 3 do
		self:AddToggleListener(self["connect" .. iter_5_0 .. "Tgl_"], function(arg_6_0)
			if arg_6_0 then
				self.connectType = iter_5_0 - 1
			end
		end)
	end

	self:AddBtnListener(self.yesBtn_, nil, function()
		if self.connectType and self.connectType ~= self.params_.type then
			HomeSceneSettingAction.SetRandomMode(self.connectType, function()
				JumpTools.Back()
			end)
		end

		if self.connectType == self.params_.type then
			JumpTools.Back()
		end
	end)
	self:AddBtnListener(self.noBtn_, nil, function()
		JumpTools.Back()
	end)
end

function RandomSceneModePopView:OnEnter()
	self.connectType = self.params_.type
	self.connectType = math.min(HomeSceneSettingConst.RANDOM_MODE.COUNT - 1, self.connectType)
	self["connect" .. self.connectType + 1 .. "Tgl_"].isOn = true
end

function RandomSceneModePopView:OnExit()
	return
end

function RandomSceneModePopView:Dispose()
	self.params_ = nil

	RandomSceneModePopView.super.Dispose(self)
end

return RandomSceneModePopView
