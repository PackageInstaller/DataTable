local var_0_0 = g.core.config.palace_info
local var_0_1 = g.core.lang
local var_0_2 = g.core.common.Path
local EchoLabTreeActivePop = class("EchoLabTreeActivePop", require("app.fairyGUI.echoLab.UI_EchoLabTreeActiveComp"))

function EchoLabTreeActivePop:ctor()
	self._talentId = 0
end

function EchoLabTreeActivePop:update(arg_2_1)
	if not arg_2_1.talent then
		return
	end

	self._talentId = arg_2_1.talent:getId()

	if arg_2_1.talent:isBig() then
		self.m_isBigController:setSelectedIndex(1)

		local var_2_0 = var_0_0.get(arg_2_1.talent:getInfo().palace_id)

		if var_2_0.palace_grade == 1 then
			self.m_descText:setText(var_0_1:get(408505))
			self.m_levelGroup:setVisible(false)
		else
			self.m_levelGroup:setVisible(true)
			self.m_descText:setText(var_0_1:get(408506))
			self.m_levelText:setText(var_0_1:get(109501, {
				level = var_2_0.palace_grade
			}))
		end
	else
		self.m_isBigController:setSelectedIndex(0)
		self.m_nameText:setText(arg_2_1.talent:getName())

		local var_2_1 = arg_2_1.talent:getAttrList()

		self.m_talentIcon:setURL(var_0_2:getEchoLabTalent256Icon(arg_2_1.talent:getInfo()))

		local var_2_2 = ""

		for iter_2_0, iter_2_1 in ipairs(var_2_1) do
			local var_2_3, var_2_4 = var_0_1:getAttr(iter_2_1.type, iter_2_1.value, false)

			var_2_2 = var_2_2 .. var_0_1:get(408502, {
				attrName = g.core.lang:get(2071, {
					name = var_2_3
				}),
				attrValue = var_2_4
			})

			if iter_2_0 ~= #var_2_1 then
				var_2_2 = var_2_2 .. ","
			end
		end

		self.m_attrText:setText(var_2_2)
	end
end

function EchoLabTreeActivePop:playAnimate()
	self.m_enterTransition:play()
	self.m_eff:addEffectSpine({
		scale = 1,
		remove = false,
		isLoop = false,
		name = "eff_ui_common_singlereward"
	})
end

function EchoLabTreeActivePop:onUnload()
	if self._talentId > 0 then
		self:dispatchCompEvent("active_comp_end", {
			id = self._talentId
		})
	end
end

return EchoLabTreeActivePop
