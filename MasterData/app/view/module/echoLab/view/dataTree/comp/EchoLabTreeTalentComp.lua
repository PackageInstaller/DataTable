local var_0_0 = g.core.common.Path
local var_0_1 = g.core.const.ConstMgr.EchoLabConst
local var_0_2 = g.core.model.User.echoLabData
local EchoLabTreeTalentComp = class("EchoLabTreeTalentComp", require("app.fairyGUI.echoLab.UI_EchoLabTreeTalentComp"))

function EchoLabTreeTalentComp:ctor()
	self._talentId = 0
	self._selectEffect = nil
	self._bigNodeEffect = nil
	self._preLineController = self.m_preLine:getController("line")
	self._nextLineController = self.m_nextLine:getController("line")
end

function EchoLabTreeTalentComp:setClickState(arg_2_1)
	self.m_showTypeController:setSelectedIndex(arg_2_1 and 1 or 0)
	self:updateSelectEffect(arg_2_1)
end

function EchoLabTreeTalentComp:getNextLineWidth()
	return var_0_2:getTreeData():getTalentById(self._talentId):getNextLineWidth()
end

function EchoLabTreeTalentComp:refreshComp(arg_4_1)
	if self._talentId > 0 then
		self:updateCompByStruct(var_0_2:getTreeData():getTalentById(self._talentId))
	end

	if arg_4_1 and arg_4_1 == self._talentId then
		self.m_effState:addEffectSpine({
			anim = "play",
			name = "eff_ui_echoLab_up",
			isLoop = false,
			remove = true,
			eventHandler = handler(self, self._activeEffectEnd)
		})
	end
end

function EchoLabTreeTalentComp:_activeEffectEnd(arg_5_1)
	if arg_5_1.type == "complete" then
		self:dispatchCompEvent("active_effect_end", {
			id = self._talentId
		})
	end
end

function EchoLabTreeTalentComp:updateCompByStruct(arg_6_1, arg_6_2)
	self._talentId = arg_6_1:getId()

	if arg_6_2 then
		self:setClickState(arg_6_2 == self._talentId)
	end

	self:updateLine(arg_6_1)
	self:updateIconBg(arg_6_1)
	self:updateActive(arg_6_1)
	self:updateNodeType(arg_6_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			talentId = self._talentId
		}
	})
end

function EchoLabTreeTalentComp:updateNodeType(arg_7_1)
	local var_7_0 = arg_7_1:getNodeType()

	self.m_nodeTypeController:setSelectedIndex(var_7_0)
	self.m_icon:setURL(var_0_0:getEchoLabTalentIcon(arg_7_1:getIcon(), var_7_0))

	if var_7_0 == var_0_1.NODE_TYPE1.VALUE2 and not arg_7_1:isActive() then
		self._bigNodeEffect = self._bigNodeEffect or self.m_effState:addEffectSpine({
			anim = "play",
			name = "eff_ui_echoLab_down",
			isLoop = true
		})
	else
		self._bigNodeEffect = nil

		self.m_effState:removeAllEffect()
	end
end

function EchoLabTreeTalentComp:updateIconBg(arg_8_1)
	if arg_8_1:isBig() then
		self.m_bg:setURL("ui://echoLab/pic_echo_sjs_1")
	elseif arg_8_1:getNodeType() == var_0_1.NODE_TYPE1.VALUE1 then
		if arg_8_1:getInfo().node_type_2 == var_0_1.NODE_TYPE2.VALUE1 then
			self.m_bg:setURL("ui://echoLab/pic_echo_sjs_3")
		else
			self.m_bg:setURL("ui://echoLab/pic_echo_sjs_5")
		end
	elseif arg_8_1:getInfo().node_type_2 == var_0_1.NODE_TYPE2.VALUE1 then
		self.m_bg:setURL("ui://echoLab/pic_echo_sjs_2")
	else
		self.m_bg:setURL("ui://echoLab/pic_echo_sjs_4")
	end
end

function EchoLabTreeTalentComp:updateLine(arg_9_1)
	self._preLineController:setSelectedIndex(arg_9_1:getPreLineType())
	self._nextLineController:setSelectedIndex(arg_9_1:getNextLineType())
end

function EchoLabTreeTalentComp:updateSelectEffect(arg_10_1)
	if arg_10_1 then
		self._selectEffect = self._selectEffect or self.m_effSelect:addEffectSpine({
			anim = "play",
			name = "eff_ui_echoLab_select",
			isLoop = true
		})

		self._selectEffect:setVisible(true)
	elseif self._selectEffect then
		self._selectEffect:setVisible(false)
	end
end

function EchoLabTreeTalentComp:getId()
	return self._talentId
end

function EchoLabTreeTalentComp:updateActive(arg_12_1)
	self.m_isActiveController:setSelectedIndex(arg_12_1:isActive() and 1 or 0)
end

return EchoLabTreeTalentComp
