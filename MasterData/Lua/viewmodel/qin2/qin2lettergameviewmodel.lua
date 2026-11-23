




require("ViewModel/Qin2/Qin2LetterGame_CardItem")
require("ViewModel/Qin2/Qin2GameMgr")
require("ViewModel/Qin2/Qin2_RewardItem")


local this = { vm = nil,
               cardUIList = {},
               cardItemObj = nil;
               rewardUIList={};
               rewardItemObj=nil;
               trailItemObj=nil;
               eventId=nil;
tarImg=nil;
disturbImgList={};
tarCount=nil;
totalTime=nil;
remainTime=nil;
pauseRemainTime=nil;
fastPassTime=nil;
proIndex=nil;
               tweenr=nil;
               objPool={};
               isPause=false;
               cokey=nil;
               
               
};

local GameProgressType={
Start=1,
Update=2,
Pause=3,
Success=4,
Fail=5,
}

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local good = nil;
local Middle = nil;
local goTimer = nil;
local goCountdown = nil;
local goCombo = nil;
local goResult = nil;
local goPause = nil;
local goFail = nil;
local Right = nil;
local Left = nil;
local tranArea = nil;
local tranTarget = nil;
local tranTarCard = nil;
local tranAward = nil;
local imgTar = nil;
local imgFilAmount = nil;
local txtTarPro = nil;
local txtTime = nil;
local txtCombo = nil;
local txtSucessTime = nil;
local txtFailTime = nil;
local btnStart = nil;
local btnPause = nil;
local btnMaskSuccess = nil;
local btnExit = nil;
local btnRestart = nil;
local btnContinue = nil;
local btnMaskFail = nil;
local goLianji=nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    good = uiLink:Get("good");
    Middle = uiLink:Get("Middle");
    goTimer = uiLink:Get("goTimer");
    goCountdown = uiLink:Get("goCountdown");
    goCombo = uiLink:Get("goCombo");
    goResult = uiLink:Get("goResult");
    goPause = uiLink:Get("goPause");
    goFail = uiLink:Get("goFail");
    Right = uiLink:Get("Right");
    Left = uiLink:Get("Left");
    tranArea = uiLink:Get("tranArea"):GetComponent("RectTransform");
    tranTarget = uiLink:Get("tranTarget"):GetComponent("RectTransform");
    tranTarCard = uiLink:Get("tranTarCard"):GetComponent("RectTransform");
    tranAward = uiLink:Get("tranAward"):GetComponent("RectTransform");
    imgTar = uiLink:Get("imgTar"):GetComponent("Image");
    imgFilAmount = uiLink:Get("imgFilAmount"):GetComponent("Image");
    txtTarPro = uiLink:Get("txtTarPro"):GetComponent("Text");
    txtTime = uiLink:Get("txtTime"):GetComponent("Text");
    txtCombo = uiLink:Get("txtCombo"):GetComponent("Text");
    txtSucessTime = uiLink:Get("txtSucessTime"):GetComponent("Text");
    txtFailTime = uiLink:Get("txtFailTime"):GetComponent("Text");
    btnStart = uiLink:Get("btnStart"):GetComponent("Button");
    btnPause = uiLink:Get("btnPause"):GetComponent("Button");
    btnMaskSuccess = uiLink:Get("btnMaskSuccess"):GetComponent("Button");
    btnExit = uiLink:Get("btnExit"):GetComponent("Button");
    btnRestart = uiLink:Get("btnRestart"):GetComponent("Button");
    btnContinue = uiLink:Get("btnContinue"):GetComponent("Button");
    btnMaskFail = uiLink:Get("btnMaskFail"):GetComponent("Button");
    goLianji=uiLink:Get("goLianji");
    this.AddRegister(uiLink);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    good = nil;
    Middle = nil;
    goTimer = nil;
    goCountdown = nil;
    goCombo = nil;
    goResult = nil;
    goPause = nil;
    goFail = nil;
    Right = nil;
    Left = nil;
    tranArea = nil;
    tranTarget = nil;
    tranTarCard = nil;
    tranAward = nil;
    imgTar = nil;
    imgFilAmount = nil;
    txtTarPro = nil;
    txtTime = nil;
    txtCombo = nil;
    txtSucessTime = nil;
    txtFailTime = nil;
    btnStart = nil;
    btnPause = nil;
    btnMaskSuccess = nil;
    btnExit = nil;
    btnRestart = nil;
    btnContinue = nil;
    btnMaskFail = nil;
    goLianji=nil;
