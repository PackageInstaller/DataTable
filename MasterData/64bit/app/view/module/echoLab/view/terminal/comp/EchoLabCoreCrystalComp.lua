local var_0_0 = g.core.model.User.echoLabData
local var_0_1 = g.core.const.ConstMgr.EchoLabConst
local EchoLabCoreCrystalComp = class("EchoLabCoreCrystalComp", require("app.fairyGUI.echoLab.UI_EchoLabCoreCrystalComp"))

function EchoLabCoreCrystalComp:ctor()
	self.m_eff:removeAllEffect()
	self.m_eff:addEffectSpine({
		isLoop = true,
		name = "eff_ui_echoLab_crystal",
		anim = "play"
	})
	self.m_lookBtn:addClickListener(handler(self, self._onClickLookBtn))
end

function EchoLabCoreCrystalComp:updateMainView()
	self:updateCoreAttrView((var_0_0:getAllAttrSumData()))
end

function EchoLabCoreCrystalComp:updateCoreComp(arg_3_1, arg_3_2)
	self:updateCoreAttrView(var_0_0:getAttrSumDataByCardType(arg_3_2), arg_3_1)
end

function EchoLabCoreCrystalComp:updateCoreAttrView(arg_4_1, arg_4_2)
	self.m_lvTxt:setText((var_0_0:getPalaceId()))

	local var_4_0 = 0

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		local var_4_2, var_4_3 = g.core.lang:getAttr(iter_4_0, iter_4_1, true)

		var_4_0 = var_4_0 + 1

		self["m_attrIconLoader" .. var_4_0]:setURL(g.core.common.Path:getAttrIconByName(g.core.config.attribute_info.get(iter_4_0).icon .. "_2"))
		self["m_descTxt" .. var_4_0]:setText(g.core.lang:get(408904, {
			name = var_4_2,
			num = var_4_3
		}))
	end

	if arg_4_2 and var_4_0 == 0 then
		self.m_descTxt1:setText(var_0_1.EchoLabNameArray[arg_4_2].defaultAttr)
		self.m_moreAttrController:setSelectedIndex(0)
		self.m_attrIconLoader1:setURL(g.core.common.Path:getAttrIconByName(g.core.config.attribute_info.get(var_0_1.EchoLabNameArray[arg_4_2].attrId).icon .. "_2"))
	end

	self.m_moreAttrController:setSelectedIndex(var_4_0 > 1 and 1 or 0)
end

function EchoLabCoreCrystalComp:_onClickLookBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.echoLab.view.terminal.EchoLabLevelUpDetailsPop").new()))
end

function EchoLabCoreCrystalComp:playUpEff()
	self.m_upEff:removeAllEffect()
	self.m_upEff:addEffectSpine({
		isLoop = false,
		name = "eff_ui_echoLab_txt",
		anim = "play"
	})
end

return EchoLabCoreCrystalComp
