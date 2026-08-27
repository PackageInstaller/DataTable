local UIActivityStarUp = class("UIActivityStarUp", UIBaseWindow)
local base = UIBaseWindow
local UINActivityStarUpTask = require("Game.ActivityStarUp.UI.UINActivityStarUpTask")
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local ActivityStarUpEnum = require("Game.ActivityStarUp.ActivityStarUpEnum")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroLookTargetController = require("Game.Hero.Live2D.HeroLookTargetController")
local TaskEnum = require("Game.Task.TaskEnum")
local CS_OasisCameraController = CS.OasisCameraController
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function UIActivityStarUp:OnInit()
  self.ui.rewardItem:SetActive(false)
  self.rewardPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.rewardItem)
  self.__TaskUpdateCallback = BindCallback(self, self.TaskUpdateCallback)
  self.__ActivityChange = BindCallback(self, self.ActivityChange)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__ActivityChange)
  self.ui.scroll_task.onInstantiateItem = BindCallback(self, self.OnInstantiateItem)
  self.ui.scroll_task.onChangeItem = BindCallback(self, self.OnTaskChangeItem)
  self.taskItemDic = {}
  UIUtil.AddButtonListener(self.ui.btn_Preview, self, self.OnClickPreview)
  UIUtil.AddButtonListener(self.ui.btn_Get, self, self.OnClickReward)
  self.heroId = 0
  self.skinId = 0
end

function UIActivityStarUp:OnShow()
  if self.l2dBinding ~= nil then
    local interation = self.l2dBinding.renderController.transform:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if interation ~= nil then
      interation:RestartBodyAnimation()
    end
  end
  base.OnShow(self)
end

function UIActivityStarUp:InitWindow(id)
  self.activityInfo = PlayerDataCenter.activityStarUpData.dataDic[id]
  if self.activityInfo == nil then
    error("cant get StarUp activityInfo, id:" .. tostring(id))
    return
  end
  self:UpdateStage()
  self:DealExtraParam()
end

