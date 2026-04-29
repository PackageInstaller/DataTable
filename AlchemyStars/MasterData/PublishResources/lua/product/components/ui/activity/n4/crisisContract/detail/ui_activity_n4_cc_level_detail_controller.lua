_class("UIActivityN4CCLevelDetailController", UIController)
UIActivityN4CCLevelDetailController = UIActivityN4CCLevelDetailController

function UIActivityN4CCLevelDetailController:OnShow(uiParams)
  self._levelData = uiParams[1]
  self._context = uiParams[2]
  self._closeCb = uiParams[3]
  self._campaign = self._context:GetCampaign()
  self:InitWidget()
  self:Refresh()
  self:_AttachEvents()
end

function UIActivityN4CCLevelDetailController:OnHide()
  self:_DetachEvents()
end

function UIActivityN4CCLevelDetailController:InitWidget()
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    self:CloseWithAni()
  end)
  self.bossFrame = self:GetUIComponent("Image", "bossFrame")
  self.imgBoss = self:GetUIComponent("RawImageLoader", "imgBoss")
  self.txtBossName = self:GetUIComponent("UILocalizationText", "txtBossName")
  self.txtBossName2 = self:GetUIComponent("UILocalizationText", "txtBossName2")
  local tabPool = self:GetUIComponent("UISelectObjectPath", "tab")
  self.tabItems = tabPool:SpawnObjects("UIActivityN4CCLevelDetailTab", 3)
  for i = 1, 3 do
    self.tabItems[i]:SetData(self._levelData[i], self._context, function(item)
      self:OnTabItemClicked(item)
    end)
  end
  local tabInfoPool = self:GetUIComponent("UISelectObjectPath", "tabInfo")
  self.tabInfo = tabInfoPool:SpawnObject("UIActivityN4CCLevelDetailTabInfo")
  self.tabInfo:Init(self._context)
  self.txtRecommend = self:GetUIComponent("UILocalizationText", "txtRecommend")
  local elementPool = self:GetUIComponent("UISelectObjectPath", "element")
  self.element = elementPool:SpawnObject("UIActivityN4CCLevelElement")
  self.conformGo = self:GetGameObject("conform")
  self.taskRedGo = self:GetGameObject("taskRed")
  self.animation = self:GetUIComponent("Animation", "animation")
end

function UIActivityN4CCLevelDetailController:CloseWithAni()
  self:Lock("UIActivityN4CCLevelDetailController_Close_Ani")
  self:StartTask(function(TT)
    self.animation:Play("uianim_UIActivityN4CCLevelDetailController_out")
    YIELD(TT, 500)
    self:CloseDialog()
    if self._closeCb then
      self._closeCb()
    end
    self:UnLock("UIActivityN4CCLevelDetailController_Close_Ani")
  end)
end

function UIActivityN4CCLevelDetailController:Refresh()
  local easyCfg = self._levelData[1]
  self.easyCfg = easyCfg
  self.imgBoss:LoadImage(easyCfg.MonsterIcon3)
  self.txtBossName:SetText(StringTable.Get(easyCfg.MissionName))
  self.txtBossName2:SetText(StringTable.Get(easyCfg.MissionName))
  self.element:SetData(self.easyCfg.ElementIcon1, self.easyCfg.ElementIcon2)
  self:_RefreshRed()
  for i = 3, 1, -1 do
    local tabItem = self.tabItems[i]
    if not tabItem:IsLock() then
      self:OnTabItemClicked(tabItem)
      break
    end
  end
end

function UIActivityN4CCLevelDetailController:_RefreshRed()
  local red = self._context:CheckTaskRed(self.easyCfg)
  self.taskRedGo:SetActive(red)
end

function UIActivityN4CCLevelDetailController:RefreshTabInfo()
  local cfg = self.lastSelectItem:GetCfg()
  self.tabInfo:SetData(cfg)
  local level = cfg.RecommendLV
  local awake = cfg.RecommendAwaken
  self.txtRecommend:SetText(StringTable.Get("str_crisis_contract_level_detail_recommend", awake, level))
end

