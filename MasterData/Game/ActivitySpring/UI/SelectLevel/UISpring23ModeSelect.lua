local UISpring23ModeSelect = class("UISpring23ModeSelect", UIBaseWindow)
local base = UIBaseWindow
local UINSpring23ModeSelectDiffNode = require("Game.ActivitySpring.UI.SelectLevel.UINSpring23ModeSelectDiffNode")
local UIMSpring23ModeSelectEnvNode = require("Game.ActivitySpring.UI.SelectLevel.UINSpring23ModeSelectEnvNode")
local SubNodeType = {SelectEnv = 1, SelectDiff = 2}

function UISpring23ModeSelect:OnInit()
  UIUtil.SetTopStatus(self, self.Delete, nil, nil, nil, nil)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickCloseModeSelect)
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self.OnClickRollback)
  UIUtil.AddButtonListener(self.ui.btn_NewGame, self, self.OnClickConfirm)
  self.__OnSelectEnvCallback = BindCallback(self, self.__OnSelectEnv)
  self.__OnSelectDiffCallback = BindCallback(self, self.__OnSelectDiff)
  self.__startSpring23QuickBattle = BindCallback(self, self.__StartSpring23QuickBattle)
end

function UISpring23ModeSelect:InitSpring23ModeSelect(actSpringData, closeCallback)
  self._data = actSpringData
  self.closeCallback = closeCallback
  self:__OpenEnv()
  local tickId = actSpringData:GetSpringTicketID()
  UIUtil.RefreshTopResId({tickId})
end

function UISpring23ModeSelect:__OpenEnv()
  self._subType = SubNodeType.SelectEnv
  self._envId = nil
  if self._envNode == nil then
    self._envNode = UIMSpring23ModeSelectEnvNode.New()
    self._envNode:Init(self.ui.obj_envtSelectNode)
    self._envNode:InitSpring23EnvNode(self._data, self.__OnSelectEnvCallback)
  end
  self._envNode:RefreshSpring23EnvNode()
  self._envNode:Show()
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

function UISpring23ModeSelect:__OpenDiff()
  self._subType = SubNodeType.SelectDiff
  if self._diffNode == nil then
    self._diffNode = UINSpring23ModeSelectDiffNode.New()
    self._diffNode:Init(self.ui.obj_modeSelectNode)
  end
  self._diffNode:InitSpring23SelectMode(self._data, self._envId, self.__OnSelectDiffCallback, nil, self.__startSpring23QuickBattle)
  self._diffNode:Show()
  if self._envNode ~= nil then
    self._envNode:Hide()
  else
    self.ui.obj_envtSelectNode:SetActive(false)
  end
  self.ui.btn_Back.gameObject:SetActive(true)
  self.ui.btn_NewGame.gameObject:SetActive(true)
  self.ui.textEN:SetIndex(1)
  self.ui.textCN:SetIndex(1)
  self.ui.tex_NewGameText:SetIndex(1)
  local envCfg = ConfigData.activity_spring_advanced_env[self._envId]
  self.ui.tex_SelectedEnvName.text = LanguageUtil.GetLocaleText(envCfg.env_name)
end

function UISpring23ModeSelect:__OnSelectEnv(envId)
  self._envId = envId
  self:__OpenDiff()
end

function UISpring23ModeSelect:__OnSelectDiff(diff, index)
  self._diffId = diff
  self._index = index
  local envCfg = ConfigData.activity_spring_advanced_env[self._envId]
  local stageId = envCfg.stage_id[self._index]
  local stageCfg = ConfigData.sector_stage[stageId]
  local costStamina = stageCfg.cost_strength_num
  self.ui.tex_Cost.text = "-" .. tostring(costStamina)
end

function UISpring23ModeSelect:OnClickConfirm()
  if self._subType == SubNodeType.SelectDiff then
    local function EnterFormation()
      local stageChallengeData
      
      if self._diffNode ~= nil then
        stageChallengeData = self._diffNode:GetSatgeChallengeData()
        if stageChallengeData ~= nil then
          stageChallengeData:TrySaveStgChallengeTask()
        end
      end
      local ctrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
      ctrl:EnterSpringEp(self._data, self._envId, self._diffId, self._index, stageChallengeData, function(isChallengeMode)
        if self._diffNode ~= nil then
          self._diffNode:_SetChallengeModeOpen(isChallengeMode, true)
        end
      end)
    end
    
    local curStamina = PlayerDataCenter.stamina:GetCurrentStamina()
    if curStamina < ConfigData.game_config.staminaWarnNum then
      local staminaCeiling = PlayerDataCenter.stamina:GetStaminaCeiling()
      local msg = string.format(ConfigData:GetTipContent(751), curStamina, staminaCeiling)
      local msgWindow = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
      msgWindow:ShowTextBoxWithYesAndNo(msg, function()
        EnterFormation()
      end, function()
        return
      end)
    else
      EnterFormation()
    end
  end
end

function UISpring23ModeSelect:__StartSpring23QuickBattle()
  local ctrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
  ctrl:EnterSpringEpQuickBattle(self._data, self._envId, self._diffId, self._index)
end

function UISpring23ModeSelect:OnClickRollback()
  if self._subType == SubNodeType.SelectDiff then
    self:__OpenEnv()
  end
end

function UISpring23ModeSelect:OnClickCloseModeSelect()
  UIUtil.OnClickBackByUiTab(self)
end

function UISpring23ModeSelect:OnDelete()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  if self._diffNode ~= nil then
    self._diffNode:OnDelete()
  end
  if self._envNode ~= nil then
    self._envNode:OnDelete()
  end
  base.OnDelete(self)
end

return UISpring23ModeSelect
