local StormBigWorldMapComp = class("StormBigWorldMapComp", require("app.fairyGUI.storm.UI_StormBigWorldMapComp"))

function StormBigWorldMapComp:ctor()
	self:getScrollPane():setPercX(0.5)
	self:getScrollPane():setPercY(0.5)
end

function StormBigWorldMapComp:onLoad()
	return
end

return StormBigWorldMapComp
