local var_0_0 = g.core.model.User.roleSkinData
local RoleSkinInfoPopTalentComp = class("RoleSkinInfoPopTalentComp", require("app.fairyGUI.roleSkin.UI_RoleSkinInfoPopTalentComp"))

function RoleSkinInfoPopTalentComp:ctor()
	self._strengthenList = {}
	self._stageUpList = {}

	self.m_strengthenList:setIniter()
	self.m_strengthenList:setItemRenderer(handler(self, self._onLevelUpItemRenderer))
	self.m_stageUpList:setIniter()
	self.m_stageUpList:setItemRenderer(handler(self, self._onStageUpItemRenderer))
end

function RoleSkinInfoPopTalentComp:updateShow(arg_2_1)
	self._strengthenList = var_0_0:getLevelTalentByGroup(arg_2_1:getLevelGroup())
	self._stageUpList = arg_2_1:getStageTalentArr()

	self.m_strengthenList:setNumItems(#self._strengthenList)
	self.m_stageUpList:setNumItems(#self._stageUpList)
end

function RoleSkinInfoPopTalentComp:_onLevelUpItemRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._strengthenList[arg_3_1 + 1], true)
end

function RoleSkinInfoPopTalentComp:_onStageUpItemRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._stageUpList[arg_4_1 + 1], true)
end

return RoleSkinInfoPopTalentComp
