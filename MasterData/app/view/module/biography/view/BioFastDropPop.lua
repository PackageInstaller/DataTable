local var_0_0 = g.core.model.User.bioData
local var_0_1 = 5
local BioFastDropPop = class("BioFastDropPop", require("app.fairyGUI.biography.UI_BioFastDropPop"), function()
	return fgui.GComponent:create({
		resName = "BioFastDropPop",
		pkgPath = "ui/biography/biography",
		pkgName = "biography"
	})
end)

function BioFastDropPop:ctor()
	self._group = 0
	self._data = {}

	self:showAtCenter()
	self:_initList()
	self.m_groupController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onGroupChange))
end

function BioFastDropPop:_initList()
	self.m_dropList:setVirtual()
	self.m_dropList:setItemRenderer(handler(self, self._onDropRenderer))
end

function BioFastDropPop:_onDropRenderer(arg_4_1, arg_4_2)
	if self._data[self._group] then
		arg_4_2:updateCell(self._data[self._group][arg_4_1 + 1])
	end
end

function BioFastDropPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_FASTEXECUTEMISSION, self.updateView, self)
	self:updateView()
end

function BioFastDropPop:updateView()
	self:updateData()
	self:updateList()
end

function BioFastDropPop:updateList()
	self._group = self.m_groupController:getSelectedIndex()

	local var_7_0 = 0

	if self._data[self._group] then
		var_7_0 = #self._data[self._group]
	end

	if var_7_0 > 0 then
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_dropList:setNumItems(var_7_0)
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end

	self.m_dropList:transitionShowCells("listIconUiScaleIn", 0.03, 1)
end

function BioFastDropPop:updateData()
	local var_8_1 = var_0_0:getFastData():getDropData()

	if var_8_1 then
		for iter_8_0 = 0, var_0_1 - 1 do
			self._data[iter_8_0] = {}
		end

		local var_8_2 = {}

		for iter_8_1, iter_8_2 in pairs(var_8_1) do
			for iter_8_3, iter_8_4 in pairs(iter_8_2) do
				table.insert(var_8_2, iter_8_4)
			end
		end

		table.sort(var_8_2, function(arg_9_0, arg_9_1)
			if arg_9_0.drop.type ~= arg_9_1.drop.type then
				return arg_9_0.drop.type > arg_9_1.drop.type
			end

			if arg_9_0.drop.quality ~= arg_9_1.drop.quality then
				return arg_9_0.drop.quality > arg_9_1.drop.quality
			end

			return arg_9_0.drop.value > arg_9_1.drop.value
		end)

		for iter_8_5, iter_8_6 in ipairs(var_8_2) do
			if iter_8_6.drop.type == 2 then
				table.insert(self._data[iter_8_6.drop.group], iter_8_6)
			else
				for iter_8_7 = 1, var_0_1 - 1 do
					table.insert(self._data[iter_8_7], iter_8_6)
				end
			end
		end

		self._data[0] = var_8_2
	end
end

function BioFastDropPop:_onGroupChange()
	self:updateList()
end

return BioFastDropPop
