local UINEventRoomRandom = class("UINEventRoomRandom", UIBaseNode)
local base = UIBaseNode
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local UINRandomBeforeBattlePassItem = require("Game.Battle.UI.UINRandomBeforeBattlePassItem")
local UINEventRoomRandomOptionButton = require("Game.Exploration.UI.EventRoom.UINEventRoomRandomOptionButton")
local UINEventRoomRandomResult = require("Game.Exploration.UI.EventRoom.UINEventRoomRandomResult")
local cs_MessageCommon = CS.MessageCommon

function UINEventRoomRandom:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.randomOptionDic = {}
  self.normalOptionDic = {}
  self.randomItemList = {}
  self.selectedCfg = nil
  self.selectedInedx = nil
  self.isAllpass = false
  self.passNum = 0
  self.resultList = {}
  self.focusItemNum = 0
  UIUtil.AddButtonListener(self.ui.btn_selectButton, self, self.OnClickSelect)
  UIUtil.AddButtonListener(self.ui.btn_rejudgeButton, self, self.OnClickRejudge)
  UIUtil.AddButtonListener(self.ui.btn_acquireButton, self, self.OnClickCollectReward)
  self.resultItemPool = UIItemPool.New(UINEventRoomRandomResult, self.ui.obj_resultItem)
  self.ui.obj_resultItem:SetActive(false)
  self.optionButtonItemPool = UIItemPool.New(UINEventRoomRandomOptionButton, self.ui.obj_optionButton)
  self.ui.obj_optionButton:SetActive(false)
  self.randomItemPool = UIItemPool.New(UINRandomBeforeBattlePassItem, self.ui.obj_randomItem)
  self.ui.obj_randomItem:SetActive(false)
  self.__RandomOptionClick = BindCallback(self, self.RandomOptionClick)
  self.__NormalOptionClick = BindCallback(self, self.NormalOptionClick)
  self.__refreshFocusPoint = BindCallback(self, self.RefreshFocusPoint)
  MsgCenter:AddListener(eMsgEventId.EpFocusPointChange, self.__refreshFocusPoint)
  ExplorationManager.epCtrl.eventCtrl:SetRejudegeOverCallback(function(judgeValue)
    local career, judgeResult = self:UnpackageData(judgeValue)
    self:__RefreshRandomItem(career, judgeResult)
    self:RefreshDifferentResultProbability(self.selectedCfg, true)
  end)
end

function UINEventRoomRandom:InitRandomEvent(datas, dynPlayData, onClickActionNormal)
  self.onClickActionNormal = onClickActionNormal
  self.heroList = dynPlayData.heroList
  local eventText
  local eventCfg = datas.eventCfg
  if eventCfg == nil then
    eventText = ""
  else
    eventText = eventCfg.event_txt
  end
  self.ui.content.text = LanguageUtil.GetLocaleText(eventText)
  self:RefreshFocusPoint(dynPlayData.focusItemNum, dynPlayData.focusLimit)
  if datas.selectedRandomId ~= 0 then
    self:__InitAfterSelect(datas)
  else
    self:__InitBeforeSelect(datas)
  end
end

function UINEventRoomRandom:__InitBeforeSelect(datas)
  self.optionButtonItemPool:HideAll()
  for index, choiceData in ipairs(datas.choiceDatalist) do
    local item = self.optionButtonItemPool:GetOne(true)
    local cfg
    if choiceData.isRandom == true then
      cfg = ConfigData.event_random[choiceData.choiceId]
      item:InitRandomButton(cfg, choiceData.idx, self.__RandomOptionClick)
    else
      cfg = ConfigData.event_choice[choiceData.choiceId]
      item:InitNormalButton(cfg, choiceData.idx, self.__NormalOptionClick)
    end
  end
  self.randomItemPool:HideAll()
  self.resultItemPool:HideAll()
  self.passNum = 0
  self.ui.btn_selectButton.gameObject:SetActive(true)
  self.ui.btn_rejudgeButton.gameObject:SetActive(false)
  self.ui.btn_acquireButton.gameObject:SetActive(false)
end

function UINEventRoomRandom:__InitAfterSelect(datas)
  local career, judgeResult = self:UnpackageData(datas.judge)
  self:__RefreshRandomItem(career, judgeResult)
  local cfg
  self.optionButtonItemPool:HideAll()
  for index, choiceData in ipairs(datas.choiceDatalist) do
    if choiceData.isRandom == true and choiceData.choiceId == datas.selectedRandomId then
      local item = self.optionButtonItemPool:GetOne(true)
      cfg = ConfigData.event_random[choiceData.choiceId]
      item:InitRandomButton(cfg, choiceData.idx, nil)
      self:RefreshDifferentResultProbability(cfg, true)
      self.selectedCfg = cfg
    end
  end
  self.ui.btn_selectButton.gameObject:SetActive(false)
  self.ui.btn_rejudgeButton.gameObject:SetActive(true)
  self.ui.btn_acquireButton.gameObject:SetActive(true)
end

