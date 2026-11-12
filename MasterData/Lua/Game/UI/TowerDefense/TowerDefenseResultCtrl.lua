local TowerDefenseResultCtrl = class("TowerDefenseResultCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
TowerDefenseResultCtrl._mapNodeConfig = {
  ButtonClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  imgBlurredBg = {},
  SuccessRoot = {},
  go_Perfect = {},
  txt_Perfect = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Perfect"
  },
  txt_level = {sComponentName = "TMP_Text"},
  db_target = {nCount = 3},
  Mask = {
    sComponentName = "CanvasGroup"
  },
  FailRoot = {},
  Mask_fail = {
    sComponentName = "CanvasGroup"
  },
  txt_level_fail = {sComponentName = "TMP_Text"},
  db_target_fail = {nCount = 3}
}
TowerDefenseResultCtrl._mapEventConfig = {}
TowerDefenseResultCtrl._mapRedDotConfig = {}

function TowerDefenseResultCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.bResult = param[1]
    self.sLevelName = param[2]
    self.tbTarget = param[3]
    self.callback = param[4]
    self.msgData = param[5]
    self.nStar = param[6] or 0
  end
  self._mapNode.SuccessRoot:SetActive(self.bResult)
  self._mapNode.FailRoot:SetActive(not self.bResult)
  self:SetContent()
  self.bProcessingClose = false
end

function TowerDefenseResultCtrl:SetContent()
  EventManager.Hit(EventId.TemporaryBlockInput, 1)
  WwiseManger:PostEvent("ui_loading_combatSFX_mute", nil, false)
  WwiseManger:PlaySound("ui_roguelike_victory")
  if self.bResult then
    for _, target in pairs(self._mapNode.db_target) do
      target:SetActive(false)
    end
    NovaAPI.SetTMPText(self._mapNode.txt_level, self.sLevelName)
    for i = 1, math.min(#self.tbTarget, #self._mapNode.db_target) do
      local target = self._mapNode.db_target[i]
      local star = target.transform:Find("star_get")
      local txt_target = target.transform:Find("txt_target")
      star.gameObject:SetActive(self.tbTarget[i].bResult)
      NovaAPI.SetTMPText(txt_target:GetComponent("TMP_Text"), self.tbTarget[i].sTargetDes)
      target:SetActive(true)
    end
    self._mapNode.go_Perfect:SetActive(self.nStar // 10 == 1)
    self:AddTimer(1, 0.9, function()
      local mapReward = PlayerData.Item:ProcessRewardChangeInfo(self.msgData)
      local tbItem = {}
      for _, v in ipairs(mapReward.tbReward) do
        local item = {
          Tid = v.id,
          Qty = v.count,
          rewardType = AllEnum.RewardType.First
        }
        table.insert(tbItem, item)
      end
      UTILS.OpenReceiveByDisplayItem(tbItem, self.msgData)
    end, true, true, true)
  else
    for _, target in pairs(self._mapNode.db_target_fail) do
      target:SetActive(false)
    end
    NovaAPI.SetTMPText(self._mapNode.txt_level_fail, self.sLevelName)
    for i = 1, math.min(#self.tbTarget, #self._mapNode.db_target_fail) do
      local target = self._mapNode.db_target_fail[i]
      local txt_target = target.transform:Find("txt_target")
      NovaAPI.SetTMPText(txt_target:GetComponent("TMP_Text"), self.tbTarget[i].sTargetDes)
      target:SetActive(true)
    end
  end
end

function TowerDefenseResultCtrl:OnBtnClick_Close()
  if self.bProcessingClose then
    return
  end
  self.bProcessingClose = true
  if self.callback ~= nil then
    self.callback()
  end
  if NovaAPI.GetCurrentModuleName() == "MainMenuModuleScene" then
    CS.AdventureModuleHelper.LevelStateChanged(true, 0, false)
    EventManager.Hit(EventId.CloesCurPanel)
    PlayerData.Base:OnBackToMainMenuModule()
  else
    EventManager.Hit(EventId.ClosePanel, PanelId.TowerDefensePanel)
    local mask
    if self.bResult then
      mask = self._mapNode.Mask
    else
      mask = self._mapNode.Mask_fail
    end
    NovaAPI.SetCanvasGroupAlpha(mask, 0)
    mask.gameObject:SetActive(true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
    local sequence = DOTween.Sequence()
    sequence:Append(mask:DOFade(1, 0.5):SetUpdate(true))
    sequence:AppendCallback(function()
      CS.AdventureModuleHelper.LevelStateChanged(true, 0, false)
    end)
    sequence:SetUpdate(true)
  end
end

return TowerDefenseResultCtrl
