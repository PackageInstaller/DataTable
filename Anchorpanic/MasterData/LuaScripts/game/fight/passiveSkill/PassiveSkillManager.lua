--[[ 
-----------------------------------------------------
@filename       : PassiveSkillManager
@Description    : 被动技能演出管理器
@date           : 2022-11-24 12:10:25
@Author         : Jacob
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('fight.PassiveSkillManager', Class.impl(Manager))

--构造函数
function ctor(self)

end

--析构函数

function dtor(self)

end

-- 初始化boss演出配置
function parseConfigData(self)
    self.mConfigDic = {}
    local baseData = RefMgr:getData("passive_skill_show_data")
    for skillId, data in pairs(baseData) do
        local vo = fight.PassiveSkillCofingVo.new()
        vo:parseData(skillId, data)
        self.mConfigDic[vo.skillId] = vo
    end
end

-- 取被动技能演出数据
function getPassiveSkilShowVo(self, modelId)
    if not self.mConfigDic then
        self:parseConfigData()
    end
    return self.mConfigDic[modelId]
end

-- 被动技能效果
function playPassiveSkillShow(self, skillId, liveId, finishCall)
    -- local livething = fight.SceneItemManager:getLivething(liveId)
    -- local liveVo = livething:getLiveVo()
    local showVo = self:getPassiveSkilShowVo(skillId)
    if showVo and showVo.skillEff and showVo.skillEff ~= "" then
        self:playEffTravel(liveId, 5, showVo.skillEff)

        RateLooper:setTimeout(1, self, function()
            if finishCall then
                finishCall()
            end
        end)
    else
        if finishCall then
            finishCall()
        end
    end
end

-- 播放演出特效
function playEffTravel(self, liveId, point, effName)
    local travel = STravelFactory:travel02(nil, 3, liveId, 0)
    local eftName = UrlManager:get3DBuffPath(effName)
    travel:setPerfData(eftName, nil, 6)
    travel:setSimplePoint(point)
    travel:start()
end

-- 播放音效
function playSoundEff(self, liveId, soundName)
    local livething = fight.SceneItemManager:getLivething(liveId)
    local liveVo = livething:getLiveVo()
    AudioManager:playFightSoundEffect(UrlManager:getFightSoundPath(soundName), false, liveVo:getCurPos())
end

return _M