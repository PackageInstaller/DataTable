--[[ 
-----------------------------------------------------
@filename       : DupApostlesBossVo
@Description    : 使徒之战服务器发来的boss数据
@date           : 2022-06-13 10:28:47
@Author         : lyx
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_apostles_war.manager.vo.DupApostlesBossVo', Class.impl())

-- 解析数据
function parseData(self, cusData)
    self.id = cusData.id
    self.lockHeroList = cusData.lock_hero_list
    self.difficultyList = {}
    for k, v in pairs(cusData.dup_list) do
        local dataVo = dup.DupApostlesBossDiffiVo:new()
        dataVo:parseData(v)
        self.difficultyList[k] = dataVo
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
