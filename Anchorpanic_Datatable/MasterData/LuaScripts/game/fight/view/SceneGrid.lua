module("fight.SceneGrid", Class.impl())

local GRID_WIDTH = 3 * 0.4

function ctor(self)
    self.m_go = nil
    self.m_trans = nil
    self.m_attGridTrans = nil
    self.m_defGridTrans = nil
    self.m_attGridPosDict = nil
    self.m_defGridPosDict = nil
    self.m_fixHeight = 0

    -- 战斗中摄像机总控节点
    self.m_cameraRootTrans = nil
    -- 摄像机翻转节点
    self.m_cameraFilpTrans = nil
    -- 摄像动画节点
    self.m_cameraAniTrans = nil
    -- 摄像动画组件
    self.m_cameraAni = nil
    -- 摄像机旋转台
    self.m_rootRT = nil
    self.m_cameraRTTrans = nil

    self.m_scAniTweens = {}
end

function dtor(self)
    if self.m_go and not gs.GoUtil.IsGoNull(self.m_go) then
        gs.GameObject.Destroy(self.m_go)
        self.m_go = nil
        self.m_trans = nil
        self.m_attGridTrans = nil
        self.m_defGridTrans = nil
        self.m_attGridPosDict = nil
        self.m_defGridPosDict = nil

        self.m_cameraRootTrans = nil
        self.m_cameraFilpTrans = nil
        self.m_cameraAniTrans = nil
        self.m_cameraAni = nil

        self.m_rootRT = nil
        self.m_cameraRTTrans = nil

        -- 摄像机远近距离节点
        self.m_cameraDTTrans = nil
    end
end

function setupCamera(self, cameraTrans)
    -- cameraTrans:SetParent(self.m_trans, false)
    if cameraTrans.Parent ~= self.m_cameraDTTrans then
        cameraTrans:SetParent(self.m_cameraDTTrans, false)
        gs.TransQuick:LPos(cameraTrans, 0, 0, 0)
        gs.TransQuick:SetLRotation(cameraTrans, 0, 0, 0)
    end
end

function getFixHeight(self)
    return self.m_fixHeight
end

function getRootTrans(self)
    return self.m_trans
end

-- 相机翻转节点
function getFilpTrans(self)
    return self.m_cameraFilpTrans
end

-- 相机动作节点
function getAniTrans(self)
    return self.m_cameraAniTrans
end

-- 相机旋转云台
-- function getRTTrans(self)
--     return { self.m_rootRT, self.m_cameraRTTrans }
-- end

-- 相机远近轨道
function getCameraRTTrans(self)
    return self.m_cameraRTTrans
end

-- 相机技能云台
function getCameraDTTrans(self)
    return self.m_cameraDTTrans
end

-- 设置翻转节点X轴翻转
function setFilpX(self, beFilp)
    if beFilp then
        gs.TransQuick:ScaleX(self.m_cameraFilpTrans, -1)
    else
        gs.TransQuick:ScaleX(self.m_cameraFilpTrans, 1)
    end
end

-- 设置翻转节点Z轴翻转
function setFilpZ(self, beFilp)
    if beFilp then
        gs.TransQuick:ScaleZ(self.m_cameraFilpTrans, -1)
    else
        gs.TransQuick:ScaleZ(self.m_cameraFilpTrans, 1)
    end
end

-- 播放相机动作
function playCameraAni(self, aniName)
    self:_clearCamerTween()
    gs.DynamicAnimation:PlayAnimation02(self.m_cameraAni, aniName)
    gs.DynamicAnimation:SetSpeed(self.m_cameraAni, RateLooper:getPlayRate())
end

-- 设置相机速度
function setCameraAniSpeed(self, speed)
    gs.DynamicAnimation:SetSpeed(self.m_cameraAni, speed)
end

function cameraAniNode2Org(self, speed)
    speed = speed or 0.5
    self:_clearCamerTween()
    local _tweenFinishCall = function()
        self:_clearCamerTween()
    end
    table.insert(self.m_scAniTweens, TweenFactory:move2Lpos(self.m_cameraAniTrans, gs.VEC3_ZERO, speed, nil, _tweenFinishCall))
    table.insert(self.m_scAniTweens, self.m_cameraAniTrans:DOLocalRotate(gs.VEC3_ZERO, speed))
