require("ViewModel/YPS/YPSGameMgr")
require("ViewModel/YPS/YPSGameCharacterMgr")
require("ViewModel/YPS/YPSGameCharacterItem")
require("ViewModel/YPS/YPSGameCharacterFoodItem")
require("ViewModel/YPS/YPSGameFoodItem")
require("ViewModel/YPS/YPSGameBFoodItem")
require("ViewModel/YPS/YPSGameFinishFoodItem")
require("ViewModel/YPS/YPSGameContainerItem")
require("ViewModel/YPS/YPSGameFlyFoodItem")
require("ViewModel/YPS/YPSGameFoodMgr")

local this = {

}

local objs = {
    middleTF = { path = "root/Middle", type = "RectTransform" },
    foodItem = { path = "template/FoodItem", type = "GameObject" },
    baseFoodItem = { path = "template/BaseFoodItem", type = "GameObject" },
    containerItem = { path = "template/ContainerItem", type = "GameObject" },
    finishFoodItem = { path = "template/FinishFoodItem", type = "GameObject" },
    foodsTF = { path = "root/Middle/Foods", type = "RectTransform" },
    baseFoodsTF = { path = "root/Middle/BaseFoods", type = "RectTransform" },
    containerTF = { path = "root/Middle/Container", type = "RectTransform" },
    finishFoodTF = { path = "root/Left/PrepareBox/FinishFoodBox", type = "RectTransform" },
    characterItem = { path = "template/CharacterItem", type = "GameObject" },
    charactersTF = { path = "root/Middle/Characters", type = "Transform" },
    characterFoodItem = { path = "template/CharacterFoodItem", type = "GameObject" },
    flyFoodItem = { path = "template/FlyFoodItem", type = "GameObject" },
    timeAnimator = { path = "root/Left/Info/Time", type = "Animator" },
    time = { path = "root/Left/Info/Time/Text", type = "Text" },
    serveNum = { path = "root/Left/Info/ServeNum/Text", type = "Text" },
    pauseBtn = { path = "root/Left/Pause", type = "Button" },
    startGameGO = { path = "root/Right/StartGame", type = "GameObject" },
    startGameBtn = { path = "root/Right/StartGame", type = "Button" },
    guideBox = { path = "root/Middle/guideBox", type = "GameObject" },
    txtTip = { path = "root/Right/ImgTip/txtTip", type = "Text" },
    imgTip = { path = "root/Right/ImgTip", type = "GameObject" },
}


this.OnBack = function()
    if (YPSGameMgr.IsOpen() and YPSGameMgr.GameEndTime() > 0) then
        YPSGameMgr.Pause();
    else
        LuaMgr.Back();
    end
end


this.SetData = function()
    YPSGameCharacterMgr.Init(this.characterItem, this.charactersTF, this.characterFoodItem, this.SetServeNum);
    YPSGameCharacterMgr.Show();
    YPSGameMgr.InitFoods();
    YPSGameMgr.GenFoodDatas();
    local itemList = { this.foodItem, this.baseFoodItem, this.containerItem, this.finishFoodItem }
    local tfList = { this.foodsTF, this.baseFoodsTF, this.containerTF, this.finishFoodTF }
    YPSGameMgr.Init(itemList, tfList, this.SetTime);
    YPSGameMgr.Show();
    YPSGameFoodMgr.Init(this.flyFoodItem, this.middleTF);
    this.SetTime();
    this.SetServeNum();
    SetActive(this.startGameGO, true);
    SetActive(this.guideBox, false);
    SetActive(this.imgTip, true);
end


this.SetTime = function()
    local time = math.ceil(YPSGameMgr.GameEndTime());
    local h, m, s = GetTimeHMS(time);
    this.time.text = string.format("%s:%s", m, s);
    local playLimit = ConfigMgr.Config.CookConstants.PlayLimit;
    this.timeAnimator.enabled = playLimit >= time;
end


this.SetServeNum = function()
    local num = YPSGameCharacterMgr.GetServeNum();
    this.serveNum.text = string.format(LuaMgr.GetLangText("FoodComposeViewModel_1"), num);
    this.txtTip.text = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23666"),
DataMgr.Player.CookGame.Challenge);
end


this.SetCharacters = function()
    this.characterList:Clear(false);
    local listData;
    local listDatas = {};
    local len = #this.characterDatas;
    for i = 1, len do
        listData = UIListData.GetData(this.characterItem, "YPSGameCharacterItem",
            { id = this.characterDatas[i], index = i });
        table.insert(listDatas, listData);
    end
    this.characterList:SetData(listDatas, true);
end


this.OnClickPause = function()
    if (YPSGameMgr.IsOpen() and YPSGameMgr.GameEndTime() > 0) then
        YPSGameMgr.Pause();
    end
end


this.OnClickStartGame = function()
    if (YPSMgr.CheckChallengeTimes() == false) then
        return
    end
    SetActive(this.startGameGO, false);
    SetActive(this.guideBox, true);
    SetActive(this.imgTip, false);
    YPSGameMgr.ShowFoods();
    LuaMgr.ShowLuaPanel(UIName.YPSGamePauseViewModel, 0, YPSGameCharacterMgr.SetCharacterInfo);
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/hightea_open.mp3");
end


this.OnRestart = function()
    YPSGameMgr.Clear();
    YPSGameCharacterMgr.Clear();
    YPSGameFoodMgr.Clear();
    YPSGameCharacterMgr.Show();
    YPSGameMgr.GenFoodDatas();
    YPSGameMgr.Show();
    this.SetTime();
    this.SetServeNum();
    SetActive(this.startGameGO, false);
    SetActive(this.guideBox, true);
    SetActive(this.imgTip, false);
    YPSGameMgr.ShowFoods();
    LuaMgr.ShowLuaPanel(UIName.YPSGamePauseViewModel, 0, YPSGameCharacterMgr.SetCharacterInfo);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        RedMgr.Singleton:RegisterViewModel(UIName.YPSGameViewModel)
        LuaMgr.AddClick(this.pauseBtn, this.OnClickPause);
        LuaMgr.AddClick(this.startGameBtn, this.OnClickStartGame);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if (RedMgr.Singleton:CheckRedCondition("17203")) then
            RedMgr.Singleton:FrushRedCondition("17203")
        end
        vm.behaviour:UpdateTopBar("", this.OnBack);
        LuaMgr.AddUIEventListener(UIEventConst.YPSGameRestart, this.OnRestart);
        this.SetData();
        LuaMgr.AddUIEventListener(UIEventConst.TopBarHelp, this.OnClickPause)
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.YPSGameRestart, this.OnRestart);
        YPSGameMgr.Clear();
        YPSGameCharacterMgr.Clear();
        LuaMgr.RemoveUIEventListener(UIEventConst.TopBarHelp, this.OnClickPause)
    end,
    before_destroy = function(vm)
        RedMgr.Singleton:RemoveViewModel(UIName.YPSGameViewModel);
        LuaMgr.RemoveClick(this.pauseBtn, this.OnClickPause);
        LuaMgr.RemoveClick(this.startGameBtn, this.OnClickStartGame);
        YPSGameMgr.Destroy();
        YPSGameCharacterMgr.Destroy();
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})