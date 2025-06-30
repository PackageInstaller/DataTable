--[[ 
-----------------------------------------------------
@filename       : DormitorySceneController
@Description    : 宿舍场景控制器
@date           : 2021-07-20 17:42:25
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dormitory.controller.DormitorySceneController', Class.impl(map.MapBaseController))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    self:clearMap()
end

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.ADD_FURNITURE_TO_SCENE, self.onAddFunitureHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {

    }
end

function onAddFunitureHandler(self, args)
    if self.roomScene then
        self.roomScene:putonFurniture(args)
    end
end
--获取类别的家具计数
function getFurnitureNum(self, subType)
    if self.roomScene then
        return self.roomScene:getFurnitureNum(subType)
    end
    return 0
end
--删除类别的家具计数
function deleteFurnitureNum(self, subType,id)
    if self.roomScene then
        return self.roomScene:deleteFurnitureNum(subType,id)
    end
    return 0
end

-- 开始加载前
function beforeLoad(self)
    UIFactory:startForcibly()
end

-- 加载场景完的调用
function enterMap(self)
    super.enterMap(self)
    GameDispatcher:dispatchEvent(EventName.ENTER_DORMITORY_SCENE_SUCCSE)
    if not self.roomScene then
        self.roomScene = dormitory.DormitoryScene.new()
    end
    self.roomScene:setup()
end

-- 关闭当前地图
function clearMap(self)
    super.clearMap(self)
    
    UIFactory:startForcibly()
    self:resetTileTip()
    
    if self.roomScene then
        self.roomScene:reset()
    end
    self.roomScene = nil

    dormitory.DormitoryManager:setRoomId(0)
end

-- 取一个格子
function getTile(self, site, col, row)
    if self.roomScene then
        return self.roomScene:getTile(site, col, row)
    end
end
-- 取对应的墙
function getWallRootTran(self, index)
    if self.roomScene then
        return self.roomScene:getWallRootTran(index)
    end
end

-- 设置一个格子显示提示
function setTileShowTip(self, site, col, row, state)
    local tile = self:getTile(site, col, row)
    if tile then
        tile:setActive(true)
        local type = state and 2 or 1
        tile:setMaterial(type)
    end
    dormitory.DormitoryManager:addTileTip(site, col, row)
end

-- 重置格子提示
function resetTileTip(self)
    local list = dormitory.DormitoryManager:getTileTipList()
    for i, v in pairs(list) do
        local tile = self:getTile(v.site, v.col, v.row)
        if tile then
            tile:setActive(false)
        end
    end
    -- dormitory.DormitoryManager:clearTileTipList()
end

-- 设置格子占有的家具id
function setTileHoldFurniture(self, site, col, row, id)
    local tile = self:getTile(site, col, row)
    if tile then
        tile:holdFurniture(id)
    end
end

-- 设置格子占有的角色id
function setTileHoldRole(self, site, col, row, id)
    local tile = self:getTile(site, col, row)
    if tile then
        if id ~= 0 then 
            --这个格子没用被占用才能进行占用
            local type, _id = tile:getState2()
            if _id == 0 then 
                tile:holdRole(id)
            end
        else
            tile:holdRole(id)
        end
    end
end

-- 收纳一个家具
function storageFuniture(self, cusId, cusTid)
    if self.roomScene then
        self.roomScene:storageFuniture(cusId, cusTid)
    end
end
-- 恢复墙面样式
function resetStyle(self, cusInfo)
    if self.roomScene then
        self.roomScene:resetStyle(cusInfo)
    end
end

-- 取格子状态
function getTileState(self, site, col, row, id)
    local tile = self:getTile(site, col, row)
    if tile then
        return tile:getState()
    end
    return 0
end

-- 地图类型
function getMapType(self)
    return MAP_TYPE.DORMITORY
end

-- 地图资源名
function getMapID(self)
    return 801
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
