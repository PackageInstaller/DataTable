require("ViewModel/Simulate/Simulate_RiddlesAnsItem")
require("ViewModel/Simulate/Simulate_RiddlesRewardItem")

local this = {
    vm = nil,
    answerUIList={};
    answerItemObj=nil;
    rewardUIList={};
    rewardItemObj=nil;
    clickInterval=1;
    lastClickTime=0;
};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.goods = uiLink:Get("goods");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtContent = uiLink:Get("txtContent"):GetComponent("Text");
    ui.tranAnswer = uiLink:Get("tranAnswer"):GetComponent("RectTransform");
    ui.tranReward = uiLink:Get("tranReward"):GetComponent("RectTransform");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
   
end


local data = {
    bodyPath=""
}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        print("before_awake");
        this.InitUI(vm.behaviour)
        this.answerUIList=UIListView.New(ui.tranAnswer);
        this.rewardUIList=UIListView.New(ui.tranReward);
        this.answerItemObj=vm.behaviour.transform:Find("template/answerItem").gameObject;
        this.rewardItemObj=vm.behaviour.transform:Find("template/rewardItem").gameObject;
        this.spineCharacter=vm.behaviour.transform:Find("root/Middle/tranCharacter/Body"):GetComponent("UISpineCharacter");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>0 then
                local queId=vm.behaviour.Params[0];
                RedMgr.Singleton:FrushRedCondition("17313_"..queId);
                this.queRiddle=ConfigMgr.Config.SimulateRiddleMap[queId];
                this.riddleOptionMap=ConfigMgr.Config.SimulateRiddleOptionMap;
                this.SetCharacter();
                this.ParseData();
            end
        end
        
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.answerUIList:Clear();
        this.rewardUIList:Clear();
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Simulate_RiddlesAnsItem")
        UIListView.ClearItem("Simulate_RiddlesRewardItem")
    end
}


this.SetCharacter = function()
    local path = HeroManager.SetCharacterDrawing(this.spineCharacter, "W0176", "W0176001");
    if (path ~= "") then
        this.vm.data.bodyPath = path;
    end
end

this.ParseData=function()
    this.dataRiddleMap=DataMgr.Player.SimulateGame.RiddleMap;

    this.isAnswer=not IsNull(this.dataRiddleMap) and this.dataRiddleMap[this.queRiddle.Id]~=nil;
    ui.txtTitle.text=LuaMgr.GetLangText(this.queRiddle.NameLan)
    ui.txtContent.text=LuaMgr.GetLangText(this.queRiddle.ContentLan)
    this.SetAnswerUIList();
    this.SetRewardUIList();
end

this.SetAnswerUIList=function()
    this.answerUIList:Clear();
    local list={};
    for i,v in ipairs(this.queRiddle.Option) do
        local ansItem={
            index=i,
            optionId=v,
            info=LuaMgr.GetLangText(this.riddleOptionMap[v].ContentLan);
            isSuccess=false;
            isFail=false;
            callBack=this.AnswerCallBack,
        }
        if this.isAnswer then

            ansItem.isSuccess=v==this.queRiddle.Answer;
        end
        local ansData=UIListData.GetData(this.answerItemObj,"Simulate_RiddlesAnsItem",ansItem);
        table.insert(list,ansData);
    end
    this.answerUIList:SetData(list);
end


this.AnswerCallBack=function(index)
    if UnityEngine.Time.realtimeSinceStartup-this.lastClickTime>this.clickInterval then
        this.lastClickTime=UnityEngine.Time.realtimeSinceStartup;

        if this.isAnswer then return end;
        if this.queRiddle.Option[index]==this.queRiddle.Answer then
            this.isAnswer=true;
        end
        for i,v in ipairs(this.answerUIList.itemList) do
            if i==index then
                if this.isAnswer then
                    v.data.isSuccess=true;
                    v:SetIsSuccess(true);
                end
            end
        end
        if this.isAnswer then
            SimulateRoomMgr.OnAskOnAskBlessingRiddle(this.queRiddle.Id,function()
                this.ParseData();
            end)
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("29412"));
        end
    end
end

this.SetRewardUIList=function()
    this.rewardUIList:Clear();
    local list={}
    for i,v in ipairs(this.queRiddle.Reward) do
        local item={
            item=v,
            isPass=this.isAnswer
        }
        local itemData=UIListData.GetData(this.rewardItemObj,"Simulate_RiddlesRewardItem",item);
        table.insert(list,itemData);
    end
    this.rewardUIList:SetData(list);
end

return vm({
    data = data,
    command = command,
    hook = hook
})