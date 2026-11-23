Simulate_EmployeeItem = {};

Simulate_EmployeeItem.__index = Simulate_EmployeeItem;

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
    new={path="root/canvas/new",type="GameObject"},
    imgUsed={path="root/canvas/used",type="Image"},
    bgBtn={path="root/canvas/BG",type="Button"},
    select={path="root/select",type="GameObject"},
}


function Simulate_EmployeeItem.New()
    local self = {};
    setmetatable(self, Simulate_EmployeeItem);
    self.headVM=nil;
    return self;
end


function Simulate_EmployeeItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.bgBtn,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.characterId,self.data.index);
        end
    end)
end

function Simulate_EmployeeItem:SetData(pdata)
    self.data=pdata.data
    self:SetHead();
    self.touristValue.text=self.data.tourist;
    self.touristSlider.value=self.data.touristPro;
    self.imgTourFillColor.color=self.data.touristPro<0.4 and colorRed or colorGreen 
    
    self.satisfieValue.text=self.data.satisfie;
    self.satisfieSlider.value=self.data.satisfiePro;
    self.imgSatisfieFillColor.color=self.data.satisfiePro<0.4 and colorRed or colorGreen
    
    self.visitValue.text=self.data.visit;
    self.visitSlider.value=self.data.visitPro;
    self.imgVisitFillColor.color=self.data.visitPro<0.4 and colorRed or colorGreen
    
    self.name.text=self.data.name;
    self:SetSelect(self.data.isSelect);

    SetActive(self.new,  IsNullOrEmpty(self.data.isUsedBuildId) and self.data.isNew);
    if not self.data.isSelect and not IsNullOrEmpty(self.data.isUsedBuildId) then
        SetActive(self.imgUsed.gameObject,true)
        self.imgUsed.sprite=LuaMgr.GetSprite("Simulate","ui_hd_rsrh_jy_icon_"..self.data.isUsedBuildId)
    else
        SetActive(self.imgUsed.gameObject,false);
    end
end

function Simulate_EmployeeItem:SetHead()
    if self.headVM==nil then
        self.headVM=Simulate_headItem.New(self.headTF);
    end

    local headData={
        characterId=self.data.characterId;
        rare=self.data.rare;

    }
    self.headVM:SetData(headData);

end

function Simulate_EmployeeItem:SetSelect(isOn)
    SetActive(self.select,isOn);
    self.canvasGroup.alpha=isOn and 0.7 or 1.0
end

function Simulate_EmployeeItem:Clear()
    self.data=nil
end


function Simulate_EmployeeItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);

end

