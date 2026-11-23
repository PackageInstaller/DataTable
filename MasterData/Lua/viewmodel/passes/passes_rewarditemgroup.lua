Passes_RewardItemGroup = {};

Passes_RewardItemGroup.__index = Passes_RewardItemGroup;

local objs = {
    num1Text={path="bg/Num_1",type="Text"},
    tagObj={path="bg/Image/tag",type="GameObject"},

    norBtn={path="bg/norBtn",type="UIButtonClick"},
    highBtn={path="bg/highBtn",type="UIButtonClick"},
    norItemObj={path="bg/normalReward",type="GameObject"},
    highItemObj={path="bg/highRewards",type="GameObject"},
    bgCanvas={path="bg",type="CanvasGroup"},
}
function Passes_RewardItemGroup.New()
    local self = {};
    self.init=false
    setmetatable(self, Passes_RewardItemGroup);
    return self;
end

function Passes_RewardItemGroup:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.norUIList=UIListView.New(self.norItemObj.transform)
    self.highUIList=UIListView.New(self.highItemObj.transform)
    
    self.norCommand=function()
        if self.data.callBackNor~=nil then
            self.data.callBackNor(self.data.index)
        end
    end
    self.highCommand=function()
        if self.data.callBackSpe~=nil then
            self.data.callBackSpe(self.data.index)
        end
    end
    LuaMgr.AddClick(self.norBtn, self.norCommand)
    LuaMgr.AddClick(self.highBtn, self.highCommand)
end

function Passes_RewardItemGroup:SetData(pdata)
    self.data=pdata.data
    self.num1Text.text=self.data.num_1
    SetActive(self.tagObj,self.data.normalItems[1].isRewarded)

    local norList={}
    for i,v in ipairs(self.data.normalItems) do
        local dataItem=UIListData.GetData(self.data.rewardItemObj,"Passes_RewardItem",v)
        table.insert(norList,dataItem);
    end
    self.norUIList:SetData(norList,true)
    local highList={}
    for i,v in ipairs(self.data.specialItems) do
        local dataItem=UIListData.GetData(self.data.rewardItemObj,"Passes_RewardItem",v)
        table.insert(highList,dataItem);
    end
    self.highUIList:SetData(highList,true)



    SetActive(self.norBtn.gameObject,self.data.isNorRewarding);
    SetActive(self.highBtn.gameObject,self.data.isSpeRewarding);
end

function Passes_RewardItemGroup:DOAlphaAnimation(time)
    self.bgCanvas.alpha=0.0
    DOTWeen.To(function() return 0.0  end,function(value)
        self.bgCanvas.alpha=value
    end,1.0,0.5):SetDelay(0.2+time)
end

function Passes_RewardItemGroup:Clear()
   
end
function Passes_RewardItemGroup:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.init=nil
    self.tagObj=nil;
end

