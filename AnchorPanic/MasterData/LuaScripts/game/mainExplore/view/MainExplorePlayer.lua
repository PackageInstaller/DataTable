--[[
-----------------------------------------------------
@filename       : MainExplorePlayer
@Description    : 主线探索主角
@date           : 2022-2-11
@Author         : Zzz
@copyright      : (LY) 2018 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExplorePlayer", Class.impl(model.modelLive))

--构造函数
function ctor(self)
    super.ctor(self)
end

function onRecover(self)
    self:clearModel()
end

function setTID(self, tid, heroType, finishCall)
    self.tid = tid
    self.m_raceType = heroType
    if heroType == 0 then
        local heroConfigVo = hero.HeroManager:getHeroConfigVo(tid)
        if heroConfigVo then
            self:setModelID(heroConfigVo.model, heroType, finishCall)
            return
        end
    elseif heroType == 1 then
        local monsterConfigVo = monster.MonsterManager:getMonsterVo01(tid)
        if monsterConfigVo then
            if monsterConfigVo.type == 3 then
                self:setModelID(monsterConfigVo.model, heroType, finishCall)
            else
                self:setModelID(monsterConfigVo.model, heroType, finishCall)
            end
            return
        end
    end
    logError("tid = [" .. tostring(tid) .. "] 没有数据")
end

function setModelID(self, modelID, heroType, finishCall)
    self.m_modeID = modelID
    local prefabPath = nil
    if heroType == 0 then
        prefabPath = UrlManager:getRolePath01(modelID)
    else
        prefabPath = UrlManager:getMonsterPath01(modelID)
    end

    if self.m_uiPrefabPath ~= prefabPath then
        self:removeWeapon()
        self:setPrefab(prefabPath, false)
        self.m_uiPrefabPath = prefabPath
        self.m_uiShowWeaponSn = -1
    else
        if finishCall then
            finishCall()
        end
    end
    
    local modeShowRo = fight.RoleShowManager:getShowData(self.m_modeID)
    if modeShowRo then
        local wpath = UrlManager:getWeaponPath(string.format("%d_wq_%02d/model%d_wq_%02d.prefab", modelID, 1, modelID, 1))
        self:addWeapon(wpath, modeShowRo:getWeaponNode(), beAlwayEft)
    end
end

function setPrefab(self, prefabPath, beAlwayEft)
    local finishCall = function()
        self:playAction(fight.FightDef.ACT_STAND, nil, nil)
        self.mNavMeshAgent = gs.GoUtil.AddComponent(self:getRootGO(), typeof(CS.UnityEngine.AI.NavMeshAgent))
    end
    self:setupPrefab(prefabPath, beAlwayEft, finishCall)
end

function playAction(self, aniHash, startCall, endCall)
    if (self.m_curAniHash ~= aniHash) then
        super.playAction(self, aniHash, startCall, endCall)
    end
end

function playFade(self, aniHash, startCall, endCall)
    if (self.m_curAniHash ~= aniHash) then
        super.playFade(self, aniHash, startCall, endCall)
    end
end

function setPosition(self, localPos)
    if not localPos then
        return
    end
    if self.m_position == localPos then
        return
    end
    self.m_position:copy(localPos)
    if self.m_trans and localPos then
        gs.TransQuick:LPos(self.m_trans, self.m_position.x, self.m_position.y, self.m_position.z)
    end
end

function turnDirByVector(self, cusPosition, cusNow)
    if self.m_position:equals(cusPosition) then
        return
    end

    local dir = (self.m_position - cusPosition)
    local angle = math.get_angle_ignoreY(math.Vector3.BACK, dir)
    self:setAngle(angle, cusNow)
end

function setAngle(self, angle, isNow)
    if isNow then
        self:stopTurnAngle()
        self.m_angle = angle
        gs.TransQuick:SetRotation(self.m_trans, 0, angle, 0)
    else
        if angle ~= self.m_angle then
            self:stopTurnAngle()
            self.m_angle = angle
            self.m_angle_tweener = TweenFactory:rotate(self.m_trans, math.Vector3(0, self.m_angle, 0), 0.3)
            fight.TweenManager:addTweener(self.m_angle_tweener)
        end
    end
end

function stopTurnAngle(self)
    if self.m_angle_tweener ~= nil then
        self.m_angle_tweener:Kill()
        self.m_angle_tweener = nil
    end
end

function clearModel(self)
    if (self.mPlayerModel) then
        self.mPlayerModel:clearModel()
        self.mPlayerModel = nil
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
