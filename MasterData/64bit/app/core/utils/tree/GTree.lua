local GTree = class("GTree")

function GTree:create()
	return GTree.new(...)
end

function GTree:ctor(arg_2_1)
	self._params = arg_2_1
	self._cellUrl = arg_2_1.cellUrl or nil
	self._subCellUrl = arg_2_1.subCellUrl or nil
	self._treeNodeRender = arg_2_1.treeNodeRender or nil
	self._checkTreeNodeClick = arg_2_1.checkTreeNodeClick or nil
	self._treeNodeClickItem = arg_2_1.treeNodeClickItem or nil
	self._isAutoCollapse = arg_2_1.isAutoCollapse or false
	self._onResetDataFunc = arg_2_1.onTreeResetCallBack or nil
	self._treeDatas = nil
	self._currentSelectFolderNode = nil
	self._treeView = arg_2_1.treeList

	self._treeView:setIniter()
	self._treeView:retain()

	self._rootTreeNode = self._treeView:getRootNode()

	self._treeView:setTreeNodeRender(handler(self, self._onTreeNodeRender))
	self._treeView:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTreeNodeClickItem))
end

function GTree:_onTreeNodeRender(arg_3_1)
	local var_3_0 = arg_3_1:getCell()
	local var_3_1 = self:getCellData(arg_3_1)

	if self._treeNodeRender then
		self._treeNodeRender(var_3_0, var_3_1)
	else
		var_3_0:updateView(var_3_1)
	end
end

function GTree:_getNodeRenderData(arg_4_1)
	local var_4_0 = string.split(arg_4_1, "_")
	local var_4_1 = tonumber(var_4_0[2])
	local var_4_2 = self._treeDatas[tonumber(var_4_0[1])]

	if not var_4_2 then
		return
	end

	if var_4_1 ~= 0 then
		return var_4_2.subTree[var_4_1]
	end

	return var_4_2
end

function GTree:_onTreeNodeClickItem(arg_5_1)
	print("_onTreeNodeClickItem")

	local var_5_0 = self._treeView:getSelectedNode()

	if not var_5_0 then
		return
	end

	self:_onUpdateView(var_5_0)
end

function GTree:_onUpdateViewByCustom(arg_6_1)
	if self._checkTreeNodeClick and not self._checkTreeNodeClick(arg_6_1) then
		self._treeView:unselectNode(arg_6_1)
		self._treeView:collapseAll(arg_6_1)

		return
	end

	local var_6_0 = arg_6_1:getParent()

	if not arg_6_1:isFolder() and self._rootTreeNode ~= var_6_0 then
		self._currentSelectFolderNode = var_6_0

		self._treeNodeClickItem(var_6_0, self._usedTreeCell.cell)
	end

	self._treeNodeClickItem(arg_6_1, self._usedTreeCell.cell)
end

function GTree:_onUpdateView(arg_7_1)
	if self._checkTreeNodeClick and not self._checkTreeNodeClick(arg_7_1) then
		self._treeView:unselectNode(arg_7_1)
		self._treeView:collapseAll(arg_7_1)

		return
	end

	if arg_7_1:isFolder() then
		local var_7_0 = arg_7_1:isExpanded()

		if self._currentSelectFolderNode and self._currentSelectFolderNode ~= arg_7_1 then
			self._treeView:clearSelection()
			self._treeView:collapseAll(self._currentSelectFolderNode)
			arg_7_1:setExpaned(var_7_0)
		end

		self._currentSelectFolderNode = arg_7_1

		self._treeView:selectNode(arg_7_1)

		if var_7_0 and arg_7_1:numChildren() > 0 then
			local var_7_1 = arg_7_1:getChildAt(0)

			self._treeView:selectNode(var_7_1)

			if self._treeNodeClickItem then
				self._treeNodeClickItem(var_7_1)
			end
		end
	end

	if self._treeNodeClickItem then
		self._treeNodeClickItem(arg_7_1, self._usedTreeCell.cell)
	end
end

function GTree:setData(arg_8_1)
	self._usedTreeCell = self._usedTreeCell or {
		cell = {},
		subCell = {}
	}
	self._treeDatas = arg_8_1

	for iter_8_0 = 1, #arg_8_1 do
		if arg_8_1[iter_8_0] then
			local var_8_0 = fgui.GTreeNode:create(true, self._cellUrl)

			var_8_0:setData(iter_8_0 .. "_0")
			self._rootTreeNode:addChild(var_8_0)
			table.insert(self._usedTreeCell.cell, var_8_0)

			if arg_8_1[iter_8_0].subTree then
				for iter_8_1 = 1, #arg_8_1[iter_8_0].subTree do
					local var_8_1 = fgui.GTreeNode:create(false, self._subCellUrl)

					var_8_1:setData(iter_8_0 .. "_" .. iter_8_1)
					var_8_0:addChild(var_8_1)
					table.insert(self._usedTreeCell.subCell, var_8_1)
				end
			end
		end
	end

	self._treeView:collapseAll(self._rootTreeNode)
