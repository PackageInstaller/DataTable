local SetRoomUICtrl = BaseClass("SetRoomUICtrl")

local M = SetRoomUICtrl

function M:__init(view)
    self._view = view

    self._view.tg_cabinEnterAnim:OnToggleClick(Bind(self, self.OnSwitchCabinEnterAnim))
    self._view.tg_cabinCameraTrackIn:OnToggleClick(Bind(self, self.OnSwitchCabinCameraTrackIn))
end

function M:Open()
    self._view.tg_cabinEnterAnim:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Dorm.CabinEnterAnim,SettingDefault.Dorm.CabinEnterAnim)>0)
    self._view.tg_cabinCameraTrackIn:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Dorm.CabinCameraTrackIn,SettingDefault.Dorm.CabinCameraTrackIn)>0)
end


function M:OnSwitchCabinEnterAnim(isOn)
    GameHelper.SetPlayerPrefsInt(SettingConst.Dorm.CabinEnterAnim,isOn and 1 or 0)
    print('set room cabin enter ison:'..tostring( isOn))
end

function M:OnSwitchCabinCameraTrackIn(isOn)
    GameHelper.SetPlayerPrefsInt(SettingConst.Dorm.CabinCameraTrackIn,isOn and 1 or 0)
    print('set room CabinCameraTrackIn ison:'..tostring( isOn))
end

function M:OnDispose()
    self._view.tg_cabinEnterAnim:RemoveToggleAllClicks()
    self._view.tg_cabinCameraTrackIn:RemoveToggleAllClicks()
    if self._view then
        self._view:OnDispose()
    end
    self._view = nil
end

function M:RevertAll(active)
    if active then
        self._view.tg_cabinEnterAnim:SetIsOn(SettingDefault.Dorm.CabinEnterAnim>0)
        self._view.tg_cabinCameraTrackIn:SetIsOn(SettingDefault.Dorm.CabinCameraTrackIn>0)
    else
        self:OnSwitchCabinEnterAnim(SettingDefault.Dorm.CabinEnterAnim>0)
        self:OnSwitchCabinCameraTrackIn(SettingDefault.Dorm.CabinCameraTrackIn>0)
    end
end

return SetRoomUICtrl
