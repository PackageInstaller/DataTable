module('fight.LivethingVo', Class.impl('lib.event.EventDispatcher'))

MoveCls = require('game/fight/ai/move/Move_3')

EVENT_UPDATE_POSITION = 'EVENT_UPDATE_POSITION'
EVENT_UPDATE_ANI = 'EVENT_UPDATE_ANI'
EVENT_UPDATE_ANI_SPEED = 'EVENT_UPDATE_ANI_SPEED'
EVENT_ANI_TRANS_COND = 'EVENT_ANI_TRANS_COND'
EVENT_UPATE_ANI_BOOLVAL = 'EVENT_UPATE_ANI_BOOLVAL'
EVENT_UPATE_ANI_TRIGGERVAL = 'EVENT_UPATE_ANI_TRIGGERVAL'
EVENT_VISIBLE = 'EVENT_VISIBLE'
EVENT_VISIBLE_BY_CAMERA = 'EVENT_VISIBLE_BY_CAMERA'
EVENT_ALIVE = 'EVENT_ALIVE'
-- 设置透明
EVENT_TRANPARENCY = 'EVENT_TRANPARENCY'
-- 设置缩放
EVENT_UPDATE_SCALE = 'EVENT_UPDATE_SCALE'
-- 英雄转向
EVENT_TURN_DIR = 'EVENT_TURN_DIR'
-- 复活
EVENT_REALIVE = 'EVENT_REALIVE'
-- 冰冻效果表现
EVENT_CHANGE_FROZE_EFFECT = 'EVENT_CHANGE_FROZE_EFFECT'
-- 金属封印效果表现
EVENT_CHANGE_METAL_EFFECT = 'EVENT_CHANGE_METAL_EFFECT'
-- 击破效果
EVENT_CHANGE_WEEK_EFFECT = 'EVENT_CHANGE_WEEK_EFFECT'
-- 雷遁隐身效果
EVENT_CHANGE_MODEL_HIT = 'EVENT_CHANGE_MODEL_HIT'

-- 绑定非预设绑定的动作片段
EVENT_ANIMAT_OTHER_BIND = 'EVENT_ANIMAT_OTHER_BIND'
-- 通知外部模块血条区域更新
EVENT_HEAD_AREA_UPDATE = 'EVENT_HEAD_AREA_UPDATE'

-- -- 英雄死亡
-- DEAD = 'DEAD'
-- -- 护盾上限变化
-- SHIELD_MAX_CHANGE = 'SHIELD_MAX_CHANGE'
-- -- 护盾变化
-- SHIELD_CHANGE = 'SHIELD_CHANGE'
-- -- 蓝量上限变化
-- MP_MAX_CHANGE = 'MP_MAX_CHANGE'
-- -- 蓝量变化
-- MP_CHANGE = 'MP_CHANGE'
-- -- 血量上限变化
-- HP_MAX_CHANGE = 'HP_MAX_CHANGE'
-- -- 血量变化
-- HP_CHANGE = 'HP_CHANGE'
-- EVENT_MOVE_COMPLETE = 'EVENT_MOVE_COMPLETE'

function ctor(self, liveID, cusIsAtt)
    super.ctor(self)
    self.id = liveID
    self.tid = nil

    self.m_attrs = {}
    self.m_isAlive = true
    --当前坐标点
    self.position = math.Vector3()
    -- 1-为己方 2-敌方
    self.isAtt = cusIsAtt

    --应该是读表的数据-----BEGIN
    self.m_heroCfgVo = nil

    -- 对应的角色预制体
    self.m_prefabName = "model1102.prefab"
    self.m_modelID = nil

    --应该是读表的数据-----END
    --所在的起始站位格ID
    self.m_gridID = 0
    self.m_orgDirAngle = self.isAtt == 1 and 90 or 270
    self:setDirAngle(self.m_orgDirAngle, true)

    self.m_move_ctl = MoveCls.new()
    self.m_move_ctl:setData(self)

    self.m_skillList = nil
    --种族类型 标志是人物还是怪物
    self.m_raceType = 0
    -- 模型是战员还是怪物
    self.m_modelType = 0
    -- 种族数据
    self.m_raceVo = nil
    -- 当前Buff数据
    self.m_buffDatas = {}
    -- 复制的目标vo
    self.m_copyedLiveVo = nil
    -- 是否显示
    self.m_beVisible = true
    -- 皮肤id
    self.m_fashionId = nil
    -- 皮肤部位id
    self.m_fashionColorId = nil
    -- 是否冰冻定帧中
    self.isFroze = nil

    -- 角色身上的战斗特效管理器sn列表
    self.m_travelSns = {}
