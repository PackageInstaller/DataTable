--[[ 
-----------------------------------------------------
@filename       : OrderVo
@Description    : 战盟序列物数据
@date           : 2021-06-22 16:12:36
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.covenantTalent.manager.vo.OrderVo', Class.impl(equip.EquipVo))

-- 请求详细数据
function __dispatchReqDetailData(self)
    if (self.id) then
        -- 含有id向服务器获取属性
        GameDispatcher:dispatchEvent(EventName.REQ_ORDER_DETAIL_DATA, { helperId = self.heroId, orderId = self.id })
    else
        -- 此类情况是，该装备没穿戴在英雄身上，也没在背包内，即作为单纯奖励展示，则属性全读配置表，根据需求实现获取方式
        Debug:log_warn("EquipVo", "某些配置属性数据未实现本地获取")
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
