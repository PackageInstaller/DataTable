require("ViewModel/FoodCompose/FoodComposeMgr")
require("ViewModel/FoodCompose/FoodComposeCharacterMgr")
require("ViewModel/FoodCompose/FoodComposeItem")
require("ViewModel/FoodCompose/FoodComposeCharacterItem")
require("ViewModel/FoodCompose/FoodComposeCharacterFoodItem")
require("ViewModel/FoodCompose/FoodComposeFoodItem")
require("ViewModel/FoodCompose/FoodComposeFoodMgr")

local this = {
    
}

local objs = {
    middleTF = { path = "root/Middle", type = "RectTransform" },
    foodItem = { path = "template/FoodItem", type = "GameObject" },
    foodsTF = { path = "root/Middle/Foods", type = "RectTransform" },
    dragFoodTF = { path = "root/Middle/Foods/DragFood", type = "RectTransform" },
    dragFoodImg = { path = "root/Middle/Foods/DragFood", type = "RawImage" },
    characterItem = { path = "template/CharacterItem", type = "GameObject" },
    charactersTF = { path = "root/Middle/Characters", type = "Transform" },
    characterFoodItem = { path = "template/CharacterFoodItem", type = "GameObject" },
    flyFoodItem = { path = "template/FlyFoodItem", type = "GameObject" },
    timeAnimator = { path = "root/Left/Info/Time", type = "Animator" },
    time = { path = "root/Left/Info/Time/Text", type = "Text" },
    serveNum = { path = "root/Left/Info/ServeNum/Text", type = "Text" },
    cleanBtn = { path = "root/Left/Clean", type = "Button" },
    putFoodBtn = { path = "root/Left/PutFood", type = "Button" },
    pauseBtn = { path = "root/Left/Pause", type = "Button" },
    foodBookBtn = { path = "root/Right/FoodBook", type = "Button" },
    startGameGO = { path = "root/Right/StartGame", type = "GameObject" },
    startGameBtn = { path = "root/Right/StartGame", type = "Button" },
    txtTip={ path = "root/Right/txtTip", type = "Text" },
}


this.OnBack = function()
    if (FoodComposeMgr.IsOpen() and FoodComposeMgr.GameEndTime() > 0) then
        FoodComposeMgr.Stop();
        local msg = LuaMgr.GetLangText("FoodComposeViewModel_0");
        LuaMgr.ShowLuaPanel(UIName.FoodComposeConfirmViewModel, msg, FoodComposeMgr.Result, FoodComposeMgr.Play);
    else
        LuaMgr.Back();
    end
end


this.SetData = function()
    FoodComposeCharacterMgr.Init(this.characterItem, this.charactersTF, this.characterFoodItem, this.SetServeNum);
    FoodComposeCharacterMgr.Show();
    FoodComposeMgr.InitFoods();
    FoodComposeMgr.GenFoodDatas();
    FoodComposeMgr.Init(this.foodItem, this.foodsTF, this.dragFoodTF, this.dragFoodImg, this.SetTime);
    FoodComposeMgr.Show();
    FoodComposeFoodMgr.Init(this.flyFoodItem, this.middleTF);
    this.SetTime();
    this.SetServeNum();
    SetActive(this.startGameGO, true);
    SetActive(this.txtTip.gameObject,true);
end


this.SetTime = function()
    local time = math.ceil(FoodComposeMgr.GameEndTime());
    local h, m, s = GetTimeHMS(time);
    this.time.text = string.format("%s:%s", m, s);
    local playLimit = ConfigMgr.Config.MixConstants.PlayLimit;
    this.timeAnimator.enabled = playLimit >= time;
end


this.SetServeNum = function()
    local num = FoodComposeCharacterMgr.GetServeNum();
    this.serveNum.text = string.format(LuaMgr.GetLangText("FoodComposeViewModel_1"), num);
    this.txtTip.text=ConfigMgr.LangGlobal("23666");
end


