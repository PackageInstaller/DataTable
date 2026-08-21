--[[ 
-----------------------------------------------------
@filename       : BuffTriggerEftManger
@Description    : BUFF触发效果管理器(单次效果)
@date           : 2023-04-06 20:06:59
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('fight.BuffTriggerEftManger', Class.impl(Manager))

local STAND_POS = 1
local BODY_POS = 2
local HEAD_POS = 3
local WEAPON_POS = 4
local CAMERA_POS = 5

--构造函数
function ctor(self)
    self.buffTriggerEftList = {}
    self.maxLimitTime = 6
end

--析构函数
function dtor(self)
end

-- 被动技能效果
function buffTrigger(self, liveId, buffId, addLevel)
    local liveThing = fight.SceneItemManager:getLivething(liveId)
    if not liveThing then
        return
    end

    if addLevel and addLevel > 0 then
        self:updateBuffEft(liveId, buffId, addLevel)

        if not self.mTimerSn then
            self.mTimerSn = RateLooper:addTimer(1, 0, self, self.onTimer)
        end
    end

    local liveThing = fight.SceneItemManager:getLivething(liveId)
    local buffRo = Buff.BuffRoMgr:getBuffRo(buffId)

    -- 有图标飘图标
    if buffRo and not table.empty(buffRo:getSpIcon()) then
        local pos = liveThing:getPointPos(fight.FightDef.POINT_SPINE)
        for _, v in ipairs(buffRo:getSpIcon()) do
            fightUI.FightFlyUtil:fly3DImg2(self.id, UrlManager:getFightArtfontPath(v), pos, buffRo:getType() ~= 2)
        end
    end

    -- 有文本飘文本
    if buffRo and buffRo:getFlyText() ~= "" then
        local pos = liveThing:getPointPos(fight.FightDef.POINT_SPINE)
        fightUI.FightFlyUtil:fly3DText(liveId, buffRo:getFlyText(), pos, buffRo:getType() ~= 2)
    end
end

-- 更新buff特效
function updateBuffEft(self, liveId, buffId, addLevel)
    local buffRo = Buff.BuffRoMgr:getBuffRo(buffId)
    if buffRo then
        local casterLiveVo = fight.SceneManager:getThing(liveId)
        local casterModelId = nil
        if casterLiveVo then
            casterModelId = casterLiveVo:getModelID()
        end

        local eftArr = buffRo:getHangStand(casterModelId)
        if not table.empty(eftArr) then
            local eftname = eftArr[addLevel]
            if not eftname then
                eftname = eftArr[1]
            end
            self:playEffTravel(liveId, STAND_POS, buffId, eftname)
        end
        eftArr = buffRo:getHangBody(casterModelId)
        if not table.empty(eftArr) then
            local eftname = eftArr[addLevel]
            if not eftname then
                eftname = eftArr[1]
            end
            self:playEffTravel(liveId, BODY_POS, buffId, eftname)
        end

        eftArr = buffRo:getHangHead(casterModelId)
        if not table.empty(eftArr) then
            local eftname = eftArr[addLevel]
            if not eftname then
                eftname = eftArr[1]
            end
            self:playEffTravel(liveId, HEAD_POS, buffId, eftname)
        end

        eftArr = buffRo:getHangWeapon(casterModelId)
        if not table.empty(eftArr) then
            local eftname = eftArr[addLevel]
            if not eftname then
                eftname = eftArr[1]
            end
            self:playEffTravel(liveId, WEAPON_POS, buffId, eftname)
        end

        eftArr = buffRo:getHangCamera(casterModelId)
        -- table.print(eftArr)
        if not table.empty(eftArr) then
            local eftname = eftArr[addLevel]
            if not eftname then
                eftname = eftArr[1]
            end
            self:playEffTravel(liveId, CAMERA_POS, buffId, eftname)
        end
    end
end

-- 播放演出特效
function playEffTravel(self, liveId, posType, buffId, eftName)
    local liveThing = fight.SceneItemManager:getLivething(liveId)
    self.mEffectName = UrlManager:get3DBuffPath(eftName)
    local eftGo = gs.GOPoolMgr:Get(self.mEffectName)
    if eftGo then
        if posType == CAMERA_POS then
            eftGo:SetActive(true)
            local scTrans = gs.CameraMgr:GetSceneCameraTrans()
            gs.TransQuick:SetParentOrg(eftGo.transform, scTrans)
        else
            eftGo:SetActive(true)
            gs.TransQuick:SetParentOrg(eftGo.transform, liveThing:getTrans())
            local charAppend = eftGo:GetComponent(ty.CharAppendEffect)
            if charAppend then
                charAppend.CharSet = liveThing:getRootGO()
            end

        end
        local eftVo = { buffId = buffId, startTime = os.time(), eftName = eftName, eftGo = eftGo }
        table.insert(self.buffTriggerEftList, eftVo)
    end
end

-- 计时销毁
function onTimer(self)
    if #self.buffTriggerEftList > 0 then
        for i = #self.buffTriggerEftList, 1, -1 do
            local eftVo = self.buffTriggerEftList[i]
            if (os.time() - eftVo.startTime) > self.maxLimitTime then
                if eftVo.eftGo and not gs.GoUtil.IsGoNull(eftVo.eftGo) then
                    local fixSet = eftVo.eftGo:GetComponent(ty.EffectFixSet)
                    if fixSet then
                        fixSet:ClearUpObjList()
                    end
                    if self.m_charAppend then
                        self.m_charAppend:RecoveParent()
                    end
                    gs.GOPoolMgr:Recover(eftVo.eftGo, self.mEffectName)
                    eftVo.eftGo:SetActive(false)
                    eftVo.eftGo = nil

                    table.remove(self.buffTriggerEftList, i)
                end
            end
        end
    else
        RateLooper:removeTimerByIndex(self.mTimerSn)
        self.mTimerSn = nil
    end
end

return _M