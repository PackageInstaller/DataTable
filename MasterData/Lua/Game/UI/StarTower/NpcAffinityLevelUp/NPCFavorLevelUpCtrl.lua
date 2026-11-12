local BaseCtrl = require("GameCore.UI.BaseCtrl")
local NPCFavorLevelUpCtrl = class("NPCFavorLevelUpCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
NPCFavorLevelUpCtrl._mapNodeConfig = {
  trActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  },
  aniActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Animator"
  },
  got_fullscreen_blur_black = {
    sNodeName = "t_fullscreen_blur_black",
    sComponentName = "GameObject"
  },
  btnsnapshot = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtn_ClickClose"
  },
  rtBg = {
    sNodeName = "goBg",
    sComponentName = "RectTransform"
  },
  goLevelUp = {},
  TMPRewardTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "NPCFavor_LevelUp_RewardTitle"
  },
  affinityLevel = {
    sCtrlName = "Game.UI.StarTower.NpcAffinityLevelUp.TemplateAffinityLevelCtrl"
  },
  affinityLevelBefore = {
    sCtrlName = "Game.UI.StarTower.NpcAffinityLevelUp.TemplateAffinityLevelCtrl"
  },
  trContent = {
    sNodeName = "--Content--",
    sComponentName = "RectTransform"
  },
  btnSkipAnim = {
    sNodeName = "btnSkipAnim",
    sComponentName = "UIButton",
    callback = "OnBtn_SkipAnim"
  },
  aniSafeRoot = {
    sNodeName = "----SafeRoot----",
    sComponentName = "Animator"
  },
  goSafeRoot = {
    sNodeName = "----SafeRoot----",
    sComponentName = "GameObject"
  },
  rtItem = {
    sNodeName = "tc_item_",
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 3
  },
  btnItem = {
    sComponentName = "UIButton",
    nCount = 3,
    callback = "OnBtn_ClickItem"
  }
}
NPCFavorLevelUpCtrl._mapEventConfig = {}

function NPCFavorLevelUpCtrl:Awake()
end

function NPCFavorLevelUpCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  self.tbLevelUpList = tbParam[1]
  self.closeCallback = tbParam[2]
  self._mapNode.got_fullscreen_blur_black:SetActive(true)
  self:RefreshPanel()
end

function NPCFavorLevelUpCtrl:RefreshPanel(bNext)
  if bNext == nil then
  end
  if self.tbLevelUpList ~= nil and #self.tbLevelUpList > 0 then
    local data = table.remove(self.tbLevelUpList, 1)
    self.curNPCId = data.NPCId
    self.affinityLevel = data.affinityLevel
    self.affinityLevelBefore = data.affinityLevelBefore
    self.tbItem = data.Items
  end
  self._mapNode.aniSafeRoot.speed = 1
  self._mapNode.aniActor2D_PNG.speed = 1
  self._mapNode.goSafeRoot:SetActive(true)
  CS.WwiseAudioManager.Instance:PostEvent("ui_charInfo_favour_up")
  local nSkinId = ConfigTable.GetData("StarTowerNPC", self.curNPCId).NPCSkin
  if not bNext then
    self._mapNode.aniSafeRoot:Play("NpcFavourLevelUpPanel_in")
  else
    self._mapNode.aniSafeRoot:Play("NpcFavourLevelUpPanel_Next_in")
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    Actor2DManager.SetBoardNPC2D_PNG(self._mapNode.trActor2D_PNG, PanelId.NPCAffinityLevelUp, self.curNPCId, nSkinId)
    if not bNext then
      self._mapNode.aniActor2D_PNG:Play("Actor2D_PNG_NpcFavour")
    else
      self._mapNode.aniActor2D_PNG:Play("Actor2D_PNG_NpcFavour_in")
    end
  end
  
  cs_coroutine.start(wait)
  self._mapNode.affinityLevel:SetInfo(self.affinityLevel, self.curNPCId)
  self._mapNode.affinityLevelBefore:SetInfo(self.affinityLevelBefore, self.curNPCId)
  for i = 1, 3 do
    if self.tbItem[i] ~= nil then
      self._mapNode.btnItem[i].gameObject:SetActive(true)
      self._mapNode.rtItem[i]:SetItem(self.tbItem[i].Tid, nil, self.tbItem[i].Qty)
    else
      self._mapNode.btnItem[i].gameObject:SetActive(false)
    end
  end
  self._mapNode.btnSkipAnim.gameObject:SetActive(true)
end

function NPCFavorLevelUpCtrl:OnBtn_SkipAnim()
  self._mapNode.aniSafeRoot.speed = 1000
  self._mapNode.aniActor2D_PNG.speed = 1000
  self._mapNode.btnSkipAnim.gameObject:SetActive(false)
end

function NPCFavorLevelUpCtrl:OnBtn_ClickClose()
  if self.bClose == true then
    return
  end
  if self.tbLevelUpList ~= nil and #self.tbLevelUpList > 0 then
    self:RefreshPanel(true)
    return
  end
  self.bClose = true
  
  local function WaitAnim()
    if self.closeCallback ~= nil then
      self.closeCallback()
    end
    EventManager.Hit(EventId.ClosePanel, PanelId.NPCAffinityLevelUp)
  end
  
  self._mapNode.aniSafeRoot.speed = 1
  self._mapNode.aniActor2D_PNG.speed = 1
  self._mapNode.aniActor2D_PNG:Play("Actor2D_PNG_NpcFavour_Out")
  self._mapNode.aniSafeRoot:Play("NpcFavourLevelUpPanel_Next_out")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.35)
  self:AddTimer(1, 0.35, WaitAnim, true, true, true)
end

function NPCFavorLevelUpCtrl:OnBtn_ClickItem(btn, nIdx)
  if self.tbItem[nIdx] == nil then
    return
  end
  UTILS.ClickItemGridWithTips(self.tbItem[nIdx].Tid, btn.transform, false, true, false)
end

return NPCFavorLevelUpCtrl
