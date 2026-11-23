SpringCampTechItem = {};

SpringCampTechItem.__index = SpringCampTechItem;

local objs = {
    RectTr = { path = "", type = "RectTransform" },
    Icon = { path = "Group/Bg/Icon", type = "Image" },
    ClickBtn = { path = "Group/Bg", type = "UIButtonClick" },
    SelectGo = { path = "Group/Bg/Select", type = "GameObject" },
    ActivatedGo = { path = "Group/Bg/Activated", type = "GameObject" },
    UnlockEffectGo = { path = "Group/Bg/Select/vfx_glow", type = "GameObject" },
    UpLineGo = { path = "Group/UpLine", type = "GameObject" },
    UpActivatedLineGo = { path = "Group/UpLine/ActivatedLine", type = "GameObject" },
    RightLineGo = { path = "Group/RightLine", type = "GameObject" },
    RightActivatedLineGo = { path = "Group/RightLine/ActivatedLine", type = "GameObject" },
}

function SpringCampTechItem.New()
    local self = {};
    setmetatable(self, SpringCampTechItem);
    return self;
end

function SpringCampTechItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if self.onClickItem ~= nil then
            self.onClickItem(self.data.TechId)
        end
    end
    LuaMgr.AddClick(self.ClickBtn, self.OnClickItem);
end

function SpringCampTechItem:SetData(cfg, callback)
    self.data = cfg;
    self.onClickItem = callback
    local index = tonumber(self.data.TechId) - 1
    local posX = 22 + math.floor(index / 3) * 126
    local posY = 20 + (index % 3) * (160)
    self.RectTr.anchoredPosition = Vector2(posX, posY)
    self.Icon.sprite = LuaMgr.GetSprite("BuffIcon", self.data.Icon)
    local curIsUnlock = TrainingCampMgr.CheckTechIsUnlock(self.data.TechId)
    SetActive(self.SelectGo, false)
    SetActive(self.ActivatedGo, curIsUnlock)
    SetActive(self.UnlockEffectGo, false)
    SetActive(self.UpLineGo, (index + 1) % 3 ~= 0)
    SetActive(self.UpActivatedLineGo, curIsUnlock)
    SetActive(self.RightLineGo, index % 3 == 0 and index ~= 15)

    SetActive(self.RightActivatedLineGo, true)
end

function SpringCampTechItem:CheckIsSelect(curSelectId)
    if self.data ~= nil then
        SetActive(self.SelectGo, self.data.TechId == curSelectId)
    end
end

function SpringCampTechItem:ShowUnlockEffect()
    SetActive(self.UnlockEffectGo, true)
end

function SpringCampTechItem:Clear()
    self.data = nil;
end

function SpringCampTechItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.ClickBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end