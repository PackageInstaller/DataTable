local var_0_1 = g.core.config.knight_info
local KnightStruct = require("app.view.module.knight.model.KnightStruct")
local CrossServerArenaPowerComp = class("CrossServerArenaPowerComp", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaPowerComp"))

function CrossServerArenaPowerComp:ctor()
	self._compIndex = 0
	self._targetGroup = 0
	self._mulFormationStruct = nil

	self.m_lineupList:setVirtual()
	self.m_lineupList:setItemRenderer(handler(self, self._onRenderLineupList))
end

function CrossServerArenaPowerComp:updateComp(arg_2_1, arg_2_2)
	self._formation = arg_2_1.knight_id
	self._targetGroup = arg_2_2.targetGroup or 0
	self._knightStructArr = self:_getLineUpKnights()

	self.m_lineupList:setNumItems(6)
	self.m_powerTxt:setText(arg_2_1.fight_value or 0)
end

function CrossServerArenaPowerComp:_getLineUpKnights()
	local var_3_0 = {}

	for iter_3_0 = 1, 6 do
		if self._formation[iter_3_0] and self._formation[iter_3_0] > 0 then
			local var_3_1 = var_0_1.get(self._formation[iter_3_0])
			local var_3_2 = KnightStruct.new(var_3_1.advance_id)

			var_3_2:addCfgInfo(var_3_1)

			var_3_0[iter_3_0] = var_3_2
		end
	end

	return var_3_0
end

function CrossServerArenaPowerComp:_onRenderLineupList(arg_4_1, arg_4_2)
	if self._knightStructArr[arg_4_1 + 1] then
		arg_4_2:updateComp(arg_4_1 + 1, {
			struct = self._knightStructArr[arg_4_1 + 1]
		}, true)

		local var_4_0 = self._knightStructArr[arg_4_1 + 1]:getGroup()
		local var_4_1 = self._targetGroup == var_4_0

		arg_4_2:setCtrlState("isBuff", {
			index = self._targetGroup == var_4_0 and 1 or 0
		})

		if var_4_1 then
			arg_4_2:setCtrlState("group", {
				index = var_4_0
			})
		end
	else
		arg_4_2:updateComp(arg_4_1 + 1, nil, true)
	end
end

return CrossServerArenaPowerComp
