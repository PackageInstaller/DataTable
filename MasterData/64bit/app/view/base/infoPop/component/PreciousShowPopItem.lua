local var_0_0 = g.core.const.ConstMgr.QUALITY_TYPE
local PreciousShowSmallIconComp = class("PreciousShowSmallIconComp", require("app.fairyGUI.infoPop.UI_PreciousShowPopItem"))

function PreciousShowSmallIconComp:ctor()
	return
end

function PreciousShowSmallIconComp:updateItemComp(arg_2_1)
	local var_2_0 = g.core.config.precious_info.get(arg_2_1)
	local var_2_1 = g.core.model.User.preciousData:getPreciousSuitByAdvId(var_2_0.advance_id)

	self.m_iconComp:setIcon((g.core.common.Path:getPreciousIconByResId(var_2_0.res_id)))
	self.m_nameText:setText(var_2_0.name)

	if var_2_0.quality > var_0_0.SSR then
		self.m_iconComp:getChild("qualityzsBg"):setURL("ui://base_new/pic_gzp_zhanshidikuang" .. var_2_0.quality + 1)
		self.m_iconComp:getChild("qualityydBg"):setURL("ui://base_new/pic_gzp_wupinyuandi" .. var_2_0.quality + 1)
	else
		self.m_iconComp:getChild("qualityzsBg"):setURL("ui://base_new/pic_gzp_zhanshidikuang4")
		self.m_iconComp:getChild("qualityydBg"):setURL("ui://base_new/pic_gzp_wupinyuandi4")
	end

	self.m_suitNameText:setText((g.core.lang:get(410615, {
		name = var_2_1:getCfg().name
	})))

	local var_2_2 = g.core.config.precious_privilege_info.fetch(var_2_0.privilege_id)

	if var_2_2 then
		self.m_privilegeDesText:setText(g.core.lang:get(421215, {
			name = var_2_2.description
		}))
		self.m_hasPrivilegeController:setSelectedIndex(1)
	else
		self.m_hasPrivilegeController:setSelectedIndex(0)
	end

	self.m_qualityLoader:setURL((g.core.common.Path:getQualityArtTxtURL(var_2_0.quality)))
	self.m_nameBgLoader:setURL("ui://base_new/pic_gzp_wupin" .. var_2_0.quality + 1)

	for iter_2_0 = 1, 3 do
		self["m_smallIcon" .. iter_2_0]:updateIconComp(var_2_1:getPreciousCfgByIndex(iter_2_0).id, var_2_1:isPreciousOwnByIndex(iter_2_0))
	end
end

function PreciousShowSmallIconComp:playShowEffect(arg_3_1)
	if not arg_3_1 then
		return
	end

	local var_3_0 = self.m_iconComp:getChild("effSuccess")

	var_3_0:removeAllEffect()

	local var_3_1 = self.m_iconComp:getChild("effBg")

	var_3_1:removeAllEffect()
	var_3_0:addEffectSpine({
		remove = true,
		isLoop = false,
		name = "eff_ui_precious_success",
		anim = "play_" .. arg_3_1 + 1
	})
	var_3_1:addEffectSpine({
		remove = false,
		name = "eff_ui_precious_success",
		isLoop = true,
		anim = "loop_" .. arg_3_1 + 1
	})
end

return PreciousShowSmallIconComp
