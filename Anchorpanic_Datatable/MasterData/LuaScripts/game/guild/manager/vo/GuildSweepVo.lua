module('guild.GuildSweepVo', Class.impl())

function parseData(self,id,cusData)

    self.roundId = id
     
    self.mapId = cusData.map_id
    --关卡
    self.stage = cusData.stage
    --名字
    self.name = cusData.name
    --怪物等级
    self.imageId = cusData.image_id
    --模型id
    self.modelTid = cusData.model_tid
end

return _M