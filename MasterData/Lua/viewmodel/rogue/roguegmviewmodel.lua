
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
    ui.btnAddAllBuff = uiLink:Get("btnAddAllBuff"):GetComponent("Button");
    ui.btnAddBuff = uiLink:Get("btnAddBuff"):GetComponent("Button");
    ui.btnAddAllHero = uiLink:Get("btnAddAllHero"):GetComponent("Button");
    ui.btnAddHero = uiLink:Get("btnAddHero"):GetComponent("Button");
    ui.btnChangeItem = uiLink:Get("btnChangeItem"):GetComponent("Button");
    ui.btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    ui.inputAddBuff = uiLink:Get("inputAddBuff"):GetComponent("InputField");
    ui.inputAddHero = uiLink:Get("inputAddHero"):GetComponent("InputField");
    ui.inputChangeItem = uiLink:Get("inputChangeItem"):GetComponent("InputField");
    ui.inputChangeCount = uiLink:Get("inputChangeCount"):GetComponent("InputField");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnAddAllBuff",function()
       RogueMgr.GMAddBuff(nil,function()
           LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("RogueGMViewModel_0"))
       end)
    end)
    uiLink:AddClickEvent("btnAddBuff",function()
        local buffId=ui.inputAddBuff.text;
        if not IsNullOrEmpty(buffId) then
            RogueMgr.GMAddBuff(buffId,function()
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("RogueGMViewModel_1"))
            end)
        end
    end)
    uiLink:AddClickEvent("btnAddAllHero",function()
        RogueMgr.GMAddCharacter(nil,function()
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("RogueGMViewModel_2"))
        end)
    end)
    uiLink:AddClickEvent("btnAddHero",function()
        local characterId=ui.inputAddHero.text;
        if not IsNullOrEmpty(characterId) then
            RogueMgr.GMAddBuff(characterId,function()
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("RogueGMViewModel_3"))
            end)
        end
    end)
    uiLink:AddClickEvent("btnChangeItem",function()
        local itemID=ui.inputChangeItem.text;
        local count=ui.inputChangeCount.text;
        if not IsNullOrEmpty(itemID) and not IsNullOrEmpty(count) then
            RogueMgr.GMChangeItems(itemID,count,function()
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("RogueGMViewModel_4"))
            end)
        end
    end)
    uiLink:AddClickEvent("btnClose",function()
       LuaMgr.HidePanel(UIName.RogueGMViewModel);
    end)
end


local data = {

}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        RedMgr.Singleton:RegisterViewModel(UIName.KZRYExploreViewModel);
        print("before_awake");
        this.InitUI(vm.behaviour)
      
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>1 then
                this.buffId=vm.behaviour.Params[0];
                this.callBack=vm.behaviour.Params[1];
                this.ParseData();
            end
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        if this.callBack~=nil then
            this.callBack();
        end
    end,
    before_destroy = function()
        this.ClearUI()
    end
}

this.ParseData=function()
    local cfgBuffDes=ConfigMgr.Config.RogueBuffDescMap[this.buffId]
    if cfgBuffDes==nil then 
        LuaDebug.error("cfgBuffDes is nil");
        return
    end;
    ui.imgRare.sprite=LuaMgr.GetSprite("Rogue","ui_xhyt_csqzxbfd_0"..cfgBuffDes.BuffQuality);
    ui.imgIcon.sprite=LuaMgr.GetSprite("BuffIcon",cfgBuffDes.BuffIcon);
    ui.txtName.text=LuaMgr.GetLangText(cfgBuffDes.BuffNameLan);
    ui.txtDes.text=LuaMgr.GetLangText(cfgBuffDes.BuffDesLan);
end

return vm({
    data = data,
    command = command,
    hook = hook
})