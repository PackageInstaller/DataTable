local var_0_0 = g.core.const.ConstMgr.QUALITY_TYPE
local QualityFilterComp = class("QualityFilterComp", require("app.fairyGUI.reborn.UI_QualityFilterComp"))

function QualityFilterComp:ctor()
	self._descendingOrder = true
	self._qualityType = nil
	self._minQualityType = var_0_0.NONE
	self._maxQualityType = var_0_0.SSR

	self.m_qualityList:setVirtual(self)
	self.m_qualityList:setItemRenderer(handler(self, self._onQualityListRenderer))
	self.m_qualityList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickQualityListItem))
end

function QualityFilterComp:initComp(arg_2_1, arg_2_2)
	self._minQualityType = arg_2_1
	self._maxQualityType = arg_2_2

	self.m_qualityList:setNumItems((self:_getQualityNum()))
end

function QualityFilterComp:_onQualityListRenderer(arg_3_1, arg_3_2)
	local var_3_0 = self:_getQualityTypeWithIndex(arg_3_1)

	arg_3_2.m_qualityController:setSelectedIndex(var_3_0)
	arg_3_2:setSelected(var_3_0 == self._qualityType)
end

function QualityFilterComp:_onClickQualityListItem(arg_4_1)
	local var_4_0 = arg_4_1:getDataValue()

	if self:_getQualityFilterCell(var_4_0):isSelected() then
		self._qualityType = self:_getQualityTypeWithIndex(var_4_0)

		if self._qualityType ~= self._qualityType then
			self.m_qualityList:setNumItems((self:_getQualityNum()))
		end
	else
		self._qualityType = nil
	end

	self:dispatchCompEvent("ChangeFiltrateQualityType")
end

function QualityFilterComp:getSelectedQuality()
	return self._qualityType
end

function QualityFilterComp:clearSelectedQuality()
	self._qualityType = nil

	self.m_qualityList:setNumItems((self:_getQualityNum()))
end

function QualityFilterComp:_getQualityNum()
	return self._maxQualityType - self._minQualityType + 1
end

function QualityFilterComp:_getQualityTypeWithIndex(arg_8_1)
	if self._descendingOrder then
		return self._maxQualityType - arg_8_1
	else
		return self._minQualityType + arg_8_1
	end
end

function QualityFilterComp:_getQualityFilterCell(arg_9_1)
	local var_9_0 = self.m_qualityList:itemIndexToChildIndex(arg_9_1)

	if var_9_0 >= 0 and var_9_0 < self.m_qualityList:numChildren() then
		return self.m_qualityList:getChildAt(var_9_0)
	end
end

return QualityFilterComp
