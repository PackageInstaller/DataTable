local UICommonGiftSelect = class("UICommonGiftSelect", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UICommonGiftSelect:OnInit()
  UIUtil.SetTopStatus(self, self.__OnClickBack, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_buttonYes, self, self.__OnClickYesBtn)
  UIUtil.AddButtonListener(self.ui.btn_buttonNo, self, self.__OnClickNoBtn)
  self.__onClickItem = BindCallback(self, self.__OnClickItem)
  self.itemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount)
  self.ui.uINBaseItemWithCount:SetActive(false)
  self.ui.obj_img_Select:SetActive(false)
end

function UICommonGiftSelect:InitCommonGiftSelect(itemList, numList, yesCallback, noCallback)
  self.__selectedOneIndex = nil
  self.__itemList = itemList
  self.__numList = numList
  self.__yesCallback = yesCallback
  self.__noCallback = noCallback
  self.__onClickCallback = nil
  self:__RefreshItemList()
end

function UICommonGiftSelect:SetTitleAndSubTitle(mainTitle, subTitle)
  if mainTitle ~= nil then
    self.ui.tex_title.text = ConfigData:GetTipContent(mainTitle)
  end
  if subTitle ~= nil then
    self.ui.tex_subTitle.text = ConfigData:GetTipContent(subTitle)
  end
end

function UICommonGiftSelect:SetOnItemClick(onClickCallback)
  self.__onClickCallback = onClickCallback
end

function UICommonGiftSelect:__RefreshItemList()
  self.itemPool:HideAll()
  for index, itemId in ipairs(self.__itemList) do
    local num = self.__numList[index]
    local item = self.itemPool:GetOne()
    local itemCfg = ConfigData.item[itemId]
    item:InitItemWithCount(itemCfg, num, self.__onClickItem, nil, nil, nil)
    item:BindClickCustomArg({index = index, item = item})
  end
end

function UICommonGiftSelect:__OnClickItem(itemCfg, clickArg)
  self.__selectedOneIndex = clickArg.index
  local item = clickArg.item
  if item ~= nil then
    self.ui.obj_img_Select.transform:SetParent(item.transform)
    self.ui.obj_img_Select.transform.localPosition = Vector3.zero
    self.ui.obj_img_Select:SetActive(true)
  end
  if self.__onClickCallback ~= nil then
    self.__onClickCallback(itemCfg, clickArg)
  end
end

function UICommonGiftSelect:__OnClickYesBtn()
  if self.__selectedOneIndex == nil then
    return
  end
  if self.__yesCallback ~= nil then
    self.__yesCallback(self.__selectedOneIndex)
  end
end

function UICommonGiftSelect:__OnClickNoBtn()
  if self.__noCallback ~= nil then
    self.__noCallback()
  end
  UIUtil.OnClickBackByUiTab(self)
end

function UICommonGiftSelect:__OnClickBack()
  self:Delete()
end

return UICommonGiftSelect
