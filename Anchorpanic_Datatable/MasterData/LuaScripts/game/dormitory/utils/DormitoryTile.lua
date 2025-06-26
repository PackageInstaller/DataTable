--[[ 
-----------------------------------------------------
@filename       : DormitoryTile
@Description    : 宿舍格子
@date           : 2021-07-21 11:07:25
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dormitory.utils.DormitoryTile', Class.impl())

function ctor(self)
   self:initData()
end

function initData(self)
    self.furnitureId = 0
    self.liveTid = 0
    self.state = nil
end

function createTite(self, site, posX, posY, posZ, c, r)
    -- 配置获取
    -- self.mRootGo = gs.GameObject()
    -- self.mTrans = self.mRootGo.transform
    self.mSite = site
    self.mPosition = { x = posX , y = posY , z = posZ }
    self.mCol = c
    self.mRow = r
    self:initData()
end

function getTileName(self)
    return "Tile_" .. self.mCol .. "_" .. self.mRow
end

-- 启动模型
function setupPrefab(self)
    if self.mRootGo == nil then
        local name = DormitoryCost.TILE_ITEM_LIST[self.mSite]
        self.mPrefabName = UrlManager:getDormitoryTilePrefabUrl(name)

        self.mRootGo = gs.GOPoolMgr:GetOther(self.mPrefabName)
        if not self.mRootGo or gs.GoUtil.IsGoNull(self.mRootGo) then
            self.mRootGo = gs.GameObject()
            self.mTrans = self.mRootGo.transform

            self.mModel = gs.ResMgr:LoadGO(self.mPrefabName)
        else
            self.mTrans = self.mRootGo.transform
            self.mModel = self.mTrans:GetChild(0).gameObject
        end
        self.mRootGo.name = self:getTileName()
        self.mModel:SetActive(true)
        self.mModelTrans = self.mModel.transform
        self.mModelTrans:SetParent(self.mTrans, false)
        self.mTileA = self.mModelTrans:Find("dormitory_101_tile_03_A")
        self.mTileB = self.mModelTrans:Find("dormitory_101_tile_03_B")
        gs.TransQuick:PosScale(self.mModelTrans)

        self:setMaterial(self.mShowType)
        
        self:setToParent()
        self:updatePosition()
    else
        if not self.mModel.activeSelf then
            self.mModel:SetActive(true)
        end
    end
end

function setActive(self, value)
    self.mIsActive = value

    if self.mIsActive then 
        self:setupPrefab()
    elseif self.mRootGo and not gs.GoUtil.IsGoNull(self.mRootGo) then
        if self.mModel.activeSelf then
            self.mModel:SetActive(false)
        end
    end
end

function updatePosition(self)
    if self.mTrans then
        self.mTrans.localPosition = self.mPosition
    end
end

function getPosition(self)
    return self.mPosition
end

function setToParent(self, parent, worldPositionStays)
    if parent ~= nil then
        self.mParentTrans = parent
    end
    if self.mTrans and self.mParentTrans then
        if worldPositionStays == nil then
            worldPositionStays = false
        end
        self.mTrans:SetParent(self.mParentTrans, worldPositionStays)
    end
end

-- 设置纹理
function setMaterial(self, type)
    self.mShowType = type
    if not self.mModel or not self.mShowType then
        return
    end

    if self.mShowType == 1 then
        -- self.mTileA:SetActive(true)
        -- self.mTileB:SetActive(false)
        gs.TransQuick:LPosY(self.mTileA, 0)
        gs.TransQuick:LPosY(self.mTileB, 1000)
        -- self.mRenderer.material:SetColor("_Color", gs.ColorUtil.GetColor("1494F8FF"))
    else
        -- self.mTileA:SetActive(false)
        -- self.mTileB:SetActive(true)
        gs.TransQuick:LPosY(self.mTileA, 1000)
        gs.TransQuick:LPosY(self.mTileB, 0)
        -- self.mRenderer.material:SetColor("_Color", gs.ColorUtil.GetColor("FF0000FF"))
    end
end

-- 锁定格子家具id
function holdFurniture(self, id)
    if self.furnitureId == 0 or id == 0  then
        self.furnitureId = id
    end

    -- if id ~= 0 then
    --     self:setActive(true)
    --     self:setMaterial(1)
    -- else
    --     self:setActive(false)
    -- end
end

-- 模型所在格子的坐标
function getTileRolePos(self)
    -- local tilePos = self:getPosition()
    -- local pos = math.Vector3(tilePos.x + DormitoryCost.TITE_SIZE / 2, tilePos.y, tilePos.z + DormitoryCost.TITE_SIZE / 2)
    -- return pos
    return self:getPosition()
end

-- 格子状态
function getState(self)
    -- 根据传进来的家具判断是否冲突，暂时返回id
    return self.furnitureId
end

-- 锁定格子角色id
function holdRole(self, id)
    self.liveTid = id
    -- if id ~= 0 then
    --     self:setActive(true)
    --     self:setMaterial(2)
    -- else
    --     self:setActive(false)
    -- end
end

-- 格子状态2
function getState2(self)
    if self.furnitureId > 0 then
        return 1, self.furnitureId
    else
        return 2, self.liveTid
    end
end

-- 清空模型 (并不是删除! 删除请用destroy)
function clearModel(self)
    if self.m_loadSn and self.m_loadSn ~= 0 then
        gs.ResMgr:CancelLoadAsync(self.m_loadSn)
        self.m_loadSn = 0
    end
end

function onRecover(self)
    self:destroy()
end

function destroy(self)
    self:clearModel()
    if self.mRootGo then
        gs.GOPoolMgr:RecoverOther(self.mPrefabName, self.mRootGo)
        self.mRootGo = nil
        self.mTrans = nil
        self.mParentTrans = nil
        self.mModel = nil
        self.mModelTrans = nil
    end

    self.mSite = nil
    self.mPosition = nil
    self.mCol = nil
    self.mRow = nil

    self.furnitureId = nil
    self.liveTid = nil
    self.state = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
