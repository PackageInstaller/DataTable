local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.fragmentsData
local SuccubaPopNameComp = class("SuccubaPopNameComp", require("app.fairyGUI.succuba.UI_SuccubaPopNameComp"))

function SuccubaPopNameComp:ctor()
	self._succubaStruct = nil

	self:_initBtn()
end

function SuccubaPopNameComp:_initBtn()
	self.m_touchRect:addClickListener(handler(self, self._onAddBtnClick))
	self.m_addBtn:addClickListener(handler(self, self._onAddBtnClick))
end

function SuccubaPopNameComp:updateComp(arg_3_1)
	if not arg_3_1 then
		return
	end

	self._succubaStruct = arg_3_1

	self.m_nameComp:updateComp(arg_3_1)

	local var_3_0 = arg_3_1:getCurStarCfg()

	self.m_fragIcon:setURL((g.core.common.Path:getIconByTypeValue(var_0_0.TYPE_FRAGMENT, var_3_0.fragment, true)))
	self.m_fragNameText:setText(g.core.config.fragment_info.get(var_3_0.fragment).name)

	local var_3_1 = math.min(var_0_1:getFragmentNumById(var_3_0.fragment), var_3_0.next_star_num)

	self.m_progText:setText(var_3_1 .. "/" .. var_3_0.next_star_num)
	self.m_progBar:setPercent({
		init = 0,
		cur = var_3_1,
		max = var_3_0.next_star_num
	})
	self.m_stateController:setSelectedIndex(arg_3_1:isMaxStar() and 1 or 0)
end

function SuccubaPopNameComp:_onAddBtnClick()
	local var_4_0

	if not self._succubaStruct then
		do return end

		var_4_0 = {
			type = var_0_0.TYPE_FRAGMENT
		}
	end

	var_4_0.value = self._succubaStruct:getCurStarCfg().fragment

	g.view.entrance.ModuleGotoProxy:gotoModuleBySource(var_4_0)
end

return SuccubaPopNameComp
