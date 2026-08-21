module("HeroFavorableVo", Class.impl())

function parseConfigData(self, cusData)
    -- 战员id
    self.id = cusData.id
    -- 喜欢的道具
    self.likegift = cusData.like_gift
    -- 不喜欢的礼物
    self.dislikegift = cusData.dislike_gift
    -- 亲密度数据
    self.favorableData = {}
    -- 是否有剧情
    self.hasStory = cusData.is_story == 1
    --是否可以结婚
    self.isPromise = cusData.is_promise == 1
    --结婚剧情
    self.promiseStoryId = cusData.promise_story
    --结婚CV
    self.promiseCv = cusData.promise_cv

    for id, data in pairs(cusData.relation_data) do
        local vo = favorable.FavorableVo.new()
        vo:parseConfigData(data)
        self.favorableData[data.relation_lv] = vo
    end

end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
