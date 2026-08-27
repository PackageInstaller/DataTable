local base = require("Game.Exploration.UI.EventRoom.UINEventRoomPageBase")
local UINEpEntLotteryNode = class("UINEpEventNode", base)
local UINEpEventSlotMachineItem = require("Game.Exploration.UI.EventRoom.UINEpEventSlotMachineItem")
local cs_Edge = CS.UnityEngine.RectTransform.Edge
local CS_DOTween = CS.DG.Tweening.DOTween

function UINEpEntLotteryNode:OnInit()
  base.OnInit(self)
  self.__ChoiceFinihsEftEvent = BindCallback(self, self.__ChoiceFinihsEft)
  self._onSlotMachinePressUp = BindCallback(self, self._OnSlotMachinePressUp)
  self._onSlotMachinePressDown = BindCallback(self, self._OnSlotMachinePressDown)
  self.slotMachinePool = UIItemPool.New(UINEpEventSlotMachineItem, self.ui.obj_rankdomItem)
  self.ui.obj_rankdomItem:SetActive(false)
end

function UINEpEntLotteryNode:InitBranchPage(uiEvent, onChoiceClick)
  base.InitBranchPage(self, uiEvent, onChoiceClick)
end

function UINEpEntLotteryNode:RefreshBranchPage()
  base.RefreshBranchPage(self)
  ExplorationManager.epCtrl.eventCtrl:RegistEventSelectSuccessFunc(self.__ChoiceFinihsEftEvent)
  self.slotMachinePool:HideAll()
  for index, choiceData in ipairs(self.uiEvent.roomData.choiceDatalist) do
    if choiceData.cfg ~= nil and choiceData.cfg.gamblebenefit_tag > 0 then
      local slotItem = self.slotMachinePool:GetOne(true)
      slotItem:InitSlotMachineItem(choiceData, self._onSlotMachinePressUp, self._onSlotMachinePressDown)
    end
  end
end

function UINEpEntLotteryNode:_OnSlotMachinePressUp()
  UIManager:HideWindow(UIWindowTypeID.RichIntro)
end

function UINEpEntLotteryNode:_OnSlotMachinePressDown(name, desc)
  UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
    if win ~= nil then
      win:ShowIntroCustom(self.uiEvent.ui.introHolder, name, desc, true)
      win:SetIntroListPosition(cs_Edge.Right, cs_Edge.Top)
    end
  end)
end

function UINEpEntLotteryNode:__ChoiceFinihsEft(selectIndex, completeFunc)
  if selectIndex == nil then
    completeFunc()
    return
  end
  ExplorationManager.epCtrl.eventCtrl:CancleEventSelectSuccessFunc(self.__ChoiceFinihsEftEvent)
  local choiceItem = self.choiceItemDic[selectIndex + 1]
  if choiceItem == nil then
    completeFunc()
    return
  end
  local eventChoiceCfg = ConfigData.event_choice[choiceItem.choiceId]
  if choiceItem.cfg == nil or (choiceItem.cfg.gamble_group or 0) == 0 then
    completeFunc()
    return
  end
  local eftStopItem
  for _, slotItem in ipairs(self.slotMachinePool.listItem) do
    if slotItem.cfg ~= nil and slotItem.cfg.group == choiceItem.cfg.gamble_group then
      eftStopItem = slotItem
      break
    end
  end
  if eftStopItem == nil then
    completeFunc()
    return
  end
  if self.finishTween ~= nil then
    self.finishTween:Kill()
    self.finishTween = nil
  end
  local finishTween = CS_DOTween.Sequence()
  self.ui.obj_SelectRankdomNode:SetActive(true)
  self.uiEvent:ActiveUIMask(true)
  for i = 1, self.ui.rankdomTotalCycle do
    for _, slotItem in ipairs(self.slotMachinePool.listItem) do
      finishTween:AppendCallback(function()
        self.ui.obj_SelectRankdomNode.transform.position = slotItem.transform.position
      end)
      finishTween:AppendInterval(self.ui.rankdomIntervialTime)
    end
  end
  for _, slotItem in ipairs(self.slotMachinePool.listItem) do
    finishTween:AppendCallback(function()
      self.ui.obj_SelectRankdomNode.transform.position = slotItem.transform.position
    end)
    if slotItem == eftStopItem then
      break
    end
    finishTween:AppendInterval(self.ui.rankdomIntervialTime)
  end
  finishTween:AppendInterval(self.ui.rankdomStayTime)
  finishTween:AppendCallback(function()
    if self.finishTween ~= nil then
      self.finishTween:Kill()
      self.finishTween = nil
    end
    self.ui.obj_SelectRankdomNode:SetActive(false)
    self.uiEvent:ActiveUIMask(false)
    completeFunc()
  end)
end

function UINEpEntLotteryNode:OnDelete()
  if ExplorationManager.epCtrl ~= nil and ExplorationManager.epCtrl.eventCtrl ~= nil then
    ExplorationManager.epCtrl.eventCtrl:CancleEventSelectSuccessFunc(self.__ChoiceFinihsEftEvent)
  end
  base.OnDelete(self)
end

return UINEpEntLotteryNode
