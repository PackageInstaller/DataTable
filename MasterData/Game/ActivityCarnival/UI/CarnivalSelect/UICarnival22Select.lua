local UICarnival22Select = class("UICarnival22Select", UIBaseWindow)
local base = UIBaseWindow
local FmtEnum = require("Game.Formation.FmtEnum")
local ActivityCarnivalEnum = require("Game.ActivityCarnival.ActivityCarnivalEnum")
local UINCarnival22EnvDetail = require("Game.ActivityCarnival.UI.CarnivalSelect.UINCarnival22EnvDetail")
local UINCarnival22Select = require("Game.ActivityCarnival.UI.CarnivalSelect.UINCarnival22Select")
local util = require("XLua.Common.xlua_util")
local cs_MessageCommon = CS.MessageCommon

function UICarnival22Select:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickBack)
  self._diffcultyPool = UIItemPool.New(UINCarnival22Select, self.ui.select)
  self.ui.select:SetActive(false)
  self.ui.windowInfo:SetActive(false)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_LeftTouch, self, self.OnClickChange, true)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_RightTouch, self, self.OnClickChange, false)
  UIUtil.AddButtonListener(self.ui.btn_InfoTouch, self, self.OnClickDetail)
  UIUtil.AddButtonListener(self.ui.btn_Icon, self, self.OnClickTicket)
  UIUtil.AddButtonListener(self.ui.btn_Battle, self, self._OnClickEnterBattle)
  self.__UpdateItemCallback = BindCallback(self, self.__UpdateItem)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__UpdateItemCallback)
  self.__OnUnlockEnvCallback = BindCallback(self, self.__OnUnlockEnv)
  MsgCenter:AddListener(eMsgEventId.ActivityCarnivalEnvUnlock, self.__OnUnlockEnvCallback)
  self.__OnSelectDiffcultyCallback = BindCallback(self, self.__OnSelectDiffculty)
  self.__RefreshReddotCallback = BindCallback(self, self.__RefreshReddot)
  self._EnterSelectEnvCallback = BindCallback(self, self.EnterSelectEnv)
end

function UICarnival22Select:InitCarnival22Select(actCarnivalData, closeFunc)
  self._closeFunc = closeFunc
  self._actCarnivalData = actCarnivalData
  self._carnivalCfg = self._actCarnivalData:GetCarnivalMainCfg()
  local unlockEnvDic = self._actCarnivalData:GetCarnivalUnlockEnv()
  self._unlockEnvList = {}
  for envId, _ in pairs(unlockEnvDic) do
    table.insert(self._unlockEnvList, envId)
  end
  table.sort(self._unlockEnvList)
  local showItemId = self._carnivalCfg.ticket_item
  self.ui.img_res_Icon.sprite = CRH:GetSpriteByItemId(showItemId)
  self.ui.tex_res_Count.text = tostring(PlayerDataCenter:GetItemCount(showItemId))
  self._diffcultyPool:HideAll()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local envId, diffculty = saveUserData:GetCarnivalDiffEnv(self._carnivalCfg.id)
  if envId == nil then
    self._curDiffculty = 1
    local envCfgs = self._actCarnivalData:GetCarnivalEnvCfg()
    self._selectEnvId = envCfgs[1].id
  else
    self._curDiffculty = diffculty
    self._selectEnvId = envId
  end
  local diffculityMax = ConfigData.activity_carnival_difficulty.maxDiffculty
  for i = 1, diffculityMax do
    local diffculityCfg = ConfigData.activity_carnival_difficulty[i]
    if diffculityCfg ~= nil then
      local item = self._diffcultyPool:GetOne()
      item:InitSelectItem(self._actCarnivalData, diffculityCfg, self.__OnSelectDiffcultyCallback)
      item:SetDiffcultySelected(diffculityCfg.id == self._curDiffculty)
    end
  end
  self:__RefreshSelectEnv(self._selectEnvId)
  if self._reddot == nil then
    local reddot = self._actCarnivalData:GetActivityReddot()
    if reddot ~= nil then
      self._reddot = reddot
      RedDotController:AddListener(reddot.nodePath, self.__RefreshReddotCallback)
      self:__RefreshReddot(reddot)
    end
  end
