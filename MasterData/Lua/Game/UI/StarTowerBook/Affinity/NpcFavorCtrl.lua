local BaseCtrl = require("GameCore.UI.BaseCtrl")
local NpcFavorCtrl = class("NpcFavorCtrl", BaseCtrl)
NpcFavorCtrl._mapNodeConfig = {
  txtFavourLevel = {
    sNodeName = "txtFavourLevel",
    sComponentName = "TMP_Text"
  },
  transFavourBarCenter = {
    sNodeName = "FavourBarCenter",
    sComponentName = "Transform"
  },
  txtFavourNum = {sNodeName = "txtFavour", sComponentName = "TMP_Text"},
  txtFavourBubble = {
    sNodeName = "txtFavourBubble",
    sComponentName = "TMP_Text"
  },
  imgHeart = {sNodeName = "imgHeart", sComponentName = "Image"},
  aniFavour = {
    sNodeName = "aniFavourRoot",
    sComponentName = "Animator"
  }
}
NpcFavorCtrl._mapEventConfig = {
  [EventId.AffinityChange] = "OnEvent_AffinityChange"
}

function NpcFavorCtrl:Awake()
end

function NpcFavorCtrl:OnEnable()
end

function NpcFavorCtrl:Refresh(nNpcId)
  self.curCharId = nNpcId
  local affinityData = PlayerData.StarTower:GetNpcAffinityData(nNpcId)
  self.curFavourExp = affinityData.Exp
  local mapNpc = ConfigTable.GetData("StarTowerNPC", nNpcId)
  local nGroupId = mapNpc.AffinityGroupId
  local nId = nGroupId * 100 + affinityData.Level
  local mapAffinityCfgData = ConfigTable.GetData("NPCAffinityGroup", nId)
  local data = mapAffinityCfgData
  local needExp = affinityData.nNeed
  self.curFavourLevel = data.AffinityLevelStage
  NovaAPI.SetTMPText(self._mapNode.txtFavourLevel, ConfigTable.GetUIText("Advance_Level_Name") .. affinityData.Level)
  NovaAPI.SetTMPText(self._mapNode.txtFavourNum, self.curFavourExp .. "/" .. needExp)
  self._mapNode.txtFavourNum.gameObject:SetActive(needExp ~= 0)
  NovaAPI.SetTMPText(self._mapNode.txtFavourBubble, data.RelationshipName)
  if data.AffinityLevelIcon ~= "" then
  end
  self._mapNode.aniFavour.gameObject:SetActive(false)
  self._mapNode.aniFavour.gameObject:SetActive(true)
  self._mapNode.aniFavour:SetInteger("affinity_lv", self.curFavourLevel)
  local percent = 0
  if needExp ~= 0 then
    percent = self.curFavourExp / needExp
  else
    percent = 1
  end
  self:RefreshProgressBar(percent, 0)
end

function NpcFavorCtrl:RefreshProgressBar(nPercent, nDuration)
  self._mapNode.transFavourBarCenter.localEulerAngles = Vector3(0, 0, 0)
  self._mapNode.transFavourBarCenter:DORotate(Vector3(0, 0, (1 - nPercent) * 102), nDuration, RotateMode.LocalAxisAdd)
end

function NpcFavorCtrl:ResetData()
  self._mapNode.transFavourBarCenter.localEulerAngles = Vector3(0, 0, 0)
end

return NpcFavorCtrl
