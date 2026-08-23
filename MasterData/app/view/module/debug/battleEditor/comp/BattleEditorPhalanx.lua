local BattleEditorData = require("app.view.module.debug.model.BattleEditorData")
local BattleEditorPhalanx = class("BattleEditorPhalanx", require("app.fairyGUI.debug.UI_BattleEditorPhalanx"))
local PressComp = require("app.view.module.recruit.view.comp.PressComp")

function BattleEditorPhalanx:ctor()
	self._data = nil

	self:_init()
end

function BattleEditorPhalanx:_init()
	return
end

function BattleEditorPhalanx:onLoad()
	return
end

function BattleEditorPhalanx:_onPressed()
	return
end

function BattleEditorPhalanx:updatePhalanx(arg_5_1)
	self._data = arg_5_1

	self:_updateKnight(BattleEditorData.getInstance():getGroupDatas(arg_5_1.group)[arg_5_1.pos])

	if arg_5_1.group == 1 then
		self.m_knightRoot:setScaleX(-1)
	else
		self.m_knightRoot:setScaleX(1)
	end
end

function BattleEditorPhalanx:_updateKnight(arg_6_1)
	local var_6_0 = self.m_knightRoot:displayObject()

	var_6_0:removeAllChildren()

	local var_6_1

	if not arg_6_1 then
		do return end

		var_6_1 = require("app.view.battle.BattleKnight").new
	end

	local var_6_2 = require("app.view.battle.BattleKnight").new({
		resId = arg_6_1:getBaseInfo().res_id
	})

	var_6_0:addChild(var_6_2)
	var_6_2:setPositionY(-60)
end

return BattleEditorPhalanx
