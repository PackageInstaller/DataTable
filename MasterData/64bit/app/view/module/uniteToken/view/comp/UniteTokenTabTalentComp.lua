local var_0_0 = g.core.model.User.uniteTokenData
local UniteTokenTabTalentComp = class("UniteTokenTabTalentComp", require("app.fairyGUI.uniteToken.UI_UniteTokenTabTalentComp"))

function UniteTokenTabTalentComp:ctor()
	self._skillList = {}
	self._talentList = {}
	self._passiveList = {}

	self:_initListView()
end

function UniteTokenTabTalentComp:updateShow(arg_2_1)
	self:updateTalentInfo(arg_2_1.tokenData)
end

function UniteTokenTabTalentComp:_initListView()
	self.m_skillList:setIniter()
	self.m_skillList:setItemRenderer(handler(self, self._onRenderSkillList))
	self.m_passiveList:setIniter()
	self.m_passiveList:setItemRenderer(handler(self, self._onRenderPassiveList))
	self.m_talentList:setIniter()
	self.m_talentList:setItemRenderer(handler(self, self._onRenderTalentList))
end

function UniteTokenTabTalentComp:_onRenderSkillList(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._skillList[arg_4_1 + 1])
end

function UniteTokenTabTalentComp:_onRenderTalentList(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._talentList[arg_5_1 + 1])
end

function UniteTokenTabTalentComp:_onRenderPassiveList(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._passiveList[arg_6_1 + 1])
end

function UniteTokenTabTalentComp:updateTalentInfo(arg_7_1)
	if not arg_7_1 then
		return
	end

	self._skillList = var_0_0:getTokenSkillList((arg_7_1:getBaseId()))

	self.m_skillList:setNumItems(#self._skillList)
	self.m_skillList:resizeToFit(#self._skillList)

	self._talentList = var_0_0:getTokenUpgradeInfo(arg_7_1:getUpgradeId(), arg_7_1:getLevel(), true).talentList

	self.m_talentList:setNumItems(#self._talentList)
	self.m_talentList:resizeToFit(#self._talentList)

	self._passiveList = var_0_0:getTokenPassiveSkillList(arg_7_1:getAdvanceId(), arg_7_1:getStarLevel())

	if #self._passiveList > 0 then
		self.m_passiveList:setNumItems(#self._passiveList)
		self.m_passiveList:resizeToFit(#self._passiveList)
		self.m_showPassiveController:setSelectedIndex(1)
	else
		self.m_showPassiveController:setSelectedIndex(0)
	end
end

return UniteTokenTabTalentComp
