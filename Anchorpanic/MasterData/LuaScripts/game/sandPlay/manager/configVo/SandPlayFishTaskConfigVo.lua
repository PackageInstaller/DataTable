-- @FileName:   SandPlayFishTaskConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.manager.configVo.SandPlayFishTaskConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key

    self.count = cusData.times
    self.reward = cusData.reward
    self.des = _TT(cusData.des)
    self.name = _TT(cusData.name)
end

return _M
