CrisisContract2SimpleSelfBuffItem = {};

CrisisContract2SimpleSelfBuffItem.__index = CrisisContract2SimpleSelfBuffItem;

local objs = {
    LeftGo = { path = "Left", type = "GameObject" },
    LeftIconSprite = { path = "Left/Icon", type = "Image" },
    LeftNametxt = { path = "Left/Name", type = "Text" },
    
    RightGo = { path = "Right", type = "GameObject" },
    RightIconSprite = { path = "Right/Icon", type = "Image" },
    RightNametxt = { path = "Right/Name", type = "Text" },
}

function CrisisContract2SimpleSelfBuffItem.New(obj)
    local self = {};
    setmetatable(self, CrisisContract2SimpleSelfBuffItem);
    self.gameObject = obj
    return self;
end

function CrisisContract2SimpleSelfBuffItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function CrisisContract2SimpleSelfBuffItem:SetData(pdata)
    self.data = pdata.data
    if self.data.leftData ~= nil then
        local buffInfo = self.data.leftData.BuffInfo
        if TableIsNull(buffInfo) or self.data.leftData.Level ~= buffInfo.Level then
            buffInfo = CrisisContract4Mgr.GetBuffInfoByLevel(self.data.leftData.Id, self.data.leftData.Level)
            self.data.leftData.BuffInfo = buffInfo
        end
        self.LeftIconSprite.sprite = self.data.leftData.BuffInfo.Icon
        self.LeftNametxt.text = self.data.leftData.BuffInfo.Name
    end
    if self.data.rightData ~= nil then
        local buffInfo = self.data.rightData.BuffInfo
        if TableIsNull(buffInfo) or self.data.rightData.Level ~= buffInfo.Level then
            buffInfo = CrisisContract4Mgr.GetBuffInfoByLevel(self.data.rightData.Id, self.data.rightData.Level)
            self.data.rightData.BuffInfo = buffInfo
        end
        self.RightIconSprite.sprite = self.data.rightData.BuffInfo.Icon
        self.RightNametxt.text = self.data.rightData.BuffInfo.Name
    end
    
    SetActive(self.LeftGo, self.data.leftData ~= nil)
    SetActive(self.RightGo, self.data.rightData ~= nil)
    SetActive(self.gameObject, true)
end

function CrisisContract2SimpleSelfBuffItem:Hide()
    SetActive(self.gameObject, false)
end

function CrisisContract2SimpleSelfBuffItem:Clear()
    self.data = nil
end

function CrisisContract2SimpleSelfBuffItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.LeftGo = nil
    self.LeftIconSprite = nil
    self.LeftNametxt = nil
    self.RightGo = nil
    self.RightIconSprite = nil
    self.RightNametxt = nil
end 