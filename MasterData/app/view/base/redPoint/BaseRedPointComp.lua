local var_0_0 = g.core.const.ConstMgr.RedPointConst.STYLE
local var_0_1 = "ui://base_new/pic_icon_hongdian_1"
local var_0_2 = g.core.service.ServiceManager:getServiceByName("RedPointService")
local var_0_3 = g.core.model.User.redPointData
local BaseRedPointComp = class("BaseRedPointComp", require("app.fairyGUI.base_new.UI_BaseRedPointComp"))

function BaseRedPointComp:ctor()
	self._id = checknumber(self.m_idTxt:getText())
	self.isRedPointComp = true
	self._customData = nil
	self._showCondStruct = nil
	self._tipEffectSpine = nil

	self:_initView()
end

function BaseRedPointComp:_initView()
	self.m_styleController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCtrlChanged))
	self.m_styleController:setSelectedIndex(var_0_0.NONE)
end

function BaseRedPointComp:onLoad()
	if checknumber(self._id) > 0 then
		self:_addToRedPointService()
	end

	self:updateLoopAniState()
end

function BaseRedPointComp:onUnload()
	if self._showCondStruct then
		if var_0_3.recordFinishedRedPoint then
			var_0_3:recordFinishedRedPoint(self._showCondStruct:getLifeCycle(), self._id)
		end
	end

	var_0_2:rmvRedPointComp(self)

	if self.m_redPointLoopTransition:isPlaying() then
		self.m_redPointLoopTransition:stop()
	end

	if self._tipEffectSpine then
		self._tipEffectSpine = nil

		self.m_tipEffectSpine:removeAllEffect()
	end
end

function BaseRedPointComp:getId()
	return self._id
end

function BaseRedPointComp:setId(arg_6_1)
	if self._id == arg_6_1 then
		return
	end

	self._id = checknumber(arg_6_1)

	self:_addToRedPointService()
end

function BaseRedPointComp:getCustomData()
	return self._customData
end

function BaseRedPointComp:setCustomData(arg_8_1)
	if arg_8_1 ~= self._customData then
		self._customData = arg_8_1
	end
end

function BaseRedPointComp:getEventMap()
	return var_0_3:getRedPointEventMap(self._id)
end

function BaseRedPointComp:refresh(arg_10_1, arg_10_2)
	if self._isManually then
		return
	end

	self:setCustomData(arg_10_1)

	if not self:_isRefreshEnable(arg_10_2) then
		self._showCondStruct = nil

		self.m_styleController:setSelectedIndex(var_0_0.NONE)

		return
	end

	local var_10_0
	local var_10_1
	local var_10_2 = var_0_3:getRedPointStruct(self._id)

	if var_10_2 then
		var_10_0, var_10_1 = var_10_2:getMeetConditionStruct(self._customData)
	end

	if var_10_0 then
		local var_10_3 = var_10_0:getStyle()

		if var_10_3 == var_0_0.LIMIT_TIME then
			if type(var_10_1) == "string" and #var_10_1 > 0 then
				self.m_redPointLoader:setURL(var_10_1)
			else
				self.m_redPointLoader:setURL(var_0_1)
			end
		elseif var_10_3 == var_0_0.RED_POINT then
			self.m_redPointLoader:setURL(var_0_1)
		end

		self.m_styleController:setSelectedIndex(var_10_3)
	else
		self.m_styleController:setSelectedIndex(var_0_0.NONE)
	end

	self._showCondStruct = var_10_0
end

function BaseRedPointComp:_onCtrlChanged()
	self:updateLoopAniState()
end

function BaseRedPointComp:updateLoopAniState()
	local var_12_0 = self.m_styleController:getSelectedIndex()

	if var_12_0 == var_0_0.RED_POINT or var_12_0 == var_0_0.NEW_WORD then
		if not g.core.utils.Quality.needCloseUIAnime() then
			self.m_redPointLoopTransition:play()
		end

		if self._tipEffectSpine then
			self._tipEffectSpine = nil

			self.m_tipEffectSpine:removeAllEffect()
		end
	elseif var_12_0 == var_0_0.CAN_BREAK or var_12_0 == var_0_0.CAN_SWAP then
		if not g.core.utils.Quality.needCloseUIAnime() and not self._tipEffectSpine then
			self._tipEffectSpine = self.m_tipEffectSpine:addEffectSpine({
				anim = "play",
				name = "eff_ui_knight_tipsglow",
				isLoop = true
			})
		end

		if self.m_redPointLoopTransition:isPlaying() then
			self.m_redPointLoopTransition:stop()
		end
	else
		if self.m_redPointLoopTransition:isPlaying() then
			self.m_redPointLoopTransition:stop()
		end

		if self._tipEffectSpine then
			self._tipEffectSpine = nil

			self.m_tipEffectSpine:removeAllEffect()
		end
	end
end

function BaseRedPointComp:_isRefreshEnable(arg_13_1)
	return var_0_3:isRedPointIdValid(self._id)
end

function BaseRedPointComp:_addToRedPointService()
	var_0_2:rmvRedPointComp(self)

	if var_0_3:isRedPointIdValid(self._id) then
		var_0_2:addRedPointComp(self)
	end
end

function BaseRedPointComp:getRedPointStyle()
	return self.m_styleController:getSelectedIndex()
end

function BaseRedPointComp:setShow(arg_16_1, arg_16_2)
	arg_16_2 = arg_16_1 and (arg_16_2 or var_0_0.RED_POINT) or var_0_0.NONE

	if arg_16_2 ~= self:getRedPointStyle() then
		self.m_styleController:setSelectedIndex(arg_16_2)
	end
end

function BaseRedPointComp:isShow()
	return self:getRedPointStyle() ~= var_0_0.NONE
end

function BaseRedPointComp:setStyleManually(arg_18_1)
	self.m_styleController:setSelectedIndex(arg_18_1)

	self._isManually = true
end

return BaseRedPointComp
