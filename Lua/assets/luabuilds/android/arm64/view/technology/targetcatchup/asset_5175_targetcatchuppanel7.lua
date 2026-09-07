local TargetCatchupPanel7 = class("TargetCatchupPanel7", import(".BaseTargetCatchupPanel"))

function TargetCatchupPanel7:getUIName()
	return "TargetCatchupPanel7"
end

function TargetCatchupPanel7:init()
	self.tecID = 7

	self:initData()
	self:initUI()

	return
end

return TargetCatchupPanel7
