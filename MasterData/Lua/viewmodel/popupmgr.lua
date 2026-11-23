




PopUpMgr = {
    canShowIosUrlInterface = false
}
local popList={}
local popMap={};

local popWait=false;




PopUpMgr.Insert=function(popName)
   table.insert(popList,popName);
    popMap[popName]=true;
end

PopUpMgr.Count=function()
    return #popList;
end


PopUpMgr.CheckPopUp=function()
    if #popList==0 or LuaMgr.IsGuide() or not LuaMgr.IsPanelOpen("MainPageViewModel") then
        PopUpMgr.StopPopUp();
        return;
    end
    if popWait then 
        return 
    end;
    popWait=true
    local panelName=popList[1];
    if panelName==UIName.ActivitySignInViewModel then
        LuaMgr.ShowLuaPanel(panelName,"signIn");
    elseif panelName==UIName.NoticeSlapfaceViewModel then
        NoticeMgr.stopSlapface=false;
    else
        LuaMgr.ShowLuaPanel(panelName);
    end







end



PopUpMgr.ClosePopPanel=function(data)
    local popName=tostring(data[0])
    if popMap[popName]~=nil then
        if popName==UIName.NoticeSlapfaceViewModel then
            if NoticeMgr.GetPaiLianCount()== 0 then
                table.remove(popList,1);
                popWait=false;
            end
        else
            table.remove(popList,1);
            popWait=false;
        end
    end
end


PopUpMgr.StartPopUp=function()
    if LuaMgr.IsGuide() or not LuaMgr.IsPanelOpen("MainPageViewModel") then
        return;
    end
    popWait=false;

    if PopUpMgr.IsCanShowIosUrlInterface() and not LuaMgr.GetIOSUrlShowPop() then
        LuaMgr.AddTimer(TimerConst.IOSUrlInterface, PopUpMgr.OnShowIOSUrlInterface, 0.2, 1, false);
        return;
    end
    
    if #popList==0 and ComData.MainPageChickShowTime ==0 then
        ComData.MainPageChickShowTime = LuaMgr.Timestamp()

    end
    if #popList>0 then
        LuaMgr.RemoveUIEventListener(UIEventConst.ClosePopPanel,PopUpMgr.ClosePopPanel);
        LuaMgr.AddUIEventListener(UIEventConst.ClosePopPanel,PopUpMgr.ClosePopPanel);
        LuaMgr.RemoveTimer(TimerConst.CheckPopUp);
        LuaMgr.AddTimer(TimerConst.CheckPopUp,PopUpMgr.CheckPopUp,0.3);

    else
        NoticeMgr.stopSlapface=false;
        LuaMgr.AddTimer(TimerConst.IOSUrlInterface, PopUpMgr.OnShowIOSUrlInterface, 0.2, 1, false);
        LuaMgr.AddTimer(TimerConst.IOSRequestReview, PopUpMgr.ShowIOSRequestReview, 0.2, 1, false);
    end
end

PopUpMgr.StopPopUp=function()
    if #popList==0 and NoticeMgr.GetPaiLianCount()== 0 and ComData.MainPageChickShowTime ==0 then  
        ComData.MainPageChickShowTime = LuaMgr.Timestamp()
    end

    LuaMgr.RemoveTimer(TimerConst.CheckPopUp);

    NoticeMgr.stopSlapface=false;
    PopUpMgr.OnShowIOSUrlInterface()
    PopUpMgr.ShowIOSRequestReview()
end

PopUpMgr.Login=function()
    popMap={};
    popList={};
    popWait=false;
end


PopUpMgr.OnShowIOSUrlInterface = function()
    if PopUpMgr.IsCanShowIosUrlInterface() and not LuaMgr.IsGuide() then
        PopUpMgr.canShowIosUrlInterface = false
        FeatureManager.GotoPanel(LuaMgr.GetIOSUrlInterfaceId(),LuaMgr.GetIOSUrlInterfaceParam())
        LuaMgr.ClearIOSUrlParam()
    end
end

PopUpMgr.ShowIOSRequestReview = function()
    local starsteers = DataMgr.Player.Starsteers
    if starsteers ~= nil then
        local finishTaskKeyList = {};
        for k, v in pairs(starsteers) do
            if v.State == 1 then
                table.insert(finishTaskKeyList, k)
            end
        end

        if #finishTaskKeyList > 0 then
            local param = {ids = finishTaskKeyList, jump = false}
            ApiMgr.Request("starsteers/starsteers_completed",param,true,function()
                LongyuanSDKManager.RequestReview()
            end,nil,false);
        end
    end
end

PopUpMgr.IsCanShowIosUrlInterface = function()
    return LuaMgr.GetIOSUrlInterfaceId() ~= "" and  PopUpMgr.canShowIosUrlInterface
end

return PopUpMgr;