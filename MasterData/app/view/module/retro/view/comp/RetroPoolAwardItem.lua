local var_0_0 = g.core.model.User.retroData
local var_0_1 = g.core.model.User.bagData
local var_0_2 = g.core.const.ConstMgr.RetroConst
local RetroPoolAwardItem = class("RetroPoolAwardItem", require("app.fairyGUI.retro.UI_RetroPoolAwardItem"))

function RetroPoolAwardItem:ctor()
	self._effEnter = nil

	self:addClickListener(handler(self, self._onClick))
end

function RetroPoolAwardItem:updateAwardInfo(arg_2_1, arg_2_2)
	self._boxId = arg_2_1
	self._index = arg_2_2 - 1
	self._boxCfg = var_0_0:getOneBoxCfgById(self._boxId)

	local var_2_0, var_2_1 = var_0_0:isGetBoxAward(self._index)

	self:newScheduleOnce(handler(self, function()
		self.m_isOpenController:setSelectedIndex(var_2_0 and 1 or 0)
	end), 0.3)

	if not var_2_0 then
		self.m_boxLoader:setURL("ui://retro/icon_box" .. self._boxCfg.quality)
	else
		self.m_boxLoader:setURL("ui://retro/icon_box" .. self._boxCfg.quality .. "_1")

		if var_2_1 and next(var_2_1) then
			local var_2_2 = g.core.common.Goods:convert(var_2_1[1])

			if var_2_2 then
				self.m_iconLoader:setIcon(var_2_2.icon)
				self.m_qualityLoader:setURL("ui://retro/pic_cfyj_pinzhi" .. var_2_2.quality + 1)
				self.m_numTxt:setText(var_2_1[1].size)
			end
		end
	end

	if not self._effEnter and self._boxCfg.quality == var_0_2.BOX_QUALITY.SUPER then
		self._effEnter = self.m_effEnter:addEffectSpine({
			name = "eff_ui_retro_boxEnter_4",
			remove = true,
			isLoop = false,
			anim = var_2_0 and "on" or "off"
		})
	end

	self.m_effLoop:removeAllEffect()

	if not var_2_0 then
		self.m_effLoop:addEffectSpine({
			name = "eff_ui_retro_boxLoop",
			isLoop = true,
			anim = "play_" .. self._boxCfg.quality + 1
		})
	end
end

function RetroPoolAwardItem:openAwardEff()
	self.m_rewardTransition:play()
	self.m_eff:removeAllEffect()
	self.m_eff:addEffectSpine({
		remove = true,
		isLoop = false,
		name = "eff_ui_retro_box_" .. self._boxCfg.quality + 1
	})
end

function RetroPoolAwardItem:_onClick()
	local var_5_0, var_5_1 = var_0_0:isGetBoxAward(self._index)

	if var_5_0 then
		if var_5_1 and next(var_5_1) then
			g.core.common.GlobalFunc.pushInfoPop(var_5_1[1])
		end

		return
	end

	local var_5_2 = var_0_1:getOwnNum(self._boxCfg.open_type, self._boxCfg.open_value)

	if var_5_2 < self._boxCfg.open_size then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = self._boxCfg.open_type,
			value = self._boxCfg.open_value,
			curSize = var_5_2,
			needSize = self._boxCfg.open_size - var_5_2
		})

		return
	end

	g.core.network.GameNetProxy:send_C2S_Retro_BoxAward({
		tp = 1,
		index = self._index
	})

	if self._boxCfg.quality == var_0_2.BOX_QUALITY.SUPER then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_BoxOpen_SR)
	else
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_BoxOpen)
	end
end

return RetroPoolAwardItem
