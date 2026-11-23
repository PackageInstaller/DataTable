




require("ViewModel/Qin2/Qin2Answer_AnswerItem")
require("ViewModel/Qin2/Qin2_AuswerRewardItem")


local this = {vm=nil,
              eventId=nil,
              cfgAnswer = nil,
              answerUIList=nil;
              answerItemObj=nil;
              answer=nil;
              answerList=nil;
              rewardUIList=nil;
              rewardItemObj=nil;
              isTip=false,
              pos={Vector2(120,75),Vector2(-14,-14),Vector2(275,-14)};
              spineCharacter=nil;
              cfgEvent=nil;
};

local AnswerState={
    Progress=1,
    Success=2,
    Fail=3
}

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local good = nil;
local Middle = nil;
local goResult = nil;
local goTip = nil;
local Right = nil;
local Left = nil;
local text = nil;
local txtTitle = nil;
local txtTip = nil;
local tranArea = nil;
local tranAwardTf = nil;
local tranQSpine = nil;
local rawImageBody = nil;
local btnTip = nil;
local btnSubmit = nil;
local btnReStart = nil;
local btnBack = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    good = uiLink:Get("good");
    Middle = uiLink:Get("Middle");
    goResult = uiLink:Get("goResult");
    goTip = uiLink:Get("goTip");
    Right = uiLink:Get("Right");
    Left = uiLink:Get("Left");
    text = uiLink:Get("text"):GetComponent("Text");
    txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    txtTip = uiLink:Get("txtTip"):GetComponent("Text");
    tranArea = uiLink:Get("tranArea"):GetComponent("RectTransform");
    tranAwardTf = uiLink:Get("tranAwardTf"):GetComponent("RectTransform");
    tranQSpine = uiLink:Get("tranQSpine"):GetComponent("RectTransform");
    rawImageBody = uiLink:Get("rawImageBody"):GetComponent("RawImage");
    btnTip = uiLink:Get("btnTip"):GetComponent("Button");
    btnSubmit = uiLink:Get("btnSubmit"):GetComponent("Button");
    btnReStart = uiLink:Get("btnReStart"):GetComponent("Button");
    btnBack = uiLink:Get("btnBack"):GetComponent("Button");
    this.AddRegister(uiLink);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    good = nil;
    Middle = nil;
    goResult = nil;
    goTip = nil;
    Right = nil;
    Left = nil;
    text = nil;
    txtTitle = nil;
    txtTip = nil;
    tranArea = nil;
    tranAwardTf = nil;
    tranQSpine = nil;
    rawImageBody = nil;
    btnTip = nil;
    btnSubmit = nil;
    btnReStart = nil;
    btnBack = nil;

end


local data={}
local command={}

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnSubmit",function()
        if this.answer==nil then
            return
        end
        if this.answer==this.cfgAnswer.RightAnswer then
            txtTitle.text=ConfigMgr.LangGlobal("104006")
            Qin2EventMgr.TourGetReward(this.eventId,0,function()
                this.SetBtnState(AnswerState.Success)
                this.SetReward();
            end)
        else
            txtTitle.text=ConfigMgr.LangGlobal("104007")
            this.SetBtnState(AnswerState.Fail)
        end
    end)
    uiLink:AddClickEvent("btnReStart",function()
        this.ParseData();
    end)
    uiLink:AddClickEvent("btnBack",function()
        LuaMgr.Back();
    end)
    uiLink:AddClickEvent("btnTip",function()
        this.isTip=not this.isTip;
        SetActive(goTip, this.isTip)
    end);
end
   





