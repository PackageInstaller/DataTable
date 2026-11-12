local AdventureModuleHelper = CS.AdventureModuleHelper
local BossPanelCtrl = class("BossPanelCtrl", BaseCtrl)
BossPanelCtrl._mapNodeConfig = {
  BossCanvas = {sNodeName = "Boss", sComponentName = "Canvas"},
  BossCanvasGroup = {
    sNodeName = "Boss",
    sComponentName = "CanvasGroup"
  },
  animBoss = {sNodeName = "Boss", sComponentName = "Animator"},
  singleBoss = {
    sNodeName = "goSingleBoss",
    sCtrlName = "Game.UI.Battle.BossHUDCtrl"
  },
  goMultipleBoss = {},
  goBossCtrl = {
    nCount = 3,
    sNodeName = "goMultipleBoss",
    sCtrlName = "Game.UI.Battle.BossHUDCtrl"
  },
  goJointDrillBoss_2 = {},
  goJointDrillBossCtrl = {
    nCount = 2,
    sNodeName = "goJointDrillBoss_2_",
    sCtrlName = "Game.UI.Battle.BossHUDCtrl"
  }
}
BossPanelCtrl._mapEventConfig = {
  RefreshCenterHpBar = "OnEvent_RefreshCenterHpBar",
  MonsterBossDead = "OnEvent_MonsterBossDead",
  ShowCenterHpBar = "OnEvent_ShowCenterHpBar",
  InputEnable = "OnEvent_InputEnable",
  Level_Settlement = "OnEvent_ResetBossHUD",
  ResetBossHUD = "OnEvent_ResetBossHUD",
  ADVENTURE_LEVEL_UNLOAD_COMPLETE = "OnEvent_ResetBossHUD"
}

function BossPanelCtrl:Awake()
  self.bInputEnable = false
  self.inputEnableCallback = nil
end

function BossPanelCtrl:OnEnable()
  self.bInit = true
  self.nBloodType = 0
  self.tbBoss = {}
  self.tbBossCtrl = {}
  self._mapNode.BossCanvas.enabled = true
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.BossCanvasGroup, 0)
  NovaAPI.SetComponentEnable(self._mapNode.BossCanvas, false)
end

function BossPanelCtrl:OnDisable()
  self.tbBoss = {}
end

function BossPanelCtrl:OnDestroy()
end

function BossPanelCtrl:SetBossHUD(mapData, ctrl, bRefresh)
  ctrl:CloseUI()
  ctrl:OpenUI(mapData.nBossId, mapData.nDataId, mapData.nType, self.nBloodType, bRefresh)
  self.tbBossCtrl[mapData.nBossId] = ctrl
end

