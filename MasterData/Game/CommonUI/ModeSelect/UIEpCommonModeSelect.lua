local UIEpCommonModeSelect = class("UIEpCommonModeSelect", UIBaseWindow)
local base = UIBaseWindow
local ModeSelectData = require("Game.CommonUI.ModeSelect.Data.ModeSelectData")
local UINEpCommonModeSelectDiffNode = require("Game.CommonUI.ModeSelect.UINEpCommonModeSelectDiffNode")
local UINEpCommonModeSelectEnvNode = require("Game.CommonUI.ModeSelect.UINEpCommonModeSelectEnvNode")
local EpCommonModeSelectUtil = require("Game.CommonUI.ModeSelect.EpCommonModeSelectUtil")
local UINEpCmMdSlInfinite = require("Game.CommonUI.ModeSelect.Infinite.UINEpCmMdSlInfinite")
local SubNodeType = {
  SelectEnv = 1,
  SelectDiff = 2,
  Infinite = 3
}
local getNodeFuncDic = {
  [SubNodeType.SelectEnv] = function(self)
    return self._envNode
  end,
  [SubNodeType.SelectDiff] = function(self)
    return self._diffNode
  end,
  [SubNodeType.Infinite] = function(self)
    return self._infiniteNode
  end
}

function UIEpCommonModeSelect:OnInit()
  self.ui.infiniteSelectNode:SetActive(false)
  self.ui.obj_modeSelectNode:SetActive(false)
  self.ui.obj_envtSelectNode:SetActive(false)
  UIUtil.SetTopStatus(self, self.Delete, nil, nil, nil, nil)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickCloseModeSelect)
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self.OnClickRollback)
  UIUtil.AddButtonListener(self.ui.btn_NewGame, self, self.OnClickConfirm)
  self.__OnSelectEnvCallback = BindCallback(self, self.__OnSelectEnv)
  self.__OnSelectDiffCallback = BindCallback(self, self.__OnSelectDiff)
  self.__startSpring23QuickBattle = BindCallback(self, self.__StartSpring23QuickBattle)
end

function UIEpCommonModeSelect:InitEpCommonModeSelect(arg1, startBattleFunc, quickBattleFunc, closeCallback)
  local modeData
  if type(arg1) == "number" then
    modeData = ModeSelectData.New(arg1)
  else
    modeData = arg1
  end
  self._modeData = modeData
  self._startBattleFunc = startBattleFunc
  self._quickBattleFunc = quickBattleFunc
  self.closeCallback = closeCallback
  self:__OpenEnv()
  local tickId = self._modeData:getMainCfg().ticket_item
  UIUtil.RefreshTopResId({tickId})
end

function UIEpCommonModeSelect:_GetCurNode()
  if self._subType == nil then
    return
  end
  local func = getNodeFuncDic[self._subType]
  if func == nil then
    error("cant get getNodeFuncDic, type:" .. tostring(self._subType))
    return
  end
  return func(self)
end

function UIEpCommonModeSelect:_HideCurNode()
  local node = self:_GetCurNode()
  if node then
    node:Hide()
  end
end

function UIEpCommonModeSelect:__OpenEnv()
  self:_HideCurNode()
  self._subType = SubNodeType.SelectEnv
  self._envId = nil
  if self._envNode == nil then
    self._envNode = UINEpCommonModeSelectEnvNode.New()
    self._envNode:Init(self.ui.obj_envtSelectNode)
    self._envNode:InitEpCommonEnvNode(self._modeData, self.__OnSelectEnvCallback)
  end
  self._envNode:RefreshSpring23EnvNode()
  self._envNode:Show()
  self.ui.btn_Back.gameObject:SetActive(false)
  self.ui.btn_NewGame.gameObject:SetActive(false)
  self.ui.obj_newGameCost:SetActive(true)
  self.ui.textEN:SetIndex(0)
  self.ui.textCN:SetIndex(0)
end

function UIEpCommonModeSelect:__OpenDiff()
  self:_HideCurNode()
  self._subType = SubNodeType.SelectDiff
  if self._diffNode == nil then
    self._diffNode = UINEpCommonModeSelectDiffNode.New()
    self._diffNode:Init(self.ui.obj_modeSelectNode)
  end
  self._diffNode:InitSpring23SelectMode(self._modeData, self._envId, self.__OnSelectDiffCallback, nil, self.__startSpring23QuickBattle)
  self._diffNode:Show()
  self.ui.btn_Back.gameObject:SetActive(true)
  self.ui.btn_NewGame.gameObject:SetActive(true)
  self.ui.textEN:SetIndex(1)
  self.ui.textCN:SetIndex(1)
  self.ui.tex_NewGameText:SetIndex(1)
  self.ui.obj_newGameCost:SetActive(true)
  local envCfg = ConfigData.act_general_ep_env[self._envId]
  self.ui.tex_SelectedEnvName.text = LanguageUtil.GetLocaleText(envCfg.env_name)
