local TargetCatchupPanel4 = class("TargetCatchupPanel4", import(".BaseTargetCatchupPanel"))

function TargetCatchupPanel4:getUIName()
	return "TargetCatchupPanel4"
end

function TargetCatchupPanel4:init()
	self.tecID = 4

	self:initData()
	self:initUI()

	return
end

return TargetCatchupPanel4
