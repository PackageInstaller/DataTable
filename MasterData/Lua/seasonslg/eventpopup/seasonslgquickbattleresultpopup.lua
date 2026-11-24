local this = {
};

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.goWinRight = uiLink:Get("goWinRight");
    ui.goLoseRight = uiLink:Get("goLoseRight");
    ui.goWinLeft = uiLink:Get("goWinLeft");
    ui.goLoseLeft = uiLink:Get("goLoseLeft");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.imgResult = uiLink:Get("imgResult"):GetComponent("Image");
    ui.text = uiLink:Get("text"):GetComponent("Text");
    ui.txtRightPower = uiLink:Get("txtRightPower"):GetComponent("Text");
    ui.txtLeftPower = uiLink:Get("txtLeftPower"):GetComponent("Text");
    ui.txtResult = uiLink:Get("txtResult"):GetComponent("Text");
    ui.uispinecharacterRight = uiLink:Get("uispinecharacterRight"):GetComponent("UISpineCharacter");
    ui.uispinecharacterLeft = uiLink:Get("uispinecharacterLeft"):GetComponent("UISpineCharacter");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        this.Back()
    end)
end

local data = {}

local command = {}

local desc =
{
    ["0"] = "LangGlobalLan_LangGlobal_name_34229",
    ["1"] = "LangGlobalLan_LangGlobal_name_34230",
    ["2"] = "LangGlobalLan_LangGlobal_name_34231",
    ["3"] = "LangGlobalLan_LangGlobal_name_34232",
}

this.rewardDesc =
{
    ["0"] = "LangGlobalLan_LangGlobal_name_34234",
    ["1"] = "LangGlobalLan_LangGlobal_name_34235",
    ["2"] = "LangGlobalLan_LangGlobal_name_34236",
    ["3"] = "LangGlobalLan_LangGlobal_name_34237",
}








local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour)
        ui.leftImage = ui.uispinecharacterLeft:GetComponent("RawImage")
        ui.rightImage = ui.uispinecharacterRight:GetComponent("RawImage")
    end,
    before_active = function(vm)
        this.isBacked = false
        if SeasonSLGMapMgr.Constants().SeasonalBattleWindow ~= nil then
            this.autoBackDelay = SeasonSLGMapMgr.Constants().SeasonalBattleWindow
        end
        this.resultData = nil
        this.StartAutoBackTimer()
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length >= 1 then
            this.resultData = vm.behaviour.Params[0]
            this.SetViewInfo()
        end
    end,
    before_deactive = function(vm)
        this.ClearSpine()
        if (vm.behaviour.Params == nil) then return end
    end,
    before_destroy = function()
        this.ClearSpine()
        this.StopAutoBackTimer()
    end
}

this.ClearSpine = function()
    if ui.uispinecharacterLeft then
        ui.uispinecharacterLeft:Clear()
    end
    if ui.uispinecharacterRight then
        ui.uispinecharacterRight:Clear()
    end
end

this.SetViewInfo = function()

    ui.imgResult.sprite = LuaMgr.GetSprite(SeasonSLGConst.SeasonSLGAtlas, "sjz-zlfy-gzjm-sdtc-jg-" .. tostring(this.resultData.result));
    ui.txtResult.text = LuaMgr.GetLangText(desc[tostring(this.resultData.result)])


    local skin=DataHelper.GetCurPlayerSKin();
    if IsNullOrEmpty(skin) then
        skin="SCJ201";
    end
    if string.match(skin,"SCJ") then
        local ids=NumTool.split(skin,"J");
        if #ids>1 then
            if ids[2]%2==0 then
                skin="SCJ202"
            else
                skin="SCJ201"
            end
        end
    end
    local spineSkinId=skin.."001"
        local renderTex=ui.uispinecharacterLeft:SetBattle2(skin,spineSkinId,"-1",0);
        if renderTex~=nil then
            ui.uispinecharacterLeft:Play("idle", true, nil)
        end

    ui.txtLeftPower.text = tostring(this.resultData.leftPower)
    SetActive(ui.goWinLeft,this.resultData.result > 0)



    local misinterId = this.resultData.DungeonIcon
        local renderTex=ui.uispinecharacterRight:SetBattle2(misinterId,misinterId.."001","-1",0);
        if renderTex~=nil then
            ui.uispinecharacterRight:Play("idle", true, nil)
        end

    ui.txtRightPower.text = tostring(this.resultData.rightPower)
    SetActive(ui.goWinRight,this.resultData.result == 0)
end


this.autoBackDelay = 5

this.StartAutoBackTimer = function()
    this.StopAutoBackTimer()
    LuaMgr.AddTimer(TimerConst.SeasonSLGQuickBattleResultAutoClose, this.Back, this.autoBackDelay, 1, false)
end

this.StopAutoBackTimer = function()
    LuaMgr.RemoveTimer(TimerConst.SeasonSLGQuickBattleResultAutoClose)
end

this.Back = function()
    if this.isBacked then
        return
    end
    this.isBacked = true
    this.StopAutoBackTimer()
    LuaMgr.HidePanel(UIName.SeasonSlGQuickBattleResultPopup);
    if this.resultData ~= nil and this.resultData.reward ~= nil then
        SeasonSLGMapMgr.CheckShowRewardsNew(this.resultData.reward,LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_34233"),LuaMgr.GetLangText(this.rewardDesc[tostring(this.resultData.result)]))
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})