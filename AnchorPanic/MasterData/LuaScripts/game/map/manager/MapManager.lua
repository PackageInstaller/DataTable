--[[   
     场景地图数据
]]
module("map.MapManager", Class.impl(Manager))


--构造函数
function ctor(self)
	super.ctor(self)
    self.m_mapType = MAP_TYPE.MAIN_CITY
    self.m_oldMapType = nil
end

--析构函数
function dtor(self)
	
end

-- 地图类型改变
function setMapType(self, cusType)
    if self.m_mapType ~= cusType then
        self.m_oldMapType = self.m_mapType
		self.m_mapType = cusType
		GameDispatcher:dispatchEvent(EventName.MAP_TYPE_CHANGE)
	end
end

-- 获取当前地图类型
function getMapType(self)
	return self.m_mapType
end

-- 获取旧地图类型
function getOldMapType(self)
	return self.m_oldMapType
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
