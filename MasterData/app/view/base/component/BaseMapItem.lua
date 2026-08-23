local BaseConst = require("app.view.base.const.BaseConst")
local var_0_1 = g.core.model.User.bioData
local BaseMapItem = class("BaseMapItem", require("app.fairyGUI.base_new.UI_BaseMapItem"))

function BaseMapItem:ctor()
	self._index = nil
	self._unlock = nil

	self:_bindCommonEvents()
end

function BaseMapItem:_bindCommonEvents()
	self:addClickListener(handler(self, self._onClick))
end

function BaseMapItem:_onClick()
	if self._unlock == 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(105027))

		return
	end

	self.m_onfocusController:setSelectedIndex(1)
end

function BaseMapItem:update(arg_4_1, arg_4_2)
	if arg_4_2 == BaseConst.mapCompConst.WARRIORS then
		self._index = arg_4_1.id
		self._unlock = arg_4_1.unlock

		self:setTitle(arg_4_1.title)
		self.m_chapterNumText:setText(arg_4_1.num)
	elseif arg_4_2 == BaseConst.mapCompConst.BIOGRAPHY then
		self._unlock = arg_4_1.unlock

		self:setTitle(g.core.lang:get(302002, {
			num = arg_4_1.number
		}) .. " " .. arg_4_1.name)

		if arg_4_1.finish or arg_4_1.fighting then
			local var_4_0 = 0
			local var_4_1 = 0

			for iter_4_0, iter_4_1 in ipairs(arg_4_1.chapters) do
				var_4_0 = var_4_0 + var_0_1:getChapterCurPro(iter_4_1)
				var_4_1 = var_4_1 + var_0_1:getChapterMaxPro(iter_4_1)
			end

			self.m_chapterNumText:setText(g.core.lang:get(302080, {
				num = string.format("%.1f", var_4_0 / var_4_1 * 100) .. "%"
			}))
		end
	end

	if self._unlock == 1 then
		self.m_onfocusController:setSelectedIndex(2)
		self.m_chapterNumText:setText(g.core.lang:get(302062))
	else
		self.m_onfocusController:setSelectedIndex(arg_4_1.onfocus)
	end
end

return BaseMapItem
