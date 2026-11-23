TrainingDummyDamageItem = {};

TrainingDummyDamageItem.__index = TrainingDummyDamageItem;

local objs = {
    RectTr = { path = "", type = "RectTransform" },
    DamageText = { path = "Group/Damage", type = "Text" },
    HeadItemTemplate = { path = "Group/CharacterList/CharacterItem", type = "GameObject" },
    HeadItemContentTr = { path = "Group/CharacterList", type = "RectTransform" },
    animatorObj={path="Group",type="GameObject"},
}

function TrainingDummyDamageItem.New()
    local self = {};
    setmetatable(self, TrainingDummyDamageItem);
    return self;
end

function TrainingDummyDamageItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.headItems = {}
    SetActive(self.HeadItemTemplate, false)
end

function TrainingDummyDamageItem:SetData(pdata)
    self.data = pdata.data;

    if self.data.animBool then

        SetActive(self.animatorObj,true)
    end
    
    self.DamageText.text = self.data.damageStr
    local index = 1
    for _, v in ipairs(self.data.characterDatas) do
        if index > #self.headItems then
            local obj = LuaMgr.InstantiateGO(self.HeadItemTemplate, self.HeadItemContentTr, false).transform
            local item = TrainingDummyDamageHeadItem.New()
            item.gameObject = obj.gameObject
            item.transform = obj
            item:Init()
            table.insert(self.headItems, item)
        end
        local techItem = self.headItems[index]
        techItem:SetData(v)
        index = index + 1
    end
    local len = #self.headItems;
    for i = index, len do
        self.headItems[i]:Hide();
    end
end

function TrainingDummyDamageItem:Clear()
    for i, v in ipairs(self.headItems) do
        v:Clear()
    end
    self.data = nil;
    SetActive(self.animatorObj,false)
end

function TrainingDummyDamageItem:Destroy()
    for i, v in ipairs(self.headItems) do
        v:Destroy()
    end
    self.headItems = {}
    
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end