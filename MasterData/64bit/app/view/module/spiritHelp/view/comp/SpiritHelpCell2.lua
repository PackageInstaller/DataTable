local var_0_0 = g.core.const.ConstMgr.SpiritHelpConst
local SpiritHelpCell2 = class("SpiritHelpCell2", require("app.fairyGUI.spiritHelp.UI_SpiritHelpCell2"))
local var_0_2 = 159

function SpiritHelpCell2:ctor()
	self.getSharedTrans(self, "enter_right", "CommonShortCellList", self)

	self._doingData = nil

	self.m_costComp:setTitleNormalColor(2)
	self.m_mindBtn:addClickListener(handler(self, self._onClickCheck))
	self.m_helpBtn:addClickListener(handler(self, self._onClickHelpBtn))
end

function SpiritHelpCell2:_onClickHelpBtn()
	local var_2_0 = self._doingData:getHelpPopId()

	if var_2_0 > 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
			id = var_2_0
		}), {
			touchDisappear = true
		})
	end
end

function SpiritHelpCell2:playAllSelectEffect()
	self.m_mainComp:playAllSelectEffect()
end

function SpiritHelpCell2:_onClickCheck()
	self._doingData:setMind((self.m_mindBtn:isSelected()))
end

function SpiritHelpCell2:updateHelpCell(arg_5_1)
	self._doingData = arg_5_1

	self.m_mainComp:updateHelpCell(arg_5_1)
	self.m_stateController:setSelectedIndex(arg_5_1:getState())

	if arg_5_1:getState() == var_0_0.STATE.NORMAL then
		self:setHeight(var_0_2)
		self:updateHelpMoreView(arg_5_1)
	else
		self:setHeight(self.m_mainComp:getHeight())
	end
end

function SpiritHelpCell2:updateHelpMoreView(arg_6_1)
	self.m_addComp:initMinMaxNum({
		max = arg_6_1:getMaxCount(),
		cur = arg_6_1:getCurCount(),
		callback = handler(self, self._changeNum)
	})
	self.m_helpTipText:setText(arg_6_1:getHelpTipText())
	self.m_mindBtn:setSelected(arg_6_1:isMind())
	self:updateCost()
	self.m_helpBtn:setVisible(arg_6_1:getHelpPopId() > 0)
	self.m_hasHelpShowController:setSelectedIndex(arg_6_1:hasHelpBtn() and 1 or 0)
	self.m_hasMindController:setSelectedIndex(arg_6_1:hasMindBtn() and 1 or 0)
	self.m_hasCountController:setSelectedIndex(arg_6_1:hasCountComp() and 1 or 0)
end

function SpiritHelpCell2:_changeNum()
	self._doingData:setCurCount(self.m_addComp:getCurNum())
	self:updateCost()
	self:dispatchCompEvent("change_count_refresh")
end

function SpiritHelpCell2:updateCost()
	local var_8_0 = self._doingData:getCountCostItem()

	if var_8_0 and next(var_8_0) and var_8_0.size > 0 then
		self.m_costComp:updateByTVS(var_8_0)
		self.m_hasCostController:setSelectedIndex(1)
	else
		self.m_hasCostController:setSelectedIndex(0)
	end
end

return SpiritHelpCell2
