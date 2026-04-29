_class("UISeasonStageEnemyBalckfistItem", UICustomWidget)
UISeasonStageEnemyBalckfistItem = UISeasonStageEnemyBalckfistItem

function UISeasonStageEnemyBalckfistItem:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonStageEnemyBalckfistItem:InitWidget()
  self.pet = self:GetUIComponent("RawImageLoader", "pet")
  self.secondAttribute1 = self:GetUIComponent("Image", "secondAttribute1")
  self.firstAttribute1 = self:GetUIComponent("Image", "firstAttribute1")
end

function UISeasonStageEnemyBalckfistItem:SetData(petImgName, elemt1, elemt2, clickCb)
  self._clickCb = clickCb
  self.pet:LoadImage(petImgName)
  self.secondAttribute1.gameObject:SetActive(elemt2 ~= nil)
  self.firstAttribute1.gameObject:SetActive(elemt1 ~= nil)
  if elemt2 then
    self.secondAttribute1.sprite = elemt2
  end
  if elemt1 then
    self.firstAttribute1.sprite = elemt1
  end
end

function UISeasonStageEnemyBalckfistItem:SetLeader(pet)
  local leaderPool = self:GetUIComponent("UISelectObjectPath", "leader")
  if not leaderPool then
    return
  end
  local leaderWidget = leaderPool:SpawnObject("UITeamsLeader")
  leaderWidget:Flush(pet, true)
end

function UISeasonStageEnemyBalckfistItem:RootOnClick(go)
  if self._clickCb then
    self._clickCb()
  end
end
