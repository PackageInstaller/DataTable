--[[ 
-----------------------------------------------------
@filename       : MiningAi_1001
@Description    : 鱼雷ai
@date           : 2023-11-29 11:07:07
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mining.manager.ai.MiningAi_1001', Class.impl("game.mining.manager.ai.MiningAi"))


-- 碰撞触发
function colliderEnter(self, cusParent)
    self:stopAI()
    self:boom()
    return false
end

function boom(self)
    AudioManager:playSoundEffect(UrlManager:getUISoundPath("minigames/mng_sm_6.prefab"))
    local animTime = self.mMinigLive:showAnim("MiningTorpedo_Show")
    self.animTimeoutId = LoopManager:setTimeout(animTime, self, function()
        self.mEventVo = mining.MiningManager:getEventVo(self.mEventId)
        for i, v in ipairs(self.mEventVo.skillIds) do
            local skillVo = mining.MiningManager:getEventSkillVo(self.mEventId)
            if skillVo.type == 1 then
                -- 炸掉周围的
                local range = skillVo.param[1]
                local centerGo = self.mMinigLive:getThingGo()
                local centerRad = centerGo:GetComponent(ty.BoxCollider).size.x * (self.mMinigLive:getEventVo().interactType / 10000)
                local thingDic = mining.MiningController:getMiningSceneThingDic()
                for k, live in pairs(thingDic) do
                    if k ~= self.mMinigLive:getEventKey() then
                        local go = live:getThingGo()
                        local dis = gs.Vector3.Distance(centerGo.transform.localPosition, go.transform.localPosition)
                        local rad = go:GetComponent(ty.BoxCollider).size.x * (live:getEventVo().interactType / 10000)
                        if (range - dis - rad - centerRad) >= 0 then
                            thingDic[k] = nil
                            live:boom()
                        end
                    end
                end
            end
        end
        self:destroyLive()
    end)
end



return _M