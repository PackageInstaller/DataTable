local var_0_0 = g.core.config.knight_tissue_info
local var_0_1 = g.core.model.User.knightTissueData
local KnightTissueWorldViewPop = class("KnightTissueWorldViewPop", require("app.fairyGUI.knightTissue.UI_KnightTissueWorldViewPop"), function()
	return fgui.GComponent:create({
		resName = "KnightTissueWorldViewPop",
		pkgPath = "ui/knightTissue/knightTissue",
		pkgName = "knightTissue"
	})
end)

function KnightTissueWorldViewPop:ctor(arg_2_1)
	if arg_2_1 then
		self._tissueId = arg_2_1.id or 0
	end

	self._groupId = 0

	self:showAtCenter()
	self:_initRegister()
	self:_initMainView()
end

function KnightTissueWorldViewPop:_initRegister()
	self.m_tissueList:setVirtual()
	self.m_tissueList:setItemProvider(handler(self, self._onTissueItemProvider))
	self.m_tissueList:setItemRenderer(handler(self, self._onTissueListItemRender))
	self:addListen(self.m_tissueList)
end

function KnightTissueWorldViewPop:_onTissueItemProvider(arg_4_1)
	if self._tissueListData[arg_4_1 + 1] then
		if self._tissueListData[arg_4_1 + 1].isMain then
			return "ui://knightTissue/KnightTissueWorldMainCell"
		else
			return "ui://knightTissue/KnightTissueWorldSubCell"
		end
	end
end

function KnightTissueWorldViewPop:_onTissueListItemRender(arg_5_1, arg_5_2)
	if self._tissueListData[arg_5_1 + 1] then
		arg_5_2:updateCell(self._tissueListData[arg_5_1 + 1])
	end
end

function KnightTissueWorldViewPop:_initMainView()
	local var_6_0 = var_0_1:getKnightCollectionAllCount()
	local var_6_1 = var_0_1:getOwnCollectCount()

	self.m_collectNumTxt:setText(var_6_1 .. g.core.lang:get(111903, {
		num = var_6_0
	}))
	self.m_collectProgress:setPercent({
		init = 0,
		cur = var_6_1 or 0,
		max = var_6_0 or 0
	})

	local var_6_2 = var_0_1:_getSortGroupTissueData()

	if self._tissueId == 0 then
		self._groupId = var_6_2[1].id
		self._subTissueId = var_0_1:getTissueGroupCfg()[self._groupId][1].id
	else
		self._groupId = tonumber(var_0_0.get(self._tissueId).group)
		self._subTissueId = self._tissueId
	end

	self:_upateViewInfo()

	if self._groupId == var_6_2[#var_6_2].id then
		self.m_tissueList:scrollToView(#self._tissueListData - 1)
	end
end

function KnightTissueWorldViewPop:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "KNIGHTTISSUE_MAIN_CELL" then
		if self._groupId ~= arg_7_2.id then
			self._groupId = arg_7_2.id
			self._subTissueId = var_0_1:getTissueGroupCfg()[self._groupId][1].id

			self:_upateViewInfo()
		end
	elseif arg_7_1 == "KNIGHTTISSUE_SUB_CELL" then
		if self._subTissueId ~= arg_7_2.id then
			self._subTissueId = arg_7_2.id

			self:_upateViewInfo()
		end
	end
end

function KnightTissueWorldViewPop:_upateViewInfo()
	self._tissueListData = var_0_1:getKnightTissueListData(self._groupId, self._subTissueId)

	self.m_tissueList:setNumItems(#self._tissueListData)

	local var_8_0 = var_0_0.get(self._subTissueId)

	self.m_groupName:setText(var_8_0.name)
	self.m_descTxt:setText(var_8_0.des)
end

return KnightTissueWorldViewPop
