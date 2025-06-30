-- @FileName:   SandPlayHappyFarmSeedConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.manager.configVo.SandPlayHappyFarmSeedConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key
    self.type = cusData.type
    self.subtype = cusData.subtype
    self.production_cycle = cusData.production_cycle
    self.cost = cusData.cost
    self.produce = cusData.produce
    self.model = cusData.model
    self.ripe_time = cusData.ripe_time
    self.name = cusData.name
    self.des = cusData.des
    self.icon = cusData.icon
    self.ai_params = cusData.ai_params
    self.produce_des = cusData.produce_des
end

function getStandTime(self)
    local rand_time = self.ai_params[2]
    return math.random(rand_time[1], rand_time[2])
end

function getName(self)
    return _TT(self.name)
end

function getDesc(self)
    return _TT(self.des)
end

function getIcon(self)
    return self.icon
end

return _M
