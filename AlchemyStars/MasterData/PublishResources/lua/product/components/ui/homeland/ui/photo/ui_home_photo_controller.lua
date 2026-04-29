_class("UIHomePhotoController", UIController)
UIHomePhotoController = UIHomePhotoController

function UIHomePhotoController:OnShow(uiParams)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.HomelandAudioEnterMuseum)
  self:GetComponent()
  self:OnValue()
  AudioHelperController.PlayBGM(CriAudioIDConst.BGSeniorSkin, AudioConstValue.BGMCrossFadeTime)
end

function UIHomePhotoController:GetComponent()
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  self._btnPool = self:GetUIComponent("UISelectObjectPath", "btnPool")
  self._btnItem = self._btnPool:SpawnObject("UIHomeCommonCloseBtn")
  self._btnItem:SetData(function()
    self:closeBtnOnClick()
  end, nil, true)
end

function UIHomePhotoController:OnValue()
  self._datas = {}
  self._viewCfg = Cfg.cfg_home_photo_layout({})
  if self._viewCfg and next(self._viewCfg) then
    for i = 1, #self._viewCfg do
      local cfg = self._viewCfg[i]
      local data = {}
      data.group = cfg.Group
      data.index = cfg.Index
      data.title = cfg.Title
      data.icon = cfg.Iocn
      table.insert(self._datas, data)
    end
  end
  local maxCount = 0
  for i = 1, #self._datas do
    if maxCount < self._datas[i].index then
      maxCount = self._datas[i].index
    end
  end
  self._pool:SpawnObjects("UIHomePhotoEnterItem", maxCount)
  local pools = self._pool:GetAllSpawnList()
  for i = 1, #pools do
    local innerData = self:InnerData(i)
    local item = pools[i]
    item:Active(innerData)
    if innerData then
      local data = self:GetData(i)
      if data then
        item:SetData(data)
      end
    end
  end
end

function UIHomePhotoController:InnerData(idx)
  for i = 1, #self._datas do
    local data = self._datas[i]
    if data.index == idx then
      return true
    end
  end
  return false
end

function UIHomePhotoController:GetData(idx)
  for i = 1, #self._datas do
    local data = self._datas[i]
    if data.index == idx then
      return data
    end
  end
end

function UIHomePhotoController:OnHide()
  GameGlobal.GetUIModule(HomelandModule):GetClient():PlayHomelandBgm()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.RefreshInteractUI)
end

function UIHomePhotoController:closeBtnOnClick(go)
  self:CloseDialog()
end
