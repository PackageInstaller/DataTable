-------------------------------------------------------------------------------
-- 和风战牌 - 初始卡牌
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-16 14:24:31
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class BattleCardGameCardInfoVo : SettingRefBase @ AutoIds.IdSetting10001
local BattleCardGameCardInfoVo = Class('BattleCardGameCardInfoVo', SettingRefBase)


function BattleCardGameCardInfoVo:__init()
    ---@type integer @ 卡牌id
    self.cardId = 0

    ---@type string @ 卡牌名字
    self.cardName = ''

    ---@type integer @ 同盟id
    self.cardKind = 0

    ---@type integer @ 卡牌星级
    self.cardStar = 0

    ---@type integer[] @ 四边属性：上，右，下，左
    self.attributes = 0

    ---@type table @ 重复转换定义
    self.exchange = {}

    ---@type boolean @ 是否新品上架（置顶 & new角标）
    self.isNewly = false

    ---@type string @ 卡牌图片
    self.drawPath = ''

    ---@type string @ 卡牌图片2
    self.drawPath2 = ''
end


function BattleCardGameCardInfoVo:__delete()
    self.cardId     = nil
    self.cardName   = nil
    self.cardKind   = nil
    self.cardStar   = nil
    self.attributes = nil
    self.exchange   = nil
    self.isNewly    = nil
    self.drawPath   = nil
    self.drawPath2  = nil
end


---@param row TableML.TableFileRow
---@return BattleCardGameCardInfoVo
function BattleCardGameCardInfoVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.cardId     = parse_number(row, 'id')
    self.cardName   = parse_localizeText(row, 'name')
    self.cardKind   = parse_number(row, 'type')
    self.cardStar   = parse_number(row, 'level')
    self.attributes = parse_numbers(row, 'attribute')
    self.exchange   = parse_rewardData(row, 'changeId', 'changeNum')
    self.isNewly    = parse_number(row, 'isNew') == 1

    if self:IsAdvanced() then
        local basePath = parse_string(row, 'pic')
        self.drawPath  = parse_pathNameByData(basePath .. '_1')
        self.drawPath2 = parse_pathNameByData(basePath .. '_2')
    else
        self.drawPath = parse_pathName(row, 'pic')
    end

    return self
end


--- 是否高级卡牌
-- @return boolean
function BattleCardGameCardInfoVo:IsAdvanced()
    return checkInt(self.cardStar) >= BattleCardGameUtils.CardAdvancedStar
end


--- 是否光效卡牌
function BattleCardGameCardInfoVo:IsEffected()
    return checkInt(self.cardStar) >= BattleCardGameUtils.CardEffectedStar
end


--- 上边 属性值
---@return integer
function BattleCardGameCardInfoVo:GetAttrTop()
    return checkInt(self.attributes[BattleCardGameUtils.CardAttrIndex.TOP])
end


--- 下边 属性值
---@return integer
function BattleCardGameCardInfoVo:GetAttrBottom()
    return checkInt(self.attributes[BattleCardGameUtils.CardAttrIndex.BOTTOM])
end


--- 左边 属性值
---@return integer
function BattleCardGameCardInfoVo:GetAttrLeft()
    return checkInt(self.attributes[BattleCardGameUtils.CardAttrIndex.LEFT])
end


--- 右边 属性值
---@return integer
function BattleCardGameCardInfoVo:GetAttrRight()
    return checkInt(self.attributes[BattleCardGameUtils.CardAttrIndex.RIGHT])
end


return BattleCardGameCardInfoVo
