




require("ViewModel/BattlePrepare/BattlePrepareSuspend_HeadItem")
local this = {
    vm = nil;
    headItemObj=nil,
    scrollViewUIList=nil,
};
local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local scrollView = nil;
local tranContent = nil;
local toggleAgain = nil;
local btnConfrim = nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    scrollView = uiLink:Get("ScrollView");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    toggleAgain = uiLink:Get("toggleAgain"):GetComponent("Toggle");
    btnConfrim = uiLink:Get("btnConfrim"):GetComponent("Button");
    uiLink:AddClickEvent("btnConfrim",this.BtnComfrimCommand)
end

this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    scrollView = nil;
    tranContent = nil;
    toggleAgain = nil;
    btnConfrim = nil;
end

this.BtnComfrimCommand=function()
    LuaMgr.HidePanel(UIName.AreaSqualSuspendTipViewModel);
end


local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        this.headItemObj=vm.behaviour.transform:Find("template/headItem").gameObject;
        this.scrollViewUIList=UIListView.New(tranContent);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params== nil) then return  end
        local suspendList=vm.behaviour.Params[0];
        this.ParseData(suspendList);
    end,
    
    before_deactive = function(vm)
        if (vm.behaviour.Params== nil) then return  end
        if toggleAgain.isOn then
            local key=DataMgr.Player.uid.."MOREMODE_SUSPEND"
            UnityEngine.PlayerPrefs.SetInt(key,1);
        end
    end,

    before_destroy = function(vm)
      this.Clear()
        UIScrollView.ClearItem("BattlePrepareSuspend_HeadItem")
    end,
}


this.ParseData=function(characterList)
    local dataList={}
    for i,v in ipairs(characterList) do
        local skinId=nil;
        if DataMgr.Player.characters[v]~=nil then
            skinId=DataMgr.Player.characters[v].curSkin;
        elseif DataMgr.Player.moreModAssist[v]~=nil then
            skinId=DataMgr.Player.moreModAssist[v].character.curSkin
        end

        local ch=ConfigMgr.Config.characterTable[v];
        local headItem={
            icon = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(v,skinId)),
            rare = LuaMgr.GetSprite("AreaMapRes","ui_dzr_tx"..ch.rare),
            name = LuaMgr.GetLangText(ch.namelan)
        }
        local headData=UIListData.GetData(this.headItemObj,"BattlePrepareSuspend_HeadItem",headItem);
        table.insert(dataList,headData)

    end
    this.scrollViewUIList:SetData(dataList,true);
    
end



return vm({
    data = data,
    command = command,
    hook = hook
})