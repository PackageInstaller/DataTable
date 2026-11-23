local this = {
    vm = nil,
    members={};
    spineCharacter="";
    resultType=nil;
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
    ui.goSucces = uiLink:Get("goSucces");
    ui.goFail = uiLink:Get("goFail");
    ui.tranCharacter = uiLink:Get("tranCharacter"):GetComponent("RectTransform");
    ui.tranMsg = uiLink:Get("tranMsg"):GetComponent("RectTransform");
    ui.tranResult = uiLink:Get("tranResult"):GetComponent("RectTransform");
    ui.btnSucInfo = uiLink:Get("btnSucInfo"):GetComponent("Button");
    ui.btnFailInfo = uiLink:Get("btnFailInfo"):GetComponent("Button");
    ui.btnConform = uiLink:Get("btnConform"):GetComponent("Button");
    ui.txtInfo = uiLink:Get("txtInfo"):GetComponent("Text");
    ui.txtCount = uiLink:Get("txtCount"):GetComponent("Text");
    ui.rawIcon = uiLink:Get("rawIcon"):GetComponent("RawImage");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnSucInfo",function()
        this.ShowBattleDetail()
    end)
    uiLink:AddClickEvent("btnFailInfo",function()
        this.ShowBattleDetail()
    end)
    uiLink:AddClickEvent("btnConform",this.ExitBattle)
end

this.ShowBattleDetail=function()
    local  jsonData=LuaMgr.GetReportDataForBattleWin();
    if not IsNullOrEmpty(jsonData) then
        LuaMgr.ShowLuaPanel(UIName.BattleDetailViewModel,jsonData);
    end
end

this.ExitBattle=function()
    RogueExploreMgr.UpdateHandlerList();
    RogueExploreMgr.isBattleContinue=true;
    LuaMgr.ExitBattle(this.resultType);
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
        this.spineCharacter=vm.behaviour.transform:Find("root/Left/tranCharacter/Body"):GetComponent("UISpineCharacter")
        
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.resultType=tonumber(vm.behaviour.Params[0])
            local jsonMember=tostring(vm.behaviour.Params[1])
            this.members={};
            local membersTable=json.decode(jsonMember);
            for i,v in pairs(membersTable) do
                table.insert(this.members,v);
            end
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        if (vm.behaviour.Params ~= nil) then
            BattlePrepareMgr.Clear();
        end
    end,
    before_destroy = function()
        this.ClearUI()
    end
}

this.ParseData=function()









    this.SetCharacter();
    SetActive(ui.goSucces,this.resultType>0)
    SetActive(ui.goFail,this.resultType==0)
end

this.SetCharacter=function()
    ui.rawIcon.texture=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath("5133"));
    ui.txtCount.text=DataMgr.Player.Rogue.Oxygen;
    if #this.members==0 then
        return;
    end
    math.randomseed(LuaMgr.Timestamp());
    local index=math.random(1,#this.members)
    local characterId=this.members[index];
    local skinId=characterId.."001";
    local path = HeroManager.SetCharacterDrawing(this.spineCharacter, characterId,skinId);
    if (path ~= "") then
        this.vm.data.bodyPath = path;
    end
    local msgType=nil;
    if this.resultType>0 then
        msgType=index%2==0 and CharacterMsgType.VictoryLine_1 or CharacterMsgType.VictoryLine_2
    else
        msgType=index%2==0 and CharacterMsgType.LoseLine_1 or CharacterMsgType.LoseLine_2
    end
    this.characterMsgVM = LuaMgr.LoadCharacterMsgViewModel(this.characterMsgVM,ui.tranMsg,characterId,msgType, nil);
end

return vm({
    data = data,
    command = command,
    hook = hook
})