this.SetCharacters = function()
    this.characterList:Clear(false);
    local listData;
    local listDatas = {};
    local len = #this.characterDatas;
    for i = 1, len do
        listData = UIListData.GetData(this.characterItem, "FoodComposeCharacterItem", {id=this.characterDatas[i], index=i});
        table.insert(listDatas, listData);
    end
    this.characterList:SetData(listDatas, true);
end


this.OnClickClean = function()
    if (FoodComposeMgr.IsOpen() and FoodComposeMgr.GameEndTime() > 0) then
        FoodComposeMgr.Stop();
        local msg = LuaMgr.GetLangText("FoodComposeViewModel_2");
        LuaMgr.ShowLuaPanel(UIName.FoodComposeConfirmViewModel, msg, FoodComposeMgr.ClearFoods, nil);
    end
end


this.OnClickPutFood = function()
    if (FoodComposeMgr.IsOpen() and FoodComposeMgr.GameEndTime() > 0) then
        FoodComposeMgr.GenFoodDatas();
        FoodComposeMgr.SetFoods(true);
    end
end


this.OnClickPause = function()
    if (FoodComposeMgr.IsOpen() and FoodComposeMgr.GameEndTime() > 0) then
        FoodComposeMgr.Pause();
    end
end


this.OnClickFoodBook = function()
    if (FoodComposeMgr.GameEndTime() > 0) then
        FoodComposeMgr.Stop();
    end
    LuaMgr.ShowLuaPanel(UIName.FoodComposeBookViewModel);
end


this.OnClickStartGame = function()
    local maxCount = DataMgr.Player.MixGame.Challenge or 0
    if maxCount == 0 then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7501")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    SetActive(this.startGameGO, false);
    SetActive(this.txtTip.gameObject,false);
    FoodComposeMgr.ShowFoods();
    LuaMgr.ShowLuaPanel(UIName.FoodComposePauseViewModel, 0, FoodComposeCharacterMgr.SetCharacterInfo);
end


this.OnRestart = function()
    FoodComposeMgr.Clear();
    FoodComposeCharacterMgr.Clear();
    FoodComposeFoodMgr.Clear();
    FoodComposeCharacterMgr.Show();
    FoodComposeMgr.GenFoodDatas();
    FoodComposeMgr.Show();
    this.SetTime();
    this.SetServeNum();
    SetActive(this.startGameGO, false);
    SetActive(this.txtTip.gameObject,false);
    FoodComposeMgr.ShowFoods();
    LuaMgr.ShowLuaPanel(UIName.FoodComposePauseViewModel, 0, FoodComposeCharacterMgr.SetCharacterInfo);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        RedMgr.Singleton:RegisterViewModel(UIName.FoodComposeViewModel)
        local redID = "15027"
        RedMgr.Singleton:FrushRedCondition(redID)
        RedMgr.Singleton:UpdateClientRedData(redID, 0)
        LuaMgr.AddClick(this.cleanBtn, this.OnClickClean);
        LuaMgr.AddClick(this.putFoodBtn, this.OnClickPutFood);
        LuaMgr.AddClick(this.pauseBtn, this.OnClickPause);
        LuaMgr.AddClick(this.foodBookBtn, this.OnClickFoodBook);
        LuaMgr.AddClick(this.startGameBtn, this.OnClickStartGame);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        vm.behaviour:UpdateTopBar("", this.OnBack);
        LuaMgr.AddUIEventListener(UIEventConst.FoodComposeRestart, this.OnRestart);
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.FoodComposeRestart, this.OnRestart);
        FoodComposeMgr.Clear();
        FoodComposeCharacterMgr.Clear();
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.cleanBtn, this.OnClickClean);
        LuaMgr.RemoveClick(this.putFoodBtn, this.OnClickPutFood);
        LuaMgr.RemoveClick(this.pauseBtn, this.OnClickPause);
        LuaMgr.RemoveClick(this.foodBookBtn, this.OnClickFoodBook);
        LuaMgr.RemoveClick(this.startGameBtn, this.OnClickStartGame);
        FoodComposeMgr.Destroy();
        FoodComposeCharacterMgr.Destroy();
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})