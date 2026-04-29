_class("UICommonConversionController", UIController)
UICommonConversionController = UICommonConversionController

function UICommonConversionController:OnShow(uiParams)
  self._info = uiParams[1]
  self._closeCallback = uiParams[2]
  self._oriPool = self:GetUIComponent("UISelectObjectPath", "itemPoolOri")
  self._tarPool = self:GetUIComponent("UISelectObjectPath", "itemPoolTar")
  self._selectInfoPool = self:GetUIComponent("UISelectObjectPath", "selectInfoPool")
  local bgCanvas = self:GetUIComponent("Canvas", "BGCanvas")
  self._blur = self:GetUIComponent("H3DUIBlurHelper", "Blur")
  self._blur.OwnerCamera = bgCanvas.worldCamera
  self._blur:RefreshBlurTexture()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundGetItem)
  self:SortList()
  self:ShowInfo()
end

function UICommonConversionController:ShowInfo()
  local info = self._sortList[self._showIdx]
  self._oriItem = self._oriPool:SpawnObject("UIItemForConversion")
  self._oriItem:SetData(info, function(id, pos)
    self:ItemClick(id, pos)
  end)
  local per = info.count
  local cfg = Cfg.cfg_item[info.assetid]
  local converAwardList = cfg.ConverAward
  if converAwardList and 0 < #converAwardList then
    local count = #converAwardList
    self._tarPools = self._tarPool:SpawnObjects("UIItemForConversion", count)
    for i = 1, count do
      local widget = self._tarPools[i]
      local cfg_conversion = converAwardList[i]
      local conversionInfo = RoleAsset:New()
      conversionInfo.assetid = cfg_conversion[1]
      conversionInfo.count = cfg_conversion[2] * per
      widget:SetData(conversionInfo, function(id, pos)
        self:ItemClick(id, pos)
      end)
    end
  else
    Log.error("###[UICommonConversionController] converAwardList == 0 ! id --> ", info.assetid)
  end
end

function UICommonConversionController:SortList()
  if table.count(self._info) == 0 then
    Log.error("###[UICommonConversionController] info count == 0 !")
    self:CloseDialog()
    return
  end
  self._showIdx = 1
  self._sortList = {}
  for id, count in pairs(self._info) do
    local info = RoleAsset:New()
    info.assetid = id
    info.count = count
    table.insert(self._sortList, info)
  end
  table.sort(self._sortList, function(a, b)
    local a_id = a.assetid
    local b_id = b.assetid
    local cfg_a = Cfg.cfg_item[a_id]
    local cfg_b = Cfg.cfg_item[b_id]
    if cfg_a.BagSortIndex == cfg_b.BagSortIndex then
      if cfg_a.Color == cfg_b.Color then
        return cfg_a.ID < cfg_b.ID
      end
      return cfg_a.Color > cfg_b.Color
    end
    return cfg_a.BagSortIndex > cfg_b.BagSortIndex
  end)
end

function UICommonConversionController:ImageOnClick()
  if self._showIdx == #self._sortList then
    self:ClosePanel()
  else
    self._showIdx = self._showIdx + 1
    self:ShowInfo()
  end
end

function UICommonConversionController:ItemClick(id, pos)
  if not self._itemInfo then
    self._itemInfo = self._selectInfoPool:SpawnObject("UISelectInfo")
  end
  self._itemInfo:SetData(id, pos)
end

function UICommonConversionController:ClosePanel()
  self:CloseDialog()
end

function UICommonConversionController:OnHide()
  Log.debug("关闭转化物品界面")
  if self._closeCallback then
    Log.debug("关闭回调调用")
    self._closeCallback()
  end
end
