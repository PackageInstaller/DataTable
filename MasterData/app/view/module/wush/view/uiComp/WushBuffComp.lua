local WushBuffComp = class("WushBuffComp", require("app.fairyGUI.wush.UI_WushBuffComp"))
local var_0_1 = g.core.config.dead_battle_buff_info

function WushBuffComp:ctor()
	self._buffId = 0
	self._index = 1
	self._enough = false

	self:addClickListener(handler(self, self._onClickChoose))
end

function WushBuffComp:update(arg_2_1)
	if arg_2_1 then
		self._buffId = arg_2_1.buffId or 1
	end

	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.index or 1
	end

	local var_2_1 = var_0_1.get(self._buffId)
	local var_2_2 = var_2_1.name_num / 10

	if g.core.model.User.wushData:getCurLeftStar() < var_2_1.star then
		self._enough = false

		self.m_costTxt:setText(var_2_1.star)
		self.m_costTxt:setColor(g.core.common.Color.top.RED)
	else
		self._enough = true

		self.m_costTxt:setText(var_2_1.star)
	end

	self._index = var_2_0

	self.m_attrTxt:setText(var_2_1.name)
	self.m_valTxt:setText("+" .. var_2_2 .. "%")
	self.m_buffIconLoader:setURL(g.core.common.Path:getWushBuffIconById(var_2_1.image))
	self.m_costLoader:setURL(g.core.common.Path:getItemIconById(10036, true))
end

function WushBuffComp:_onClickChoose()
	if self._enough then
		self:dispatchCompEvent("buff_choose_cell", {
			buffId = self._buffId,
			pos = self._index
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(303024))
	end
end

function WushBuffComp:doAutoAction()
	if self._enough then
		self:dispatchCompEvent("buff_choose_cell", {
			buffId = self._buffId,
			pos = self._index
		})

		return true
	else
		return false
	end
end

return WushBuffComp
