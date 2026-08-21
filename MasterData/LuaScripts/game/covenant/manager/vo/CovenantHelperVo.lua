module("covenant.CovenantHelperVo", Class.impl())

function ctor(self)
end

function parseMsgData(self, cusData)
    -- 助手id
    self.helperId = cusData.helper_id
    -- 助手等级
    self.lvl = cusData.helper_lv
    -- 助手经验
    self.exp = cusData.helper_exp
    -- 助手当前等级经验上限
    self.maxExp = cusData.helper_max_exp
    
    -- -- 剩余基因点数
    -- self.remainGeneNum = cusData.remain_gene_point
    -- -- 基因点数
    -- self.totalGeneNum = cusData.total_gene_point

    -- 助力英雄列表
    local list = cusData.connect_hero_list
    self.helpHeroList = {}
    self.helpHeroPosDic = {}
    self.helpHeroIdDic = {}
    for i = 1, #list do
        local data = {}
        data.showPos = list[i].pos
        data.heroId = list[i].hero_id
        self.helpHeroList[i] = data
        self.helpHeroPosDic[data.showPos] = data.heroId
        self.helpHeroIdDic[data.heroId] = data.showPos
    end

    -- 属性列表
    list = cusData.attr_list
    self.attrList = {}
    self.attrDic = {}
    for i = 1, #list do
        local attrVo = { key = list[i].key, value = list[i].value }
        table.insert(self.attrList, attrVo)
        self.attrDic[attrVo.key] = attrVo.value
    end
    table.sort(self.attrList, AttConst.sort)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
