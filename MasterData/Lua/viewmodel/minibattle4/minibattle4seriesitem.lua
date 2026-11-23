MiniBattle4SeriesItem = {};

MiniBattle4SeriesItem.__index = MiniBattle4SeriesItem;

local objs = {
    RedIconListener = { path = "", type = "RedIconListener" },
    ClickBtn = { path = "Group/Bg", type = "UIButtonClick" },
    Name = { path = "Group/Name", type = "Text" },
    LockGo = { path = "Group/Lock", type = "GameObject" },
    LockTips = { path = "Group/Lock/Tips", type = "Text" },
    SelectedGo = { path = "Group/Selected", type = "GameObject" },
}

function MiniBattle4SeriesItem.New()
    local self = {};
    setmetatable(self, MiniBattle4SeriesItem);
    return self;
end

function MiniBattle4SeriesItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if self.data.isSelected then
            return
        end
        if self.data.isLock then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, self.data.lockTipsStr)
            return
        end
        if self.data.onClick ~= nil then
            self.data.onClick(self.data.seriesId)
        end
    end
    LuaMgr.AddClick(self.ClickBtn, self.OnClickItem);
end

function MiniBattle4SeriesItem:SetData(pdata)
    self.data = pdata.data
    self.Name.text = self.data.nameStr
    self.RedIconListener.RedId = self.data.redId
    self:Refresh()
end

function MiniBattle4SeriesItem:Refresh()
    local curTime = LuaMgr.Timestamp()
    self.data.isLock = curTime < self.data.unlockTime
    if self.data.isLock then
        local leftTime = self.data.unlockTime - LuaMgr.Timestamp()
        local d, h, m = GetTimeDHM(leftTime)
        if leftTime < 3600 then
            h = "01"
        end
        if IsNullOrEmpty(d) then
            self.data.lockTipsStr = string.format(LuaMgr.GetLangText("MiniBattle4SeriesItem_0"), h)
        else
            self.data.lockTipsStr = string.format(LuaMgr.GetLangText("MiniBattle4SeriesItem_1"), d, h)
        end
        self.LockTips.text = self.data.lockTipsStr
    end
    SetActive(self.LockGo, self.data.isLock)
    SetActive(self.SelectedGo, self.data.isSelected)
end

function MiniBattle4SeriesItem:Clear()
    self.data = nil;
end

function MiniBattle4SeriesItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.ClickBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end