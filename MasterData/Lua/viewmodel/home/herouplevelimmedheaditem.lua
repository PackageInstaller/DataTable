HeroUpLevelImmedHeadItem = {};

HeroUpLevelImmedHeadItem.__index = HeroUpLevelImmedHeadItem;

local objs = {
    button = { path = "Icon", type = "Button" },
    icon = { path = "Icon", type = "RawImage" },
    job = { path = "Job", type = "Image" },
    level = { path = "Level/Text", type = "Text" },
    rare = { path = "Rare", type = "Image" },
    select = { path = "Select", type = "GameObject" },
};

function HeroUpLevelImmedHeadItem.New()
    local self = {};
    setmetatable(self, HeroUpLevelImmedHeadItem);
    return self;
end

function HeroUpLevelImmedHeadItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.HeroUpLevelImmedSelectHead, self);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end

function HeroUpLevelImmedHeadItem:SetData(data)
    self.data = data.data;
    local character = self.data.character;
    self.icon.texture = GetCharacterTexture(character.id, character.curSkin);
    self.level.text = tostring(character.level);
    local characterConfig = ConfigMgr.Config.characterTable[character.id];
    if (characterConfig ~= nil) then
        self.job.sprite = LuaMgr.GetSprite("JobIcon", "job_" .. characterConfig.job);
        self.rare.sprite = LuaMgr.GetSprite("CommonRes", "ui_home_kbn_tx" .. characterConfig.rare);
    end
    SetActive(self.select, self.data.select);
end

function HeroUpLevelImmedHeadItem:Select(isSelect)
    self.data.select = isSelect;
    SetActive(self.select, isSelect);
end

function HeroUpLevelImmedHeadItem:Clear()
    self.data = nil;
    self.icon.texture = nil;
    self.job.sprite = nil;
    self.rare.sprite = nil;
end

function HeroUpLevelImmedHeadItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end