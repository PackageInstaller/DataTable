--[[ 
-----------------------------------------------------
@filename       : FirstChargeVo
@Description    : 首充解析
@date           : 2023-04-2 13:54:15
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.firstCharge.manager.vo.FirstChargeVo', Class.impl())

function parseData(self, daily, msg)
    self.daily = daily
    self.itemList = msg.item
end


function getCurDaily(self)
    return self.daily
end
--是否可领取
function getIsCanRecive(self)
    return firstCharge.FirstChargeManager:getIsCanReciveByDay(self.daily)
end
--是否已领取
function getIsRecived(self)
    return firstCharge.FirstChargeManager:getIsRecivedByDay(self.daily)
end

function getItemList(self)
    return self.itemList
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]