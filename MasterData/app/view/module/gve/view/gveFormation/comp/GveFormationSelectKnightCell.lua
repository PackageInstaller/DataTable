local var_0_1 = g.core.model.User.gveDataMgr
local GveFormationSelectKnightCell = class("GveFormationSelectKnightCell", require("app.fairyGUI.gve.UI_GveFormationSelectKnightCell"))
local var_0_3 = {
	pos = 2,
	pool = 1
}

function GveFormationSelectKnightCell:ctor()
	self._curIndex = nil
	self._cellType = var_0_3.pos
	self._knightData = nil

	self.getSharedTrans(self, "listIconUiScaleIn", "ItemBagList", self)
	self:addClickListener(handler(self, self._onClickCell))
	self.m_knightIcon:setTouchable(false)
	self.m_starComp:initStar({
		gap = -10,
		style = 2,
		type = 1,
		index = 3,
		num = 0
	})
end

function GveFormationSelectKnightCell:updateEquipCell(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self._knightData = nil

	local var_2_0 = arg_2_1 or {}
	local var_2_1 = var_2_0.knight

	self._curIndex = arg_2_2
	self._cellType = var_0_3.pos
	self._callback = arg_2_4

	if arg_2_2 > var_0_1:getGveFormationData():getPosCurNum() then
		self.m_stateController:setSelectedIndex(3)
		self.m_isShowActionController:setSelectedIndex(0)

		return
	end

	self.m_isShowActionController:setSelectedIndex(1)

	if arg_2_2 == arg_2_3 and not var_2_1 then
		self.m_stateController:setSelectedIndex(2)
	else
		self.m_stateController:setSelectedIndex(0)
	end

	self._knightData = var_2_1

	if var_2_1 then
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_knightIcon:updateIcon({
			struct = var_2_1
		})
		self.m_starComp:setStarNum(var_2_1:getStarLv())
		self.m_knightGroupController:setSelectedIndex(var_2_1:getGroup() - 1)
	else
		self.m_isEmptyController:setSelectedIndex(1)

		if var_0_1:getGveFormationData():hasKnightCanEquip() then
			-- block empty
		end
	end

	self.m_actionValueText:setText(var_2_0.action or 0)
end

function GveFormationSelectKnightCell:updatePoolCell(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self._knightData = nil
	self._curIndex = arg_3_2
	self._cellType = var_0_3.pool
	self._callback = arg_3_4

	if arg_3_1 then
		self.m_knightIcon:updateIcon({
			struct = arg_3_1
		})
		self.m_starComp:setStarNum(arg_3_1:getStarLv())
		self.m_knightGroupController:setSelectedIndex(arg_3_1:getGroup() - 1)
	end

	if arg_3_3[arg_3_2] == true then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

function GveFormationSelectKnightCell:_onClickCell()
	if self._knightData ~= nil then
		return
	end

	if self._cellType == var_0_3.pos then
		if var_0_1:getGveFormationData():getPosCurNum() < self._curIndex then
			g.core.module.ModuleManager:tip(g.core.lang:get(309023))

			return
		end

		if self._callback then
			self._callback("cell_equip_pos", {
				pos = self._curIndex
			})
		end
	elseif self._callback then
		self._callback("cell_select_pos", {
			pos = self._curIndex
		})
	end
end

return GveFormationSelectKnightCell
