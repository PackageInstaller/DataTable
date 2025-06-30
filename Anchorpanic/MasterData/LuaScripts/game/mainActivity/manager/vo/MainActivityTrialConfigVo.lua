--[[
-----------------------------------------------------
@filename       : MainActivityTrialConfigVo
@Description    : 试玩
@date           : 2023-05-22 15:45:15
@Author         : Tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('mainActivity.MainActivityTrialConfigVo', Class.impl())

function parseConfigData(self, key, cusData)
    self.dupId = key
    self.mon = cusData.mon
    self.scene_id = cusData.scene_id
    self.first_award = cusData.first_award
end

function getSceneId(self)
    return self.scene_id
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
