local var_0_0 = g.core.module.ModuleManager
local var_0_1 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_2 = g.core.common.ModuleUnlock
local var_0_3 = g.core.model.User.weddingData
local BaseWeddingBtn = class("BaseWeddingBtn", require("app.fairyGUI.base_new.UI_BaseWeddingBtn"))

function BaseWeddingBtn:ctor()
	self._advId = 0
	self._effectEnd = nil
	self._effectOpen = nil

	self:addClickListener(handler(self, self._onClickWeddingBtn))
end

function BaseWeddingBtn:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WEDDING_VOW_ACTIVE, handler(self, self._updateVisible), self)
	self:_updateVisible()
end

function BaseWeddingBtn:_onClickWeddingBtn()
	local var_3_0, var_3_1 = var_0_2:getUnlockComment(var_0_1.WEDDING_VOW)

	if not var_3_1 then
		var_0_0:tip(var_3_0)

		return
	end

	if self._advId == 0 then
		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.WEDDING_MAIN_POP, {
		advance_id = self._advId
	})
end

function BaseWeddingBtn:setKnightAdvId(arg_4_1)
	if self._advId == arg_4_1 then
		return
	end

	self._advId = arg_4_1

	self:_updateVisible()
end

function BaseWeddingBtn:_updateVisible()
	if self._advId > 0 then
		local var_5_0 = var_0_2:isModuleShow(var_0_1.WEDDING_VOW) and var_0_3:hasWeddingModule(self._advId)

		self:setVisible(var_5_0)

		if var_5_0 then
			self:updateEffectState()
		end
	else
		self:setVisible(false)
	end
end

function BaseWeddingBtn:updateEffectState()
	if var_0_3:isWeddingVowByKnightId(self._advId) then
		self.m_isWeddingController:setSelectedIndex(1)
		self.m_weddingKnight.m_eff2:removeAllEffect()

		self._effectOpen = nil
		self._effectEnd = self._effectEnd or self.m_effectNode:addEffectSpine({
			remove = false,
			name = "eff_ui_wedding_endBtn",
			anim = "play",
			isLoop = true
		})
	else
		self.m_effectNode:removeAllEffect()

		self._effectEnd = nil
		self._effectOpen = self._effectOpen or self.m_weddingKnight.m_eff2:addEffectSpine({
			remove = false,
			name = "eff_ui_wedding_openBtn",
			anim = "play",
			isLoop = true
		})

		self.m_isWeddingController:setSelectedIndex(0)
		self.m_weddingKnight:updateIconComp(self._advId)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			advId = self._advId
		}
	})
end

return BaseWeddingBtn
