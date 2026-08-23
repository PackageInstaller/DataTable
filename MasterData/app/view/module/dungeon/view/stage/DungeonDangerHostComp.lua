local var_0_0 = g.core.model.User.rebelData
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.config.knight_base_info
local var_0_3 = g.core.module.ModuleManager
local DungeonDangerHostComp = class("DungeonDangerHostComp", require("app.fairyGUI.dungeon.UI_DungeonDangerHostComp"))

function DungeonDangerHostComp:ctor()
	self:setVisible(false)
	self:addClickListener(handler(self, self._onTouchClick))
end

function DungeonDangerHostComp:updateState()
	local var_2_0 = var_0_0:getRebelArr()

	if var_2_0 and #var_2_0 > 0 then
		if var_2_0[#var_2_0] then
			self.m_bossIcon:setIcon((var_0_1:getKnightIconById(var_0_2.get(var_2_0[#var_2_0]:getBaseInfo().res).icon_id)))
			self:setVisible(true)
		end
	else
		self:setVisible(false)
	end
end

function DungeonDangerHostComp:hide()
	self:setVisible(false)
end

function DungeonDangerHostComp:_onTouchClick()
	var_0_3:pushModule(g.view.entrance.REBEL)
end

return DungeonDangerHostComp
