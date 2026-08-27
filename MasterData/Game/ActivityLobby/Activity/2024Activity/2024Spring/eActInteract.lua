local eActInteract = {}
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local SectorChapterEnum = require("Game.Sector.Enum.SectorLevelChapterEnum")
local HandBookActReviewOpenFunc = require("Game.HandBook.UI.Activity.HandBookActReviewOpenFunc")
local HandBookActReviewFunc = require("Game.HandBook.UI.Activity.HandBookActReviewFunc")
local ActivitySpring24Enum = require("Game.ActivitySpring24.Data.ActivitySpring24Enum")
local cs_MessageCommon = CS.MessageCommon

function eActInteract.__GetActData()
  local spring24Ctrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring24)
  if not spring24Ctrl then
    return
  end
  local actFrameId = ActLbUtil.GetCurActLbActId()
  return spring24Ctrl:GetActDataByFrameId(actFrameId)
end

eActInteract.eMissonBtn = {Task = 1}
local MissonBtnOpenFunc = {
  [eActInteract.eMissonBtn.Task] = function(ignoreInteract)
    local actData = eActInteract.__GetActData()
    local dailyTaskData = actData:GetSpring24DailyTaskData()
    local termTaskData = actData:GetSpring24TermTaskData()
    if dailyTaskData == nil then
      if isGameDev then
        warn(" daily task not open ")
      end
      return
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.Winter23Task, function(win)
      if win == nil then
        return
      end
      if not ignoreInteract then
        ActLbUtil.OnActLbInteractEnter(true)
        win:InitWinter23Task(actData:GetActFrameId(), dailyTaskData, termTaskData, function()
          ActLbUtil.OnActLbInteractEnter(false)
        end)
      else
        win:InitWinter23Task(actData:GetActFrameId(), dailyTaskData, termTaskData, function()
          local win = UIManager:GetWindow(UIWindowTypeID.UI24SpringCollectFortuneMain)
          if win then
            win:RefreshCollectFortuneMainReddot()
          end
        end)
      end
    end)
  end
}
local MissonBtnRedFunc = {
  [eActInteract.eMissonBtn.Task] = function()
    local actData = eActInteract.__GetActData()
    local reddot = actData:GetActivityReddot()
    if reddot == nil then
      return false
    end
    local childReddot = reddot:GetChild(ActivitySpring24Enum.reddotType.DailyTask)
    if childReddot ~= nil and childReddot:GetRedDotCount() > 0 then
      return true
    end
    childReddot = reddot:GetChild(ActivitySpring24Enum.reddotType.OnceTask)
    return childReddot:GetRedDotCount() > 0
  end
}
eActInteract.eLbIntrctActionId = {
  Board = 1,
  MainAct = 2,
  FlipCard = 3,
  MainStory = 4,
  DigRewardTip = 5,
  Egg = 6,
  DigReward = 7
}
eActInteract.eLbIntrctEntityId = {
  None = 0,
  Board = 1,
  MainAct = 2,
  FlipCard = 3,
  MainStory = 4,
  DigRewardTip = 5,
  Egg = 6,
  Erika = 7,
  DigReward1 = 8,
  DigReward2 = 9,
  DigReward3 = 10,
  DigReward4 = 11,
  DigReward5 = 12,
  DigReward6 = 13,
  DigReward7 = 14,
  DigReward8 = 15,
  DigReward9 = 16,
  DigReward10 = 17,
  DigReward11 = 18,
  DigReward12 = 19,
  DigReward13 = 20,
  DigReward14 = 21
}

local function CheckDigRewardShow(objId)
  local actData = eActInteract.__GetActData()
  local treasureData = actData:GetTreasureData()
  return treasureData:GetEntObjIdIsShow(objId)
end

local function GetDigRewardPos(objId)
  local actData = eActInteract.__GetActData()
  return actData:GetTreasurePos(objId)
end

local function GetDigRewardIsShowAndPos(objId, isNeedPos)
  local isShow = CheckDigRewardShow(objId)
  local pos
  if isNeedPos then
    pos = GetDigRewardPos(objId)
  end
  return isShow, pos
end

