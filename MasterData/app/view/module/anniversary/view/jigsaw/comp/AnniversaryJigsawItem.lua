local var_0_0 = g.core.model.User.anniversaryData
local AnniversaryJigsawItem = class("AnniversaryJigsawItem", require("app.fairyGUI.anniversary.UI_AnniversaryJigsawItem"))

function AnniversaryJigsawItem:updateItem(arg_1_1, arg_1_2)
	self._jigsawId = var_0_0:getJigsawIdByPos(arg_1_1, arg_1_2)
	self._drawTime = var_0_0:getDrawJigsawTime(self._jigsawId)

	self.m_iconLoader:setURL(g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_ITEM, self._jigsawId))
	self.m_isGetController:setSelectedIndex(self._drawTime > 0 and 1 or 0)
end

function AnniversaryJigsawItem:playScrollEff(arg_2_1)
	self.m_eff:removeAllEffect()
	self.m_eff:addEffectSpine({
		anim = "roll",
		name = "eff_ui_anniversaryJigsaw_rollcube",
		remove = true,
		isLoop = true
	})
	self:runFGAction((fgui.FSequence:create({
		fgui.FDelayTime:create(arg_2_1),
		fgui.FCallFunc:create(handler(self, function()
			self.m_eff:removeAllEffect()
		end))
	})))
end

function AnniversaryJigsawItem:playFinallyEff()
	self.m_eff:removeAllEffect()

	if self.m_isGetController:getSelectedIndex() == 0 then
		self.m_eff:addEffectSpine({
			anim = "new",
			name = "eff_ui_anniversaryJigsaw_rollcube",
			isLoop = false,
			eventHandler = handler(self, self._onNewAnimationEnd)
		})
	else
		self.m_eff:addEffectSpine({
			anim = "repeat",
			name = "eff_ui_anniversaryJigsaw_rollcube",
			remove = true,
			isLoop = false
		})
		self:dispatchCompEvent("FLY_TO_SHARE_BTN", {
			jigsawId = self._jigsawId
		})
	end

	self._drawTime = var_0_0:getDrawJigsawTime(self._jigsawId)

	self.m_isGetController:setSelectedIndex(self._drawTime > 0 and 1 or 0)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_StarNight_Majiang03)
end

function AnniversaryJigsawItem:_onNewAnimationEnd(arg_5_1)
	if arg_5_1.type == "event" and arg_5_1.eventData.name == "cut" then
		self.m_getNewTransition:play()
	end
end

function AnniversaryJigsawItem:playScaleOnceTransition()
	self.m_scaleOnceTransition:play()
end

return AnniversaryJigsawItem
