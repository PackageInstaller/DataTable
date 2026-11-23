




require("ViewModel/HeroSpeciality/SingleAttrItemModel")
SingleGroupItemModel = {}
SingleGroupItemModel.__index = SingleGroupItemModel
SingleGroupItemModel.tableInsert = table.insert
local objs = {

    a_level = {path = "A_Level",type = "GameObject"},
    a_levelText = {path = "A_Level/Text",type = "Text"},
    n_level = {path = "N_Level",type = "GameObject"},
    n_levelText = {path = "N_Level/Text",type = "Text"},
    attrView = {path = "AttrView",type = "RectTransform"},
    a_select = {path = "A_Select",type = "GameObject"},
    n_select = {path = "N_Select",type = "GameObject"},

    skill = {path = "Skill",type = "GameObject"},
    a_skill = {path = "Skill/A_Skill",type = "GameObject"},
    a_skillText = {path = "Skill/A_Skill/Text",type = "Text"},
    a_skillTran = {path = "Skill/A_Skill",type = "RectTransform"},
    n_skill = {path = "Skill/N_Skill",type = "GameObject"},
    n_skillText = {path = "Skill/N_Skill/Text",type = "Text"},
    n_skillTran = {path = "Skill/N_Skill",type = "RectTransform"},

    a_Skill_Level = {path = "A_Level/A_Skill_Level",type = "GameObject"},
    a_Skill_LevelText = {path = "A_Level/A_Skill_Level/Text",type = "Text"},
    n_Skill_Level = {path = "N_Level/N_Skill_Level",type = "GameObject"},
    n_Skill_LevelText = {path = "N_Level/N_Skill_Level/Text",type = "Text"},
}

SingleGroupItemModel.New = function(container)
    local self = {}
    setmetatable(self, SingleGroupItemModel)
    self.prefabPath = "Assets/_BundleResources/UI/HeroSpeciality/SingleGroupItem.prefab"
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

function SingleGroupItemModel:SetPosition(position)
    self.object.transform.localPosition = position
end

function SingleGroupItemModel:SetWidthHeight()

    if not self.type then
        self.height = (24 * #self.talents) + (#self.talents * 5) - 5
    else
        self.height = self.a_skillText.preferredHeight + 30
        self.a_skillTran.sizeDelta = Vector2(self.a_skillTran.sizeDelta.x,self.height)
        self.n_skillTran.sizeDelta = Vector2(self.n_skillTran.sizeDelta.x,self.height)
    end
    self.object.transform.sizeDelta = Vector2(self.object.transform.sizeDelta.x,self.height)
end

function SingleGroupItemModel:SetData(index,level,talents)
    self.index = index
    self.talents = talents
    self.level = level
    self.isActive = index <= level
    
    self.a_levelText.text = index
    SetActive(self.a_level,self.isActive)
    self.n_levelText.text = index
    SetActive(self.n_level,not self.isActive)
    
    self.a_Skill_LevelText.text = index
    SetActive(self.a_Skill_Level,index == 7)
    self.n_Skill_LevelText.text = index
    SetActive(self.n_Skill_Level,index == 7)

    SetActive(self.a_select,false)
    SetActive(self.n_select,false)
    SetActive(self.a_skill,self.isActive)
    SetActive(self.n_skill,not self.isActive)
    

    local talentBank = ConfigMgr.Config.talentBankMap[talents[1]]
    if talentBank.type == 2 then
        self.type = false
    else
        self.type = true
    end
    SetActive(self.skill,self.type)
    
    self:SetAttr()
    self:SetWidthHeight()
    self.object.gameObject:SetActive(true)
end


function SingleGroupItemModel:SetAttr()
    if not self.type then
        if self.talents == nil or #self.talents <= 0 then return end
        if self.allAttrData == nil then
            self.allAttrData = {}
        end
        local attrName,attrValue,attrType = nil,nil,nil
        local attrItem = nil
        for i = 1, #self.talents do
            if self.allAttrData[i] == nil then
                attrItem = SingleAttrItemModel.New(self.attrView)
                self.tableInsert(self.allAttrData,attrItem)
            end
            attrName,attrValue,attrType = ConfigHelper.GetAttrNameStr(self.talents[i])
            self.allAttrData[i]:SetData(i,attrName,attrValue,attrType,self.isActive)
        end
        for i = #self.talents + 1, #self.allAttrData do
            self.allAttrData[i]:Hide()
        end
    else
        if self.talents == nil then return end
        local attrName,attrValue,attrType,iconName = ConfigHelper.GetAttrNameStr(self.talents[1])
        local skill = ConfigSkillMgr.GetCharacterPassiveSkill(iconName..attrValue)
        if skill == nil then return end
        self.a_skillText.text = LuaMgr.GetLangText(skill.DescriptionLan)
        self.n_skillText.text = LuaMgr.GetLangText(skill.DescriptionLan)
    end
end

function SingleGroupItemModel:Hide()
    self.object.gameObject:SetActive(false)
end

function SingleGroupItemModel:Clear()
    if self.allAttrData ~= nil then
        for i = 1, #self.allAttrData do
            self.allAttrData[i]:Clear()
        end
        self.allAttrData = nil
    end
    self.index = nil
    self.level = nil
    self.talents = nil
    self.rectTransform = nil
    LuaMgr.RemovePrefabRefCount(self.prefabPath)
    LuaMgr.DestroyImmediateGO(self.object)
    self.object = nil
    self.prefabPath = nil
end