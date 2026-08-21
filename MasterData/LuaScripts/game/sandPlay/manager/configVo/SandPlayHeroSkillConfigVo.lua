-- @FileName:   SandPlayHeroSkillConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.manager.configVo.SandPlayHeroSkillConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.skillTid = key
    self.type = cusData.type
    self.effect = cusData.effect
    self.icon = cusData.icon

    self.max_useCount = cusData.max_useCount

    self.trigger_effct = cusData.release_effect
    self.trigger_sound = cusData.sound_effect[1]

    self.damage_type = cusData.damage_type
    self.damage_range = cusData.damage_range
    self.ui_effect = cusData.icon_effect
end

return _M
