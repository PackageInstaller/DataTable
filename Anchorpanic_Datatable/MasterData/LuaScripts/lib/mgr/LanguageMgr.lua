
module("LanguageMgr", Class.impl())

function ctor(self)
	self.m_firstUpdateCalls = {}
	self.m_updateCalls = {}
	local function _firstUpdateCall( oldLan, newLan )
		for _, v in ipairs(self.m_firstUpdateCalls) do
			v(oldLan, newLan)
		end
	end
	gs.LanguageMgr:AddFirstUpdateEvent(_firstUpdateCall)
	local function _updateCall( oldLan, newLan )
		for _, v in ipairs(self.m_updateCalls) do
			v(oldLan, newLan)
		end
	end
	gs.LanguageMgr:AddUpdateEvent(_updateCall)
end

-- 设置基础路径
function setLanuage(self, lan)
	gs.LanguageMgr:SetLanuage(lan)
end

--获取引用数据
function getLanuage( self )
	return gs.LanguageMgr:GetLanuage()
end

function addUpdateEvent( self,call )
	for _,v in ipairs(self.m_updateCalls) do
		if v==call then return end
	end
	table.insert(self.m_updateCalls, call)
end

function removeUpdateEvent( self,call )
	for i,v in ipairs(self.m_updateCalls) do
		if v==call then
			table.remove(self.m_updateCalls, i)
		end
	end
end

function addFirstUpdateEvent( self,call )
	for _,v in ipairs(self.m_firstUpdateCalls) do
		if v==call then return end
	end
	table.insert(self.m_firstUpdateCalls, call)
end

function removeFirstUpdateEvent( self,call )
	for i,v in ipairs(self.m_firstUpdateCalls) do
		if v==call then
			table.remove(self.m_firstUpdateCalls, i)
		end
	end
end

return _M