end



local data={}
local command={}

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnStart",function()
        if this.cokey~=nil then
            coroutine_runner.stop(this.cokey);
        end
        this.cokey=coroutine_runner.start(function()
            SetActive(goCountdown,true)
            coroutine_runner.wait(3)
            SetActive(goCountdown,false)
            Qin2GameMgr.StartGame();
            this.SetProgress();
        end)
    end)
    uiLink:AddClickEvent("btnPause",function()
        LuaMgr.RemoveTimer(TimerConst.Qin2GameTime);
        this.SetGameState(GameProgressType.Pause)
        Qin2GameMgr.SetGamePause(true);
        this.isPause=true;

        if Qin2GameMgr.IsGameFastState() then
            LuaMgr.RemoveTimer(TimerConst.Qin2GameFastTime);
        end
    end)
    uiLink:AddClickEvent("btnMaskFail",function()
        LuaMgr.Back();
    end)
    uiLink:AddClickEvent("btnMaskSuccess",function()
        LuaMgr.Back();
    end)
    uiLink:AddClickEvent("btnExit",function()
        Qin2GameMgr.GameOver();
        LuaMgr.Back();
    end)
    uiLink:AddClickEvent("btnRestart",function()
        this.ReStartGame();
    end)
    uiLink:AddClickEvent("btnContinue",function()
        this.SetGameState(GameProgressType.Update)
        this.isPause=false;
        Qin2GameMgr.SetGamePause(false);
        this.remainTime=this.pauseRemainTime
        this.SetProgress();

        if Qin2GameMgr.IsGameFastState() then
            this.SetFastProgress();
        end
    end)
    
end

this.CardCallback=function(cardValue,index)
    local isHit,isFast=Qin2GameMgr.CheckHitCount(cardValue);
    if isHit then

        local hitCount=Qin2GameMgr.GetHitCount();
        this.UpdateTarPro(hitCount)
        if hitCount>=this.tarCount then
            this.GameOver(true);
            return;
        end
        this.ShowTrail(index);
    end
    this.SetDurHitInfo(isHit);
    if isFast then

        this.SetFastProgress();
    end
end


local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        this.cardItemObj=vm.behaviour.transform:Find("template/cardItem").gameObject;
        this.trailItemObj=vm.behaviour.transform:Find("template/trailItem").gameObject;
        this.rewardItemObj=vm.behaviour.transform:Find("template/rewardItem").gameObject;
        this.rewardUIList=UIListView.New(tranAward)
        this.cardUIList=UIListView.New(tranArea);
        this.objPool={}
       
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>0 then
                vm.behaviour:UpdateTopBar("", this.OnBack);
                this.eventId=vm.behaviour.Params[0];
                local GameParameter=ConfigMgr.Config.TourEventMap[this.eventId].GameParameter
                this.tarImg=GameParameter[1];
                this.disturbImgList={}
                table.insert(this.disturbImgList,GameParameter[2])
                table.insert(this.disturbImgList,GameParameter[3])
                this.tarCount=tonumber(GameParameter[4])
                this.totalTime=tonumber(GameParameter[5]);
                this.fastPassTime=0;
                this.gameTime=0;
                this.proIndex=0;
                this.isPause=false;
                Qin2GameMgr.InitLetterGame(16);
                SetActive(goCombo,false);
                txtTarPro.text=""
                imgFilAmount.fillAmount=0.0;
                SetActive(goCountdown,false)
                SetActive(goLianji,false);
                this.ParseData();
            end
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end;
        this.cardUIList:Clear();
        this.rewardUIList:Clear();
        LuaMgr.RemoveTimer(TimerConst.Qin2GameTime)
        LuaMgr.RemoveTimer(TimerConst.Qin2GameFastTime)
        Qin2GameMgr.GameOver();
        if this.cokey~=nil then
            coroutine_runner.stop(this.cokey);
        end
        
    end,
    before_destroy=function()
        this.Clear()
        this.objPool={}
        UIListView.ClearItem("Qin2LetterGame_CardItem")
        UIListView.ClearItem("Qin2_RewardItem")
    end
}


