--[[ 
-----------------------------------------------------
@filename       : MainExplorePlayConfigVo
@Description    : 玩法配置数据
@date           : 2021-08-07 14:16:01
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('mainExplore.MainExplorePlayConfigVo', Class.impl())

function parseData(self, dupType, cusData)
    -- 对应的玩法副本类型
    self.dupType = dupType
    -- 通关后是否自动重置游戏
    self.isAutoReset = cusData.is_auto == 1
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