eActInteract.eIntrctFuncs = {
  [eActInteract.eLbIntrctActionId.Board] = function(entity)
  end,
  [eActInteract.eLbIntrctActionId.MainAct] = function(entity)
    local actData = eActInteract.__GetActData()
    local collectFortuneCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCollectFortune, true)
    local data = collectFortuneCtrl:GetCollectFortuneData()
    if data == nil then
      return
    end
    ActLbUtil.OnActLbInteractEnter(true)
    UIManager:ShowWindowAsync(UIWindowTypeID.UI24SpringCollectFortuneMain, function(win)
      if win == nil then
        return
      end
      win:InitCollectFortuneMain(data, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
      win:BindActTaskOnClickFunc(MissonBtnOpenFunc[eActInteract.eMissonBtn.Task])
      win:BindActTaskReddotRefreshFunc(MissonBtnRedFunc[eActInteract.eMissonBtn.Task])
      win:BindReddotRefreshFunc(function()
        actData:RefreshCollectFortuneRedDot()
      end)
    end)
  end,
  [eActInteract.eLbIntrctActionId.FlipCard] = function(entity)
  end,
  [eActInteract.eLbIntrctActionId.MainStory] = function(entity)
    local actData = eActInteract.__GetActData()
    local cPRData = HandBookActReviewFunc[actData:GetActivityFrameCat()](actData:GetActId())
    ActLbUtil.OnActLbInteractEnter(true)
    HandBookActReviewOpenFunc:OpenHandbookActReview(cPRData, function()
      UIManager:ShowWindowOnly(UIWindowTypeID.HandBookActBookFes)
      ActLbUtil.OnActLbInteractEnter(false)
    end, true)
  end,
  [eActInteract.eLbIntrctActionId.DigRewardTip] = function(entity)
    local actData = eActInteract.__GetActData()
    local tipId = actData:GetDigRewardGuideTipId()
    local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
    GuidePicture.OpenGuidePicture(tipId, nil)
  end,
  [eActInteract.eLbIntrctActionId.Egg] = function(entity)
    local actData = eActInteract.__GetActData()
    local avgId = actData:GetActSpring24EggStoryId()
    ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, avgId, function()
      ActLbUtil.UpdActLbEnttUnlockStateByObjId(eActInteract.eLbIntrctEntityId.Egg)
      MsgCenter:Broadcast(eMsgEventId.UpdActLbFollowUI)
    end)
  end,
  [eActInteract.eLbIntrctActionId.DigReward] = function(entity)
    local actData = eActInteract.__GetActData()
    local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring24)
    if actCtrl then
      actCtrl:SendDigReward(entity:GetLbInteractEntityId(), actData)
    end
  end
}
eActInteract.eActIntrctActionUIInitFunc = {}
eActInteract.eSubNameFuncs = {}
eActInteract.eUnlockIntrctFunc = {
  [eActInteract.eLbIntrctEntityId.Egg] = function(lbIntrctData)
    local actData = eActInteract.__GetActData()
    local treasureData = actData:GetTreasureData()
    local isDigAll = treasureData:IsActSpring24TreasureDigAll()
    if not isDigAll then
      return false
    end
    local avgId = actData:GetActSpring24EggStoryId()
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local played = avgPlayCtrl:IsAvgPlayed(avgId)
    return not played
  end
}
eActInteract.eActIntrctActionLockStateDesFunc = {}
eActInteract.eActIntrctActionShowBlueDotFunc = {
  [eActInteract.eLbIntrctActionId.MainAct] = function(entity, actionCfg)
    local actData = eActInteract.__GetActData()
    if actData == nil or not actData:IsActivityRunning() then
      return false
    end
    local reddot = actData:GetActivityReddot()
    local childReddot = reddot:AddChild(ActivitySpring24Enum.reddotType.CollectFortune)
    return childReddot ~= nil and childReddot:GetRedDotCount() > 0
  end
}

function eActInteract.UpdateActivityReddotChange()
  ActLbUtil.UpdLbEntranceBlueDot(eActInteract.eLbIntrctEntityId, eActInteract.eActIntrctActionShowBlueDotFunc)
  for k, v in pairs(eActInteract.eActIntrctActionShowBlueDotFunc) do
    ActLbUtil.UpdLbEnttBluedot(k)
  end
  local missonUI = UIManager:GetWindow(UIWindowTypeID.Spring23Misson)
  if missonUI ~= nil then
    missonUI:RefreshMissonReddot()
  end
end

function eActInteract.NormalInitEntInfoItem(entInfoItem, entity)
  if entity:GetLbInteractEntityId() ~= eActInteract.eLbIntrctEntityId.DigRewardTip then
    return
  end
  if entInfoItem.digRewardNode then
    entInfoItem.digRewardNode:Hide()
    entInfoItem.digRewardNode = nil
  end
end

eActInteract.eSpecialOpeEntInfoFunc = {
  [eActInteract.eLbIntrctEntityId.None] = function(entInfoItem)
  end,
  [eActInteract.eLbIntrctEntityId.DigRewardTip] = function(entInfoItem)
    local spring24Data = eActInteract:__GetActData()
    if spring24Data == nil then
      return
    end
    if entInfoItem.digRewardNode == nil then
      local originUINode = require("Game.ActivitySpring24.UI.DigReward.UINDigRewardTipNode")
      entInfoItem.digRewardNode = originUINode.New()
      local obj = entInfoItem.transform:Find("RewardList").gameObject
      obj:SetActive(true)
      entInfoItem.digRewardNode:Init(obj)
      entInfoItem.digRewardNode:InitDigRewardTipNode(spring24Data)
    end
    entInfoItem.digRewardNode:Show()
    entInfoItem.digRewardNode:RefreshDigRewardTipNode()
  end
}