function BossPanelCtrl:RefreshBossPanel(bRefresh)
  if #self.tbBoss == 0 then
    self:CloseUI()
    return
  end
  if self.bInit then
    self.bInit = false
    NovaAPI.SetComponentEnable(self._mapNode.BossCanvas, true)
    self.bossHUDOpenAnimTweener = Sequence()
    self.bossHUDOpenAnimTweener:Append(self._mapNode.BossCanvasGroup:DOFade(1, 0.5))
    self.bossHUDOpenAnimTweener:SetUpdate(true)
    self.bossHUDOpenAnimTweener:OnComplete(function()
      self.bossHUDOpenAnimTweener:Kill()
      self.bossHUDOpenAnimTweener = nil
    end)
  end
  self.nBloodType = 0
  
  local function refreshHUD()
    if self.nBloodType == AllEnum.BossBloodType.Single then
      self._mapNode.singleBoss.gameObject:SetActive(true)
      self._mapNode.goMultipleBoss.gameObject:SetActive(false)
      self._mapNode.goJointDrillBoss_2.gameObject:SetActive(false)
      local mapData = self.tbBoss[1]
      self:SetBossHUD(mapData, self._mapNode.singleBoss, bRefresh)
      self.tbBoss[1].bInit = false
      EventManager.Hit("ShowBossHUD", mapData.nBossId, mapData.nType, false, mapData.nDataId, self.nBloodType)
    elseif self.nBloodType == AllEnum.BossBloodType.Multiple then
      self._mapNode.singleBoss.gameObject:SetActive(false)
      self._mapNode.goMultipleBoss.gameObject:SetActive(true)
      self._mapNode.goJointDrillBoss_2.gameObject:SetActive(false)
      for i, v in ipairs(self._mapNode.goBossCtrl) do
        v.gameObject:SetActive(self.tbBoss[i] ~= nil)
        if self.tbBoss[i] ~= nil then
          self:SetBossHUD(self.tbBoss[i], v, bRefresh)
          self.tbBoss[i].bInit = false
          EventManager.Hit("ShowBossHUD", self.tbBoss[i].nBossId, self.tbBoss[i].nType, true, self.tbBoss[i].nDataId, self.nBloodType)
        end
      end
    elseif self.nBloodType == AllEnum.BossBloodType.JointDrill_Mode_2 then
      self._mapNode.singleBoss.gameObject:SetActive(false)
      self._mapNode.goMultipleBoss.gameObject:SetActive(false)
      self._mapNode.goJointDrillBoss_2.gameObject:SetActive(true)
      for i, v in ipairs(self._mapNode.goJointDrillBossCtrl) do
        v.gameObject:SetActive(self.tbBoss[i] ~= nil)
        if self.tbBoss[i] ~= nil then
          self:SetBossHUD(self.tbBoss[i], v, bRefresh)
          self.tbBoss[i].bInit = false
          EventManager.Hit("ShowBossHUD", self.tbBoss[i].nBossId, self.tbBoss[i].nType, true, self.tbBoss[i].nDataId, self.nBloodType)
        end
      end
    end
  end
  
  if self.bossAnimTimer ~= nil then
    self.bossAnimTimer:Cancel()
    self.bossAnimTimer = nil
    if self.nBloodType == AllEnum.BossBloodType.Multiple then
      refreshHUD()
    end
  end
  if #self.tbBoss == 1 then
    self.nBloodType = AllEnum.BossBloodType.Single
    if self.nLastBossCount == 2 then
      local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.animBoss, {
        "MultipleBoss_out"
      })
      self.bossAnimTimer = self:AddTimer(1, nAnimLen, function()
        self._mapNode.animBoss:Play("SingleBoss_in", 0, 0)
        self.bossAnimTimer = nil
        refreshHUD()
      end)
      self._mapNode.animBoss:Play("MultipleBoss_out", 0, 0)
    else
      self._mapNode.animBoss:Play("SingleBoss_in", 0, 0)
      refreshHUD()
    end
  else
    self.nBloodType = AllEnum.BossBloodType.Multiple
    if self._panel.nType ~= nil and self._panel.nType == GameEnum.JointDrillMode.JointDrill_Mode_2 and #self.tbBoss == 2 then
      self.nBloodType = AllEnum.BossBloodType.JointDrill_Mode_2
    end
    if self.nLastBossCount == 3 and #self.tbBoss == 2 then
      local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.animBoss, {
        "MultipleBoss_out"
      })
      self.bossAnimTimer = self:AddTimer(1, nAnimLen, function()
        self._mapNode.animBoss:Play("MultipleBoss_in", 0, 0)
        self.bossAnimTimer = nil
        refreshHUD()
      end)
      self._mapNode.animBoss:Play("MultipleBoss_out", 0, 0)
    else
      refreshHUD()
      self._mapNode.animBoss:Play("MultipleBoss_in", 0, 0)
    end
  end
  self.nLastBossCount = #self.tbBoss
end

function BossPanelCtrl:CloseUI()
  if #self.tbBoss == 0 and next(self.tbBossCtrl) == nil then
    self._mapNode.BossCanvas.enabled = false
    return
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.BossCanvasGroup, 1)
  self.bossHUDCloseAnimTweener = Sequence()
  self.bossHUDCloseAnimTweener:Append(self._mapNode.BossCanvasGroup:DOFade(0, 0.5))
  self.bossHUDCloseAnimTweener:OnComplete(function()
    self._mapNode.BossCanvas.enabled = false
    self.bossHUDCloseAnimTweener:Kill()
    self.bossHUDCloseAnimTweener = nil
  end)
  self.bossHUDCloseAnimTweener:SetUpdate(true)
  self.tbBoss = {}
  self.tbBossCtrl = {}