end

function UICarnival22Select:EnterSelectEnv(envId, stageId)
  if 0 < (envId or 0) and 0 < (stageId or 0) then
    if ConfigData.activity_carnival_env.stageEnvMapping[stageId] ~= envId then
      return
    end
    local stageIds = self._actCarnivalData:GetCarnivalEnvCfgById(envId).stage_id
    self._curDiffculty = table.indexof(stageIds, stageId)
  elseif 0 < (envId or 0) then
    if self._actCarnivalData:GetCarnivalEnvCfgById(envId) == nil then
      return
    end
    self._curDiffculty = 0
  elseif 0 < (stageId or 0) then
    envId = ConfigData.activity_carnival_env.stageEnvMapping[stageId]
    if envId == nil then
      return
    end
    local stageIds = self._actCarnivalData:GetCarnivalEnvCfgById(envId).stage_id
    self._curDiffculty = table.indexof(stageIds, stageId)
  else
    error("param all nil")
    return
  end
  self:__RefreshSelectEnv(envId)
end

function UICarnival22Select:__RefreshReddot(reddot)
  reddot = reddot:GetChild(ActivityCarnivalEnum.eActivityCarnivalReddot.UnlockEnv)
  self.ui.redDot:SetActive(reddot ~= nil and reddot:GetRedDotCount() > 0)
  self.ui.obj_New:SetActive(reddot ~= nil and reddot:GetRedDotCount() > 0)
end

function UICarnival22Select:OnClickChange(isLeft)
  local selectIndex = table.indexof(self._unlockEnvList, self._selectEnvId)
  if isLeft then
    if 1 < selectIndex then
      selectIndex = selectIndex - 1
    else
      selectIndex = #self._unlockEnvList
    end
  elseif selectIndex < #self._unlockEnvList then
    selectIndex = selectIndex + 1
  else
    selectIndex = 1
  end
  local selectEnvId = self._unlockEnvList[selectIndex]
  self:__RefreshSelectEnv(selectEnvId)
  self:__ClearEnvReddot()
end

