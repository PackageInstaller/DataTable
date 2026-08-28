local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

-- 深度互动 道具表   61皮肤和谐影子道具表


---@class Live3dGoodsHeXieVo
local Live3dGoodsHeXieVo = Class("Live3dGoodsHeXieVo", SettingRefBase)

function Live3dGoodsHeXieVo:__init()
    self.id = nil           --道具编号
    self.type = nil         --道具类型:
    self.showType = nil     --显示类型
    self.name = nil         --名字
    self.desc = nil         --用途（加粗文本
    self.description = nil  --文案包装（普通文本
    self.quality = nil      --道具品质,1,白;2,绿;3,蓝;4,紫;5,橙;6,彩色
    self.stack = nil        --背包堆叠:最大堆叠数量
    self.openType = nil     --跳转目标（填功能切割表里的ID）
    self.openParameter = nil--跳转参数（填写关卡ID）
    self.photoId = nil      --物品图标
    self.photoPath = nil      --物品图标
    self.storeIcon = nil       --商城大图
    self.effectType = nil   --效果类型 (读效果类型枚举表
    self.effectId = nil     --对应ID
    self.effectNum = nil    --效果数量
    self.Maxnum = nil       --最大数量
    -- self.cardId = nil       --对应卡牌ID
    -- self.needNum = nil      --合成需要数量
    self.skinId = nil       --对应皮肤id
    self.status = nil       --状态
end

---FillVo
---@param row TableML.TableFileRow
function Live3dGoodsHeXieVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.type = parse_number(row, "type")
    self.showType = parse_number(row, "showType")
    self.name = parse_localizeText(row, "name")
    self.desc = parse_localizeText(row, "desc")
    self.description = parse_localizeText(row, "description")
    self.quality = parse_number(row, "quality", 0)
    self.stack = parse_number(row, "stack")
    self.openType = parse_string(row, "openType", "")
    self.openParameter = parse_string(row, "openParameter")
    self.photoId = ParseUtils.ParsePathName(row, "photoId")
    self.photoPath = self.photoId
    self.storeIcon = ParseUtils.ParsePathName(row, "storeIcon")
    self.effectType = parse_number(row, "effectType")
    self.effectId = parse_string(row, "effectId")
    self.effectNum = parse_string(row, "effectNum")
    self.Maxnum = parse_number(row, "Maxnum")
    -- self.cardId = parse_number(row, "cardId")
    -- self.needNum = parse_number(row, "needNum")
    self.skinId = parse_number(row, "skinId")          
    self.status = parse_number(row, "status")
end

function Live3dGoodsHeXieVo:__delete()
    self.id = nil           --道具编号
    self.type = nil         --道具类型:
    self.showType = nil     --显示类型
    self.name = nil         --名字
    self.desc = nil         --用途（加粗文本
    self.description = nil  --文案包装（普通文本
    self.quality = nil      --道具品质,1,白;2,绿;3,蓝;4,紫;5,橙;6,彩色
    self.stack = nil        --背包堆叠:最大堆叠数量
    self.openType = nil     --跳转目标（填功能切割表里的ID）
    self.openParameter = nil--跳转参数（填写关卡ID）
    self.photoId = nil      --物品图标
    self.photoPath = nil
    self.storeIcon = nil       --商城大图
    self.effectType = nil   --效果类型 (读效果类型枚举表
    self.effectId = nil     --对应ID
    self.effectNum = nil    --效果数量
    self.Maxnum = nil       --最大数量
    -- self.cardId = nil       --对应卡牌ID
    -- self.needNum = nil      --合成需要数量
    self.skinId = nil       --对应皮肤id
    self.status = nil       --状态
end

return Live3dGoodsHeXieVo
