--[[ 
-----------------------------------------------------
@filename       : MainExploreSceneThingManager
@Description    : 主线探索场景物件数据管理器
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreSceneThingManager", Class.impl(Manager))

-- 添加物件
ADD_THING = "ADD_THING"
-- 移除物件
REMOVE_THING = "REMOVE_THING"

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
    self.mThingDic = nil
end

---------------------------------------------------------------start 获取场景数据相关---------------------------------------------------------------
-- 物件实体相关
function addThing(self, thingVo, aiCtrl, loadFinish)
    if(thingVo)then
        local eventConfigVo = thingVo:getEventConfigVo()
        if(not self.mThingDic)then
            self.mThingDic = {}
        end
        if(not self.mThingDic[eventConfigVo.eventType])then
            self.mThingDic[eventConfigVo.eventType] = {}
        end
        local thing = mainExplore.getThing(thingVo:getType())
        table.insert(self.mThingDic[eventConfigVo.eventType], thing)
        thing:setData(thingVo, aiCtrl, loadFinish)
        self:dispatchEvent(self.ADD_THING, thing)
    end
end

function removeThing(self, thingVo)
    if(thingVo)then
        local eventConfigVo = thingVo:getEventConfigVo()
        local dic = self.mThingDic
        if(dic)then
            local list = dic[eventConfigVo.eventType]
            if(list)then
                for i = #list, 1, -1 do
                    local thing = list[i]
                    if(thing:getThingVo():getEventConfigVo().eventId == eventConfigVo.eventId)then
                        self:dispatchEvent(self.REMOVE_THING, thing)
                        LuaPoolMgr:poolRecover(table.remove(list, i))
                        return true
                    end
                end
            end
        end
    end
    return false
end

function getThing(self, thingVo)
    if(thingVo)then
        local eventConfigVo = thingVo:getEventConfigVo()
        local dic = self.mThingDic
        if(dic)then
            local list = dic[eventConfigVo.eventType]
            if(list)then
                for i = 1, #list do
                    local thing = list[i]
                    if(thing:getThingVo():getEventConfigVo().eventId == eventConfigVo.eventId)then
                        return thing
                    end
                end
            end
        end
    end
end

function getThingDic(self)
    return self.mThingDic
end

function getThingList(self, eventType)
    if(self.mThingDic)then
        return self.mThingDic[eventType]
    end
    return nil
end

-- 添加玩家
function addPlayerThing(self, thingVo, aiCtrl, loadFinish)
    local thing = mainExplore.getThing(thingVo:getType())
    local function _loadFinish()
        loadFinish(thing)
    end
    thing:setData(thingVo, aiCtrl, _loadFinish)
end

function resetExploreData(self)
	if(self.mThingDic)then
		for thingType, thingList in pairs(self.mThingDic) do
			for _, thing in pairs(thingList) do
				LuaPoolMgr:poolRecover(thing)
			end
		end
	end
	self.mThingDic = {}
    mainExplore.MainExplorePlayerProxy:deActive()
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
