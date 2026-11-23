HeroUpLevelAttributeItem = {};

HeroUpLevelAttributeItem.__index = HeroUpLevelAttributeItem;

local objs = {
    icon = { path = "Icon", type = "Image" },
    nameGO = { path = "Name", type = "GameObject" },
    name = { path = "Name", type = "Text" },
    textTF = { path = "Text", type = "RectTransform" },
    text = { path = "Text", type = "Text" },
    arrowGO = { path = "Arrow", type = "GameObject" },
    text2GO = { path = "Text2", type = "GameObject" },
    text2 = { path = "Text2", type = "Text" },
}

function HeroUpLevelAttributeItem.New()
    local self = {};
    setmetatable(self, HeroUpLevelAttributeItem);
    return self;
end

function HeroUpLevelAttributeItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function HeroUpLevelAttributeItem:SetData(data)
    data = data.data;
    self.icon.sprite = data.attIcon;
    SetActive(self.nameGO, data.isName);
    self.name.text = data.attName;
    self.textTF.anchoredPosition = data.valuePosition;
    self.text.text = data.value1;
    SetActive(self.arrowGO, data.isArrow);
    self.text2.text = data.value2;
    SetActive(self.text2GO, data.isArrow);
end

function HeroUpLevelAttributeItem:Clear()
    self.data = nil;
    self.icon.sprite = nil;
end

function HeroUpLevelAttributeItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end