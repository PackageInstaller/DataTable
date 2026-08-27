local UIActivitySeasonBonus = class("UIActivitySeasonBonus", UIBaseWindow)
local base = UIBaseWindow
local ConditionListener = require("Game.Common.CheckCondition.ConditonListener.ConditionListener")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local UINCommonActivityBG = require("Game.ActivityFrame.UI.UINCommonActivityBG")
local cs_ResLoader = CS.ResLoader

function UIActivitySeasonBonus:OnInit()
  self:BindActivitySeasonBtn()
  self:SetActivitySeasonItemClass()
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

function UIActivitySeasonBonus:BindActivitySeasonBtn()
  UIUtil.SetTopStatus(self, self.OnCloseBouns)
  UIUtil.AddButtonListener(self.ui.btn_ReceiveAll, self, self.OnClickPickedAll)
end

function UIActivitySeasonBonus:SetActivitySeasonItemClass()
  self._itemClass = require("Game.ActivitySeason.UI.UINActivitySeasonBonusItem")
  self._cycleClass = require("Game.ActivitySeason.UI.UINActivitySeasonBonusCycleItem")
  self._emetyElement = require("Game.ActivityHallowmas.UI.Bouns.UINHalloweenBounsItemEmptyElement")
end

function UIActivitySeasonBonus:InitActivitySeasonBouns(activitySeasonData)
  self._data = activitySeasonData
  self:__InitFixed()
  self:__Refresh()
  self._actBgNode:InitActivityBG(self._data:GetActFrameId(), self._resloader)
end

function UIActivitySeasonBonus:RefreshActivitySeasonBouns()
  self:__Refresh()
end

function UIActivitySeasonBonus:SetCloseCallback(closeCallback)
  self._closeCallback = closeCallback
end

function UIActivitySeasonBonus:__InitFixed()
  local itemId = self._data:GetSeasonTokenItemId()
  self.ui.tex_TokenName.text = ConfigData:GetItemName(itemId)
  self.ui.img_Token.sprite = CRH:GetSpriteByItemId(itemId)
  local itemCfg = ConfigData.item[itemId]
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(itemCfg.describe)
  self.ui.scroll.totalCount = self._data:GetSeasonRewardLvLimit() + 1
  local targetIndex = self._data:GetSeasonRewardCurLv()
  for i = 1, targetIndex do
    if self._data:IsSeasonRewardLevelCanPick(i) then
      targetIndex = i
      break
    end
  end
  self.ui.scroll:RefillCells(targetIndex - 1, 200)
  self.ui.scroll:SrollToCell(targetIndex - 1, 9999)
end

function UIActivitySeasonBonus:__Refresh()
  self.ui.tex_TokenNum:SetIndex(0, tostring(self._data:GetSeasonRewardAllExp()))
  self.ui.tex_Lvl:SetIndex(0, tostring(self._data:GetSeasonRewardCurLv()))
  local tempExp = self._data:GetSeasonRewardCurExp() % self._data:GetSeasonRewardCurExpLimit()
  local remainExp = self._data:GetSeasonRewardCurExpLimit() - tempExp
  self.ui.tex_Exp.text = tostring(remainExp)
  for k, v in pairs(self._goItem) do
    v:RefreshBounsElement()
  end
  self:__RefreshAllGet()
end

function UIActivitySeasonBonus:__RefreshAllGet()
  local hasCanRecive = self._data:HasSeasonRewardExpCanReceive()
  self.ui.img_Mask.gameObject:SetActive(not hasCanRecive)
end

function UIActivitySeasonBonus:__OnInstantiateItem(go)
  local item = self._emetyElement.New()
  item:Init(go)
  item:BindHalloweenBounsItemClass(self._itemClass, self._cycleClass)
  self._goItem[go] = item
end

function UIActivitySeasonBonus:__OnChangeItem(go, index)
  local item = self._goItem[go]
  local level = index + 1
  if level > self._data:GetSeasonRewardLvLimit() then
    item:InitBounsCycleItem(self._data, self.__OnPickedSingleCycleCallback)
  else
    item:InitBounsItem(self._data, level, self.__OnPickedSingleCallback)
  end
end

function UIActivitySeasonBonus:__OnPickedSingle(level, item)
  self._data:ReqSeasonRewardExpReceive(level)
end

function UIActivitySeasonBonus:__OnPickedSingleCycle()
  self._data:ReqSeasonRewardExpCycle()
end

function UIActivitySeasonBonus:OnClickPickedAll()
  if not self._data:HasSeasonRewardExpCanReceive() then
    return
  end
  self._data:ReqSeasonRewardAllExp()
end

function UIActivitySeasonBonus:OnClickCloseBouns()
  UIUtil.OnClickBack()
end

function UIActivitySeasonBonus:OnCloseBouns(tohome)
  self:Delete()
  if self._closeCallback ~= nil then
    self._closeCallback()
  end
end

function UIActivitySeasonBonus:OnDelete()
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  self._conditionListener:Delete()
  base.OnDelete(self)
end

return UIActivitySeasonBonus
