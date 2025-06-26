
module('doundless.DoundlessRoundDataVo', Class.impl())

function parseData(self,id,cusData)
    self.id = id
    --波次id
    self.mRoundId = cusData.round_id
    --战区id
    self.mWarId = cusData.war_id 
    --城区id
    self.mCityId = cusData.city_id
    --关卡id
    self.mDupList = cusData.dup_list
    --环境id
    self.mSkillId = cusData.skill_id
end

return _M