end

function BossPanelCtrl:OnEvent_ShowCenterHpBar(nBossId, nType, bShow, nDataId)
  if (nType == GameEnum.monsterBloodType.BOSS or nType == GameEnum.monsterBloodType.MINIBOSS or nType == GameEnum.monsterBloodType.BOSSRUSH or nType == GameEnum.monsterBloodType.JOINTDRILLBOSS) and bShow then
    local bAdded = false
    self.nLastBossCount = #self.tbBoss
    for _, v in ipairs(self.tbBoss) do
      if v.nBossId == nBossId then
        bAdded = true
        break
      end
    end
    if not bAdded then
      if #self.tbBoss >= 3 then
        printError("场上同时显示boss血条数量超过3！！！")
        return
      end
      local nSortType = 0
      if nType == GameEnum.monsterBloodType.BOSSRUSH or nType == GameEnum.monsterBloodType.JOINTDRILLBOSS then
        local nBossCount = 0
        for _, v in ipairs(self.tbBoss) do
          if v.nType == GameEnum.monsterBloodType.BOSSRUSH then
            nBossCount = nBossCount + 1
          end
        end
        if 1 < nBossCount then
          return
        end
      elseif nType == GameEnum.monsterBloodType.BOSS then
        nSortType = 1
      elseif nType == GameEnum.monsterBloodType.MINIBOSS then
        nSortType = 2
      end
      table.insert(self.tbBoss, {
        nBossId = nBossId,
        nType = nType,
        nSortType = nSortType,
        nDataId = nDataId,
        bInit = true
      })
      table.sort(self.tbBoss, function(a, b)
        if a.nSortType == b.nSortType then
          return a.nDataId < b.nDataId
        end
        return a.nSortType < b.nSortType
      end)
      if self.bInputEnable then
        self.inputEnableCallback = nil
        self:RefreshBossPanel()
      else
        function self.inputEnableCallback()
          self:RefreshBossPanel()
        end
      end
    end
  else
  end
end

function BossPanelCtrl:OnEvent_ResetBossHUD()
  self.bInit = true
  self.nBloodType = 0
  for _, v in pairs(self.tbBossCtrl) do
    v:CloseUI()
  end
  self:CloseUI()
end

function BossPanelCtrl:OnEvent_RefreshCenterHpBar()
  if self.bInputEnable then
    self.inputEnableCallback = nil
    self:RefreshBossPanel(true)
  else
    function self.inputEnableCallback()
      self:RefreshBossPanel(true)
    end
  end
end

function BossPanelCtrl:OnEvent_MonsterBossDead(nBossId)
  local nIndex = 0
  for k, v in ipairs(self.tbBoss) do
    if v.nBossId == nBossId then
      nIndex = k
      break
    end
  end
  if nIndex ~= 0 then
    table.remove(self.tbBoss, nIndex)
  end
  if self.nBloodType == AllEnum.BossBloodType.Single then
    self._mapNode.animBoss:Play("SingleBoss_out", 0, 0)
  end
end

function BossPanelCtrl:OnEvent_InputEnable(bEnable)
  self.bInputEnable = bEnable
  if bEnable then
    if self.bossHUDCloseAnimTweener ~= nil then
      self.bossHUDCloseAnimTweener:Pause()
    end
    if self.bossHUDOpenAnimTweener ~= nil then
      self.bossHUDOpenAnimTweener:Play()
    end
  else
    if self.bossHUDOpenAnimTweener ~= nil then
      self.bossHUDOpenAnimTweener:Pause()
    end
    if self.bossHUDCloseAnimTweener ~= nil then
      self.bossHUDCloseAnimTweener:Play()
    end
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.BossCanvasGroup, bEnable == true and 1 or 0)
  if bEnable and self.inputEnableCallback ~= nil then
    self.inputEnableCallback()
    self.inputEnableCallback = nil
  end
end

return BossPanelCtrl
