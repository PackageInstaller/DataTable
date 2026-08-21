-- @FileName:   DanKePlayerSkillConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.manager.vo.DanKePlayerSkillConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.tid = key
    self.type = cusData.type
    self.subtype = cusData.subtype
    self.icon = cusData.icon
    self.name = cusData.name

    self.skill_level = table.copy(cusData.skill_level)
end

function getLevelConfig(self, level)
    return self.skill_level[level]
end

function getName(self)
    return _TT(self.name)
end

function getIcon(self)
    return "arts/ui/icon/danke/" .. self.icon
end

return _M