end

function UIEpCommonModeSelect:__OpenInfinite(envCfg)
  if self._infiniteNode == nil then
    self._infiniteNode = UINEpCmMdSlInfinite.New()
    self._infiniteNode:Init(self.ui.infiniteSelectNode)
  end
  self._infiniteNode:InitEpCmMdSlInfinite(self._modeData, envCfg, function()
    self:_HideCurNode()
    self._subType = SubNodeType.Infinite
    self.ui.btn_Back.gameObject:SetActive(true)
    self.ui.btn_NewGame.gameObject:SetActive(true)
    self.ui.tex_SaveFormationTip:SetActive(false)
    self.ui.textEN:SetIndex(2)
    self.ui.textCN:SetIndex(2)
    self.ui.tex_NewGameText:SetIndex(3)
    self.ui.obj_newGameCost:SetActive(false)
    self.ui.tex_SelectedEnvName.text = LanguageUtil.GetLocaleText(envCfg.env_name)
  end)
end

function UIEpCommonModeSelect:__OnSelectEnv(envId)
  self._envId = envId
  local envCfg = ConfigData.act_general_ep_env[envId]
  if envCfg and #envCfg.use_team > 1 then
    self:__OpenInfinite(envCfg)
    return
  end
  self:__OpenDiff()
end

function UIEpCommonModeSelect:__OnSelectDiff(diff, index)
  self._diffId = diff
  self._index = index
  local envCfg = ConfigData.act_general_ep_env[self._envId]
  local stageId = envCfg.stage_id[self._index]
  local stageCfg = ConfigData.sector_stage[stageId]
  local costStamina = stageCfg.cost_strength_num
  self.ui.tex_Cost.text = "-" .. tostring(costStamina)
  local isInfinity = EpCommonModeSelectUtil.IsEpCommonInfinity(diff)
  self.ui.tex_SaveFormationTip:SetActive(envCfg.save_team > 0 and not isInfinity)
end

function UIEpCommonModeSelect:OnClickConfirm()
  if self._subType == SubNodeType.SelectDiff then
    local function EnterFormation()
      local stageChallengeData, epInifinityData
      
      if self._diffNode ~= nil then
        stageChallengeData = self._diffNode:GetSatgeChallengeData()
        epInifinityData = self._diffNode:GetEpInifinityData()
        if stageChallengeData ~= nil then
          stageChallengeData:TrySaveStgChallengeTask()
        end
      end
      if self._startBattleFunc ~= nil then
        self._startBattleFunc(self._envId, self._diffId, self._index, stageChallengeData, function(isChallengeMode)
          if self._diffNode ~= nil then
            self._diffNode:_SetChallengeModeOpen(isChallengeMode, true)
          end
        end, epInifinityData)
      end
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
    return
  end
  if self._subType == SubNodeType.Infinite then
    local epInifinityData = self._infiniteNode:GetEpInifiniteData()
    if self._startBattleFunc ~= nil then
      self._startBattleFunc(self._envId, self._diffId, 1, nil, nil, epInifinityData)
    end
    return
  end
end

function UIEpCommonModeSelect:__StartSpring23QuickBattle()
  if self._quickBattleFunc ~= nil then
    self._quickBattleFunc(self._envId, self._diffId, self._index)
  end
end

function UIEpCommonModeSelect:OnClickRollback()
  if self._subType == SubNodeType.SelectDiff or self._subType == SubNodeType.Infinite then
    self:__OpenEnv()
  end
end

function UIEpCommonModeSelect:OnClickCloseModeSelect()
  UIUtil.OnClickBackByUiTab(self)
end

function UIEpCommonModeSelect:OnDelete()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  if self._diffNode ~= nil then
    self._diffNode:OnDelete()
  end
  if self._envNode ~= nil then
    self._envNode:OnDelete()
  end
  if self._infiniteNode ~= nil then
    self._infiniteNode:OnDelete()
  end
  base.OnDelete(self)
end

return UIEpCommonModeSelect
