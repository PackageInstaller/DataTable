BrilliantGiftPopUp_RewardItem = {};

BrilliantGiftPopUp_RewardItem.__index = BrilliantGiftPopUp_RewardItem;

local objs = {
    goodRoot={path="goods",type="Transform"},
    doneObj={path="done",type="GameObject"},
    canvasGroup={path="goods",type="CanvasGroup"},
   
  
    
}
function BrilliantGiftPopUp_RewardItem.New()
    local self = {};
    setmetatable(self, BrilliantGiftPopUp_RewardItem);
    return self;
end

function BrilliantGiftPopUp_RewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    
end

function BrilliantGiftPopUp_RewardItem:SetData(pdata)
    self.data=pdata.data
    SetActive(self.doneObj,self.data.isDone);
    self.canvasGroup.alpha=self.data.isDone and 0.5 or 1.0;
    if self.item==nil then
        self.item=GoodsDataItem.New(self.goodRoot)
    end
    local itemConfig = ConfigMgr.Config.itemMap[self.data.reward.id]
    itemConfig["count0"] = self.data.reward.count
    self.item:SetData(1,itemConfig,1,false,Vector3.one*0.7,true)
end
function BrilliantGiftPopUp_RewardItem:Clear()
   self.data=nil
end
function BrilliantGiftPopUp_RewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

