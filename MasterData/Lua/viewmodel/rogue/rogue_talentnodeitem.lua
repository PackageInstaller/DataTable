Rogue_TalentNodeItem = {};

Rogue_TalentNodeItem.__index = Rogue_TalentNodeItem;

local lockColor = UnityEngine.Color(95 / 255, 95 / 255, 99 / 255, 1);
local objs = {
    clickBtn = { path = "", type = "UIButtonClick" },
Bg1Go = { path = "Group/Bg_1", type = "GameObject" },
Bg2Go = { path = "Group/Bg_2", type = "GameObject" },
Bg3Go = { path = "Group/Bg_3", type = "GameObject" },
    SelectGo = { path = "Group/Select", type = "GameObject" },
    LockGo = { path = "Group/Lock", type = "GameObject" },
    UnlockEffectGo = { path = "Group/UnlockEffect", type = "GameObject" },
    iconSprite = { path = "Group/Icon", type = "Image" },
    lockEffectGo = { path = "Group/lockEffect", type = "GameObject" },
};

function Rogue_TalentNodeItem.New()
    local self = {};
    setmetatable(self, Rogue_TalentNodeItem);
    return self;
end

function Rogue_TalentNodeItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if (self.data.id ~= nil and self.data.callback ~= nil) then
            self.data.callback(self.data.id)
        end
    end
    LuaMgr.AddClick(self.clickBtn, self.OnClickItem);
end

function Rogue_TalentNodeItem:SetData(data)
    self.data = data;
    self.iconSprite.sprite = self.data.icon
    self:SetStatus(self.data.status)
    SetActive(self.SelectGo, self.data.select)
end


function Rogue_TalentNodeItem:SetStatus(status)
    SetActive(self.Bg1Go, status == 0)
    SetActive(self.Bg2Go, status == 2 or status == 3)
    SetActive(self.Bg3Go, status == 1)
    SetActive(self.LockGo, status == 0)
    SetActive(self.UnlockEffectGo, status == 2)
    SetActive(self.lockEffectGo, false)
    self.iconSprite.color = status == 0 and lockColor or UnityEngine.Color.white
end

function Rogue_TalentNodeItem:CheckSelect(selectId)
    if self.data == nil then
        return
    end
    SetActive(self.SelectGo, selectId == self.data.id)
end

function Rogue_TalentNodeItem:ShowUnlockEffect()
    SetActive(self.lockEffectGo, false)
    SetActive(self.lockEffectGo, true)
end

function Rogue_TalentNodeItem:Clear()
    self.data = nil;
end

function Rogue_TalentNodeItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.clickBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end