local var_0_1 = g.core.model.User
local PAPeakStageHeadComp = class("PAPeakStageHeadComp", require("app.fairyGUI.peakArena.UI_PAPeakStageHeadComp"))

function PAPeakStageHeadComp:ctor()
	self._userSnapshot = nil

	self.m_myselfController:setSelectedIndex(0)
	self.m_stateController:setSelectedIndex(0)

	local var_1_0, var_1_1 = string.match(self:getName(), ".+(%d)_(%d)")

	self.m_headCutComp:addClickListener(handler(self, self._onClickHead))
	self.m_cheerBtn:getChild("cheerBtn"):addClickListener(handler(self, self._onClickCheer))
end

function PAPeakStageHeadComp:_onClickCheer()
	if self._userSnapshot then
		g.core.network.GameNetProxy:send_C2S_PeakArena_Cheer({
			target_id = self._userSnapshot.id
		})
	end
end

function PAPeakStageHeadComp:_onClickHead(arg_3_1)
	if not self._userSnapshot then
		return
	elseif self._userSnapshot.id == var_0_1:getId() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
			isSelf = true
		})
	else
		local var_3_0

		if arg_3_1 then
			var_3_0 = {}

			local var_3_1 = arg_3_1:getInput():getTouch()

			var_3_0.x = var_3_1:getLocationInView().x
			var_3_0.y = var_3_1:getLocationInView().y
		end

		local var_3_2 = clone(self._userSnapshot)

		if var_3_2.guild_id and var_3_2.guild_id == 0 then
			var_3_2.guild_id = -1
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.InfoUserMenuPop").new({
			playerInfo = {
				user = var_3_2
			},
			clickWorldPos = var_3_0
		}), {
			isUpdateBlack = false,
			hideContinue = true
		})
	end
end

function PAPeakStageHeadComp:updateComp(arg_4_1, arg_4_2)
	self._userSnapshot = arg_4_2

	self.m_stateController:setSelectedIndex(arg_4_1)
	self.m_cheerGroup:setVisible(false)

	if arg_4_2 then
		local var_4_0 = arg_4_2.id == var_0_1:getId()

		self.m_myselfController:setSelectedIndex(var_4_0 and 1 or 0)

		local var_4_1 = self.m_headCutComp:getChild("icon")

		if var_4_0 then
			var_4_1:updateAsUser(var_0_1:packUser())
		else
			var_4_1:updateAsUser(arg_4_2)
		end

		self.m_nameTxt:setText((g.core.utils.String.transRobotName(arg_4_2)))
		self:updateCheer()
	else
		self.m_myselfController:setSelectedIndex(0)
		self.m_cheerGroup:setVisible(false)
		self.m_alliance:setText("")
	end
end

function PAPeakStageHeadComp:updateCheer()
	local var_5_0 = self.m_stateController:getSelectedIndex()
	local var_5_1 = self._userSnapshot

	if var_0_1.peakArenaData:isCheerActive() then
		local var_5_2 = false
		local var_5_3 = var_0_1.peakArenaData:isUserCheer(var_5_1.id)

		if var_5_1.alliance_id and var_5_1.alliance_id > 0 then
			self.m_alliance:setText(var_5_1.alliance_name or "")

			var_5_2 = var_5_1.alliance_id == var_0_1:getAllianceId()
		else
			self.m_alliance:setText(g.core.lang:get(307064))
		end

		local var_5_5 = var_5_0 == 1
		local var_5_6 = g.core.common.ServerTime:getTime()
		local var_5_7 = var_0_1.peakArenaData:getGroupStageEndTime() <= var_5_6 and var_5_6 < var_0_1.peakArenaData:getFinalStageEndTime()

		self.m_cheerGroup:setVisible(var_5_0 == 1 and var_5_7)

		if var_5_5 and var_5_7 then
			self.m_cheerBtn:setVisible(var_5_2 and not var_5_3 and var_0_1.peakArenaData:getOwnCheerCount() > 0)
		end

		self.m_cheerNum:setText(var_0_1.peakArenaData:getCheerCount(var_5_1.id))
	else
		self.m_cheerGroup:setVisible(false)
		self.m_alliance:setText("")
	end
end

function PAPeakStageHeadComp:getUserId()
	return (self._userSnapshot or nil) and (self._userSnapshot.id or 0)
end

function PAPeakStageHeadComp:updateCD(arg_7_1, arg_7_2)
	if arg_7_1 then
		self.m_cdTxt:setText(arg_7_2)
		self.m_showCDController:setSelectedIndex(1, false)
	else
		self.m_showCDController:setSelectedIndex(0, false)
	end
end

return PAPeakStageHeadComp
