--[[ 
-----------------------------------------------------
@filename       : FavorableGiveVo
@Description    : 好感度礼物数据
@date           : 2022-02-21 20:04:33
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.favorable.manager.vo.FavorableGiveVo', Class.impl())

function setData(self, id, tid)
    -- 道具id
    self.propsId = id
    -- 道具tid
    self.propsTid = tid
    self.propsConfigVo = props.PropsManager:getPropsConfigVo(tid)

    -- 当前选择数量
    self.seletctCount = 0
end

-- 获取好感度（道具效果参数为固定好感度，喜欢增加，不喜欢减少配置值）
function getFavorableValue(self)
    local value = self.propsConfigVo.effectList[1]
    local isLike, likeValue = self:getIsLike()
    local isDislike, disLikeValue = self:getIsDislike()
    if isLike then
        return value + likeValue
    end
    if isDislike then
        return value - disLikeValue
    end
    return value
end

-- 返回值1 是否为喜欢的礼物， 返回值2 额外值
function getIsLike(self)
    return favorable.FavorableManager:checkIsLike(self.propsTid)
end

-- 返回值1 是否为不喜欢的礼物， 返回值2 额外值
function getIsDislike(self)
    return favorable.FavorableManager:checkIsDislike(self.propsTid)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
