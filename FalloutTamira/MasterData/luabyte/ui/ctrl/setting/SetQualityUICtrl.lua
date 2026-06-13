local SetQualityUICtrl = BaseClass("SetQualityUICtrl")

local M = SetQualityUICtrl

function M:__init(view)
    self._view = view

    self._view.tg_low:OnToggleClick(Bind(self, self.OnClickLowQualityToggle))
    self._view.tg_medium:OnToggleClick(Bind(self, self.OnClickMediumQualityToggle))
    self._view.tg_high:OnToggleClick(Bind(self, self.OnClickHighQualityToggle))

    self._view.tg_30:OnToggleClick(Bind(self, self.OnClick30Frame))
    self._view.tg_45:OnToggleClick(Bind(self, self.OnClick45Frame))
    self._view.tg_60:OnToggleClick(Bind(self, self.OnClick60Frame))

    self._view.battle_bg_30:OnToggleClick(Bind(self, self.OnClickBattle30Frame))
    self._view.battle_bg_45:OnToggleClick(Bind(self, self.OnClickBattle45Frame))
    self._view.battle_bg_60:OnToggleClick(Bind(self, self.OnClickBattle60Frame))

    self._view.tg_anti_aliasing:OnToggleClick(Bind(self, self.OnClickAntiAliasing))

    self._view.slider_screenFit:OnSliderChanged(Bind(self, self.OnScreenFitSliderChanged))
end

function M:Open()
    self._view.tgGroup_quality:SetAllTogglesOff()

    self._view.tg_low:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Graphics.QualityLevel,SettingDefault.Graphics.QualityLevel)==2)
    self._view.tg_medium:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Graphics.QualityLevel,SettingDefault.Graphics.QualityLevel)==1)
    self._view.tg_high:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Graphics.QualityLevel,SettingDefault.Graphics.QualityLevel)==0)

    self._view.tg_30:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Graphics.TargetFrame,SettingDefault.Graphics.TargetFrame)==30)
    self._view.tg_45:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Graphics.TargetFrame,SettingDefault.Graphics.TargetFrame)==45)
    self._view.tg_60:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Graphics.TargetFrame,SettingDefault.Graphics.TargetFrame)==60)

    self._view.battle_bg_30:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Graphics.BattleTargetFrame,SettingDefault.Graphics.BattleTargetFrame)==30)
    self._view.battle_bg_45:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Graphics.BattleTargetFrame,SettingDefault.Graphics.BattleTargetFrame)==45)
    self._view.battle_bg_60:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Graphics.BattleTargetFrame,SettingDefault.Graphics.BattleTargetFrame)==60)


    self._view.tg_anti_aliasing:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Graphics.AntiAliasing,SettingDefault.Graphics.AntiAliasing)>0)

    self._view.slider_screenFit:SetValue(GameHelper.GetPlayerPrefsInt(SettingConst.Graphics.ScreenFit,SettingDefault.Graphics.ScreenFit) * 0.01)
end



function M:OnClickLowQualityToggle(isOn)
    if isOn then
        GameHelper.SetPlayerPrefsInt(SettingConst.Graphics.QualityLevel,2)
        ISettingDataMgr:SwitchGraphicLevel(2)
    end
end

function M:OnClickMediumQualityToggle(isOn)
    if isOn then
        GameHelper.SetPlayerPrefsInt(SettingConst.Graphics.QualityLevel,1)
        ISettingDataMgr:SwitchGraphicLevel(1)
    end
end

function M:OnClickHighQualityToggle(isOn)
    if isOn then
        GameHelper.SetPlayerPrefsInt(SettingConst.Graphics.QualityLevel,0)
        ISettingDataMgr:SwitchGraphicLevel(0)
    end
end

function M:OnClick30Frame(isOn)
    if isOn then
        GameHelper.SetPlayerPrefsInt(SettingConst.Graphics.TargetFrame,30)
        ISettingDataMgr:SwitchFrame(30)
    end
end

function M:OnClick45Frame(isOn)
    if isOn then
        GameHelper.SetPlayerPrefsInt(SettingConst.Graphics.TargetFrame,45)
        ISettingDataMgr:SwitchFrame(45)
    end
end

function M:OnClick60Frame(isOn)
    if isOn then
        GameHelper.SetPlayerPrefsInt(SettingConst.Graphics.TargetFrame,60)
        ISettingDataMgr:SwitchFrame(60)
    end
end

function M:OnClickBattle30Frame(isOn)
    if isOn then
        GameHelper.SetPlayerPrefsInt(SettingConst.Graphics.BattleTargetFrame,30)
        ISettingDataMgr:SwitchBattleFrame(30)
    end
end

function M:OnClickBattle45Frame(isOn)
    if isOn then
        GameHelper.SetPlayerPrefsInt(SettingConst.Graphics.BattleTargetFrame,45)
        ISettingDataMgr:SwitchBattleFrame(45)
    end
