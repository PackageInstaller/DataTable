local BattleEditorData = require("app.view.module.debug.model.BattleEditorData")
local BattleEditorLayerComp = class("BattleEditorLayerComp", require("app.fairyGUI.debug.UI_BattleEditorLayerComp"))

function BattleEditorLayerComp:create()
	return BattleEditorLayerComp.new()
end

function BattleEditorLayerComp:ctor()
	self._datas = {
		left = {},
		right = {}
	}

	self:_init()
end

function BattleEditorLayerComp:_init()
	for iter_3_0 = 1, 4 do
		self["m_leftUnitSkillIcon" .. iter_3_0]:setIdentity(1)
		self["m_leftUnitSkillIcon" .. iter_3_0]:setSkillPos(iter_3_0)
	end

	for iter_3_1 = 1, 4 do
		self["m_rightUnitSkillIcon" .. iter_3_1]:setIdentity(2)
		self["m_rightUnitSkillIcon" .. iter_3_1]:setSkillPos(iter_3_1)
	end
end

function BattleEditorLayerComp:onLoad()
	print("BattleEditorLayerComp:onLoad")
	g.core.event.EventManager:addEventListener("EVENT_CHANGE_UNITE", handler(self, self.updateCombos), self)
end

function BattleEditorLayerComp:onUnload()
	print("BattleEditorLayerComp:onUnload")
end

function BattleEditorLayerComp:updateAllPhalanx(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		self:updateOnePhalanx(iter_6_1)
	end
end

function BattleEditorLayerComp:updateOneGroupPhalanx(arg_7_1)
	for iter_7_0 = 1, 6 do
		self:updateOnePhalanx({
			pos = iter_7_0,
			group = arg_7_1.group
		})
	end
end

function BattleEditorLayerComp:updateOnePhalanx(arg_8_1)
	local var_8_0 = "left"

	if arg_8_1.group == 1 then
		var_8_0 = "right"
	end

	self._datas[var_8_0][arg_8_1.pos] = arg_8_1

	self["m_" .. var_8_0 .. "Phalanx" .. arg_8_1.pos]:updatePhalanx(arg_8_1)
end

function BattleEditorLayerComp:updateCombos()
	local var_9_0 = BattleEditorData.getInstance():getUnitDataList(1)

	for iter_9_0 = 1, 4 do
		self["m_leftUnitSkillIcon" .. iter_9_0]:updateTokenFormatIcon(var_9_0[iter_9_0])
	end

	local var_9_1 = BattleEditorData.getInstance():getUnitDataList(2)

	for iter_9_1 = 1, 4 do
		self["m_rightUnitSkillIcon" .. iter_9_1]:updateTokenFormatIcon(var_9_1[iter_9_1])
	end
end

return BattleEditorLayerComp
