local var_0_0 = {
	GET = 1,
	UN_GET = 2
}
local TreasureSpecialInfoAttrsComp = class("TreasureSpecialInfoAttrsComp", require("app.fairyGUI.infoPop.UI_TreasureSpecialInfoAttrsComp"))

function TreasureSpecialInfoAttrsComp:ctor(arg_1_1)
	self._attrs = nil
	self._treasureBaseId = nil
	self._stateType = var_0_0.GET

	self.m_attsList:setVirtual()
	self.m_attsList:setItemRenderer(handler(self, self._onAttrsItemRenderer))
	self.m_attsList:setItemProvider(handler(self, self._onItemProvider))
	self:addClickListener(handler(self, self._onClickShowAttrsInfo))
end

function TreasureSpecialInfoAttrsComp:_onItemProvider(arg_2_1)
	if self._stateType == var_0_0.UN_GET then
		return "ui://infoPop/TreasureUnGetSpecialAttrComp"
	else
		return "ui://base_new/BaseAttrValueComp1"
	end
end

function TreasureSpecialInfoAttrsComp:updateAttrs(arg_3_1)
	local var_3_0 = arg_3_1.levelDesc

	if arg_3_1.baseId then
		self._treasureBaseId = arg_3_1.baseId
		self._stateType = var_0_0.UN_GET

		local var_3_1, var_3_2 = g.core.model.User.treasureData:getShowTreasureSpecialAttrsPool(arg_3_1.baseId)

		self.m_attsList:setNumItems(var_3_2)
		self.m_attsList:resizeToFit(var_3_2)

		var_3_0 = g.core.lang:get(201576, {
			num = var_3_2
		})
	else
		self._stateType = var_0_0.GET
		self._attrs = arg_3_1.attrs

		self.m_isHasAttrController:setSelectedIndex(#self._attrs > 0 and 0 or 1)

		if #self._attrs > 0 then
			self.m_attsList:setNumItems(#self._attrs)
			self.m_attsList:resizeToFit(#self._attrs)
		end
	end

	self.m_attrsLevelDescTxt:setText(var_3_0 or "")
end

function TreasureSpecialInfoAttrsComp:_onAttrsItemRenderer(arg_4_1, arg_4_2)
	if self._stateType == var_0_0.GET then
		self._attrs[arg_4_1 + 1].customBg = g.core.common.Path:getAttrQualityBgByQuality(self._attrs[arg_4_1 + 1].attrPoolInfo.quality or 1)

		arg_4_2:updateAttr(self._attrs[arg_4_1 + 1])
		arg_4_2.m_firstValueSizeController:setSelectedIndex(1)
		arg_4_2:setIsShowBg(false)
	end
end

function TreasureSpecialInfoAttrsComp:_onClickShowAttrsInfo()
	if self._stateType == var_0_0.UN_GET then
		g.core.sound.SoundManager:playSound("UI_Click_Middle")
		g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.TreasureSpecialAttrPoolPop").new({
			baseId = self._treasureBaseId
		})))
	end
end

return TreasureSpecialInfoAttrsComp