this.ReStartGame=function()
    this.gameTime=0;
    this.proIndex=0;
    this.fastPassTime=0;
    this.isPause=false;
    this.UpdateTarPro(0)
    SetActive(goCombo,false);
    LuaMgr.RemoveTimer(TimerConst.Qin2GameFastTime)
    imgFilAmount.fillAmount=0.0;
    this.SetProgress();
    Qin2GameMgr.ReStartGame();
end

this.OnBack=function()
    LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,ConfigMgr.LangGlobal("104013"),function()
        LuaMgr.Back();
    end,nil)
end


this.ParseData=function()
    imgTar.sprite=LuaMgr.GetSprite("Qin2",this.tarImg);
    this.UpdateTarPro(0);
    this.SetGameState(GameProgressType.Start);
    this.SetBoardList();
    this.SetRewardList();
end

this.SetGameState=function(type)
    SetActive(btnStart.gameObject,type==GameProgressType.Start)
    SetActive(goTimer,type==GameProgressType.Update or type==GameProgressType.Pause)
    SetActive(goPause,type==GameProgressType.Pause);
    SetActive(goResult,type==GameProgressType.Success)
    SetActive(goFail,type==GameProgressType.Fail)
end


this.UpdateTarPro=function(hitCount)
    txtTarPro.text=string.format("<color=#b34a18>%s</color>/%s",hitCount,this.tarCount)
end

this.SetBoardList=function()
    local list={}
    for i,v in ipairs(Qin2GameMgr.Board) do
        local cardItem={
            cardIndex=i,
            cardCallBack=this.CardCallback
        }
        local cardData=UIListData.GetData(this.cardItemObj,"Qin2LetterGame_CardItem",cardItem);
        table.insert(list,cardData);
    end
    this.cardUIList:SetData(list);
    Qin2GameMgr.BindUIList(this.cardUIList,this.tarImg,this.disturbImgList);
end

this.SetRewardList=function()
    local list={}
    local rewards=ConfigMgr.Config.TourEventMap[this.eventId].Reward;
    if rewards==nil then return end;
    for i,v in ipairs(rewards) do
        local awardItem={
            id=v.id,
            count=v.count,
            isReward=this.CheckIsReward(this.eventId),
            scale=0.4;
        }
        local awardData=UIListData.GetData(this.rewardItemObj,"Qin2_RewardItem",awardItem);
        table.insert(list,awardData)
    end
    this.rewardUIList:SetData(list);
    
end

this.CheckIsReward=function(eventId)
    if not IsNull(DataMgr.Player.tour.receiveEvent) and DataMgr.Player.tour.receiveEvent[eventId]~=nil then
        return true
    end
    return false;
end

this.SetProgress=function()
    this.SetGameState(GameProgressType.Update)
    this.StartTime=UnityEngine.Time.realtimeSinceStartup-this.gameTime;
    LuaMgr.RemoveTimer(TimerConst.Qin2GameTime)
    LuaMgr.AddTimer(TimerConst.Qin2GameTime,this.SetTimer,0.1,-1,true);
end

this.SetTimer=function()
    this.gameTime=UnityEngine.Time.realtimeSinceStartup-this.StartTime
    this.gameTime=math.floor(this.gameTime);
    if  this.gameTime>=this.totalTime then
        txtTime.text=string.format(ConfigMgr.LangGlobal("104004"),0);
        this.GameOver(false);
        LuaMgr.RemoveTimer(TimerConst.Qin2GameTime)
        return;
    end

    txtTime.text=string.format(ConfigMgr.LangGlobal("104004"),this.totalTime-math.floor(this.gameTime));
