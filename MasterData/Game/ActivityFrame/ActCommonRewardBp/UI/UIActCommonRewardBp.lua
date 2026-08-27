local UIActCommonRewardBp = class("UIActCommonRewardBp", UIBaseWindow)
local base = UIBaseWindow
local ConditionListener = require("Game.Common.CheckCondition.ConditonListener.ConditionListener")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local UINCommonActivityBG = require("Game.ActivityFrame.UI.UINCommonActivityBG")
local UINActCommonRewardBpCycleItem = require("Game.ActivityFrame.ActCommonRewardBp.UI.UINActCommonRewardBpCycleItem")
local UINActCommonRewardBpEmptyElement = require("Game.ActivityFrame.ActCommonRewardBp.UI.UINActCommonRewardBpEmptyElement")
local UINActCommonRewardBpItem = require("Game.ActivityFrame.ActCommonRewardBp.UI.UINActCommonRewardBpItem")
local cs_ResLoader = CS.ResLoader

function UIActCommonRewardBp:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseBouns)
  UIUtil.AddButtonListener(self.ui.btn_ReceiveAll, self, self.OnClickPickedAll)
  self.ui.scroll.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.scroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__OnPickedSingleCallback = BindCallback(self, self.__OnPickedSingle)
  self.__OnPickedSingleCycleCallback = BindCallback(self, self.__OnPickedSingleCycle)
  self._goItem = {}
  self._conditionListener = ConditionListener.New()
  self._actBgNode = UINCommonActivityBG.New()
  self._actBgNode:Init(self.ui.uI_CommonActivityBG)
  self._resloader = cs_ResLoader.Create()
end

function UIActCommonRewardBp:InitActivityCommonRewardBp(actCommonRewardBpData)
  self._data = actCommonRewardBpData
  self:__InitFixed()
  self:__Refresh()
  self._actBgNode:InitActivityBG(self._data:GetActFrameId(), self._resloader)
end

function UIActCommonRewardBp:RefreshActivityCommonRewardBp()
  self:__Refresh()
end

function UIActCommonRewardBp:SetCloseCallback(closeCallback)
  self._closeCallback = closeCallback
end

function UIActCommonRewardBp:__InitFixed()
  local itemId = self._data:GetRewardBpTokenItemId()
  self.ui.tex_TokenName.text = ConfigData:GetItemName(itemId)
  self.ui.img_Token.sprite = CRH:GetSpriteByItemId(itemId)
  local itemCfg = ConfigData.item[itemId]
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(itemCfg.describe)
  local totalCount = self._data:GetCommonRewardLvLimit()
  if self._data:GetIsHaveCirReward() then
    totalCount = totalCount + 1
  end
  self.ui.scroll.totalCount = totalCount
  local targetIndex = self._data:GetCommonRewardCurLv()
  for i = 1, targetIndex do
    if self._data:IsCommonRewardLevelCanPick(i) then
      targetIndex = i
      break
    end
  end
  self.ui.scroll:RefillCells(targetIndex - 1, 200)
  self.ui.scroll:SrollToCell(targetIndex - 1, 9999)
end

function UIActCommonRewardBp:__Refresh()
  self.ui.tex_TokenNum:SetIndex(0, tostring(self._data:GetCommonRewardAllExp()))
  self.ui.tex_Lvl:SetIndex(0, tostring(self._data:GetCommonRewardCurLv()))
  local limitNum = self._data:GetCommonRewardCurExpLimit()
  local tempExp
  if limitNum == 0 then
    tempExp = self._data:GetCommonRewardCurExp()
  else
    tempExp = self._data:GetCommonRewardCurExp() % self._data:GetCommonRewardCurExpLimit()
  end
  local remainExp = self._data:GetCommonRewardCurExpLimit() - tempExp
  self.ui.tex_Exp.text = tostring(remainExp)
  self.ui.tex_Exp.gameObject:SetActive(0 < remainExp)
  self.ui.tex_ExpParent.gameObject:SetActive(0 < remainExp)
  for k, v in pairs(self._goItem) do
    v:RefreshBounsElement()
  end
  self:__RefreshAllGet()
end

function UIActCommonRewardBp:__RefreshAllGet()
  local hasCanRecive = self._data:HasCommonRewardExpCanReceive()
  self.ui.img_Mask.gameObject:SetActive(not hasCanRecive)
end

function UIActCommonRewardBp:__OnInstantiateItem(go)
  local item = UINActCommonRewardBpEmptyElement.New()
  item:Init(go)
  item:BindHalloweenBounsItemClass(UINActCommonRewardBpItem, UINActCommonRewardBpCycleItem)
  self._goItem[go] = item
end

function UIActCommonRewardBp:__OnChangeItem(go, index)
  local item = self._goItem[go]
  local level = index + 1
  local isCycle = level > self._data:GetCommonRewardLvLimit()
  if isCycle then
    item:InitBounsCycleItem(self._data, self.__OnPickedSingleCycleCallback)
  else
    item:InitBounsItem(self._data, level, self.__OnPickedSingleCallback)
  end
end

function UIActCommonRewardBp:__OnPickedSingle(level, item)
  self._data:ReqCommonRewardExpReceive(level)
end

function UIActCommonRewardBp:__OnPickedSingleCycle()
end

function UIActCommonRewardBp:OnClickPickedAll()
  self._data:ReqCommonRewardAllExp()
end

function UIActCommonRewardBp:OnClickCloseBouns()
  UIUtil.OnClickBack()
end

function UIActCommonRewardBp:OnCloseBouns(tohome)
  self:Delete()
  if self._closeCallback ~= nil then
    self._closeCallback()
  end
end

function UIActCommonRewardBp:OnDelete()
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  self._conditionListener:Delete()
  base.OnDelete(self)
end

return UIActCommonRewardBp