end

function GTree:resetData(arg_9_1)
	self._unusedTreeCellPool = self._unusedTreeCellPool or {
		cell = {},
		subCell = {}
	}

	if not self._treeDatas then
		self:setData(arg_9_1)

		return
	end

	self._treeDatas = arg_9_1

	for iter_9_0, iter_9_1 in ipairs(self._usedTreeCell.subCell) do
		iter_9_1:retain()
		table.insert(self._unusedTreeCellPool.subCell, iter_9_1)
	end

	for iter_9_2, iter_9_3 in ipairs(self._usedTreeCell.cell) do
		iter_9_3:retain()
		iter_9_3:removeChildren()
		table.insert(self._unusedTreeCellPool.cell, iter_9_3)
	end

	self._rootTreeNode:removeChildren()

	self._usedTreeCell = {
		cell = {},
		subCell = {}
	}

	for iter_9_4 = 1, #arg_9_1 do
		local var_9_0 = arg_9_1[iter_9_4]

		if arg_9_1[iter_9_4] then
			local var_9_1

			if not self._unusedTreeCellPool.cell[1] then
				var_9_1 = fgui.GTreeNode:create(true, self._cellUrl)

				self._rootTreeNode:addChild(var_9_1)
			else
				var_9_1 = self._unusedTreeCellPool.cell[1]

				table.remove(self._unusedTreeCellPool.cell, 1)
				self._rootTreeNode:addChild(var_9_1)
				var_9_1:release()
			end

			var_9_1:setData(iter_9_4 .. "_0")
			self:_onTreeNodeRender(var_9_1)
			self._rootTreeNode:addChild(var_9_1)
			table.insert(self._usedTreeCell.cell, var_9_1)

			if var_9_0.subTree then
				for iter_9_5 = 1, #var_9_0.subTree do
					local var_9_2

					if not self._unusedTreeCellPool.subCell[1] then
						var_9_2 = fgui.GTreeNode:create(false, self._subCellUrl)

						var_9_1:addChild(var_9_2)
					else
						var_9_2 = self._unusedTreeCellPool.subCell[1]

						table.remove(self._unusedTreeCellPool.subCell, 1)
						var_9_1:addChild(var_9_2)
						var_9_2:release()
					end

					var_9_2:setData(iter_9_4 .. "_" .. iter_9_5)
					table.insert(self._usedTreeCell.subCell, var_9_2)
				end
			end
		end
	end

	if self._onResetDataFunc then
		self._onResetDataFunc(self._usedTreeCell.cell)
	end
end

function GTree:getTreeView()
	return self._treeView
end

function GTree:getRootNode()
	return self._rootTreeNode
end

function GTree:getSelectedNode()
	return self._treeView:getSelectedNode()
end

function GTree:setSelectedIndex(arg_13_1)
	if not self._rootTreeNode then
		return
	end

	if self._currentSelectFolderNode then
		self._treeView:clearSelection()
		self._treeView:collapseAll(self._currentSelectFolderNode)
	end

	self:_selectedTreeNode(self._rootTreeNode, arg_13_1)

	local var_13_0 = self._treeView:getSubSelectedNode() or self._treeView:getSelectedNode()

	if var_13_0 then
		self:_onUpdateViewByCustom(var_13_0)
	end
end

function GTree:_selectedTreeNode(arg_14_1, arg_14_2)
	if not arg_14_1 then
		return
	end

	local var_14_0 = arg_14_1:numChildren()

	if var_14_0 > 0 then
		local var_14_1

		if not arg_14_2 then
			var_14_1 = arg_14_1:getChildAt(0)
		else
			local var_14_2 = table.remove(arg_14_2, 1)

			if var_14_2 < 0 then
				var_14_2 = 0
			elseif var_14_0 < var_14_2 then
				var_14_2 = var_14_0 - 1
			end

			var_14_1 = arg_14_1:getChildAt(var_14_2)
		end

		if var_14_1 then
			if var_14_1:getParent() == self._rootTreeNode then
				var_14_1:setExpaned(true)
			end

			self._treeView:selectNode(var_14_1)
			self:_selectedTreeNode(var_14_1, arg_14_2)
		else
			assert("GTree-传入的下标数未找到对应的TreeNode。")
		end
	end
end

function GTree:getCellData(arg_15_1)
	return (self:_getNodeRenderData((arg_15_1:getData())))
end

function GTree:dispose()
	if self._treeView then
		self._treeView:release()
	end

	if self._unusedTreeCellPool then
		if self._unusedTreeCellPool.cell then
			for iter_16_0, iter_16_1 in ipairs(self._unusedTreeCellPool.cell) do
				iter_16_1:release()
			end
		end

		self._unusedTreeCellPool.cell = {}

		if self._unusedTreeCellPool.subCell then
			for iter_16_2, iter_16_3 in ipairs(self._unusedTreeCellPool.subCell) do
				iter_16_3:release()
			end
		end

		self._unusedTreeCellPool.subCell = {}
	end
end

return GTree
