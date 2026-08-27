local UIShortTheatre = class("UISignInMiniGame", UIBaseWindow)
local base = UIBaseWindow
local UINTaskItem = require("Game.ActivityShortTheatre.UI.UINShortTheatreTaskItem")
local HandBookActReviewOpenFunc = require("Game.HandBook.UI.Activity.HandBookActReviewOpenFunc")
local HandBookActReviewFunc = require("Game.HandBook.UI.Activity.HandBookActReviewFunc")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")

function UIShortTheatre:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickBtnClose)
  UIUtil.AddButtonListener(self.ui.btn_handBool, self, self.OnClickHandBoolBtn)
  UIUtil.AddButtonListener(self.ui.btn_rewardRecived, self, self.OnClickGetFinalRewardBtn)
  self.__OnRecivedCallBack = BindCallback(self, self.OnRecivedCallBack)
  self.resloader = CS.ResLoader.Create()
  self.ui.obj_taskItem:SetActive(false)
  self.taskItemPool = UIItemPool.New(UINTaskItem, self.ui.obj_taskItem)
end

function UIShortTheatre:InitShortTheatre(actId)
  self.shortTheatreGameCtrl = ControllerManager:GetController(ControllerTypeId.ShortTheatre, true)
  if actId ~= self.shortTheatreGameCtrl:GetShortTheatreId() then
    return
  end
  self.ui.text_title.text = ConfigData:GetTipContent(9701)
  self:RefreshRewardProgress()
  self:RefreshLeftDay()
  self:RefreshTask()
  self:RefreshCRPData()
  local mainCfg = self.shortTheatreGameCtrl:GetShorTheatreMainCfg()
  if mainCfg ~= nil then
    self:LoadBackgroundPic(mainCfg)
    self.ui.text_activityName.text = LanguageUtil.GetLocaleText(mainCfg.name)
    self.ui.text_des.text = ConfigData:GetTipContent(mainCfg.activity_rule)
    local totalStage = self.shortTheatreGameCtrl:GetTotalStageId()
    self.ui.text_rewardDes:SetIndex(0, tostring(totalStage))
    local rewardDic = mainCfg.reward_id
    for k, v in pairs(rewardDic) do
      local itemCfg = ConfigData.item[k]
      if itemCfg ~= nil then
        self.ui.text_reward.text = LanguageUtil.GetLocaleText(itemCfg.name)
        break
      end
    end
    self.ui.img_reward.sprite = AtlasUtil.GetSpriteFromAtlas(mainCfg.file, mainCfg.icon, self.resloader)
    local actData = self.shortTheatreGameCtrl:GetCurData()
    if actData ~= nil then
      local openTime = actData:GetActOpenTime()
      local endTime = actData:GetActEndTime()
      local date = TimeUtil:TimestampToDate(openTime, false, true)
      self.ui.text_startTime.text = string.format("%02d/%02d<size=28>%02d:%02d</size>", date.month, date.day, date.hour, date.min)
      date = TimeUtil:TimestampToDate(endTime, false, true)
      self.ui.text_endTime.text = string.format("%02d/%02d<size=28>%02d:%02d</size>", date.month, date.day, date.hour, date.min)
    end
    if self.leftTimeUpdateTimerId == nil then
      self.leftTimeUpdateTimerId = TimerManager:StartTimer(60, self.RefreshItemLeftTime, self, false, false, true)
    end
    self.ui.text_desTitle:SetIndex(0, string.format("%02d", mainCfg.id))
    self:ShowShortTheatreAvg(mainCfg.start_avg, true)
  else
    error("sign_theater_main表为空，id:" .. actId)
  end
end

function UIShortTheatre:LoadBackgroundPic(mainCfg)
  local skinId = mainCfg.background_skin
  if mainCfg.skin_type == 1 then
    self:__LoadPic(mainCfg, skinId)
  else
    self:__LoadL2D(mainCfg, skinId)
  end
  local x = mainCfg.BG_pos[1] or 0
  local y = mainCfg.BG_pos[2] or 0
  self.ui.heroHolder.transform.anchoredPosition = Vector3.New(x, y, 0)
end

