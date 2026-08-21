_class("UISeasonCollectionController", UIController)
UISeasonCollectionController = UISeasonCollectionController

function UISeasonCollectionController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonCollectionController:OnShow(uiParams)
  self:InitWidget()
  self:_RefreshCgNew()
  self:_RefreshMusicNew()
  self:_RefreshRareItemNew()
end

function UISeasonCollectionController:InitWidget()
  local topBtns = self:GetUIComponent("UISelectObjectPath", "TopBtns")
  self._backBtns = topBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, nil, function()
    local currentStateUI = GameGlobal.UIStateManager():CurUIStateType()
    if currentStateUI == UIStateType.UISeasonExploreMainController then
      self:SwitchState(UIStateType.UIMain)
    else
      GameGlobal.GetUIModule(SeasonModule):ExitSeasonTo(UIStateType.UIMain)
    end
  end)
  self.cgBtn = self:GetUIComponent("Image", "CgBtn")
  self.musicBtn = self:GetUIComponent("Image", "MusicBtn")
  self.rareBtn = self:GetUIComponent("Image", "RareBtn")
  self.newCg = self:GetGameObject("newCg")
  self.newMusic = self:GetGameObject("newMusic")
  self.newRare = self:GetGameObject("newRare")
end

function UISeasonCollectionController:CgBtnOnClick(go)
  self:ShowDialog("UISeasonCgCollectionController", function()
    self:_RefreshCgNew()
  end)
end

function UISeasonCollectionController:MusicBtnOnClick(go)
  self:ShowDialog("UISeasonMusicCollectionController", function()
    self:_RefreshMusicNew()
  end)
end

function UISeasonCollectionController:RareBtnOnClick(go)
  self:ShowDialog("UISeasonRareCollectionController", function()
    self:_RefreshRareItemNew()
  end)
end

function UISeasonCollectionController:_RefreshCgNew()
  local hasNew = UISeasonExploreHelper.IsSeasonCgHasNew()
  self.newCg:SetActive(hasNew)
end

function UISeasonCollectionController:_RefreshMusicNew()
  local hasNew = UISeasonExploreHelper.IsSeasonMusicHasNew()
  self.newMusic:SetActive(hasNew)
end

function UISeasonCollectionController:_RefreshRareItemNew()
  local hasNew = UISeasonExploreHelper.IsSeasonRareItemHasNew()
  self.newRare:SetActive(hasNew)
end
