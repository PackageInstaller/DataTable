local var_0_0 = g.core.const.ConstMgr.KnightFavoConst.SOUND_STATUS
local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local FavoSoundCell = class("FavoSoundCell", require("app.fairyGUI.knightFavorability.UI_FavoSoundCell"))

function FavoSoundCell:ctor()
	self._index = 0
	self._resId = 0
	self._playStatus = var_0_0.NULL_STATUS
	self._soundData = nil
	self._knightFavoStruct = nil

	self.getSharedTrans(self, "enter_down", "CommonLongCellList", self)
	self.m_effectHolder:addEffectSpine({
		isLoop = true,
		name = "eff_ui_dungeon_audio"
	})
	self:addClickListener(handler(self, self._onClick))
end

function FavoSoundCell:updateCell(arg_2_1)
	self._index = arg_2_1.index
	self._resId = arg_2_1.resId
	self._soundData = arg_2_1.soundData
	self._knightFavoStruct = arg_2_1.favoStruct

	self.m_name:setText(arg_2_1.soundData.title)

	local var_2_0 = false

	if arg_2_1.unlocked then
		self._playStatus = var_0_0.CAN_PLAY

		self.m_isUnLockController:setSelectedIndex(1)

		var_2_0 = not arg_2_1.soundData.isPlayed
	else
		self._playStatus = var_0_0.CAN_NOT_PLAY

		self.m_isUnLockController:setSelectedIndex(0)

		if arg_2_1.unlockLevel ~= 9999 then
			self.m_unLockTitle:setTitle(g.core.lang:get(112020, {
				level = arg_2_1.soundData.unlockLevel
			}))
		else
			self.m_unLockTitle:setTitle(g.core.lang:get(112221))
		end
	end

	self:_reset()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			isNew = var_2_0
		}
	})
end

function FavoSoundCell:onClickItem(arg_3_1)
	if self._index ~= arg_3_1 and self._playStatus == var_0_0.PLAYING then
		self:_stopSound()
	end
end

function FavoSoundCell:_onClick()
	if self._playStatus == var_0_0.CAN_PLAY then
		self:_playSound()
	elseif self._playStatus == var_0_0.PLAYING then
		self:_stopSound(true)
	end
end

function FavoSoundCell:_playSound()
	self._playStatus = var_0_0.PLAYING

	self.m_isPlayController:setSelectedIndex(0)

	if not self._soundData.isPlayed then
		self._soundData.isPlayed = true

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				isNew = false
			}
		})
		self._knightFavoStruct:setSoundsPlayed(self._resId, {
			self._soundData
		})
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_FAVO_PLAY_LINES, false, {
		tip = self._soundData.tip
	})
	KnightVoiceCommon.playVoice({
		voiceName = self._soundData.soundName,
		func = handler(self, self._soundEnd)
	})
end

function FavoSoundCell:_soundEnd()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_FAVO_PLAY_LINES_END)

	self._playStatus = var_0_0.CAN_PLAY

	if self._reset then
		self:_reset()
	end
end

function FavoSoundCell:_stopSound(arg_7_1)
	self._playStatus = var_0_0.CAN_PLAY

	if arg_7_1 then
		KnightVoiceCommon.stopVoice()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_FAVO_PLAY_LINES_END)
	end

	self:_reset()
end

function FavoSoundCell:_reset()
	self.m_isPlayController:setSelectedIndex(1)
end

return FavoSoundCell
