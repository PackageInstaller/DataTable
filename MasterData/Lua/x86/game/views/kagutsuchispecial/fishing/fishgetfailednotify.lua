local FishGetFailedNotify = class("FishGetFailedNotify", ReduxView)

function FishGetFailedNotify:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionFishingUI/JapanRegionFishingLosePopUI"
end

function FishGetFailedNotify:UIParent()
	return manager.ui.uiPop.transform
end

function FishGetFailedNotify:Init()
	self:BindCfgUI()
	self:AddBtnListener(self.okBtn_, nil, JumpTools.Back)
end

function FishGetFailedNotify:OnEnter()
	return
end

return FishGetFailedNotify