end

function setCopyLiveVo(self, liveVo)
    self.m_copyedLiveVo = liveVo
end

function getCopyLiveVo(self)
    return self.m_copyedLiveVo
end

function getCurDisplayLiveVo(self)
    if self.m_copyedLiveVo then
        return self.m_copyedLiveVo
    end
    return self
end

-- 设置角色隐藏
function setVisible(self, beVisible)
    if self.m_isAlive ~= true and beVisible == true then
        return
    end

    self.m_beVisible = beVisible
    if beVisible == true then
        --print("AttConst.STATE_BATTLE_EXILE", self:haveAtt(AttConst.STATE_BATTLE_EXILE))
        if self:haveAtt(AttConst.STATE_BATTLE_EXILE) then
            return
        end
    end
    -- logError("setVisible ======== "..tostring(beVisible))
    self:dispatchEvent(fight.LivethingVo.EVENT_VISIBLE, beVisible, true)
end

-- 获取角色隐藏状态
function getVisible(self)
    return self.m_beVisible
end

-- 设置角色对相机不可见
function setVisibleByCamera(self, beVisible, ctrlThing)
    if self.m_isAlive ~= true then
        return
    end

    if not self.m_hideFlags then
        self.m_hideFlags = {}
    end

    local oldVisible = (self.m_hideFlags[ctrlThing] == nil);
    if oldVisible ~= beVisible then
        if beVisible then
            self.m_hideFlags[ctrlThing] = nil;
        else
            self.m_hideFlags[ctrlThing] = true;
        end
        self:dispatchEvent(fight.LivethingVo.EVENT_VISIBLE_BY_CAMERA)
    end
end

-- 获取角色对相机不可见状态
function getVisibleByCamera(self)
    if table.empty(self.m_hideFlags) then
        return self:getVisible()
    end
    return false;
end

-- 设置透明度
function setTranparency(self, bool, ctrlThing)
    self:dispatchEvent(fight.LivethingVo.EVENT_TRANPARENCY, bool)
end

-- 添加buff
function addBuff(self, buffId, casterID, roundCnt, addLevel, descValue)
    -- print("===================buffid", buffId)
    local buffRo = Buff.BuffRoMgr:getBuffRo(buffId)

    local isNewBuff = false
    local bdata = self.m_buffDatas[buffId]
    if not bdata then
        bdata = { roundCnt, addLevel, descValue, casterID }
        self.m_buffDatas[buffId] = bdata
        BuffHandler:addBuff(casterID, self.id, buffId)
        isNewBuff = true
    else
        bdata[1] = roundCnt
        bdata[2] = bdata[2] + addLevel
        bdata[3] = descValue
        bdata[4] = casterID

        BuffHandler:refreshBuff(self.id, buffId)
    end

    local objLive = fight.SceneItemManager:getLivething(self:getLiveID())
    -- 目标已经不存在了
    if not objLive then return end
    -- 弹buff效果飘字
    if isNewBuff and buffRo then
        local pos = objLive:getPointPos(fight.FightDef.POINT_SPINE)
        if not pos then
            return
        end

        -- 有图标飘图标
        if buffRo and not table.empty(buffRo:getSpIcon()) then
            for _, v in ipairs(buffRo:getSpIcon()) do
                fightUI.FightFlyUtil:fly3DImg2(self.id, UrlManager:getFightArtfontPath(v), pos, buffRo:getType() ~= 2)
            end
        end

        -- 有文本飘文本
        if buffRo and buffRo:getFlyText() ~= "" then
            fightUI.FightFlyUtil:fly3DText(self:getLiveID(), buffRo:getFlyText(), pos, buffRo:getType() ~= 2)
        end
    end

    -- 特殊buff效果
    self:buffEffect(buffRo)

    -- buff元素表现 删除元素反应
    -- local headItem = objLive:getHeadArea()
    -- if headItem then
    --     if Buff.BuffRoMgr:isEleBuffRo(buffId) then
    --         headItem:addBuffEle(buffId)
    --         local eleRo = self:judgeReaction(buffId)
    --         if eleRo then
    --             headItem:reactionBuffEle(eleRo:getOldBuffId(), eleRo:getAddBuffId(), eleRo)
    --         end
    --     end
    -- end
