local var_0_0 = g.core.model.User.knightTissueData
local KnightTissueBaseAttrPop = class("KnightTissueBaseAttrPop", require("app.fairyGUI.knightTissue.UI_KnightTissueBaseAttrPop"), function()
	return fgui.GComponent:create({
		resName = "KnightTissueBaseAttrPop",
		pkgPath = "ui/knightTissue/knightTissue",
		pkgName = "knightTissue"
	})
end)

function KnightTissueBaseAttrPop:ctor(arg_2_1)
	self:showAtCenter()

	if arg_2_1 then
		self._tissueId = arg_2_1.id or 0
	end

	self:_initView()
end

function KnightTissueBaseAttrPop:_initView()
	self.m_attrList:setIniter()
	self.m_attrList:setItemRenderer(handler(self, self._onAttrListItemRender))
	self.m_attrList:setNumItems((var_0_0:getTissueAttrCountById(self._tissueId, 1)))
end

function KnightTissueBaseAttrPop:_onAttrListItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateAttrCellInfo(self._tissueId, arg_4_1 + 1)
end

return KnightTissueBaseAttrPop
