module("seabed.SeabedDifficultyVo", Class.impl())

function parseData(self,id,data)
    --难度
    self.id = id 
    --刷新玩法币消耗
    self.costCoin = data.cost_coin
    --积分倍率
    self.pointMultiple = data.point_multiple
    --首通奖励
    self.reward = data.reward
    --难度标题
    self.difficultyTitle = data.difficulty_title
    --难度描述
    self.difficultyDes = data.difficulty_des
    --推荐等级
    self.suggestLevel = data.suggest_level
    --推荐属性
    self.suggestEle = data.suggest_ele
end


return _M