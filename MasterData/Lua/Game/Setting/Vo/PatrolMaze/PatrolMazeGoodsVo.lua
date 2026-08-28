-------------------------------------------------------------------------------
-- 夜巡迷宫 - 迷宫道具表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-26 20:13:30
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class PatrolMazeGoodsVo : SettingRefBase @ AutoIds.IdSetting353
local PatrolMazeGoodsVo = Class('PatrolMazeGoodsVo', SettingRefBase)


function PatrolMazeGoodsVo:__init()
    ---@type integer @ 道具id
    self.goodsId = 0

    ---@type integer @ 兼容GoodsVo用
    self.id = 0
    
    ---@type string @ 名字
    self.name = nil

    ---@type string @ 描述
    self.descr = nil

    ---@type string @ 兼容GoodsVo用
    self.desc = nil

    ---@type integer @ 道具品质,1,白;2,绿;3,蓝;4,紫;5,橙;6,彩色
    self.quality = 0

    ---@type PatrolMazeUtils.EffectType @ 效果类型 (1.恢复 2.复活 3.消除 4.SP增加 5.关卡增益（类型参数填写关卡增益表id）6.战斗员升星7.关卡结算时可以多选择1个圣物)
    self.effectType = 0

    ---@type number @ 效果值
    self.effectNum = 0

    ---@type integer @ 目标类型(1.指定 2.全体 3.随机)
    self.targetType = 0
    
    ---@type integer @ 目标参数（目标数量1一个，2个）
    self.targetNum = 0

    ---@type integer @ 显示类型（道具表/道具显示类型表）
    self.showType = 0

    ---@type integer @ 生效战斗次数（-1为无限次，0为不按战斗场次生效）
    self.effectiveTime = 0

    ---@type string @ 图标路径
    self.iconPath = nil
    
    ---@type string @ 兼容GoodsVo用
    self.photoPath = nil
end


function PatrolMazeGoodsVo:__delete()
    self.goodsId       = nil
    self.id            = nil
    self.name          = nil
    self.desc          = nil
    self.descr         = nil
    self.quality       = nil
    self.effectType    = nil
    self.effectNum     = nil
    self.targetType    = nil
    self.targetNum     = nil
    self.showType      = nil
    self.effectiveTime = nil
    self.iconPath      = nil
    self.photoPath     = nil
end


---@param row TableML.TableFileRow
function PatrolMazeGoodsVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.goodsId       = parse_number(row, 'id')
    self.name          = parse_localizeText(row, 'name')
    self.descr         = parse_localizeText(row, 'desc', true)
    self.quality       = parse_number(row, 'quality')
    self.effectType    = parse_number(row, 'effectType')
    self.effectNum     = parse_number(row, 'effectNum')
    self.targetType    = parse_number(row, 'targetType')
    self.targetNum     = parse_number(row, 'targetNum')
    self.showType      = parse_number(row, 'showType')
    self.effectiveTime = parse_number(row, 'effectiveTime')
    self.iconPath      = parse_pathName(row, 'photoId')
    
    self.id        = self.goodsId
    self.desc      = self.descr
    self.photoPath = self.iconPath
end


return PatrolMazeGoodsVo
