module("HeroIncreasesVo",Class.impl())

function parseHeroIncreasesData(self,cusData)
    --数据字典
    self.increaseDic = {}

    for id,data in pairs(cusData.increases_data) do
        local vo = hero.IncreasesVo.new()
        vo:parseIncreasesVo(data)
        self.increaseDic[vo.lv] = vo
    end
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
