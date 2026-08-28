local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

-- 微缩世界增益道具表

---@class MiniWorldBuffItemVo
local MiniWorldBuffItemVo = Class("MiniWorldBuffItemVo", SettingRefBase)

function MiniWorldBuffItemVo:__init()
    self.id = nil
    self.name = nil            -- 增益名称
    self.desc = nil              -- 增益描述
    self.type = nil               -- 增益类型：1护盾、2无敌冲刺、3八哥増时、4吸铁石、5隐身道具、6收集类道具、7攻击八哥道具
    self.icon = nil               -- 增益图标
    self.score = nil               -- 自由探索积分
    self.status = nil               --状态
end

---FillVo
---@param row TableML.TableFileRow
function MiniWorldBuffItemVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.name = ParseUtils.ParseLocalizeText(row, "name")        
    self.desc = ParseUtils.ParseLocalizeText(row, "desc")
    self.type = parse_number(row, "type")       
    self.icon = ParseUtils.ParsePathName(row, "icon")    
    self.score = parse_number(row, "score")            
    self.status = parse_number(row, "status")
end

function MiniWorldBuffItemVo:__delete()
    self.id = nil
    self.name = nil            -- 增益名称
    self.desc = nil              -- 增益描述
    self.type = nil               -- 增益类型：1护盾、2无敌冲刺、3八哥増时、4吸铁石、5隐身道具、6收集类道具、7攻击八哥道具
    self.icon = nil               -- 增益图标
    self.score = nil               -- 自由探索积分
    self.status = nil               --状态
end

return MiniWorldBuffItemVo