end

function buffEffect(self, buffRo)
    if not buffRo then
        return
    end
    -- 冰冻定帧
    if buffRo:getModelState() == BuffDef.BUFF_MODEL_STATE_FROZE then
        self.isFroze = true
        self:updateAniSpeed(0)
        self:dispatchEvent(fight.LivethingVo.EVENT_CHANGE_FROZE_EFFECT, true)
    elseif buffRo:getModelState() == BuffDef.BUFF_MODEL_STATE_METAL then
        self.isFroze = true
        self:updateAniSpeed(0)
        self:dispatchEvent(fight.LivethingVo.EVENT_CHANGE_METAL_EFFECT, true)
    elseif buffRo:getModelState() == BuffDef.BUFF_MODEL_STATE_CHANGE_WEAPON then
        -- 奥利维亚替换武器
        local livething = fight.SceneItemManager:getLivething(self:getLiveID())
        -- 目标已经不存在了
        if livething then
            livething:setWeaponData(nil, 2)
        end
    elseif buffRo:getModelState() == BuffDef.BUFF_MODEL_STATE_WEEK then
        -- print("================BUFF_MODEL_STATE_WEEK 弱点击破效果")
        -- 弱点击破效果
        self:dispatchEvent(fight.LivethingVo.EVENT_CHANGE_WEEK_EFFECT, true)
    elseif buffRo:getModelState() == BuffDef.BUFF_MODEL_STATE_HIT then
        -- print("==================BUFF_MODEL_STATE_HIT 雷遁隐身")
        -- 雷遁
        self:dispatchEvent(fight.LivethingVo.EVENT_CHANGE_MODEL_HIT, true)
    end
end

function judgeReaction(self, buffId)
    if Buff.BuffRoMgr:isEleBuffRo(buffId) then
        for key, _ in pairs(self.m_buffDatas) do
            if key ~= buffId then
                local eleRo = Buff.BuffRoMgr:tryGetEleBuffRo(buffId, key)
                if eleRo then
                    return eleRo
                end
            end
        end
    end
    return false
end

-- 移除buff
function removeBuff(self, buffId, roundCnt, removeLevel)
    local buffRo = Buff.BuffRoMgr:getBuffRo(buffId)
    local bdata = self.m_buffDatas[buffId]
    if bdata then
        bdata[1] = roundCnt
        bdata[2] = bdata[2] - removeLevel -- 全局修改层数
        if (bdata[2] <= 0) then
            self.m_buffDatas[buffId] = nil
            BuffHandler:removeBuff(self.id, buffId, true)

            self:removeBuffEffect(buffRo)

            local objLive = fight.SceneItemManager:getLivething(self:getLiveID())
            -- 目标已经不存在了, 不用想太多了
            if not objLive then return end
            local headItem = objLive:getHeadArea()
            if headItem then
                headItem:removeBuffEle(buffId)
                headItem:updateBuffIcon()
            end
        else
            -- 减层，更新(层数因为已经全局修改，不需要再传值去计算了)
            -- bdata[4] 施法者id
            self:addBuff(buffId, bdata[4], bdata[1], 0, bdata[3])
        end
    end
end

-- 移除buff特殊效果
function removeBuffEffect(self, buffRo)
    if not buffRo then
        return
    end
    if buffRo:getModelState() == BuffDef.BUFF_MODEL_STATE_FROZE then
        self.isFroze = false
        self:updateAniSpeed(1)
        self:dispatchEvent(fight.LivethingVo.EVENT_CHANGE_FROZE_EFFECT, false)
    elseif buffRo:getModelState() == BuffDef.BUFF_MODEL_STATE_METAL then
        self.isFroze = false
        self:updateAniSpeed(1)
        self:dispatchEvent(fight.LivethingVo.EVENT_CHANGE_METAL_EFFECT, false)
    elseif buffRo:getModelState() == BuffDef.BUFF_MODEL_STATE_CHANGE_WEAPON then
        -- 奥利维亚替换武器
        local livething = fight.SceneItemManager:getLivething(self:getLiveID())
        -- 目标已经不存在了
        if livething then
            livething:setWeaponData(nil, 1)
        end
    elseif buffRo:getModelState() == BuffDef.BUFF_MODEL_STATE_WEEK then
        -- 弱点击破效果
        self:dispatchEvent(fight.LivethingVo.EVENT_CHANGE_WEEK_EFFECT, false)
    elseif buffRo:getModelState() == BuffDef.BUFF_MODEL_STATE_HIT then
        -- 雷遁
        self:dispatchEvent(fight.LivethingVo.EVENT_CHANGE_MODEL_HIT, false)
    end
