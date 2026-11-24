SeasonSLGResourceItem = {};

SeasonSLGResourceItem.__index = SeasonSLGResourceItem;

local objs = {
    btnClick = { path = "Group/btnClick", type = "Button" },
    btnAdd = { path = "Group/btnAdd", type = "Button" },
    img = { path = "Group/rawImage", type = "RawImage" },
    num = { path = "Group/textNum", type = "Text" },
}
local efficiency = nil
local efficiencyIcon = nil
function SeasonSLGResourceItem.New(obj)
    local self = {};
    setmetatable(self, SeasonSLGResourceItem);
    if obj ~= nil then
        self.gameObject = obj
    end

    return self;
end

function SeasonSLGResourceItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.onClickAdd = function()
        self:OnClickAdd()
    end

    self.Refresh = function()
        self.itemId = self.data.itemId;
        self.num.text = LuaMgr.NumFormat(DataHelper.GetItemCountById(self.itemId));
        self.img.texture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/ItemIcons/itemicon_home_%s.png", self.itemId))

        efficiency = self.gameObject.transform:Find("Group/efficiency/desc")
        efficiencyIcon = self.gameObject.transform:Find("Group/efficiency/icon")
        if efficiency ~= nil then
            local produce = DataMgr.Player.Seasonal[SeasonSLGMapMgr.curSeasonal.Id].Produce[self.itemId]
            efficiency:GetComponent("Text").text = "+" .. tostring(produce or 0);
        end
        if efficiencyIcon ~= nil then
            efficiencyIcon:GetComponent("RawImage").texture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/ItemIcons/itemicon_home_%s.png", self.itemId));
        end
        local tfEfficiency=self.gameObject.transform:Find("Group/efficiency/Image");
        if tfEfficiency~=nil then
            self.btnEfficiency=self.gameObject.transform:Find("Group/efficiency/Image"):GetComponent("Button");
            self.efficiencyClickExecute=function()
                if self.data.callBack~=nil then
                   local data={
                       count=LuaMgr.NumFormat(DataHelper.GetItemCountById(self.itemId)),
                       itemId=self.data.itemId,
                       addCount=DataMgr.Player.Seasonal[SeasonSLGMapMgr.curSeasonal.Id].Produce[self.itemId],
                       pos=self.transform.anchoredPosition
                   }
                    self.data.callBack(data);
                end
            end
            LuaMgr.RemoveClick(self.btnEfficiency, self.efficiencyClickExecute);
            LuaMgr.AddClick(self.btnEfficiency, self.efficiencyClickExecute);
        end
    end

end

function SeasonSLGResourceItem:SetData(data)
    LuaMgr.RemoveClick(self.btnAdd, self.onClickAdd);
    LuaMgr.AddClick(self.btnAdd, self.onClickAdd);
    LuaMgr.RemoveClick(self.btnClick, self.onClickAdd);
    LuaMgr.AddClick(self.btnClick, self.onClickAdd);
    self.data = data.data;
    self.Refresh()
end

function SeasonSLGResourceItem:OnClickAdd()
    local itemConfig = ConfigMgr.Config.itemMap[self.itemId];
    if itemConfig ~= nil then
        if itemConfig.AddSkipType == "6" then
            LuaMgr.ShowLuaPanel(UIName.SeasonSLGFatigueReplyViewModel);
        elseif itemConfig.AddSkipType == "5" then
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,self.itemId,false,false,false,0,0);
        end
    end
end

function SeasonSLGResourceItem:Clear()
end

function SeasonSLGResourceItem:Destroy()
    if self.onClickAdd ~= nil then
        LuaMgr.RemoveClick(self.btnAdd, self.onClickAdd);
        LuaMgr.RemoveClick(self.btnClick, self.onClickAdd);
        LuaMgr.RemoveClick(self.btnEfficiency, self.efficiencyClickExecute);
        self.onClickAdd = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end