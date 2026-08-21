_class("UISideEnterItem_Base", UICustomWidget)
UISideEnterItem_Base = UISideEnterItem_Base

function UISideEnterItem_Base:SetMainInfo(mainCfg, btnCfg, clickCallback, setShowCallback, setNewRedCallback)
  self._mainCfg = mainCfg
  self._btnCfg = btnCfg
  self._clickCallback = clickCallback
  self._setShowCallback = setShowCallback
  self._setNewRedCallback = setNewRedCallback
end

function UISideEnterItem_Base:OnSideEnterLoad(TT)
  local isOpen = self:_CheckOpen(TT) and self:_BtnCheckFunc(TT)
  if isOpen then
    self._setShowCallback(true)
    self:_CheckPoint()
    self:DoShow()
  end
end

function UISideEnterItem_Base:_BtnCheckFunc(TT)
  local isOpen = UISideEnterBtnConst.CheckOpen(TT, self._btnCfg)
  return isOpen
end

function UISideEnterItem_Base:_CheckOpen(TT)
  Log.exception(self._className .. "必须重写 _CheckOpen() 方法:", debug.traceback())
end

function UISideEnterItem_Base:GetSideEnterRawImage()
  Log.exception(self._className .. "必须重写 GetSideEnterRawImage() 方法:", debug.traceback())
end

function UISideEnterItem_Base:DoShow()
  Log.exception(self._className .. "必须重写 DoShow() 方法:", debug.traceback())
end

function UISideEnterItem_Base:_CalcNew()
  Log.exception(self._className .. "必须重写 _CalcNew() 方法:", debug.traceback())
end

function UISideEnterItem_Base:_CalcRed()
  Log.exception(self._className .. "必须重写 _CalcRed() 方法:", debug.traceback())
end

function UISideEnterItem_Base:_CalcHot()
  return self._mainCfg.Hot
end

function UISideEnterItem_Base:_CheckPoint()
  if not self.view then
    return
  end
  local new = self:_CalcNew()
  local red = self:_CalcRed()
  UIWidgetHelper.SetNewAndReds(self, new, red, "new", "red")
  local hotCfg = self:_CalcHot()
  if hotCfg ~= nil then
    local hot = (new == 0 or new == false) and hotCfg == true
    self:GetGameObject("hot"):SetActive(hot)
  end
  self._setNewRedCallback(new, red)
end

function UISideEnterItem_Base:BtnOnClick(go)
  if self._clickCallback ~= nil then
    self._clickCallback()
  end
end
