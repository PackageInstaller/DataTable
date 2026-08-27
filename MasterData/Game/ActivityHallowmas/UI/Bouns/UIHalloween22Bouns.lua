local UIHalloween22Bouns = class("UIHalloween22Bouns", UIBaseWindow)
local base = UIBaseWindow
local ConditionListener = require("Game.Common.CheckCondition.ConditonListener.ConditionListener")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))

function UIHalloween22Bouns:OnInit()
  self:BindHalloweenBtn()
  self:SethalloweenItemClass()
  self.ui.scroll.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.scroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__OnPickedSingleCallback = BindCallback(self, self.__OnPickedSingle)
  self.__OnPickedSingleCycleCallback = BindCallback(self, self.__OnPickedSingleCycle)
  self._goItem = {}
  self.__RefreshCallback = BindCallback(self, self.__Refresh)
  MsgCenter:AddListener(eMsgEventId.ActivityHallowmas, self.__RefreshCallback)
  self._conditionListener = ConditionListener.New()
  self.__RefreshBuyBtnCallback = BindCallback(self, self.__RefreshBuyBtn)
end

function UIHalloween22Bouns:BindHalloweenBtn()
  UIUtil.SetTopStatus(self, self.OnCloseBouns, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickCloseBouns)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnClickBuy)
  UIUtil.AddButtonListener(self.ui.btn_ReceiveAll, self, self.OnClickPickedAll)
  UIUtil.AddButtonListener(self.ui.btn_Icon, self, self.OnClickIconTip)
end

function UIHalloween22Bouns:SethalloweenItemClass()
  self._itemClass = require("Game.ActivityHallowmas.UI.Bouns.UINHalloweenBounsItemWithGet")
  self._cycleClass = require("Game.ActivityHallowmas.UI.Bouns.UINHalloweenBounsCycleItem")
  self._emetyElement = require("Game.ActivityHallowmas.UI.Bouns.UINHalloweenBounsItemEmptyElement")
end

function UIHalloween22Bouns:InitHalloween22Bouns(hallowmasData, closeEvent)
  self._data = hallowmasData
  self._closeEvent = closeEvent
  self:__InitFixed()
  self:__Refresh()
  local startTime = self._data:GetHallowmasMainCfg().score_buy_time
  local endTime = self._data:GetActivityDestroyTime()
  self._conditionListener:AddConditionChangeListener(1, self.__RefreshBuyBtnCallback, {
    CheckerTypeId.TimeRange
  }, {startTime}, {endTime})
end

function UIHalloween22Bouns:__InitFixed()
  local itemId = self._data:GetHallowmasScoreItemId()
  self.ui.tex_TokenName.text = ConfigData:GetItemName(itemId)
  self.ui.img_Token.sprite = CRH:GetSpriteByItemId(itemId)
  local itemCfg = ConfigData.item[itemId]
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(itemCfg.describe)
  self.ui.scroll.totalCount = self._data:GetHallowmasLvLimit() + 1
  local targetIndex = self._data:GetHallowmasLv()
  for i = 1, targetIndex do
    if self._data:IsHallowmasLevelCanPick(i) then
      targetIndex = i
      break
    end
  end
  self.ui.scroll:RefillCells(targetIndex - 1, 200)
  self.ui.scroll:SrollToCell(targetIndex - 1, 9999)
end

function UIHalloween22Bouns:__Refresh()
  self.ui.tex_TokenNum:SetIndex(0, tostring(self._data:GetHallowmasAllExp()))
  self.ui.tex_Lvl:SetIndex(0, tostring(self._data:GetHallowmasLv()))
  local tempExp = self._data:GetHallowmasCurExp() % self._data:GetHallowmasCurExpLimit()
  local remainExp = self._data:GetHallowmasCurExpLimit() - tempExp
  self.ui.tex_Exp.text = tostring(remainExp)
  for k, v in pairs(self._goItem) do
    v:RefreshBounsElement()
  end
  self:__RefreshAllGet()
  self:__RefreshBuyBtn()
end

function UIHalloween22Bouns:__RefreshAllGet()
  self.ui.img_Mask.gameObject:SetActive(not self._data:IsHallowmasExpAllReceive())
end

function UIHalloween22Bouns:__OnInstantiateItem(go)
  local item = self._emetyElement.New()
  item:Init(go)
  item:BindHalloweenBounsItemClass(self._itemClass, self._cycleClass)
  self._goItem[go] = item
end

function UIHalloween22Bouns:__OnChangeItem(go, index)
  local item = self._goItem[go]
  local level = index + 1
  if level > self._data:GetHallowmasLvLimit() then
    item:InitBounsCycleItem(self._data, self.__OnPickedSingleCycleCallback)
  else
    item:InitBounsItem(self._data, level, self.__OnPickedSingleCallback)
  end
end

function UIHalloween22Bouns:__RefreshBuyBtn()
  local startTime = self._data:GetHallowmasMainCfg().score_buy_time
  local endTime = self._data:GetActivityDestroyTime()
  local curTime = PlayerDataCenter.timestamp
  local curLevel = self._data:GetHallowmasLv()
  local maxLevel = self._data:GetHallowmasLvLimit()
  self.ui.btn_Buy.gameObject:SetActive(startTime <= curTime and endTime > curTime and curLevel < maxLevel)
end

function UIHalloween22Bouns:__OnPickedSingle(level, item)
  self._data:ReqHallowmasExpReceive(level)
end

function UIHalloween22Bouns:__OnPickedSingleCycle()
  self._data:ReqHallowmasExpCycle()
end

function UIHalloween22Bouns:OnClickBuy()
  UIManager:ShowWindowAsync(UIWindowTypeID.EventBattlePassBuyLevel_Halloween, function(win)
    if win == nil then
      return
    end
    win:InitBPHallowBuy(self._data, function(levelCount)
      local curLevel = self._data:GetHallowmasLv()
      self._data:ReqHallowmasBuyScore(levelCount, function()
        local expCount = 0
        for i = curLevel, curLevel + levelCount - 1 do
          local cfg = self._data:GetHallowmasExpCfg()[i]
          expCount = expCount + cfg.need_exp
        end
        UIUtil.ShowCommonReward({
          [self._data:GetHallowmasScoreItemId()] = expCount
        })
      end)
    end)
  end)
end

function UIHalloween22Bouns:OnClickPickedAll()
  if not self._data:IsHallowmasExpAllReceive() then
    return
  end
  self._data:ReqHallowmasAllExp()
end

function UIHalloween22Bouns:OnClickIconTip()
  UIManager:ShowWindowAsync(UIWindowTypeID.Carnival22InfoWindow, function(win)
    if win == nil then
      return
    end
    win:InitCarnivalInfoWindow(self._data:GetHallowmasMainCfg().score_limit_tip)
  end)
end

function UIHalloween22Bouns:OnClickCloseBouns()
  UIUtil.OnClickBackByUiTab(self)
end

function UIHalloween22Bouns:OnCloseBouns(tohome)
  self:Delete()
  if self._closeEvent ~= nil then
    self._closeEvent(tohome)
    self._closeEvent = nil
  end
end

function UIHalloween22Bouns:OnDelete()
  self._conditionListener:Delete()
  MsgCenter:RemoveListener(eMsgEventId.ActivityHallowmas, self.__RefreshCallback)
  base.OnDelete(self)
end

return UIHalloween22Bouns
