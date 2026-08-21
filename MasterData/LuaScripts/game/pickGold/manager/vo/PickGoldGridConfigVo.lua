-- @FileName:   PickGoldGridConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.pickGold.manager.vo.PickGoldGridConfigVo', Class.impl())

function parseCogfigData(self, key, cusData, weight)
    self.id = key
    self.icon = cusData.icon
    self.score = cusData.score
    self.angle = cusData.angle
    self.sound = cusData.sound
end

function getSoundPath(self)
    return string.format("arts/audio/UI/minigames/%s.prefab",self.sound)
end

return _M