local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        this.answerItemObj=vm.behaviour.transform:Find("template/answerItem").gameObject;
        this.rewardItemObj=vm.behaviour.transform:Find("template/rewardItem").gameObject;
        this.answerUIList=UIListView.New(tranArea);
        this.rewardUIList=UIListView.New(tranAwardTf);
        this.spineCharacter = this.vm.behaviour.transform:Find("root/Middle/tranQSpine/Spine/JQ005A011"):GetComponent("UISpineCharacter")
        this.spineCharacter:SetDrawing();
        this.spineCharacter:Play("idle_1", true, nil);
       
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>0 then
                this.eventId=vm.behaviour.Params[0];
                this.cfgEvent=ConfigMgr.Config.TourEventMap[this.eventId];
                local answerId=this.cfgEvent.GameParameter[1]
                this.cfgAnswer=ConfigMgr.Config.TourQuestionMap[answerId];
                SetActive(goTip,false);
                this.isTip=false
                this.ParseData();
            end
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end;
        this.answerUIList:Clear();
        this.rewardUIList:Clear();
      
    end,
    before_destroy=function()
        this.Clear()
        UIListView.ClearItem("Qin2Answer_AnswerItem")
        UIListView.ClearItem("Qin2_AuswerRewardItem")
    end
}

this.ParseData=function()
    this.answer=nil;
    this.SetBaseInfo();
    this.SetAnswerList();
    this.SetReward();
    this.SetBtnState(AnswerState.Progress)
end

this.SetBtnState=function(state)
    SetActive(btnSubmit.gameObject,state==AnswerState.Progress)
    SetActive(btnReStart.gameObject,state==AnswerState.Fail)
    SetActive(btnBack.gameObject,state==AnswerState.Success);
    SetActive(goResult,state~=AnswerState.Progress)
    if state==AnswerState.Progress then
        SetActive(tranQSpine.gameObject,false)
        SetActive(tranArea.gameObject,true)
    elseif state==AnswerState.Success then
        SetActive(tranQSpine.gameObject,true)
        SetActive(tranArea.gameObject,false)
        this.spineCharacter:Play("victory", true, nil);
    elseif state==AnswerState.Fail then
        SetActive(tranQSpine.gameObject,true)
        SetActive(tranArea.gameObject,false)
        this.spineCharacter:Play("fail", true, nil);
    end
    
end

this.SetBaseInfo=function()
    txtTitle.text=LuaMgr.GetLangText(this.cfgAnswer.TitleLan)
    txtTip.text=LuaMgr.GetLangText(this.cfgAnswer.AnswerTipsLan);
    local name=DataMgr.Player.sex==1 and "SCJ101" or "SCJ102"
    rawImageBody.texture=LuaMgr.GetTexture(string.format("%sPlayerSkin/%s.png",Path.Image,name));
    
end

this.SetAnswerList=function()
    this.answerList={}
    if not IsNullOrEmpty(this.cfgAnswer.Answer1) then
        table.insert(this.answerList,{id="answer1",name=LuaMgr.GetLangText(this.cfgAnswer.Answer1Lan)})
    end
    if not IsNullOrEmpty(this.cfgAnswer.Answer2) then
        table.insert(this.answerList,{id="answer2",name=LuaMgr.GetLangText(this.cfgAnswer.Answer2Lan)})
    end
    if not IsNullOrEmpty(this.cfgAnswer.Answer3) then
        table.insert(this.answerList,{id="answer3",name=LuaMgr.GetLangText(this.cfgAnswer.Answer3Lan)})
    end
    local list={}
    for i,v in ipairs(this.answerList) do
        local answerItem={
            index=i,
            id=v.id,
            name=v.name,
            callBack=this.AnswerCallBack,
            pos=this.pos[i],
            isOn=false,
        }
        local answerData=UIListData.GetData(this.answerItemObj,"Qin2Answer_AnswerItem",answerItem);
        table.insert(list,answerData);
    end
    this.answerUIList:SetData(list);
end


this.AnswerCallBack=function(index)
    for i,v in ipairs(this.answerUIList.itemList) do
        v:SetIsOn(i==index)
    end
    this.answer=this.answerList[index].id;
end

this.SetReward=function()
    local list={}
    if IsNull(this.cfgEvent.Reward) or #this.cfgEvent.Reward==0 then return end;
    for i,v in ipairs(this.cfgEvent.Reward) do
        local awardItem={
            id=v.id,
            count=v.count,
            isReward=this.CheckIsReward(this.cfgEvent.Id),
            scale=0.4;
        }
        local awardData=UIListData.GetData(this.rewardItemObj,"Qin2_AuswerRewardItem",awardItem);
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

return vm({
    data = data,
    command = command,
    hook = hook
})