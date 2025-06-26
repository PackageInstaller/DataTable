-- @FileName:   BigHostelManager.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.bigHostel.manager.BigHostelManager', Class.impl(Manager))

--构造
function ctor(self)
    super.ctor(self)
    self:init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:init()
end

--初始化
function init(self)
    --max_dormitory_data
end

function parseModelCvConfigData(self)
    self.m_ModelCvDic = {}

    local baseData = RefMgr:getData("hero_action_cv_data")
    for key, data in pairs(baseData) do
        local baseVo = bigHostel.BigHostelModelConfigVo.new()
        baseVo:parseCogfigData(key, data)
        self.m_ModelCvDic[key] = baseVo
    end
end

function getModelCv(self, model_id)
    if not self.m_ModelCvDic then
        self:parseModelCvConfigData()
    end

    return self.m_ModelCvDic[model_id]
end

-------------------------------------------------------------------临时数据
--{heroConfigVo,model_id,main_type}
function setHostelData(self, heroData)
    self.m_heroData = heroData
end

function getHostelHero(self)
    return self.m_heroData
end

function setSceneModel(self, model)
    self.m_model = model
end

function getSceneModel(self)
    return self.m_model
end

return _M
