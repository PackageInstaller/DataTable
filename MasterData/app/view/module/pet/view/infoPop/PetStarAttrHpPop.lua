local PetStarAttrHpPop = class("PetStarAttrHpPop", require("app.fairyGUI.pet.UI_PetStarAttrHpPop"), function()
	return fgui.GComponent:create({
		resName = "PetStarAttrHpPop",
		pkgName = "pet"
	})
end)

function PetStarAttrHpPop:ctor(arg_2_1)
	self:showAtCenter()
	self.m_hpAttrList:setVirtual()
	self.m_hpAttrList:setItemRenderer(handler(self, self._onRenderHpAttr))

	self._hpAttrList = arg_2_1.attrList
	self._starNum = arg_2_1.starNum

	self.m_hpAttrList:setNumItems(#self._hpAttrList)
end

function PetStarAttrHpPop:_onRenderHpAttr(arg_3_1, arg_3_2)
	local var_3_0 = self._hpAttrList[arg_3_1 + 1]

	arg_3_2:setAlpha(self._starNum >= self._hpAttrList[arg_3_1 + 1].star and 1 or 0.3)
	arg_3_2:setTitle(g.core.lang:get(201030, {
		star = var_3_0.star
	}))
	arg_3_2:getChild("attrName"):setText(g.core.lang:get(428007, {
		num = var_3_0.value / 10
	}))
end

return PetStarAttrHpPop
