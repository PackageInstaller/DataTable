require("ui_n12_map_controller")
_class("UIN12MapExitsController", UIN12MapController)
UIN12MapExitsController = UIN12MapExitsController

function UIN12MapExitsController:GetComponents()
  self._titleTex = self:GetUIComponent("UILocalizationText", "title")
  self._goOnBtn = self:GetGameObject("goOnBtn")
end

function UIN12MapExitsController:OnValue()
  self._over = self._rate >= 1
  self:SetTextMat()
  self:ShowExitsPanel()
end

function UIN12MapExitsController:ShowExitsPanel()
  self._goOnBtn:SetActive(not self._over)
  local title
  if self._over then
    title = StringTable.Get("str_n12_map_exits_rate_leave", "100%%")
  else
    title = StringTable.Get("str_n12_map_exits_rate_leave_or_goon", math.floor(self._rate * 100) .. "%%")
  end
  self._titleTex:SetText(title)
end

function UIN12MapExitsController:SetFontMat(lable, resname)
  self._res = ResourceManager:GetInstance():SyncLoadAsset(resname, LoadType.Mat)
  if not self._res then
    return
  end
  local obj = self._res.Obj
  local mat = lable.fontMaterial
  lable.fontMaterial = obj
  lable.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end

function UIN12MapExitsController:exitsBtnOnClick(go)
  self:CloseDialog()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN12CloseMap)
end

function UIN12MapExitsController:goOnBtnOnClick(go)
  self:CloseDialog()
end

function UIN12MapExitsController:closeBtnOnClick(go)
  self:CloseDialog()
end
