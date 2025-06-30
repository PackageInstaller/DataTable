module("favorable.FavorableVo",Class.impl())

function parseConfigData(self,cusData)
    --亲密度等级
    self.favorableLevel = cusData.relation_lv
    --亲密度经验
    self.favorableExp = cusData.relation_exp
    --解锁的语音配置
    self.cvId = cusData.cv_id
    --解锁的动作id
    self.moveId = cusData.move_id
    --描述文件
    self.des = cusData.des
    --关系描述
    self.favorable = cusData.relation_des

    --剧情奖励
    self.storyReward = cusData.story_reward
    --剧情id
    self.storyId = cusData.story_id
    --剧情title
    self.storyTitle = cusData.story_title
    --剧情描述
    self.storyDes = cusData.story_des
end

return _M

 
--[[ 替换语言包自动生成，请勿修改！
]]
