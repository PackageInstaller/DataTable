require("Voyage/VoyageRichManShip")
require("Voyage/VoyageRichManGrid")
require("Voyage/VoyageRichManEvent")
require("Voyage/VoyageRichManCharacterItem")
require("Voyage/VoyageRichManArrow")

local this = {
    isRollDice = false,
    isSelectDice = false,
    characterList = nil,
    startAniName = "UI_VoyageRichManPanel_01",
    isDungeon = false,
    characterSizeDelta = Vector2(150, 0),
};

local objs = {
    animator = { path = "root", type = "UIAnimator" },
    backBtn = { path = "root/Left/Back", type = "Button" },
    captainName = { path = "root/Left/Captain/Name/Text", type = "Text" },
    selectDiceGO = { path = "root/Right/SelectDice", type = "GameObject" },
    selectDiceBtn = { path = "root/Right/SelectDice", type = "Button" },
    selectDiceCooling = { path = "root/Right/SelectDice/Cooling", type = "GameObject" },
    selectDiceCoolingTime = { path = "root/Right/SelectDice/Cooling/Time", type = "Text" },
    selectDiceCount = { path = "root/Right/SelectDice/DiceCount", type = "Text" },
    plusDiceGO = { path = "root/Right/PlusDice", type = "GameObject" },
    plusDiceBtn = { path = "root/Right/PlusDice", type = "Button" },
    plusDiceCooling = { path = "root/Right/PlusDice/Cooling", type = "GameObject" },
    plusDiceCoolingTime = { path = "root/Right/PlusDice/Cooling/Time", type = "Text" },
    plusDiceCount = { path = "root/Right/PlusDice/DiceCount", type = "Text" },
    rollDiceGO = { path = "root/Right/RollDice", type = "GameObject" },
    rollDiceBtn = { path = "root/Right/RollDice", type = "Button" },
    rollDiceImg = { path = "root/Right/RollDice", type = "Image" },
    rollDiceCountImg = { path = "root/Right/RollDice/DiceCount", type = "Image" },
    rollDiceCount = { path = "root/Right/RollDice/DiceCount/Text", type = "Text" },
    rollDiceText = { path = "root/Right/RollDice/RollText", type = "Image" },
    charactersTF = { path = "root/Left/Characters/Viewport/Content", type = "RectTransform" },
    characterItem = { path = "template/CharacterItem", type = "GameObject" },
    receivediceEffect = { path = "root/Right/RollDice/UI_VoyageRichman_receivedice", type = "GameObject" },
    lossdiceEffect = { path = "root/Right/RollDice/UI_VoyageRichman_lossdice", type = "GameObject" },
    chargingcompletedEffect = { path = "root/Right/SelectDice/UI_Voyagerichman_Chargingcompleted", type = "GameObject" },
    chargingcompleted01Effect = { path = "root/Right/PlusDice/UI_Voyagerichman_Chargingcompleted01", type = "GameObject" },
    autoSailBtn = { path = "root/Right/AutoSail", type = "Button" },
    autoSailGroup = { path = "root/Right/AutoSail", type = "CanvasGroup" },
    autoSailAuto = { path = "root/Right/AutoSail/Auto", type = "GameObject" },
    autoSailCancel = { path = "root/Right/AutoSail/Cancel", type = "GameObject" },
    autoSailLock = { path = "root/Right/AutoSail/Lock", type = "GameObject" },
    warehouseBtn = { path = "root/Left/Warehouse", type = "Button" },
    dropBtn = { path = "root/Right/Drop", type = "Button" },
    autoSailTitle = { path = "root/Middle/AutoSailTitle", type = "GameObject" },
    autoSailTitleText = { path = "root/Middle/AutoSailTitle/Text", type = "Text" },
    warehouseAddGoods = { path = "root/Left/Warehouse/eff_gain", type = "GameObject" },
    warehouseGoodsMinus = { path = "root/Left/Warehouse/eff_lost", type = "GameObject" },
    testDice = { path = "root/Right/TestDice", type = "GameObject" },
    testDiceInput = { path = "root/Right/TestDice/Num", type = "InputField" },
    testDiceBtn = { path = "root/Right/TestDice/Click", type = "Button" },
};


