local var_0_0 = g.core.model.User.gveDataMgr
local GveBossAttrComp = class("GveBossAttrComp", require("app.fairyGUI.gve.UI_GveBossAttrComp"))

function GveBossAttrComp:ctor()
	self._bossCfg = nil
	self._bossData = nil

	self.m_detailBtn:addClickListener(handler(self, self._onDetailClick))
end

function GveBossAttrComp:updateAttr(arg_2_1, arg_2_2)
	self._bossCfg = arg_2_1
	self._bossData = arg_2_2

	if arg_2_2:isAllMonsterDead() then
		self:updateBossAttr(arg_2_1)
	else
		self:updateMonsterAttr(arg_2_1)
	end
end

function GveBossAttrComp:updateMonsterAttr(arg_3_1)
	local var_3_2

	if arg_3_1.attr_dec_time == 0 then
		self.m_detailBtn:setVisible(false)

		var_3_2 = 0
	else
		var_3_2 = math.max(arg_3_1.attr_dec_min, arg_3_1.initial_attr - arg_3_1.attr_dec_ratio * math.floor((g.core.common.ServerTime:getTime() - var_0_0:getMyFirstEnterTime()) / arg_3_1.attr_dec_time)) / 10
	end

	self.m_attrTxt:enableRich()
	self.m_attrTxt:setText(g.core.lang:get(309193, {
		num = var_3_2
	}))
end

function GveBossAttrComp:updateBossAttr(arg_4_1)
	local var_4_0

	if arg_4_1.attr_dec_time == 0 then
		var_4_0 = 0

		self.m_detailBtn:setVisible(false)
	else
		var_4_0 = math.max(arg_4_1.attr_dec_min, arg_4_1.initial_attr - arg_4_1.attr_dec_ratio * math.floor((g.core.common.ServerTime:getTime() - var_0_0:getMyFirstEnterTime()) / arg_4_1.attr_dec_time)) / 10
	end

	self.m_attrTxt:enableRich()
	self.m_attrTxt:setText(g.core.lang:get(309193, {
		num = var_4_0
	}))
end

function GveBossAttrComp:_onDetailClick()
	local var_5_0 = not not (self._bossData and self._bossData:isAllMonsterDead())

	g.core.module.ModuleManager:pushPopup((require("app.view.module.gve.view.gveStage.GveBossAttrPop").new({
		cfg = self._bossCfg,
		isBoss = var_5_0
	})))
end

return GveBossAttrComp