function UIShortTheatre:__LoadL2D(mainCfg, skinId)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("skinCfg is NIL")
    return
  end
  if not PlayerDataCenter.skinData:IsSkinL2dCouldShow(skinId) then
    self:__LoadPic(skinId)
    return
  end
  local resName = skinCfg.src_id_pic
  local heroId = mainCfg.hero_id
  self.resloader:LoadABAssetAsync(PathConsts:GetCharacterLive2DPath(resName), function(l2dModelAsset)
    if IsNull(l2dModelAsset) then
      return
    end
    local liveGo = l2dModelAsset:Instantiate()
    liveGo.transform:SetParent(self.ui.heroHolder.transform)
    liveGo.transform:SetLayer(LayerMask.UI)
    local cs_CubismInterationController = self.liveGo.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = HeroCubismInteration.New()
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting(self:GetWindowSortingLayer(), self.ui.heroHolder, nil, true)
      self.heroCubismInteration:SetL2DPosType("HeroList", false)
    end
  end)
end

function UIShortTheatre:__LoadPic(mainCfg, skinId)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("skinCfg is NIL")
    return
  end
  local resName = skinCfg.src_id_pic
  self.resloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resName), function(prefab)
    local bigImgGameObject = prefab:Instantiate(self.ui.heroHolder.transform)
    local commonPicCtrl = bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
  end)
end

function UIShortTheatre:RefreshRewardProgress()
  if self.shortTheatreGameCtrl == nil then
    return
  end
  local curStage = self.shortTheatreGameCtrl:GetCurStage()
  if curStage == nil then
    return
  end
  local curStageId = 0
  if curStage ~= nil then
    curStageId = curStage.stageId
  end
  local totalStage = self.shortTheatreGameCtrl:GetTotalStageId()
  self.ui.text_rewardProgress:SetIndex(0, tostring(curStageId), tostring(totalStage))
  local per = curStageId / totalStage
  self.ui.img_rewardProgress.fillAmount = per
  if curStage.pickFinalReward == true then
    self.ui.obj_recived:SetActive(true)
    self.ui.obj_notRecived:SetActive(false)
  else
    self.ui.obj_recived:SetActive(false)
    self.ui.obj_notRecived:SetActive(true)
    if self.shortTheatreGameCtrl:CheckCanGetFinalReward() then
      self.ui.btn_rewardRecived.gameObject:SetActive(true)
    else
      self.ui.btn_rewardRecived.gameObject:SetActive(false)
    end
  end
end

function UIShortTheatre:RefreshLeftDay()
  if self.shortTheatreGameCtrl == nil then
    return
  end
  local actData = self.shortTheatreGameCtrl:GetCurData()
  if actData == nil then
    return
  end
  local endTime = actData:GetActEndTime()
  local leftTime = endTime - PlayerDataCenter.timestamp
  local leftDay = TimeUtil:TimestampToTimeInter(math.floor(leftTime), false, true)
  self.ui.text_leftDay:SetIndex(0, tostring(leftDay))
end

function UIShortTheatre:RefreshTask()
  if self.shortTheatreGameCtrl == nil then
    return
  end
  local curStageData = self.shortTheatreGameCtrl:GetCurStage()
  if curStageData == nil then
    return
  end
  self.taskItemPool:HideAll()
  self.taskItemList = {}
  local tasks = curStageData.curQuests
  local curStageId = curStageData.stageId + 1
  local totalStageId = self.shortTheatreGameCtrl:GetTotalStageId()
  if curStageId >= totalStageId then
    curStageId = totalStageId
    local taskCfg = ConfigData.sign_theater_task_condition[self.shortTheatreGameCtrl:GetActId()][curStageId]
    if taskCfg ~= nil then
      local taskIds = taskCfg.task_id
      for k, v in pairs(taskIds) do
        local item = self.taskItemPool:GetOne()
        local endTime = 0
        local isCurStageTask = false
        for k2, v2 in pairs(tasks) do
          if v2.questId == v then
            isCurStageTask = true
            endTime = v2.waitingNext
            break
          end
        end
        local leftTime = endTime - PlayerDataCenter.timestamp
        local isComplete = not isCurStageTask
        item:InitTaskItem(v, totalStageId, isCurStageTask, leftTime, isComplete, self.__OnRecivedCallBack)
        table.insert(self.taskItemList, item)
      end
    end
  else
    local taskCfg = ConfigData.sign_theater_task_condition[self.shortTheatreGameCtrl:GetActId()][curStageId]
    if taskCfg ~= nil then
      local taskIds = taskCfg.task_id
      for k, v in pairs(tasks) do
        local item = self.taskItemPool:GetOne()
        local taskId = v.questId
        local isCurStageTask = table.contain(taskIds, taskId)
        local endTime = v.waitingNext
        local leftTime = endTime - PlayerDataCenter.timestamp
        local isComplete = false
        item:InitTaskItem(taskId, v.stageId, isCurStageTask, leftTime, isComplete, self.__OnRecivedCallBack)
        table.insert(self.taskItemList, item)
      end
    end
  end
