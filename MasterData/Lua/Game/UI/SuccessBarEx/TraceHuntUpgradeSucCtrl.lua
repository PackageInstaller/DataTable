local TraceHuntUpgradeSucCtrl = class("TraceHuntUpgradeSucCtrl", BaseCtrl)
TraceHuntUpgradeSucCtrl._mapNodeConfig = {
  txtLevelCount = {sComponentName = "TMP_Text"},
  txtLevelTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_Level_Title"
  },
  goRewardInfoList = {},
  goRewardInfo_ = {nCount = 5, sComponentName = "Transform"},
  ani1 = {sNodeName = "rtTitle", sComponentName = "Animator"},
  ani2 = {
    sNodeName = "goRewardInfoList",
    sComponentName = "Animator"
  },
  aniLine = {
    nCount = 5,
    sNodeName = "goRewardInfo_",
    sComponentName = "Animator"
  }
}
TraceHuntUpgradeSucCtrl._mapEventConfig = {}
local MaxEffectCount = 5

function TraceHuntUpgradeSucCtrl:Open()
  self:RefreshContent()
  local SuccessBar = self:BindCtrlByNode(self.gameObject, "Game.UI.SuccessBarEx.SuccessBarCtrl")
  SuccessBar:PlayAni(AllEnum.SuccessBar.Yellow, self.tbAni)
end

function TraceHuntUpgradeSucCtrl:RefreshContent()
  self.tbAni = {}
  local nLevel = self._panel.mapData.nLevel
  NovaAPI.SetTMPText(self._mapNode.txtLevelCount, nLevel)
  table.insert(self.tbAni, self._mapNode.ani1)
  local tbEffect = PlayerData.TraceHunt:GetLevelDisplayEffects(nLevel)
  local nCount = math.min(#tbEffect, MaxEffectCount)
  if nCount == 0 then
    self._mapNode.goRewardInfoList:SetActive(false)
  end
  for i = 1, MaxEffectCount do
    if i <= nCount then
      if i == 1 then
        table.insert(self.tbAni, {
          self._mapNode.ani2,
          self._mapNode.aniLine[1],
          bMulti = true
        })
      else
        table.insert(self.tbAni, self._mapNode.aniLine[i])
      end
      local txtRewardInfo = self._mapNode.goRewardInfo_[i]:Find("--Basic--/txtRewardInfo"):GetComponent("TMP_Text")
      local imgRewardIcon1 = self._mapNode.goRewardInfo_[i]:Find("--Basic--/goReward/imgRewardIcon1").gameObject
      local imgRewardIcon2 = self._mapNode.goRewardInfo_[i]:Find("--Basic--/goReward/imgRewardIcon2").gameObject
      NovaAPI.SetTMPText(txtRewardInfo, tbEffect[i].sText)
      imgRewardIcon1:SetActive(tbEffect[i].bIcon1)
      imgRewardIcon2:SetActive(not tbEffect[i].bIcon1)
    end
    self._mapNode.goRewardInfo_[i].gameObject:SetActive(i <= nCount)
  end
end

function TraceHuntUpgradeSucCtrl:Awake()
end

function TraceHuntUpgradeSucCtrl:OnEnable()
end

function TraceHuntUpgradeSucCtrl:OnDisable()
end

function TraceHuntUpgradeSucCtrl:OnDestroy()
end

return TraceHuntUpgradeSucCtrl
