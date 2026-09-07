local TargetCatchupPanel1 = class("TargetCatchupPanel1", import(".BaseTargetCatchupPanel"))

function TargetCatchupPanel1:getUIName()
	return "TargetCatchupPanel1"
end

function TargetCatchupPanel1:init()
	self.tecID = 1

	self:initData()
	self:initUI()

	return
end

return TargetCatchupPanel1
