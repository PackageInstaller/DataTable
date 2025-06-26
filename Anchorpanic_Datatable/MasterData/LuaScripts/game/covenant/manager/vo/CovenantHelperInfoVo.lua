module("covenant.CovenantHelperInfoVo", Class.impl())

function ctor(self)
    self:__init()
end

function __init(self)
    self.covenantId = nil
    self.name = nil
    self.skillId = nil
    self.geneLimit = nil
    self.model = nil

    self.maxLv = 0
end

function parseConfigData(self, cusData)
    self.covenantId = cusData.forces_id
    self.name = cusData.name
    self.skillIdList = cusData.skill_id
    self.geneLimit = cusData.gene_limit
    self.model = cusData.model
    --self.helperLvUp = cusData.helper_levelup

    self.lvDic = self:parseHelperLvUp(cusData.helper_levelup)
    self.needLvDic = self:parseHelperNeedLvUp(cusData.helper_levelup)
end

function parseHelperLvUp(self, dic)
    local lvDic = {}
    for k, v in pairs(dic) do
        if self.maxLv < v.level then
            self.maxLv = v.level
        end
        lvDic[v.level] = v.helper_exp
    end
    return lvDic
end

function parseHelperNeedLvUp(self, dic)
    local lvDic = {}
    for k, v in pairs(dic) do
        lvDic[v.helper_exp] = v.level
    end
    return lvDic
end

function getHelperLvExp(self, lv)
    return self.lvDic[lv]
end

function getHelperMaxLv(self)
    return self.maxLv
end
--当前升级所需等级
function getHelperUpNeedLv(self, exp)
    return self.needLvDic[exp]
end

function getName(self)
    return _TT(self.name)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
