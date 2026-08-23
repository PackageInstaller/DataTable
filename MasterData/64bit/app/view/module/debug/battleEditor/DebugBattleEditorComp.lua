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
	self._listCountCfg = {
		6,
		6
	}

	self:_init()
end

function DebugBattleEditorComp:_init()
	self.m_enterBtn:addClickListener(handler(self, self._onBattleBtnClicked))
	self.m_pathBtn:addClickListener(handler(self, self._onPathBtnClicked))
	self.m_exportBtn:addClickListener(handler(self, self._onExportBtnClicked))
	self.m_leftCfgBtn:addClickListener(handler(self, self._onLeftCfgBtnClicked))
	self.m_rightCfgBtn:addClickListener(handler(self, self._onRightCfgBtnClicked))
	self.m_guideBattleBtn1:addClickListener(handler(self, self._onGuideBattleBtn1Clicked))
	self.m_guideBattleBtn2:addClickListener(handler(self, self._onGuideBattleBtn2Clicked))
	self.m_leftList:setVirtual(self)
	self.m_leftList:setItemRenderer(handler(self, self._onLeftListItemRender))
	self.m_rightList:setVirtual(self)
	self.m_rightList:setItemRenderer(handler(self, self._onRightListItemRender))
end

function DebugBattleEditorComp:onLoad()
	self.m_leftList:setNumItems(self._listCountCfg[1])
	self.m_rightList:setNumItems(self._listCountCfg[2])
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
	arg_7_2:updateComp(BattleEditorData.getInstance():getGroupDatas(DebugConst.BATTLE_EDITOR_GROUP.LEFT)[arg_7_1 + 1], arg_7_1 + 1, true, (self._listCountCfg[1] == 1 or nil) and "monsterTeamInfo")
end

function DebugBattleEditorComp:_onRightListItemRender(arg_8_1, arg_8_2)
	arg_8_2:updateComp(BattleEditorData.getInstance():getGroupDatas(DebugConst.BATTLE_EDITOR_GROUP.RIGHT)[arg_8_1 + 1], arg_8_1 + 1, nil, (self._listCountCfg[2] == 1 or nil) and "monsterTeamInfo")
end

function DebugBattleEditorComp:_onBattleBtnClicked()
	local var_9_0 = {
		battleType = 2,
		type = 5,
		bgId = 111,
		cloudLoading = true,
		isVideo = false,
		skip = 2
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

function DebugBattleEditorComp:_onLeftCfgBtnClicked()
	BattleEditorData.getInstance():resetGroupDatas(0)

	local var_12_0

	if self.m_leftCfgTypeController:getSelectedIndex() == 0 then
		self._listCountCfg[1] = 1
		var_12_0 = 1
	else
		self._listCountCfg[1] = 6
		var_12_0 = 0
	end

	self.m_leftCfgTypeController:setSelectedIndex(var_12_0)
	self.m_leftList:setNumItems(self._listCountCfg[1])
	self.m_battleLayerComp:updateOneGroupPhalanx({
		group = 0
	})
end

function DebugBattleEditorComp:_onRightCfgBtnClicked()
	BattleEditorData.getInstance():resetGroupDatas(1)

	local var_13_0

	if self.m_rightCfgTypeController:getSelectedIndex() == 0 then
		self._listCountCfg[2] = 1
		var_13_0 = 1
	else
		self._listCountCfg[2] = 6
		var_13_0 = 0
	end

	self.m_rightCfgTypeController:setSelectedIndex(var_13_0)
	self.m_rightList:setNumItems(self._listCountCfg[2])
	self.m_battleLayerComp:updateOneGroupPhalanx({
		group = 1
	})
end

function DebugBattleEditorComp:receiveCompEvent(arg_14_1, arg_14_2)
	if arg_14_1 == "EVENT_CHANGE_KNIGHT" then
		if arg_14_2.ptype == "actorInfo" then
			self.m_battleLayerComp:updateOnePhalanx(arg_14_2)
		else
			self.m_battleLayerComp:updateOneGroupPhalanx(arg_14_2)
		end

		return true
	end

	return false
end

function DebugBattleEditorComp:onChangeSize(arg_15_1)
	self.m_isHideInfoController:setSelectedIndex(arg_15_1)
end

function DebugBattleEditorComp:_onGuideBattleBtn1Clicked()
	g.core.battle.BattleProxy:playTestTeamBattle(299001, 299041, true, 999)
end

function DebugBattleEditorComp:_onGuideBattleBtn2Clicked()
	g.core.battle.BattleProxy:playTestTeamBattle(299061, 299041, true, 999)
end

return DebugBattleEditorComp
