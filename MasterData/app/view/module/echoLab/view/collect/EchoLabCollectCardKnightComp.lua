local EchoLabCollectCardKnightComp = class("EchoLabCollectCardKnightComp", require("app.fairyGUI.echoLab.UI_EchoLabCollectCardKnightComp"))

function EchoLabCollectCardKnightComp:updateIcon(arg_1_1, arg_1_2)
	if g.core.common.Goods.TYPE_KNIGHT == arg_1_2 or g.core.common.Goods.TYPE_SKIN == arg_1_2 then
		self.m_topIcon:setURL(arg_1_1)
	else
		self.m_midIcon:setURL(arg_1_1)
	end

	self.m_typeController:setSelectedIndex(({
		[g.core.common.Goods.TYPE_KNIGHT] = 0,
		[g.core.common.Goods.TYPE_UNITETOKEN] = 1,
		[g.core.common.Goods.TYPE_SKIN] = 2,
		[g.core.common.Goods.TYPE_ARTIFACT] = 3,
		[g.core.common.Goods.TYPE_PET] = 4
	})[arg_1_2])
end

function EchoLabCollectCardKnightComp:updateLockCtr(arg_2_1)
	if arg_2_1 then
		self.m_isLockController:setSelectedIndex(1)
	else
		self.m_isLockController:setSelectedIndex(0)
	end
end

return EchoLabCollectCardKnightComp
