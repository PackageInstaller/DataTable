-------------------------------------------------------------------------------
-- 海外图鉴 - 区域百科vo
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-08-18 16:41:22
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class IllustratedEncyAreaVo : SettingRefBase @see AutoIds.IdSetting915
local IllustratedEncyAreaVo = Class('IllustratedEncyAreaVo', SettingRefBase)


function IllustratedEncyAreaVo:__init()
    ---@type integer @ 百科id
    self.encyId = nil
    ---@type integer @ 百科页签（1=城市，2=区，3=地标建筑）
    self.encyTag = nil
    ---@type integer @ 所属地（上层是哪个区域/城市）
    self.area = nil
    ---@type string @ 地点名称
    self.name = nil
    ---@type string @ 地点介绍
    self.descr = nil
    ---@type string @ 地区背景图
    self.bgImg = nil
end


function IllustratedEncyAreaVo:__delete()
    self.encyId  = nil
    self.encyTag = nil
    self.area    = nil
    self.name    = nil
    self.descr   = nil
    self.bgImg   = nil
end


---@param row TableML.TableFileRow
function IllustratedEncyAreaVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.encyId  = parse_number(row, 'id')
    self.encyTag = parse_number(row, 'tag')
    self.area    = parse_number(row, 'area')
    self.name    = parse_localizeText(row, 'name1')
    self.descr   = parse_localizeText(row, 'name2', true)
    self.bgImg   = parse_pathName(row, 'imgbg')
end


return IllustratedEncyAreaVo
