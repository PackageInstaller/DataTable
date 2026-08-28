-------------------------------------------------------------------------------
-- 海外图鉴 - 关键词百科vo
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-08-18 16:42:51
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class IllustratedEncyKeywordVo : SettingRefBase @see AutoIds.IdSetting916
local IllustratedEncyKeywordVo = Class('IllustratedEncyKeywordVo', SettingRefBase)


function IllustratedEncyKeywordVo:__init()
    ---@type integer @ 编号（四位数，1xxx为组织势力；2xxx为专有名词
    self.encyId = nil
    ---@type integer @ 所属页签（1=组织势力，2=专有名词）
    self.encyTag = nil
    ---@type string @ 词条名
    self.name = nil
    ---@type string @ 词条内容
    self.descr = nil
    ---@type string @ 图标
    self.icon = nil
    ---@type integer[] @ 关联词条（对应关联词条id，英文分号隔开）
    self.relations = {}
    ---@type integer @ 解锁关卡（主线关卡表id）
    self.unlockNum = nil
end


function IllustratedEncyKeywordVo:__delete()
    self.encyId    = nil
    self.encyTag   = nil
    self.name      = nil
    self.descr     = nil
    self.icon      = nil
    self.relations = nil
    self.unlockNum = nil
end


---@param row TableML.TableFileRow
function IllustratedEncyKeywordVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.encyId    = parse_number(row, 'id')
    self.encyTag   = parse_number(row, 'tag')
    self.name      = parse_localizeText(row, 'name1')
    self.descr     = parse_localizeText(row, 'name2', true)
    self.icon      = parse_pathName(row, 'icon')
    self.relations = parse_numbers(row, 'relation', ';')
    self.unlockNum = parse_number(row, 'unlockNum')
end


return IllustratedEncyKeywordVo
