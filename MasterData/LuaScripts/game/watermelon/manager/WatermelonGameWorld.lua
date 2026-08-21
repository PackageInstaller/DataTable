module("watermelon.WatermelonGameWorld", Class.impl(Manager))

-- 构造函数
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
    self.datas = {}
    self.isDebug = false -- GameManager.IS_DEBUG
    self.removeList = {}
end

function setGameRun(self, isRun)
    self.isRun = isRun

    self.worldData = {}
    self.lastFrameColliderDic = {}
end

function registerToTheWorld(self, key, level, obj, colType, selfGroup, colGroup, motion, scale, enterCallback,
    stayCallback, exitCallback)
    local worldVo = LuaPoolMgr:poolGet(watermelon.WatermelonWorldVo)
    worldVo:parseData(key, level, obj, colType, selfGroup, colGroup, motion, scale, enterCallback, stayCallback,
        exitCallback)
    self.datas[key] = worldVo

    -- self:insertToQuadTree(worldVo)
end

function buildQuadTree(self, minX, maxX, minY, maxY)
    self.treeMinX = minX
    self.treeMaxX = maxX
    self.treeMinY = minY
    self.treeMaxY = maxY
    self.quadTree = LuaPoolMgr:poolGet(QuadTree)
    self.quadTree:initTree(minX, maxX, minY, maxY, 0, nil)
end

function insertToQuadTree(self, worldVo)
    self.quadTree:insert(worldVo)
end

function unRegisterToTheWorld(self, key)
    if self.isDebug then
        cusLog("移除" .. key)
    end
    -- table.insert(self.removeList, key)
    -- if self.datas[key] ~= nil then
    --     self.datas[key]:clearAll()
    --     LuaPoolMgr:poolRecover(self.datas[key]) -- 回收dat
    -- end
    self.datas[key] = nil
end

function unRegisterAll(self)
    for k, v in pairs(self.datas) do
        v:clearAll()
        LuaPoolMgr:poolRecover(v) -- 回收dat
    end
    self.datas = {}
end

-- function onUpdateTODO(self)
--     if self.isRun == false then
--         return
--     end

--     self.worldData = {}
--     for key, worldVo in pairs(self.datas) do
--         table.insert(self.worldData, worldVo)
--     end

--     if #self.worldData < 2 then
--         return
--     end

--     self.colliderDic = {}

--     self.quadTree = LuaPoolMgr:poolGet(QuadTree)
--     self.quadTree:initTree(self.treeMinX, self.treeMaxX, self.treeMinY, self.treeMaxY, 0, nil)

--     for i = 1, #self.worldData do
--         if self.worldData[i].motion then
--             self.worldData[i]:updateWordlInfo()
--         end
--         self.quadTree:insert(self.worldData[i])
--     end
--     for i = 1, #self.worldData do
--         local result = self.quadTree:query(self.worldData[i])
--         if #result > 0 then
--             if self.colliderDic[self.worldData[i].key] == nil then
--                 self.colliderDic[self.worldData[i].key] = {self.worldData[i]}
--             end
--             for j = 1, #result do
--                 table.insert(self.colliderDic[self.worldData[i].key], self.worldData[j])
--             end
--         end
--     end
-- end

