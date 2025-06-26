-- @FileName:   FieldExplorationHeroConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.manager.configVo.FieldExplorationHeroConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key
    self.heroTid = cusData.hero_id
    self.life = cusData.life
    self.energy = cusData.energy
    self.agent_radius = cusData.agent_radius * 0.01
    self.agent_height = cusData.agent_height * 0.01
    self.normal_speed = cusData.normal_speed * 0.01
    self.skill = cusData.skill
end

return _M
