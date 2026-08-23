local GveHalidomInfoPop = require("app.view.module.gve.view.gveBag.GveHalidomInfoPop")
local var_0_1 = g.core.common.Path
local GveHalidomItem = class("GveHalidomItem", require("app.fairyGUI.gve.UI_GveHalidomItem"))

function GveHalidomItem:ctor(arg_1_1)
	self._halidom = {}

	self:_initView()
end

function GveHalidomItem:_initView()
	self:addClickListener(handler(self, self._onClickItem))
end

function GveHalidomItem:onLoad()
	return
end

function GveHalidomItem:updateView(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	if arg_4_3 then
		self:setTouchable(true)
	else
		self:setTouchable(false)
	end

	self._needNum = arg_4_2
	self._halidom = arg_4_1

	self.m_icon:setURL((var_0_1:getHalidom128ById((self._halidom:getIcon()))))
	self.m_levelText:setText(g.core.lang:get(100535, {
		lv = self._halidom:getLevel()
	}))

	if self._halidom:getIsEquip() then
		self.m_halidomTypeController:setSelectedIndex(1)
	else
		self.m_halidomTypeController:setSelectedIndex(0)
	end

	if arg_4_4 then
		if arg_4_2 then
			self.m_awardCountTxt:setText(self._halidom:getNum() .. "/" .. arg_4_2)
		else
			self.m_awardCountTxt:setText("x" .. self._halidom:getNum())
		end

		self.m_showTagController:setSelectedIndex(0)
	else
		self.m_showTagController:setSelectedIndex(1)
		self.m_awardCountTxt:setText("")
	end

	if arg_4_5 then
		self.m_showNameController:setSelectedIndex(1)
		self.m_nameText:setText((self._halidom:getName()))
	else
		self.m_showNameController:setSelectedIndex(0)
	end
end

function GveHalidomItem:_onClickItem()
	if self._halidom:getIsEquip() then
		g.core.module.ModuleManager:pushPopup(GveHalidomInfoPop.new(self._halidom))
	else
		g.core.module.ModuleManager:pushPopup(GveHalidomInfoPop.new(self._halidom))
	end
end

return GveHalidomItem
