local TrialDepotCtrl = class("TrialDepotCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
TrialDepotCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  trActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  },
  animActor2D = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Animator"
  },
  imgActorBg = {},
  animActorBg = {sNodeName = "imgActorBg", sComponentName = "Animator"},
  goBlur = {
    sNodeName = "t_fullscreen_blur_01"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_01",
    sComponentName = "Animator"
  },
  goRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  aniRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  imgNoteTogBg = {},
  imgEmpty = {},
  CharInfo = {
    sNodeName = "---CharInfo---",
    sCtrlName = "Game.UI.TrialBattle.DepotCharInfoCtrl"
  },
  Potential = {
    sNodeName = "---Potential---",
    sCtrlName = "Game.UI.TrialBattle.DepotPotentialCtrl"
  },
  DiscSkill = {
    sNodeName = "---DiscSkill---",
    sCtrlName = "Game.UI.TrialBattle.DepotDiscSkillCtrl"
  },
  tog = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeTab"
  },
  ctrlTog = {
    nCount = 3,
    sNodeName = "tog",
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  txt_EmptyTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "FRDepot_EmptyItem"
  },
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Close"
  }
}
TrialDepotCtrl._mapEventConfig = {
  RefreshActor2D_Depot = "OnEvent_RefreshActor2D",
  Guide_SelectDepotTog = "OnEvent_SelectDepotTog",
  [EventId.UIBackConfirm] = "OnEvent_Close"
}
TrialDepotCtrl._mapRedDotConfig = {}

function TrialDepotCtrl:InitAllPotential()
  self.mapAllPotential = {}
  for k, nCharId in ipairs(self._panel.tbTeam) do
    local tbData = {
      nCharId = nCharId,
      tbPotential = {}
    }
    local charPotentialCfg = PlayerData.Char:GetCharPotentialList(nCharId)
    if charPotentialCfg ~= nil then
      if k == 1 then
        tbData.tbPotential = charPotentialCfg.master
      else
        tbData.tbPotential = charPotentialCfg.assist
      end
    end
    table.insert(self.mapAllPotential, tbData)
  end
end

function TrialDepotCtrl:RefreshTogText()
  self._mapNode.ctrlTog[1]:SetText(ConfigTable.GetUIText("StarTower_Depot_Potential"))
  self._mapNode.ctrlTog[2]:SetText(ConfigTable.GetUIText("StarTower_Depot_Note"))
  self._mapNode.ctrlTog[3]:SetText(ConfigTable.GetUIText("StarTower_Depot_Char"))
end

function TrialDepotCtrl:SetDefaultTog()
  if nil == self.nCurTog then
    self.nCurTog = AllEnum.StarTowerDepotTog.Potential
  end
  for i = 1, 3 do
    self._mapNode.ctrlTog[i]:SetDefault(i == self.nCurTog)
  end
  self:SwitchTog()
end

function TrialDepotCtrl:SwitchTog()
  self:RefreshList()
end

function TrialDepotCtrl:RefreshList()
  self._mapNode.CharInfo.gameObject:SetActive(self.nCurTog == AllEnum.StarTowerDepotTog.CharInfo)
  self._mapNode.Potential.gameObject:SetActive(self.nCurTog == AllEnum.StarTowerDepotTog.Potential)
  self._mapNode.DiscSkill.gameObject:SetActive(self.nCurTog == AllEnum.StarTowerDepotTog.DiscSkill)
  self._mapNode.trActor2D_PNG.gameObject:SetActive(self.nCurTog == AllEnum.StarTowerDepotTog.CharInfo)
  self._mapNode.imgActorBg.gameObject:SetActive(self.nCurTog == AllEnum.StarTowerDepotTog.CharInfo)
  self._mapNode.imgNoteTogBg.gameObject:SetActive(self.nCurTog == AllEnum.StarTowerDepotTog.DiscSkill)
  if self.nCurTog == AllEnum.StarTowerDepotTog.CharInfo then
    self._mapNode.CharInfo:RefreshCharInfo(self._panel.tbTeam, self._panel.mapCharData)
  elseif self.nCurTog == AllEnum.StarTowerDepotTog.Potential then
    self._mapNode.Potential:RefreshPotential(self.mapAllPotential, self.mapPotential)
  elseif self.nCurTog == AllEnum.StarTowerDepotTog.DiscSkill then
    EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_OpenTrialDepot")
    self._mapNode.DiscSkill:RefreshDiscSkill(self.mapNote)
  end
