Qin2Task_Item = {};

Qin2Task_Item.__index = Qin2Task_Item;
local objs = {
    proText={ path = "pro", type = "Text" },
    des={ path = "des", type = "Text" },
    amountImg={ path = "slider/amount", type = "Image" },
    rewardTf={ path = "reward", type = "Transform" },
    awardObj={ path = "award", type = "GameObject" },
    awardCanvasGroup={ path = "reward", type = "CanvasGroup" },
    jumpObj={path="jump",type="GameObject"},
    doneObj={path="done",type="GameObject"},
    awardBtn={ path = "award", type = "Button" },
    jumpBtn={ path = "jump", type = "Button" },
}

function Qin2Task_Item.New()
    local self = {};
    setmetatable(self, Qin2Task_Item);
    self.isActive=false;
    return self;
end

function Qin2Task_Item:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.awardBtn,function()
        if  self.data.rewardCallBack~=nil then
            self.data.rewardCallBack(self.data.id);
        end
    end)
    LuaMgr.AddClick(self.jumpBtn,function()
        if  self.data.jumpCallBack~=nil then
            self.data.jumpCallBack(self.data.skipPage);
        end
    end)
    self.itemList={};
end

function Qin2Task_Item:SetData(pdata)
    self.data = pdata.data
    self.proText.text=self.data.pro;
    self.des.text=self.data.name;
    self.amountImg.fillAmount=self.data.proValue;
    self.awardCanvasGroup.alpha=self.data.state==3 and 0.5 or 1.0
    SetActive(self.awardObj,self.data.state==2)
    SetActive(self.jumpObj,self.data.state==1)
    SetActive(self.doneObj,self.data.state==3);
    for i,v in ipairs(self.data.awards) do
        if self.itemList[i]==nil then
            self.itemList[i]=GoodsDataItem.New(self.rewardTf)
        end
        SetActive(self.itemList[i].gameObject,true)
        local itemConfig = ConfigMgr.Config.itemMap[v.id]
        itemConfig["count0"] = v.count
        self.itemList[i]:SetData(1,itemConfig,1,false,Vector3(0.5,0.5,1),false)
    end
end





function Qin2Task_Item:Clear()
    if self.itemList~=nil then
        for i,v in ipairs(self.itemList) do
            SetActive(v.gameObject,false)
        end
    end
    self.data = nil;
end

function Qin2Task_Item:Destroy()
    self.proText=nil;
    self.des=nil;
    self.amountImg=nil;
    self.rewardTf=nil;
    self.awardObj=nil;
    self.jumpObj=nil;
    self.doneObj=nil;
    self.awardBtn=nil;
    self.jumpBtn=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
end