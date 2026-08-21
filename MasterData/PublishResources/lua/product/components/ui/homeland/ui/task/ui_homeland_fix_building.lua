_class("UIHomelandFixBuilding", UIController)
UIHomelandFixBuilding = UIHomelandFixBuilding

function UIHomelandFixBuilding:OnShow(uiParams)
  self:InitWidget()
  local matObj = self:GetAsset("uieff_n17_fix_building_success.mat", LoadType.Mat)
  local mat = self.tip.fontMaterial
  self.tip.fontMaterial = matObj
  self.tip.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
  self:Lock(self:GetName())
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideHomelandMainUI, false)
  self._active = true
  self:StartTask(function(TT)
    YIELD(TT, 2200)
    if not self._active then
      return
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ResetOneBuilding, uiParams[2], true)
    YIELD(TT, 1800)
    if not self._active then
      return
    end
    self:CloseDialog()
    self:UnLock(self:GetName())
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomeLandSpecialCheck, uiParams[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideHomelandMainUI, true)
  end)
end

function UIHomelandFixBuilding:OnHide()
  self._active = false
end

function UIHomelandFixBuilding:InitWidget()
  self.tip = self:GetUIComponent("UILocalizedTMP", "tip")
end
