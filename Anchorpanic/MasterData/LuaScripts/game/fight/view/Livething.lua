module("fight.Livething", Class.impl(model.modelLive))

function ctor(self)
    super.ctor(self)
    self.m_headArea = nil
    self.m_headVisible = false

    -- 当前模型类型，默认1 低模
    self.currModelType = 1

    -- 是否战斗场景使用
    self.isInFightScene = true
end

function destroy(self)
    fight.SceneItemManager:removeLivething(self.m_liveID)
    self:removeEvent()
    if self.m_headArea then
        self.m_headArea:destroy()
        self.m_headArea = nil
    end
    super.destroy(self)
end

function setData(self, liveVo, callBack)
    self.m_liveVo = liveVo
    self.m_liveID = self.m_liveVo.id
    self:setPosition(self.m_liveVo.position)
    local playRate = 1
    if not fight.LiveLooper:isNorFrameStop() or fight.LiveLooper:isNonStopLive(self.m_liveID) then
        playRate = RateLooper:getPlayRate()
    end

    self:setAngle(self.m_liveVo:getDirAngle(), true)
    self:removeEvent()
    self:addEvent()

    local speed = playRate * (self.m_aniSpeed + self.m_liveVo:attSpeedInc())
    self:setAniSpeed(speed)
    self:playAction(fight.FightDef.ACT_STAND)
    local finishCall = function(beSuccess, live)
        self:setMaterial()
        self:setAutoCameraNode(live)
        if callBack then
            callBack(beSuccess, live)
        end
    end
    -- self:setIsLoad(true)
    self:setupPrefab(liveVo:getPrefabName(), true, finishCall, 1)
    self:setWeaponData(self.m_liveVo:getModelID())
end

function setWeaponData(self, modelId, showWeaponSn)
    modelId = modelId or self.m_liveVo:getModelID()
    local sRo = fight.RoleShowManager:getShowData(modelId)
    if sRo and sRo:getWeaponNode() ~= 0 then
        self:setWeaponLoadFightAni(true)
        showWeaponSn = showWeaponSn or 1
        local wpath = UrlManager:getWeaponPath(string.format("%s_wq_%02d/model%s_wq_%02d.prefab", modelId, showWeaponSn, modelId, showWeaponSn))
        self:addWeapon(wpath, sRo:getWeaponNode(), true)
    end
end

-- 设置战斗中角色镜头挂点
function setAutoCameraNode(self, live)
    if self.mCameraRT == nil then
        self.mCameraRT = gs.GameObject()
        self.mCameraRTTrans = self.mCameraRT.transform
        self.mCameraRTTrans:SetParent(self.m_trans, false)
        gs.TransQuick:Rotate(self.mCameraRTTrans, 0, -25, 0)

    end
    local rtName = string.match(self.m_prefabName, "model%d*") .. "CameraRT"
    self.mCameraRT.name = rtName

    if self.mCameraDT == nil then
        self.mCameraDT = gs.GameObject()
        self.mCameraDTTrans = self.mCameraDT.transform
        gs.TransQuick:SetParentOrg(self.mCameraDTTrans, self.mCameraRTTrans)
        gs.TransQuick:LPos(self.mCameraDTTrans, 0, 1.5, -3)
        gs.TransQuick:Rotate(self.mCameraDTTrans, 0, 0, 0)
    end
    local dtName = string.match(self.m_prefabName, "model%d*") .. "CameraDT"
    self.mCameraDT.name = dtName

    if self.mCameraFT == nil then
        self.mCameraFT = gs.GameObject()
        self.mCameraFTTrans = self.mCameraFT.transform
        gs.TransQuick:SetParentOrg(self.mCameraFTTrans, self.mCameraDTTrans)
        gs.TransQuick:LPos(self.mCameraFTTrans, 0, 0, 0)
        gs.TransQuick:Rotate(self.mCameraFTTrans, 0, 0, 0)
    end
    local ftName = string.match(self.m_prefabName, "model%d*") .. "CameraFT"
    self.mCameraFT.name = ftName

    self.m_points[fight.FightDef.POINT_CAMERA_RT] = gs.GoUtil.FindNameInChilds(self:getTrans(), rtName)
    self.m_points[fight.FightDef.POINT_CAMERA_DT] = gs.GoUtil.FindNameInChilds(self:getTrans(), dtName)
    self.m_points[fight.FightDef.POINT_CAMERA_FT] = gs.GoUtil.FindNameInChilds(self:getTrans(), ftName)