end

-- 清除buff
function clearBuff(self)
    self.m_buffDatas = {}
    self.isFroze = false
    self:updateAniSpeed(1)
    BuffHandler:clearBuff(self.id)
    self:dispatchEvent(fight.LivethingVo.EVENT_CHANGE_FROZE_EFFECT, false)
    self:dispatchEvent(fight.LivethingVo.EVENT_CHANGE_METAL_EFFECT, false)
    self:dispatchEvent(fight.LivethingVo.EVENT_CHANGE_WEEK_EFFECT, false)
    self:dispatchEvent(fight.LivethingVo.EVENT_CHANGE_MODEL_HIT, false)
    local objLive = fight.SceneItemManager:getLivething(self:getLiveID())
    -- 目标已经不存在了, 不用想太多了
    if not objLive then return end
    local headItem = objLive:getHeadArea()
    if headItem then
        headItem:clearBuffEle()
        headItem:updateBuffIcon()
    end
end

function getBuffData(self, buffId)
    return self.m_buffDatas[buffId]
end

function getBuffDataDict(self)
    return self.m_buffDatas
end

-- 设置模型资源
function setPrefabName(self, prefabName)
    self.m_prefabName = prefabName
end

-- 模型预制体路径
function getPrefabName(self)
    return self.m_prefabName
end

-- 获取高模路径
function getHighModelPath(self)
    return self.m_highModelPath
end

-- 设置模型id
function setModelID(self, modelID, raceType)
    self.m_modelID = modelID
    self.m_modelType = raceType
    if raceType == 0 then
        self.m_prefabName = UrlManager:getRolePath01(modelID)
    else
        self.m_prefabName = UrlManager:getMonsterPath01(modelID)
    end
end

-- 设置高模id
function setHighModelId(self, highModelId)
    self.mHighModelID = highModelId
    if highModelId == nil or highModelId == "" then
        self.m_highModelPath = nil
    else
        self.m_highModelPath = UrlManager:getRolePath01(self.mHighModelID)
    end
end

-- 获取高模Id
function getHighModelId(self)
    return self.mHighModelID
end

-- 获取模型资源ID
function getModelID(self)
    return self.m_modelID
end

-- 获取基础模型名(取公共配置)
function getBaseModelId(self)
    local arr = string.split(self.m_modelID, "_")
    local baseModelId = arr[1] --切掉时装后缀
    return baseModelId
end

-- 模型类型（战员还是怪物）
function getModelType(self)
    return self.m_modelType
end

-- 数据类型（玩家的战员还是怪物配置）
function getRaceType(self)
    return self.m_raceType
end

function getRaceVo(self)
    return self.m_raceVo
end

function getOrgData(self)
    if self.m_raceVo then
        return self.m_raceVo:getOrgData()
    end
end
function getTID(self)
    return self.tid
end
-- 设置英雄模版属性
-- tType 角色-0, 怪物-1
function setTID(self, tid, tType, fashionId, fashionColorId)
    self.m_raceVo = nil
    if fight.FightManager.m_gmModelTid then
        local hVo = hero.HeroManager:getHeroConfigVo(fight.FightManager.m_gmModelTid)
        if hVo then
            self.m_skillList = hVo.baseSkillIdList
            self.m_raceType = 0
            self:setModelID(hVo:getHeroModel(), self.m_raceType)
            self:setHighModelId(hVo:getHeroHighModel(), self.m_raceType)
            self.m_raceVo = hVo
            self.tid = tid
            return
        end
    end
    self.tid = tid
    self.m_raceType = tType
    self.m_fashionId = fashionId
    self.m_fashionColorId = fashionColorId
    if tType == 0 then
        local hVo = hero.HeroManager:getHeroConfigVo(tid)
        if hVo then
            -- print("=======", tType, tid, hVo:getHeroModel())
            self.m_skillList = hVo.baseSkillIdList
            self:setModelID(hVo:getHeroModel(fashionId), self.m_raceType)
            self:setHighModelId(hVo:getHeroHighModel(fashionId), self.m_raceType)
            self.m_raceVo = hVo
            return
        end
    elseif tType == 1 then
        local mVo = monster.MonsterManager:getMonsterVo01(tid)
        if mVo then
            -- print("=======", tType, tid, mVo:getHeroModel())
            self.m_skillList = mVo.skillList
            -- 战员型
            if mVo.type == 3 then
                self:setModelID(mVo.model, 0)

                local hVo = hero.HeroManager:getHeroConfigVo(mVo.heroTid)
                if hVo then
                    self:setHighModelId(hVo:getHeroHighModel(fashionId), self.m_raceType)
                end
            else
                self:setModelID(mVo.model, self.m_raceType)
            end
            self.m_raceVo = mVo
            return
        end
    end
    self:setModelID(1102, 0)
