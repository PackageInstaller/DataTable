

local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---@class FashionPassScheduleVo
local FashionPassScheduleVo = Class("FashionPassScheduleVo", SettingRefBase)

function FashionPassScheduleVo:__init()
    self:CleanFields()
end

function FashionPassScheduleVo:__delete()
    self:CleanFields()
end

function FashionPassScheduleVo:CleanFields()
    self.id = nil
    self.lobbyMode = nil
    self.bodyIcon = nil
    self.sceneId = nil
    self.commodityId = nil
    self.goodsConsum = nil
    self.goodsConsumNum = nil
    self.mailId = nil
    self.ruleID = nil
    self.desc = nil
    self.status = nil

end

---FillVo
---@param row TableML.TableFileRow
function FashionPassScheduleVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, 'id') -- 编号
    self.lobbyMode = parse_number(row, 'lobbyMode') -- 卡牌展示id
    self.bodyIcon = parse_pathName(row, 'bodyIcon') -- 立绘ID
    self.sceneId = parse_pathName(row, 'sceneId') -- 背景图片
    self.commodityId = parse_number(row, 'commodityId') -- 商品id
    self.goodsConsum = parse_number(row, 'goodsConsum', 0) -- 消耗道具（0表示现金）
    self.goodsConsumNum = parse_number(row, 'goodsConsumNum') -- 消耗道具数量
    self.mailId = parse_number(row, 'mailId') -- 补发邮件id
    self.ruleID = parse_number(row, 'ruleID') -- 功能规则
    self.desc = parse_localizeText(row, 'desc') -- 界面描述语
    self.status = parse_number(row, 'status') -- 状态

end

return FashionPassScheduleVo
