TrafficPermitNew_RewardItemGroup = {};

TrafficPermitNew_RewardItemGroup.__index = TrafficPermitNew_RewardItemGroup;
require("ViewModel/TrafficPermitNew/TrafficPermitNew_RewardItem")

local objs = {
    num1Text={path="bg/Num_1",type="Text"},

    norBtn={path="bg/norBtn",type="UIButtonClick"},
    highBtn={path="bg/highBtn",type="UIButtonClick"},
    norItemObj={path="bg/normalReward",type="GameObject"},
    highItemObj={path="bg/highRewards",type="GameObject"},
    bgCanvas={path="bg",type="CanvasGroup"},
}
function TrafficPermitNew_RewardItemGroup.New()
    local self = {};
    self.init=false
    setmetatable(self, TrafficPermitNew_RewardItemGroup);
    return self;
end

function TrafficPermitNew_RewardItemGroup:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.norUIList=UIListView.New(self.norItemObj.transform)
    self.highUIList=UIListView.New(self.highItemObj.transform)
end

function TrafficPermitNew_RewardItemGroup:SetData(pdata)
    self.data=pdata.data
    self.num1Text.text=self.data.num_1

    local norList={}
    for i,v in ipairs(self.data.normalItems) do
        local dataItem=UIListData.GetData(self.data.rewardItemObj,"TrafficPermitNew_RewardItem",v)
        table.insert(norList,dataItem);
    end
    self.norUIList:SetData(norList,true)
    local highList={}
    for i,v in ipairs(self.data.specialItems) do
        local dataItem=UIListData.GetData(self.data.rewardItemObj,"TrafficPermitNew_RewardItem",v)
        table.insert(highList,dataItem);
    end
    self.highUIList:SetData(highList,true)



    SetActive(self.norBtn.gameObject,self.data.isNorRewarding);
    SetActive(self.highBtn.gameObject,self.data.isSpeRewarding);
    
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

function TrafficPermitNew_RewardItemGroup:DOAlphaAnimation(time)
    self.bgCanvas.alpha=0.0
    DOTWeen.To(function() return 0.0  end,function(value)
        self.bgCanvas.alpha=value
    end,1.0,0.5):SetDelay(0.2+time)
end

function TrafficPermitNew_RewardItemGroup:Clear()
    LuaMgr.RemoveClick(self.norBtn, self.norCommand)
    LuaMgr.RemoveClick(self.highBtn, self.highCommand)
    UIListView.ClearItem("TrafficPermitNew_RewardItem")
end
function TrafficPermitNew_RewardItemGroup:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.init=nil
end

