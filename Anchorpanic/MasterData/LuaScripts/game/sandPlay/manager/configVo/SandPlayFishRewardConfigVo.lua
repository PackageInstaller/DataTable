-- @FileName:   SandPlayFishRewardConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.manager.configVo.SandPlayFishRewardConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key

    self.fish_list = cusData.fish_list --咬钩时间
    self.reward = cusData.reward
    self.name = cusData.name
end

return _M