end

function UIShortTheatre:RefreshCRPData()
  if self.shortTheatreGameCtrl == nil then
    return
  end
  local actData = self.shortTheatreGameCtrl:GetCurData()
  if actData ~= nil then
    local actFrameData = actData.actInfo
    if actFrameData ~= nil then
      self._CPRData = HandBookActReviewFunc[actFrameData:GetActivityFrameCat()](actFrameData:GetActId())
    end
  end
end

function UIShortTheatre:RefreshItemLeftTime()
  if self.taskItemList == nil then
    return
  end
  for i, v in ipairs(self.taskItemList) do
    v:RefreshLeftTime(60)
  end
end

function UIShortTheatre:OnRecivedCallBack(taskData)
  local actData = self.shortTheatreGameCtrl:GetCurData()
  local actFrameData = actData.actInfo
  local actFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  actFrameNet:CS_Activity_Quest_Commit(actFrameData:GetActivityFrameId(), taskData.id, function()
    self.shortTheatreGameCtrl:UpdActShortTheatreRedDot()
    if IsNull(self.transform) then
      return
    end
    self:RefreshRewardProgress()
    local curStageData = self.shortTheatreGameCtrl:GetCurStage()
    if curStageData ~= nil then
      local taskCfg = ConfigData.sign_theater_task_condition[self.shortTheatreGameCtrl:GetActId()][curStageData.stageId]
      if taskCfg ~= nil then
        local taskId = taskData.id
        if table.contain(taskCfg.task_id, taskId) then
          self:ShowShortTheatreAvg(taskCfg.task_avg, true)
        end
      end
    end
  end)
end

function UIShortTheatre:ShowShortTheatreAvg(avgId, isOnlyFirst)
  local avgCfg = ConfigData.story_avg[avgId]
  if avgCfg == nil then
    return
  end
  if isOnlyFirst == true then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    if avgPlayCtrl:IsAvgPlayed(avgId) then
      return
    end
    avgPlayCtrl:ReqAvgComplete(avgId)
  end
  local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
  avgCtrl:StartAvg(avgCfg.script_id, avgId, function()
    self:RefreshCRPData()
  end)
end

function UIShortTheatre:OnClickHandBoolBtn()
  if self._CPRData == nil then
    return
  end
  HandBookActReviewOpenFunc:OpenHandbookActReview(self._CPRData, function()
    UIManager:ShowWindowOnly(UIWindowTypeID.HandBookActBookFes)
  end, true)
end

function UIShortTheatre:OnClickGetFinalRewardBtn()
  if self.shortTheatreGameCtrl == nil then
    return
  end
  self.shortTheatreGameCtrl:SendGetFinalRewardMsg(function()
    local mainCfg = self.shortTheatreGameCtrl:GetShorTheatreMainCfg()
    if mainCfg ~= nil then
      local rewardDic = mainCfg.reward_id
      UIUtil.ShowCommonReward(rewardDic)
    end
    self:RefreshTask()
    self:RefreshRewardProgress()
    self.shortTheatreGameCtrl:UpdActShortTheatreRedDot()
  end)
end

function UIShortTheatre:SetCloseCallback(callback)
  self.__closeCallback = callback
end

function UIShortTheatre:OnClickBtnClose()
  self:Delete()
  if self.__closeCallback ~= nil then
    local action = self.__closeCallback
    self.__closeCallback = nil
    action()
  end
end

function UIShortTheatre:OnDelete()
  TimerManager:StopTimer(self.leftTimeUpdateTimerId)
  self.leftTimeUpdateTimerId = nil
  self.taskItemPool:DeleteAll()
  self.resloader:Put2Pool()
  self.resloader = nil
  base.OnDelete(self)
end

return UIShortTheatre
