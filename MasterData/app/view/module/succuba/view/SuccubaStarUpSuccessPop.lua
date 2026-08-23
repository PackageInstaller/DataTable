local var_0_0 = g.core.const.ConstMgr.SuccubaConst
local var_0_1 = g.core.model.User.succubaData
local DrawSuccuba = require("app.view.common.DrawSuccuba")
local SuccubaStarUpSuccessPop = class("SuccubaStarUpSuccessPop", require("app.fairyGUI.succuba.UI_SuccubaStarUpSuccessPop"), function()
	return fgui.GComponent:create({
		resName = "SuccubaStarUpSuccessPop",
		pkgPath = "ui/succuba/succuba",
		isFullScreen = true,
		pkgName = "succuba"
	}, ...)
end)

function SuccubaStarUpSuccessPop:ctor(arg_2_1)
	self._succubaStruct = nil

	self:showAtCenter()
	self:_initView(arg_2_1)
	self:_initBtn()
end

function SuccubaStarUpSuccessPop:onLoad()
	self.m_enterTransition:setHook("upGrade", handler(self, self._onPlayEnterSpineEff))
	self.m_enterTransition:setHook("starup", handler(self, self._onPlayStarSpineEff))
	self.m_enterTransition:setHook("starline", handler(self, self.playStarLineEff))
	self.m_enterTransition:play()
end

function SuccubaStarUpSuccessPop:_initBtn()
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClick))
end

function SuccubaStarUpSuccessPop:_initView(arg_5_1)
	if not arg_5_1 or not arg_5_1.advId then
		return
	end

	local var_5_0 = var_0_1:getSuccubaByAdvanceId(arg_5_1.advId)

	if not var_5_0 then
		return
	end

	self._succubaStruct = var_5_0

	local var_5_1 = var_5_0:getCurStarCfg()

	self.m_bgComp:initData({
		title = g.core.lang:get(201105),
		englishTitle = g.core.lang:get(201106),
		quality = var_5_1.quality,
		idleEff = {
			anim = "play",
			name = "eff_ui_succuba_idleEff"
		}
	})
	self.m_spineHolder:removeChildren()

	self._drawSuccuba = DrawSuccuba.new({
		showCfg = var_5_0:getShowCfg()
	})

	self._drawSuccuba:setPosition(200, 250)
	self.m_spineHolder:addChild(self._drawSuccuba)
	self.m_starComp:initStar({
		gap = 0,
		style = 2,
		type = 1,
		index = 4,
		num = var_5_1.star - 1
	})

	for iter_5_0 = 1, 4 do
		self["m_attrComp" .. iter_5_0]:updateAttr({
			isShowAnima = true,
			iconType = 2,
			type = var_0_0.STAR_ATTR_TYPE[iter_5_0].type,
			value = var_5_1[var_0_0.STAR_ATTR_TYPE[iter_5_0].key]
		})
	end

	self.m_attrComp5:updateAttr({
		iconRes = "icon/attrIcon/icon_meilizhi_2.png",
		isShowAnima = true,
		name = g.core.lang:get(431008),
		value = var_5_0:getStarCharm(var_5_1.star)
	})
	self.m_skillIcon1:updateIcon({
		skillId = var_5_1.skill_id
	})
	self.m_skillLvText1:setText(g.core.config.skill_info.get(var_5_1.skill_id).level)
	self.m_skillIcon2:updateIcon({
		isPassive = true,
		skillId = var_5_1.passive_skill_1
	})
	self.m_skillLvText2:setText(g.core.config.passive_skill_info.get(var_5_1.passive_skill_1).level)
end

function SuccubaStarUpSuccessPop:_onPlayEnterSpineEff()
	if not self._succubaStruct then
		return
	end

	local var_6_0 = self._succubaStruct:getCurStarCfg()

	self.m_effPlaceHolder:addEffectSpine({
		remove = true,
		name = "eff_ui_succuba_upGrade",
		anim = "play",
		isLoop = false
	})
end

function SuccubaStarUpSuccessPop:_onPlayStarSpineEff()
	if not self._succubaStruct then
		return
	end

	local var_7_0 = self._succubaStruct:getCurStarCfg()

	self.m_starComp:addEffectToStars(var_7_0.star, var_7_0.star, {
		remove = true,
		name = "eff_ui_knight_upstar",
		isLoop = false,
		anim = "play",
		eventHandler = handler(self, self._onStarPlayFinish)
	})
end

function SuccubaStarUpSuccessPop:playStarLineEff()
	self.m_effStarHolder:addEffectSpine({
		remove = true,
		name = "eff_ui_knight_upstarline",
		anim = "play",
		isLoop = false
	})
end

function SuccubaStarUpSuccessPop:_onStarPlayFinish(arg_9_1)
	if not self._succubaStruct then
		return
	end

	local var_9_0 = self._succubaStruct:getCurStarCfg()

	if arg_9_1.eventData and arg_9_1.eventData.name == "cut" then
		self.m_starComp:initStar({
			gap = 0,
			style = 2,
			type = 1,
			index = 4,
			num = var_9_0.star
		})
	end
end

function SuccubaStarUpSuccessPop:_onClick()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return SuccubaStarUpSuccessPop
