local MonopolyConst = require("app.view.module.monopoly.const.MonopolyConst")
local var_0_1 = g.core.model.User.monopolyDataMgr
local MonopolyGridInfoComp = class("MonopolyGridInfoComp", require("app.fairyGUI.monopoly.UI_MonopolyGridInfoComp"))

function MonopolyGridInfoComp:ctor()
	self:addClickListener(handler(self, self._onGridClick))
end

function MonopolyGridInfoComp:_onGridClick()
	self:setVisible(true)
end

function MonopolyGridInfoComp:updateGridInfo(arg_3_1)
	self.m_enterTransition:play()
	self.m_title:setText(arg_3_1.cfg.des)

	if arg_3_1.cfg.type == MonopolyConst.EVENT_TYPE.START then
		self.m_typeController:setSelectedIndex(0)

		return
	end

	local var_3_0 = var_0_1:getMonopolyData()
	local var_3_1 = var_3_0:getGridLvCfg(arg_3_1.cfg.type, arg_3_1.level)

	if var_3_1.type == MonopolyConst.EVENT_TYPE.BEHIND_GRIDS or var_3_1.type == MonopolyConst.EVENT_TYPE.FRONT_GRIDS then
		local var_3_2 = var_3_0:getGridLvCfg(arg_3_1.cfg.type, arg_3_1.level + 1)

		self.m_isMaxController:setSelectedIndex(var_3_2 and 0 or 1)
		self.m_typeController:setSelectedIndex(1)

		if var_3_1.type == MonopolyConst.EVENT_TYPE.BEHIND_GRIDS then
			self.m_moveDesc1:setText(g.core.lang:get(431106, {
				num = var_3_1.value
			}))

			if var_3_2 then
				self.m_moveDesc2:setText(g.core.lang:get(431107, {
					num = var_3_2.value
				}))
			end
		else
			self.m_moveDesc1:setText(g.core.lang:get(431104, {
				num = var_3_1.value
			}))

			if var_3_2 then
				self.m_moveDesc2:setText(g.core.lang:get(431105, {
					num = var_3_2.value
				}))
			end
		end
	else
		local var_3_3 = var_3_0:getGridLvCfg(arg_3_1.cfg.type, arg_3_1.level + 1)

		self.m_isMaxController:setSelectedIndex(var_3_3 and 0 or 1)
		self.m_typeController:setSelectedIndex(2)

		local var_3_4 = g.core.common.Goods:convert({
			type = var_3_1.reward_type_1,
			value = var_3_1.reward_value_1
		})

		self.m_desc1_1:enableRich()
		self.m_desc1_1:setText(("<img src='common/" .. var_3_4.icon_mini .. "' width='27'height='27'/>") .. "x" .. var_3_1.reward_size_1)

		if var_3_3 then
			self.m_desc2_1:enableRich()
			self.m_desc2_1:setText(("<img src='common/" .. var_3_4.icon_mini .. "' width='27'height='27'/>") .. "x" .. var_3_3.reward_size_1)
		end
	end
end

return MonopolyGridInfoComp
