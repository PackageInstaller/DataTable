_class("UIXiaoLinJiaCollectionController", UIController)
UIXiaoLinJiaCollectionController = UIXiaoLinJiaCollectionController

function UIXiaoLinJiaCollectionController:Constructor()
  self.atlas = self:GetAsset("XiaoLinJia.spriteatlas", LoadType.SpriteAtlas)
end

function UIXiaoLinJiaCollectionController:OnShow(uiParams)
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._backBtns = backBtns:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    self:Lock("UIXiaoLinJiaCollectionController_Close")
    self._anim:Play("uieff_UIXiaoLinJiaCollectionController_out")
    self:StartTask(function(TT)
      YIELD(TT, 167)
      self:CloseDialog()
      self:UnLock("UIXiaoLinJiaCollectionController_Close")
    end)
  end, nil, nil, false, nil, nil, nil)
  self.uiMainController = uiParams[1]
  self._content = self:GetUIComponent("UISelectObjectPath", "content")
  self._contentLayout = self:GetUIComponent("GridLayoutGroup", "content")
  self._contentRect = self:GetUIComponent("RectTransform", "content")
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._detail = self:GetUIComponent("UILocalizationText", "detail")
  self._lockText = self:GetUIComponent("UILocalizationText", "lockText")
  self._lockObj = self:GetGameObject("lockObj")
  local offsetL = (ResolutionManager.RealWidth() - 1920) / 1.875
  local offsetR = (ResolutionManager.RealWidth() - 1920) / 1.6
  self._contentLayout.padding.left = ResolutionManager.RealWidth() / 2 - 180 - offsetL
  self._contentLayout.padding.right = ResolutionManager.RealWidth() / 2 - 240 - offsetR
  self._padding = 480
  self:OnValue()
end

function UIXiaoLinJiaCollectionController:OnValue()
  local componentID = self.uiMainController:GetTacitTestComponentCfgId()
  self.collectionCfg = Cfg.cfg_xiaolinjia_collection({ComponentID = componentID})
  self.collectionList = {}
  local missionList = self.uiMainController:GetMissionList()
  if self.collectionCfg then
    for _, v in pairs(self.collectionCfg) do
      if missionList[v.MissionID]:GetIsHide() and missionList[v.MissionID]:GetIsLock() then
      else
        self.collectionList[v.ID] = v
      end
    end
  end
  self._content:SpawnObjects("UIXiaoLinJiaCollectionItem", #self.collectionList)
  self.pool = self._content:GetAllSpawnList()
  for i = 1, #self.collectionList do
    self.pool[i]:SetData(self.collectionList[i], self)
  end
  self.pool[1]:BtnOnClick()
end

function UIXiaoLinJiaCollectionController:OnSelectCollection(id, lock)
  if self.selectId == id then
    return
  end
  for _, v in pairs(self.pool) do
    v:OnSelect(self.selectId, id)
  end
  self.selectId = id
  local posX = self._padding * (id - 1)
  local pos = self._contentRect.anchoredPosition
  self._contentRect:DOAnchorPosX(-posX, 0.3)
  local cfg = self.collectionList[id]
  if lock then
    self._lockObj:SetActive(true)
    self._title:SetText(StringTable.Get(cfg.LockName))
    self._title.color = Color(0.5764705882352941, 0.5764705882352941, 0.5764705882352941, 1)
    self._detail:SetText(StringTable.Get(cfg.LockClue))
    self._lockText:SetText(StringTable.Get(cfg.LockRoleSpeak))
  else
    self._lockObj:SetActive(false)
    self._title:SetText(StringTable.Get(cfg.UnlockName))
    self._title.color = Color(1, 0.2196078431372549, 0.4745098039215686, 1)
    self._detail:SetText(StringTable.Get(cfg.Desc))
    self._lockText:SetText(StringTable.Get(cfg.UnlockRoleSpeak))
  end
end
