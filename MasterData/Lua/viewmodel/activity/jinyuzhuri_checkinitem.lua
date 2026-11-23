JinYuZhuRi_CheckInItem = {};

JinYuZhuRi_CheckInItem.__index = JinYuZhuRi_CheckInItem;

local objs = {
    goMask={path="offSet/iconMask",type="GameObject"},
    btnIcon={path="offSet/icon",type="Button"},
    goCur={path="offSet/cur",type="GameObject"},
    goPass={path="offSet/pass",type="GameObject"},
    goLock={path="offSet/lock",type="GameObject"},
    rewardTf={path="offSet/reward",type="Transform"},
    dayText={path="offSet/Text",type="Text"},
    offTf={path="offSet",type="Transform"},
    goFX={path="offSet/eff_fire",type="GameObject"},
}
function JinYuZhuRi_CheckInItem.New()
    local self = {};
    setmetatable(self, JinYuZhuRi_CheckInItem);
    return self;
end

function JinYuZhuRi_CheckInItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnIcon,function()
        if self.data~=nil and self.data.callBack~=nil  then
            self.data.callBack(self.data.index);
        end
    end)
end





function JinYuZhuRi_CheckInItem:SetData(pdata)
    self.data=pdata.data
    self.dayText.text=string.format(ConfigMgr.LangGlobal("15714"),self.data.index);
    SetActive(self.goMask,self.data.checkInState~=2);
    SetActive(self.goPass,self.data.checkInState==3);
    SetActive(self.goLock,self.data.checkInState==1);
    SetActive(self.goFX,self.data.checkInState==2)
    if self.item==nil then
        self.item=GoodsDataItem.New(self.rewardTf)
    end
    local itemConfig = ConfigMgr.Config.itemMap[self.data.showReward.id]
    itemConfig["count0"] = self.data.showReward.count
    self.item:SetData(1,itemConfig,1,false,Vector3.one*0.7,false)
    self:SelectState(false)

end

function JinYuZhuRi_CheckInItem:SelectState(isOn)
    self.offTf.anchoredPosition=isOn and Vector2(0,20) or Vector2(0,0);
    SetActive(self.goCur,isOn);
end



function JinYuZhuRi_CheckInItem:Clear()
    self.data=nil
end
function JinYuZhuRi_CheckInItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
end

