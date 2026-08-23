local SpireBossDetailPanel = class("SpireBossDetailPanel", require("app.fairyGUI.spire.UI_SpireBossDetailPanel"))

function SpireBossDetailPanel:ctor()
	self._skillList = nil
	self._buffList = nil

	self:_initPanel()
end

function SpireBossDetailPanel:_initPanel()
	self.m_skillList:setVirtual(self)
	self.m_skillList:setItemRenderer(handler(self, self._onRenderSkillItem))
	self.m_buffList:setVirtual(self)
	self.m_buffList:setItemRenderer(handler(self, self._onRenderBuffItem))
end

function SpireBossDetailPanel:_onRenderSkillItem(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._skillList[arg_3_1 + 1])
	arg_3_2:openClick()
end

function SpireBossDetailPanel:_onRenderBuffItem(arg_4_1, arg_4_2)
	arg_4_2:getChild("title"):enableRich()

	local var_4_0, var_4_1 = g.core.utils.String.formatPassiveSkillDesc(self._buffList[arg_4_1 + 1].cfg.buff)

	arg_4_2:setTitle(var_4_0)
end

function SpireBossDetailPanel:updatePanel(arg_5_1)
	self.m_bossDesTxt:setText(arg_5_1:getCfg().boss_desc)

	self._skillList = arg_5_1:getShowSkillList()

	self.m_skillList:setNumItems(#self._skillList)

	self._buffList = arg_5_1:getBossBuffList()

	self.m_buffList:setNumItems(#self._buffList)
	self:_updateBuffListSizeByItem()
end

function SpireBossDetailPanel:_updateBuffListSizeByItem()
	local var_6_0 = self.m_buffList:getSize()

	self._tempHeight = 0

	local var_6_1 = self.m_buffList:getChildren()[1]

	for iter_6_0 = 1, #self._buffList do
		self:_onRenderBuffItem(iter_6_0 - 1, var_6_1)

		self._tempHeight = var_6_1:getSize().height + 10 + self._tempHeight
	end

	var_6_0.height = self._tempHeight

	self.m_buffList:setSize(var_6_0)
	self.m_skillList:setNumItems(#self._buffList)
end

return SpireBossDetailPanel
