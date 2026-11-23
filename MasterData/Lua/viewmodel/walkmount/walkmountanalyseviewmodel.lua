






local this = {
    vm=nil,
    reward=nil,
    voicePath=nil,
};

local cfgLottery=nil;
local isVoicePlay=false;
local isRewarding=false;
local callBack=nil;

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local goInfo1 = nil;
local goMask = nil;
local goInfo2 = nil;
local goClose=nil;
local Right = nil;
local btnMask = nil;
local btnPoem = nil;
local btnClose = nil;
local btnVoice=nil;
local textPoem = nil;
local textName = nil;
local textDes = nil;
local textTitle = nil;
local textYear = nil;
local textFullPoem = nil;
local textDes = nil;
local textFullPoem = nil;
local tranRoot = nil;
local ScrollView = nil;
local ScrollbarVertical = nil;


local animator=nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goInfo1 = uiLink:Get("goInfo1");
    goMask = uiLink:Get("goMask");
    goInfo2 = uiLink:Get("goInfo2");
    goClose=uiLink:Get("goClose");
    Right = uiLink:Get("Right");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    btnPoem = uiLink:Get("btnPoem"):GetComponent("Button");
    btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    btnVoice=uiLink:Get("btnVoice"):GetComponent("Button");
    textPoem = uiLink:Get("textPoem"):GetComponent("Text");
    textName = uiLink:Get("textName"):GetComponent("Text");
    textDes = uiLink:Get("textDes"):GetComponent("Text");
    textTitle = uiLink:Get("textTitle"):GetComponent("Text");
    textYear = uiLink:Get("textYear"):GetComponent("Text");
    textFullPoem = uiLink:Get("textFullPoem"):GetComponent("Text");
    textDes = uiLink:Get("textDes"):GetComponent("UIText");
    textFullPoem = uiLink:Get("textFullPoem"):GetComponent("UIText");
    tranRoot = uiLink:Get("tranRoot"):GetComponent("RectTransform");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ScrollbarVertical = uiLink:Get("ScrollbarVertical"):GetComponent("ScrollRect");

    
    uiLink:AddClickEvent("btnMask",function()
        if isVoicePlay then return end;
        LuaMgr.HidePanel(UIName.WalkMountAnalyseViewModel)
    end)
    uiLink:AddClickEvent("btnClose",function()
        SetActive(goInfo2,false)
        SetActive(goInfo1,true)
        SetActive(goClose,true);
    end)

    uiLink:AddClickEvent("goClose",function()
        if isVoicePlay then return end;
        LuaMgr.HidePanel(UIName.WalkMountAnalyseViewModel)
    end)
    
    uiLink:AddClickEvent("btnPoem",function()
        SetActive(goInfo2,true)
        SetActive(goInfo1,false);
        SetActive(goClose,false)
        animator:Play("ani_ui_WalkMountAnalysePanel_goInfo2",0,0)
        this.SetFullPoemInfo()
    end)
    uiLink:AddClickEvent("btnVoice",function()
        AudioMgr.Singleton:StopVoice(false);
        AudioMgr.Singleton:PlayVoice(this.voicePath);
    end)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    goInfo1 = nil;
    goMask = nil;
    goInfo2 = nil;
    Right = nil;
    btnMask = nil;
    btnPoem = nil;
    btnClose = nil;
    textPoem = nil;
    textName = nil;
    textDes = nil;
    textTitle = nil;
    textYear = nil;
    textFullPoem = nil;
    textDes = nil;
    textFullPoem = nil;
    tranRoot = nil;
    ScrollView = nil;
    ScrollbarVertical = nil;


end



local data = {
}


