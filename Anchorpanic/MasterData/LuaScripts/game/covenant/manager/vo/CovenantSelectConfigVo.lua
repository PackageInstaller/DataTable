module("CovenantSelectConfigVo", Class.impl())

function parseConfigData(self, id, cusData)
    --索引
    self.id  = id
    --名字语言包
    self.name = cusData.name
    --英文名字语言包
    self.enName = cusData.eng_name

    self.skill = cusData.skill
    
    --详细介绍
    self.contractDes = cusData.contract_des
    --道具id
    self.keepsake = cusData.keepsake
    --道具数量
    self.keepsake_num = cusData.keepsake_num

    --助手id
    self.helpersId = cusData.helpers_id
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
