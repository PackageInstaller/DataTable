require("GuoBao/GuoBaoScene")
require("GuoBao/GuoBaoSceneMgr")
require("GuoBao/GuoBaoConst")
require("GuoBao/GuoBaoSceneLineMgr")
require("GuoBao/GuoBaoCharacter")
require("GuoBao/GuoBaoCharacterAI")
require("GuoBao/GuoBaoCharacterMgr")
require("GuoBao/GuoBaoBuilding")
require("GuoBao/GuoBaoBuildingInfo")
require("GuoBao/GuoBaoMsgMgr")

GuoBaoMgr = {};

local this = {
    camera = nil,
    isFirstPage = true,
    outsideClick = false,
};


GuoBaoMgr.SetFirstPage = function(isFirstPage)
    this.isFirstPage = isFirstPage;
end


GuoBaoMgr.IsFirstPage = function()
    return this.isFirstPage;
end


this.OnGuoBao = function()
    LuaMgr.AddUIEventListener(UIEventConst.TopBarElementClickAdd, this.OnTopBarElementClickAdd);
    this.SetAntiAliasing();
    GuoBaoScene.Init();
    GuoBaoScene.Show();
    LuaMgr.ShowLuaPanel(UIName.GuoBaoViewModel);
end


this.SetAntiAliasing = function()
    local foundationAntiAliasing = ConfigMgr.Config.constants.FoundationAntiAliasing;
    local quality = SettingHelper.GetCurImageQuality();
    if (quality.key == ESetting.Image_QualityHigh.key) then
        LuaMgr.AntiAliasing(foundationAntiAliasing[3]);
    elseif (quality.key == ESetting.Image_QualityMiddle.key) then
        LuaMgr.AntiAliasing(foundationAntiAliasing[2]);
    else
        LuaMgr.AntiAliasing(foundationAntiAliasing[1]);
    end
end


this.OnLoadingScene = function()
    LuaMgr.AntiAliasing(0);
    LuaMgr.RemoveUIEventListener(UIEventConst.TopBarElementClickAdd, this.OnTopBarElementClickAdd);
    this.camera = nil;
    GuoBaoScene.Destroy();
end


this.OnTopBarElementClickAdd = function()
    
end


function GuoBaoMgr.Open()
    LuaMgr.SceneSwitchMark();
    LuaMgr.LoadScene("GuoBao", nil, this.OnGuoBao);
end


function GuoBaoMgr.Back()
    this.OnLoadingScene();
end


function GuoBaoMgr.Clear()
    this.OnLoadingScene();
end


GuoBaoMgr.ClickSound = function()
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/Click_light.mp3");
end


GuoBaoMgr.StopVoice = function()
    AudioMgr.Singleton:StopVoice(false);
end


GuoBaoMgr.SetCamera = function(camera)
    this.camera = camera;
end


GuoBaoMgr.GetCamera = function()
    return this.camera;
end


GuoBaoMgr.ScreenRatioOffset = function()
    local designRatio = 16 / 9;
    local screenRatio = UnityEngine.Screen.width / UnityEngine.Screen.height;
    if (screenRatio < designRatio) then
        return designRatio - screenRatio;
    end
    return 0;
end


GuoBaoMgr.SetOutsideClick = function(isClick)
    this.outsideClick = isClick;
end


GuoBaoMgr.IsOutsideClick = function()
    return this.outsideClick;
end