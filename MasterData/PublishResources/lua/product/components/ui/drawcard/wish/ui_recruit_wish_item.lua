_class("UIRecruitWishItem", UICustomWidget)
UIRecruitWishItem = UIRecruitWishItem

function UIRecruitWishItem:Constructor()
  self._atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
end

function UIRecruitWishItem:OnShow()
  self:UIWidget()
  self:CreatePetItem()
end

function UIRecruitWishItem:OnHide()
end

function UIRecruitWishItem:AddBtnOnClick(go)
  if self._selectionCB ~= nil then
    self._selectionCB(self._elementType, self._petTid)
  end
end

function UIRecruitWishItem:BtnChangeOnClick(go)
  if self._selectionCB ~= nil then
    self._selectionCB(self._elementType, self._petTid)
  end
end

function UIRecruitWishItem:UIWidget()
  self._uiAdd = self:GetUIComponent("RectTransform", "uiAdd")
  self._uiPetWish = self:GetUIComponent("RectTransform", "uiPetWish")
  self._addAttribute = self:GetUIComponent("Image", "addAttribute")
  self._petItem = self:GetUIComponent("UISelectObjectPath", "petItem")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIRecruitWishItem:CreatePetItem()
  self._uiPetItem = self._petItem:SpawnObjects("UIDrawCardAwardPetItem", 1)
  self._uiPetItem = self._uiPetItem[1]
end

function UIRecruitWishItem:SetData(elementType, petTid, selectionCB)
  self._elementType = elementType
  self._petTid = petTid
  self._selectionCB = selectionCB
  self:Flush()
end

function UIRecruitWishItem:SetPetTid(petTid)
  self._petTid = petTid
  self:Flush()
end

function UIRecruitWishItem:Flush()
  self._uiAdd.gameObject:SetActive(self._petTid == 0 or self._petTid ~= 0)
  self._uiPetWish.gameObject:SetActive(self._petTid ~= 0)
  local cfgAttribute = Cfg.cfg_pet_element[self._elementType]
  self._addAttribute.sprite = self._atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfgAttribute.Icon))
  if self._petTid ~= 0 then
    self._uiPetItem:SetData(6, self._petTid, nil)
    self._uiPetItem:ShowPetAwakening(true)
    self._uiPetItem:RootLocalScale(Vector3(0.9, 0.9, 0.9))
    self._uiPetItem:AnimRootPosition(Vector2(0, -126))
  end
end
