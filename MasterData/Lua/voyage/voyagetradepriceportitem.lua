VoyageTradePricePortItem = {};

VoyageTradePricePortItem.__index = VoyageTradePricePortItem;

local objs = {
    name = { path = "Name", type = "Text" },
    riseUp = { path = "RiseUp", type = "GameObject" },
    riseDown = { path = "RiseDown", type = "GameObject" },
    gotoBtn = { path = "Goto", type = "Button" },
};

function VoyageTradePricePortItem.New()
    local self = {};
    setmetatable(self, VoyageTradePricePortItem);
    return self;
end

function VoyageTradePricePortItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickGoto = function()
        if (PlayerVoyageMgr.IsPortLock(self.data.HarborId)) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10561"));
            return;
        end
        local harbor = ConfigMgr.Config.SailingHarborMap[self.data.HarborId];
        if (harbor ~= nil) then
            LuaMgr.InvokeUIEventListeners(UIEventConst.VoyagePortInfo, harbor);
            LuaMgr.HidePanel(UIName.VoyageTradePriceViewModel);
        end
    end
    LuaMgr.AddClick(self.gotoBtn, self.OnClickGoto);
end

function VoyageTradePricePortItem:SetData(data)
    self.data = data.data;
    local harbor = ConfigMgr.Config.SailingHarborMap[self.data.HarborId];
    if (harbor ~= nil) then
        self.name.text = LuaMgr.GetLangText(harbor.HarborNameLan);
    end
    local flag = string.sub(self.data.PriceRate, 1, 1);
    if (flag == "0") then
        SetActive(self.riseUp, false);
        SetActive(self.riseDown, false);
    else
        if (flag ~= "-") then
            SetActive(self.riseUp, true);
            SetActive(self.riseDown, false);
        else
            SetActive(self.riseUp, false);
            SetActive(self.riseDown, true);
        end
    end
end

function VoyageTradePricePortItem:Clear()
    self.data = nil;
end

function VoyageTradePricePortItem:Destroy()
    if (self.OnClickGoto ~= nil) then
        LuaMgr.RemoveClick(self.gotoBtn, self.OnClickGoto);
        self.OnClickGoto = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end