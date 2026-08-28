local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

-- 微缩世界陷阱表

---@class MiniWorldTrapVo
local MiniWorldTrapVo = Class("MiniWorldTrapVo", SettingRefBase)

function MiniWorldTrapVo:__init()
    self.id = nil
    self.name = nil            -- 陷阱名称
    self.desc = nil              -- 陷阱描述
    self.type = nil               -- 陷阱类型：1地刺、2移动NPC、3八哥突袭
    self.icon = nil               -- 陷阱图标
    self.score = nil               -- 自由探索积分
    self.status = nil               --状态
end

---FillVo
---@param row TableML.TableFileRow
function MiniWorldTrapVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.name = ParseUtils.ParseLocalizeText(row, "name")        
    self.desc = ParseUtils.ParseLocalizeText(row, "desc")
    self.type = parse_number(row, "type")       
    self.icon = ParseUtils.ParsePathName(row, "icon")    
    self.score = parse_number(row, "score")            
    self.status = parse_number(row, "status")
end

function MiniWorldTrapVo:__delete()
    self.id = nil
    self.name = nil            -- 陷阱名称
    self.desc = nil              -- 陷阱描述
    self.type = nil               -- 陷阱类型：1地刺、2移动NPC、3八哥突袭
    self.icon = nil               -- 陷阱图标
    self.score = nil               -- 自由探索积分
    self.status = nil               --状态
end

return MiniWorldTrapVo
