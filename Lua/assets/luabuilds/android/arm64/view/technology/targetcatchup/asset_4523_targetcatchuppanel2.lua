local TargetCatchupPanel2 = class("TargetCatchupPanel2", import(".BaseTargetCatchupPanel"))

function TargetCatchupPanel2:getUIName()
	return "TargetCatchupPanel2"
end

function TargetCatchupPanel2:init()
	self.tecID = 2

	self:initData()
	self:initUI()

	return
end

return TargetCatchupPanel2
