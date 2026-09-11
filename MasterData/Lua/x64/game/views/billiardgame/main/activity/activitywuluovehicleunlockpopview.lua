local ActivityWuluoVehicleUnlockPopView = class("ActivityWuluoVehicleUnlockPopView", ReduxView)

function ActivityWuluoVehicleUnlockPopView:UIName()
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_Main/Activity_WuLuo_BallUnlockPopUI"
end

function ActivityWuluoVehicleUnlockPopView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityWuluoVehicleUnlockPopView:Init()
	self:InitUI()
	self:AddUIListner()
end

function ActivityWuluoVehicleUnlockPopView:InitUI()
	self:BindCfgUI()
end

function ActivityWuluoVehicleUnlockPopView:AddUIListner()
	self:AddBtnListener(self.confirmBtn_, nil, function()
		self:Back()
		JumpTools.OpenPageByJump("activityWuluoVehicleInfoPopView", {
			unLockVehicleID = self.vehicleId_
		})
	end)
end

function ActivityWuluoVehicleUnlockPopView:OnEnter()
	self.vehicleId_ = self.params_.vehicleID
	self.params_.vehicleID = nil
	self.cfg_ = MergeBallVehicleCfg[self.vehicleId_]

	if self.cfg_ then
		self.unlockVehicleIcon_.sprite = pureGetSpriteWithoutAtlas(self.cfg_.icon)
		self.unlockVehicleName_.text = self.cfg_.name
	end
end

return ActivityWuluoVehicleUnlockPopView
