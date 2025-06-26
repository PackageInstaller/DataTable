module("IncreasesVo",Class.impl())

function parseIncreasesVo(self,cusData)
    --增幅等级
    self.lv = cusData.increases_lv
    --消耗材料
    self.const = cusData.cost
    --属性
    self.skillId = cusData.skill_id
    --等级
    self.skillLv = cusData.skill_lv

    --解锁需要的等级
    self.needHeroLv = cusData.hero_lv

    --消耗类型
    self.payId = cusData.pay_id
    --消耗数量
    self.payNum = cusData.pay_num
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
