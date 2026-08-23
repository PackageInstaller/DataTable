local DebugConst = require("app.view.module.debug.const.DebugConst")
local BattleEditorData = require("app.view.module.debug.model.BattleEditorData")
local BattlePath = require("app.view.battle.BattlePath")
local DebugBattleEditorComp = class("DebugBattleEditorComp", require("app.fairyGUI.debug.UI_DebugBattleEditorComp"))

function DebugBattleEditorComp:create()
	return DebugBattleEditorComp.new()
end

function DebugBattleEditorComp:ctor()
	self._tabIndex = -1
	self._subComps = {}

	self:_init()
end

function DebugBattleEditorComp:_init()
	self.m_enterBtn:addClickListener(handler(self, self._onBattleBtnClicked))
	self.m_pathBtn:addClickListener(handler(self, self._onPathBtnClicked))
	self.m_exportBtn:addClickListener(handler(self, self._onExportBtnClicked))
	self.m_leftList:setVirtual(self)
	self.m_leftList:setItemRenderer(handler(self, self._onLeftListItemRender))
	self.m_rightList:setVirtual(self)
	self.m_rightList:setItemRenderer(handler(self, self._onRightListItemRender))
end

function DebugBattleEditorComp:onLoad()
	self.m_leftList:setNumItems(6)
	self.m_rightList:setNumItems(6)
end

function DebugBattleEditorComp:onUnload()
	return
end

function DebugBattleEditorComp:close()
	if self._curComp then
		self._curComp:onHide()
	end

	g.core.module.ModuleManager:popComponent()
end

function DebugBattleEditorComp:_onLeftListItemRender(arg_7_1, arg_7_2)
	arg_7_2:updateComp(BattleEditorData.getInstance():getGroupDatas(DebugConst.BATTLE_EDITOR_GROUP.LEFT)[arg_7_1 + 1], arg_7_1 + 1, true)
end

function DebugBattleEditorComp:_onRightListItemRender(arg_8_1, arg_8_2)
	arg_8_2:updateComp(BattleEditorData.getInstance():getGroupDatas(DebugConst.BATTLE_EDITOR_GROUP.RIGHT)[arg_8_1 + 1], arg_8_1 + 1)
end

function DebugBattleEditorComp:_onBattleBtnClicked()
	local var_9_0 = {
		battleType = 2,
		isVideo = false,
		skip = 2,
		cloudLoading = true
	}

	var_9_0.report = BattleEditorData.getInstance():getBattleReport()

	g.core.battle.BattleProxy:enterBattle(var_9_0)
end

function DebugBattleEditorComp:_onPathBtnClicked()
	return
end

function DebugBattleEditorComp:_onExportBtnClicked()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.debug.pop.BattleReportFilePop").new())
end

function DebugBattleEditorComp:receiveCompEvent(arg_12_1, arg_12_2)
	if arg_12_1 == "EVENT_CHANGE_KNIGHT" then
		self.m_battleLayerComp:updateOnePhalanx(arg_12_2)

		return true
	end

	return false
end

function DebugBattleEditorComp:onChangeSize(arg_13_1)
	self.m_isHideInfoController:setSelectedIndex(arg_13_1)
end

return DebugBattleEditorComp