function UICarnival22Select:__RefreshSelectEnv(envId)
  self._selectEnvId = envId
  local envCfg = self._actCarnivalData:GetCarnivalEnvCfgById(self._selectEnvId)
  local stageId = envCfg.stage_id[self._curDiffculty]
  local unlock = stageId ~= nil and PlayerDataCenter.sectorStage:IsStageUnlock(stageId)
  if not unlock then
    for i = #envCfg.stage_id, 1, -1 do
      local defaultStageId = envCfg.stage_id[i]
      local defaultUnlock = defaultStageId ~= nil and PlayerDataCenter.sectorStage:IsStageUnlock(defaultStageId)
      if defaultUnlock then
        self._curDiffculty = i
        break
      end
    end
    for i, item in ipairs(self._diffcultyPool.listItem) do
      item:SetDiffcultySelected(i == self._curDiffculty)
    end
  end
  self.ui.tex_ENumber.text = LanguageUtil.GetLocaleText(envCfg.env_name)
  self.ui.tex_EnviroName.text = LanguageUtil.GetLocaleText(envCfg.env_name)
  local extraContent = LanguageUtil.GetLocaleText(envCfg.env_des_extra)
  if not string.IsNullOrEmpty(extraContent) then
    self.ui.tex_Buff:SetIndex(0, extraContent)
  else
    self.ui.tex_Buff:SetIndex(1)
  end
  local selectEnvId = table.indexof(self._unlockEnvList, self._selectEnvId)
  if not selectEnvId then
    error("env not unlock ,envId is " .. tostring(self._selectEnvId))
    selectEnvId = 1
    self._selectEnvId = self._unlockEnvList[1]
  end
  self.ui.leftArrow:SetActive(1 < selectEnvId)
  self.ui.rightArrow:SetActive(selectEnvId < #self._unlockEnvList)
  self:__RefreshRecommenPower()
  for i, diffItem in ipairs(self._diffcultyPool.listItem) do
    diffItem:RefreshDiffcultyCost(self._selectEnvId)
  end
end

function UICarnival22Select:__ClearEnvReddot()
  local reddot = self._actCarnivalData:GetActivityReddot()
  if reddot == nil then
    return
  end
  reddot = reddot:GetChild(ActivityCarnivalEnum.eActivityCarnivalReddot.UnlockEnv)
  if reddot == nil then
    return
  end
  reddot:ClearChild()
end

function UICarnival22Select:__RefreshRecommenPower()
  local envCfg = self._actCarnivalData:GetCarnivalEnvCfgById(self._selectEnvId)
  local stageId = envCfg.stage_id[self._curDiffculty]
  if stageId == nil then
    error("stageId is NIL, envId is " .. tostring(self._selectEnvId) .. " diffculty is " .. tostring(self._curDiffculty))
    return
  end
  local stageCfg = ConfigData.sector_stage[stageId]
  if stageCfg == nil then
    error("stageCfg is NIL, stageId is" .. tostring(stageId))
    return
  end
  local recommenPower = stageCfg.combat
  self.ui.tex_Recommend:SetIndex(0, tostring(recommenPower))
  self.ui.image_key.sprite = CRH:GetSpriteByItemId(stageCfg.cost_strength_id)
  self.ui.tex_Point.text = tostring(stageCfg.cost_strength_num or 0)
  self._curStageCfg = stageCfg
end

function UICarnival22Select:OnClickDetail()
  local selectEnvId = self._selectEnvId
  if self._envDetailNode ~= nil then
    self._envDetailNode:Show()
    self._envDetailNode:OpenEnvDetail(selectEnvId)
  else
    self.ui.windowInfo:SetActive(true)
    self._envDetailNode = UINCarnival22EnvDetail.New()
    self._envDetailNode:Init(self.ui.windowInfo)
    self._envDetailNode:InitEnvDetail(self._actCarnivalData, selectEnvId, self._EnterSelectEnvCallback)
  end
  self:__ClearEnvReddot()
end

function UICarnival22Select:__OnSelectDiffculty(selectItem)
  self._curDiffculty = selectItem:GetSelectItemDiffcultyCfg().id
  for i, item in ipairs(self._diffcultyPool.listItem) do
    item:SetDiffcultySelected(item == selectItem)
  end
  self:__RefreshRecommenPower()
end

function UICarnival22Select:__UpdateItem(itemUpdate)
  local showItemId = self._carnivalCfg.ticket_item
  if itemUpdate[showItemId] == nil then
    return
  end
  self.ui.tex_res_Count.text = tostring(PlayerDataCenter:GetItemCount(showItemId))
end

function UICarnival22Select:__OnUnlockEnv()
  local unlockEnvDic = self._actCarnivalData:GetCarnivalUnlockEnv()
  table.removeall(self._unlockEnvList)
  for envId, _ in pairs(unlockEnvDic) do
    table.insert(self._unlockEnvList, envId)
  end
  table.sort(self._unlockEnvList)
  local selectEnvId = table.indexof(self._unlockEnvList, self._selectEnvId)
  self.ui.leftArrow:SetActive(1 < selectEnvId)
  self.ui.rightArrow:SetActive(selectEnvId < #self._unlockEnvList)
end

function UICarnival22Select:OnClickTicket()
  local showItemId = self._carnivalCfg.ticket_item
  local window = UIManager:ShowWindow(UIWindowTypeID.GlobalItemDetail)
  window:ParentWindowType(self:GetUIWindowTypeId())
  window:InitCommonItemDetail(ConfigData.item[showItemId])
end

function UICarnival22Select:_OnClickEnterBattle()
  self._enterFmtCo = GR.StartCoroutine(util.cs_generator(BindCallback(self, self._EnterMainFormationCo)))
end

function UICarnival22Select:_EnterMainFormationCo()
  local stageCfg = self._curStageCfg
  local stageId = stageCfg.id
  if 0 < (stageCfg.cost_strength_id or 0) then
    local curNum = PlayerDataCenter:GetItemCount(stageCfg.cost_strength_id)
    local waitConfimCost = false
    if curNum < ConfigData.game_config.carnivalCurrencyWarnNum then
      local waitConfimCost = true
      local confimOk = false
      UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
        if win == nil then
          return
        end
        local msg = ConfigData:GetTipContent(7121)
        win:ShowTextBoxWithYesAndNo(msg, function()
          waitConfimCost = false
          confimOk = true
        end, function()
          waitConfimCost = false
        end)
      end)
      while waitConfimCost do
        coroutine.yield(nil)
      end
      if not confimOk then
        self._enterFmtCo = nil
        return
      end
    end
    if curNum < (stageCfg.cost_strength_num or 0) then
      local tip = ConfigData:GetTipContent(7113)
      local itemName = ConfigData:GetItemName(stageCfg.cost_strength_id)
      tip = string.format(tip, itemName, itemName)
      cs_MessageCommon.ShowMessageTipsWithErrorSound(tip)
      self._enterFmtCo = nil
      return
    end
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  
  local function enterFunc()
    self:Hide()
    UIManager:HideWindow(UIWindowTypeID.Carnival22Main)
    UIManager:HideWindow(UIWindowTypeID.SectorEntrance)
  end
  
  local function exitFunc()
    UIManager:ShowWindowOnly(UIWindowTypeID.SectorEntrance)
    UIManager:ShowWindowOnly(UIWindowTypeID.Carnival22Main)
    self:Show()
  end
  
  local function startBattleFunc(curSelectFormationData, callBack)
    local totalFtPower, totalBenchPower = fmtCtrl:CalculatePower(curSelectFormationData)
    local curSelectFormationId = curSelectFormationData.id
    ExplorationManager:ReqEnterExploration(stageId, curSelectFormationId, proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration, false, callBack, curSelectFormationData:GetSupportHeroData(), false, nil, totalFtPower, totalBenchPower)
    saveUserData:SetLastFromModuleFmtId(FmtEnum.eFmtFromModule.CarnivalEp, curSelectFormationId)
  end
  
  local lastFmtId = saveUserData:GetLastFromModuleFmtId(FmtEnum.eFmtFromModule.CarnivalEp)
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.CarnivalEp, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetEnterBattleTicketItemId(stageCfg.cost_strength_id):SetEnterBattleCostTicketNum(stageCfg.cost_strength_num)
  fmtCtrl:EnterFormation()
  self._enterFmtCo = nil
end

function UICarnival22Select:OnClickBack()
  self:Delete()
  if self._closeFunc ~= nil then
    self._closeFunc()
  end
end

function UICarnival22Select:OnDelete()
  if self._enterFmtCo ~= nil then
    GR.StopCoroutine(self._enterFmtCo)
    self._enterFmtCo = nil
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:RecordCarnivalDiffEnv(self._carnivalCfg.id, self._selectEnvId, self._curDiffculty)
  base.OnDelete(self)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__UpdateItemCallback)
  MsgCenter:RemoveListener(eMsgEventId.ActivityCarnivalEnvUnlock, self.__OnUnlockEnvCallback)
  if self._reddot ~= nil then
    RedDotController:RemoveListener(self._reddot.nodePath, self.__RefreshReddotCallback)
  end
end

return UICarnival22Select
