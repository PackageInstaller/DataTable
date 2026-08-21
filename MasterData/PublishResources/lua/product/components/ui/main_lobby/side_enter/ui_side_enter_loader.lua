_class("UISideEnterLoader", UICustomWidget)
UISideEnterLoader = UISideEnterLoader

function UISideEnterLoader:SetData(TT, cfg, hideCallback, redCallback)
  Log.info("UISideEnterLoader:SetData() ID = ", cfg.ID)
  self._mainCfg = cfg
  local btnKey = cfg.BtnKey
  local btnCfg = UISideEnterConst.GetCfg_SideEnterBtn(btnKey)
  self._hideCallback = hideCallback
  self._redCallback = redCallback
  self:SetShow(false, true)
  self._new, self._red = 0, 0
  local class, prefab = UISideEnterConst.GetCfg_SideEnterBtn_Info(btnKey)
  UIWidgetHelper.ClearWidgets(self, "_sop")
  self._obj = UIWidgetHelper.SpawnObject(self, "_sop", class, prefab)
  if not self._obj then
    return
  end
  local clickCallback = UISideEnterBtnConst.ForceOpenUI(btnCfg)
  self._obj:SetMainInfo(self._mainCfg, btnCfg, clickCallback, function(show)
    self:SetShow(show)
  end, function(new, red)
    self:SetNewRed(new, red)
  end)
  self._obj:OnSideEnterLoad(TT)
  self._rawImage = self._obj:GetSideEnterRawImage()
end

function UISideEnterLoader:SetShow(show, init)
  local pre = self._show
  self._show = show
  self:GetGameObject():SetActive(show)
  if not init and pre == true and show == false and self._hideCallback then
    self._hideCallback()
  end
end

function UISideEnterLoader:GetShow()
  return self._show
end

function UISideEnterLoader:SetNewRed(new, red)
  if self._new ~= new or self._red ~= red then
    if type(new) == "boolean" then
      new = new and 1 or 0
    end
    if type(red) == "boolean" then
      red = red and 1 or 0
    end
    self._new, self._red = new, red
    if self._redCallback then
      self._redCallback()
    end
  end
end

function UISideEnterLoader:GetNewRed()
  Log.info("UISideEnterLoader:GetNewRed() ID = ", self._mainCfg.ID, " new = ", self._new, " red = ", self._red)
  return self._new, self._red
end

function UISideEnterLoader:GetSideEnterRawImage()
  Log.info("UISideEnterLoader:GetSideEnterRawImage() ID = ", self._mainCfg.ID, " rawImage = ", self._rawImage)
  return self._rawImage
end

function UISideEnterLoader:GetCfg()
  return self._mainCfg
end
