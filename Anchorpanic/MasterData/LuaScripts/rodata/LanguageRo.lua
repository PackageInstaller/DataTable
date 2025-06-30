

module("LanguageRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_language = refData.language
end

function getRefID(self)
	return self.m_refID
end

function getLanguage(self)
	return self.m_language
end

return _M
