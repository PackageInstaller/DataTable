TRJRoulette_RewardItemGroup = {};

TRJRoulette_RewardItemGroup.__index = TRJRoulette_RewardItemGroup;

local objs = {
    numSprite={path="bg/num",type="Image"},
    clickBtn={path="bg/clickBtn",type="UIButtonClick"},
    norItemObj={path="bg/normalReward",type="GameObject"},
    highItemObj={path="bg/highRewards",type="GameObject"},
    bgCanvas={path="bg",type="CanvasGroup"},
}
function TRJRoulette_RewardItemGroup.New()
    local self = {};
    setmetatable(self, TRJRoulette_RewardItemGroup);
    return self;
end

function TRJRoulette_RewardItemGroup:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.norUIList=UIListView.New(self.norItemObj.transform)
    self.highUIList=UIListView.New(self.highItemObj.transform)
    self.clickBtnCommand=function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index)
        end
    end
    LuaMgr.AddClick(self.clickBtn, self.clickBtnCommand)
end



function TRJRoulette_RewardItemGroup:SetData(pdata)
    self.data=pdata.data
    self.numSprite.sprite=LuaMgr.GetSprite("TRJ","ui_hd_znq_tybl_img_0"..self.data.index);
    local norList={}
    for i,v in ipairs(self.data.freeReward) do
        local dataItem={
            item=v,
            isLock=false,
            isRewarded=self.data.freeState==3;
            isRed=self.data.freeState==2;
        }
        local dataData=UIListData.GetData(self.data.itemObj,"TRJRoulette_RewardItem",dataItem)
        table.insert(norList,dataData);
    end
    self.norUIList:SetData(norList)
    local highList={}
    for i,v in ipairs(self.data.payReward) do
        local dataItem={
            item=v,
            isLock=self.data.payState==0,
            isRewarded=self.data.payState==3;
            isRed=self.data.payState==2;
        }
        local dataData=UIListData.GetData(self.data.itemObj,"TRJRoulette_RewardItem",dataItem)
        table.insert(highList,dataData);
    end
    self.highUIList:SetData(highList)
    SetActive(self.clickBtn.gameObject,self.data.freeState==2 or self.data.payState==2);
end




function TRJRoulette_RewardItemGroup:Clear()
    self.norUIList:Clear();
    self.highUIList:Clear();
end
function TRJRoulette_RewardItemGroup:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

