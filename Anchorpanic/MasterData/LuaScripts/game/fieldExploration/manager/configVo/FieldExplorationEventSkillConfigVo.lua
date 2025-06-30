-- @FileName:   FieldExplorationEventSkillConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.manager.configVo.FieldExplorationEventSkillConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.tid = key
    self.type = cusData.type
    self.buff_id = cusData.buff_id
    self.param = cusData.param --技能参数
    self.decide_time = cusData.decide_time
    self.damage_cd = cusData.damage_cd
    self.range_type = cusData.range_type --伤害范围碰撞类型（-1不需要添加，列如金币）
    self.range_subtype = cusData.range_subtype
    self.is_show_range = cusData.is_show_range == 1 --是否显示伤害范围（列如炸弹）
end

return _M
