local TargetCatchupPanel5 = class("TargetCatchupPanel5", import(".BaseTargetCatchupPanel"))

function TargetCatchupPanel5:getUIName()
	return "TargetCatchupPanel5"
end

function TargetCatchupPanel5:init()
	self.tecID = 5

	self:initData()
	self:initUI()

	return
end

return TargetCatchupPanel5