function UINEventRoomRandom:RandomOptionClick(cfg, idx)
  self.randomItemPool:HideAll()
  self.ui.txt_NoremalChoice.gameObject:SetActive(false)
  self.randomItemList = {}
  for i = 1, cfg.judge_num do
    local item = self.randomItemPool:GetOne(true)
    table.insert(self.randomItemList, item)
  end
  self:RefreshDifferentResultProbability(cfg, false)
  self.selectedCfg = cfg
  self.selectedInedx = idx
end

function UINEventRoomRandom:NormalOptionClick(cfg, idx)
  self.randomItemPool:HideAll()
  self.resultItemPool:HideAll()
  self.passNum = 0
  self.ui.txt_NoremalChoice.gameObject:SetActive(true)
  self.ui.txt_NoremalChoice.text = LanguageUtil.GetLocaleText(cfg.choice_describe_txt)
  self.selectedCfg = cfg
  self.selectedInedx = idx
end

function UINEventRoomRandom:OnClickSelect()
  if self.selectedCfg == nil or self.selectedInedx == nil then
    cs_MessageCommon.ShowMessageTips("未选择")
    return
  end
  self.onClickActionNormal(self.selectedCfg, self.selectedInedx, true)
end

function UINEventRoomRandom:OnClickRejudge()
  if self.focusItemNum <= 0 then
    cs_MessageCommon.ShowMessageTips("专注点数不足")
    return
  end
  if self.isAllpass then
    print("已经全部通过了")
    return
  end
  ExplorationManager.epCtrl.eventCtrl:SendRejudge()
end

function UINEventRoomRandom:OnClickCollectReward()
  local des = self.resultList[self.passNum]:GetDes()
  local couldContinue = false
  if self.resultList[self.passNum].jumpTarget ~= 0 then
    couldContinue = true
  end
  ExplorationManager.epCtrl.eventCtrl:SendCollectReward(des, couldContinue)
end

function UINEventRoomRandom:RefreshDifferentResultProbability(cfg, isRejudege)
  local n = cfg.judge_num
  self.resultItemPool:HideAll()
  local baseRate = ConfigData.game_config.RandomBeforeBatteleProbabilityBase or 0.6
  local eachRate = ConfigData.game_config.RandomBeforeBatteleProbabilityEachOne or 0.06
  local careeNum = 0
  for _, heroData in ipairs(self.heroList) do
    if heroData:GetCareer() == cfg.judge_profession then
      careeNum = careeNum + 1
    end
  end
  local successRate = (baseRate + eachRate * careeNum) / 1000
  local definitePassNum = self.passNum or 0
  if isRejudege and n > definitePassNum then
    definitePassNum = definitePassNum + 1
  end
  for i = 1, n + 1 do
    local item = self.resultItemPool:GetOne(true)
    local passNum = i - 1
    local probability
    if definitePassNum > passNum then
      probability = 0
    else
      local wantPassNum = passNum - definitePassNum
      local remainPssNum = n - definitePassNum
      probability = self:_combination(remainPssNum, wantPassNum) * Mathf.Pow(successRate, wantPassNum) * Mathf.Pow(1 - successRate, remainPssNum - wantPassNum)
    end
    local logic = cfg.logic[i]
    local para1 = cfg.para1[i]
    local para2 = cfg.para2[i]
    local jumpTarget = cfg.jump_target[i]
    item:InitRandomResult(passNum, probability, logic, para1, para2, jumpTarget)
    self.resultList[passNum] = item
  end
end

function UINEventRoomRandom:_combination(n, m)
  local temp1 = self:_factorial(n)
  return self:_factorial(n) / (self:_factorial(m) * self:_factorial(n - m))
end

function UINEventRoomRandom:_factorial(n)
  if n == 0 then
    return 1
  end
  local temp = 1
  for i = 1, n do
    temp = temp * i
  end
  return temp
end

function UINEventRoomRandom:__RefreshRandomItem(career, judgeResult)
  self.randomItemPool:HideAll()
  self.randomItemList = {}
  self.isAllpass = true
  self.passNum = 0
  for index, judgeNum in ipairs(judgeResult) do
    local isPass = 0 < judgeNum
    local item = self.randomItemPool:GetOne(true)
    item:InitPassItem(isPass)
    item:SetJudgeIcon(career)
    if judgeNum == 2 then
      item:LuckPass()
    end
    table.insert(self.randomItemList, item)
    if not isPass then
      self.isAllpass = false
    else
      self.passNum = self.passNum + 1
    end
  end
  if self.isAllpass then
    self.ui.btn_rejudgeButton.gameObject:SetActive(false)
  end
end

function UINEventRoomRandom:UnpackageData(data)
  local temp = data >> 16
  local judgeData = data & CommonUtil.UInt16Max
  local career = temp >> 4
  local judgeTimes = temp & 15
  local judgeResult = {}
  for i = 1, judgeTimes do
    judgeResult[i] = judgeData % 10
    judgeData = judgeData // 10
  end
  return career, judgeResult
end

function UINEventRoomRandom:RefreshFocusPoint(focusItemNum, focusLimit)
  self.focusItemNum = focusItemNum
  self.ui.txt_focusPiont:SetIndex(0, tostring(focusItemNum), tostring(focusLimit))
end

function UINEventRoomRandom:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.EpFocusPointChange, self.__refreshFocusPoint)
  base.OnDelete(self)
end

return UINEventRoomRandom
