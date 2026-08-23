local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.config.skin_info
local var_0_3 = g.core.config.passive_skill_info
local var_0_4 = g.core.config.wedding_vow_info
local var_0_5 = g.core.const.ConstMgr
local var_0_6 = g.core.model.User.knightsData
local var_0_7 = g.core.model.User.weddingData
local BaseConfirmPop = require("app.view.base.pop.BaseConfirmPop")
local WeddingMainPop = class("WeddingMainPop", require("app.fairyGUI.wedding.UI_WeddingMainPop"), function()
	return fgui.GComponent:create({
		pkgName = "wedding",
		isFullScreen = false,
		pkgPath = "ui/wedding/wedding",
		resName = "WeddingMainPop"
	}, ...)
end)

function WeddingMainPop:ctor(arg_2_1)
	if arg_2_1.knightStruct then
		self._knightStruct = arg_2_1.knightStruct
	elseif arg_2_1 then
		self._knightStruct = var_0_6:getKnight(arg_2_1)
	end

	self._advId = self._knightStruct:getAdvanceId()
	self._vowInfo = nil
	self._effect = nil

	self:_initView()
	self:_playEnterEffect()
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playMusic(var_0_5.SoundConst.Sound.UI_Event_WeddingMenu_Open)
end

function WeddingMainPop:_initView()
	self:showAtCenter()
	self.m_weddingBtn:addClickListener(handler(self, self._onClickWeddingBtn))
	self.m_passiveIcon:addClickListener(handler(self, self._onClickSkillIcon))
	self.m_bgComp:updateMaskKnight(self._knightStruct)
	self.m_userSignComp:setTitle(g.core.model.User:getName())
	self.m_knightSignComp:setTitle(self._knightStruct:getName())
	self:_initDesc()
end

function WeddingMainPop:_onClickSkillIcon()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.KnightWeddingSkillTip").new({
		knightStruct = self._knightStruct
	}), {
		touchDisappear = true
	})
end

function WeddingMainPop:_playEnterEffect()
	self.m_bgComp:getChild("mainEnterEff"):addEffectSpine({
		anim = "play",
		remove = true,
		isLoop = false,
		name = "eff_ui_wedding_bookCN",
		eventHandler = handler(self, self._playIdleEffect)
	})
end

function WeddingMainPop:_playIdleEffect()
	self.m_bgComp:getChild("idleEff"):addEffectSpine({
		name = "eff_ui_wedding_bookCN",
		isLoop = true,
		anim = "idle",
		remove = false
	})
end

function WeddingMainPop:_initDesc()
	local var_7_0 = self._knightStruct:getName()
	local var_7_1 = var_0_4.get(self._advId)

	self._vowInfo = var_7_1

	if var_7_1.skin > 0 then
		self.m_tip2:setTitle(g.core.lang:get(412022, {
			knightName = var_7_0,
			skinName = var_0_2.get(var_7_1.skin).name
		}))
	else
		self.m_tip2:setTitle(g.core.lang:get(412021))
	end

	self.m_tip0:setTitle(g.core.lang:get(412028))
	self.m_tip1:getChild("title"):enableRich()
	self.m_tip1:setText(var_7_0 .. var_7_1.vow_talent_des)

	local var_7_3 = var_0_3.get(self._vowInfo["skill_" .. var_0_7:getFirstFavorInfo(self._advId).level])

	self.m_passiveIcon:updateIcon({
		isPassive = true,
		skillId = var_7_3.id
	})
	self.m_tip3:setText(g.core.lang:get(412029, {
		knightName = var_7_0,
		skillName = var_7_3.name
	}))
end

function WeddingMainPop:_onClickWeddingBtn()
	if not self.m_condComp:isCondFinish() then
		g.core.module.ModuleManager:tip(g.core.lang:get(412019))

		return
	end

	g.core.module.ModuleManager:pushPopup(BaseConfirmPop.new({
		title = g.core.lang:get(412026),
		desc = g.core.lang:get(412025, {
			itemName = self:getItemName(),
			knightName = self._knightStruct:getName()
		}),
		onConfirm = function()
			g.core.network.GameNetProxy:send_C2S_WeddingVow_Active({
				knight_id = self._knightStruct:getServerId()
			})
		end
	}))
end

function WeddingMainPop:getItemName()
	if self._vowInfo.ring_spe_type > 0 then
		local var_10_0 = var_0_1:convert({
			type = self._vowInfo.ring_spe_type,
			value = self._vowInfo.ring_spe_value
		})

		if var_10_0.size >= self._vowInfo.ring_spe_size then
			return var_10_0.name
		end
	end

	return var_0_1:convert({
		type = var_0_1.TYPE_ITEM,
		value = var_0_5.WeddingConst.WEDDING_ITEM_VALUE
	}).name
end

function WeddingMainPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WEDDING_VOW_ACTIVE, handler(self, self._onRcvWeddingActive), self)

	if var_0_7:isWeddingVowByKnightId(self._advId) then
		self:newScheduleOnce(handler(self, self._onClickClose))
	else
		g.core.sound.SoundManager:playMusic(var_0_5.SoundConst.BGM.Music_MarrySystemMenu)
		self:updateView()
	end
end

function WeddingMainPop:_onRcvWeddingActive()
	if self._weddingAdvance then
		return
	end

	self._weddingAdvance = var_0_4.get(self._advId).vow_advance

	g.core.module.ModuleManager:pushPopup((require("app.view.module.wedding.view.WeddingVowLayer").new({
		knightStruct = self._knightStruct
	}, true)))
	self:_onClickClose(true)
end

function WeddingMainPop:updateView()
	self.m_condComp:setCondData(self._advId, var_0_5.WeddingConst.WEDDING_COND_ITEM)
end

function WeddingMainPop:_onClickClose(arg_14_1)
	if not arg_14_1 then
		g.core.sound.SoundManager:playMusic(var_0_5.SoundConst.BGM.MUSIC_MAIN_MENU)
	end

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return WeddingMainPop
