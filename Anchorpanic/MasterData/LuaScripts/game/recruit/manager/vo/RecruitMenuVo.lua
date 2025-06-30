--[[ 
-----------------------------------------------------
@filename       : RecruitMenuVo
@Description    : 招募菜单数据
@date           : 2021-06-09 17:45:44
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('recruit.RecruitMenuVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key
    self.type = cusData.type
    self.langId = cusData.lang_id
    self.tupe = cusData.tupe
    self.mainLang = cusData.main_lang
    self.subLang = cusData.sub_lang
    self.funcId = cusData.func_id
    self.beginTime = cusData.begin_time
    self.endTime = cusData.end_time

    self.hero_list = cusData.hero_list
    self.sort = cusData.sort
end

function isOpenTime(self)
    if not self.beginTime or #self.beginTime == 0 then
        return true
    end

    local clientTime = GameManager:getClientTime()
    if clientTime >= TimeUtil.transTime(self.beginTime) and clientTime < TimeUtil.transTime(self.endTime) then
        return true
    end
    return false
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
