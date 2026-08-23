local var_0_0 = 10
local var_0_1 = 0.05
local BaseAwardPanel = class("BaseAwardPanel", require("app.fairyGUI.base_new.UI_BaseAwardPanel"))
local var_0_3 = g.core.common.Goods

function BaseAwardPanel:update(arg_1_1)
	if arg_1_1 then
		self._params = arg_1_1.data or {}
	end

	self._tipsText = arg_1_1.tips
	self._items = {}

	self.m_awardList:setIniter(self)
	self.m_awardList:setItemRenderer(handler(self, self._onItemRender))
	self:_initView()
end

function BaseAwardPanel:_initView()
	self.m_awardList:setNumItems(#self._params)

	if self._tipsText then
		self.m_showTipsController:setSelectedIndex(1)
		self.m_tipsText:setText(self._tipsText)
	else
		self.m_showTipsController:setSelectedIndex(0)
	end
end

function BaseAwardPanel:_onItemRender(arg_3_1, arg_3_2)
	local var_3_0 = self._params[arg_3_1 + 1]

	var_3_0.nameRow = self._params[arg_3_1 + 1].nameRow or 2

	arg_3_2:updateIcon(var_3_0)

	local var_3_1 = var_0_3:checkGoodsRare(var_3_0.type, var_3_0.value, var_3_0.size, arg_3_1) > 0

	if var_3_0.isRare then
		-- block empty
	end

	if arg_3_1 < var_0_0 then
		arg_3_2:setVisible(false)
	end

	table.insert(self._items, arg_3_2)
end

function BaseAwardPanel:playAnimate()
	for iter_4_0 = 1, #self._items < var_0_0 and #self._items or var_0_0 do
		self:_showItem(self._items[iter_4_0], iter_4_0 - 1)
	end
end

function BaseAwardPanel:_showItem(arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1

	self:runFGAction((fgui.FSequence:create(fgui.FDelayTime:create(arg_5_2 * var_0_1), (fgui.FCallFunc:create(function()
		var_5_0:playIconEffect(nil, 0.08)
		var_5_0:setVisible(true)
	end)))))
end

return BaseAwardPanel
