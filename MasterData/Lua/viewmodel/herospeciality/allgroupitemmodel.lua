




require("ViewModel/HeroSpeciality/AllAttrItemModel")
AllGroupItemModel = {}
AllGroupItemModel.__index = AllGroupItemModel
AllGroupItemModel.tableInsert = table.insert
AllGroupItemModel.toNumber = tonumber
local objs = {
    coreBool = {path = "NameCore/Core",type = "GameObject"},
    coreIcon = {path = "NameCore/Core/CoreIcon",type = "Image"},
    nameText = {path = "NameCore/Text",type = "Text"},
    attrView = {path = "AttrView",type = "RectTransform"},
    skillText = {path = "SkillText",type = "Text"},
    tipText = {path = "TipText",type = "Text"},
}

AllGroupItemModel.New = function(container)
    local self = {}
    setmetatable(self, AllGroupItemModel)
    self.prefabPath = "Assets/_BundleResources/UI/HeroSpeciality/AllGroupItem.prefab"
    self.object = LuaMgr.GetPrefab(self.prefabPath)
    LuaMgr.AddPrefabRefCount(self.prefabPath)
    self.object.transform:SetParent(container, false)
    
    self.object.transform.pivot = Vector2(0.5,1)
    self.object.transform.anchorMax = Vector2(0.5,1)
    self.object.transform.anchorMin = Vector2(0.5,1)
    
    self.rectTransform = self.object.transform:GetComponent("RectTransform")
    UITool.Parse(self.object,self,objs)
    return self
end

function AllGroupItemModel:SetPosition(position)
    self.object.transform.localPosition = position
end

function AllGroupItemModel:SetWidthHeight()

    if not self.type then
        if self.index == 2 and (self.talents == nil or #self.talents <= 0) then
            self.height = 70 + (30 * #self.tempList)
        else
            self.height = 56 + (30 * #self.tempList)
        end
    else
        self.height = 56 + self.skillText.preferredHeight + 30
    end
    self.object.transform.sizeDelta = Vector2(self.object.transform.sizeDelta.x,self.height)
end

function AllGroupItemModel:SetData(index,titleStr,type,talents)
    self.index = index
    self.talents = talents
    self.type = type
    self.nameText.text = titleStr
    self.skillText.text = ""
    SetActive(self.coreBool,type and talents ~= nil)
    if TableIsNull(self.talents) then
        self.tipText.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2909"].NameLan)
    else
        self.tipText.text = ""
    end
    self:SetAttr()
    self:SetWidthHeight()
    self.object.gameObject:SetActive(true)
end


function AllGroupItemModel:SetAttr()
    local attrName,attrValue,attrType,iconName = nil,nil,nil,nil
    self.tempList = {}
    if not self.type then
        if self.talents == nil or #self.talents <= 0 then
            if self.allAttrData ~= nil then
                for i = 1, #self.allAttrData do
                    self.allAttrData[i]:Hide()
                end
            end
            return
        end
        local temp = nil
        local length = #self.talents

        for i = 1, length do
            attrName,attrValue,attrType,iconName = ConfigHelper.GetAttrNameStr(self.talents[i])
            temp = {attrName = attrName,attrValue = self.toNumber(attrValue),attrType = attrType,iconName = iconName}
            self:AddAttrList(temp)
        end
        if self.allAttrData == nil then
            self.allAttrData = {}
        end
        local attrItem = nil
        length = #self.tempList
        for i = 1, length do
            if self.allAttrData[i] == nil then
                attrItem = AllAttrItemModel.New(self.attrView)
                self.tableInsert(self.allAttrData,attrItem)
            end
            self.allAttrData[i]:SetData(i,self.tempList[i])
        end
        for i = length + 1, #self.allAttrData do
            self.allAttrData[i]:Hide()
        end
    else
        if self.talents == nil then return end
        attrName,attrValue,attrType,iconName = ConfigHelper.GetAttrNameStr(self.talents.skillId)
        local skill = ConfigSkillMgr.GetCharacterPassiveSkill(iconName..attrValue)
        if skill == nil then return end
        self.coreIcon.sprite = LuaMgr.GetSprite("CoreIcon",self.talents.skillIcon)
        self.skillText.text = LuaMgr.GetLangText(skill.DescriptionLan)
    end
end
function AllGroupItemModel:AddAttrList(temp)
    for i = 1, #self.tempList do
        if self.tempList[i].iconName == temp.iconName then
            self.tempList[i].attrValue = self.tempList[i].attrValue + temp.attrValue
            return
        end
    end
    self.tableInsert(self.tempList,temp)
end

function AllGroupItemModel:Hide()
    self.object.gameObject:SetActive(false)
end

function AllGroupItemModel:Clear()
    if self.allAttrData ~= nil then
        for i = 1, #self.allAttrData do
            self.allAttrData[i]:Clear()
        end
        self.allAttrData = nil
    end
    self.index = nil
    self.type = nil
    self.talents = nil
    self.tempList = nil
    self.rectTransform = nil
    LuaMgr.RemovePrefabRefCount(self.prefabPath)
    LuaMgr.DestroyImmediateGO(self.object)
    self.object = nil
    self.prefabPath = nil
end