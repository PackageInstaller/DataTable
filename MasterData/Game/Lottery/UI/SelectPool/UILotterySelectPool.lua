local base = UIBaseWindow
local UILotterySelectPool = class("UILotterySelectPool", base)
local UINLtrSelectPoolItem = require("Game.Lottery.UI.SelectPool.UINLtrSelectPoolItem")
local cs_MessageCommon = CS.MessageCommon

function UILotterySelectPool:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnClickConfirm)
  self._optionPool = UIItemPool.New(UINLtrSelectPoolItem, self.ui.option, false)
  self._OnSelectOptionFunc = BindCallback(self, self._OnSelectOption)
end

function UILotterySelectPool:InitLtrSelectPool(ltrGroupData, defaultSelectLtrId, confirmFunc)
  self.confirmFunc = confirmFunc
  self.ltrDataList = ltrGroupData:GetLtrInGroupDataList()
  for i = 1, 2 do
    local ltrData = self.ltrDataList[i]
    local optionItem = self._optionPool:GetOne()
    optionItem:InitLtrSelectPoolItem(ltrData, self._OnSelectOptionFunc)
    if ltrData.poolId == defaultSelectLtrId then
      self:_OnSelectOption(optionItem, ltrData)
    else
      optionItem:UpdLtrPoolItemSelect(false)
    end
  end
  if defaultSelectLtrId == 0 then
    self.ui.img_Locked:SetActive(true)
    self.ui.obj_Select.gameObject:SetActive(false)
  end
end

function UILotterySelectPool:_OnSelectOption(optionItem, ltrData)
  if self._lastSelectOptionItem == optionItem then
    return
  end
  self._curSelectLtrData = ltrData
  if self._lastSelectOptionItem ~= nil then
    self._lastSelectOptionItem:UpdLtrPoolItemSelect(false)
  end
  optionItem:UpdLtrPoolItemSelect(true)
  self._lastSelectOptionItem = optionItem
  self.ui.img_Locked:SetActive(false)
  self.ui.obj_Select.gameObject:SetActive(true)
  self.ui.obj_Select:SetParent(optionItem.transform)
  self.ui.obj_Select.anchoredPosition = Vector2.zero
end

function UILotterySelectPool:BackAction()
  if self._curSelectLtrData == nil then
    self._curSelectLtrData = self.ltrDataList[1]
  end
  if self.confirmFunc ~= nil then
    self.confirmFunc(self._curSelectLtrData)
  end
  UIUtil.ReShowTopStatus()
  self:Delete()
end

function UILotterySelectPool:_OnClickConfirm()
  if self._curSelectLtrData == nil then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(318))
    return
  end
  UIUtil.OnClickBackByUiTab(self)
end

function UILotterySelectPool:OnDelete()
  self._optionPool:DeleteAll()
  base.OnDelete(self)
end

return UILotterySelectPool
