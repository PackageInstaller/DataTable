local TargetCatchupPanel3 = class("TargetCatchupPanel3", import(".BaseTargetCatchupPanel"))

function TargetCatchupPanel3:getUIName()
	return "TargetCatchupPanel3"
end

function TargetCatchupPanel3:init()
	self.tecID = 3

	self:initData()
	self:initUI()

	return
end

return TargetCatchupPanel3
