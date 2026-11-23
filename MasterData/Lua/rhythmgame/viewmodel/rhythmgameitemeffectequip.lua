RhythmGameItemEffectEquip = {};

RhythmGameItemEffectEquip.__index = RhythmGameItemEffectEquip;

local objs = {
    button = { path = "", type = "Button" },
    icon = { path = "Icon", type = "RawImage" },
    name = { path = "Name", type = "Text" },
    info = { path = "Info", type = "Text" },
    noEquipTip = { path = "NoEquipTip", type = "GameObject" },
    BG1 = { path = "BG1", type = "GameObject" },
    BG2 = { path = "BG2", type = "GameObject" },
}

function RhythmGameItemEffectEquip.New(gameObject)
    local self = {};
    setmetatable(self, RhythmGameItemEffectEquip);
    self.gameObject = gameObject
    return self;
end

function RhythmGameItemEffectEquip:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGameItemEffectEquip, self.data);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end

function RhythmGameItemEffectEquip:SetData(data)
    self.data = data;

    SetActive(self.noEquipTip, self.data.id == - 1)
    SetActive(self.BG1, self.data.id ~= - 1)
    SetActive(self.BG2, self.data.id == - 1)
    if self.data.id == - 1 then
        self.name.text = ""
        self.info.text = ""
        SetActive(self.icon.gameObject, false)
    else        
        SetActive(self.icon.gameObject, true)
self.name.text = LuaMgr.GetLangText(self.data.nameLan)
self.info.text = LuaMgr.GetLangText(self.data.textLan)
        self.icon.texture = GetRhythmEquipTexture(self.data.icon);
    end
end

function RhythmGameItemEffectEquip:Clear()
    self.data = nil;
    self.icon.texture = nil;
end

function RhythmGameItemEffectEquip:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end


end