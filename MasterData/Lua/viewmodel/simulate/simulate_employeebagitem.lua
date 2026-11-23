require("ViewModel/Simulate/Simulate_headItem")

Simulate_EmployeeBagItem = {};

Simulate_EmployeeBagItem.__index = Simulate_EmployeeBagItem;

local colorRed=UnityEngine.Color(185/255,76/255,51/255,1)
local colorGreen=UnityEngine.Color(204/255,224/255,140/255,1)

local objs = {
    canvasGroup={path="root/canvas",type="CanvasGroup"},
    headTF={path="root/canvas/head",type="Transform"},
    touristSlider={path="root/canvas/tourist/touristSlider",type="Slider"},
    touristName={path="root/canvas/tourist/touristName",type="Text"},
    touristValue={path="root/canvas/tourist/touristValue",type="Text"},
    imgTourFillColor={path="root/canvas/tourist/touristSlider/FillArea/Fill",type="Image"},

    satisfieSlider={path="root/canvas/satisfie/satisfieSlider",type="Slider"},
    satisfieName={path="root/canvas/satisfie/satisfieName",type="Text"},
    satisfieValue={path="root/canvas/satisfie/satisfieValue",type="Text"},
    imgSatisfieFillColor={path="root/canvas/satisfie/satisfieSlider/FillArea/Fill",type="Image"},

    visitSlider={path="root/canvas/visit/visitSlider",type="Slider"},
    visitName={path="root/canvas/visit/visitName",type="Text"},
    visitValue={path="root/canvas/visit/visitValue",type="Text"},
    imgVisitFillColor={path="root/canvas/visit/visitSlider/FillArea/Fill",type="Image"},


    name={path="root/canvas/Name",type="Text"},
    goNew={path="root/canvas/new",type="GameObject"},
    rawCostIcon={path="root/canvas/clickArea/costIcon",type="RawImage"},
    costCount={path="root/canvas/clickArea/costCount",type="Text"},
    bgBtn={path="root/canvas/clickArea",type="Button"},
    
    used={path="root/used",type="GameObject"},
    goUsedFX={path="root/used/caidai",type="GameObject"},
    animator={path="root",type="Animator"},
}



function Simulate_EmployeeBagItem.New()
    local self = {};
    setmetatable(self, Simulate_EmployeeBagItem);
    self.headVM=nil;
    return self;
end


function Simulate_EmployeeBagItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.bgBtn,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.characterId,self.data.index);
        end
    end)
end

function Simulate_EmployeeBagItem:SetData(pdata)
    self.data=pdata.data
    self:SetHead();
    self.touristName.text=SimulateRoomMgr.Build_FourName[2];
    self.touristValue.text=self.data.tourist;
    self.touristSlider.value=self.data.touristPro;
    self.imgTourFillColor.color=self.data.touristPro<0.4 and colorRed or colorGreen
    
    self.satisfieName.text=SimulateRoomMgr.Build_FourName[3];
    self.satisfieValue.text=self.data.satisfie;
    self.satisfieSlider.value=self.data.satisfiePro;
    self.imgSatisfieFillColor.color=self.data.satisfiePro<0.4 and colorRed or colorGreen
    
    self.visitName.text=SimulateRoomMgr.Build_FourName[4];
    self.visitValue.text=self.data.visit;
    self.visitSlider.value=self.data.visitPro;
    self.imgVisitFillColor.color=self.data.visitPro<0.4 and colorRed or colorGreen
    
    self.name.text=self.data.name;

    SetActive(self.goNew,not self.data.isUsed and self.data.isNew);
    local path=ConfigHelper.GetItemHomeIconPath(self.data.cost[1].id)
    self.rawCostIcon.texture=LuaMgr.GetTexture(path);
    self.costCount.text=string.format("%d",self.data.cost[1].count-self.data.cost[1].count*SimulateRoomMgr.CheckTriggerReduceCostEmployee());
    self:SetSelect(self.data.isUsed);
end

function Simulate_EmployeeBagItem:SetHead()
    if self.headVM==nil then
        self.headVM=Simulate_headItem.New(self.headTF);
    end

    local headData={
        characterId=self.data.characterId;
        rare=self.data.rare;
        job=self.data.job;
    }
    self.headVM:SetData(headData);
    
end

function Simulate_EmployeeBagItem:SetSelect(isOn)
    SetActive(self.used,isOn);
    self.canvasGroup.alpha=isOn and 0.7 or 1.0
    SetActive(self.goUsedFX,self.data.isUsedFX)
end

function Simulate_EmployeeBagItem:Clear()
    self.data=nil
end


function Simulate_EmployeeBagItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end

