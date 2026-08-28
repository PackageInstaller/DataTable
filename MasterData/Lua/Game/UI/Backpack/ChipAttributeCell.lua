---@type Engine.Lib.KTool
local KTool               = CS.Engine.Lib.KTool

---@class ChipAttributeCell
---@field Unlock                        	UnityEngine.UI.Text                     @图芯卡未解锁文字
---@field Value                         	UnityEngine.UI.Text                     @图芯卡属性值
---@field Name                          	UnityEngine.UI.Text                     @图芯卡属性名
local ChipAttributeCell = Class('ChipAttributeCell')

function ChipAttributeCell:__init(controller)
    self.controller = controller
end

function ChipAttributeCell:__delete()
    self.controller = nil
end

function ChipAttributeCell:Awake()
end

---刷新
---@param chipAttribute table
function ChipAttributeCell:FreshCell(chipAttribute)
    KTool.SetActive(self.Name, chipAttribute.isUnlock)
    KTool.SetActive(self.Value, chipAttribute.isUnlock)
    if chipAttribute.isUnlock then
        KTool.SetActive(self.Unlock, false)
        self.Value.text = chipAttribute.num

        local cardConfMgr = CardConfMgr:GetInstance()
        local equipAttrVo = cardConfMgr:GetEquipAttrVoById(tonumber(chipAttribute.type))
        if equipAttrVo then
            local additionVo = cardConfMgr:GetBasicAttrAdditionById(equipAttrVo.attrAdditionId)
            self.Name.text = additionVo.attrAdditionName
        else
            self.Name.text = chipAttribute.type
        end
    else
        KTool.SetActive(self.Unlock, true)
        self.Unlock.text = localize("_num_级获得随机一条属性", {_num_ = chipAttribute.unlockLevel})
    end
end

return ChipAttributeCell