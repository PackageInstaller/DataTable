--[[ 
-----------------------------------------------------
@filename       : CovenantInstituteVo
@Description    : 研究所解析
@date           : 2022-08-12 17:41:13
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("covenant.CovenantInstituteVo", Class.impl())

function ctor(self)

end

function parseConfigData(self, cusData)
    self.maxLv = 0
    self.name = cusData.name
    self.lvDic = self:parseHelperLvUp(cusData.inst_levelup)
end

function parseHelperLvUp(self, dic)
    local lvDic = {}
    for k, v in pairs(dic) do
        if self.maxLv < v.level then
            self.maxLv = v.level
        end
        lvDic[v.level] = v.inst_exp
    end
    return lvDic
end

function getHelperLvExp(self, lv)
    return self.lvDic[lv]
end

function getHelperMaxLv(self)
    return self.maxLv
end

function getName(self)
    return _TT(self.name)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
