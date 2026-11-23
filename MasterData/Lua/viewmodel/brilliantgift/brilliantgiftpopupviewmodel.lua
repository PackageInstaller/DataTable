




require("ViewModel/BrilliantGift/BrilliantGiftPopUp_RewardItem")
local this = {vm=nil,
              rewardUIList={},
              rewardItemObj=nil,
              animator=nil,
              typeCallBack=nil,
};

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local btnMask = nil;
local btnReward = nil;
local btnJump = nil;
local tranOffset = nil;
local tranContent = nil;
local txtTitle = nil;
local txtContent = nil;
local ScrollView = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    btnReward = uiLink:Get("btnReward"):GetComponent("Button");
    btnJump = uiLink:Get("btnJump"):GetComponent("Button");
    tranOffset = uiLink:Get("tranOffset"):GetComponent("RectTransform");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    txtContent = uiLink:Get("txtContent"):GetComponent("Text");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    this.AddRigister(uiLink);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    btnMask = nil;
    btnReward = nil;
    btnJump = nil;
    tranOffset = nil;
    tranContent = nil;
    txtTitle = nil;
    txtContent = nil;
    ScrollView = nil;

end




this.AddRigister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.BrilliantGiftPopUpViewModel)
    end)
    uiLink:AddClickEvent("btnReward",function()
        DataExHelper.EX_GetAward(this.cfgQuest[1].id,function()
            this.ParseData();
            HeroRedDataHelper.SetBrilliantGiftRed();
            RedMgr.Singleton:Refresh();
        end)
    end)
    uiLink:AddClickEvent("btnJump",function()
        LuaMgr.HidePanel(UIName.BrilliantGiftPopUpViewModel)
        if this.type==0 then
            LuaMgr.ShowLuaPanel(UIName.BrilliantGiftViewModel);
        else
            if this.typeCallBack~=nil then
                this.typeCallBack();
            end
        end
    end)
end


local data={}

local command = {

}


local hook = {
    before_awake = function(vm)
        this.vm=vm;
        print("before_awake");
        this.Init(vm.behaviour)
        this.rewardUIList=UIListView.New(tranContent);
        this.rewardItemObj= vm.behaviour.transform:Find("template/rewardItem").gameObject;
        this.animator=vm.behaviour.transform:Find("root"):GetComponent("Animator");
       
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>0 then
            this.type=1;
            this.typeCallBack=vm.behaviour.Params[0];
            SetActive(btnMask.gameObject,false)
            tranOffset.anchoredPosition =Vector2(136,7);
            this.animator:Play("ani_BrilliantGiftPop_root1",0,0)
        else
            this.type=0;
            SetActive(btnMask.gameObject,true)
            tranOffset.anchoredPosition =Vector2(0,0);
            this.animator:Play("ani_BrilliantGiftPop_root2",0,0)
        end
        this.cfgQuest=DataExHelper.Check_ConfigQuestEventByText("BrilliantGiftPop")
        this.ParseData();
    end,
   
    before_deactive = function(vm)
        print("before_deactive");
        if (vm.behaviour.Params == nil) then return end
      
    end,
    
    before_destroy=function()
        this.Clear();
        UIListView.ClearItem("BrilliantGiftPopUp_RewardItem")
    end
    
}

this.ParseData=function()
    this.questData=DataMgr.Player.quests;
    txtTitle.text=ConfigMgr.LangGlobal("22615");
    txtContent.text=ConfigMgr.LangGlobal("22616");
    if this.cfgQuest==nil or #this.cfgQuest==0 then return end;
    local state=this.questData[this.cfgQuest[1].id]~=nil and this.questData[this.cfgQuest[1].id].state or 1;
    SetActive(btnReward.gameObject,state==2);
    SetActive(btnJump.gameObject,state==3);
    this.SetRewardList(state);
end

this.SetRewardList=function(state)
    if IsNull(this.cfgQuest[1].reward) then return end;
    local list={}
    for i,v in ipairs(this.cfgQuest[1].reward) do
        local rewardItem={
            reward=v,
            isDone=state==3
        }
        local rewardData=UIListData.GetData(this.rewardItemObj,"BrilliantGiftPopUp_RewardItem",rewardItem);
        table.insert(list,rewardData);
    end
    this.rewardUIList:SetData(list);
end

return vm({
    data = data,
    command = command,
    hook = hook
})