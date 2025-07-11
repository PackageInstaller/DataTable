-- @FileName:   SandPlayFishBaitConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.manager.configVo.SandPlayFishBaitConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key
    self.bite_time = cusData.bite_time --咬钩时间

    self.fishlist = cusData.fishlist
    self.sort_index = cusData.sort
end

return _M
