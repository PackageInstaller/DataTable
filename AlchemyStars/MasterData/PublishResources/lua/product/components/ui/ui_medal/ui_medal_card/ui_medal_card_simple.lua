_class("UIMedalCardSimple", UICustomWidget)
UIMedalCardSimple = UIMedalCardSimple

function UIMedalCardSimple:Constructor()
  self._eventBoardMedalUpdate = nil
  self._Width = 0
end

function UIMedalCardSimple:OnShow(uiParams)
  self.medalModule = GameGlobal.GetModule(MedalModule)
  self.editData = self.medalModule:GetN22MedalEditData()
  self:InitWidget()
end

function UIMedalCardSimple:OnHide()
  if self._eventBoardMedalUpdate then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.BoardMedalUpdate, self._eventBoardMedalUpdate)
    self._eventBoardMedalUpdate = nil
  end
end

function UIMedalCardSimple:InitWidget()
  self.bg = self:GetUIComponent("RawImageLoader", "bg")
  self.root = self:GetUIComponent("UISelectObjectPath", "root")
  self.rootRt = self:GetUIComponent("RectTransform", "root")
end

function UIMedalCardSimple:OnBoardMedalUpdate()
  local placeData = GameGlobal.GetModule(MedalModule):GetPlacementInfo()
  self:SetData(self._Width, placeData, nil, self.callback)
end

function UIMedalCardSimple:SetData(width, placeData, isVisit, callback)
  self._Width = width
  self.callback = callback
  if not isVisit and not self._eventBoardMedalUpdate then
    self._eventBoardMedalUpdate = GameHelper:GetInstance():CreateCallback(self.OnBoardMedalUpdate, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.BoardMedalUpdate, self._eventBoardMedalUpdate)
  end
  local sz = self.rootRt.sizeDelta
  sz.y = sz.y / sz.x * width
  sz.x = width
  self.rootRt.sizeDelta = sz
  local cfg = Cfg.cfg_item_medal_board[placeData.board_back_id]
  if cfg then
    self.bg:LoadImage(cfg.IconHD)
  else
    self.bg:LoadImage("N22_xzxt_di04")
  end
  local boardMedals = self.editData:GetMappingBoardMedalList(width, placeData)
  table.sort(boardMedals, function(a, b)
    return a.index < b.index
  end)
  local count = table.count(boardMedals)
  self.root:SpawnObjects("UIMedalCardIcon", count)
  local allItems = self.root:GetAllSpawnList()
  for k, subItem in pairs(allItems) do
    if k <= count then
      subItem:SetData(boardMedals[k])
    end
  end
end

function UIMedalCardSimple:BgOnClick(go)
  if self.callback then
    self.callback()
  end
end

_class("UIMedalCardIcon", UICustomWidget)
UIMedalCardIcon = UIMedalCardIcon

function UIMedalCardIcon:Constructor()
  self._atlas = self:GetAsset("UIMedal.spriteatlas", LoadType.SpriteAtlas)
  self._itemId = nil
end

function UIMedalCardIcon:OnShow(uiParams)
  self:InitWidget()
end

function UIMedalCardIcon:InitWidget()
  self.icon = self:GetUIComponent("Image", "Icon")
  self.iconRt = self:GetUIComponent("RectTransform", "Icon")
end

function UIMedalCardIcon:SetData(boardMedal)
  self.icon.sprite = self._atlas:GetSprite(boardMedal:IconMedal())
  self.iconRt.anchoredPosition = boardMedal.pos
  self.iconRt.sizeDelta = boardMedal.wh
  self.iconRt.localRotation = boardMedal.quat
  self._itemId = boardMedal.id
end

function UIMedalCardIcon:IconOnClick(go)
  self:ShowDialog("UIMedalTipsController", self._itemId)
end
