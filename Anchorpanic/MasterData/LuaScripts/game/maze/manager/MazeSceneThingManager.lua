module("maze.MazeSceneThingManager", Class.impl(Manager))

--构造函数
function ctor(self)
	super.ctor(self)
    self:__initData()
end

-- Override 重置数据
function resetData(self)
     super.resetData(self)
     self:__initData()
end

function __initData(self)
    self.mLayerDic = nil
    self.mThingDic = nil
end

---------------------------------------------------------------start 获取场景数据相关---------------------------------------------------------------
-- 添加层级对象
function addLayer(self, layerType, trans)
    if(not self.mLayerDic)then
        self.mLayerDic = {}
    end
    self.mLayerDic[layerType] = trans
end
function getLayer(self, layerType)
    if(not self.mLayerDic)then
        return nil
    end
    return self.mLayerDic[layerType]
end

-- 物件实体相关
function addThing(self, thingVo, finishCall)
    if(not self.mThingDic)then
        self.mThingDic = {}
    end
    if(not self.mThingDic[thingVo:getType()])then
        self.mThingDic[thingVo:getType()] = {}
    end
    -- 此处保证顺序先加入到字段里，保证及时模型加载完立马也能获取当前实体
    local thing = maze.getEventThing(thingVo:getType())
    table.insert(self.mThingDic[thingVo:getType()], thing)
    thing:create(thingVo, finishCall)
end
function removeThing(self, type, row, col)
    local dic = self.mThingDic
    if(dic)then
        local list = dic[type]
        if(list)then
            for i = 1, #list do
                local thing = list[i]
                if(thing:getRow() == row and thing:getCol() == col)then
                    local thing = table.remove(list, i)
                    LuaPoolMgr:poolRecover(thing)
                    return true
                end
            end
        end
    end
    return false
end
function getThing(self, type, row, col)
    local dic = self.mThingDic
    if(dic)then
        local list = dic[type]
        if(list)then
            for i = 1, #list do
                local thing = list[i]
                if(thing:getRow() == row and thing:getCol() == col)then
                    return thing
                end
            end
        end
    end
end
function resetMazeData(self)
	if(self.mThingDic)then
		for thingType, thingList in pairs(self.mThingDic) do
			for _, thing in pairs(thingList) do
				LuaPoolMgr:poolRecover(thing)
			end
		end
	end
	self.mThingDic = {}
    self:__initData()
end
---------------------------------------------------------------end 获取场景数据相关---------------------------------------------------------------

---------------------------------------------------------------start 其他控制器涉及---------------------------------------------------------------
function setEventTrigger(self, eventTrigger)
    self.mEventTrigger = eventTrigger
end

function getEventTrigger(self)
    return self.mEventTrigger
end
---------------------------------------------------------------end 其他控制器涉及---------------------------------------------------------------


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