function UIActivityN4CCLevelDetailController:OnTabItemClicked(tabItem)
  if self.lastSelectItem == tabItem then
    return
  end
  if self.lastSelectItem then
    self.lastSelectItem:SetSelect(false)
  end
  self.lastSelectItem = tabItem
  self.lastSelectItem:SetSelect(true)
  self:RefreshTabInfo()
end

function UIActivityN4CCLevelDetailController:BtnDialogBackOnClick(go)
  self.conformGo:SetActive(false)
end

function UIActivityN4CCLevelDetailController:BtnDialogContinueOnClick(go)
  self.conformGo:SetActive(false)
  self:StartTask(function(TT)
    self:_StartFight(TT)
  end)
end

function UIActivityN4CCLevelDetailController:BtnFightOnClick(go)
  if self.lastSelectItem == nil then
    return
  end
  local cfg = self.lastSelectItem:GetCfg()
  local missionId = cfg.CampaignMissionId
  local affix = self._context:GetAffix(missionId)
  if not affix or #affix == 0 or cfg.AffixNum > #affix then
    self.conformGo:SetActive(true)
    return
  end
  self:StartTask(function(TT)
    self:_StartFight(TT)
  end)
end

function UIActivityN4CCLevelDetailController:_StartFight(TT)
  local cfg = self.lastSelectItem:GetCfg()
  local missionId = cfg.CampaignMissionId
  local affix = self._context:GetAffix(missionId)
  local levelIndex = cfg.LeveIndex
  local component = self._context:GetComponent()
  local componentInfo = self._context:GetComponentInfo()
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  if not affix or #affix <= 0 then
    res = component:HandleClearAffix(TT, res, missionId)
  else
    res = component:HandleSelectAffix(TT, res, missionId, affix)
  end
  if res:GetSucc() then
    local missiontModule = GameGlobal.GetModule(MissionModule)
    local ctx = missiontModule:TeamCtx()
    local formationList = componentInfo.formation_list
    local team
    for i = 1, #formationList do
      local formation = formationList[i]
      if formation.id == levelIndex then
        team = formation
        break
      end
    end
    ctx:InitN21CCTeams(team, levelIndex)
    local level = cfg.RecommendLV
    local awake = cfg.RecommendAwaken
    local param = {
      missionId,
      component:GetCampaignMissionComponentId(),
      component:GetCampaignMissionParamKeyMap(),
      {
        true,
        level,
        awake
      }
    }
    ctx:Init(TeamOpenerType.N21CC, param)
    ctx:ShowDialogUITeams(false)
  else
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id)
  end
end

function UIActivityN4CCLevelDetailController:BtnTaskOnClick(go)
  self:ShowDialog("UIN4CCTaskController", self._context, self.easyCfg.Quest, function()
    self:_RefreshRed()
  end)
end

function UIActivityN4CCLevelDetailController:BtnRestrainOnClick(go)
  self:ShowDialog("UIRestrainTips")
end

function UIActivityN4CCLevelDetailController:BtnBossDetailOnClick(go)
  if self.lastSelectItem == nil then
    return
  end
  local cfg = self.lastSelectItem:GetCfg()
  local missionId = cfg.CampaignMissionId
  local cfgs = Cfg.cfg_campaign_mission({CampaignMissionId = missionId})
  if cfgs and 0 < #cfgs then
    local ids = {}
    local misionCfg = cfgs[1]
    local fightID = misionCfg.FightLevel
    local monsterIDs = UICommonHelper:GetInstance():GetOptimalEnemys(fightID)
    if monsterIDs == nil or #monsterIDs == 0 then
      Log.fatal("UIActivityN4CCLevelDetailController [Enemy] 怪物id列表为空")
    else
      local count = table.count(monsterIDs)
      for i = 1, count do
        table.insert(ids, monsterIDs[i])
      end
    end
    if #ids <= 0 then
      Log.debug("UIActivityN4CCLevelDetailController monster list is empty")
      return
    end
    self:ShowDialog("UIEnemyTip", ids, 1)
  end
end

function UIActivityN4CCLevelDetailController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIActivityN4CCLevelDetailController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIActivityN4CCLevelDetailController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:CloseDialog()
  end
end
