local UINActivityCollectFortuneDownNode = class("UINActivityCollectFortuneDownNode", UIBaseNode)
local base = UIBaseNode
local cs_TweenLoop = CS.DG.Tweening.LoopType

function UINActivityCollectFortuneDownNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINActivityCollectFortuneDownNode:ActCollectFortunrDN_Inite(actData, resloader)
  self._actData = actData
  self._resloader = resloader
  self.__leftTween = self.ui.TopLeft:DOLocalMove(Vector3.Temp(7, -7, 0), 1):SetRelative(true):SetLoops(-1, cs_TweenLoop.Yoyo):SetLink(self.gameObject):Pause()
  self.__rightTween = self.ui.DownRight:DOLocalMove(Vector3.Temp(-7, 7, 0), 1):SetRelative(true):SetLoops(-1, cs_TweenLoop.Yoyo):SetLink(self.gameObject):Pause()
  self.__midTween = self.ui.Diamond:DOScale(0.9, 1):SetLoops(-1, cs_TweenLoop.Yoyo):SetLink(self.gameObject):Pause()
  local couldDrawBtnFXPrefab = self._resloader:LoadABAsset("FX/UI_effct/UI_wufu/FXP_wufu_guang.prefab")
  self.__couldDrawFX = couldDrawBtnFXPrefab:Instantiate(self.ui.Btn_Open)
  self:ActCollectFortunrDN_RefreshOpenBtnTween()
end

function UINActivityCollectFortuneDownNode:ActCollectFortunrDN_RefreshOpenBtnTween()
  local isCouldeDraw, _ = self._actData:GetActCollectFortuneIsCouldDraw()
  if isCouldeDraw then
    self.__leftTween:Play()
    self.__rightTween:Play()
    self.__midTween:Play()
  else
    self.__leftTween:Rewind()
    self.__rightTween:Rewind()
    self.__midTween:Rewind()
  end
  self.__couldDrawFX.gameObject:SetActive(isCouldeDraw)
end

function UINActivityCollectFortuneDownNode:ActCollectFortunrDN_ShowDrawTween(callback)
  UIUtil.AddOneCover("ActCollectFortunrDN")
  self.ui.Btn_Open:DOScale(0.9, 0.2):SetLoops(2, cs_TweenLoop.Yoyo):SetLink(self.gameObject):OnComplete(function()
    if callback ~= nil then
      callback()
    end
    UIUtil.CloseOneCover("ActCollectFortunrDN")
  end)
  if self.__drawFX ~= nil then
    self.__drawFX.gameObject:SetActive(true)
  else
    local drawFXPrefab = self._resloader:LoadABAsset("FX/UI_effct/UI_wufu/FXP_wufu_bao.prefab")
    self.__drawFX = drawFXPrefab:Instantiate(self.ui.List)
  end
  TimerManager:StopTimer(self._timer)
  self._timer = TimerManager:StartTimer(0.5, function()
    if IsNull(self.gameObject) then
      return
    end
    if self.__drawFX ~= nil then
      self.__drawFX.gameObject:SetActive(false)
    end
  end, self, true, false, false)
end

function UINActivityCollectFortuneDownNode:OnDelete()
  TimerManager:StopTimer(self._timer)
  base.OnDelete(self)
end

return UINActivityCollectFortuneDownNode
