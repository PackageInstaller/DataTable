_class("UIActivityReviewItem", UICustomWidget)
UIActivityReviewItem = UIActivityReviewItem
local state = {
  CannotUnlock = 1,
  CanUnlock = 2,
  Download = 3,
  Downloading = 4,
  Normal = 5,
  NONE = 999
}
_enum("UIReviewState", state)

function UIActivityReviewItem:OnShow(uiParams)
  self:InitWidget()
  self:AttachEvent(GameEventType.UIReviewOnUnlock, self.OnUnlock)
  self:AttachEvent(GameEventType.UIReviewRefreshRedpoint, self.RefreshRedpoint)
  self:AttachEvent(GameEventType.UIReviewOnDownloadStateChanged, self.OnDownloadFinish)
  self:AttachEvent(GameEventType.UIReviewOnDownloadStart, self.OnStartDownload)
  self:AttachEvent(GameEventType.ItemCountChanged, self.OnItemCountChanged)
  self._isActive = true
end

function UIActivityReviewItem:OnHide()
  self:DetachEvent(GameEventType.ItemCountChanged, self.OnItemCountChanged)
  self._isActive = false
end

function UIActivityReviewItem:InitWidget()
  self.bg = self:GetUIComponent("RawImageLoader", "bg")
  self.redpoint = self:GetGameObject("redpoint")
  self.unlock = self:GetGameObject("unlock")
  self.itemcount = self:GetUIComponent("UILocalizationText", "itemcount")
  self.download = self:GetGameObject("download")
  self.downloading = self:GetGameObject("downloading")
  self.finish = self:GetGameObject("finish")
  self.progress = self:GetUIComponent("Image", "progress")
  self.percent = self:GetUIComponent("UILocalizationText", "percent")
  self.line = self:GetGameObject("line")
  self.hor = self:GetUIComponent("RectTransform", "hor")
  self.ver = self:GetUIComponent("RectTransform", "ver")
  self.poi = self:GetUIComponent("RectTransform", "poi")
  self.root = self:GetUIComponent("RectTransform", "root")
  self.title = self:GetUIComponent("RawImageLoader", "title")
  self.bg2 = self:GetUIComponent("RawImageLoader", "bg2")
  self.index = self:GetUIComponent("UILocalizationText", "index")
end

function UIActivityReviewItem:SetData(data, index, lastOne)
  self._data = data
  self._index = index
  self._idLastOne = lastOne
  local cfg = Cfg.cfg_activity_review[self._data:ActivityID()]
  self.bg:LoadImage(cfg.ListItemBg1)
  self.bg2:LoadImage(cfg.ListItemBg2)
  self.title:LoadImage(cfg.TitleImage)
  self.index:SetText(string.format("%02d", self._data:Index()))
  local paddingLeft = -135
  local paddingRight = 414
  local del1 = 580
  local del2 = 241
  local x = paddingLeft
  local num = math.floor(self._index / 2)
  local x = x + num * (del1 + del2)
  local y = 208
  local value = self._index % 2
  if value == 1 then
    x = x + del1
  else
    y = -227
  end
  self.root.anchoredPosition = Vector2(x, y)
  if lastOne then
    self.line:SetActive(false)
  else
    self.line:SetActive(true)
    if self._index % 2 == 1 then
      self.hor.anchoredPosition = Vector2(254, 6)
      self.hor.sizeDelta = Vector2(46, 3)
      self.ver.localRotation = Quaternion.Euler(0, 0, -90)
      self.ver.anchoredPosition = Vector2(310, -4)
      self.ver.sizeDelta = Vector2(250, 3)
      self.poi.anchoredPosition = Vector2(310, 6)
    else
      self.hor.anchoredPosition = Vector2(254, 6)
      self.hor.sizeDelta = Vector2(166, 3)
      self.ver.localRotation = Quaternion.Euler(0, 0, 90)
      self.ver.anchoredPosition = Vector2(429, 16)
      self.ver.sizeDelta = Vector2(250, 3)
      self.poi.anchoredPosition = Vector2(429, 5)
    end
  end
  self:Refresh()
end

function UIActivityReviewItem:Refresh()
  self:RefreshRedpoint()
  self:RefreshState()
end

