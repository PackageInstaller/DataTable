Passes_TaskItem = {};

Passes_TaskItem.__index = Passes_TaskItem;

local objs = {
    desText={path="root/des",type="Text"},
    proText={path="root/pro",type="Text"},
    goodsTF={path="root/good",type="Transform"},
    btnReward={path="root/btnReward",type="Button"},
    btnJump={path="root/btnJump",type="Button"},
    goDone={path="root/done",type="GameObject"},
   
}
function Passes_TaskItem.New()
    local self = {};
    setmetatable(self, Passes_TaskItem);
    return self;
end

function Passes_TaskItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnReward, function()
        if self.data.rewardCallBack~=nil then
            self.data.rewardCallBack(self.data.id)
        end
    end)
    LuaMgr.AddClick(self.btnJump, function()
        if self.data.jumpCallBack~=nil then
            self.data.jumpCallBack(self.data.id)
        end
    end)
end

function Passes_TaskItem:SetData(pdata)
    self.data=pdata.data
    self.desText.text=self.data.des;
    self.proText.text=self.data.pro;
    SetActive(self.btnJump.gameObject,self.data.state==2)
    SetActive(self.btnReward.gameObject,self.data.state==1)
    SetActive(self.goDone,self.data.state==3)
    if self.item==nil then
        self.item=GoodsDataItem.New(self.goodsTF)
    end
    local itemConfig = ConfigMgr.Config.itemMap[self.data.item.id]
    itemConfig["count0"] = self.data.item.count
    self.item:SetData(1,itemConfig,1,false,Vector3.one*0.5,true)
end
function Passes_TaskItem:Clear()
   self.data=nil
end
function Passes_TaskItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.desText=nil;
    self.proText=nil;
    self.goodsTF=nil;
    self.btnReward=nil;
    self.btnJump=nil;
    self.goDone=nil;
end