end

-- 设置替换的材质球
function setMaterial(self)
    local fashionColorVo = fashion.FashionManager:getFasionColorVo(self.m_liveVo.tid, self.m_liveVo.m_fashionId, self.m_liveVo.m_fashionColorId)
    if fashionColorVo then
        self:updateMaterial(fashionColorVo.posList, fashionColorVo.materials, fashionColorVo.dissolves)
    end
end

-- 切换高模
function switchHighModel(self, callBack, isWin)
    if self.currModelType == 2 then
        if callBack then
            callBack()
        end
        return
    end
    if self.m_liveVo:getHighModelPath() == nil then
        if callBack then
            callBack()
        end

        if isWin then
            -- 战斗胜利时低模主动加载常驻特效
            self.isInFightScene = false
            self:_loadAlwaysEft()
        end
        -- 没有高模
        logInfo("=====切换高模：该角色没有高模====")
        return
    end
    local finishCall = function()
        if callBack then
            callBack()
        end
        logInfo("=====切换高模：切换高模完成====")
    end
    self.currModelType = 2
    self:setupPrefab(self.m_liveVo:getHighModelPath(), true, finishCall, 6)
    self:setWeaponData(self.m_liveVo:getHighModelId())
end

-- 切换低模
function switchLowModel(self, callBack)
    if self.currModelType == 1 then
        if callBack then
            callBack()
        end
        return
    end
    if self.m_liveVo:getHighModelPath() == nil then
        if callBack then
            callBack()
        end
        -- 没有高模
        logInfo("=====切换低模：该角色没有高模，无需切换====")
        return
    end
    local finishCall = function()
        if callBack then
            callBack()
        end
        logInfo("=====切换低模：切换低模完成====")
    end
    self.currModelType = 1
    self:setupPrefab(self.m_liveVo:getPrefabName(), true, finishCall, 7)
    self:setWeaponData(self.m_liveVo:getModelID())
end

function justChangeAppearance(self, liveVo, finishCall)
    if self.m_headArea then
        self.m_headArea:destroy()
        self.m_headArea = nil
    end

    self:playAction(fight.FightDef.ACT_STAND)
    self:setupPrefab(liveVo:getPrefabName(), true, finishCall, 2)

    if self.m_liveVo:getRaceType() == 0 then
        local sRo = fight.RoleShowManager:getShowData(self.m_liveVo:getModelID())
        if sRo then
            local showWeaponSn = 1
            local wpath = UrlManager:getWeaponPath(string.format("%s_wq_%02d/model%s_wq_%02d.prefab", liveVo:getModelID(), showWeaponSn, liveVo:getModelID(), showWeaponSn))
            self:addWeapon(wpath, sRo:getWeaponNode(), true)
        end
    end
end

function _afterLoad(self)
    super._afterLoad(self)
    if self.m_liveVo:getRaceVo().monType == monster.MonsterType.SUPER_BOSS then
        -- 超级boss不显示头顶血条
        return
    end

    if self.m_liveVo:getRaceVo().monType == monster.MonsterType.NO_HP_MONSTER then
        -- 不显示头顶血条的怪物
        return
    end

    if not self.m_headArea then
        self.m_headArea = fightUI.HeadAreaItem.new()
    end
    self.m_headArea:setData(self.m_points[fight.FightDef.POINT_TOP], SubLayerMgr:getLayer(gud.SLAYER_BAR), self.m_liveVo)
    if self.m_headVisible then
        self:showHeadBar()
    end
