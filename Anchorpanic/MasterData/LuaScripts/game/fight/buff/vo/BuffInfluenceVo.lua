--[[
****************************************************************************
Brief  :buffer 中的数据对象
Author :James Ou
Date   :2020-02-17
****************************************************************************
]]
module("Buff.BuffInfluenceVo", Class.impl(Buff.BuffVo))
-------------------------------
--构造函数
function ctor(self)
	super.ctor(self)
	-- 记录已影响的BuffRefID
	self.m_influenceRefIDDict = {}
	-- 用于排查的BuffRefID
	self.m_rejectionRefIDDict = nil
end

-- 被回收
function onRecover(self)
	-- 回收时需要返回数值
	if not table.empty(self.m_influenceRefIDDict) then
		self.m_entity:onInfluenceRemove(self.m_refID, self.m_influenceRefIDDict)
	end	
	super.onRecover(self)
end
-- 主要用干扰其它buff所以这里不需要实现
function startup(self)
end

-- 属性解释 (有不同的解释需求时 由子类重写)
function onParseData(self)
	self.m_dataValDict = {}
	local str = self.m_buffRo:getInfluenceVal()
	local strArr = string.split(str, ";")
	for _, subStr in ipairs(strArr) do
		local arr = string.split(subStr, ",")
		local cnt = #arr
		if cnt>=3 then
			local key = tonumber(arr[1])
			local val = tonumber(arr[2])
			local type = tonumber(arr[3])
			local attrVo = Buff.BuffAttrVo.new()
			attrVo:setData(key, val, type)
			self.m_dataValDict[key] = attrVo
		end
	end
end

-- 设置要排斥的bufferIDs (refIDs是个ID列表)
function setRejectionBuffRefIDs(self, refIDs)
	if refIDs==nil then
		self.m_rejectionRefIDDict = nil
		return
	end
	self.m_rejectionRefIDDict = {}
	for _, id in ipairs(refIDs) do
		self.m_rejectionRefIDDict[id] = true
	end
end

-- 排查buffer 要排查的返回true
function rejectionBuffRefID(self, refID)
	if self.m_rejectionRefIDDict then
		if self.m_rejectionRefIDDict[refID] then
			return true
		end
	end
	return false
end

function isInfluencedAttr(self, attrKey)
	return false
end

function addInfluencedRefID(self, refID)
	self.m_influenceRefIDDict[refID] = true
end

function tryInfluencedAttr(self, attrKey, attrVal)
	return nil
end



return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
