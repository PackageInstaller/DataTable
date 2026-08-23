local var_0_0 = g.core.model.User.halfAnniversaryData
local var_0_1 = g.core.const.ConstMgr.HalfAnniversaryConst
local var_0_2 = g.core.common.Goods
local CommonKnight = require("app.view.common.CommonKnight")
local HalfAnniversaryPointComp = class("HalfAnniversaryPointComp", require("app.fairyGUI.halfAnniversary.UI_HalfAnniversaryPointComp"))

function HalfAnniversaryPointComp:ctor()
	self._commonKnight = nil

	self:addClickListener(handler(self, self._onClickAwardComp))
end

function HalfAnniversaryPointComp:updatePointComp(arg_2_1, arg_2_2)
	self._pointInfo = arg_2_1
	self._index = arg_2_2
	self._cfg = var_0_0:getMapPointAwardsCfg()
	self._activityCfg = var_0_0:getHalfYearActivityCfg()

	local var_2_0 = var_0_2:convert({
		type = var_0_2.TYPE_ITEM,
		value = self._activityCfg.item_id
	})

	if var_2_0 then
		self.m_scoreLoader:setURL(var_2_0.icon_mini)
	end

	self.m_isEndController:setSelectedIndex(#self._cfg == self._index and 1 or 0)
	self.m_scoreNumTxt:setText(self._pointInfo.need_point)

	self._awards = var_0_2:convert({
		type = self._pointInfo.reward_type_1,
		value = self._pointInfo.reward_value_1
	})

	self.m_awardIconComp:setIcon(self._awards.icon)
	self.m_countTxt:setText("×" .. self._pointInfo.reward_size_1)

	self._isAward = var_0_0:isGetScoreAward(self._cfg[self._index].id)

	self.m_stateController:setSelectedIndex(self._isAward and 1 or 0)
	self.m_typeController:setSelectedIndex(self._activityCfg.id)
	self.m_onlyShowRoleController:setSelectedIndex(0)

	if self._activityCfg.id == var_0_1.SPECIAL_ID and #self._cfg == self._index then
		self.m_onlyShowRoleController:setSelectedIndex(1)
		self:_onCreateKnight()
	end
end

function HalfAnniversaryPointComp:_onCreateKnight()
	if not self._commonKnight then
		self._commonKnight = CommonKnight.new({
			scale = 0.7,
			resId = g.core.config.knight_base_info.get(self._pointInfo.reward_value_1).fight_id
		})

		self.m_rolePlaceHolder:addChild(self._commonKnight)
	end
end

function HalfAnniversaryPointComp:_onClickAwardComp()
	if self._isAward then
		g.core.module.ModuleManager:tip(g.core.lang:get(408203))

		return
	else
		g.core.common.GlobalFunc.pushInfoPop(self._awards)
	end
end

return HalfAnniversaryPointComp
