local var_0_0 = g.core.model.User.gveDataMgr
local GveBossAttrPop = class("GveBossAttrPop", require("app.fairyGUI.gve.UI_GveBossAttrPop"), function()
	return fgui.GComponent:create({
		resName = "GveBossAttrPop",
		pkgPath = "ui/gve/gve",
		pkgName = "gve"
	}, ...)
end)

function GveBossAttrPop:ctor(arg_2_1)
	self:showAtCenter()

	self._params = arg_2_1
end

function GveBossAttrPop:onLoad()
	if self._params.isBoss then
		self:updateBossView(self._params.cfg)
	else
		self:updateMonsterView(self._params.cfg)
	end
end

function GveBossAttrPop:updateBossView(arg_4_1)
	local var_4_0 = var_0_0:getMyFirstEnterTime()
	local var_4_1 = math.ceil((g.core.common.ServerTime:getTime() - var_4_0) / arg_4_1.attr_dec_time)

	self.m_timeText:setText(g.core.lang:get(309196, {
		time = g.core.common.ServerTime:getLeftDHMSFormat(var_4_0 + var_4_1 * arg_4_1.attr_dec_time)
	}))

	local var_4_2 = arg_4_1.initial_attr - arg_4_1.attr_dec_ratio * (var_4_1 - 1)

	if arg_4_1.initial_attr - arg_4_1.attr_dec_ratio * (var_4_1 - 1) <= arg_4_1.attr_dec_min then
		var_4_2 = arg_4_1.attr_dec_min

		self.m_timeText:setVisible(false)
	else
		self.m_timeText:setVisible(true)
	end

	self.m_descTxt:getChild("title"):enableRich()
	self.m_descTxt:setTitle(g.core.lang:get(309194, {
		name = arg_4_1.name,
		num = var_4_2 / 10
	}))
	self.m_bottomText:setText(g.core.lang:get(309195, {
		num = arg_4_1.attr_dec_min / 10
	}))
end

function GveBossAttrPop:updateMonsterView(arg_5_1)
	local var_5_0 = var_0_0:getMyFirstEnterTime()
	local var_5_1 = math.ceil((g.core.common.ServerTime:getTime() - var_5_0) / arg_5_1.attr_dec_time)

	self.m_timeText:setText(g.core.lang:get(309196, {
		time = g.core.common.ServerTime:getLeftDHMSFormat(var_5_0 + var_5_1 * arg_5_1.attr_dec_time)
	}))

	local var_5_2 = arg_5_1.initial_attr - arg_5_1.attr_dec_ratio * (var_5_1 - 1)

	if arg_5_1.initial_attr - arg_5_1.attr_dec_ratio * (var_5_1 - 1) <= arg_5_1.attr_dec_min then
		var_5_2 = arg_5_1.attr_dec_min

		self.m_timeText:setVisible(false)
	else
		self.m_timeText:setVisible(true)
	end

	self.m_descTxt:getChild("title"):enableRich()
	self.m_descTxt:setTitle(g.core.lang:get(309197, {
		num = var_5_2 / 10
	}))
	self.m_bottomText:setText(g.core.lang:get(309195, {
		num = arg_5_1.attr_dec_min / 10
	}))
end

return GveBossAttrPop
