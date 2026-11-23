




ConnectFourRankAwardItem = {}
ConnectFourRankAwardItem.__index = ConnectFourRankAwardItem

function ConnectFourRankAwardItem.New(prefab, parent)
    local self = {}
    setmetatable(self, ConnectFourRankAwardItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    
    local uiLink = self.gameObject:GetComponent("UILink");

    self.goLevelBgsType1 = uiLink:Get("goLevelBgsType1");
    self.goLevelBgsType2 = uiLink:Get("goLevelBgsType2");
    self.goLevelBgsType3 = uiLink:Get("goLevelBgsType3");
    self. goContent = uiLink:Get("goContent");
    self. textLeft1 = uiLink:Get("textLeft1"):GetComponent("Text");
    self. textRight2 = uiLink:Get("textRight2"):GetComponent("Text");
    self. textRight3 = uiLink:Get("textRight3"):GetComponent("Text");
    self. textLeft4 = uiLink:Get("textLeft4"):GetComponent("Text");
    self. uiGoodsItem=uiLink:Get("uiGoodsItem"):GetComponent("GoodsViewModel");
    self. listItem={};
    
    return self
end

function ConnectFourRankAwardItem:Destroy()
    local allCount=#self.listItem;
    for i = 1, allCount do
        LuaMgr.DestroyImmediateGO(self.listItem[i].gameObject)
    end

    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self.goLevelBgsType1 =nil;
    self.goLevelBgsType2 =nil;
    self.goLevelBgsType3=nil;
    self.goContent =nil;
    self.textLeft1 =nil;
    self.textRight2 =nil;
    self.textRight3 =nil;
    self.textLeft4 =nil;
    self.uiGoodsItem=nil;
    self.listItem=nil;
end

function ConnectFourRankAwardItem:SetData(data)
    SetActive(self.goLevelBgsType1,data.goLevelBgsType1)
    SetActive(self.goLevelBgsType2,data.goLevelBgsType2)
    SetActive(self.goLevelBgsType3,data.goLevelBgsType3)
    self. textLeft1.text=data.textLeft;
    self. textLeft4.text=data.textLeft;
    self. textRight2.text=data.textRight;
    self. textRight3.text=data.textRight;
    local num=#data.rewardLis;

    for i = 1, num do
        if i>#self.listItem then
            local uiItem=LuaMgr.InstantiateGO(self. uiGoodsItem.gameObject, self.goContent.transform, false):GetComponent("GoodsViewModel")
            table.insert(self.listItem,uiItem);
        end

        SetActive( self.listItem[i].gameObject,true);
        self.listItem[i]:SetData(data.rewardLis[i].id,data.rewardLis[i].count,1,0.58,true);
    end

    local allCount=#self.listItem;
    for i = (num+1), allCount do
        SetActive(self.listItem[i].gameObject,false);
    end
    
    SetActive(self.gameObject, true)
end

function ConnectFourRankAwardItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end