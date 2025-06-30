module("cycle.CycleDifficultyVo", Class.impl())

function parseCycleDifficuty(self, id, data)
    self.id = id
    self.pointMultiple = data.point_multiple
    self.title = data.title
    self.effectDes = data.effect_des
    self.difficultyDes = data.difficulty_des
    self.suggestEle = data.suggest_ele
end

function getTitle(self)
    return _TT(self.title)
end

function getEffectDes(self)
    if self.effectDes <= 0 then
        return false
    end
    return _TT(self.effectDes)
end

function getDifficultyDes(self)
    if self.difficultyDes <= 0 then
        return false
    end
    return self.difficultyDes
end

function getPointMultiple(self)
    return self.pointMultiple / 100
end

function getSuggestEle(self)
    return self.suggestEle
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