function UIActivityReviewItem:itemOnClick(go)
  if self._state == UIReviewState.CannotUnlock then
    self:ShowDialog("UIReviewUnlockTip", self._data)
  elseif self._state == UIReviewState.CanUnlock then
    self:ShowDialog("UIReviewUnlockTip", self._data)
  elseif self._state == UIReviewState.Download then
    self:ShowDialog("UIReviewDownloadTip", self._data)
  elseif self._state == UIReviewState.Downloading then
    ToastManager.ShowToast(StringTable.Get("str_review_downloading"))
  elseif self._state == UIReviewState.Normal then
    self._data:ActivityOnOpen()
  end
  Log.debug(self._data:AssetPackageID())
end

function UIActivityReviewItem:RefreshRedpoint(id)
  if id then
    if self._data:ActivityID() == id then
      self.redpoint:SetActive(self._data:HasRedPoint())
    end
  else
    self.redpoint:SetActive(self._data:HasRedPoint())
  end
end

function UIActivityReviewItem:RefreshState()
  if self._data:IsUnlock() then
    self.unlock:SetActive(false)
    if self._data:IsFinished() then
      if self._data:IsDownloaded() then
        self._state = UIReviewState.Normal
        self.finish:SetActive(true)
        self.download:SetActive(false)
        self.downloading:SetActive(false)
        Log.debug("[Review] 已完成，并且下载过")
      elseif self._data:IsDownLoading() then
        self._state = UIReviewState.Downloading
        self.finish:SetActive(false)
        self.download:SetActive(false)
        self.downloading:SetActive(true)
        self:StartTask(self._OnDownloading, self)
        Log.debug("[Review] 已完成，正在下载中")
      else
        self.finish:SetActive(true)
        self.download:SetActive(false)
        self.downloading:SetActive(false)
        self._state = UIReviewState.Download
        Log.debug("[Review] 已完成，但本地没有资源")
      end
    else
      self.finish:SetActive(false)
      if self._data:IsDownloaded() then
        self.download:SetActive(false)
        self.downloading:SetActive(false)
        self._state = UIReviewState.Normal
        Log.debug("[Review] 已下载未完成")
      elseif self._data:IsDownLoading() then
        self.download:SetActive(false)
        self.downloading:SetActive(true)
        self._state = UIReviewState.Downloading
        self:StartTask(self._OnDownloading, self)
        Log.debug("[Review] 正在下载")
      else
        self.download:SetActive(true)
        self.downloading:SetActive(false)
        self._state = UIReviewState.Download
        Log.debug("[Review] 待下载")
      end
    end
  else
    self.unlock:SetActive(true)
    self.download:SetActive(false)
    self.downloading:SetActive(false)
    self.finish:SetActive(false)
    local asset = self._data:UnlockCost()
    self.itemcount:SetText("×" .. asset.count)
    if self._data:CanUnlock() then
      self.itemcount.color = Color.green
      self._state = UIReviewState.CanUnlock
      Log.debug("[Review] 可解锁")
    else
      self.itemcount.color = Color.red
      self._state = UIReviewState.CannotUnlock
      Log.debug("[Review] 无法解锁")
    end
  end
end

function UIActivityReviewItem:OnUnlock(id)
  if self._data:ActivityID() == id or not self._data:IsUnlock() then
    self:Refresh()
  end
end

function UIActivityReviewItem:OnDownloadFinish(assetPackageID)
  if self._data:AssetPackageID() == assetPackageID then
    self:Refresh()
  end
end

function UIActivityReviewItem:OnStartDownload(id)
  if self._data:ActivityID() == id then
    self._state = UIReviewState.Downloading
    self._data:Download()
    self:RefreshState()
    self:StartTask(self._OnDownloading, self)
  end
end

function UIActivityReviewItem:OnItemCountChanged()
  self:RefreshState()
end

function UIActivityReviewItem:_OnDownloading(TT)
  while self._data:IsDownLoading() do
    local value = self._data:DownloadProgress()
    self.progress.fillAmount = value
    self.percent:SetText(math.floor(value * 100) .. "%")
    YIELD(TT)
    if not self._isActive then
      return
    end
  end
  if self._data:IsDownloaded() then
    self:RefreshState()
  end
end
