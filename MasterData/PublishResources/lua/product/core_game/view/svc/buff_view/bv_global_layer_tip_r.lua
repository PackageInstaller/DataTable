_class("BuffViewGlobalLayerTipShow", BuffViewBase)
BuffViewGlobalLayerTipShow = BuffViewGlobalLayerTipShow

function BuffViewGlobalLayerTipShow:PlayView(TT)
  self._world:EventDispatcher():Dispatch(GameEventType.UIInitGlobalLayerTipInfo, self._buffResult)
end

_class("BuffViewGlobalLayerTipHide", BuffViewBase)
BuffViewGlobalLayerTipHide = BuffViewGlobalLayerTipHide

function BuffViewGlobalLayerTipHide:PlayView(TT)
  self._world:EventDispatcher():Dispatch(GameEventType.UIHideGlobalLayerTipInfo)
end

_class("BuffViewGlobalLayerTipUpdate", BuffViewBase)
BuffViewGlobalLayerTipUpdate = BuffViewGlobalLayerTipUpdate

function BuffViewGlobalLayerTipUpdate:PlayView(TT)
  self._world:EventDispatcher():Dispatch(GameEventType.UIUpdateGlobalLayerTipInfo, self._buffResult)
end

function BuffViewGlobalLayerTipUpdate:IsNotifyMatch(notify)
  if notify:GetNotifyType() == NotifyType.NotifyLayerChange then
    if notify:GetLayerName() ~= self._buffResult.layerName then
      return false
    end
    return notify:GetLayer() == self._buffResult.count and self._buffResult.total == notify:GetTotalCount()
  end
end
