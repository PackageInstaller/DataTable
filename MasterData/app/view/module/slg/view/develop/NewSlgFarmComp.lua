local NewSlgFarmComp = class("NewSlgFarmComp", require("app.fairyGUI.newSlg.UI_NewSlgFarmComp"))

function NewSlgFarmComp:ctor()
	self._farmCompCfg = nil

	self:addClickListener(handler(self, self._onFarmClick))
end

function NewSlgFarmComp:updateFarmItem(arg_2_1)
	self._farmCompCfg = g.core.model.User.newSlgData:getFarmComponentById(arg_2_1.farm_id)

	local var_2_0 = g.core.model.User.newSlgData:getFarmInfoById(arg_2_1.farm_id)

	self.m_nameTxt:setText("Lv." .. var_2_0.level .. var_2_0.name)
	self.m_farmLoader:setURL(g.core.common.Path:getNewSlgFarm(var_2_0.res))
end

function NewSlgFarmComp:_onFarmClick()
	if self._farmCompCfg then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(1257),
			desc = g.core.lang:get(429724),
			onConfirm = handler(self, self._onConfirm)
		}), {
			touchDisappear = true
		})
	end
end

function NewSlgFarmComp:_onConfirm()
	self:dispatchCompEvent("NEW_SLG_GO_TO_FARM_1", {
		pos = cc.p(self._farmCompCfg.anchor_x, self._farmCompCfg.anchor_y)
	})
end

return NewSlgFarmComp
