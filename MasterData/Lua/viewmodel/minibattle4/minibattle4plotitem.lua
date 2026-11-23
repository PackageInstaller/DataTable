MiniBattle4PlotItem = {};

MiniBattle4PlotItem.__index = MiniBattle4PlotItem;

local objs = {
    RedIconListener = { path = "", type = "RedIconListener" },
    ClickBtn = { path = "Group/Bg", type = "UIButtonClick" },
    ScoreTips = { path = "Group/Tips", type = "Text" },
    SelectedGo = { path = "Group/Selected", type = "GameObject" },
}

function MiniBattle4PlotItem.New(obj)
    local self = {};
    setmetatable(self, MiniBattle4PlotItem);
    self.gameObject = obj
    return self;
end

function MiniBattle4PlotItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if self.data.isSelected then
            return
        end
        if self.data.onClick ~= nil then
            self.data.onClick(self.data.plotId)
        end
    end
    LuaMgr.AddClick(self.ClickBtn, self.OnClickItem);
end

function MiniBattle4PlotItem:SetData(pdata)
    self.data = pdata;
    self.ScoreTips.text = LuaMgr.GetLangText("MiniBattle4PlotItem_0") .. MiniBattle4Mgr.GetPlotBestScore(self.data.plotId);
    self.RedIconListener.RedId = self.data.redId
    self:Refresh()
end

function MiniBattle4PlotItem:Refresh()
    SetActive(self.SelectedGo, self.data.isSelected)
end

function MiniBattle4PlotItem:Clear()
    self.data = nil;
end

function MiniBattle4PlotItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.ClickBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end