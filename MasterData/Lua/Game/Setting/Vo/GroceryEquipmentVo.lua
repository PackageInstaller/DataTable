-------------------------------------------------------------------------------
-- 杂货铺 - 装备卡池设定表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-03-17 16:28:05
-------------------------------------------------------------------------------

local ParseUtils     = CS.ParseUtils
local SettingRefBase = import('Game.Setting.SettingRefBase')
---@class GroceryEquipmentVo : SettingRefBase
local GroceryEquipmentVo = Class("GroceryEquipmentVo", SettingRefBase)


function GroceryEquipmentVo:__init()
    self.poolId         = nil  -- 卡池id
    self.poolType       = nil  -- 卡池类型
    self.name           = nil  -- 卡池名称
    self.resource       = nil  -- 卡池资源
    self.cardId         = nil  -- 卡牌id
    self.sort           = nil  -- 排序规则
    self.unlockId       = nil  -- 解锁条件
    self.activity       = nil  -- 是否活动卡池
    self.substituteProp = nil  -- 代币id
    self.singleProp     = nil  -- 单抽道具id
    self.singleConsume  = nil  -- 单抽消耗
    self.singleCoin     = nil  -- 单抽可得代币
    self.singleCoinNum  = nil  -- 单抽可得代币
    self.tenProp        = nil  -- 十抽道具id
    self.tenConsume     = nil  -- 十抽消耗
    self.tenCoin        = nil  -- 十抽可得代币
    self.tenCoinNum     = nil  -- 十抽可得代币
end


function GroceryEquipmentVo:__delete()
end


function GroceryEquipmentVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.poolId         = parse_number(row, 'poolId', 0)
    self.poolType       = parse_number(row, 'poolType', 0)
    self.name           = CfUtils.GetCfDataByLine(row, 'name', Constants.DataType.LocalString)
    self.resource       = parse_number(row, 'resource', 0)
    self.cardId         = ParseUtils.ParseListIntByHeaderName(row, 'cardId')
    self.sort           = parse_number(row, 'sort', 0)
    self.unlockId       = parse_number(row, 'unlockId', 0)
    self.activity       = parse_number(row, 'activity', 0)
    self.substituteProp = parse_number(row, 'substituteProp', 0)
    self.singleProp     = parse_number(row, 'singleProp', 0)
    self.singleConsume  = parse_number(row, 'singleConsume', 0)
    self.singleCoin     = parse_number(row, 'singleCoin', 0)
    self.singleCoinNum  = parse_number(row, 'singleCoinNum', 0)
    self.tenProp        = parse_number(row, 'tenProp', 0)
    self.tenConsume     = parse_number(row, 'tenConsume', 0)
    self.tenCoin        = parse_number(row, 'tenCoin', 0)
    self.tenCoinNum     = parse_number(row, 'tenCoinNum', 0)
end

return GroceryEquipmentVo