local command = {
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        animator=vm.behaviour.transform:Find("root"):GetComponent("Animator");
      
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>1 then
                local  id=vm.behaviour.Params[0]
                cfgLottery=ConfigMgr.Config.LotteryMap[id];
                isRewarding=vm.behaviour.Params[1]
                if vm.behaviour.Params.Length>2 then
                    callBack=vm.behaviour.Params[2];
                else
                    callBack=nil;
                end
                animator:Play("ani_ui_WalkMountAnalysePanel_root")
                this.ParseData()
            end
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            AudioMgr.Singleton:StopVoice();
            LuaMgr.RemoveTimer(TimerConst.WalkMountPoemTimer)
            if callBack~=nil then
                callBack();
                callBack=nil;
            end
        end
    end,
    before_destroy=function()
       
    end
        
    
}

this.ParseData=function()
  this.SetBaseInfo()
end

this.SetBaseInfo=function()
    SetActive(goInfo1,true)
    SetActive(goInfo2,false)
    textName.text=LuaMgr.GetLangText("WalkMountAnalyseViewModel_0")..LuaMgr.GetLangText(cfgLottery.NameLan)..LuaMgr.GetLangText("WalkMountAnalyseViewModel_1");
    textDes.text=LuaMgr.GetLangText(cfgLottery.Description2Lan);
    local poem=LuaMgr.GetLangText(cfgLottery.DescriptionLan);
    poem=LuaMgr.Replace(poem,"\n","");
    textPoem.transform.sizeDelta=Vector2(38*NumTool.GetStringLength(poem),108)
    
    this.SetReward()
    if cfgLottery.Voice~=nil and  cfgLottery.Voice~="" then
        this.voicePath=string.format("%sTourismVoice/%s.mp3",Path.audio_PATH,cfgLottery.Voice)
    end
    if not isRewarding then
        textPoem.text=poem;
        return
    end
    if poem~=nil and poem~="" then
        this.ShowPoem(poem);
    end
    if cfgLottery.Voice~=nil and  cfgLottery.Voice~="" then
        local audioSource=AudioMgr.Singleton:PlayVoice(this.voicePath);
        if audioSource~=nil then
            isVoicePlay=true;
            coroutine_runner.start(function()
                coroutine_runner.wait(audioSource.clip.length)
                isVoicePlay=false;
            end)
        end
    end
    

end

this.SetReward=function()
    local reward=cfgLottery.Reward[1]
    if this.reward==nil then
        this.reward=GoodsDataItem.New(tranRoot)
    end
    local itemConfig = ConfigMgr.Config.itemMap[reward.id]
    itemConfig["count0"] = reward.count
    this.reward:SetData(1,itemConfig,1,false,Vector3(1,1,1),false)
    SetActive(goMask,not isRewarding);



end

this.ShowPoem=function(poem)
    local index=0;
    local maxLength=LuaMgr.GetStringLength(poem)
    LuaMgr.AddTimer(TimerConst.WalkMountPoemTimer,function()
        if index>=maxLength then
            LuaMgr.RemoveTimer(TimerConst.WalkMountPoemTimer)
        end
        textPoem.text=LuaMgr.Substring(poem,index)
        index=index+1
    end,0.4,-1,true)
end

this.SetFullPoemInfo=function()
    textTitle.text=LuaMgr.GetLangText(cfgLottery.NameLan);
    textYear.text=LuaMgr.GetLangText(cfgLottery.DynastyLan);
    

    local info=LuaMgr.GetLangText(cfgLottery.Description1Lan);
    local orgInfo=info;
    local size=24;
    if string.match(info,"<size=") then
        info=LuaMgr.Replace(info,"<size=","")
        info=LuaMgr.Replace(info,"</size>","")
        local infos=NumTool.split(info,">")
        info=infos[2];
        size=tonumber(infos[1]);
    end
    local reInfo=LuaMgr.Replace(info,"\n","|")
    local infoList=NumTool.split(reInfo,"|");
    local maxLenInfo=infoList[1];
    for i,v in ipairs(infoList) do
        if #maxLenInfo<#v then
            maxLenInfo=v;
        end
    end

    local len=LuaMgr.GetStringLength(maxLenInfo);
    local width=len*size>998 and 998 or len*size
    textFullPoem.transform.sizeDelta=Vector2(width,0);
textFullPoem.text=orgInfo;
end

return vm({
    data = data,
    command = command,
    hook = hook
})