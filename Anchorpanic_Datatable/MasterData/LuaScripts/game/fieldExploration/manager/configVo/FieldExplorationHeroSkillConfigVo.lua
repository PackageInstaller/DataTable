-- @FileName:   FieldExplorationHeroSkillConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.manager.configVo.FieldExplorationHeroSkillConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.skillTid = key
    self.type = cusData.type
    self.effect = cusData.effect
    self.buff_id = cusData.buff_id
    self.use_cd_time = cusData.use_cd_time
    self.max_useCount = cusData.max_useCount
    self.cd_time = cusData.cd_time
    self.actionName = cusData.action_res
    self.icon = cusData.icon

    self.ui_effect = cusData.icon_effect
    self.trigger_effct = cusData.release_effect
    self.trigger_sound = cusData.sound_effect[1]

    self.damage_type = cusData.damage_type
    self.damage_range = cusData.damage_range
end

return _M