end

function TrialDepotCtrl:Awake()
  self:RefreshTogText()
  self:InitAllPotential()
  self.nCurTog = nil
  self._mapNode.goRoot:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
end

function TrialDepotCtrl:FadeOut()
end

function TrialDepotCtrl:OnEnable()
  self:OnEvent_OpenTrialDepot(self._panel.mapPotential, self._panel.mapNote)
end

function TrialDepotCtrl:OnDisable()
end

function TrialDepotCtrl:OnDestroy()
end

function TrialDepotCtrl:OnRelease()
end

function TrialDepotCtrl:OnBtnClick_ChangeTab(btn, nIndex)
  if nIndex == self.nCurTog then
    return
  end
  self._mapNode.ctrlTog[nIndex]:SetTrigger(true)
  self._mapNode.ctrlTog[self.nCurTog]:SetTrigger(false)
  self.nCurTog = nIndex
  self:SwitchTog()
end

function TrialDepotCtrl:OnBtnClick_Close()
  self:OnEvent_Close(self._panel._nPanelId)
end

function TrialDepotCtrl:OnEvent_Close(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if self._panel.bBattle then
    PanelManager.InputEnable()
    EventManager.Hit("TrialSetButtonEnable", true, true)
    CS.GameCameraStackManager.Instance:OpenMainCamera()
    EventManager.Hit(EventId.BattleDashboardVisible, true)
    GamepadUIManager.DisableGamepadUI("TrialDepotCtrl")
  end
  self.nCurTog = nil
  self._mapNode.goRoot:SetActive(false)
  self._mapNode.goBlur:SetActive(false)
  self._mapNode.trActor2D_PNG.gameObject:SetActive(false)
  self._mapNode.imgActorBg.gameObject:SetActive(false)
  self._mapNode.imgNoteTogBg.gameObject:SetActive(false)
  self._mapNode.Potential:Clear()
  self._mapNode.DiscSkill:Clear()
  self._mapNode.CharInfo:Clear()
  EventManager.Hit(EventId.ClosePanel, PanelId.TrialDepot)
end

function TrialDepotCtrl:OnEvent_OpenTrialDepot(mapPotential, mapNote)
  if self._panel.bBattle then
    PanelManager.InputDisable()
    EventManager.Hit("TrialSetButtonEnable", false, false)
    GamepadUIManager.EnableGamepadUI("TrialDepotCtrl", self.tbGamepadUINode, nil, true)
  end
  self.mapPotential = mapPotential
  self.mapNote = mapNote
  self._mapNode.goBlur:SetActive(true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.33)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if self._panel.bBattle then
      CS.GameCameraStackManager.Instance:CloseMainCamera(0.1)
    end
    self:SetDefaultTog()
    self._mapNode.goRoot:SetActive(true)
    self._mapNode.aniRoot:Play("depot_t_in")
    if self.nCurTog == AllEnum.StarTowerDepotTog.CharInfo then
      self._mapNode.animActor2D:Play("Actor2D_PNG_down_in", 0, 0)
      self._mapNode.animActorBg:Play("imgActorBg_in", 0, 0)
    end
  end
  
  cs_coroutine.start(wait)
end

function TrialDepotCtrl:OnEvent_RefreshActor2D(nCharId)
  Actor2DManager.SetActor2D_PNG(self._mapNode.trActor2D_PNG, PanelId.MainView, nCharId)
end

function TrialDepotCtrl:OnEvent_SelectDepotTog(nTog)
  if nTog == self.nCurTog then
    return
  end
  self._mapNode.ctrlTog[nTog]:SetTrigger(true)
  self._mapNode.ctrlTog[self.nCurTog]:SetTrigger(false)
  self.nCurTog = nTog
  self:SwitchTog()
end

return TrialDepotCtrl
