local var_0_0 = g.core.const.ConstMgr.SpiritHelpConst
local var_0_1 = g.core.model.User.spiritHelpData
local var_0_2 = g.core.config.spirit_help_info
local SpiritHelpLogCell = class("SpiritHelpLogCell", require("app.fairyGUI.spiritHelp.UI_SpiritHelpLogCell"))
local var_0_4 = 150
local var_0_5 = 120

function SpiritHelpLogCell:ctor()
	self._awardList = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListRenderer))
end

function SpiritHelpLogCell:_onAwardListRenderer(arg_2_1, arg_2_2)
	arg_2_2:updateIcon(self._awardList[arg_2_1 + 1])
end

function SpiritHelpLogCell:updateLogCell(arg_3_1)
	if arg_3_1.isEnd then
		return
	end

	self.m_nameText:setText(var_0_2.get(arg_3_1.spiritId).name)

	self._awardList = var_0_1:mergeSameItem(arg_3_1.awardList or {})

	if #self._awardList > 0 then
		self.m_awardList:setNumItems(#self._awardList)
		self.m_hasAwardController:setSelectedIndex(1)
	else
		self.m_hasAwardController:setSelectedIndex(0)
	end

	local var_3_0 = false

	self.m_effectNode:removeAllEffect()

	if arg_3_1.doingState == var_0_0.DOING_STATE.SUCCESS then
		self.m_doingStateController:setSelectedIndex(1)

		if type(arg_3_1.awardText) == "table" and arg_3_1.awardText.langId then
			var_3_0 = true

			self.m_awardText:setText(g.core.lang:get(arg_3_1.awardText.langId, arg_3_1.awardText.param))
		else
			self.m_awardText:setText("")
		end

		if type(arg_3_1.costText) == "table" and arg_3_1.costText.langId then
			var_3_0 = true

			self.m_costText:setText(g.core.lang:get(arg_3_1.costText.langId, arg_3_1.costText.param))
		else
			self.m_costText:setText("")
		end

		self:setHeight((var_3_0 or nil) and (var_0_4 or var_0_5))
	elseif arg_3_1.doingState == var_0_0.DOING_STATE.FAIL then
		self.m_doingStateController:setSelectedIndex(2)
		self.m_failText:setText((g.core.config.net_msg_error.fetch(arg_3_1.failText) or {}).error_msg or g.core.lang:get(409507))
		self:setHeight(var_0_5)
	else
		self.m_effectNode:addEffectSpine({
			anim = "play",
			name = "eff_ui_spiritHelp_playing",
			scale = 1,
			isLoop = true
		})
		self.m_doingStateController:setSelectedIndex(0)
		self:setHeight(var_0_5)
	end

	self.m_bottomShowController:setSelectedIndex(var_3_0 and 1 or 0)
end

return SpiritHelpLogCell
