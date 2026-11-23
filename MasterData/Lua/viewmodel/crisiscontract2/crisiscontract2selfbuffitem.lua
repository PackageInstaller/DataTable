CrisisContract2SelfBuffItem = {};

CrisisContract2SelfBuffItem.__index = CrisisContract2SelfBuffItem;

local objs = {
    Desctxt = { path = "Desc/Text", type = "Text" },
    IconSprite = { path = "NameAndIcon/Icon", type = "Image" },
    Nametxt = { path = "NameAndIcon/Name", type = "Text" },
    NameChoosedGo = { path = "NameAndIcon/Choosed", type = "GameObject" },
    ConnectChoosedGo = { path = "Connect/Choosed", type = "GameObject" },
    NotChooseBtn = { path = "NotChoose", type = "Button" },
    ChooseBtn = { path = "Choosed", type = "Button" },
    ChoosedGo = { path = "Choosed", type = "GameObject" },
}

function CrisisContract2SelfBuffItem.New(obj)
    local self = {};
    setmetatable(self, CrisisContract2SelfBuffItem);
    self.gameObject = obj
    return self;
end

function CrisisContract2SelfBuffItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.onClickAddCommand = function()
        if self.data.onClickAdd ~= nil then
            self.data.onClickAdd(self.data.index);
        end
    end
    self.onClickRemoveCommand = function()
        if self.data.onClickDel ~= nil then
            self.data.onClickDel(self.data.index);
        end
    end
    LuaMgr.AddClick(self.NotChooseBtn, self.onClickAddCommand);
    LuaMgr.AddClick(self.ChooseBtn, self.onClickRemoveCommand);
end

function CrisisContract2SelfBuffItem:SetData(pdata)
    self.data = pdata.data
    local buffInfo = self.data.BuffInfo
    if TableIsNull(buffInfo) or self.data.Level ~= buffInfo.Level then
        buffInfo = CrisisContract4Mgr.GetBuffInfoByLevel(self.data.Id, self.data.Level)
        self.data.BuffInfo = buffInfo
    end
    self.Desctxt.text = buffInfo.Desc
    self.IconSprite.sprite = buffInfo.Icon
    self.Nametxt.text = buffInfo.Name

    SetActive(self.NameChoosedGo, self.data.Level > 0)
    SetActive(self.ConnectChoosedGo, self.data.Level > 0)
    SetActive(self.NotChooseBtn.gameObject, self.data.Level == 0)
    SetActive(self.ChoosedGo, self.data.Level > 0)
    SetActive(self.gameObject, true)
end

function CrisisContract2SelfBuffItem:Hide()
    SetActive(self.gameObject, false)
end

function CrisisContract2SelfBuffItem:Clear()
    self.data = nil
end

function CrisisContract2SelfBuffItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    if (self.onClickAddCommand ~= nil) then
        LuaMgr.RemoveClick(self.NotChooseBtn, self.onClickAddCommand)
        self.onClickAddCommand = nil
    end
    if (self.onClickRemoveCommand ~= nil) then
        LuaMgr.RemoveClick(self.ChooseBtn, self.onClickRemoveCommand)
        self.onClickRemoveCommand = nil
    end
    self.Desctxt = nil
    self.IconSprite = nil
    self.Nametxt = nil
    self.NameChoosedGo = nil
    self.ConnectChoosedGo = nil
    self.NotChooseBtn = nil
    self.ChoosedGo = nil
end 