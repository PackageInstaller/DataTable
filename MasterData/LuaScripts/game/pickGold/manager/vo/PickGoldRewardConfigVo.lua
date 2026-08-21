-- @FileName:   PickGoldRewardConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.pickGold.manager.vo.PickGoldRewardConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key
    self.type = cusData.type
    self.points = cusData.sub_type
    self.reward = cusData.reward
    self.des = cusData.des
end

function getDesc(self)
    return _TT(self.des)
end

return _M
