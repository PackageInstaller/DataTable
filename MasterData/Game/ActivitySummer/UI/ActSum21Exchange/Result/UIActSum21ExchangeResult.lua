local UIActSum21ExchangeResult = class("UIActSum21ExchangeResult", UIBaseWindow)
local base = UIBaseWindow
local UINActSum21ExcgResultItem = require("Game.ActivitySummer.UI.ActSum21Exchange.Result.UINActSum21ExcgResultItem")

function UIActSum21ExchangeResult:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnClickClose)
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self._ItemDic = {}
end

function UIActSum21ExchangeResult:InitActSum21ExchangeResult(rewardDataList, closeFunc)
  self.rewardDataList = rewardDataList
  self.closeFunc = closeFunc
  self:_RefillScrollRect()
end

function UIActSum21ExchangeResult:_RefillScrollRect()
  self.ui.scrollRect.totalCount = #self.rewardDataList
  self.ui.scrollRect:RefillCells()
end

function UIActSum21ExchangeResult:__OnNewItem(go)
  local item = UINActSum21ExcgResultItem.New()
  item:Init(go)
  self._ItemDic[go] = item
end

function UIActSum21ExchangeResult:__OnChangeItem(go, index)
  local item = self._ItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local rewardData = self.rewardDataList[index + 1]
  if rewardData == nil then
    error("Can't find rewardData by index, index = " .. tonumber(index))
  end
  item:InitActSum21ExcgResultItem(rewardData.itemId, rewardData.itemNum, rewardData.groupNum)
end

function UIActSum21ExchangeResult:_OnClickClose()
  self:Delete()
  if self.closeFunc ~= nil then
    self.closeFunc()
  end
end

function UIActSum21ExchangeResult:OnDelete()
  for k, v in pairs(self._ItemDic) do
    v:Delete()
  end
  DestroyUnityObject(self.ui.scrollRect)
  base.OnDelete(self)
end

return UIActSum21ExchangeResult
