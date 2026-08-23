local TreeUnit = require("app.core.utils.tree.TreeUnit")
local TreeSingle = require("app.core.utils.tree.TreeSingle")
local TreeSingleComp = class("TreeSingleComp", require("app.fairyGUI.base_new.UI_BaseTreeSingleComp"))

function TreeSingleComp:ctor()
	self._observer = nil
	self._treeData = nil
	self._tempOptUnit = nil
	self._curTreeIdx = nil
	self._mainIndexMap = {}

	self:_initDefaultData()
	self:_initRegisterUI()
end

function TreeSingleComp:startUp(arg_2_1)
	self._observer = arg_2_1
end

function TreeSingleComp:refreshUI()
	self.m_treeList:setNumItems(self._treeData:getCount())
end

function TreeSingleComp:cleanTree()
	self._treeData:cleanAll()
end

function TreeSingleComp:pushMainElem(arg_5_1)
	local var_5_0 = TreeUnit.new()

	var_5_0:setElemData(arg_5_1)
	self._treeData:addChildUnit(var_5_0)

	self._tempOptUnit = var_5_0
end

function TreeSingleComp:frontMainElem(arg_6_1)
	local var_6_0 = TreeUnit.new()

	var_6_0:setElemData(arg_6_1)
	self._treeData:frontChildUnit(var_6_0)

	self._tempOptUnit = var_6_0
end

function TreeSingleComp:pushSubElem(arg_7_1)
	local var_7_0 = TreeUnit.new()

	var_7_0:setElemData(arg_7_1)
	self._tempOptUnit:addChildUnit(var_7_0)
end

function TreeSingleComp:frontSubElem(arg_8_1)
	local var_8_0 = TreeUnit.new()

	var_8_0:setElemData(arg_8_1)
	self._tempOptUnit:frontChildUnit(var_8_0)
end

function TreeSingleComp:setSelectTreeIndex(arg_9_1)
	if self._curTreeIdx == arg_9_1 then
		return
	end

	local var_9_0 = self._treeData:openClick(arg_9_1 + 1)

	if var_9_0 ~= nil then
		self.m_treeList:setNumItems(0)
		self.m_treeList:setNumItems(self._treeData:getCount())

		arg_9_1 = self._treeData:getIndex(var_9_0)
		arg_9_1 = arg_9_1 == nil and 0 or arg_9_1 - 1
	end

	if self.m_treeList:getSelectedIndex() ~= arg_9_1 then
		self.m_treeList:setSelectedIndex(arg_9_1)
	end

	self._curTreeIdx = arg_9_1

	if self._observer and self._observer.onTreeSelectChange then
		local var_9_1 = self._treeData:getUnit(self._curTreeIdx + 1)

		if var_9_1 then
			self._observer:onTreeSelectChange(var_9_1:getElem())
		end
	end
end

function TreeSingleComp:_initDefaultData()
	self._treeData = TreeSingle.new()
	self._tempOptUnit = nil
	self._curTreeIdx = nil
end

function TreeSingleComp:_initRegisterUI()
	self.m_treeList:setVirtual()
	self.m_treeList:setItemProvider(handler(self, self._onTreeItemTempl))
	self.m_treeList:setItemRenderer(handler(self, self._onTreeItemUpdate))
	self.m_treeList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTreeItemClick))
end

function TreeSingleComp:_onTreeItemTempl(arg_12_1)
	return self._treeData:getUnit(arg_12_1 + 1):getElem():getTemplate()
end

function TreeSingleComp:_onTreeItemUpdate(arg_13_1, arg_13_2)
	arg_13_2:updateTreeCell(self._treeData:getUnit(arg_13_1 + 1), arg_13_1)
end

function TreeSingleComp:_onTreeItemClick(arg_14_1)
	local var_14_0 = arg_14_1:getDataValue()

	self:setSelectTreeIndex(var_14_0)

	if var_14_0 == 1 then
		self:setSelectTreeIndex(var_14_0 + 1)
	elseif self._mainIndexMap[var_14_0] then
		self:setSelectTreeIndex(self._mainIndexMap[var_14_0] + 1)
	end
end

function TreeSingleComp:addMainIndex(arg_15_1, arg_15_2)
	self._mainIndexMap[arg_15_1] = arg_15_2
end

function TreeSingleComp:setTreeCellLineGap(arg_16_1)
	if arg_16_1 and type(arg_16_1) == "number" then
		self.m_treeList:setLineGap(arg_16_1)
	end
end

function TreeSingleComp:getSelectedTreeIndex()
	return self._curTreeIdx
end

return TreeSingleComp
