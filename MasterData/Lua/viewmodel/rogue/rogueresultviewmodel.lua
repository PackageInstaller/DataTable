require("ViewModel/Rogue/Rogue_ResultBuffItem")
require("ViewModel/Rogue/Rogue_ResultHeadItem")
local this = {
    vm = nil,
    heroUIList={};
    heroItemObj=nil;
    buffUIList={},
    buffItemObj=nil,
};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.goPanel1 = uiLink:Get("goPanel1");
    ui.goPanel2 = uiLink:Get("goPanel2");
    ui.goInfo = uiLink:Get("goInfo");
    ui.goDetail = uiLink:Get("goDetail");
    ui.goStar5132 = uiLink:Get("goStar5132");
    ui.goBallast5135 = uiLink:Get("goBallast5135");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.btnNext = uiLink:Get("btnNext"):GetComponent("Button");
    ui.btnDetail = uiLink:Get("btnDetail"):GetComponent("Button");
    ui.btnExit = uiLink:Get("btnExit"):GetComponent("Button");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranHeroContent = uiLink:Get("tranHeroContent"):GetComponent("RectTransform");
    ui.tranBuffContent = uiLink:Get("tranBuffContent"):GetComponent("RectTransform");
    ui.txtExploreCount = uiLink:Get("txtExploreCount"):GetComponent("Text");
    ui.txtCharacterCount = uiLink:Get("txtCharacterCount"):GetComponent("Text");
    ui.txtBattleWinCount = uiLink:Get("txtBattleWinCount"):GetComponent("Text");
    ui.txtBuffCount = uiLink:Get("txtBuffCount"):GetComponent("Text");
    ui.txtStepCount = uiLink:Get("txtStepCount"):GetComponent("Text");
    ui.txtScore = uiLink:Get("txtScore"):GetComponent("Text");
    ui.txtStar5132 = uiLink:Get("txtStar5132"):GetComponent("Text");
    ui.txtStar5134 = uiLink:Get("txtStar5134"):GetComponent("Text");
    ui.txtBallast5135 = uiLink:Get("txtBallast5135"):GetComponent("Text");
    ui.rawScore = uiLink:Get("rawScore"):GetComponent("RawImage");
    ui.rawStar5132 = uiLink:Get("rawStar5132"):GetComponent("RawImage");
    ui.rawStar5134 = uiLink:Get("rawStar5134"):GetComponent("RawImage");
    ui.rawBallast5135 = uiLink:Get("rawBallast5135"):GetComponent("RawImage");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnExit",function()
        LuaMgr.HidePanel(UIName.RogueResultViewModel)
        if this.callBack~=nil then
            this.callBack();
        end
    end)
    uiLink:AddClickEvent("btnNext",function()
        this.SetPanel2Info();
    end)
    uiLink:AddClickEvent("btnDetail",function()
        if ui.goDetail.activeSelf then
            this.SetPanel2Info();
        else
            this.SetDetailInfo();
        end
    end)
end


local data = {
    bodyPath="";
}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        print("before_awake");
        this.InitUI(vm.behaviour)
        this.heroUIList=UIListView.New(ui.tranHeroContent);
        this.buffUIList=UIListView.New(ui.tranBuffContent);
        this.buffItemObj= vm.behaviour.transform:Find("template/buffItem").gameObject
        this.heroItemObj= vm.behaviour.transform:Find("template/headItem").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>0 then
                this.callBack=vm.behaviour.Params[0]
                SetActive(ui.goPanel1,true);
                SetActive(ui.goPanel2,false);
                SetActive(ui.goDetail,false);
                this.ParseData();
            end
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.heroUIList:Clear();
        this.buffUIList:Clear();
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Rogue_ResultHeadItem")
        UIListView.ClearItem("Rogue_ResultBuffItem")
    end
}

this.ParseData=function()
    this.heroIdList={};
    this.buffIdList={}
    if not IsNull(DataMgr.Player.Rogue.BuffIds) then
        this.buffIdList=DataMgr.Player.Rogue.BuffIds;
    end
    if not IsNull(DataMgr.Player.RogueMembers) then
        for i,v in pairs(DataMgr.Player.RogueMembers) do
            table.insert(this.heroIdList,v)
        end
    end
end


this.SetPanel2Info=function()
    SetActive(ui.goPanel2,true);
    SetActive(ui.goPanel1,false);
    SetActive(ui.goInfo,true);
    SetActive(ui.goDetail,false);
    this.SetHeroList();
    this.SetBuffList();
    ui.txtScore.text=DataMgr.Player.Rogue.Score
    ui.rawStar5134.texture=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath("5134"))
    ui.txtStar5134.text=DataMgr.Player.Rogue.StarKey
    
    SetActive(ui.goStar5132,RogueExploreMgr.exploreTheme==1)
    SetActive(ui.goBallast5135,RogueExploreMgr.exploreTheme==2)
    if RogueExploreMgr.exploreTheme==1 then
        ui.rawStar5132.texture=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath("5132"))
        ui.txtStar5132.text=DataMgr.Player.Rogue.StarDust
    else
        ui.rawBallast5135.texture=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath("5135"))
        ui.txtBallast5135.text=DataMgr.Player.Rogue.Ballast
    end
end

this.SetDetailInfo=function()
    SetActive(ui.goPanel2,true);
    SetActive(ui.goPanel1,false);
    SetActive(ui.goInfo,false);
    SetActive(ui.goDetail,true);
    ui.txtExploreCount.text=RogueExploreMgr.GetExploreCount();
    if not IsNull(DataMgr.Player.Rogue.Characters) then
        ui.txtCharacterCount.text=NumTool.GetLen(DataMgr.Player.Rogue.Characters)
    else
        ui.txtCharacterCount.text="0";
    end
    ui.txtBattleWinCount.text=DataMgr.Player.Rogue.BattleSuccess;
    ui.txtBuffCount.text=#this.buffIdList;
    ui.txtStepCount.text=DataMgr.Player.Rogue.Oxygen;
end

this.SetHeroList=function()
    this.heroUIList:Clear();
    local list={}
    for i,v in ipairs(this.heroIdList) do
        local cfgHero=ConfigMgr.Config.characterTable[v];
        local heroItem={
            rare=cfgHero.rare;
            job=cfgHero.job;
            id=cfgHero.id;
            level="100";
        }
        local heroData=UIListData.GetData(this.heroItemObj,"Rogue_ResultHeadItem",heroItem);
        table.insert(list,heroData);
    end
    this.heroUIList:SetData(list);
end

this.SetBuffList=function()
    this.buffUIList:Clear();
    local list={}
    for i,v in ipairs(this.buffIdList) do
        local buffInfo=ConfigMgr.Config.RogueBuffDescMap[v];
        if buffInfo~=nil then
            local buffItem={
                rare=buffInfo.BuffQuality,
                icon=buffInfo.BuffIcon,
            }
            local buffData=UIListData.GetData(this.buffItemObj,"Rogue_ResultBuffItem",buffItem);
            table.insert(list,buffData);
        else
            LuaDebug.error("buffId not config:"..v);
        end
    end
    this.buffUIList:SetData(list);
end


return vm({
    data = data,
    command = command,
    hook = hook
})