_class("UIN12MapCommonPopController", UIController)
UIN12MapCommonPopController = UIN12MapCommonPopController

function UIN12MapCommonPopController:OnShow(uiParam)
  self._title = uiParam[1]
  self._content = uiParam[2]
  self._btn1Tex = uiParam[3]
  self._btn2Tex = uiParam[4]
  self._btn1Cb = uiParam[5]
  self._btn2Cb = uiParam[6]
  self:GetComponents()
  self:OnValue()
end

function UIN12MapCommonPopController:GetComponents()
  self._contentTex = self:GetUIComponent("UILocalizationText", "content")
  self._btnTex1 = self:GetUIComponent("UILocalizedTMP", "btnTex1")
  self._btnTex2 = self:GetUIComponent("UILocalizationText", "btnTex2")
  self._titleTex = self:GetUIComponent("UILocalizationText", "title")
end

function UIN12MapCommonPopController:OnValue()
  local title = self._title or ""
  local content = self._content or ""
  local btn1Tex = self._btn1Tex or ""
  local btn2Tex = self._btn2Tex or ""
  self._titleTex:SetText(title)
  self._btnTex1:SetText(btn1Tex)
  self._btnTex2:SetText(btn2Tex)
  self._contentTex:SetText(content)
  self:SetTextMat()
end

function UIN12MapCommonPopController:SetTextMat()
  self:SetFontMat(self._btnTex1, "uieff_n12_map_leave_tex.mat")
end

function UIN12MapCommonPopController:SetFontMat(lable, resname)
  self._res = ResourceManager:GetInstance():SyncLoadAsset(resname, LoadType.Mat)
  if not self._res then
    return
  end
  local obj = self._res.Obj
  local mat = lable.fontMaterial
  lable.fontMaterial = obj
  lable.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end

function UIN12MapCommonPopController:btn1OnClick(go)
  if self._btn1Cb then
    self._btn1Cb()
  end
end

function UIN12MapCommonPopController:btn2OnClick(go)
  if self._btn2Cb then
    self._btn2Cb()
  end
end

function UIN12MapCommonPopController:closeBtnOnClick(go)
  self:CloseDialog()
end

function UIN12MapCommonPopController:OnHide()
  if self._res then
    self._res:Dispose()
    self._res = nil
  end
end
