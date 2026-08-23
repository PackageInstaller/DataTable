local var_0_0 = g.core.model.User.teamBattleData
local TeamBattleBuffAttrPop = class("TeamBattleBuffAttrPop", require("app.fairyGUI.teamBattle.UI_TeamBattleBuffAttrPop"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleBuffAttrPop",
		pkgName = "teamBattle"
	})
end)

function TeamBattleBuffAttrPop:ctor()
	self:showAtCenter()
	self:_initListView()
	self:updateView()
end

function TeamBattleBuffAttrPop:_initListView()
	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onRenderAttrList))
end

function TeamBattleBuffAttrPop:_onRenderAttrList(arg_4_1, arg_4_2)
	arg_4_2:updateView(self._attrList[arg_4_1 + 1])
end

function TeamBattleBuffAttrPop:updateView()
	self._attrList = var_0_0:getMapData():getBuffAttrList()

	if #self._attrList == 0 then
		self.m_isBuffEmptyController:setSelectedIndex(1)
	else
		self.m_isBuffEmptyController:setSelectedIndex(0)
		self.m_attrList:setNumItems(#self._attrList)
	end
end

return TeamBattleBuffAttrPop
