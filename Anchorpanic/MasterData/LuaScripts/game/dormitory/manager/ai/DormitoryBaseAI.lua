--[[ 
-----------------------------------------------------
@filename       : DormitoryBaseAI
@Description    : 宿舍战员基础AI
@date           : 2022-03-02 20:05:09
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dormitory.manager.ai.DormitoryBaseAI', Class.impl())

function ctor(self)
    self:initData()
end

function initData(self)
    self.mNoPathTime = 0
    self.mGetMoveTileCount = 0
end

-- 设置ai角色
function setData(self, cusHeroTid, cusLive)
    self.mHeroTid = cusHeroTid
    self.mDormitoryLive = cusLive
    self:setRoleCurTile(self:getRoleMoveTile())

    local config = hero.HeroCuteManager:getHeroCuteConfigVo(cusHeroTid)
    if config then
        self.moveSpeed = config:getDormitorySpeed()
    else
        self.moveSpeed = 0
    end

    local tile = dormitory.DormitorySceneController:getTile(DormitoryCost.SITE_FLOOR, self.mTileInfo.col, self.mTileInfo.row)
    if tile then
        local pos = tile:getTileRolePos()
        self.mDormitoryLive:setPosition(pos)
    end
    local angle = math.random(0, 360)
    self.mDormitoryLive:setAngle(angle, true)

    self:startAI()
end

-- 启动ai
function startAI(self)
    if not self.mRoleTimerId then
        self.mRoleTimerId = LoopManager:addTimer(5, 0, self, self.onAIStep)
    end
end

-- 停止ai
function stopAI(self)
    self:reset()
end

-- 开始ai随机
function onAIStep(self)
    if self.isMoveing or self.mDormitoryLive:getIsOnInterAct() then
        return
    end
    local function getRandomState(oldState)
        local randomIndex = math.random(1, 3)
        if randomIndex == oldState then 
            return getRandomState(oldState)
        end

        return randomIndex
    end

    local random1 = getRandomState(self.mCurAIState)
    self.mCurAIState = random1
    if random1 == DormitoryCost.AI_WALK then
        self:startMove()
    elseif random1 == DormitoryCost.AI_INTERACT then
        self:startPlayInteractForFurniture()
    elseif random1 == DormitoryCost.AI_STAND then
        local list = DormitoryCost.ACT_SHOW_LIST
        local random2 = math.random(1, #list)
        local action = list[random2]
        self.mDormitoryLive:playAction(action)
    end

    -- self.mCurAIState = 2
    -- self:startPlayInteractForFurniture()
end

--开始同家具交互
function startPlayInteractForFurniture(self)
    local furnitureVoPointData = dormitory.DormitorySceneController.roomScene:getRandomCanInteractFurniturePointData()
    if furnitureVoPointData then 
        --记录当前交互寻路的点
        self.m_CurInteractData = furnitureVoPointData
        self.findMoveFiniShCall = function ()
            if not self.m_CurInteractData then return end 
            
            if self.mCurAIState ~= DormitoryCost.AI_INTERACT or self.mDormitoryLive:getIsOnInterAct() then
                return
            end

            self.mDormitoryLive:setInteractFurnitruePoint(self.m_CurInteractData)
            self.mDormitoryLive:startInteract()
            self.m_CurInteractData = nil
        end
        self:moveTo({ col = self.m_CurInteractData.col, row = self.m_CurInteractData.row })
    end
end

-- 开始移动
function startMove(self)
    local tileInfo = self:getRoleMoveTile()
    self:moveTo(tileInfo)
end

-- 取战员的活动范围
function getMoveRange(self, range)
    local startCol = 2
    local startRow = 2
    local endCol = DormitoryCost.COL_COUNT - 2
    local endRow = DormitoryCost.COL_COUNT - 2
    if self.mTileInfo then
        range = range or (self.mNoPathTime > 3 and 3 or 15)
        range = range or (self.mNoPathTime > 6 and 1 or range)
        startCol = math.max(self.mTileInfo.col - range, 1)
        startRow = math.max(self.mTileInfo.row - range, 1)
        endCol = math.min(self.mTileInfo.col + range, 39)
        endRow = math.min(self.mTileInfo.row + range, 39)
    end
    return startCol, startRow, endCol, endRow
end

-- 随机读取一个战员可用格子
function getRoleMoveTile(self, tileInfo, range)
    local startCol, startRow, endCol, endRow = self:getMoveRange(range)
    local c = math.random(startCol, endCol)
    local r = math.random(startRow, endRow)
    if tileInfo then
        c = tileInfo.col
        r = tileInfo.row
    end

    if not self:checkTileIsCanMove(c, r) and self.mGetMoveTileCount < 50 then
        self.mGetMoveTileCount = self.mGetMoveTileCount + 1
        return self:getRoleMoveTile()
    end
    self.mGetMoveTileCount = 0
    return { col = c, row = r }
end

--  检查格子是否可以移动
function checkTileIsCanMove(self, c, r)
    local endCol = c + 1
    local endRow = r + 1
    local startCol = c - 1
    local startRow = r - 1

    for c = startCol, endCol do
        for r = startRow, endRow do
            local tile = dormitory.DormitorySceneController:getTile(DormitoryCost.SITE_FLOOR, c, r)
            if tile then 
                local type, id = tile:getState2()
                if id and id > 0 and id ~= self.mHeroTid then
                    return false
                end
            end
        end
    end
    return true
end

-- 获取路径
function getPath(self, cusTile)
    local path = dormitory.DormitoryBStar:find(self.mTileInfo, cusTile, self.mHeroTid)
    return path
end

-- 移动到某个格子
function moveTo(self, cusTile)
    if cusTile == nil then
        logAll("没有可以移动的格子tile ", self.mHeroTid)
        return
    end

    if self.mTileInfo ~= nil and cusTile == self.mTileInfo then
        return
    end

    if not table.empty(self.mRolePath) then
        self.mRolePath = nil
    end
    self.mRolePath = self:getPath(cusTile)

    -- self.mTileInfo = cusTile

    self.mMoveTileInfo = cusTile

    if self.mRolePath == nil then
        self.mNoPathTime = self.mNoPathTime + 1
        logAll(self.mHeroTid,"no path")
        self.isMoveing = false
        self.mDormitoryLive:resetInterActPoint()
        return
    end

    self.mNoPathTime = 0
    self.isMoveing = true
    self.mDormitoryLive:playAction(DormitoryCost.ACT_SHOW_WALK)
    self:moveNext()
end

-- 下一步
function moveNext(self)
    local nextTile = self.mRolePath[1]
    if not nextTile then return end

    if not self:checkTileIsCanMove(nextTile.col, nextTile.row) then
        self:resetMove()
        self:startMove()
        return
    end

    self:setRoleCurTile(nextTile)

    local tile = dormitory.DormitorySceneController:getTile(DormitoryCost.SITE_FLOOR, nextTile.col, nextTile.row)
    if tile then
        local canMove = true
        if self.mCurAIState == DormitoryCost.AI_INTERACT then
            if self.m_CurInteractData.heroTid ~= 0 then 
                canMove = false
                self:stopAI()
                self:startAI()
            end
        end

        if canMove then 
            local nextPos = tile:getTileRolePos()
            if self.mNextPos == nil then
                LoopManager:removeFrameByIndex(self.mRoleFrameId)
                self.mRoleFrameId = LoopManager:addFrame(1, 0, self, self.onMoveStep)
            end

            self.mNextPos = nextPos
            self.mCurrPos = self.mDormitoryLive:getCurPos()
        end
    end

end

-- 更新模型
function onMoveStep(self,deltaTime)
    self:updatePosition(deltaTime)
end

-- 更新位置
function updatePosition(self,deltaTime)
    local nextPos = gs.Vector3.MoveTowards(self.mCurrPos, self.mNextPos, self.moveSpeed * deltaTime)
    local curPos = self.mDormitoryLive:getCurPos()
    if math.abs(curPos.x - self.mNextPos.x) < 0.01 and math.abs(curPos.z - self.mNextPos.z) < 0.01 then
        self.mDormitoryLive:turnDirByVector(nextPos, true)
        self.mDormitoryLive:setPosition(nextPos)

        table.remove(self.mRolePath, 1)
        self:moveNext()

        if self.mRolePath == nil or #self.mRolePath < 1 then
            self:resetMove()

            if self.mMoveTileInfo then 
                if self.mTileInfo.col == self.mMoveTileInfo.col and self.mTileInfo.row == self.mMoveTileInfo.row then 
                    if self.findMoveFiniShCall then 
                        self.findMoveFiniShCall()
                        self.findMoveFiniShCall = nil
                    end
                end
            end
        end
    else
        self.mDormitoryLive:turnDirByVector(nextPos, false)
        self.mDormitoryLive:setPosition(nextPos)
    end
end

-- 获取角色当前的格子
function getRoleCurTile(self)
    return self.mTileInfo
end

-- 设置角色当前占有格子
function setRoleCurTile(self, cusTile)
    self:removeTileRoleInfo()
    self.mTileInfo = cusTile
    self:setTileRoleInfo()
end

-- 设置格子战员占位占有
function setTileRoleInfo(self)
    if not self.mTileInfo then return end

    local endCol = self.mTileInfo.col + 1
    local endRow = self.mTileInfo.row + 1
    local startCol = self.mTileInfo.col - 1
    local startRow = self.mTileInfo.row - 1

    -- endCol = gs.Mathf.Clamp(endCol, 1, DormitoryCost.COL_COUNT)
    -- endRow = gs.Mathf.Clamp(endRow, 1, DormitoryCost.ROW_COUNT)
    -- startCol = gs.Mathf.Clamp(startCol, 1, DormitoryCost.COL_COUNT)
    -- startRow = gs.Mathf.Clamp(startRow, 1, DormitoryCost.ROW_COUNT)

    for c = startCol, endCol do
        for r = startRow, endRow do
            dormitory.DormitorySceneController:setTileHoldRole(DormitoryCost.SITE_FLOOR, c, r, self.mHeroTid)
        end
    end
end

-- 解除格子战员占位占有
function removeTileRoleInfo(self)
    if self.mTileInfo then
        local endCol = self.mTileInfo.col + 1
        local endRow = self.mTileInfo.row + 1
        local startCol = self.mTileInfo.col - 1
        local startRow = self.mTileInfo.row - 1

        -- endCol = gs.Mathf.Clamp(endCol, 1, DormitoryCost.COL_COUNT)
        -- endRow = gs.Mathf.Clamp(endRow, 1, DormitoryCost.ROW_COUNT)
        -- startCol = gs.Mathf.Clamp(startCol, 1, DormitoryCost.COL_COUNT)
        -- startRow = gs.Mathf.Clamp(startRow, 1, DormitoryCost.ROW_COUNT)

        for c = startCol, endCol do
            for r = startRow, endRow do
                local tile = dormitory.DormitorySceneController:getTile(DormitoryCost.SITE_FLOOR, c, r)
                if tile ~= nil then
                    local type, id = tile:getState2()
                    if type == 2 and id == self.mHeroTid then
                        dormitory.DormitorySceneController:setTileHoldRole(DormitoryCost.SITE_FLOOR, c, r, 0)
                    end
                end
            end
        end
    end
end

-- 设置战员到某格子去
function setRoleToTile(self, tileInfo)
    --正在交互中，不允许移动
    if self.mDormitoryLive:getIsOnInterAct() then return end

    if tileInfo then
        local tile = dormitory.DormitorySceneController:getTile(DormitoryCost.SITE_FLOOR, tileInfo.col, tileInfo.row)
        if tile then
            local pos = tile:getTileRolePos()
            self.mDormitoryLive:setPosition(pos)
            self:setRoleCurTile(tileInfo)
        end
    end
end

-- 重置移动
function resetMove(self)
    if not self.isMoveing then return end
    self.mNextPos = nil
    self.mCurrPos = nil
    self.mRolePath = nil
    self.isMoveing = false

    -- if dormitory.DormitoryManager.playFsHeroId == self.mHeroTid then
    --     dormitory.DormitoryManager.playFsHeroId = nil
    -- end

    LoopManager:removeFrameByIndex(self.mRoleFrameId)
    self.mRoleFrameId = nil
    self.mDormitoryLive:playAction(DormitoryCost.ACT_SHOW_STAND)
end

-- 重置ai
function reset(self, isRecover)
    self:resetMove()
    LoopManager:removeTimerByIndex(self.mRoleTimerId)
    self.mRoleTimerId = nil

    self.mDormitoryLive:resetInterActPoint()
    self.m_CurInteractData = nil
    if isRecover then
        self.mDormitoryLive = nil
        self.mTileInfo = nil
        self.mGetMoveTileCount = 0
        self.mNoPathTime = 0
    end
end


function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function poolRecover(self)
    self:removeTileRoleInfo()
    self:reset(true)
    LuaPoolMgr:poolRecover(self)
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