end

this.GameOver=function(isSuc)
    Qin2GameMgr.GameOver();
    if isSuc then
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/hightea_success.mp3");
        this.SetGameState(GameProgressType.Success);
        this.OnAskReward();
    else
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/hightea_failed.mp3");
        this.SetGameState(GameProgressType.Fail);
    end
    txtSucessTime.text=string.format(ConfigMgr.LangGlobal("104003"),this.gameTime)
    txtFailTime.text=string.format(ConfigMgr.LangGlobal("104003"),this.gameTime)
    LuaMgr.RemoveTimer(TimerConst.Qin2GameTime);
    LuaMgr.RemoveTimer(TimerConst.Qin2GameFastTime);
end

this.SetDurHitInfo=function(isShow)
    if not isShow then
        SetActive(goCombo,false)
        imgFilAmount.fillAmount=0;
        return
    end
    SetActive(goCombo,true);
    local durHitCount=Qin2GameMgr.GetDurHitCount();

    txtCombo.text=string.format(ConfigMgr.LangGlobal("104005"),durHitCount);
    if durHitCount<=Qin2GameMgr.constants.RightTimes then
        imgFilAmount.fillAmount=durHitCount/Qin2GameMgr.constants.RightTimes;
    end
    if this.tweenr~=nil then
        this.tweenr:Kill();
    end
    goCombo.transform.localScale=Vector3.one;
    this.tweenr=goCombo.transform:DOScale(Vector3.one*1.2,0.1):SetLoops(2, LoopType.Yoyo);
    SetActive(goLianji,false)
    SetActive(goLianji,true);
end


this.ShowTrail=function(index)
    local trail=this.GetTrailObj();
    local itemTf=this.cardUIList.itemList[index].transform;
    trail.img.sprite=LuaMgr.GetSprite("Qin2",this.tarImg);
    local anchoredPosition=RectTransformTool.ToContainer(itemTf,tranTarget)
    trail.tf.anchoredPosition=anchoredPosition;
    trail.tf.localScale = Vector3.one;
    SetActive(trail.tf.gameObject,true);
    if trail~=nil then
        trail.tf:DOLocalMove(Vector3(0,0,0),0.6):SetDelay(0.5).onComplete=function()
            SetActive(trail.tf.gameObject,false)
            table.insert(this.objPool,trail);
        end;
    end
    
end
    
  


this.GetTrailObj=function()
    if #this.objPool==0 then
        local obj = LuaMgr.InstantiateGO(this.trailItemObj);
        if (obj ~= nil) then
            local objTF = obj.transform;
            local img=objTF:Find("root/bg/card"):GetComponent("Image");
            objTF:SetParent(tranTarget, false);
            SetActive(objTF.gameObject,false);
            table.insert(this.objPool, { tf=objTF,img=img });
        end
    end
    local trail=this.objPool[1]
    table.remove(this.objPool,1);
    return trail;
end


this.SetFastProgress=function()
    local curTime=UnityEngine.Time.realtimeSinceStartup-this.fastPassTime;
    LuaMgr.RemoveTimer(TimerConst.Qin2GameFastTime)
    LuaMgr.AddTimer(TimerConst.Qin2GameFastTime,function()
        this.fastPassTime=UnityEngine.Time.realtimeSinceStartup-curTime;
        local pro=1-this.fastPassTime/Qin2GameMgr.constants.RewardTime;
        imgFilAmount.fillAmount=pro;
        if pro<=0 then
            Qin2GameMgr.ExitFastState()
            this.fastPassTime=0;
            this.SetDurHitInfo(false);
            LuaMgr.RemoveTimer(TimerConst.Qin2GameFastTime)
        end
    end,0.1,-1,true);
end



this.OnAskReward=function()



    Qin2EventMgr.TourGetReward(this.eventId,this.gameTime,nil);
end

return vm({
    data = data,
    command = command,
    hook = hook
})