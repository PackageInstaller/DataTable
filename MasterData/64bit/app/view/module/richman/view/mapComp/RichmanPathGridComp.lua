local var_0_0 = g.core.config.richman_event_info
local RichmanConst = require("app.view.module.richman.const.RichmanConst")
local var_0_2 = g.core.model.User.richmanData
local RichmanPathGridComp = class("RichmanPathGridComp", require("app.fairyGUI.richman.UI_RichmanPathGridComp"))

function RichmanPathGridComp:changeGridType(arg_1_1)
	self._gridCfg = arg_1_1

	self.m_typeController:setSelectedIndex(arg_1_1.type - 1)
	self:updateGridShow()
end

function RichmanPathGridComp:updateGridShow(arg_2_1)
	self.m_iconLoader:setURL("")

	if self._gridCfg then
		if arg_2_1 then
			self.m_effRefreshHolder:addEffectSpine({
				name = "eff_ui_richman_bg",
				isLoop = false,
				remove = true,
				eventHandler = handler(self, self._onAnimationEnd)
			})
		else
			self:updateGridIcon()
		end
	end
end

function RichmanPathGridComp:_onAnimationEnd(arg_3_1)
	if arg_3_1.type == "event" and arg_3_1.eventData.name == "cut" then
		self:updateGridIcon()
	end
end

function RichmanPathGridComp:updateGridIcon()
	self.m_typeController:setSelectedIndex(self._gridCfg.type - 1)

	if self._gridCfg.type == RichmanConst.GRID_TYPE.STEAL_RESOURCE_GRID then
		self.m_effHolder:addEffectSpine({
			name = "eff_ui_richman_tranmitIcon",
			isLoop = true
		})

		return
	else
		self.m_effHolder:removeAllEffect()
	end

	local var_4_0 = var_0_2:getRandGridEvent(self._gridCfg.id)

	if var_4_0 then
		local var_4_1 = "pic_dfw_zjm_dikuai_" .. var_0_0.get(var_4_0).res

		if var_4_1 then
			self.m_iconLoader:setURL("ui_cocos/richman/" .. var_4_1 .. ".png")
		end
	else
		local var_4_2 = RichmanConst.GRID_ICON[tostring(self._gridCfg.type)]

		if var_4_2 then
			self.m_iconLoader:setURL("ui_cocos/richman/" .. var_4_2 .. ".png")
		end
	end
end

return RichmanPathGridComp