function UIActivityStarUp:UpdateStage()
  local stageId = self.activityInfo.curStageId
  if stageId == nil then
    stageId = #self.activityInfo.cfg.phase
  end
  local mainTask, childTasks = self.activityInfo:GetTasks(stageId)
  self.mainTask = mainTask
  self.childTasks = childTasks
  local stagePhase = self.activityInfo.cfg.phase[stageId]
  self.ui.tex_Head.text = LanguageUtil.GetLocaleText(stagePhase.name)
  self.ui.tex_CurrStage:SetIndex(0, tostring(stageId), tostring(#self.activityInfo.cfg.phase))
  self.rewardPool:HideAll()
  for i, v in ipairs(self.mainTask.stcData.rewardIds) do
    local item = self.rewardPool:GetOne(true)
    local itemCfg = ConfigData.item[v]
    local num = self.mainTask.stcData.rewardNums[i]
    item:InitItemWithCount(itemCfg, num, nil, self.mainTask.state == TaskEnum.eTaskState.Picked)
  end
  self:UpdateMainTaskState()
  self:SortChildTask()
end

function UIActivityStarUp:SortChildTask()
  table.sort(self.childTasks, function(a, b)
    if a.state ~= b.state then
      if a.state == TaskEnum.eTaskState.Picked then
        return false
      elseif b.state == TaskEnum.eTaskState.Picked then
        return true
      end
    end
    local aComplect = a:CheckComplete()
    local bComplect = b:CheckComplete()
    if aComplect ~= bComplect then
      return aComplect and true or false
    end
    if a.stcData.order ~= b.stcData.order then
      return a.stcData.order < b.stcData.order
    end
    return a.id < b.id
  end)
  self.ui.scroll_task.totalCount = #self.childTasks
  self.ui.scroll_task:RefillCells()
  local compolectCount = 0
  for i = 1, #self.childTasks do
    if self.childTasks[i].state == TaskEnum.eTaskState.Picked then
      compolectCount = compolectCount + 1
    end
  end
  self.ui.tex_CompleteCount.text = tostring(compolectCount) .. "/" .. tostring(#self.childTasks)
end

function UIActivityStarUp:UpdateMainTaskState()
  local isFinish = self.mainTask.state == TaskEnum.eTaskState.Picked
  local isComplect = self.mainTask:CheckComplete()
  for i, v in ipairs(self.rewardPool.listItem) do
    v:SetPickedUIActive(isFinish)
  end
  self.ui.obj_Unfinish:SetActive(not isComplect and not isFinish)
  self.ui.btn_Get.gameObject:SetActive(isComplect and not isFinish)
  self.ui.obj_Completed:SetActive(isFinish)
  self.ui.redDot_reward:SetActive(isComplect and not isFinish)
end

function UIActivityStarUp:TaskUpdateCallback(taskData)
  if taskData.id == self.mainTask.id then
    self:UpdateMainTaskState()
  else
    for k, v in pairs(self.taskItemDic) do
      if v.taskInfo.id == taskData.id then
        v:UpdateUI()
        break
      end
    end
  end
end

function UIActivityStarUp:ActivityChange(taskCfg)
  if self.activityInfo:ContainsTask(taskCfg.id) then
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CRData = CommonRewardData.CreateCRDataUseList(taskCfg.rewardIds, taskCfg.rewardNums)
      window:AddAndTryShowReward(CRData)
    end)
    if taskCfg.id == self.mainTask.id then
      self:UpdateStage()
    else
      local _, childTasks = self.activityInfo:GetTasks()
      self.childTasks = childTasks
      self:SortChildTask()
    end
  end
end

function UIActivityStarUp:OnInstantiateItem(go)
  local item = UINActivityStarUpTask.New()
  item:Init(go)
  self.taskItemDic[go] = item
end

function UIActivityStarUp:OnTaskChangeItem(go, index)
  self.taskItemDic[go]:InitItem(self.activityInfo, self.childTasks[index + 1])
end

function UIActivityStarUp:CloseUINoClick()
  UIUtil.OnClickBackByUiTab(self)
end

function UIActivityStarUp:OnClickPreview()
  UIManager:ShowWindowAsync(UIWindowTypeID.ActivityStarUpRewardPreview, function(window)
    if window ~= nil then
      window:InitView(self.activityInfo)
    end
  end)
end

function UIActivityStarUp:OnClickReward()
  local taskCtr = ControllerManager:GetController(ControllerTypeId.Task)
  taskCtr:SendCommitQuestReward(self.mainTask)
end

function UIActivityStarUp:DealExtraParam()
  if self.l2dModelIns ~= nil then
    HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
  end
  if self.bigImgGameObject ~= nil then
    DestroyUnityObject(self.bigImgGameObject)
  end
  for k, params in pairs(self.activityInfo.cfg.extra_para) do
    if k == ActivityStarUpEnum.eActivityExtraParamType.Live2DShow then
      local heroId = params[1]
      self.heroId = heroId
      self.skinId = ConfigData.hero_data[heroId].default_skin
      local resCfg = ConfigData.resource_model[heroId]
      local resName = resCfg.res_Name
      local resPath = PathConsts:GetCharacterLive2DPath(resName)
      local isHaveL2D = PlayerDataCenter.skinData:IsHaveL2d(self.skinId)
      local isLocked = HeroCubismInteration.JudgeL2DLocked(self.skinId)
      self.l2dBinding = nil
      if isHaveL2D and not isLocked then
        self:LoadLive2D(resPath, params)
        break
      end
      self:LoadPic(resName, params)
      break
    elseif k == ActivityStarUpEnum.eActivityExtraParamType.HeroPicShow then
      local heroId = params[1]
      local resCfg = ConfigData.resource_model[heroId]
      local resName = resCfg.res_Name
      self:LoadPic(resName, params)
      break
    end
  end
end

function UIActivityStarUp:LoadLive2D(path, params)
  if self.Live2DResloader ~= nil then
    self.Live2DResloader:Put2Pool()
    self.Live2DResloader = nil
  end
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  self.Live2DResloader = CS.ResLoader.Create()
  self.Live2DResloader:LoadABAssetAsync(path, function(l2dModelAsset)
    HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
    self.l2dModelIns = l2dModelAsset:Instantiate(self.ui.heroHolder.transform)
    self.l2dModelIns.transform:SetLayer(LayerMask.UI)
    local cs_CubismInterationController = self.l2dModelIns.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = HeroCubismInteration.New()
      local heroId = self.heroId
      local skinId = self.skinId
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting("UINormal", self.ui.canvasGroup, nil, true)
      self.heroCubismInteration:SetL2DPosType("ActivityStarUp", false)
    end
  end)
end

function UIActivityStarUp:LoadPic(path, params)
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  self.bigImgResloader = CS.ResLoader.Create()
  self.bigImgResloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(path), function(prefab)
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder.transform)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("ActivityStarUp")
  end)
end

function UIActivityStarUp:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__ActivityChange)
  if self.Live2DResloader ~= nil then
    self.Live2DResloader:Put2Pool()
    self.Live2DResloader = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  base.OnDelete(self)
end

return UIActivityStarUp
