local UIHeroQuickLvUpWindow = class("UIHeroQuickLvUpWindow", UIBaseWindow)
local base = UIBaseWindow
local UINHeroHeadWithStarItem = require("Game.CommonUI.Hero.UINHeroHeadWithStarItem")
local cs_MessageCommon = CS.MessageCommon

function UIHeroQuickLvUpWindow:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Cancle, self, self.OnClickBtnCancle)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickBtnConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickBtnClose)
  self.__OnItemClick = BindCallback(self, self.OnItemClick)
  self.__OnWindowClose = BindCallback(self, self.OnHeroQuickLvUpWindowClose)
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  self.ui.uiNHeroHeadItem:SetActive(false)
  self.heroItemDic = {}
  self._selectHeroId = nil
end

function UIHeroQuickLvUpWindow:InitHeroQuickLvWindow(itemCfg)
  self._itemCfg = itemCfg
  local golevelCfg = ConfigData.hero_golevel[itemCfg.id]
  local lvLimitHeroList = PlayerDataCenter:GetLvLimitHeroList(golevelCfg.choose_use_level)
  self._heroDataList = lvLimitHeroList
  self.ui.scrollRect.totalCount = #self._heroDataList
  self.ui.scrollRect:RefillCells()
end

function UIHeroQuickLvUpWindow:__OnInstantiateItem(go)
  local heroItem = UINHeroHeadWithStarItem.New()
  heroItem:Init(go)
  self.heroItemDic[go] = heroItem
end

function UIHeroQuickLvUpWindow:__OnChangeItem(go, index)
  local heroItem = self.heroItemDic[go]
  if heroItem == nil then
    error("cant find heroItem")
  end
  local heroData = self._heroDataList[index + 1]
  if heroData == nil then
    error("cant find heroData")
  end
  heroItem:InitHead(heroData, true, false, self.__OnItemClick)
  if self._selectHeroId ~= nil then
    local item = self:__GetHeroItemById(self._selectHeroId)
    local itemVisiable = self:IsHeroItemVisiable(item)
    self.ui.img_Selected.gameObject:SetActive(itemVisiable)
    if itemVisiable and heroItem.heroData.dataId == self._selectHeroId then
      self.ui.img_Selected:SetParent(heroItem.transform)
      self.ui.img_Selected.anchoredPosition = Vector2.Temp(0, 0)
    end
  end
end

function UIHeroQuickLvUpWindow:IsHeroItemVisiable(item)
  if item == nil then
    return false
  end
  return self.ui.scrollRect:IsItemVisiable(item.transform)
end

function UIHeroQuickLvUpWindow:__GetHeroItemById(heroId)
  for k, v in ipairs(self._heroDataList) do
    if v.dataId == heroId then
      local index = k - 1
      return self:__GetHeroItemByIndex(index)
    end
  end
  return nil
end

function UIHeroQuickLvUpWindow:__GetHeroItemByData(heroData)
  for k, v in ipairs(self._heroDataList) do
    if v == heroData then
      local index = k - 1
      return self:__GetHeroItemByIndex(index)
    end
  end
  return nil
end

function UIHeroQuickLvUpWindow:__GetHeroItemByIndex(index)
  local go = self.ui.scrollRect:GetCellByIndex(index)
  if go ~= nil then
    return self.heroItemDic[go]
  end
  return nil
end

function UIHeroQuickLvUpWindow:OnClickBtnCancle()
  self:OnHeroQuickLvUpWindowClose()
end

function UIHeroQuickLvUpWindow:OnClickBtnConfirm()
  if self._selectHeroId == nil then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7907))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroQuickLvUpMain, function(win)
    if win == nil then
      return
    end
    win:InitHeroQuickLvUpMain(self._itemCfg, self._selectHeroId, self.__OnWindowClose)
  end)
end

function UIHeroQuickLvUpWindow:OnClickBtnClose()
  self:OnHeroQuickLvUpWindowClose()
end

function UIHeroQuickLvUpWindow:OnItemClick(heroData)
  if self._selectHeroId ~= nil and self._selectHeroId == heroData.dataId then
    return
  end
  local heroItem = self:__GetHeroItemByData(heroData)
  self._selectHeroId = heroData.dataId
  self.ui.img_Selected.gameObject:SetActive(true)
  self.ui.img_Selected:SetParent(heroItem.transform)
  self.ui.img_Selected.anchoredPosition = Vector2.Temp(0, 0)
end

function UIHeroQuickLvUpWindow:BackAction()
  self:Delete()
end

function UIHeroQuickLvUpWindow:OnHeroQuickLvUpWindowClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIHeroQuickLvUpWindow:OnDelete()
  base.OnDelete(self)
end

return UIHeroQuickLvUpWindow