end

function getLiveVo(self)
    return self.m_liveVo
end
function getLiveID(self)
    return self.m_liveID
end

function getModelId(self)
    return self.m_liveVo:getModelID()
end

function getHighModelId(self)
    return self.m_liveVo:getHighModelId()
end

function addEvent(self)
    self.m_liveVo:addEventListener(fight.LivethingVo.EVENT_UPDATE_POSITION, self.onUpdatePositonHandler, self)
    self.m_liveVo:addEventListener(fight.LivethingVo.EVENT_TURN_DIR, self.onTurnDirHandler, self)
    self.m_liveVo:addEventListener(fight.LivethingVo.EVENT_UPDATE_ANI, self.onUpdateAction, self)
    self.m_liveVo:addEventListener(fight.LivethingVo.EVENT_ANI_TRANS_COND, self.onAniTransCond, self)
    self.m_liveVo:addEventListener(fight.LivethingVo.EVENT_UPDATE_ANI_SPEED, self.setAniSpeed, self)
    self.m_liveVo:addEventListener(fight.LivethingVo.EVENT_ALIVE, self.onAliveEvent, self)
    self.m_liveVo:addEventListener(fight.LivethingVo.EVENT_UPATE_ANI_BOOLVAL, self.updateAniBoolVal, self)
    self.m_liveVo:addEventListener(fight.LivethingVo.EVENT_UPATE_ANI_TRIGGERVAL, self.updateAniTriggerVal, self)
    self.m_liveVo:addEventListener(fight.LivethingVo.EVENT_VISIBLE, self.setVisible, self)
    self.m_liveVo:addEventListener(fight.LivethingVo.EVENT_VISIBLE_BY_CAMERA, self.setVisibleByCamera, self)
    self.m_liveVo:addEventListener(fight.LivethingVo.EVENT_TRANPARENCY, self.setTranparency, self)
    self.m_liveVo:addEventListener(fight.LivethingVo.EVENT_UPDATE_SCALE, self.onUpdateScale, self)
    self.m_liveVo:addEventListener(fight.LivethingVo.EVENT_REALIVE, self.onSetReAlive, self)
    self.m_liveVo:addEventListener(fight.LivethingVo.EVENT_CHANGE_FROZE_EFFECT, self.setIsFrostEnable, self)
    self.m_liveVo:addEventListener(fight.LivethingVo.EVENT_CHANGE_METAL_EFFECT, self.setIsMetalEnable, self)
    self.m_liveVo:addEventListener(fight.LivethingVo.EVENT_ANIMAT_OTHER_BIND, self.onUpdateOtherAniClipBind, self)
    self.m_liveVo:addEventListener(fight.LivethingVo.EVENT_CHANGE_WEEK_EFFECT, self.setIsWeekEnable, self)
    self.m_liveVo:addEventListener(fight.LivethingVo.EVENT_CHANGE_MODEL_HIT, self.setIsHitModel, self)
end

