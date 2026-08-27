local UIWCSModeSelect = class("UIWCSModeSelect", UIBaseWindow)
local base = UIBaseWindow
local cs_MessageCommon = CS.MessageCommon
local UINWCSSaveNode = require("Game.WarChessSeason.UI.WCSSelect.UINWCSSaveNode")
local UINWCSSelectTower = require("Game.WarChessSeason.UI.WCSSelect.UINWCSSelectTower")
local UINWCSEnvNode = require("Game.WarChessSeason.UI.WCSSelect.UINWCSEnvNode")
local SubNodeType = {
  Archieve = 1,
  SelectEnv = 2,
  SelectDiff = 3
}

function UIWCSModeSelect:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseChristmasSelect, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickCloseModeSelect)
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self.OnClickRollback)
  UIUtil.AddButtonListener(self.ui.btn_NewGame, self, self.__OnClickConfirm)
  self.__OnSelectArchiveCallback = BindCallback(self, self.__OnSelectArchive)
  self.__OnSelectEnvCallback = BindCallback(self, self.__OnSelectEnv)
  self.__OnOpenEnvTaskCallback = BindCallback(self, self.__OnOpenEnvTask)
  self.__seasonId = nil
  self.__loadSavingDataCallback = nil
  self.__startNewWCSCallback = nil
end

function UIWCSModeSelect:SetWCSModeSelectTask(taskReddot, taskUpdDotFunc)
  self._taskReddot = taskReddot
  self._taskUpdDotFunc = taskUpdDotFunc
  if self._taskReddot == nil then
    return
  end
  self._reddotFunc = BindCallback(self, self.__RefreshReddot)
  RedDotController:AddListener(self._taskReddot.nodePath, self._reddotFunc)
end

function UIWCSModeSelect:InitWCSModeSelect(seasonId, loadSavingDataCallback, startNewWCSCallback, closeCallback)
  self.__seasonId = seasonId
  self.__loadSavingDataCallback = loadSavingDataCallback
  self.__startNewWCSCallback = startNewWCSCallback
  self._closeCallback = closeCallback
  self.ui.obj_CostBg:SetActive(false)
  self:__OpenArchive()
end

function UIWCSModeSelect:__OpenArchive()
  self._subType = SubNodeType.Archieve
  if self._archiveNode == nil then
    self.ui.obj_checkPointNode:SetActive(true)
    self._archiveNode = UINWCSSaveNode.New()
    self._archiveNode:Init(self.ui.obj_checkPointNode)
    self._archiveNode:InitWCSSelectSaves(self.__seasonId, self.__OnSelectArchiveCallback)
    self._archiveNode:SetFileNameByEnvName()
    if self._taskReddot then
      self._archiveNode:ShowWCSSaveNewGameBlueDot(self._taskReddot:GetRedDotCount() > 0)
    end
  else
    self._archiveNode:Show()
  end
  if self._envNode ~= nil then
    self._envNode:Hide()
  else
    self.ui.obj_envtSelectNode:SetActive(false)
  end
  if self._diffNode ~= nil then
    self._diffNode:Hide()
  else
    self.ui.obj_modeSelectNode:SetActive(false)
  end
  self.ui.btn_Back.gameObject:SetActive(false)
  self.ui.btn_NewGame.gameObject:SetActive(false)
  self.ui.textEN:SetIndex(0)
  self.ui.textCN:SetIndex(0)
end

function UIWCSModeSelect:__OpenEnv()
  self._subType = SubNodeType.SelectEnv
  self._envId = nil
  if self._envNode == nil then
    self.ui.obj_envtSelectNode:SetActive(true)
    self._envNode = UINWCSEnvNode.New()
    self._envNode:Init(self.ui.obj_envtSelectNode)
    self._envNode:InitWCSEnvNode(self.__seasonId, self.__OnSelectEnvCallback, self.__OnOpenEnvTaskCallback)
    self._envNode:InitWCSEnvTaskReddot(self._taskReddot)
  else
    self._envNode:Show()
    self._envNode:RefreshChristmas22EnvNode()
  end
  if self._archiveNode ~= nil then
    self._archiveNode:Hide()
  else
    self.ui.obj_checkPointNode:SetActive(false)
  end
  if self._diffNode ~= nil then
    self._diffNode:Hide()
  else
    self.ui.obj_modeSelectNode:SetActive(false)
  end
  self.ui.btn_Back.gameObject:SetActive(true)
  self.ui.btn_NewGame.gameObject:SetActive(false)
  self.ui.obj_selectedOne:SetActive(false)
  self.ui.tex_back_name:SetIndex(1)
  self.ui.textEN:SetIndex(1)
  self.ui.textCN:SetIndex(1)
end

