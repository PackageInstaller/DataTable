Simulate_LanternMatelItem = {};

Simulate_LanternMatelItem.__index = Simulate_LanternMatelItem;

local objs = {
    imgIcon={path="root/icon",type="Image"},

    goTag1={path="root/tag1",type="GameObject"},
    goTag2={path="root/tag2",type="GameObject"},
    goSelect={path="root/select",type="GameObject"},
    goLock={path="root/lock",type="GameObject"},
    iconBtn={path="root/icon",type="Button"},
    goFX={path="root/eff",type="GameObject"},
}



function Simulate_LanternMatelItem.New()
    local self = {};
    setmetatable(self, Simulate_LanternMatelItem);
    return self;
end


function Simulate_LanternMatelItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.iconBtn,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
end

function Simulate_LanternMatelItem:SetData(pdata)
    self.data=pdata.data
    SetActive(self.goFX,false);
    self.transform.anchoredPosition=self.data.pos;
    self.imgIcon.sprite=LuaMgr.GetSprite("Simulate",self.data.iconName)

    self:SetSelect(self.data.isCur)
    SetActive(self.goLock,self.data.myCount<1 and not self.data.isMerge);
    if self.data.myCount>0 then

        SetActive(self.goTag2,false)
        SetActive(self.goTag1,true)
    elseif self.data.isMerge then

        SetActive(self.goTag2,true)
        SetActive(self.goTag1,false)
    else


        SetActive(self.goTag1,false)
        SetActive(self.goTag2,false)
    end
end


function Simulate_LanternMatelItem:SetSelect(isOn)
    SetActive(self.goSelect,isOn);
end

function Simulate_LanternMatelItem:UnLockFX()
    SetActive(self.goFX,true);
    NumTool.DelayHandler(function()
        if self~=nil and self.goFX~=nil then
            SetActive(self.goFX,true);
        end
    end,1)
end

function Simulate_LanternMatelItem:Clear()
    self.data=nil
end


function Simulate_LanternMatelItem:Destroy()
    self.goFX=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end

