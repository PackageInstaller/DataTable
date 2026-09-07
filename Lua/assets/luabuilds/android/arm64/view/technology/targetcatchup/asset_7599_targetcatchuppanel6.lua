local TargetCatchupPanel6 = class("TargetCatchupPanel6", import(".BaseTargetCatchupPanel"))

function TargetCatchupPanel6:getUIName()
	return "TargetCatchupPanel6"
end

function TargetCatchupPanel6:init()
	self.tecID = 6

	self:initData()
	self:initUI()

	return
end

return TargetCatchupPanel6
