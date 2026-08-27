local base = UIBaseWindow
local UIAthRefactorConfirm = class("UIAthRefactorConfirm", base)
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local UINAthItem = require("Game.Arithmetic.AthList.Area.UINAthItem")

function UIAthRefactorConfirm:OnInit()
  self.costItem = UINBaseItem.New()
  self.costItem:Init(self.ui.uINBaseItem)
  self.athItemPool = UIItemPool.New(UINAthItem, self.ui.athTwoPiece, false)
  self.resLoader = CS.ResLoader.Create()
  self._OnClickAthItemFunc = BindCallback(self, self._OnClickAthItem)
  UIUtil.AddButtonListener(self.ui.buttonYes, self, self._OnClickYes)
  UIUtil.AddButtonListener(self.ui.buttonNo, self, self._OnClickNo)
end

function UIAthRefactorConfirm:InitAthRefactorConfirm(athUidList, refactorNum, costTotalNum, confirmFunc)
  self.confirmFunc = confirmFunc
  self.ui.tex_Msg:SetIndex(0, tostring(costTotalNum), tostring(refactorNum))
  local costItemNum = costTotalNum - #athUidList
  if 0 < costItemNum then
    self.ui.consumeItem:SetActive(true)
    local consumeItemId = ConfigData.game_config.athRefactorTokenIdList[1]
    local itemCfg = ConfigData.item[consumeItemId]
    self.costItem:InitBaseItem(itemCfg)
    self.costItem:SetNotNeedAnyJump(true)
    self.ui.tex_CostNum.text = tostring(costItemNum)
  else
    self.ui.consumeItem:SetActive(false)
  end
  for k, uid in ipairs(athUidList) do
    local athData = PlayerDataCenter.allAthData.athDic[uid]
    local athItem = self.athItemPool:GetOne()
    athItem:InitAthItem(athData, self._OnClickAthItemFunc, self.resLoader)
  end
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.scrollRect.content)
  self.ui.scrollRect.horizontalNormalizedPosition = 0
end

function UIAthRefactorConfirm:_OnClickAthItem(athItem)
  local athData = athItem:GetAthItemData()
  UIManager:ShowWindowAsync(UIWindowTypeID.AthItemDetailFloat, function(window)
    if window == nil then
      return
    end
    window:InitAthDetailFloat(athData, true, true)
  end)
end

function UIAthRefactorConfirm:_OnClickYes()
  if self.confirmFunc then
    self.confirmFunc()
  end
  self:Delete()
end

function UIAthRefactorConfirm:_OnClickNo()
  self:Delete()
end

function UIAthRefactorConfirm:OnDelete()
  self.costItem:Delete()
  self.athItemPool:DeleteAll()
  self.resLoader:Put2Pool()
  self.resLoader = nil
  base.OnDelete(self)
end

return UIAthRefactorConfirm
