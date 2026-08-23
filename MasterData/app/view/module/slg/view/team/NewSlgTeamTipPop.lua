local var_0_0 = g.core.config.new_slg_element_info
local NewSlgTeamTipPop = class("NewSlgTeamTipPop", require("app.fairyGUI.newSlg.UI_NewSlgTeamTipPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgTeamTipPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgTeamTipPop:ctor(arg_2_1)
	self:showAtCenter()

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_1 = g.core.common.GlobalFunc.getStructByTypeAndSerId(g.core.common.Goods.TYPE_KNIGHT, iter_2_1.id)

		if var_2_1 then
			local var_2_2 = var_2_1:getBaseInfo().classical

			if var_2_2 ~= 0 then
				var_2_0[#var_2_0 + 1] = var_2_2
			end
		end
	end

	local var_2_3, var_2_4, var_2_5 = g.core.model.User.newSlgData:getTeamElementTypeAndAffectValue(var_2_0)

	self._teamElem = var_2_3
	self._matchIndex = var_2_5.matchIndex

	if self._teamElem ~= 0 then
		self.m_elemIcon:setURL((g.core.common.Path:getBigElementIcon(var_2_3)))
		self.m_hasElemController:setSelectedIndex(1)
	else
		self.m_hasElemController:setSelectedIndex(0)
	end

	self.m_elemNumTxt:setText(g.core.lang:get(429766, {
		num = var_2_5.matchNum
	}))
	self:_initList()
	self.m_closeBtn:addClickListener(handler(self, self._onClickCloseBtn))
end

function NewSlgTeamTipPop:_initList()
	self.m_desList:setVirtual(self)
	self.m_desList:setItemRenderer(handler(self, self._onRenderDesCell))
end

function NewSlgTeamTipPop:onLoad()
	self.m_desList:setNumItems(var_0_0.getLength())
end

function NewSlgTeamTipPop:_onRenderDesCell(arg_5_1, arg_5_2)
	arg_5_2:updateTipCell({
		cfg = var_0_0.indexOf(arg_5_1 + 1),
		isMatch = self._matchIndex >= arg_5_1 + 1
	})
end

function NewSlgTeamTipPop:_onClickCloseBtn()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return NewSlgTeamTipPop
