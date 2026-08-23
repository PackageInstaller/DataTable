local var_0_0 = g.core.model.User
local var_0_1 = g.core.const.ConstMgr.UniteTokenConst
local FogNightmareFormationUniteBtn = class("FogNightmareFormationUniteBtn", require("app.fairyGUI.fogNightmare.UI_FogNightmareFormationUniteBtn"))

function FogNightmareFormationUniteBtn:ctor()
	self._unLock = true
	self._isDrag = false
	self._skillPos = 0
	self._skillInfo = {}
	self._tokenData = {}
	self._unLockText = nil
	self._rollEnable = true
	self._showPop = false
	self._isOtherUnite = false

	self:setScale(0.9)
	self:addClickListener(handler(self, self._onClick))
	self:addEventListener(fgui.UIEventType.RollOver, handler(self, self._onRollOver))
	self:addEventListener(fgui.UIEventType.RollOut, handler(self, self._onRollOut))
end

function FogNightmareFormationUniteBtn:setSkillPos(arg_2_1)
	self._skillPos = arg_2_1
end

function FogNightmareFormationUniteBtn:getPos()
	return self._skillPos
end

function FogNightmareFormationUniteBtn:updateFormatUnlock(arg_4_1)
	self._unLock = false

	self.m_stateController:setSelectedIndex(var_0_1.CTRL_FORMAT_UNLV)

	self._unLockText = g.core.lang:get(202514, {
		level = arg_4_1
	})
end

function FogNightmareFormationUniteBtn:updateBtn(arg_5_1, arg_5_2)
	self._isOtherUnite = arg_5_2

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			pos = self._skillPos
		}
	})

	self._tokenData = arg_5_1

	if not arg_5_1 or not next(arg_5_1) then
		self.m_stateController:setSelectedIndex(var_0_1.CTRL_FORMAT_TODO)
		g.core.utils.Action.playBlinkAction(self.m_addPic, 1, 0)

		return
	end

	self.m_stateController:setSelectedIndex(var_0_1.CTRL_FORMAT_DONE)

	local var_5_0 = self._tokenData:getSkillId()

	self._skillInfo = var_0_0.uniteTokenData:getTokenBaseInfo(var_5_0).skillInfo

	self.m_skillIcon:updateIcon({
		skillId = var_5_0
	})
end

function FogNightmareFormationUniteBtn:onDragStart()
	self._isDrag = true

	self.m_skillIcon:setAlpha(0.5)
end

function FogNightmareFormationUniteBtn:onDragEnd()
	self.m_skillIcon:setAlpha(1)
	self:newScheduleOnce(handler(self, function()
		self._isDrag = false
	end), 0.03)
end

function FogNightmareFormationUniteBtn:setClickShowInfoPopEnable(arg_9_1)
	self._showPop = arg_9_1
end

function FogNightmareFormationUniteBtn:_onClick()
	if not self._isDrag and self._unLock then
		if self._showPop then
			local var_10_0 = {
				type = g.core.common.Goods.TYPE_UNITETOKEN,
				value = self._tokenData:getCfg().id
			}

			if self._isOtherUnite then
				var_10_0.tokenData = self._tokenData
			end

			g.core.common.GlobalFunc.pushInfoPop(var_10_0)
		else
			self:dispatchCompEvent("clickAddUnite", {
				pos = self._skillPos
			})
		end
	elseif not self._isDrag and not self._unLock and self._unLockText and not self._isOther then
		g.core.module.ModuleManager:tip(self._unLockText)
	end
end

function FogNightmareFormationUniteBtn:setRollEnable(arg_11_1)
	self._rollEnable = arg_11_1
end

function FogNightmareFormationUniteBtn:_onRollOut()
	if not self._rollEnable then
		return
	end

	self:setScale(0.9)
end

function FogNightmareFormationUniteBtn:_onRollOver()
	if not self._isDrag and self._rollEnable then
		self:setScale(0.9900000000000001)
	end
end

function FogNightmareFormationUniteBtn:setIsOtherStyle()
	self.m_redPointComp:setId(0)

	self._isOther = true

	self.m_isOtherController:setSelectedIndex(1)

	if self.m_stateController:getSelectedIndex() == var_0_1.CTRL_FORMAT_TODO then
		self.m_isAlphaController:setSelectedIndex(1)
	else
		self.m_isOtherController:setSelectedIndex(0)
	end
end

function FogNightmareFormationUniteBtn:getComponentURL()
	return require("app.fairyGUI.fogNightmare.UI_FogNightmareFormationUniteBtn").URL
end

function FogNightmareFormationUniteBtn:getScriptFile()
	return "app.view.module.fogNightmare.view.explore.btn.FogNightmareFormationUniteBtn"
end

function FogNightmareFormationUniteBtn:getDragParam()
	if self._tokenData and self._tokenData.getAdvanceId then
		return {
			data = self._tokenData,
			pos = self._skillPos
		}
	else
		return nil
	end
end

function FogNightmareFormationUniteBtn:setPos(arg_18_1)
	self._skillPos = arg_18_1
end

return FogNightmareFormationUniteBtn