function removeEvent(self)
    self.m_liveVo:removeEventListener(fight.LivethingVo.EVENT_UPDATE_POSITION, self.onUpdatePositonHandler, self)
    self.m_liveVo:removeEventListener(fight.LivethingVo.EVENT_TURN_DIR, self.onTurnDirHandler, self)
    self.m_liveVo:removeEventListener(fight.LivethingVo.EVENT_UPDATE_ANI, self.onUpdateAction, self)
    self.m_liveVo:removeEventListener(fight.LivethingVo.EVENT_ANI_TRANS_COND, self.onAniTransCond, self)
    self.m_liveVo:removeEventListener(fight.LivethingVo.EVENT_UPDATE_ANI_SPEED, self.setAniSpeed, self)
    self.m_liveVo:removeEventListener(fight.LivethingVo.EVENT_ALIVE, self.onAliveEvent, self)
    self.m_liveVo:removeEventListener(fight.LivethingVo.EVENT_UPATE_ANI_BOOLVAL, self.updateAniBoolVal, self)
    self.m_liveVo:removeEventListener(fight.LivethingVo.EVENT_UPATE_ANI_TRIGGERVAL, self.updateAniTriggerVal, self)
    self.m_liveVo:removeEventListener(fight.LivethingVo.EVENT_VISIBLE, self.setVisible, self)
    self.m_liveVo:removeEventListener(fight.LivethingVo.EVENT_VISIBLE_BY_CAMERA, self.setVisibleByCamera, self)
    self.m_liveVo:removeEventListener(fight.LivethingVo.EVENT_TRANPARENCY, self.setTranparency, self)
    self.m_liveVo:removeEventListener(fight.LivethingVo.EVENT_UPDATE_SCALE, self.onUpdateScale, self)
    self.m_liveVo:removeEventListener(fight.LivethingVo.EVENT_REALIVE, self.onSetReAlive, self)
    self.m_liveVo:removeEventListener(fight.LivethingVo.EVENT_CHANGE_FROZE_EFFECT, self.setIsFrostEnable, self)
    self.m_liveVo:removeEventListener(fight.LivethingVo.EVENT_CHANGE_METAL_EFFECT, self.setIsMetalEnable, self)
    self.m_liveVo:removeEventListener(fight.LivethingVo.EVENT_ANIMAT_OTHER_BIND, self.onUpdateOtherAniClipBind, self)
    self.m_liveVo:removeEventListener(fight.LivethingVo.EVENT_CHANGE_WEEK_EFFECT, self.setIsWeekEnable, self)
    self.m_liveVo:removeEventListener(fight.LivethingVo.EVENT_CHANGE_MODEL_HIT, self.setIsHitModel, self)
end

function onAliveEvent(self)
    if self.m_liveVo:isDead() then
        self:closeHeadBar()
    end
end

function onUpdateAction(self, data)
    if self.m_liveVo:isDead() then
        if data[1] == fight.FightDef.ACT_DIE and self:isPlayHash(fight.FightDef.ACT_DIE) then
            self:setupOneCall(fight.FightDef.ACT_DIE, data[2], data[3])
            return
        end
    end
    self:playAction(data[1], data[2], data[3], data[4])
end

function onAniTransCond(self, data)
    self:playActionTrigger(data[1], data[2], data[3], nil, data[4])
end

function updateAniBoolVal(self, data)
    self:setAnimationBoolVal(data[1], data[2])
end

function updateAniTriggerVal(self, data)
    self:setAnimationTriggerVal(data[1])
end

-- 绑定非预设绑定的动作片段
function onUpdateOtherAniClipBind(self, data)
    self:setOtherAniClipBind(data[1], data[2], data[3])
end

function getHeadArea(self)
    return self.m_headArea
end

function showHeadBar(self)
    if self.m_liveVo:haveAtt(AttConst.STATE_BATTLE_EXILE) then
        return
    end
    self.m_headVisible = true
    if self.m_liveVo:getVisibleByCamera() == false then
        return
    end
    if self.m_headArea then
        self.m_headArea:showArea()
        self.m_headArea:setVisibleByScale(true)
    end
end
function closeHeadBar(self)
    if self.m_headArea then
        self.m_headArea:closeArea()
    end
    self.m_headVisible = false
end
function updateHeadBar(self)
    if self.m_headArea then
        self.m_headArea:updateBar()
    end
    self.m_liveVo:updateHeadArea()
end
function updateHeadBarBuff(self)
    if self.m_headArea then
        self.m_headArea:updateBuffIcon()
    end
    self.m_liveVo:updateHeadArea()
end
function updateProfessionType(self)
    if self.m_headArea then
        self.m_headArea:updateProfessionType()
    end
end

-- 弱点击破提示
function showWeakBreak(self, type)
    if self.m_headArea then
        self.m_headArea:showWeakBreak(type)
    end
