local var_0_0 = g.core.model.User.preciousData
local var_0_1 = g.core.const.ConstMgr.PreciousConst
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.const.ConstMgr.QUALITY_TYPE
local PreciousStarUpPop = class("PreciousStarUpPop", require("app.fairyGUI.precious.UI_PreciousStarUpPop"), function()
	return fgui.GComponent:create({
		pkgName = "precious",
		isFullScreen = true,
		pkgPath = "ui/precious/precious",
		resName = "PreciousStarUpPop"
	}, ...)
end)

function PreciousStarUpPop:ctor(arg_2_1)
	self:addBg("bg/precious/bg_gzp_xinxizhanshibg.png", nil, nil, 1)

	self._param = arg_2_1 or {}

	self:addClickListener(handler(self, self._onClick))
	self:_initStarUpView()
	self:_playEnterEffect()
end

function PreciousStarUpPop:_playEnterEffect()
	local var_3_0 = self._precious:getQuality()

	self.m_effTitle:addEffectSpine({
		isLoop = false,
		remove = true,
		name = "eff_ui_precious_title",
		anim = "play_" .. var_3_0 + 1
	})
	self.m_effBg:addEffectSpine({
		isLoop = true,
		name = "eff_ui_precious_success",
		anim = "loop_" .. var_3_0 + 1
	})
	self.m_effSuccess:addEffectSpine({
		isLoop = false,
		remove = true,
		name = "eff_ui_precious_success",
		anim = "play_" .. var_3_0 + 1
	})
	self.m_enterTransition:play()
end

function PreciousStarUpPop:_initStarUpView()
	local var_4_0 = var_0_0:getPreciousByAdvId(self._param.advance_id)

	self._precious = var_4_0

	self.m_starComp:initStar({
		style = 2,
		index = 4,
		gap = 0,
		max = var_0_1.STAR_MAX_NUM,
		num = var_4_0:getStar() - 1
	})

	local var_4_1 = var_4_0:getQuality()

	if var_4_1 > var_0_3.SSR then
		self.m_qualityzsBg:setURL("ui://base_new/pic_gzp_zhanshidikuang" .. var_4_1 + 1)
		self.m_qualityydBg:setURL("ui://base_new/pic_gzp_wupinyuandi" .. var_4_1 + 1)
		self.m_qualityxxzsBg:setURL("ui://base_new/pic_gzp_xinxizhanshidi" .. var_4_1 + 1)
	else
		self.m_qualityzsBg:setURL("ui://base_new/pic_gzp_zhanshidikuang4")
		self.m_qualityydBg:setURL("ui://base_new/pic_gzp_wupinyuandi4")
		self.m_qualityxxzsBg:setURL("ui://base_new/pic_gzp_xinxizhanshidi4")
	end

	self.m_qualityBgLoader:setURL(var_0_2:getPreciousQualityUrl(var_4_1))
	self.m_qualityLoader:setURL(var_0_2:getQualityArtTxtURL(var_4_1))
	self.m_preciousNameTxt:setText(var_4_0:getCfg().name)
	self.m_preciousLoader:setURL(var_0_2:getPreciousBigIconByResId(var_4_0:getCfg().res_id))

	local var_4_2 = var_4_0:getCfg()
	local var_4_3 = g.core.config.talent_skill_info.fetch(var_4_2["star_talent_" .. var_4_2.star])

	if var_4_3 then
		self.m_talentNameText:setText(g.core.lang:get(421215, {
			name = var_4_3.name
		}))
		self.m_talentDescText:setText(var_4_3.description)
	else
		self.m_talentGroup:setVisible(false)
	end

	local var_4_4 = g.core.config.precious_privilege_info
	local var_4_5 = false

	for iter_4_0, iter_4_1 in ipairs((var_4_0:getAllPreciousPrivilege())) do
		if iter_4_1.star == self._precious:getStar() then
			var_4_5 = true
		end
	end

	if var_4_5 then
		local var_4_6 = var_4_4.fetch((var_4_0:getPrivilegeId()))

		if var_4_6 then
			self.m_privilegeDescTxt:setText(var_4_6.description)
		end
	else
		self.m_privilegeGroup:setVisible(false)
	end

	self:_onPlayStarSpineEff()
end

function PreciousStarUpPop:_onPlayStarSpineEff()
	local var_5_0 = self._precious:getStar()

	self.m_starComp:addEffectToStars(var_5_0, var_5_0, {
		name = "eff_ui_knight_upstar",
		isLoop = false,
		anim = "play",
		remove = true,
		eventHandler = handler(self, self._onStarPlayFinish)
	})
end

function PreciousStarUpPop:_onStarPlayFinish(arg_6_1)
	if arg_6_1.eventData and arg_6_1.eventData.name == "cut" then
		self.m_starComp:initStar({
			type = 1,
			style = 2,
			index = 4,
			gap = 0,
			num = self._precious:getStar()
		})
	end
end

function PreciousStarUpPop:_onClick()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return PreciousStarUpPop
