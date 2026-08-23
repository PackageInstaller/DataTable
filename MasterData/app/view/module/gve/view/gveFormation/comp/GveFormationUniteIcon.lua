local var_0_0 = g.core.config.monster_team_info
local var_0_1 = g.core.config.unite_token_info
local var_0_2 = g.core.model.User
local var_0_3 = g.core.const.ConstMgr.UniteTokenConst
local var_0_4 = g.core.model.User.gveDataMgr
local var_0_5 = g.core.model.User.gveDataMgr:getGveFormationData()
local GveFormationUniteIcon = class("GveFormationUniteIcon", require("app.fairyGUI.gve.UI_GveFormationUniteIcon"))

function GveFormationUniteIcon:ctor()
	var_0_5 = var_0_4:getGveFormationData()
	self._unLock = true
	self._isDrag = false
	self._skillPos = 0
	self._skillInfo = {}
	self._uniteTokenId = 0
	self._tokenData = {}
	self._unLockText = nil
	self._isOther = false

	self:setScale(0.9)
	self:addClickListener(handler(self, self._onClick))
	self:addEventListener(fgui.UIEventType.RollOver, handler(self, self._onRollOver))
	self:addEventListener(fgui.UIEventType.RollOut, handler(self, self._onRollOut))
end

function GveFormationUniteIcon:setSkillPos(arg_2_1)
	self._skillPos = arg_2_1
end

function GveFormationUniteIcon:getSkillPos()
	return self._skillPos
end

function GveFormationUniteIcon:getDragParam()
	if self._tokenData and self._tokenData.getAdvanceId then
		return self._tokenData:getAdvanceId()
	else
		return 0
	end
end

function GveFormationUniteIcon:updateFormatUnlock(arg_5_1)
	self._unLock = false

	self.m_stateController:setSelectedIndex(var_0_3.CTRL_FORMAT_UNLV)

	self._unLockText = g.core.lang:get(202514, {
		level = arg_5_1
	})
end

function GveFormationUniteIcon:updateTokenFormatIcon(arg_6_1)
	self._tokenData = arg_6_1

	if not arg_6_1 or not next(arg_6_1) then
		self._uniteTokenId = 0

		self.m_stateController:setSelectedIndex(var_0_3.CTRL_FORMAT_TODO)
		g.core.utils.Action.playBlinkAction(self.m_addPic, 1, 0)

		return
	end

	self.m_stateController:setSelectedIndex(var_0_3.CTRL_FORMAT_DONE)

	local var_6_0 = self._tokenData:getSkillId()

	self._uniteTokenId = self._tokenData:getAdvanceId()
	self._skillInfo = var_0_2.uniteTokenData:getTokenBaseInfo(var_6_0).skillInfo

	self.m_skillIcon:updateIcon({
		skillId = var_6_0
	})
end

function GveFormationUniteIcon:updateMonsterIcon(arg_7_1)
	self._uniteTokenId = 0

	if arg_7_1.isBossInfo then
		if arg_7_1.monsterIndex == 0 then
			self:_updateMonsterByTeamId(arg_7_1.info.boss_team, arg_7_1.info)
		else
			self:_updateMonsterByTeamId(arg_7_1.info["guard_" .. arg_7_1.monsterIndex], arg_7_1.info)
		end
	else
		local var_7_0 = var_0_1.fetch(arg_7_1.info["unite_token_" .. self._skillPos])

		if var_7_0 then
			self._uniteTokenId = var_7_0.advance_id

			self.m_skillIcon:updateIcon({
				skillId = var_7_0.skill_id
			})
			self.m_stateController:setSelectedIndex(var_0_3.CTRL_FORMAT_DONE)
		else
			self.m_stateController:setSelectedIndex(var_0_3.CTRL_FORMAT_TODO)
		end
	end
end

function GveFormationUniteIcon:_updateMonsterByTeamId(arg_8_1)
	local var_8_0 = var_0_1.fetch(var_0_0.get(arg_8_1, 1)["unite_token_" .. self._skillPos])

	if var_8_0 then
		self._uniteTokenId = var_8_0.advance_id

		self.m_skillIcon:updateIcon({
			skillId = var_8_0.skill_id
		})
		self.m_stateController:setSelectedIndex(var_0_3.CTRL_FORMAT_DONE)
	else
		self.m_stateController:setSelectedIndex(var_0_3.CTRL_FORMAT_TODO)
	end
end

function GveFormationUniteIcon:onDragStart()
	self._isDrag = true

	self.m_skillIcon:setAlpha(0.5)
end

function GveFormationUniteIcon:onDragEnd()
	self.m_skillIcon:setAlpha(1)
	self:newScheduleOnce(handler(self, function()
		self._isDrag = false
	end), 0.03)
end

function GveFormationUniteIcon:_onClick()
	if not self._isDrag and self._unLock and not self._isOther then
		self:dispatchCompEvent("gve_formation_click_add_unite", {
			pos = self._skillPos
		})
	elseif not self._isDrag then
		if self._isOther and self._uniteTokenId > 0 then
			g.core.module.ModuleManager:pushPopup((require("app.view.module.uniteToken.view.UniteTokenInfoPop").new(self._uniteTokenId)))
		elseif not self._unLock and self._unLockText then
			g.core.module.ModuleManager:tip(self._unLockText)
		end
	end
end

function GveFormationUniteIcon:_onRollOut()
	self:setScale(0.9)
end

function GveFormationUniteIcon:_onRollOver()
	if not self._isDrag and not self._isOther then
		self:setScale(0.9900000000000001)
	end
end

function GveFormationUniteIcon:setIsOtherStyle(arg_15_1)
	self.m_redPointComp:setId(0)

	self._isOther = arg_15_1 == true

	self.m_isOtherController:setSelectedIndex(arg_15_1 and 1 or 0)
end

function GveFormationUniteIcon:isOther()
	return self._isOther
end

function GveFormationUniteIcon:checkRedPoint()
	if self._isOther then
		self.m_redPointComp:setShow(false)

		return
	end

	if self.m_stateController:getSelectedIndex() == 1 then
		if var_0_5:isHasUniteTokenCanUp() then
			self.m_redPointComp:setShow(true)
		else
			self.m_redPointComp:setShow(false)
		end
	else
		self.m_redPointComp:setShow(false)
	end
end

return GveFormationUniteIcon