end

-- 是攻击方（玩家站位方）
function isAttacker(self)
    return self.isAtt
end
-- 角色ID (唯一)
function getLiveID(self)
    return self.id
end
-- 设置战斗的站位ID
function setGridID00(self, gridID)
    self.m_gridID = gridID
end
-- 获取战斗的站位ID
function getGridID(self)
    return self.m_gridID
end

-- 当前的位置信息
function getCurPos(self)
    return self.position
end

--[[移动
pos : 移动到的位置
moveTime : 移动的用时
finishCall : 移动到位置后的回调
--]]
function moveTo(self, pos, moveTime, finishCall, ease)
    self.m_move_ctl:moveTo(pos, finishCall, moveTime, nil, ease)
end

-- 设置动作速度
function updateAniSpeed(self, speed)
    self:dispatchEvent(fight.LivethingVo.EVENT_UPDATE_ANI_SPEED, speed)
end

function moveTo2(self, pos, aniTime, startTime, endTime, startMoveCall, moveEndCall, finishCall)
    -- local dist = math.v3Distance(pos, self.position)
    -- local moveSpeed = 20
    -- local moveTime = dist/moveSpeed
    -- local aniSpeed = (aniTime-startTime-endTime)/moveTime
    local moveTime = (aniTime - startTime - endTime)
    local function _aniEndCall()
        if moveEndCall then
            moveEndCall()
            moveEndCall = nil
        end
        self:dispatchEvent(fight.LivethingVo.EVENT_UPDATE_ANI_SPEED, 1)
        if finishCall then
            finishCall()
        end
    end
    -- self:dispatchEvent(fight.LivethingVo.EVENT_UPDATE_ANI_SPEED, aniSpeed)
    local function _moveCall()
        if startMoveCall then
            startMoveCall(moveTime)
        end
        if endTime and endTime > 0 then
            local function _moveEndCall()
                if moveEndCall then
                    moveEndCall()
                    moveEndCall = nil
                end
                -- fight.LiveLooper:setTimeout(self.id, endTime/aniSpeed, self, _aniEndCall)
                fight.LiveLooper:setTimeout(self.id, endTime, self, _aniEndCall)
            end
            self.m_move_ctl:moveTo(pos, _moveEndCall, moveTime)
        else
            self.m_move_ctl:moveTo(pos, _aniEndCall, moveTime)
        end
    end
    if startTime and startTime > 0 then
        -- fight.LiveLooper:setTimeout(self.id, startTime/aniSpeed, self, _moveCall)
        fight.LiveLooper:setTimeout(self.id, startTime, self, _moveCall)
    else
        _moveCall()
    end
end

function moveTo3(self, pos, aniTime, startTime, endTime, startMoveCall, finishCall, isFront)
    local moveTime = (aniTime - startTime - endTime)
    local function _aniEndCall()
        self:dispatchEvent(fight.LivethingVo.EVENT_UPDATE_ANI_SPEED, 1)
        if finishCall then
            finishCall()
        end
    end
    local function _moveCall()
        if startMoveCall then
            startMoveCall(moveTime)
        end
        self.m_move_ctl:moveTo(pos, _aniEndCall, moveTime)
    end
    if startTime and startTime > 0 then
        fight.LiveLooper:setTimeout(self.id, startTime, self, _moveCall)
    else
        _moveCall()
    end
end

-- 替换所有属性
function setAtts(self, cusAtts)
    self.m_attrs = cusAtts