this.SetData = function()
    this.captainName.text = ConfigMgr.LangGlobal("10479");
    this.SetDiceCount();
    this.SetSpecialDiceCount();
    this.SelectDiceType(true);
    this.SetCharacters();
    SetActive(this.receivediceEffect, false);
    SetActive(this.lossdiceEffect, false);
    SetActive(this.chargingcompletedEffect, false);
    SetActive(this.chargingcompleted01Effect, false);
    if (not this.isDungeon) then
        VoyageRichManMgr.SetAutoDice(false);
    end
    this.SetAutoSail();
    this.SetWarehouseChange(false, false);
    SetActive(this.testDice, LuaMgr.IsDebug());
end


this.SetDiceCount = function()
    local rollDiceId = PlayerVoyageMgr.GetRollDiceId();
    local diceConfig = ConfigVoyageMgr.GetSailingDice(rollDiceId);
    if (diceConfig ~= nil) then
        if (diceConfig.RollNumber == 3) then
            this.rollDiceImg.sprite = LuaMgr.GetSprite("VoyageRichMan", "ui_hd_hh_hx_button1_di");
            this.rollDiceCountImg.sprite = LuaMgr.GetSprite("VoyageRichMan", "ui_hd_hh_hx_button1_image");
            this.rollDiceText.sprite = LuaMgr.GetSprite("VoyageRichMan", "ui_hd_hh_hx_button1_title");
        elseif (diceConfig.RollNumber == 4) then
            this.rollDiceImg.sprite = LuaMgr.GetSprite("VoyageRichMan", "ui_hd_hh_hx_button2_di");
            this.rollDiceCountImg.sprite = LuaMgr.GetSprite("VoyageRichMan", "ui_hd_hh_hx_button2_image");
            this.rollDiceText.sprite = LuaMgr.GetSprite("VoyageRichMan", "ui_hd_hh_hx_button2_title");
        end
    end
    this.rollDiceCount.text = tostring(PlayerVoyageMgr.GetRollDiceCount());
    SetActive(this.rollDiceGO, true);
end


this.SetSpecialDiceCount = function()
    SetActive(this.selectDiceGO, false);
    SetActive(this.plusDiceGO, false);
    local sailing = DataMgr.Player.Sailing;
    local captainConfig = ConfigVoyageMgr.GetCaptainConfig(sailing.Captain);
    local specialDiceId = PlayerVoyageMgr.GetSpecialDiceId();
    if (specialDiceId == VoyageRichManDiceId.SelectDice) then
        local specialDiceCount = PlayerVoyageMgr.GetDiceCount(specialDiceId);
        this.selectDiceCount.text = tostring(specialDiceCount);
        if (specialDiceCount >= captainConfig.SkillLimit) then
            SetActive(this.selectDiceCooling, false);
        else
            local cd = captainConfig.SkillCD - sailing.RollCount;
            this.selectDiceCoolingTime.text = tostring(cd);
            SetActive(this.selectDiceCooling, true);
        end
        SetActive(this.selectDiceGO, true);
    elseif (specialDiceId == VoyageRichManDiceId.FourDice) then
        local specialDiceCount = PlayerVoyageMgr.GetDiceCount(specialDiceId);
        this.plusDiceCount.text = tostring(specialDiceCount);
        if (specialDiceCount >= captainConfig.SkillLimit) then
            SetActive(this.plusDiceCooling, false);
        else
            local cd = captainConfig.SkillCD - sailing.RollCount;
            this.plusDiceCoolingTime.text = tostring(cd);
            SetActive(this.plusDiceCooling, true);
        end
        SetActive(this.plusDiceGO, true);
    end
end


this.SelectDiceType = function(diceType)
    if (diceType) then
        this.isRollDice = true;
        this.isSelectDice = false;
        LuaMgr.HidePanel(UIName.VoyageRichManDiceViewModel);
    else
        this.isRollDice = false;
        this.isSelectDice = true;
        LuaMgr.ShowLuaPanel(UIName.VoyageRichManDiceViewModel, VoyageRichManDiceType.SelectDice);
    end
end


this.CheckRollDice = function()
    if (not VoyageRichManMgr.IsRollDice()) then

        return true;
    end
    if (VoyageRichManMgr.IsAutoDice()) then

        return true;
    end
    return false;
end