end

function _clearCamerTween(self)
    for _, v in ipairs(self.m_scAniTweens) do
        v:Kill()
    end
    self.m_scAniTweens = {}
end

function setup(self)
    self.m_go = gs.ResMgr:LoadGO(UrlManager:getPrefabPath("fightObj/SceneGrid.prefab"))
    self.m_trans = self.m_go.transform
    gs.GoUtil.DontDestroyOnLoad(self.m_go)
    local _, campTrans = GoUtil.GetChildHash(self.m_go)
    local campA = campTrans["CampA"]
    local campD = campTrans["CampD"]

    local _, campATrans = GoUtil.GetChildHash(campA)
    local _, campDTrans = GoUtil.GetChildHash(campD)
    self.m_attGridTrans = campATrans
    self.m_defGridTrans = campDTrans


    self.m_aCenter = campTrans["ACenter"]
    self.m_dCenter = campTrans["DCenter"]
    -- self.m_rootRT = self.m_trans:Find("CameraRT")
    -- self.m_cameraRootTrans = self.m_rootRT:Find("CameraRootPoint")
    self.m_cameraNodeTrans = self.m_trans:Find("CameraNode")
    self.m_cameraRTTrans = self.m_cameraNodeTrans:Find("CameraRT")
    self.m_cameraFilpTrans = self.m_cameraRTTrans:Find("FilpNode")
    self.m_cameraAniTrans = self.m_cameraFilpTrans:Find("CameraAnimation")
    self.m_cameraDTTrans = self.m_cameraAniTrans:Find("CameraDT")
    self.m_cameraAni = self.m_cameraAniTrans:GetComponent(ty.Animation)
    campTrans["Plane"].gameObject:SetActive(false)
end

-- 进攻方中心
function getACenter(self)
    return self.m_attGridPosDict["ACenter"], self.m_aCenter
    -- return self.m_aCenter
end

-- 防守方中心
function getDCenter(self)
    return self.m_defGridPosDict["DCenter"], self.m_dCenter
    -- return self.m_dCenter
end

function setupPos(self)
    self.m_attGridPosDict = {}
    for k, v in pairs(self.m_attGridTrans) do
        local pos = v.position
        local kID = tonumber(k)
        if kID then
            self.m_attGridPosDict[kID] = math.Vector3(pos.x, pos.y, pos.z)
        else
            self.m_attGridPosDict[k] = math.Vector3(pos.x, pos.y, pos.z)
        end
    end
    local pos = self.m_aCenter.position
    self.m_attGridPosDict["ACenter"] = math.Vector3(pos.x, pos.y, pos.z)

    self.m_defGridPosDict = {}
    for k, v in pairs(self.m_defGridTrans) do
        local pos = v.position
        local kID = tonumber(k)
        if kID then
            self.m_defGridPosDict[kID] = math.Vector3(pos.x, pos.y, pos.z)
        else
            self.m_defGridPosDict[k] = math.Vector3(pos.x, pos.y, pos.z)
        end
    end
    pos = self.m_dCenter.position
    self.m_defGridPosDict["DCenter"] = math.Vector3(pos.x, pos.y, pos.z)
end

function setGridPos00(self, pos)
    if self.m_trans == nil then
        self:setup()
    end
    self.m_trans.position = pos
    self:setupPos()
end
function setGridPos01(self, trans)
    if self.m_trans == nil then
        self:setup()
    end
    gs.TransQuick:Pos(self.m_trans, trans)
    self:setupPos()
end

function getPos(self, type, gridID)
    local pos = nil
    if type == 1 then
        pos = self.m_attGridPosDict[gridID]
    else
        pos = self.m_defGridPosDict[gridID]
    end
    if pos == nil then
        Debug:log_error("SceneGrid", "no pos with girdID %d", gridID)
    end
    return pos
end

function getPosFront(self, type, gridID, len)
    local pos = self:getPos(type, gridID):clone()
    -- GRID_WIDTH
    if type == 1 then
        pos.x = pos.x + 1 * len
    else
        pos.x = pos.x - 1 * len
    end
    return pos
end

function getCenterPos(self)
    if self.m_trans then
        return self.m_trans.position
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]