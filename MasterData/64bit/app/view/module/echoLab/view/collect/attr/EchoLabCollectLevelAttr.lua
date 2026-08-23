local EchoLabCollectLevelAttr = class("EchoLabCollectLevelAttr", require("app.fairyGUI.echoLab.UI_EchoLabCollectLevelAttr"))

function EchoLabCollectLevelAttr:ctor()
	return
end

function EchoLabCollectLevelAttr:updateView(arg_2_1)
	self.m_lastLevelText:setText(arg_2_1.lastLevel)
	self.m_levelText:setText(arg_2_1.level)
end

return EchoLabCollectLevelAttr
