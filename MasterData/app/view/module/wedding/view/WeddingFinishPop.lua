local var_0_0 = g.core.config.passive_skill_info
local FightValueCalculation = require("app.core.common.FightValue.FightValueCalculation")
local var_0_2 = g.core.config.wedding_vow_info
local var_0_3 = g.core.common.ServerTime
local var_0_4 = g.core.model.User.knightsData
local var_0_5 = g.core.model.User.weddingData
local WeddingFinishPop = class("WeddingFinishPop", require("app.fairyGUI.wedding.UI_WeddingFinishPop"), function()
	return fgui.GComponent:create({
		resName = "WeddingFinishPop",
		pkgPath = "ui/wedding/wedding",
		isFullScreen = false,
		pkgName = "wedding"
	}, ...)
end)

function WeddingFinishPop:ctor(arg_2_1, arg_2_2, arg_2_3)
	if arg_2_1.knightStruct then
		self._knightStruct = arg_2_1.knightStruct
	elseif arg_2_1 then
		self._knightStruct = var_0_4:getKnight(arg_2_1)
	end

	self._isWeddingEnd = arg_2_2 or false
	self._advId = self._knightStruct:getAdvanceId()
	self._vowInfo = var_0_2.get(self._advId)
	self._isClose = false
	self._isFirst = arg_2_3

	self:initView()
	self:_playEnterEffect()
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_WeddingMenu_Open)
end

function WeddingFinishPop:_playEnterEffect()
	local var_3_0 = self.m_bgComp:getChild("shiciEnterEff")

	var_3_0:addEffectSpine({
		anim = "play",
		name = "eff_ui_wedding_shiciCN",
		remove = false,
		isLoop = false
	})
	var_3_0:addEffectSpine({
		anim = "enter",
		name = "eff_ui_wedding_shiciCN",
		isLoop = false,
		remove = false,
		eventHandler = handler(self, self._playIdleEffect)
	})
end

function WeddingFinishPop:_playIdleEffect(arg_4_1)
	if arg_4_1.type == "complete" then
		self.m_bgComp:getChild("shiciEnterEff"):addEffectSpine({
			anim = "idle",
			name = "eff_ui_wedding_shiciCN",
			isLoop = true
		})
	end
end

function WeddingFinishPop:_playIdleEffect()
	self.m_bgComp:getChild("idleEff"):addEffectSpine({
		anim = "idle",
		name = "eff_ui_wedding_bookCN",
		remove = false,
		isLoop = true
	})
end

function WeddingFinishPop:initView()
	self:showAtCenter()
	self.m_reviewBtn:addClickListener(handler(self, self._onClickReviewBtn))
	self.m_passiveIcon:addClickListener(handler(self, self._onClickSkillIcon))
	self.m_bgComp:updateMaskKnight(self._knightStruct)
	self.m_userSignComp:setTitle(g.core.model.User:getName())
	self.m_knightSignComp:setTitle(self._knightStruct:getName())
	self.m_timeText:setText(var_0_3:getTimeStringEx(var_0_5:getKnightWeddingData(self._advId).vow_time, true))
	self:updateAttr()
end

function WeddingFinishPop:_onClickSkillIcon()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.KnightWeddingSkillTip").new({
		knightStruct = self._knightStruct
	}), {
		touchDisappear = true
	})
end

function WeddingFinishPop:updateAttr()
	local var_8_0 = self._knightStruct:getName()
	local var_8_1 = var_0_0.get(self._vowInfo["skill_" .. var_0_5:getFirstFavorInfo(self._advId).level])

	self.m_passiveIcon:updateIcon({
		isPassive = true,
		skillId = var_8_1.id
	})
	self.m_tip2:setText(g.core.lang:get(412029, {
		knightName = var_8_0,
		skillName = var_8_1.name
	}))
	self.m_textLoader:setURL(g.core.common.Path:getWeddingVowText(self._vowInfo.vow_text))
	self.m_attrDesc:setText(var_8_0 .. self._vowInfo.vow_talent_des)
end

function WeddingFinishPop:_onClickReviewBtn()
	self:_onClickClose(true)
	g.core.module.ModuleManager:pushPopup((require("app.view.module.wedding.view.WeddingVowLayer").new({
		knightStruct = self._knightStruct
	}, false)))
end

function WeddingFinishPop:_onClickClose(arg_10_1)
	if self._isClose then
		return
	end

	self._isClose = true

	if not arg_10_1 then
		g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_MAIN_MENU)
	end

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function WeddingFinishPop:onLoad()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_MarrySystemMenu)
end

return WeddingFinishPop
