local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

-- 微缩世界主线剧情表

---@class MiniWorldMainChapterVo
local MiniWorldMainChapterVo = Class("MiniWorldMainChapterVo", SettingRefBase)

function MiniWorldMainChapterVo:__init()
    self.id = nil               -- 关卡id
    self.desc = nil            -- 剧情梗概表ID
    self.plotIdStory = nil            -- 纯剧情点剧情id
    self.plotIdWave = nil            -- 战前剧情id
    self.plotIdEndWave = nil            -- 战后剧情id
    self.status = nil               --状态
end

---FillVo
---@param row TableML.TableFileRow
function MiniWorldMainChapterVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.desc = parse_number(row, "desc")
    self.plotIdStory = parse_string(row, "plotIdStory")
    self.plotIdWave = parse_string(row, "plotIdWave")
    self.plotIdEndWave = parse_string(row, "plotIdEndWave")          
    self.status = parse_number(row, "status")
end

function MiniWorldMainChapterVo:__delete()
    self.id = nil               -- 关卡id
    self.desc = nil            -- 剧情梗概表ID
    self.plotIdStory = nil            -- 纯剧情点剧情id
    self.plotIdWave = nil            -- 战前剧情id
    self.plotIdEndWave = nil            -- 战后剧情id
    self.status = nil               --状态
end

return MiniWorldMainChapterVo
