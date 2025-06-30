--[[ 
-----------------------------------------------------
@filename       : ActivityCarnivalVo
@Description    : 狂欢好礼配置解析
@date           : 2024-09-11
@Author         : Shuai
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.activity.manager.vo.ActivityCarnivalVo', Class.impl())

function parseData(self, id, data)
    self.id = id
    self.rewardid = data.reward
end

function getAwardList(self)
    return AwardPackManager:getAwardListById(self.rewardid)
end

function getId(self)
    return self.id
end

function getIsCanRec(self)
    return (activity.ActitvityExtraManager:getIsOpenByDay(self.id) and not self:getIsRecived())
end

function getIsRecived(self)
    return activity.ActitvityExtraManager:getIsRecivedByDay(self.id)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]