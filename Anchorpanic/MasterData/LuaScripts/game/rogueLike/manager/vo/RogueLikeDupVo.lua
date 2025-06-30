module("rogueLike.RogueLikeDupVo", Class.impl())

function parseData(self, cusId, cusData)
    self.dupId = cusId
    self.name = cusData.name
    self.des = cusData.des
    self.cost = {cusData.need_tid, cusData.need_num}
    self.mMonsterIdList = cusData.dup_guard
    self.showAwardId = cusData.show_drop
    self.mMusicId = cusData.music_id
    self.mSceneId = cusData.scene_id
    self.mBuffColor = cusData.buff_colour

    self.mColor = cusData.color
    self.mBuffType = cusData.buff_type
    self.recommandFight = cusData.recommend_force
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