function onUpdate(self)
    if self.isRun == false then
        return
    end
    self.worldData = {}
    for key, worldVo in pairs(self.datas) do
        table.insert(self.worldData, worldVo)
    end

    if #self.worldData < 2 then
        return
    end

    self.colliderDic = {}
    for i = 1, #self.worldData do
        if self.worldData[i].colGroup == watermelon.WatermelonGroup.None then
            break
        end

        -- 已经计算过，跳过(不能跳过 因为可能A碰到了B，B碰到了C，但是A并不一定碰到了C，所以A和C的碰撞器需要重新计算)
        -- if self.colliderDic[self.worldData[i].key] ~= nil then
        --     break
        -- end
        -- 非运动状态物体不重新计算
        if self.worldData[i].motion then
            self.worldData[i]:updateWordlInfo()
        end

        local list = {}
        for j = i + 1, #self.worldData do
            -- 自己和自己不碰撞
            -- if i == j then
            --     goto continue
            -- end
            -- 不在同一个碰撞组，不碰撞
            if table.indexof01(self.worldData[i].colGroup, self.worldData[j].selfGroup) <= 0 then

            else
                -- 不是同一个等级的不参与计算
                if self.worldData[i].level ~= self.worldData[j].level and self.worldData[i].level ~= 0 and
                    self.worldData[j].level ~= 0 then
                else
                    -- 非运动状态物体不重新计算
                    if self.worldData[j].motion then
                        self.worldData[j]:updateWordlInfo()
                    end
                    -- 判断碰撞
                    local result = self.worldData[i]:compare(self.worldData[j])
                    if result then
                        -- A碰撞B的同时 B也碰撞A  但是不能同时存 A碰到C的时候 B并不一定碰到C
                        if self.colliderDic[self.worldData[i].key] == nil then
                            self.colliderDic[self.worldData[i].key] = {self.worldData[i]}
                        end
                        -- if self.colliderDic[self.worldData[j].key] == nil then
                        --     self.colliderDic[self.worldData[j].key] = {self.worldData[j]}
                        -- end
                        table.insert(self.colliderDic[self.worldData[i].key], self.worldData[j])
                        -- table.insert(self.colliderDic[self.worldData[j].key], self.worldData[i])
                    end
                end

            end
        end
    end
    self:verifyCollider()
    -- 上一帧的碰撞器
    self.lastFrameColliderDic = {}
    for key, value in pairs(self.colliderDic) do
        self.lastFrameColliderDic[key] = value
    end

    -- 所有event全部处理完毕 再执行清空操作
    --   for i = 1, #self.removeList do
    --     if self.datas[self.removeList[i]] ~= nil then
    --         self.datas[self.removeList[i]]:clearAll()
    --         LuaPoolMgr:poolRecover(self.datas[self.removeList[i]]) -- 回收dat
    --         self.datas[self.removeList[i]] = nil
    --     end
    -- end
    -- self.lastFrameColliderDic = table.copy(self.colliderDic)-- self.colliderDic
end

function verifyCollider(self)
    -- self.removeList = {}
    if table.keys(self.colliderDic) == nil then
        return
    end
    for key, value in pairs(self.colliderDic) do
        -- 0是AABB的特殊碰撞 本应都处理对应事件此处跳过
        if key ~= 0 then
            for i = 2, #value do
                value[1].enterCallFunc(value[1], value[i])
            end
        else
            if self.lastFrameColliderDic[0] ~= nil then
                for i = 2, #self.lastFrameColliderDic[0] do
                    local index = table.indexof01(self.lastFrameColliderDic[0], value[i])
                    -- 上一帧也有
                    if index > 0 then
                        value[1].stayCallFunc(value[1], value[i])
                    else
                        value[1].enterCallFunc(value[1], value[i])
                    end
                end
            else
                for i = 2, #value do
                    value[1].enterCallFunc(value[1], value[i])
                end
            end
        end
    end

    if self.lastFrameColliderDic[0] == nil then
        return
    end
    -- 上一帧有 而这一帧没有的 退出事件
    for i = 2, #self.lastFrameColliderDic[0] do
        if self.colliderDic[0] == nil then
            if self.isDebug then
                cusLog("上一帧无触发器碰撞")
            end

            self.lastFrameColliderDic[0][i].exitCallFunc(self.lastFrameColliderDic[0][1],
                self.lastFrameColliderDic[0][i])
        else
            if self.isDebug then
                cusLog("上一帧有触发器碰撞")
                local s = ""
                for key, value in pairs(self.colliderDic[0]) do
                    s = s .. value.key .. "|"
                end
                local s2 = ""
                for j = 1, #self.lastFrameColliderDic[0] do
                    s2 = s2 .. self.lastFrameColliderDic[0][j].key .. "|"
                end

                cusLog("当前：" .. s)
                cusLog("上一帧：" .. s2)
            end

            local index = table.indexof01(self.colliderDic[0], self.lastFrameColliderDic[0][i])
            if index <= 0 then
                self.colliderDic[0][1].exitCallFunc(self.lastFrameColliderDic[0][1], self.lastFrameColliderDic[0][i])
            end
        end
    end

end

return _M
