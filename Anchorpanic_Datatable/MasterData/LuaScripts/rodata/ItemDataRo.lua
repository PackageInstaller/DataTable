

module("ItemDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_sort = refData.sort
	self.m_use = refData.use
	self.m_icon = refData.icon
	self.m_uiCode = refData.ui_code
	self.m_useFast = refData.use_fast
	self.m_subtype = refData.subtype
	self.m_effectParam = refData.effect_param
	self.m_defaultColor = refData.default_color
	self.m_effect = refData.effect
	self.m_minLv = refData.min_lv
	self.m_useAll = refData.use_all
	self.m_type = refData.type
	self.m_maxNum = refData.max_num
	self.m_name = refData.name
	self.m_description = refData.description
end

function getRefID(self)
	return self.m_refID
end

function getSort(self)
	return self.m_sort
end

function getUse(self)
	return self.m_use
end

function getIcon(self)
	return self.m_icon
end

function getUiCode(self)
	return self.m_uiCode
end

function getUseFast(self)
	return self.m_useFast
end

function getSubtype(self)
	return self.m_subtype
end

function getEffectParam(self)
	return self.m_effectParam
end

function getDefaultColor(self)
	return self.m_defaultColor
end

function getEffect(self)
	return self.m_effect
end

function getMinLv(self)
	return self.m_minLv
end

function getUseAll(self)
	return self.m_useAll
end

function getType(self)
	return self.m_type
end

function getMaxNum(self)
	return self.m_maxNum
end

function getName(self)
	return self.m_name
end

function getDescription(self)
	return self.m_description
end

return _M
