local var_0_0 = g.core.model.User.echoLabData
local EchoLabTreeLineComp = class("EchoLabTreeLineComp", require("app.fairyGUI.echoLab.UI_EchoLabTreeLineComp"))

function EchoLabTreeLineComp:ctor()
	self._talentId = 0
	self._activeEffect = nil
	self._preLineController = self.m_preLine:getController("line")
	self._nextLineController = self.m_nextLine:getController("line")
	self._preUnlockController = self.m_preLine:getController("isUnlock")
	self._nextUnlockController = self.m_nextLine:getController("isUnlock")
end

function EchoLabTreeLineComp:refreshComp()
	if self._talentId > 0 then
		self:updateCompByStruct(var_0_0:getTreeData():getTalentById(self._talentId))
	end
end

function EchoLabTreeLineComp:updateCompByStruct(arg_3_1)
	self._talentId = arg_3_1:getId()

	self:updateLine(arg_3_1)
	self.m_nodeTypeController:setSelectedIndex(arg_3_1:getNodeType())
end

function EchoLabTreeLineComp:updateLine(arg_4_1)
	self._preLineController:setSelectedIndex(arg_4_1:getPreLineType())
	self._nextLineController:setSelectedIndex(arg_4_1:getNextLineType())
	self._preUnlockController:setSelectedIndex(arg_4_1:getPreIsUnlock() and 1 or 0)

	local var_4_0 = arg_4_1:getNextTalentList()

	if var_4_0[1] then
		local var_4_1 = var_4_0[1]:getPreTalentList()

		if #var_4_1 == 2 then
			local var_4_2 = true

			for iter_4_0, iter_4_1 in ipairs(var_4_1) do
				if not iter_4_1:isActive() then
					var_4_2 = false

					break
				end
			end

			self._nextUnlockController:setSelectedIndex(var_4_2 and 1 or 0)
		else
			self._nextUnlockController:setSelectedIndex(arg_4_1:isActive() and 1 or 0)
		end
	end
end

return EchoLabTreeLineComp