end
-- 获取属性
function getAtt(self, attType)
    if attType == nil then return 0 end
    local val = tonumber(self.m_attrs[attType])
    return val or 0
end
function haveAtt(self, attType)
    if attType == nil then return false end
    if self.m_attrs[attType] then
        return true
    end
    return false
end
-- 设置属性
function setAtt(self, attType, attValue)
    if attType == nil then return end
    self.m_attrs[attType] = attValue
end
-- 拷贝全部属性
function copyAtts(self)
    local dic = {}
    for k, v in pairs(self.m_attrs) do
        dic[k] = v
    end
    return dic
end
-- 初始化位置坐标
function initPosition(self, cusPosition)
    self.position:copy(cusPosition)
end
-- 设置位置坐标
function updatePosition(self, cusPosition, cusType)
    if cusType == fight.MoveType.MOVE then
        self:turnDirByVector(cusPosition)
    end
    self.position:copy(cusPosition)
    self:dispatchEvent(fight.LivethingVo.EVENT_UPDATE_POSITION, { position = self.position, type = cusType })
end
-- 通过动作Hash更新动作
function updateAni(self, aniHash, startCall, endCall, isForceEndCall)
    -- 受击动作等冰冻后不许播放
    if self.isFroze then
        -- 冰冻中不能动
        return
    end
    self:dispatchEvent(fight.LivethingVo.EVENT_UPDATE_ANI, { aniHash, startCall, endCall, isForceEndCall })
end

-- 通过动作过度的条件Hash更新动作
function transAni(self, transHash, startCall, endCall, isForceEndCall)
    -- 主动行动的动作不管冰冻状态，避免先后顺序导致卡战斗
    -- if self.isFroze then
    --     -- 冰冻中不能动
    --     return
    -- end
    self:dispatchEvent(fight.LivethingVo.EVENT_ANI_TRANS_COND, { transHash, startCall, endCall, isForceEndCall })
end

function setAnimationBoolVal(self, keyhash, val)
    self:dispatchEvent(fight.LivethingVo.EVENT_UPATE_ANI_BOOLVAL, { keyhash, val })
end

function setAnimationTriggerVal(self, keyhash)
    self:dispatchEvent(fight.LivethingVo.EVENT_UPATE_ANI_TRIGGERVAL, { keyhash })
end

-- 绑定非预设绑定的动作片段
function setOtherAniClipBind(self, clipHash, aniName, finishCall)
    self:dispatchEvent(fight.LivethingVo.EVENT_ANIMAT_OTHER_BIND, { clipHash, aniName, finishCall })
end

-- 通知livething之前的模块血条区域更新
function updateHeadArea(self)
    self:dispatchEvent(fight.LivethingVo.EVENT_HEAD_AREA_UPDATE)
end

-- 英雄死亡
function isDead(self)
    return self.m_isAlive == false
end
-- 设置是否活着
function setAlive(self, beAlive)
    self.m_isAlive = beAlive
    self:dispatchEvent(fight.LivethingVo.EVENT_ALIVE)
    if beAlive == false then
        self.m_isReAliveing = false
        self.isFroze = false
        self:updateAniSpeed(1)
        self:setAtt(AttConst.STATE_BATTLE_EXILE, nil)

        if self:isAttacker() == 1 then
            fight.FightManager:setMyDeadLiveTId(self:getTID())
        end
        -- 这里可以播放死亡动作 动作结束后发消息移除实体
        -- 移除UI上的队列列表数据
        local function _actFinishCall()
            self.m_isDeading = nil
            if self.m_isAlive then
                self:updatePosition(fight.SceneManager:getGridPos01(self))
                self:setVisible(true)
                self:updateAni(fight.FightDef.ACT_GETUP)
            else
                if self.m_isReAliveing or self.m_needLateReAlive then
                    self:reAlive()
                    return
                end
                -- 如果是当前行动角色 停止行动进入下一个Action
                if fight.FightAction:isLiveVoActiving(self) then
                    fight.FightAction:stop()
                end

                --渐变消失
                if self:isAttacker() == 1 then
                    if fight.FightManager:getSelfModelRemove() == true then
                        self:setVisible(false)
                        self:updatePosition(fight.SceneManager:getGridPos01(self))
                    end
                else
                    self:setVisible(false)
                    self:updatePosition(fight.SceneManager:getGridPos01(self))
                end
            end
        end
        self.m_isDeading = true
        self:setAnimationBoolVal(fight.FightDef.ANI_BOOL_TO_GETUP, false)
        -- 死亡动作被复活动作中断，需要让 被中断的死亡动作 强制回调
        self:updateAni(fight.FightDef.ACT_DIE, nil, _actFinishCall, true)
        self:clearLiveData()
    else
        if self.m_isDeading then return end

        self:updatePosition(fight.SceneManager:getGridPos01(self))
        self:setVisible(true)
        self:updateAni(fight.FightDef.ACT_GETUP)
    end
