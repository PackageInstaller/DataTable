module("buildBase.BuildBaseLevelsVo", Class.impl())

function parseConfigData(self,id,data)
    self.id = id
    self.datas = data
    self.des = data.des

    self.levelsDic = {}
    self:parseLevelsData()
end

function parseLevelsData(self)
    for k, v in pairs(self.datas.build_level) do
        local vo = buildBase.BuildBaseLevelVo.new()
        vo:parseConfigData(k,v)
        self.levelsDic[vo.level] = vo
    end
end

--获取对应等级的数据
function getLevelDataVo(self,lv)
    return self.levelsDic[lv]
end



return _M