end

function M:OnClickBattle60Frame(isOn)
    if isOn then
        GameHelper.SetPlayerPrefsInt(SettingConst.Graphics.BattleTargetFrame,60)
        ISettingDataMgr:SwitchBattleFrame(60)
    end
end

function M:OnClickAntiAliasing(isOn)
    local anti = isOn and SettingDefault.Graphics.AntiAliasing or 0
    GameHelper.SetPlayerPrefsInt(SettingConst.Graphics.AntiAliasing,anti)
    ISettingDataMgr:SetGraphic_Anti_aliasing(anti)

    local level = GameHelper.GetPlayerPrefsInt(SettingConst.Graphics.QualityLevel,SettingDefault.Graphics.QualityLevel)
    local open = GameHelper.GetPlayerPrefsInt(SettingConst.Graphics.AntiAliasing,SettingDefault.Graphics.AntiAliasing)>0
    if  open then
        if level == 0 then
            CS.UnityEngine.QualitySettings.antiAliasing = 4
        elseif level == 1 then
            CS.UnityEngine.QualitySettings.antiAliasing = 2
        else
            CS.UnityEngine.QualitySettings.antiAliasing = 0
        end
    else
        CS.UnityEngine.QualitySettings.antiAliasing = 0
    end
    --print("uuuuu set antialiasing level: ", CS.UnityEngine.QualitySettings.antiAliasing )
end


function M:OnScreenFitSliderChanged(value)
    self._view.slider_screenFit:SetValue(value)
    local result = math.ceil(value*100);
    GameHelper.SetPlayerPrefsInt(SettingConst.Graphics.ScreenFit,result)
    ISettingDataMgr:SetSpecialScreenFit(result)
end


function M:OnDispose()
    self._view.tg_low:RemoveToggleAllClicks()
    self._view.tg_medium:RemoveToggleAllClicks()
    self._view.tg_high:RemoveToggleAllClicks()

    self._view.tg_30:RemoveToggleAllClicks()
    self._view.tg_45:RemoveToggleAllClicks()
    self._view.tg_60:RemoveToggleAllClicks()

    self._view.battle_bg_30:RemoveToggleAllClicks()
    self._view.battle_bg_45:RemoveToggleAllClicks()
    self._view.battle_bg_60:RemoveToggleAllClicks()

    self._view.tg_anti_aliasing:RemoveToggleAllClicks()

    self._view.slider_screenFit:RemoveSliderListener()
    if self._view then
        self._view:OnDispose()
    end
    self._view = nil
end

function M:RevertAll(active)
    if  active then
        self._view.tg_low:SetIsOn(SettingDefault.Graphics.QualityLevel==2)
        self._view.tg_medium:SetIsOn(SettingDefault.Graphics.QualityLevel==1)
        self._view.tg_high:SetIsOn(SettingDefault.Graphics.QualityLevel==0)
    
        self._view.tg_30:SetIsOn(SettingDefault.Graphics.TargetFrame==30)
        self._view.tg_45:SetIsOn(SettingDefault.Graphics.TargetFrame==45)
        self._view.tg_60:SetIsOn(SettingDefault.Graphics.TargetFrame==60)

        self._view.battle_bg_30:SetIsOn(SettingDefault.Graphics.BattleTargetFrame==30)
        self._view.battle_bg_45:SetIsOn(SettingDefault.Graphics.BattleTargetFrame==45)
        self._view.battle_bg_60:SetIsOn(SettingDefault.Graphics.BattleTargetFrame==60)

        self._view.tg_anti_aliasing:SetIsOn(SettingDefault.Graphics.AntiAliasing>0)
    else
        self:OnClickLowQualityToggle(SettingDefault.Graphics.QualityLevel==2)
        self:OnClickMediumQualityToggle(SettingDefault.Graphics.QualityLevel==1)
        self:OnClickHighQualityToggle(SettingDefault.Graphics.QualityLevel==0)
    
        self:OnClick30Frame(SettingDefault.Graphics.TargetFrame==30)
        self:OnClick45Frame(SettingDefault.Graphics.TargetFrame==45)
        self:OnClick60Frame(SettingDefault.Graphics.TargetFrame==60)

        self:OnClickBattle30Frame(SettingDefault.Graphics.BattleTargetFrame==30)
        self:OnClickBattle45Frame(SettingDefault.Graphics.BattleTargetFrame==45)
        self:OnClickBattle60Frame(SettingDefault.Graphics.BattleTargetFrame==60)

        self:OnClickAntiAliasing(SettingDefault.Graphics.AntiAliasing>0)
    end
    self:OnScreenFitSliderChanged(SettingDefault.Graphics.ScreenFit)
end

return SetQualityUICtrl
