local UISelectSupportHero = class("UISelectSupportHero", UIBaseWindow)
local base = UIBaseWindow
local UINHeroHeadWithStarItem = require("Game.CommonUI.Hero.UINHeroHeadWithStarItem")

function UISelectSupportHero:OnInit()
  self.netWorkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Object)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListenerWithArg(self.ui.btn_Cancel, self, self.OnReturnClick)
  UIUtil.AddButtonListener(self.ui.btn_Comfirm, self, self.OnClickConfirm)
  self.itemDic = {}
  self.heroList = {}
  self.__curSelectedHeroData = nil
  self.__onClickHeroHeadItem = BindCallback(self, self.OnClickHeroHeadItem)
  self.ui.loopScrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.loopScrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.loopScrollRect.onReturnItem = BindCallback(self, self.__OnReturnItem)
  self.ui.obj_Select:SetActive(false)
  self.__OnHeroUpdate = BindCallback(self, self._OnHeroUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__OnHeroUpdate)
end

function UISelectSupportHero:InitSelectSupportHero(index, curSelectHeroId, SelectedHeroIdDic, onChangeCallback)
  self.index = index
  self.curSelectHeroId = curSelectHeroId
  self.SelectedHeroIdDic = SelectedHeroIdDic
  self.onChangeCallback = onChangeCallback
  local count = 0
  for heroId, heroData in pairs(PlayerDataCenter.heroDic) do
    if curSelectHeroId == heroId or SelectedHeroIdDic[heroId] == nil then
      if curSelectHeroId == heroId then
        self.__curSelectedHeroData = heroData
      end
      table.insert(self.heroList, heroData)
      count = count + 1
    end
  end
  table.sort(self.heroList, function(heroDataA, heroDataB)
    if heroDataA.rank ~= heroDataB.rank then
      return heroDataA.rank > heroDataB.rank
    end
    local powA = heroDataA:GetFightingPower()
    local powB = heroDataB:GetFightingPower()
    if powA ~= powB then
      return powA > powB
    end
    return heroDataA.dataId < heroDataB.dataId
  end)
  local targetIndex = (table.indexof(self.heroList, self.__curSelectedHeroData) or 1) - 1
  local offset = 0
  if targetIndex > #self.heroList - 5 and #self.heroList % 6 > 2 then
    offset = 50
  end
  self.ui.loopScrollRect.totalCount = count
  self.ui.loopScrollRect:RefillCells(targetIndex, offset)
end

function UISelectSupportHero:__OnNewItem(go)
  local heroItem = UINHeroHeadWithStarItem.New()
  heroItem:Init(go)
  self.itemDic[go] = heroItem
end

function UISelectSupportHero:__OnChangeItem(go, index)
  local heroItem = self.itemDic[go]
  if heroItem == nil then
    error("Can't find heroItem by gameObject")
    return
  end
  local heroData = self.heroList[index + 1]
  if heroData == nil then
    error("Can't find levelData by index, index = " .. tonumber(index))
  end
  if self.__curSelectedHeroData == heroData then
    self.ui.obj_Select.transform:SetParent(heroItem.transform)
    self.ui.obj_Select.transform.anchoredPosition = Vector2.zero
    self.ui.obj_Select:SetActive(true)
  end
  heroItem:InitHead(heroData, nil, nil, self.__onClickHeroHeadItem)
end

function UISelectSupportHero:__OnReturnItem(go)
  local heroItem = self.itemDic[go]
  if heroItem.heroData == self.__curSelectedHeroData then
    self.ui.obj_Select:SetActive(false)
  end
end

function UISelectSupportHero:OnClickHeroHeadItem(heroData)
  if self.__curSelectedHeroData == heroData then
    self.__curSelectedHeroData = nil
    self.ui.obj_Select:SetActive(false)
  else
    self.__curSelectedHeroData = heroData
    for _, heroItem in pairs(self.itemDic) do
      if heroItem.heroData == heroData then
        self.ui.obj_Select.transform:SetParent(heroItem.transform)
        self.ui.obj_Select.transform.anchoredPosition = Vector2.zero
        self.ui.obj_Select:SetActive(true)
      end
    end
  end
end

function UISelectSupportHero:OnClickConfirm()
  if self.__curSelectedHeroData == nil and self.curSelectHeroId ~= nil then
    self.netWorkCtrl:CS_ASSISTANT_Uninstall(self.curSelectHeroId, function()
      PlayerDataCenter.inforData:SetSelfSupportHoreId(self.index, nil)
      if self.onChangeCallback ~= nil then
        self.onChangeCallback()
      end
      UIUtil.OnClickBackByUiTab(self)
    end)
  elseif self.__curSelectedHeroData ~= nil and self.curSelectHeroId ~= self.__curSelectedHeroData.dataId then
    local heroId = self.__curSelectedHeroData.dataId
    self.netWorkCtrl:CS_ASSISTANT_Install(heroId, self.index, function()
      PlayerDataCenter.inforData:SetSelfSupportHoreId(self.index, heroId)
      if self.onChangeCallback ~= nil then
        self.onChangeCallback()
      end
      UIUtil.OnClickBackByUiTab(self)
    end)
  else
    UIUtil.OnClickBackByUiTab(self)
  end
end

function UISelectSupportHero:_OnHeroUpdate()
  for _, heroItem in pairs(self.itemDic) do
    heroItem:InitHead(heroItem.heroData, nil, nil, self.__onClickHeroHeadItem)
  end
end

function UISelectSupportHero:BackAction()
  self:Delete()
end

function UISelectSupportHero:OnReturnClick(isClickBackground)
  UIUtil.OnClickBackByUiTab(self)
end

function UISelectSupportHero:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__OnHeroUpdate)
  base.OnDelete(self)
end

return UISelectSupportHero
