-------------------------------------------------------------------------------
-- 夜巡迷宫 - 迷宫诅咒表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-26 20:13:30
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class PatrolMazeCurseVo : SettingRefBase @ AutoIds.IdSetting362
local PatrolMazeCurseVo = Class('PatrolMazeCurseVo', SettingRefBase)


function PatrolMazeCurseVo:__init()
    ---@type integer @ 诅咒id
    self.curseId = 0
    
    ---@type string @ 名字
    self.name = 0

    ---@type string @ 描述
    self.descr = 0
    
    ---@type integer @ 属性加成方式（0-直接加成 1-按圣物数量加成 2-按红色角色数量加成 3-按绿色角色数量加成 4-按蓝色角色数量加成）
    self.addType = 0
    
    ---@type PatrolMazeUtils.CurseEffectType @ 效果类型（0：延续之前逻辑，读取效果ID；1：选择圣物界面无法刷新圣物；2：刷新圣物消耗翻倍）
    self.effectType = 0
    
    ---@type integer @ 效果id
    self.buffId = 0
    
    ---@type string @ 图标路径
    self.iconPath = 0
    
    ---@type integer @ 品质(白1;绿2;蓝3;紫4;橙5)
    self.quality = 1
end


function PatrolMazeCurseVo:__delete()
    self.curseId    = nil
    self.name       = nil
    self.descr      = nil
    self.addType    = nil
    self.effectType = nil
    self.buffId     = nil
    self.iconPath   = nil
end


---@param row TableML.TableFileRow
function PatrolMazeCurseVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.curseId    = parse_number(row, 'Id')
    self.name       = parse_localizeText(row, 'name')
    self.descr      = parse_localizeText(row, 'description', true)
    self.addType    = parse_number(row, 'AddType')
    self.effectType = parse_number(row, 'Effect_type')
    self.buffId     = parse_number(row, 'buffId')
    self.iconPath   = parse_pathName(row, 'photoId')
    self.quality    = parse_number(row, 'quality')
end


return PatrolMazeCurseVo
