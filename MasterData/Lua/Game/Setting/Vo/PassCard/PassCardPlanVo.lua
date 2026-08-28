-------------------------------------------------------------------------------
-- Pass卡 - 排期表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-30 11:33:34
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class PassCardPlanVo : SettingRefBase @see AutoIds.IdSetting4055
local PassCardPlanVo = Class('PassCardPlanVo', SettingRefBase)


function PassCardPlanVo:__init()
    ---@type integer @ 排期ID
    self.scheduleId = nil

    ---@type string @ 开始时间
    self.startTime = nil
    
    ---@type string @ 结束时间
    self.endTime = nil

    ---@type string @ 标准Pass卡标题
    self.normalPassDescr = nil

    ---@type string @ 豪华Pass卡标题
    self.deluxePassDescr = nil

    ---@type table[] @ 购买豪华Pass卡获得奖励
    self.deluxeRewards = nil

    ---@type integer @ Pass卡经验道具id
    self.passExpGoodsId = nil

    ---@type integer @ 购买豪华Pass卡获得经验值
    self.deluxeRewardExp = nil

    ---@type table[] @ 展示解锁道具
    self.exhibitionGoods = nil

    ---@type integer @ 循环宝箱经验值
    self.loopExpNum = nil

    ---@type integer @ 循环宝箱奖励ID
    self.loopChestId = nil

    ---@type integer @ 循环宝箱奖励数量
    self.loopChestNum = nil

    ---@type string @ 循环宝箱图标路径
    self.loopChestIcon = nil

    ---@type integer @ 卡牌展示id
    self.lobbyModeId = nil

    ---@type string @ 卡牌展示路径
    self.lobbyModelPath = nil

    ---@type string @ 背景图片路径
    self.backgroundPath = nil

    ---@type integer @ 最大奖励等级
    self.passLevelMax = nil

    ---@type string @ 主界面图标路径
    self.homeIconPath = nil

    ---@type integer @ 特殊图标（1：开服限定）
    self.specialIcon = nil

    ---@type integer[] @ 豪华Pass卡展示奖励
    self.deluxeShowGoods = nil
end


function PassCardPlanVo:__delete()
    self.scheduleId      = nil
    self.startTime       = nil
    self.endTime         = nil
    self.normalPassDescr = nil
    self.deluxePassDescr = nil
    self.deluxeRewards   = nil
    self.passExpGoodsId  = nil
    self.deluxeRewardExp = nil
    self.exhibitionGoods = nil
    self.loopExpNum      = nil
    self.loopChestId     = nil
    self.loopChestNum    = nil
    self.loopChestIcon   = nil
    self.lobbyModeId     = nil
    self.lobbyModelPath  = nil
    self.backgroundPath  = nil
    self.passLevelMax    = nil
    self.homeIconPath    = nil
    self.specialIcon     = nil
    self.deluxeShowGoods = nil
end


---@param row TableML.TableFileRow
function PassCardPlanVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.scheduleId      = parse_number(row, 'id')
    self.startTime       = parse_string(row, 'startDay')
    self.endTime         = parse_string(row, 'endDay')
    self.normalPassDescr = parse_localizeText(row, 'titleDesc2', true)
    self.deluxePassDescr = parse_localizeText(row, 'titleDesc', true)
    self.deluxeRewards   = parse_rewardData(row, 'AdvancedGoodsID', 'AdvancedGoodsNum')
    self.passExpGoodsId  = parse_number(row, 'advancedExpItem')
    self.deluxeRewardExp = parse_number(row, 'AdvancedExpNum')
    self.exhibitionGoods = parse_rewardData(row, 'Exhibitiongoods', 'ExhibitiongoodsNum')
    self.loopExpNum      = parse_number(row, 'loopTreasureExp')
    self.loopChestId     = parse_number(row, 'loopTreasureGoodsId')
    self.loopChestNum    = parse_number(row, 'loopTreasureGoodsNum')
    self.loopChestIcon   = parse_pathName(row, 'loopTreasureGoodsIcon')
    self.lobbyModeId     = parse_number(row, 'lobbyMode')
    self.lobbyModelPath  = parse_pathName(row, 'bodyIcon')
    self.backgroundPath  = parse_pathName(row, 'background')
    self.homeIconPath    = parse_pathName(row, 'homeIcon')
    self.passLevelMax    = parse_number(row, 'maxLv')
    self.specialIcon     = parse_number(row, 'specialIcon')
    self.deluxeShowGoods = parse_numbers(row, 'luxuryPropsIcon', ';')
end


return PassCardPlanVo
