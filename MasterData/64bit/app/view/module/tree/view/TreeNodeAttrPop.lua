local TreeNodeAttrPop = class("TreeNodeAttrPop", require("app.fairyGUI.tree.UI_TreeNodeAttrPop"), function()
	return fgui.GComponent:create({
		resName = "TreeNodeAttrPop",
		pkgPath = "ui/tree/tree",
		pkgName = "tree"
	}, ...)
end)

function TreeNodeAttrPop:ctor(arg_2_1)
	self._nodeStruct = arg_2_1.nodeStruct
	self._stageDataList = {}

	self:showAtCenter()
	self:initView()
end

function TreeNodeAttrPop:initView()
	self.m_qualityList:setIniter()
	self.m_qualityList:setItemRenderer(handler(self, self._onRenderQualityList))

	local var_3_0 = self._nodeStruct:getQuality()
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs((self._nodeStruct:getStageDict())) do
		if iter_3_1.node_stage > 0 then
			local var_3_2 = iter_3_1.node_quality

			if not var_3_1[iter_3_1.node_quality] then
				table.insert(self._stageDataList, {
					stageList = {
						iter_3_1
					},
					quality = var_3_2,
					isActive = var_3_2 <= var_3_0
				})

				var_3_1[var_3_2] = #self._stageDataList
			else
				table.insert(self._stageDataList[var_3_1[var_3_2]].stageList, iter_3_1)
			end
		end
	end

	table.sort(self._stageDataList, function(arg_4_0, arg_4_1)
		return arg_4_0.quality < arg_4_1.quality
	end)
	self.m_qualityList:setNumItems(#self._stageDataList)
end

function TreeNodeAttrPop:_onRenderQualityList(arg_5_1, arg_5_2)
	arg_5_2:updateQualityCell(self._stageDataList[arg_5_1 + 1], self._nodeStruct)
end

return TreeNodeAttrPop
