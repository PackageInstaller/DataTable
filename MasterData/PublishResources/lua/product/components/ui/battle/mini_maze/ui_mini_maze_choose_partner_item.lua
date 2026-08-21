_class("UIMiniMazeChoosePartnerItem", UICustomWidget)
UIMiniMazeChoosePartnerItem = UIMiniMazeChoosePartnerItem

function UIMiniMazeChoosePartnerItem:OnShow(uiParam)
  self._atlas = self:GetAsset("UIMazeChoose.spriteatlas", LoadType.SpriteAtlas)
end

function UIMiniMazeChoosePartnerItem:GetComponents()
  self._card = self:GetUIComponent("RectTransform", "card")
  self._itemPool = self:GetUIComponent("UISelectObjectPath", "itemPool")
  self._itemPoolCanvasGroup = self:GetUIComponent("CanvasGroup", "itemPool")
  self._selectAreaGO = self:GetGameObject("SelectArea")
  self._notSelectGO = self:GetGameObject("NotSelect")
  self._selectGO = self:GetGameObject("Select")
end

function UIMiniMazeChoosePartnerItem:SetData(index, partnerID, pos, _cardClick)
  self:GetComponents()
  self._partnerID = partnerID
  self._petID = Cfg.cfg_mini_maze_partner_info[partnerID].PetID
  self._index = index
  self._pos = pos
  self._callback = _cardClick
  self._canClick = false
  self._item = self._itemPool:SpawnObject("UIMiniMazePartnerItem")
  
  local function cbFunc()
    self:CardClick()
  end
  
  self._item:SetData(self._partnerID, self._index, cbFunc, self._index)
  self._card:DOScale(Vector3(1, 1, 1), 0.2)
  self._card:DOMove(pos, 0.2):OnComplete(function()
    self._canClick = true
  end)
  self._colorBg = self:GetUIComponent("Image", "colorBg")
  self._colorBg.gameObject:SetActive(false)
  local cfg_pet = Cfg.cfg_pet[self._petID]
  if cfg_pet then
    local color = cfg_pet.Star
    self._colorBg.sprite = self._atlas:GetSprite("map_xuanzhong_di" .. color)
  end
end

function UIMiniMazeChoosePartnerItem:CardClick()
  if self._canClick == true then
    self._callback(self._index)
  end
end

function UIMiniMazeChoosePartnerItem:Flush(itemid)
  self:Lock("UIMiniMazeChoosePartnerItem:Flush")
  self._itemPoolCanvasGroup:DOFade(0, 0.5)
  self._card:DOScale(Vector3(0.1, 0.1, 0.1), 0.5):OnComplete(function()
    self._card:DOScale(Vector3(1, 1, 1), 0.1)
    self._itemPoolCanvasGroup:DOFade(1, 0.1)
    self:UnLock("UIMiniMazeChoosePartnerItem:Flush")
    self._item:Flush(itemid)
  end)
end

function UIMiniMazeChoosePartnerItem:CancelOrSelect(select)
  self:SetSelected(select)
end

function UIMiniMazeChoosePartnerItem:MoveTwwen(move, pos)
  if move then
    self._card:DOMove(pos, 0.2)
  else
    self._card.gameObject:SetActive(false)
  end
end

function UIMiniMazeChoosePartnerItem:SetSelected(bSelect)
  self._selectGO:SetActive(bSelect)
  self._notSelectGO:SetActive(not bSelect)
end
