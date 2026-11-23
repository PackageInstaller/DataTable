
local this = {
    vm = nil,

};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.goFXHongBaoYu = uiLink:Get("goFXHongBaoYu");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnReward = uiLink:Get("btnReward"):GetComponent("Button");
    ui.btnManage = uiLink:Get("btnManage"):GetComponent("Button");
    ui.imgManageTag = uiLink:Get("imgManageTag"):GetComponent("Image");
    ui.imgFansSlider = uiLink:Get("imgFansSlider"):GetComponent("Image");
    ui.imgIncomeSlider = uiLink:Get("imgIncomeSlider"):GetComponent("Image");
    ui.txtLevelDes = uiLink:Get("txtLevelDes"):GetComponent("Text");
    ui.txtManageDay = uiLink:Get("txtManageDay"):GetComponent("Text");
    ui.txtFansCount = uiLink:Get("txtFansCount"):GetComponent("Text");
    ui.txtItemCount = uiLink:Get("txtItemCount"):GetComponent("Text");
    ui.txtIncomeTime = uiLink:Get("txtIncomeTime"):GetComponent("Text");
    ui.rawItemIcon = uiLink:Get("rawItemIcon"):GetComponent("RawImage");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        this.animator:Play("ani_ui_SimulateManageBreviaryPanel_root_02")
        NumTool.DelayHandler(function()
            LuaMgr.HidePanel(UIName.SimulateManageBreviaryViewModel)
        end,0.8)
    end)
    uiLink:AddClickEvent("btnReward",function()
        if this.curIdleTimeIncome==0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SimulateManageBreviaryViewModel_0"))
            return;
        end
        SimulateRoomMgr.OnAskIdleRewards(function()
            this.ParseData();
            SetActive(ui.goFXHongBaoYu,true)
            XCHDMgr.CheckSimulateRedDot();
            RedMgr.Singleton:Refresh()
            NumTool.DelayHandler(function()
                if ui~=nil and ui.goFXHongBaoYu~=nil then
                    SetActive(ui.goFXHongBaoYu,false)
                end
            end,1.5)
        end);
    end)
    uiLink:AddClickEvent("btnManage",function()
        this.animator:Play("ani_ui_SimulateManageBreviaryPanel_root_02")
        NumTool.DelayHandler(function()
            LuaMgr.HidePanel(UIName.SimulateManageBreviaryViewModel)
            LuaMgr.ShowLuaPanel(UIName.SimulateManageViewModel);
        end,0.8)
    end)
end


local data = {

}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        print("before_awake");
        this.InitUI(vm.behaviour)
        this.animator=vm.behaviour.transform:Find("root"):GetComponent("Animator");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.animator:Play("ani_ui_SimulateManageBreviaryPanel_root_01")
AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/foundation_boxopen.mp3");
            this.ParseData();
            SetActive(ui.goFXHongBaoYu,false)
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
       
    end,
    before_destroy = function()
        this.ClearUI()
    end
}

this.ParseData=function()
    this.dataSIMArchitect=DataMgr.Player.SimulateArchitect;
    local curSIMDegree=ConfigMgr.Config.SimulateDegreeMap[tostring(this.dataSIMArchitect.StageLevel)]
    local nextSIMDegree=ConfigMgr.Config.SimulateDegreeMap[tostring(this.dataSIMArchitect.StageLevel+1)];
    ui.txtManageDay.text=this.dataSIMArchitect.Days;
    ui.imgManageTag.sprite=LuaMgr.GetSprite("Simulate",curSIMDegree.Icon);
    local curName=LuaMgr.GetLangText(curSIMDegree.NameLan);
    ui.txtLevelDes.text=string.format(LuaMgr.GetLangText("SimulateManageBreviaryViewModel_1"),curName);
    if nextSIMDegree==nil then
        nextSIMDegree=curSIMDegree;

        ui.txtFansCount.text=string.format(ConfigMgr.LangGlobal("29417"),curName);
        ui.imgFansSlider.fillAmount=1.0
    else

        local curFansCount=this.dataSIMArchitect.StageValue;
        local maxFansCount=nextSIMDegree.Para;
        ui.txtFansCount.text=string.format("%s/%s",curFansCount,maxFansCount);
        ui.imgFansSlider.fillAmount=curFansCount/maxFansCount;
    end
    
    this.curIdleTimeIncome=0;
    local idleDurSec=0;
    if this.dataSIMArchitect.IdleTime>0 then
        idleDurSec=LuaMgr.Timestamp()-this.dataSIMArchitect.IdleTime
        idleDurSec=idleDurSec<0 and 0 or idleDurSec;
        if idleDurSec>curSIMDegree.AccumulateLimit*60*60 then
            idleDurSec=curSIMDegree.AccumulateLimit*60*60;
        end
        local idleDurMin=math.floor(idleDurSec/60/ConfigMgr.Config.SimulateConstants.SimulateRewardGapMin)
        local revenueCount=curSIMDegree.Revenue[1].count
        this.curIdleTimeIncome=idleDurMin*revenueCount;
    end
    local path=ConfigHelper.GetItemIconPath(curSIMDegree.Revenue[1].id)
    ui.rawItemIcon.texture=LuaMgr.GetTexture(path)
    ui.txtItemCount.text=this.curIdleTimeIncome;
    local h,m,s=GetTimeHMS(idleDurSec)
    ui.txtIncomeTime.text=string.format("%.2d : %.2d : %.2d",h,m,s);
    ui.imgIncomeSlider.fillAmount=idleDurSec/(24*60*60);
end

return vm({
    data = data,
    command = command,
    hook = hook
})