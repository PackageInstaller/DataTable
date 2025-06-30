--[[ 
-----------------------------------------------------
@filename       : CovenantTalentGeneVo
@Description    : 盟约助手基因信息
@date           : 2021-06-21 16:02:40
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.covenantTalent.manager.vo.CovenantTalentGeneVo', Class.impl())

function parseMsg(self, cusMsg)
    self.id = cusMsg.groove_id
    self.lvl = cusMsg.gene_lv
    self.type = cusMsg.type
    self.isActive = cusMsg.is_active
    -- 是否解锁 0-未解锁 1-解锁
    self.isUnLock = cusMsg.is_unlock
    -- 展示数值列表
    self.showValues = cusMsg.show_value
    self.orderVo = nil
    if table.nums(cusMsg.order_info) > 0 then
        self.orderVo = LuaPoolMgr:poolGet(props.OrderVo)
        self.orderVo:setEquipDetailMsgData(cusMsg.order_info[1])
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