end

-- 设置是否显示
function setVisible(self, beVisible)
    if self.m_isHitModelEnable and beVisible then
        -- 机制隐藏状态，不给显示
        return
    end
    if beVisible == false then
        for key, _ in pairs(self.m_liveVo:getTravelSns()) do
            -- 先移除身上的战斗特效，避免特效被改变layer
            STravelHandle:endTravel(key)
        end
        self.m_liveVo:clearTravelSns()
    end

    super.setVisible(self, beVisible)
    if self.m_headArea then
        if beVisible == false then
            self.m_headArea:setVisibleByScale(beVisible)
        else
            if self.m_headVisible == true then
                self.m_headArea:setVisibleByScale(true)
            end
        end
    end
end

function setVisibleByCamera(self)
    if self.m_liveVo:getVisible() == false then
        return
    end

    self:setVisible(self.m_liveVo:getVisibleByCamera())
end

-- 设置模型透明
function setTranparency(self, value)
    if self.m_liveVo:getVisible() == false then
        return
    end
    super.setTranparency(self, value)

    for _, weaponLive in ipairs(self.m_weaponList) do
        weaponLive:setTranparency(value)
    end

    for _, liveAssembly in pairs(self.m_assemblylist) do
        liveAssembly:setTranparency(value)
    end
end

-- 冰冻效果
function setIsFrostEnable(self, isEnable)
    super.setIsFrostEnable(self, isEnable)

    for _, weaponLive in ipairs(self.m_weaponList) do
        weaponLive:setIsFrostEnable(isEnable)
    end

    for _, liveAssembly in pairs(self.m_assemblylist) do
        liveAssembly:setIsFrostEnable(isEnable)
    end
end

-- 金属封印效果
function setIsMetalEnable(self, isEnable)
    super.setIsMetalEnable(self, isEnable)

    for _, weaponLive in ipairs(self.m_weaponList) do
        weaponLive:setIsMetalEnable(isEnable)
    end

    for _, liveAssembly in pairs(self.m_assemblylist) do
        liveAssembly:setIsMetalEnable(isEnable)
    end
end

-- 弱点击破发光效果
function setIsWeekEnable(self, isEnable)
    super.setIsWeekEnable(self, isEnable)
end

-- 进入隐藏模型状态（可能是雷遁，可能是放逐等）
function setIsHitModel(self, isEnable)
    if self.m_isHitModelEnable == isEnable then
        return
    end
    self.m_isHitModelEnable = isEnable
    if isEnable then
        self.m_liveVo:updateAni(fight.FightDef.ACT_DIE)
    end
    self:setVisible(not isEnable)
end

-- 设置景深渲染顺序
function setDofPrepare(self)
    super.setDofPrepare(self)

    for _, weaponLive in ipairs(self.m_weaponList) do
        weaponLive:setDofPrepare()
    end

    for _, liveAssembly in pairs(self.m_assemblylist) do
        liveAssembly:setDofPrepare()
    end
end

-- 设置模型缩放
function onUpdateScale(self)
    self.setModelScale(self.m_liveVo:getScale())
end

function onUpdatePositonHandler(self, cusData)
    self:setPosition(self.m_liveVo.position)
end

function onTurnDirHandler(self, cusNow)
    self:setAngle(self.m_liveVo:getDirAngle(), cusNow)
end

-- 复活事件
function onSetReAlive(self)
    self:playReAliveEff()
end

-- 播放复活特效
function playReAliveEff(self)
    local eftGo = gs.ResMgr:LoadGO(UrlManager:get3DBuffPath("4504_fuhuo_buff.prefab"))
    if eftGo then
        gs.TransQuick:SetParentOrg(eftGo.transform, self:getTrans())
        local charAppend = eftGo:GetComponent(ty.CharAppendEffect)
        if charAppend then
            charAppend.CharSet = self:getRootGO()
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]