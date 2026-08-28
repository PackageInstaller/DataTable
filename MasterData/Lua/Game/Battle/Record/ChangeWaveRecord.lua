--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:luqucheng
    time:2020-03-12 15:12:22
]]
local ChangeWaveRecord = Class("ChangeWaveRecord")

--@buff: [Game.Battle.Core.Buff#Buff]
function  ChangeWaveRecord:__init(waveNum, wave, camp, maxNum)
    self.waveNum = waveNum
    self.maxNum = maxNum
    self.camp = camp
    self.wave = wave
end

function ChangeWaveRecord:ToData()
    local moudleIds = {}
    for i,v in ipairs(self.wave) do
        table.insert(moudleIds, v.id)
    end
    return {
        r = Constants.RecordType.ChangeWave,--战报类型
        waveNum = self.waveNum,--当前波次
        maxNum = self.maxNum,
        camp = self.camp,
        moudleIds = moudleIds,
    }
end

return  ChangeWaveRecord