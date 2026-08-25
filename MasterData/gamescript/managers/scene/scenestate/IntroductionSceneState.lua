local IntroductionScene, Super = System.NewClass("IntroductionScene", BaseSceneState)

function IntroductionScene:ctor()
  Super.ctor(self)
end

function IntroductionScene:OnInitSceneData()
  self.curStep = 0
end

function IntroductionScene:OnEnterScene(data)
  Super.OnEnterScene(self)
  EventMgr.Instance.OnStoryEnd:RegisterEvent(System.fn(self, self.OnStoryEnd))
  AvgStoryManager.Instance:ClearSkipPlot()
  self.stageTid = data.stageTid
  self.copyData = data.copyData
  if data.jumpNext then
    self:SetNextStep(data.step)
    self:DoStep(self.curStep)
  else
    self:DoStep(data.step)
  end
end

function IntroductionScene:OnExitScene()
  Super.OnExitScene(self)
  EventMgr.Instance.OnStoryEnd:RemoveEvent(System.fn(self, self.OnStoryEnd))
end

function IntroductionScene:GetConfig(step)
  local cfgData = DT.GetOriginalConstant("PrologueBeginPlot")
  return cfgData[step]
end

function IntroductionScene:DoStep(step)
  assert(type(step) == "number")
  Logger.Info("[IntroductionScene] DoStep", step)
  self.curStep = step
  local introCopyTid = IntroductionDataUtils.GetStageGroupId()
  local IntroStepType = CommonDefine.IntroStepType
  if IntroductionDataUtils.IsFinish(step) then
    Logger.Info("[IntroductionScene] 序章结束")
    SceneMgr.Instance:EnterTown()
  else
    local stepInfo = IntroductionDataUtils.GetStepData(step)
    if stepInfo.stepType == IntroStepType.AvgDialog then
      AvgStoryManager.Instance:StartStoryById(stepInfo.id)
    elseif stepInfo.stepType == IntroStepType.Name then
      UIManager.Instance:Reopen(Urls.SetGenderPanel, function()
        self:SetNextStep(step)
        self:DoStep(self.curStep)
      end)
    elseif stepInfo.stepType == IntroStepType.Constant then
      if self.stageTid and self.copyData then
        Logger.Info("[IntroductionScene] 第一场战斗结束")
        self:SetNextStep(step)
        TimerManager.Instance:CreateTimer(0.01, 1, function()
          local data = WorldStageManager.Instance:GenerateStageData(self.stageTid)
          WorldStageManager.Instance:StartStage(data.groupId, self.copyData)
        end)
      else
        Logger.Info("[IntroductionScene] 第一场战斗开始")
        local result = CopyDataUtils.GetCfgStageList(introCopyTid)
        WorldStageManager.Instance:Open(result[1].ID)
      end
    elseif stepInfo.stepType == IntroStepType.GetAwaker then
      local animData = {
        summonNum = 1,
        skipBeginAnim = true,
        isSpecialAwakerTid = true
      }
      local summonItemData = {
        awakerItemTid = stepInfo.id
      }
      SummonDataUtils.ShowGainItems(summonItemData)
      UIManager.Instance:Reopen(Urls.SummonNewItemPanel, nil, nil, nil, animData, function()
        self:SetNextStep(step)
        self:DoStep(self.curStep)
      end)
      local config = AwakerDataUtils.GetAwakerConfig(stepInfo.id)
      local desc = LT.Textf(DT.TipsType[10550].Desc, LT.Text(config.Name))
    elseif stepInfo.stepType == IntroStepType.StageGroup then
      local result = CopyDataUtils.GetCfgStageList(introCopyTid)
      local tid
      if self.stageTid then
        for k, v in ipairs(result) do
          if v.ID == self.stageTid then
            tid = result[k + 1] and result[k + 1].ID
            break
          end
        end
        if tid then
          Logger.Info(string.format("[IntroductionScene] 进入序章关卡：step = %s, tid = %s", step, tid))
          WorldStageManager.Instance:Open(tid)
        else
          self:SetNextStep(step)
          self:DoStep(self.curStep)
        end
      else
        local stageTid = DBGMainCopyDataUtils.GetLatestStoryLineId(introCopyTid)
        if stageTid and 0 ~= stageTid then
          WorldStageManager.Instance:Open(stageTid)
        else
          Logger.Warn("序章意外终止~")
          self:SetNextStep(step)
          self:DoStep(self.curStep)
        end
      end
    end
  end
end

function IntroductionScene:OnStoryEnd(storyId)
  local stepInfo = IntroductionDataUtils.GetStepData(self.curStep)
  if stepInfo and stepInfo.stepType == CommonDefine.IntroStepType.AvgDialog and stepInfo.id == storyId then
    self:SetNextStep(self.curStep)
    self:DoStep(self.curStep)
  end
end

function IntroductionScene:SetNextStep(step)
  if step ~= self.curStep then
    return
  end
  if IntroductionDataUtils.IsFinish() then
    self.curStep = DataCenter.introductionData.introData.step
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "SetIntroductionStep", function(data)
    Logger.Info("ReqNextStep>>>>", table.tostring(data))
  end)
  self.curStep = step + 1
  IntroductionDataUtils.SetStep(self.curStep)
  Logger.Warn("SetNextStep>>>>", self.curStep, DataCenter.introductionData.maxStep)
  local stepInfo = IntroductionDataUtils.GetStepData(self.curStep)
  if stepInfo and stepInfo.stepType == "Constant" then
    self:SetNextStep(self.curStep)
  end
end

return IntroductionScene
