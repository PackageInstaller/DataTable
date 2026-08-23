local var_0_0 = g.core.model.User.allianceData
local var_0_1 = g.core.lang
local var_0_2 = require("app.view.module.alliance.const.AllianceMenuConfig").BUTTON_TYPE
local var_0_4 = g.core.config.guild_alliance_right_info
local var_0_5 = g.core.common.ServerTime
local AllianceHallOperatePop = class("AllianceHallOperatePop", require("app.fairyGUI.alliance.UI_AllianceHallOperatePop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/alliance/alliance",
		resName = "AllianceHallOperatePop",
		pkgName = "alliance"
	}, ...)
end)

function AllianceHallOperatePop:ctor(arg_2_1)
	self:showAtCenter()

	self._cdEndTime = var_0_5:getTime() + 5
	self._cdHandler = nil
	self._operationType = arg_2_1.operationType
	self._guildSnapshot = arg_2_1.guildSnapshot
	self._onConfirm = arg_2_1.onConfirm
	self._grade = g.core.const.ConstMgr.AllianceConst.GRADE.MEMBER

	if arg_2_1.grade then
		self._grade = arg_2_1.grade
	elseif arg_2_1 and arg_2_1.guildSnapshot then
		self._grade = var_0_0:getGrade(arg_2_1.guildSnapshot.id)
	end

	self.m_operationController:setSelectedIndex(self._operationType)
	self.m_popPanel:setTitleName(arg_2_1.title or {})
	self:updateView()
	self.m_confirmBtn:addClickListener(handler(self, self._onClickConfirmBtn))
	self.m_cancelBtn:addClickListener(handler(self, self._onClickCancelBtn))
end

function AllianceHallOperatePop:updateView()
	self.m_operationTxt:setText(self:_getOperationTxt())
	self:_updateTips()

	if self._operationType == var_0_2.TRANSFER then
		self.m_transferTip:setText(var_0_1:get(428575, {
			guild = self._guildSnapshot.name,
			name = self._guildSnapshot.leader_name
		}))
	elseif self._operationType == var_0_2.LAYOFF then
		local var_3_0 = var_0_4.get(self._grade)

		self.m_layoffTip1:setText(var_0_1:get(428573, {
			grade = var_3_0.name
		}))
		self.m_layoffTip2:setText(var_0_1:get(428581, {
			num = var_3_0.num - var_0_0:getGradeNum(self._grade)
		}))
	end
end

function AllianceHallOperatePop:_updateTips()
	if self._operationType == var_0_2.DISMISS_ALLIANCE or self._operationType == var_0_2.QUIT_ALLIANCE then
		local var_4_0 = {}

		if g.core.model.User.gveDataMgr:isOpen() then
			table.insert(var_4_0, g.core.lang:get(109054))
		end

		if #var_4_0 > 0 then
			self.m_quitTips:setText(g.core.lang:get(428607, {
				play = table.concat(var_4_0, ",")
			}))
		end
	end

	self.m_tips:setText(self:_getTips())
end

function AllianceHallOperatePop:_getTips()
	if self._operationType == var_0_2.DISMISS_ALLIANCE then
		return var_0_1:get(428568)
	elseif self._operationType == var_0_2.QUIT_ALLIANCE then
		return var_0_1:get(428569)
	elseif self._operationType == var_0_2.SET_VICE then
		return var_0_1:get(428570, {
			num = var_0_4.get(g.core.const.ConstMgr.AllianceConst.GRADE.VICE_LEADER).num - var_0_0:getGradeNum(g.core.const.ConstMgr.AllianceConst.GRADE.VICE_LEADER)
		})
	elseif self._operationType == var_0_2.KICK then
		return var_0_1:get(428580)
	end

	return ""
end

function AllianceHallOperatePop:_getOperationTxt()
	if self._operationType == var_0_2.DISMISS_ALLIANCE then
		return var_0_1:get(428577, {
			alliance = var_0_0:getAllianceName()
		})
	elseif self._operationType == var_0_2.QUIT_ALLIANCE then
		return var_0_1:get(428576, {
			alliance = var_0_0:getAllianceName()
		})
	elseif self._operationType == var_0_2.SET_VICE then
		return var_0_1:get(428578, {
			guild = self._guildSnapshot.name
		})
	elseif self._operationType == var_0_2.LAYOFF then
		return var_0_1:get(428579, {
			guild = self._guildSnapshot.name
		})
	elseif self._operationType == var_0_2.TRANSFER then
		return var_0_1:get(428574, {
			guild = self._guildSnapshot.name
		})
	elseif self._operationType == var_0_2.KICK then
		return var_0_1:get(428571, {
			guild = self._guildSnapshot.name
		})
	end

	return ""
end

function AllianceHallOperatePop:_updateLeftTime()
	local var_7_0 = var_0_5:getTime()

	if var_7_0 < self._cdEndTime then
		self.m_confirmBtn:setTitle(g.core.lang:get(428582, {
			time = self._cdEndTime - var_7_0
		}))
	else
		self:cancelSchedule(self._cdHandler)

		self._cdHandler = nil

		self.m_confirmBtn:setTitle(g.core.lang:get(1160))
	end
end

function AllianceHallOperatePop:onLoad()
	self:_updateLeftTime()

	self._cdHandler = self:newSchedule(handler(self, self._updateLeftTime), 1)
end

function AllianceHallOperatePop:_onClickConfirmBtn()
	if var_0_5:getTime() < self._cdEndTime then
		g.core.module.ModuleManager:tip(g.core.lang:get(428603))

		return
	end

	if self._onConfirm then
		self._onConfirm(self._guildSnapshot)
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function AllianceHallOperatePop:_onClickCancelBtn()
	self:_onClose()
end

function AllianceHallOperatePop:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return AllianceHallOperatePop
