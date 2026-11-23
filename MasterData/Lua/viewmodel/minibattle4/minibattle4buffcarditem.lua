MiniBattle4BuffCardItem = {};

MiniBattle4BuffCardItem.__index = MiniBattle4BuffCardItem;

local objs = {
    ClickBtn = { path = "Group", type = "UIButtonClick" },
    CardTexture = { path = "Group/Icon", type = "RawImage" },
    KuangObj_1 = { path = "Group/Kuang_1", type = "GameObject" },
    KuangObj_2 = { path = "Group/Kuang_2", type = "GameObject" },
    Nametxt = { path = "Group/Name", type = "Text" },
    Desctxt = { path = "Group/ScrollView/Viewport/Text", type = "Text" },
    DetailBtn = { path = "Group/DetailBtn", type = "UIButtonClick" },
    DetailObj_1 = { path = "Group/DetailBtn/DetailBtn_1", type = "GameObject" },
    DetailObj_2 = { path = "Group/DetailBtn/DetailBtn_2", type = "GameObject" },
    SelectGo = { path = "Group/Select", type = "GameObject" },
}

function MiniBattle4BuffCardItem.New(obj, parent)
    local self = {};
    setmetatable(self, MiniBattle4BuffCardItem);
    self.gameObject = LuaMgr.InstantiateGO(obj, parent, false)
    self.transform = self.gameObject.transform;
    return self;
end

function MiniBattle4BuffCardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.onClickCommand = function()
        if self.data.onClick ~= nil then
            self.data.onClick(self.data.id);
        end
    end
    LuaMgr.AddClick(self.ClickBtn, self.onClickCommand);
    self.onClickDetailsCommand = function()
        if self.data.onClickDetails ~= nil then
            self.data.onClickDetails(self.data.id);
        end
    end
    LuaMgr.AddClick(self.DetailBtn, self.onClickDetailsCommand);
end

function MiniBattle4BuffCardItem:SetData(pdata)
    self.data = pdata
    self.CardTexture.texture = self.data.icon
    self.Nametxt.text = self.data.name
    self.Desctxt.text = self.data.desc
    SetActive(self.KuangObj_1, self.data.quality == 0)
    SetActive(self.KuangObj_2, self.data.quality == 1)
    SetActive(self.DetailObj_1, self.data.quality == 0)
    SetActive(self.DetailObj_2, self.data.quality == 1)
    SetActive(self.SelectGo, self.data.isSelect)
    SetActive(self.gameObject, true)
end

function MiniBattle4BuffCardItem:Hide()
    SetActive(self.gameObject, false)
end

function MiniBattle4BuffCardItem:Clear()
    self.data = nil
end

function MiniBattle4BuffCardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    if (self.onClickCommand ~= nil) then
        LuaMgr.RemoveClick(self.ClickBtn, self.onClickCommand)
        self.onClickCommand = nil
    end
    if (self.onClickDetailsCommand ~= nil) then
        LuaMgr.RemoveClick(self.DetailBtn, self.onClickDetailsCommand)
        self.onClickDetailsCommand = nil
    end
    self.gameObject = nil
end 