this.SetCharacters = function()
    if (this.characterList == nil) then
        this.characterList = {};
    end
    local item;
    local members = PlayerVoyageMgr.GetMembers();
    local mlen = #members;
    for i = 1, mlen do
        item = this.characterList[i];
        if (item == nil) then
            item = VoyageRichManCharacterItem.New(this.characterItem, this.charactersTF);
            this.characterList[i] = item;
        end
        item:SetData(members[i], i);
    end
    this.characterSizeDelta.y = mlen * 100;
    this.charactersTF.sizeDelta = this.characterSizeDelta;
    this.charactersTF.anchoredPosition = Vector2.zero;
    len = #this.characterList;
    mlen = mlen + 1;
    for i = mlen, len do
        this.characterList[i]:Clear();
    end
end


this.ClearCharacters = function()
    if (this.characterList ~= nil) then
        local len = #this.characterList;
        for i = 1, len do
            this.characterList[i]:Clear();
        end
    end
end


this.DestroyCharacters = function()
    if (this.characterList ~= nil) then
        local len = #this.characterList;
        for i = 1, len do
            this.characterList[i]:Destroy();
        end
        this.characterList = nil;
    end
end


this.OnRefreshCharacters = function()
    local len = #this.characterList;
    for i = 1, len do
        this.characterList[i]:Refresh();
    end
    local list = PlayerVoyageMgr.GetHideMembers();
    len = #list;
    if (len > 0) then
        PlayerVoyageMgr.InitMembers();
        for i = 1, len do
            this.characterList[list[i]]:Hide();
        end
        LuaMgr.AddTimer(TimerConst.VoyageRichManCharacterHideTime, this.OnCharacterHideTime, 0.8, 1, false);
    end
end


this.OnCharacterHideTime = function()
    LuaMgr.RemoveTimer(TimerConst.VoyageRichManCharacterHideTime);
    local len = #this.characterList;
    for i = 1, len do
        this.characterList[i]:Move();
    end
    LuaMgr.AddTimer(TimerConst.VoyageRichManCharacterMoveTime, this.OnCharacterMoveTime, 0.6, 1, false);
end


this.OnCharacterMoveTime = function()
    LuaMgr.RemoveTimer(TimerConst.VoyageRichManCharacterMoveTime);
    this.SetCharacters();
end


this.OnClickBack = function()
    if (VoyageRichManMgr.GetStatus() == VoyageRichManStatus.Success) then return end
    
    if (VoyageRichManMgr.IsRollDice()) then
        LuaMgr.ShowLuaPanel(UIName.VoyageViewModel, false);
    end
end


