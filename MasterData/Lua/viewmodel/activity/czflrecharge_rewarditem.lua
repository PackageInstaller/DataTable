CZFLRecharge_RewardItem = {};

CZFLRecharge_RewardItem.__index = CZFLRecharge_RewardItem;

local objs = {

    goLockBg={path="root/canvas/bg/lockBg",type="GameObject"},
    goReward1={path="root/canvas/reward1",type="GameObject"},
    goReward2={path="root/canvas/reward2",type="GameObject"},
    goodsTF={path="root/canvas/goods",type="Transform"},
    goLockTag={path="root/pro/tag",type="GameObject"},
    txtValue={path="root/pro/value",type="Text"},
    goRewarded={path="root/rewarded",type="GameObject"},
    goRewarding={path="root/rewarding",type="GameObject"},
    goLock={path="root/lock",type="GameObject"},
    btnClick={path="root/rewarding",type="Button"},
   
}
function CZFLRecharge_RewardItem.New()
    local self = {};
    setmetatable(self, CZFLRecharge_RewardItem);
    self.rewardList={}
    return self;
end

function CZFLRecharge_RewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnClick,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.questId)
        end
    end)
end







function CZFLRecharge_RewardItem:SetData(pdata)
    if not IsNull(self.rewardList) then
        for i,v in pairs(self.rewardList) do
            SetActive(v.transform.gameObject,false);
        end
    end
    
    self.data=pdata.data

    SetActive(self.goLock,self.data.state==1)
    SetActive(self.goLock,self.data.state==1)
    SetActive(self.goLockBg,self.data.state==1)
    SetActive(self.goRewarded,self.data.state==3)
    SetActive(self.goRewarding,self.data.state==2);
    SetActive(self.goLockTag,self.data.state==1)
    self.txtValue.text=self.data.state==1 
            and string.format("<color=#514735>%s</color>",self.data.progress) or self.data.progress;
    if IsNull(self.data.reward) or #self.data.reward==0 then
        return
    end
    local isTypeOne=#self.data.reward==1;
    self.goodsTF.anchoredPosition=not isTypeOne and Vector2(46,-16.9) or Vector2(43,-26)
    SetActive(self.goReward1,isTypeOne);
    SetActive(self.goReward2,not isTypeOne);
    for i,v in ipairs(self.data.reward) do
        if self.rewardList[tostring(i)]==nil then
            self.rewardList[tostring(i)]=GoodsDataItem.New(self.goodsTF)
        end
        SetActive(self.rewardList[tostring(i)].transform.gameObject,true)
        local itemConfig = table.Copy(ConfigMgr.Config.itemMap[v.id]);
        itemConfig.count0 = v.count;
        if isTypeOne then
            self.rewardList[tostring(i)]:SetData(1, itemConfig, 1, false, Vector3.one*0.9, false,false);
        else
            self.rewardList[tostring(i)]:SetData(1, itemConfig, 1, false, Vector3.one*0.5, false,false);
        end
    end
end


function CZFLRecharge_RewardItem:Clear()
    self.data=nil
end

function CZFLRecharge_RewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