local function entityShowMainFunc(entity, isNeedChangePos)
  local isShow, pos = GetDigRewardIsShowAndPos(entity:GetLbInteractEntityId(), isNeedChangePos)
  return isShow, pos
end

eActInteract.eActIntrctEntityShowFunc = {
  [eActInteract.eLbIntrctEntityId.Egg] = function(lbIntrctData)
    local actData = eActInteract.__GetActData()
    local treasureData = actData:GetTreasureData()
    local isDigAll = treasureData:IsActSpring24TreasureDigAll()
    return isDigAll
  end,
  [eActInteract.eLbIntrctEntityId.DigReward1] = entityShowMainFunc,
  [eActInteract.eLbIntrctEntityId.DigReward2] = entityShowMainFunc,
  [eActInteract.eLbIntrctEntityId.DigReward3] = entityShowMainFunc,
  [eActInteract.eLbIntrctEntityId.DigReward4] = entityShowMainFunc,
  [eActInteract.eLbIntrctEntityId.DigReward5] = entityShowMainFunc,
  [eActInteract.eLbIntrctEntityId.DigReward6] = entityShowMainFunc,
  [eActInteract.eLbIntrctEntityId.DigReward7] = entityShowMainFunc,
  [eActInteract.eLbIntrctEntityId.DigReward8] = entityShowMainFunc,
  [eActInteract.eLbIntrctEntityId.DigReward9] = entityShowMainFunc,
  [eActInteract.eLbIntrctEntityId.DigReward10] = entityShowMainFunc,
  [eActInteract.eLbIntrctEntityId.DigReward11] = entityShowMainFunc,
  [eActInteract.eLbIntrctEntityId.DigReward12] = entityShowMainFunc,
  [eActInteract.eLbIntrctEntityId.DigReward13] = entityShowMainFunc,
  [eActInteract.eLbIntrctEntityId.DigReward14] = entityShowMainFunc
}

function eActInteract.OnActLbSceneLoadedFunc(actLbCtrl)
  local spring24Data = eActInteract.__GetActData()
  local reddot = spring24Data:GetActivityReddot()
  RedDotController:AddListener(reddot.nodePath, eActInteract.UpdateActivityReddotChange)
  UIManager:ShowWindowAsync(UIWindowTypeID.Spring23Misson, function(win)
    if win == nil then
      return
    end
    win:SetTaskFunc(MissonBtnOpenFunc[eActInteract.eMissonBtn.Task], MissonBtnRedFunc[eActInteract.eMissonBtn.Task])
    local actFrameId = ActLbUtil.GetCurActLbActId()
    win:InitJumpFuncByActivityFrameId(actFrameId)
    win:RefreshMissonReddot()
  end)
  UIManager:ShowWindowAsync(UIWindowTypeID.Spring24Interactive, function(win)
    if win == nil then
      return
    end
    local entityDic = {}
    entityDic[eActInteract.eLbIntrctEntityId.Egg] = actLbCtrl.actLbIntrctCtrl:GetLbIntrctAllEntityDic()[eActInteract.eLbIntrctEntityId.Egg]
    win:InitSpring24Interactive(entityDic)
  end)
end

function eActInteract.OnActLbStartShowEndCoFunc(actLbCtrl)
  while UIManager:GetWindow(UIWindowTypeID.Spring24Interactive) == nil do
    coroutine.yield(nil)
  end
  while UIManager:GetWindow(UIWindowTypeID.Spring23Misson) == nil do
    coroutine.yield(nil)
  end
  local spring24Ctrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring24)
  if not spring24Ctrl then
    return
  end
  local actData = eActInteract.__GetActData()
  spring24Ctrl:TryOpenNotice(actData)
  spring24Ctrl:RunEnterCompleteFunc()
end

function eActInteract.OnActLbInteractEnterFunc(isEnter)
  if isEnter then
    UIManager:HideWindow(UIWindowTypeID.Spring23Misson)
    UIManager:HideWindow(UIWindowTypeID.Spring24Interactive)
  else
    UIManager:ShowWindowOnly(UIWindowTypeID.Spring23Misson)
    UIManager:ShowWindowOnly(UIWindowTypeID.Spring24Interactive)
    ActLbUtil.UpdLbCurFollowInfoShow()
  end
end

function eActInteract.OnActCamChangeFunc()
  local interactWin = UIManager:GetWindow(UIWindowTypeID.Spring24Interactive)
  if interactWin and interactWin.active then
    interactWin:UpdateInteractive()
  end
end

function eActInteract.OnLbActivityRunningTimeoutFunc(actLbCtrl)
end

function eActInteract.OnLbActivityFinishedFunc(actLbCtrl)
end

function eActInteract.OnActLbExitFunc(actLbCtrl)
  local actData = eActInteract.__GetActData()
  if actData ~= nil then
    local reddot = actData:GetActivityReddot()
    RedDotController:RemoveListener(reddot.nodePath, eActInteract.UpdateActivityReddotChange)
  end
end

return eActInteract