function UIWCSModeSelect:__OpenDiff()
  self._subType = SubNodeType.SelectDiff
  if self._diffNode == nil then
    self.ui.obj_modeSelectNode:SetActive(true)
    self._diffNode = UINWCSSelectTower.New()
    self._diffNode:Init(self.ui.obj_modeSelectNode)
  else
    self._diffNode:Show()
  end
  self._diffNode:InitWCSSelectTower(self.__seasonId, self._envId)
  if self._archiveNode ~= nil then
    self._archiveNode:Hide()
  else
    self.ui.obj_checkPointNode:SetActive(false)
  end
  if self._envNode ~= nil then
    self._envNode:Hide()
  else
    self.ui.obj_envtSelectNode:SetActive(false)
  end
  self.ui.btn_Back.gameObject:SetActive(true)
  self.ui.btn_NewGame.gameObject:SetActive(true)
  self.ui.tex_back_name:SetIndex(0)
  self.ui.tex_StartPlayText:SetIndex(2)
  self.ui.textEN:SetIndex(2)
  self.ui.textCN:SetIndex(2)
  self.ui.obj_selectedOne:SetActive(true)
  self.ui.tex_SelectedEnvName.text = LanguageUtil.GetLocaleText(self._envCfg.general_env_name)
end

function UIWCSModeSelect:__OnSelectArchive()
  self:__OnClickConfirm()
end

function UIWCSModeSelect:__OnSelectEnv(envId, envCfg)
  self._envId = envId
  self._envCfg = envCfg
  self:__OpenDiff()
end

function UIWCSModeSelect:__OnOpenEnvTask(envCfg)
  UIManager:ShowWindowAsync(UIWindowTypeID.ChristmasEnvTask, function(window)
    if window == nil then
      return
    end
    self.__ReqCommitEnvTaskListFunc = self.__ReqCommitEnvTaskListFunc or BindCallback(self, self._ReqCommitEnvTaskList)
    self._ReqCommitTaskFunc = self._ReqCommitTaskFunc or BindCallback(self, self._ReqCommitTask)
    window:InitChristmasEnvTask(envCfg.env_task, self.__ReqCommitEnvTaskListFunc, self._ReqCommitTaskFunc)
    local nameCfg = ConfigData.activity_hallowmas_name
    window:SetChristmasEnvTaskTitle(LanguageUtil.GetLocaleText(nameCfg[5].name))
  end)
end

function UIWCSModeSelect:_ReqCommitEnvTaskList(taskIds, callback)
  local taskIdDic = {}
  for k, id in pairs(taskIds) do
    taskIdDic[id] = true
  end
  NetworkManager:GetNetwork(NetworkTypeID.Task):CS_QUEST_OneKeyPick(taskIdDic, function()
    if self._taskUpdDotFunc ~= nil then
      self._taskUpdDotFunc()
    end
    if callback ~= nil then
      callback()
    end
  end)
end

function UIWCSModeSelect:_ReqCommitTask(taskId, callback)
  local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
  if taskData == nil or not taskData:CheckComplete() then
    return
  end
  NetworkManager:GetNetwork(NetworkTypeID.Task):SendCommitQuest(taskData, function()
    if self._taskUpdDotFunc ~= nil then
      self._taskUpdDotFunc()
    end
    local rewards, nums = taskData:GetTaskCfgRewards()
    local CommonRewardData = require("Game.CommonUI.CommonRewardData")
    local CRData = CommonRewardData.CreateCRDataUseList(rewards, nums)
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      window:AddAndTryShowReward(CRData)
    end)
    if callback ~= nil then
      callback()
    end
  end)
end

function UIWCSModeSelect:OnClickRollback()
  if self._subType == SubNodeType.SelectDiff then
    self:__OpenEnv()
  elseif self._subType == SubNodeType.SelectEnv then
    self:__OpenArchive()
  end
end

function UIWCSModeSelect:__OnClickConfirm()
  if self._subType == SubNodeType.Archieve then
    local selectNewGame, selectArchive = self._archiveNode:GetArchiveSelect()
    if selectNewGame then
      self:__OpenEnv()
    else
      cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(8717), function()
        if self.__loadSavingDataCallback ~= nil then
          self.__loadSavingDataCallback(selectArchive)
        end
      end, nil)
    end
  elseif self._subType == SubNodeType.SelectDiff then
    local stageInfoCfg = self._diffNode:GetWCSSelectDiffInfoCfg()
    if self.__startNewWCSCallback ~= nil then
      self.__startNewWCSCallback(stageInfoCfg, self._envId)
    end
  end
end

function UIWCSModeSelect:OnClickCloseModeSelect()
  UIUtil.OnClickBackByUiTab(self)
end

function UIWCSModeSelect:OnCloseChristmasSelect()
  if self._closeCallback ~= nil then
    self._closeCallback()
  end
  self:Delete()
end

function UIWCSModeSelect:__RefreshReddot(node)
  if self._envNode then
    self._envNode:UpdReddotWCSEnv(node)
  end
  if self._archiveNode then
    self._archiveNode:ShowWCSSaveNewGameBlueDot(node:GetRedDotCount() > 0)
  end
end

function UIWCSModeSelect:OnDelete()
  if self._reddotFunc then
    RedDotController:RemoveListener(self._taskReddot.nodePath, self._reddotFunc)
    self._reddotFunc = nil
  end
  if self._archiveNode ~= nil then
    self._archiveNode:OnDelete()
  end
  if self._diffNode ~= nil then
    self._diffNode:OnDelete()
  end
  if self._envNode ~= nil then
    self._envNode:OnDelete()
  end
  base.OnDelete(self)
end

return UIWCSModeSelect
