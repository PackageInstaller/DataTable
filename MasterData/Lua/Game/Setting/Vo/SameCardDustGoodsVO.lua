local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

-- 77同卡粉尘道具表


---@class SameCardDustGoodsVO
local SameCardDustGoodsVO = Class("SameCardDustGoodsVO", SettingRefBase)

function SameCardDustGoodsVO:__init()
    self.id = nil               -- 道具编号
    self.type = nil               --道具类型:
    self.showType = nil               --显示类型
    self.name = nil               --名字
    self.desc = nil               --用途（加粗文本
    self.description = nil               --文案包装（普通文本
    self.quality = nil               --道具品质,1,白;2,绿;3,蓝;4,紫;5,橙;6,彩色
    self.stack = nil               --背包堆叠:最大堆叠数量
    --self.openType = nil               --跳转目标（填功能切割表里的ID）
    --self.openParameter = nil               --跳转参数（填写关卡ID）
    self.jumpAway = nil
    self.jumpParameter = nil
    
    self.photoId = nil               --图片id（待出资源，先用其他资源显示)
    self.effectType = nil               --效果类型 (读效果类型枚举表
    self.effectId = nil               --对应ID
    self.effectNum = nil               --效果数量
    self.Maxnum = nil               --最大数量
    self.cardId = nil               --对应卡牌ID
    self.needNum = nil               --合成需要数量
    self.status = nil               --状态
end

---FillVo
---@param row TableML.TableFileRow
function SameCardDustGoodsVO:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")   
    self.type = parse_number(row, "type")   
    self.showType = parse_number(row, "showType") 
    self.name           = parse_localizeText(row, "name")
    self.desc            = parse_localizeText(row, "desc")
    self.description            = parse_localizeText(row, "description")
    self.quality = parse_number(row, "quality")
    self.stack = parse_number(row, "stack")
    --self.openType        = parse_string(row, "openType")
    --self.openParameter = parse_string(row, "openParameter")
    self.photoPath = ParseUtils.ParsePathName(row, "photoId")
    self.effectType = parse_number(row, "effectType")
    self.effectId = parse_number(row, "effectId")
    self.effectNum = parse_number(row, "effectNum")
    self.Maxnum = parse_number(row, "Maxnum")
    self.cardId = parse_number(row, "cardId")
    self.needNum = parse_number(row, "needNum")


    ---跳转的逻辑
    local openType = parse_string(row, "openType", "")
    if not string.isEmpty(openType) then
        local openTypes = string.split(openType, ";")
        local t = {}
        for i, v in pairs(openTypes) do
            if checkInt(v) > 0 then
                table.insert(t, checkInt(v))
            end
        end
        self.jumpAway = t
        ---只有跳转不为空时参数才有存在的意义
        local openParameter = parse_string(row, "openParameter", "")
        if not string.isEmpty(openParameter) then
            local params = string.split(openParameter, ";")
            local t = {}
            for i, v in pairs(params) do
                if checkInt(v) > 0 then
                    table.insert(t, checkInt(v))
                end
            end
            self.jumpParameter = t
        end
    end


    self.status = parse_number(row, "status")
end

function SameCardDustGoodsVO:__delete()
    self.id = nil               -- 道具编号
    self.type = nil               --道具类型:
    self.showType = nil               --显示类型
    self.name = nil               --名字
    self.desc = nil               --用途（加粗文本
    self.description = nil               --文案包装（普通文本
    self.quality = nil               --道具品质,1,白;2,绿;3,蓝;4,紫;5,橙;6,彩色
    self.stack = nil               --背包堆叠:最大堆叠数量
    --self.openType = nil               --跳转目标（填功能切割表里的ID）
    --self.openParameter = nil               --跳转参数（填写关卡ID）
    self.jumpAway = nil
    self.jumpParameter = nil
    
    self.photoId = nil               --图片id（待出资源，先用其他资源显示)
    self.effectType = nil               --效果类型 (读效果类型枚举表
    self.effectId = nil               --对应ID
    self.effectNum = nil               --效果数量
    self.Maxnum = nil               --最大数量
    self.cardId = nil               --对应卡牌ID
    self.needNum = nil               --合成需要数量
    self.status = nil               --状态
end

return SameCardDustGoodsVO
