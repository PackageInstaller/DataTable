_class("UIActivityN29DetectiveClueTab", UICustomWidget)
UIActivityN29DetectiveClueTab = UIActivityN29DetectiveClueTab

function UIActivityN29DetectiveClueTab:Constructor()
  self._curClueItem = nil
end

function UIActivityN29DetectiveClueTab:OnShow(uiParams)
  self:_GetComponent()
end

function UIActivityN29DetectiveClueTab:_GetComponent()
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._place = self:GetUIComponent("UILocalizationText", "place")
  self._info = self:GetUIComponent("UILocalizationText", "info")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._scrollRect = self:GetUIComponent("ScrollRect", "Scroll View")
  self._contentRect = self:GetUIComponent("RectTransform", "infoContent")
  self._arrowObj = self:GetGameObject("arrow")
  self._tabObj = self:GetGameObject("tab")
  self._anim = self:GetUIComponent("Animation", "tab")
  self._scrollRect.onValueChanged:AddListener(function(ve2)
    if ve2.y <= 0 and self._arrowObj.activeSelf then
      self._arrowObj:SetActive(false)
    end
  end)
end

function UIActivityN29DetectiveClueTab:SetData(data)
  self._clueInfo = data
  self:InitContent()
  self:RefreshInfo()
end

function UIActivityN29DetectiveClueTab:RefreshInfo()
  if self._curClueItem then
    local cfg = self._curClueItem:GetCfg()
    self._name:SetText(StringTable.Get(cfg.Name))
    self._place:SetText(StringTable.Get(cfg.Place))
    self._info:SetText(StringTable.Get(cfg.Info))
    self._icon:LoadImage(cfg.Icon)
    self._contentRect.anchoredPosition = Vector2(0, 0)
  end
end

function UIActivityN29DetectiveClueTab:InitContent()
  local list = self._clueInfo.clue_list
  local len = #list
  self._arrowObj:SetActive(6 < len)
  self._widgets = self._content:SpawnObjects("UIActivityN29DetectiveClueItem", #list)
  for i, v in pairs(list) do
    local widget = self._widgets[i]
    widget:SetSelect(false)
    local idx = len - i + 1
    local cfg = Cfg.cfg_component_detective_item[list[idx]]
    widget:SetData(cfg, i, function(item)
      self:ItemClickCallbcak(item)
    end)
    if not self._curClueItem then
      widget:ItemBtnOnClick()
    end
  end
end

function UIActivityN29DetectiveClueTab:SetActive(isActive, isAnim)
  self:StartTask(self._ActiveAnim, self, isActive, isAnim)
end

function UIActivityN29DetectiveClueTab:_ActiveAnim(TT, isActive, isAnim)
  if isActive then
    self._tabObj:SetActive(true)
  else
    if isAnim then
      self._anim:Play("uieff_UIN29DetectiveClueTab_out")
      YIELD(TT, 200)
    end
    self._tabObj:SetActive(false)
  end
end

function UIActivityN29DetectiveClueTab:ItemClickCallbcak(item)
  if self._curClueItem == item then
    return
  end
  if self._curClueItem then
    self._curClueItem:SetSelect(false)
  end
  self._curClueItem = item
  self:RefreshInfo()
end

function UIActivityN29DetectiveClueTab:CloseBtnOnClick()
  self._anim:Play("uieff_UIN29DetectiveClueTab_out")
  local controller = GameGlobal.UIStateManager():GetController("UIActivityN29DetectiveBagController")
  if controller then
    controller:Close()
  else
    Log.fatal("不存在UIActivityN29DetectiveBagController，请检查！！！")
  end
end
