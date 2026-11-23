BrilliantGift_TaskItem = {};

BrilliantGift_TaskItem.__index = BrilliantGift_TaskItem;

local objs = {
    rootObj = { path = "root", type = "GameObject" },
    desText = { path = "root/des", type = "Text" },
    norObj = { path = "root/nor", type = "GameObject" },
    getObj = { path = "root/get", type = "GameObject" },
    doneObj = { path = "root/done", type = "GameObject" },
    jumpBtn = { path = "root/nor", type = "Button" },
    getBtn = { path = "root/get", type = "Button" },
    norProText = { path = "root/nor/pro", type = "Text" },
    norImgFill = { path = "root/nor/slider/fillAmount", type = "Image" },
    tranRewardList = { path = "root/RewardList", type = "Transform" },
}
function BrilliantGift_TaskItem.New()
    local self = {};
    setmetatable(self, BrilliantGift_TaskItem);
    return self;
end

function BrilliantGift_TaskItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.itemList={}
    LuaMgr.AddClick(self.jumpBtn, function()
        if self.data.taskCallBack~=nil then
            self.data.taskCallBack(self.data.questId,self.data.skipPage,1);
        end
    end)
    LuaMgr.AddClick(self.getBtn, function()
        if self.data.taskCallBack~=nil then
            self.data.taskCallBack(self.data.questId,self.data.skipPage,2);
        end
    end)
  
end

function BrilliantGift_TaskItem:SetData(pdata)
    self.data=pdata.data
    self.desText.text=self.data.dse;
    SetActive(self.rootObj,false);
    SetActive(self.norObj,self.data.state==1);
    SetActive(self.getObj,self.data.state==2);
    SetActive(self.doneObj,self.data.state==3);
    if self.data.state==1 then
        self.norProText.text=string.format("<color=#ffeed2>%s</color>/%s",self.data.pro,self.data.tar);
        self.norImgFill.fillAmount=self.data.pro/self.data.tar;
    end
end

function BrilliantGift_TaskItem:SetActive()
    SetActive(self.rootObj,true);
    self:SetRewards()
end

function BrilliantGift_TaskItem:SetRewards()
    local count=0
    if not IsNull(self.data.reward) and  #self.data.reward>0 then
        count=#self.data.reward;
    end;
    if #self.itemList>count then
        for i=count+1,#self.itemList,1 do
            SetActive(self.itemList[i].transform.gameObject,false);
        end
    end
    if count==0 then return end;
    for i,v in ipairs(self.data.reward) do
        if  self.itemList[i]==nil then
            self.itemList[i]=GoodsDataItem.New(self.tranRewardList);
        end
        local itemConfig = ConfigMgr.Config.itemMap[v.id]
        itemConfig["count0"] = v.count
        self.itemList[i]:SetData(1,itemConfig,1,false,Vector3.one*0.5,true)
    end
end

function BrilliantGift_TaskItem:Clear()
   self.data=nil
end
function BrilliantGift_TaskItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

