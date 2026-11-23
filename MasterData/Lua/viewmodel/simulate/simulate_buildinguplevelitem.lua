Simulate_BuildingUpLevelItem = {};

Simulate_BuildingUpLevelItem.__index = Simulate_BuildingUpLevelItem;

local objs = {
    rectBg={path="root/rectBg",type="RectTransform"},
    title={path="root/title",type="Text"},
    upInfo={path="root/upInfo",type="Text"},
    addInfo={path="root/addInfo",type="Text"},
    costIcon={path="root/costIcon",type="RawImage"},
    costCount={path="root/costCount",type="Text"},
    select={path="root/select",type="GameObject"},
    goUpLevelFX={path="root/upLevelFX",type="GameObject"},
    bgBtn={path="root",type="Button"},
}



function Simulate_BuildingUpLevelItem.New()
    local self = {};
    setmetatable(self, Simulate_BuildingUpLevelItem);
    return self;
end


function Simulate_BuildingUpLevelItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.bgBtn,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
    
end









function Simulate_BuildingUpLevelItem:SetData(pdata)
    self.data=pdata.data
    self.name=self.data.index==1 and LuaMgr.GetLangText("Simulate_BuildingUpLevelItem_0") or SimulateRoomMgr.Build_FourName[self.data.index]..LuaMgr.GetLangText("Simulate_BuildingUpLevelItem_1");
    self.title.text=string.format("%s:",self.name);
    self.rectBg.sizeDelta=Vector2(self.title.preferredWidth+70,31)
    if self.data.isMaxLevel then
        self.upInfo.text=string.format(LuaMgr.GetLangText("Simulate_BuildingUpLevelItem_2"),self.data.level,self.data.maxLevel)
        self.addInfo.text=LuaMgr.GetLangText("Simulate_BuildingUpLevelItem_3");
        self.costIcon.enabled=false;
        self.costCount.text="";
    else
        local path=ConfigHelper.GetItemIconPath(self.data.upCost.id)
        self.costIcon.enabled=true;
        self.costIcon.texture=LuaMgr.GetTexture(path);
        self.costCount.text=self.data.upCost.count;
        local addInfo=""
        if self.data.index==1 then
            local add1=SimulateRoomMgr.GetBuildingFansByLevel(self.data.buildId,1,self.data.level);
            local add2=SimulateRoomMgr.GetBuildingFansByLevel(self.data.buildId,2,self.data.level);;
            local add3=SimulateRoomMgr.GetBuildingFansByLevel(self.data.buildId,3,self.data.level);;
            local add4=SimulateRoomMgr.GetBuildingFansByLevel(self.data.buildId,4,self.data.level);;
            addInfo=string.format(LuaMgr.GetLangText("Simulate_BuildingUpLevelItem_4"),SimulateRoomMgr.Build_FourName[1],add1,
                    SimulateRoomMgr.Build_FourName[2],add2,SimulateRoomMgr.Build_FourName[3],add3,SimulateRoomMgr.Build_FourName[4],add4);
            self.addInfo.text=addInfo;
        else
            local add=SimulateRoomMgr.GetBuildingBaseFansByLevel(self.data.buildId,self.data.index-1,self.data.level)
            addInfo=string.format("%s:+%s",SimulateRoomMgr.Build_FourName[self.data.index],add)
            self.addInfo.text=addInfo;
        end
    end
    self:SetSelect(self.data.isOn);
end


function Simulate_BuildingUpLevelItem:SetSelect(isOn) 
    SetActive(self.select,isOn);
    if self.data.isMaxLevel then
        return;
    end
    local upInfoTip=isOn and LuaMgr.GetLangText("Simulate_BuildingUpLevelItem_5") or LuaMgr.GetLangText("Simulate_BuildingUpLevelItem_6")
    self.upInfo.text=isOn and string.format(upInfoTip,self.data.level,self.data.level+1) 
            or string.format(upInfoTip,self.data.level,self.data.maxLevel);
end

function Simulate_BuildingUpLevelItem:SetUpLevelFX()
    SetActive(self.goUpLevelFX,true)
    NumTool.DelayHandler(function()
        if self~=nil and self.goUpLevelFX~=nil then
            SetActive(self.goUpLevelFX,false)
        end
    end,1)
end


function Simulate_BuildingUpLevelItem:Clear()
    self.data=nil
end


function Simulate_BuildingUpLevelItem:Destroy()
    self.goUpLevelFX=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
end