end

-- 复活
--（复活流程：先setAlive 死亡，等待死亡动作完成，此时eff复活效果调用reAlive，死亡动作未完成所以return；同时action继续执行，isReAliveing判断在复活流程，所以不继续action；
--  等死亡动作完成，判断是否在复活流程，继续调reAlive，走复活流程；然后根据是否有等待的action并且执行id是在复活的战员，是就等待1秒完成动作，不是直接回调继续执行action）
function reAlive(self)
    self.m_isReAliveing = true
    if self.m_isDeading then
        return
    end
    if self.m_isAlive then
        -- 跳过技能导致复活先执行于死亡，需要重新走复活流程
        self.m_needLateReAlive = true
        return
    end

    if self.m_isReAliveing then
        self.m_isAlive = true
        self.m_isReAliveing = false
        self.m_needLateReAlive = false

        self:updatePosition(fight.SceneManager:getGridPos01(self))
        self:setVisible(true)
        self:transAni(fight.FightDef.ANI_TRIGGER_TO_STAND)
        self:dispatchEvent(fight.LivethingVo.EVENT_REALIVE)

        if self.reAliveNextActData and self.reAliveNextActData.hero_id == self.id then
            fight.LiveLooper:setTimeout(self.id, 1, self, function()
                if self.reAliveFinishCall then
                    self.reAliveFinishCall()
                    self.reAliveFinishCall = nil
                end
            end)
        else
            if self.reAliveFinishCall then
                self.reAliveFinishCall()
                self.reAliveFinishCall = nil
            end
        end

    end
end

function isReAliveing(self, finishCall, actData)
    if self.m_isReAliveing then
        self.reAliveNextActData = actData
        self.reAliveFinishCall = finishCall
        return true
    end
    return false
end

function moveSpeed(self)
    local _s = self:getAtt(AttConst.MOVE_SPEED) * 0.0001 * 40
    local _p = 1 + (self:getAtt(AttConst.MOVE_SPEED_INC) * 0.0001 - self:getAtt(AttConst.MOVE_SPEED_DEC) * 0.0001)
    return _s * _p
end

function attSpeedInc(self)
    return self:getAtt(AttConst.ATT_SPEED_INC) * 0.0001 - self:getAtt(AttConst.ATT_SPEED_DEC) * 0.0001
end

--[[设置英雄转向
	cusPosition 目标坐标
	cusNow 直接转还是慢慢转
]]
function turnDirByVector(self, cusPosition, cusNow)
    if self.position:equals(cusPosition) then
        return
    end

    local dir = (self.position - cusPosition)
    local angle = math.get_angle_ignoreY(math.Vector3.BACK, dir)
    self:setDirAngle(angle, cusNow)
end

-- 当前英雄朝向角度
function getDirAngle(self)
    return self.m_target_angle
end
-- 设置英雄朝向角度
function setDirAngle(self, cusAngle, cusNow)
    self.m_target_angle = cusAngle
    self:dispatchEvent(fight.LivethingVo.EVENT_TURN_DIR, cusNow)
end

function turnOrgDirAngle(self, cusNow)
    self:setDirAngle(self.m_orgDirAngle, cusNow)
end

-- 当前战员缩放比例
function getScale(self)
    return self.m_scale
end
-- 设置战员缩放比例
function setScale(self, cusScale)
    self.m_scale = cusScale
    self:dispatchEvent(fight.LivethingVo.EVENT_UPDATE_SCALE)
end

-- 身上的特效sn
function getTravelSns(self)
    return self.m_travelSns
end

-- 保存一个身上的特效sn
function addTravelSns(self, cusSn)
    self.m_travelSns[cusSn] = true
end

-- 清除所有特效sn
function clearTravelSns(self)
    self.m_travelSns = {}
end

-- 移除生命数据
function clearLiveData(self)
    self:clearBuff()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]