this.OnClickRollDice = function()
    if (this.CheckRollDice()) then return end
    
    local rollDiceId = PlayerVoyageMgr.GetRollDiceId();
    local count = PlayerVoyageMgr.GetDiceCount(rollDiceId);
    if (count <= 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10456"));
        return;
    end
    if (this.isRollDice) then
        PlayerVoyageMgr.SetRollDiceCount(true);
        PlayerVoyageMgr.RollDice(rollDiceId, 0);
    else
        this.SelectDiceType(true);
    end
end


this.OnClickSelectDice = function()
    if (this.CheckRollDice()) then return end
    
    local specialDiceId = PlayerVoyageMgr.GetSpecialDiceId();
    local count = PlayerVoyageMgr.GetDiceCount(specialDiceId);
    if (count <= 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10456"));
        return;
    end
    this.SelectDiceType(false);
end


this.OnClickPlusDice = function()
    if (this.CheckRollDice()) then return end

    local specialDiceId = PlayerVoyageMgr.GetSpecialDiceId();
    local count = PlayerVoyageMgr.GetDiceCount(specialDiceId);
    if (count <= 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10456"));
        return;
    end
    if (this.isRollDice) then
        PlayerVoyageMgr.RollDice(specialDiceId, 0);
    else
        this.SelectDiceType(true);
    end
end


this.OnClickAutoSail = function()
    local isPortPass = PlayerVoyageMgr.IsPortPass(DataMgr.Player.Sailing.HarborID);
    if (not isPortPass) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10478"));
        return;
    end
    local isAutoDice = VoyageRichManMgr.IsAutoDice();
    VoyageRichManMgr.SetAutoDice(not isAutoDice);
    this.SetAutoSail();
end


this.OnShowDice = function(args)
    if (args.Length <= 0) then
        this.SetDiceCount();
        return;
    end
    local eventType = args[0];
    if (eventType == VoyageEventConst.DiceAdd) then
        PlayerVoyageMgr.SetRollDiceCount(true);
        SetActive(this.receivediceEffect, true);
        VoyageRichManTimeMgr.AddTime(1.6, this.OnDiceAdd);
        return;
    end
    if (eventType == VoyageEventConst.DiceMinus) then
        PlayerVoyageMgr.SetRollDiceCount(true);
        SetActive(this.lossdiceEffect, true);
        VoyageRichManTimeMgr.AddTime(1.6, this.OnDiceMinus);
        return;
    end
end


this.OnShowSpecialDice = function(args)
    if (args.Length <= 0) then
        this.SetSpecialDiceCount();
        return;
    end
    local specialDiceId = PlayerVoyageMgr.GetSpecialDiceId();
    if (specialDiceId == "2") then
        if (this.selectDiceCooling.activeSelf) then
            SetActive(this.chargingcompletedEffect, true);
            VoyageRichManTimeMgr.AddTime(1.6, this.OnChargingcompleted);
        end
    elseif (specialDiceId == "3") then
        if (this.plusDiceCooling.activeSelf) then
            SetActive(this.chargingcompleted01Effect, true);
            VoyageRichManTimeMgr.AddTime(1.6, this.OnChargingcompleted01);
        end
    end
end


this.OnDiceAdd = function()
    SetActive(this.receivediceEffect, false);
    this.SetDiceCount();
end


this.OnDiceMinus = function()
    SetActive(this.lossdiceEffect, false);
    this.SetDiceCount();
end


this.OnChargingcompleted = function()
    SetActive(this.chargingcompletedEffect, false);
    this.SetSpecialDiceCount();
end


this.OnChargingcompleted01 = function()
    SetActive(this.chargingcompleted01Effect, false);
    this.SetSpecialDiceCount();
end


this.OnStart = function()
    this.animator.AnimationName = this.startAniName;
end


this.OnPlayFinish = function(args)
    if (args.Length > 0 and args[0] == this.startAniName) then
        VoyageRichManMgr.InitStatus();
        if (this.isDungeon) then
            VoyageRichManMgr.BattleResult();
            VoyageRichManMgr.CheckGameEnd();
            this.isDungeon = false;
            this.OnRefreshCharacters();
        end
    end
end


this.SetAutoSail = function()
    this.autoSailTitleText.text = ConfigMgr.LangGlobal("10480");
    local isPortPass = PlayerVoyageMgr.IsPortPass(DataMgr.Player.Sailing.HarborID);
    if (isPortPass) then
        local isAutoDice = VoyageRichManMgr.IsAutoDice();
        SetActive(this.autoSailAuto, not isAutoDice);
        SetActive(this.autoSailCancel, isAutoDice);
        SetActive(this.autoSailTitle, isAutoDice);
        SetActive(this.autoSailLock, false);
        this.autoSailGroup.alpha = 1;
    else
        SetActive(this.autoSailAuto, false);
        SetActive(this.autoSailCancel, false);
        SetActive(this.autoSailTitle, false);
        SetActive(this.autoSailLock, true);
        this.autoSailGroup.alpha = 0.7;
    end
end


this.OnClickWarehouse = function()
    if (VoyageRichManMgr.GetStatus() == VoyageRichManStatus.Success) then return end
    
    LuaMgr.ShowLuaPanel(UIName.VoyageRichManWarehouseViewModel);
end


this.OnClickDrop = function()
    if (VoyageRichManMgr.GetStatus() == VoyageRichManStatus.Success) then return end
    if (VoyageRichManMgr.IsRollDice()) then
        VoyageRichManMgr.SetDrop(true);
        LuaMgr.ShowLuaPanel(UIName.VoyageConfirmViewModel, LuaMgr.GetLangText("VoyageRichManViewModel_2"), this.OnConfirmDrop, this.OnCancelDrop);
    end
end


this.OnConfirmDrop = function()
    PlayerVoyageMgr.Drop(this.DropResponse);
end


this.OnCancelDrop = function()
    VoyageRichManMgr.SetDrop(false);
end


this.DropResponse = function()
    LuaMgr.ShowLuaPanel(UIName.VoyageViewModel, false);
end


this.SetWarehouseChange = function(goodsAdd, goodsMinus)
    SetActive(this.warehouseAddGoods, goodsAdd);
    SetActive(this.warehouseGoodsMinus, goodsMinus);
end


this.OnWarehouseChange = function(args)
    local eventType = args[0];
    if (eventType == VoyageEventConst.GoodsAdd) then
        this.SetWarehouseChange(true, false);
    elseif (eventType == VoyageEventConst.GoodsMinus) then
        this.SetWarehouseChange(false, true);
    end
end


this.OnClickTestDice = function()
    if (this.CheckRollDice()) then return end

    local numStr = this.testDiceInput.text;
    if (IsNullOrEmpty(numStr)) then return end
    
    local num = tonumber(numStr);
    if (num > 0) then
        local rollDiceId = PlayerVoyageMgr.GetRollDiceId();
        PlayerVoyageMgr.RollDice(rollDiceId, 0, num);
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.backBtn, this.OnClickBack);
        LuaMgr.AddClick(this.selectDiceBtn, this.OnClickSelectDice);
        LuaMgr.AddClick(this.plusDiceBtn, this.OnClickPlusDice);
        LuaMgr.AddClick(this.rollDiceBtn, this.OnClickRollDice);
        LuaMgr.AddClick(this.autoSailBtn, this.OnClickAutoSail);
        LuaMgr.AddClick(this.warehouseBtn, this.OnClickWarehouse);
        LuaMgr.AddClick(this.dropBtn, this.OnClickDrop);
        LuaMgr.AddClick(this.testDiceBtn, this.OnClickTestDice);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.RemoveNormalPanel(UIName.VoyageSelectCharacterViewModel);
        this.animator.AnimationName = "UI_VoyageRichManPanel_02";
        PlayerVoyageMgr.SetDices();
        LuaMgr.AddUIEventListener(UIEventConst.VoyageRichManShowDice, this.OnShowDice);
        LuaMgr.AddUIEventListener(UIEventConst.VoyageRichManShowSpecialDice, this.OnShowSpecialDice);
        LuaMgr.AddUIEventListener(UIEventConst.VoyageRichManRefreshCharacters, this.OnRefreshCharacters);
        LuaMgr.AddUIEventListener(UIEventConst.VoyageRichManStart, this.OnStart);
        LuaMgr.AddUIEventListener(UIEventConst.VoyageRichManWarehouseChange, this.OnWarehouseChange);
        LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnPlayFinish);
        this.isDungeon = VoyageRichManMgr.IsDungeon();
        if (not this.isDungeon) then
            PlayerVoyageMgr.InitMembers();
        end
        VoyageRichManMgr.Init();
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.VoyageRichManCharacterHideTime);
        LuaMgr.RemoveTimer(TimerConst.VoyageRichManCharacterMoveTime);
        LuaMgr.RemoveUIEventListener(UIEventConst.VoyageRichManShowDice, this.OnShowDice);
        LuaMgr.RemoveUIEventListener(UIEventConst.VoyageRichManShowSpecialDice, this.OnShowSpecialDice);
        LuaMgr.RemoveUIEventListener(UIEventConst.VoyageRichManRefreshCharacters, this.OnRefreshCharacters);
        LuaMgr.RemoveUIEventListener(UIEventConst.VoyageRichManStart, this.OnStart);
        LuaMgr.RemoveUIEventListener(UIEventConst.VoyageRichManWarehouseChange, this.OnWarehouseChange);
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnPlayFinish);
        VoyageRichManMgr.Destroy();
        LuaMgr.HidePanel(UIName.VoyageRichManMopUpViewModel);
        LuaMgr.HidePanel(UIName.VoyageRichManBattleViewModel);
        LuaMgr.HidePanel(UIName.VoyageRichManDiceViewModel);
        LuaMgr.HidePanel(UIName.VoyageRichManEnemyViewModel);
        LuaMgr.HidePanel(UIName.VoyageRichManEventViewModel);
        LuaMgr.HidePanel(UIName.VoyageRichManWarehouseViewModel);
        this.ClearCharacters();
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.backBtn, this.OnClickBack);
        LuaMgr.RemoveClick(this.selectDiceBtn, this.OnClickSelectDice);
        LuaMgr.RemoveClick(this.plusDiceBtn, this.OnClickPlusDice);
        LuaMgr.RemoveClick(this.rollDiceBtn, this.OnClickRollDice);
        LuaMgr.RemoveClick(this.autoSailBtn, this.OnClickAutoSail);
        LuaMgr.RemoveClick(this.warehouseBtn, this.OnClickWarehouse);
        LuaMgr.RemoveClick(this.dropBtn, this.OnClickDrop);
        LuaMgr.RemoveClick(this.testDiceBtn, this.OnClickTestDice);
        this.DestroyCharacters();
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})