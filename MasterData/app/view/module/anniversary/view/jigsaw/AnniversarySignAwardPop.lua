local var_0_0 = g.core.model.User.anniversaryData
local var_0_1 = g.core.config.anniversary_jigsaw_sign_info
local AnniversarySignAwardPop = class("AnniversarySignAwardPop", require("app.fairyGUI.anniversary.UI_AnniversarySignAwardPop"), function()
	return fgui.GComponent:create({
		resName = "AnniversarySignAwardPop",
		pkgName = "anniversary"
	}, ...)
end)

function AnniversarySignAwardPop:ctor(arg_2_1)
	self:showAtCenter()

	self._svrData = arg_2_1.data
	self._closeCallBack = arg_2_1.callback

	self.m_touchArea:addClickListener(handler(self, self._onClickClose))

	self._isPlayEnd = false

	self:playEnterAnim()
	self.m_bg:setURL(var_0_0:getActivityResource("ui_cocos", "pic_xmhy_majiangtcdi1.png"))
	self.m_iconBg:setURL(var_0_0:getActivityResource("ui_cocos", "pic_xmhy_majiangtcdi2.png"))
end

function AnniversarySignAwardPop:playEnterAnim()
	self.m_enterTransition:play(handler(self, self._playTransitionEnd))

	local var_3_0 = "eff_ui_anniversaryJigsaw_getmj"

	if var_0_0:getActivityId() > 1 then
		var_3_0 = "eff_ui_anniversaryJigsaw_getmj" .. var_0_0:getAnniversaryInfo().file_type
	end

	self.m_effLoop:addEffectSpine({
		anim = "loop",
		isLoop = true,
		name = var_3_0
	})
	self.m_effPlay:addEffectSpine({
		anim = "play",
		isLoop = false,
		name = var_3_0
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_StarNight_01)
end

function AnniversarySignAwardPop:_playTransitionEnd()
	self._isPlayEnd = true

	self:_showGetExtraAward()
end

function AnniversarySignAwardPop:onLoad()
	local var_5_0 = var_0_1.get((var_0_0:getCurSignAwardId()))

	if not var_5_0 then
		return
	end

	self.m_mahjongLoader:setURL(g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_ITEM, var_5_0.jigsaw_id))
	self.m_descTxt:setText(var_5_0.text)
end

function AnniversarySignAwardPop:_showGetExtraAward()
	if self._svrData.extra_awards then
		g.core.module.ModuleManager:awardSummary(self._svrData.extra_awards, true)
	end
end

function AnniversarySignAwardPop:_onClickClose()
	if self._isPlayEnd then
		self.m_backTransition:play(handler(self, self._onClose))
	end
end

function AnniversarySignAwardPop:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	if self._closeCallBack then
		self._closeCallBack()
	end
end

function AnniversarySignAwardPop:onUnload()
	self._isPlayEnd = true
end

return AnniversarySignAwardPop
