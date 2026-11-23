UICollectorGuideTagItem = {}

UICollectorGuideTagItem.__index = UICollectorGuideTagItem

function UICollectorGuideTagItem.New()
    local self = {}
    setmetatable(self, UICollectorGuideTagItem)
    return self
end

function UICollectorGuideTagItem:Init()
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.goSelectBG = uiLink:Get("goSelectBG");
    self.goUnselectBG = uiLink:Get("goUnselectBG");
    self.goHaveReward = uiLink:Get("goHaveReward");
    self.textSelectTips = uiLink:Get("textSelectTips"):GetComponent("Text");
    self.textUnSelectTips = uiLink:Get("textUnSelectTips"):GetComponent("Text");
    self.btnSelect = uiLink:Get("btnSelect"):GetComponent("Button");
    uiLink:AddClickEvent("btnSelect", function()
        if self.data.fun ~= nil then
self.data.fun(self);
        end
    end)
end









function UICollectorGuideTagItem:SetData(data)
    self.data = data.data;
    self:SetSelect(self.data.isSelect);
    self:SetHaveReward(self.data.haveReward);
    local tips=string.gsub(LuaMgr.GetLangText(self.data.groupNameLan), "\\n", "\n");
    self.textSelectTips.text=tips
    self.textUnSelectTips.text=tips
end

function UICollectorGuideTagItem:SetSelect(isSelect)
    SetActive(self.goSelectBG,isSelect);
    SetActive(self.goUnselectBG,not isSelect);

end

function UICollectorGuideTagItem:SetHaveReward(haveReward)
    SetActive(self.goHaveReward,haveReward);
    self.data.haveReward=haveReward;
end

function UICollectorGuideTagItem:Clear()
    self.data = nil
end

function UICollectorGuideTagItem:Destroy()
    self.transform = nil
    self.goSelectBG = nil;
    self.goUnselectBG = nil;
    self.goHaveReward = nil;
    self.textSelectTips = nil;
    self.textUnSelectTips = nil;
    self.btnSelect = nil;

    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end