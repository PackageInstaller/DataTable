module("formation.FormationRecommendVo", Class.impl())

function parseData(self,id,cusData)
    -- 助战位置
    self.id = id
    self.mTypeList = string.split(cusData.type, ",") 
    self.mTitleList = cusData.title 
    self.mDesList = cusData.des
    self.mCount = #self.mTitleList
end

function getCount(self)
	return self.mCount
end

function getDes(self, index)
	return _TT(self.mDesList[index])
end

function getType(self, index)
	return self.mTypeList[index]
end

function getTitle(self, index)
	return _TT(self.mTitleList[index])
end

return _M
