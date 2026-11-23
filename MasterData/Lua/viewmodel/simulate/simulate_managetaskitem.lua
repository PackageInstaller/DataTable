Simulate_ManageTaskItem = {};

Simulate_ManageTaskItem.__index = Simulate_ManageTaskItem;

local objs = {
    txtInfo={path="root/info",type="Text"},
    rewardsTF={path="root/rewardsTF",type="Transform"},
    goStating={path="root/state/rewarding",type="GameObject"},
    goStatePro={path="root/state/rewardPro",type="GameObject"},
    goStated={path="root/state/rewarded",type="GameObject"},
    btnReward={path="root/state/rewarding",type="Button"},
    goFX={path="root/eff_guang",type="GameObject"},
}



function Simulate_ManageTaskItem.New()
    local self = {};
    setmetatable(self, Simulate_ManageTaskItem);
    self.showVMList={};
    return self;
end


function Simulate_ManageTaskItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnReward,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index,self.data.questId);
        end
    end)
end

function Simulate_ManageTaskItem:SetData(pdata)
    self.data=pdata.data
    SetActive(self.goFX,false)
    self.txtInfo.text=string.format("%s(%s/%s)",self.data.info,self.data.pro,self.data.max);
    SetActive(self.goStating,self.data.state==1)
    SetActive(self.goStatePro,self.data.state==2)
    SetActive(self.goStated,self.data.state==3)
    for i,v in ipairs(self.data.items) do
        if self.showVMList[tostring(i)]==nil then
            self.showVMList[tostring(i)]=GoodsDataItem.New(self.rewardsTF);
        end
        local itemData =ConfigMgr.Config.itemMap[v.id];
        itemData.count0 = v.count;
        self.showVMList[tostring(i)]:SetData(1, itemData, 1, false, Vector3(0.56,0.56,0.56), false);
        SetActive(self.showVMList[tostring(i)].transform.gameObject,true);
    end
end
function Simulate_ManageTaskItem:SetRewardFX()
    SetActive(self.goFX,true)
    NumTool.DelayHandler(function()
        if self~=nil and self.goFX~=nil then
            SetActive(self.goFX,false);
        end
    end,1)
end

function Simulate_ManageTaskItem:Clear()
    self.data=nil
    if not IsNull(self.showVMList) then
        for i,v in pairs(self.showVMList) do
            SetActive(self.showVMList[tostring(i)].transform.gameObject,false);
        end
    end
end


function Simulate_ManageTaskItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
end

