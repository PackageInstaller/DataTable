local BattleEditorData = require("app.view.module.debug.model.BattleEditorData")
local GMComp = class("GMComp", require("app.fairyGUI.debug.UI_DebugBattleEditorCellComp"))

function GMComp:ctor()
	self._data = nil

	self:_init()
end

function GMComp:_init()
	self:addListen(self.m_searchComp)
end

function GMComp:onLoad()
	return
end

function GMComp:updateComp(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self._data = {
		pos = arg_4_2,
		group = arg_4_3 and 0 or 1
	}

	self.m_searchComp:updatePaths(arg_4_4)

	if arg_4_1 then
		self.m_searchComp:setShowText(arg_4_1:getBaseInfo().name .. "_" .. arg_4_1:getBaseId())
	end

	self.m_title:setText(arg_4_2)
end

function GMComp:receiveCompEvent(arg_5_1, arg_5_2)
	if arg_5_1 == "EVENT_DEBUG_INPUT_CHANGE" then
		local var_5_0 = self.m_searchComp:getCurId()

		if arg_5_2 == "actorInfo" then
			BattleEditorData.getInstance():updateBattleDatas((var_5_0 or nil) and BattleEditorData.getInstance():getKnightStructByResId(tonumber(var_5_0)), self._data.pos, self._data.group)
		elseif arg_5_2 == "monsterTeamInfo" then
			for iter_5_0 = 1, 6 do
				BattleEditorData.getInstance():updateBattleDatas(((var_5_0 or nil) and BattleEditorData.getInstance():getKnightStructsByTeamId(tonumber(var_5_0), self._data.group))[iter_5_0], iter_5_0, self._data.group)
			end
		end

		local var_5_3 = clone(self._data)

		var_5_3.pType = arg_5_2

		self:dispatchCompEvent("EVENT_CHANGE_KNIGHT", var_5_3)
	end

	return false
end

return GMComp
