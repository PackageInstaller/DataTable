local SuccubaMainInfoComp = class("SuccubaMainInfoComp", require("app.fairyGUI.succuba.UI_SuccubaMainInfoComp"))

function SuccubaMainInfoComp:ctor()
	self._succuba = nil

	self.m_detailBtn:addClickListener(handler(self, self._onDetailBtnClicked))
end

function SuccubaMainInfoComp:updateCompUI(arg_2_1)
	if arg_2_1 then
		self._succuba = arg_2_1
	end

	self:refreshCompUI()
end

function SuccubaMainInfoComp:refreshCompUI()
	self.m_levelComp:setTitle((self._succuba:getInteractionLevel()))
	self.m_nameTxt:setText(self._succuba:getCurCfg().name)

	local var_3_0 = self._succuba:getInteractionExp()
	local var_3_1 = self._succuba:getCurInteractionCfg().exp

	if var_3_1 == 0 then
		self.m_expTxt:setVisible(false)
		self.m_probar:setVisible(false)
	else
		self.m_expTxt:setText(g.core.lang:get(201607, {
			num = var_3_0,
			max = var_3_1
		}))
		self.m_probar:setMax(var_3_1)
		self.m_probar:setValue(var_3_0)
		self.m_expTxt:setVisible(true)
		self.m_probar:setVisible(true)
	end
end

function SuccubaMainInfoComp:_onDetailBtnClicked()
	if not self._succuba then
		return
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.module.succuba.view.mainComp.SuccubaMainInfoPop").new(self._succuba)))
end

return SuccubaMainInfoComp
