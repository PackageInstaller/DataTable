-- @FileName:   DanKeMonsterSkillConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.manager.vo.DanKeMonsterSkillConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.tid = key
    self.type = cusData.type
    self.param = cusData.param
    self.bullet_speed = cusData.bullet_speed * 0.01
    self.damage = cusData.damage
    self.cd = cusData.cd * 0.001
    self.is_pass = cusData.is_pass
    self.is_stand = cusData.is_stand == 1
    self.res = cusData.res
    self.scale = cusData.multiple * 0.01
    self.agent_radius = cusData.agent_radius
end

function getRes(self)
    return "arts/fx/3d/sceneModule/danke/" .. self.res
end

return _M
