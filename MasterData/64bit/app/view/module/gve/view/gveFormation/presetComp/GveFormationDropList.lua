local var_0_0 = g.core.model.User.gveDataMgr
local GveFormationDropList = class("GveFormationDropList", require("app.fairyGUI.gve.UI_GveFormationDropList"))

function GveFormationDropList:ctor()
	self._startPos = 0
	self._presetFormationStruct = nil
	self._dragUniteComp = nil
	self._dragPetComp = nil

	self:initView()
end

function GveFormationDropList:initView()
	self.m_teamList:setVirtual()
	self.m_teamList:setItemRenderer(handler(self, self._onTeamListRender))
	self.m_teamList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onSubItemClick))
end

function GveFormationDropList:_onTeamListRender(arg_3_1, arg_3_2)
	arg_3_2:setTitle(g.core.lang:get(309185, {
		index = arg_3_1 + 1
	}))
end

function GveFormationDropList:_onSubItemClick(arg_4_1)
	self:dispatchCompEvent("gve_click_preset_formation_index", {
		formationIndex = arg_4_1:getDataValue() + 1
	})
end

function GveFormationDropList:updateListView()
	self.m_teamList:setNumItems(var_0_0:getGveFormationData():getPresetFormationNum())
end

function GveFormationDropList:checkPosIsInComp(arg_6_1)
	return self.m_touchComp:containPoint(arg_6_1)
end

function GveFormationDropList:setShowText(arg_7_1)
	self.m_teamText:setText(arg_7_1)
end

return GveFormationDropList
