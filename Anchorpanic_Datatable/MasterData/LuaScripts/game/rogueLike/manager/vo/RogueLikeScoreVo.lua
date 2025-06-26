module("rogueLike.RogueLikeScoreVo", Class.impl())

function parseData(self,id, cusData)
    self.id = id
    self.des = cusData.des
    self.difficulty = cusData.difficulty
    self.score = cusData.score
end

return _M
