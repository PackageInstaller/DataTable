local UISceneChangesMask = class("UISceneChangesMask", UIBaseWindow)
local base = UIBaseWindow
local CS_Material = CS.UnityEngine.Material
local cs_Ease = CS.DG.Tweening.Ease
local cs_DoTween = CS.DG.Tweening.DOTween
local MatRangeProperty = "_Range"

function UISceneChangesMask:OnInit()
  self._maskMat = CS_Material(self.ui.img_BlackMask.material)
  self.ui.img_BlackMask.material = self._maskMat
  self._maskMat:SetFloat(MatRangeProperty, 0)
  local se = cs_DoTween.Sequence()
  se:Append(self._maskMat:DOFloat(1, MatRangeProperty, 0.5):SetEase(cs_Ease.OutQuad)):AppendCallback(BindCallback(self, self._OnSceneClose)):AppendInterval(0.1):Append(self._maskMat:DOFloat(0, MatRangeProperty, 0.5):SetEase(cs_Ease.InQuad)):AppendCallback(BindCallback(self, self._OnSceneOpen)):Pause():SetAutoKill(false)
  self.maskMatSeq = se
end

function UISceneChangesMask:InitSceneChangesMask(onCloseSceneFunc, onOpenSceneFunc)
  self.onCloseSceneFunc = onCloseSceneFunc
  self.onOpenSceneFunc = onOpenSceneFunc
  self.maskMatSeq:Restart()
end

function UISceneChangesMask:_OnSceneClose()
  if self.onCloseSceneFunc ~= nil then
    self.onCloseSceneFunc()
  end
end

function UISceneChangesMask:_OnSceneOpen()
  if self.onOpenSceneFunc ~= nil then
    self.onOpenSceneFunc()
  end
  self:Hide()
end

function UISceneChangesMask:OnDelete()
  if self.maskMatSeq ~= nil then
    self.maskMatSeq:Kill()
    self.maskMatSeq = nil
  end
  DestroyUnityObject(self._maskMat)
  base.OnDelete(self)
end

return UISceneChangesMask
