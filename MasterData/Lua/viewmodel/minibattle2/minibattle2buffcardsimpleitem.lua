MiniBattle2BuffCardSimpleItem = {};

MiniBattle2BuffCardSimpleItem.__index = MiniBattle2BuffCardSimpleItem;

local objs = {
    ClickBtn = { path = "", type = "UIButtonClick" },
    CardTexture = { path = "Icon", type = "RawImage" },
    KuangObj_1 = { path = "Kuang_1", type = "GameObject" },
    KuangObj_2 = { path = "Kuang_2", type = "GameObject" },
    Nametxt = { path = "Name", type = "Text" },
}

function MiniBattle2BuffCardSimpleItem.New(obj)
    local self = {};
    setmetatable(self, MiniBattle2BuffCardSimpleItem);
    self.gameObject = obj
    return self;
end

function MiniBattle2BuffCardSimpleItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.onClickCommand = function()
        if self.data.onClick ~= nil then
            self.data.onClick(self.data.id);
        end
    end
    LuaMgr.AddClick(self.ClickBtn, self.onClickCommand);
end

function MiniBattle2BuffCardSimpleItem:SetData(pdata)
    self.data = pdata.data
    self.CardTexture.texture = self.data.icon
    self.Nametxt.text = self.data.name
    SetActive(self.KuangObj_1, self.data.quality == 0)
    SetActive(self.KuangObj_2, self.data.quality == 1)
    SetActive(self.gameObject, true)
end

function MiniBattle2BuffCardSimpleItem:Hide()
    SetActive(self.gameObject, false)
end

function MiniBattle2BuffCardSimpleItem:Clear()
    self.data = nil
end

function MiniBattle2BuffCardSimpleItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    if (self.onClickCommand ~= nil) then
        LuaMgr.RemoveClick(self.ClickBtn, self.onClickCommand)
        self.onClickCommand = nil
    end
    self.gameObject = nil
end 