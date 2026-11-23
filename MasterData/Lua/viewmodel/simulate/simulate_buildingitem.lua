Simulate_BuildingItem = {};

Simulate_BuildingItem.__index = Simulate_BuildingItem;

local objs = {
    txtName1={path="root/name1",type="Text"},
    txtName2={path="root/name2",type="Text"},
    imgTag={path="root/tag",type="Image"},
    tfStar={path="root/star",type="Transform"},
    goSelect={path="root/select",type="GameObject"},
    goLock={path="root/lock",type="GameObject"},
    lockInfo={path="root/lock/Text",type="Text"},
    bgBtn={path="root/bg",type="Button"},
}



function Simulate_BuildingItem.New()
    local self = {};
    setmetatable(self, Simulate_BuildingItem);
    return self;
end


function Simulate_BuildingItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.bgBtn,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
   
end









function Simulate_BuildingItem:SetData(pdata)
    self.data=pdata.data
    self.txtName1.text=self.data.isUnLock and self.data.name or "";
    self.txtName2.text=self.data.isUnLock and "" or  self.data.name;
    self.imgTag.sprite=LuaMgr.GetSprite("Simulate","ui_hd_rsrh_jy_icon_"..self.data.id);
    SetActive(self.goLock,not self.data.isUnLock)
    if not self.data.isUnLock then
        self.lockInfo.text=self.data.lockInfo;
    else
        self.lockInfo.text="";
    end
    if self.data.isUnLock then
        for i=1,self.tfStar.childCount,1 do
            SetActive(self.tfStar:GetChild(i-1).gameObject,i<=self.data.starIndex);
        end
    else
        for i=1,self.tfStar.childCount,1 do
            SetActive(self.tfStar:GetChild(i-1).gameObject,false);
        end
    end
    self:SetSelect(self.data.isCur)
    SetActive(self.gameObject,false)
    NumTool.DelayHandler(function()
        SetActive(self.gameObject,true)
    end,0.1*self.data.index)
end

function Simulate_BuildingItem:SetSelect(isOn)
    SetActive(self.goSelect,isOn);
end

function Simulate_BuildingItem:Clear()
    self.data=nil
end


function Simulate_BuildingItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end

