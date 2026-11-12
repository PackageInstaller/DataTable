local VampireSurvivorRoomInfo = class("VampireSurvivorRoomInfo", BaseCtrl)
local nTotalLength = 815
local nY = 3.5
local nYMask = 27
local nLevelBarLength = 215
local nLevelBarHeight = 24
VampireSurvivorRoomInfo._mapNodeConfig = {
  ItemTips = {
    sCtrlName = "Game.UI.VampireSurvivor.VampireRoomInfo_ItemTipsCtrl"
  },
  rtScore = {
    sCtrlName = "Game.UI.VampireSurvivor.VampireRoomInfo_ScoreCtrl"
  },
  TeamLevel = {},
  rtFillMaskLevelBar = {
    sComponentName = "RectTransform"
  },
  imgLevelBar = {sComponentName = "Image"},
  imgLevelBarAdd = {sComponentName = "Image"},
  txtLevelCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Reward_Level"
  },
  txtLevelHint = {
    sComponentName = "TMP_Text",
    sLanguageId = "Vampire_RoomInfo_LevelHint"
  },
  txtTeamLevel = {sComponentName = "TMP_Text"},
  canvasGroup = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  },
  rtProgress = {},
  imgElite = {},
  imgBoss = {},
  rtMask = {
    sComponentName = "RectTransform"
  },
  rtMarkContent = {sComponentName = "Transform"}
}
VampireSurvivorRoomInfo._mapEventConfig = {
  VampireSurvivor_Time = "OnEvent_SetTime",
  Vampire_Level_Times = "OnEvent_SetLevelProgress",
  Vampire_Boss_Spawn = "OnEvent_Boss_Spawn",
  Vampire_Exp_Change = "OnEvent_ExpChange",
  InputEnable = "OnEvent_InputEnable"
}
VampireSurvivorRoomInfo._mapRedDotConfig = {}

function VampireSurvivorRoomInfo:Awake()
end

function VampireSurvivorRoomInfo:FadeIn()
end

function VampireSurvivorRoomInfo:FadeOut()
end

function VampireSurvivorRoomInfo:OnEnable()
  self.nCurTime = 0
  self.nTotalTime = 0
  self.tbTypeTime = {}
  self.mapMark = {}
  self.mapWarnTime = {}
  self.bStop = false
  self._mapNode.rtProgress:SetActive(false)
  self._mapNode.rtFillMaskLevelBar.sizeDelta = Vector2(0, nLevelBarHeight)
  NovaAPI.SetTMPText(self._mapNode.txtTeamLevel, 1)
end

function VampireSurvivorRoomInfo:OnDisable()
  self.mapMark = {}
  self.mapWarnTime = {}
  delChildren(self._mapNode.rtMarkContent)
end

function VampireSurvivorRoomInfo:OnDestroy()
end

function VampireSurvivorRoomInfo:OnRelease()
end

function VampireSurvivorRoomInfo:OnEvent_SetTime(nTime)
  if self.bStop then
    return
  end
  local nPersent = nTime / self.nTotalTime
  if 1 < nPersent then
    nPersent = 1
  end
  local nLength = nPersent * nTotalLength
  self._mapNode.rtMask.sizeDelta = Vector2(nLength, nYMask)
  if self.mapWarnTime[nTime] ~= nil then
    local ani = self.mapWarnTime[nTime]:GetComponent("Animator")
    ani:Play("Vampire_imgElite_idle")
  end
  if self.mapMark[nTime] ~= nil then
    local ani = self.mapMark[nTime]:GetComponent("Animator")
    ani:Play("Vampire_imgElite_in")
  end
end

function VampireSurvivorRoomInfo:OnEvent_SetLevelProgress(nTotalTime, tbTypeTime)
  self.bStop = false
  self._mapNode.rtProgress:SetActive(true)
  local nCount = tbTypeTime.Count
  self.nTotalTime = tbTypeTime[nCount - 1]
  self._mapNode.rtMask.sizeDelta = Vector2(0, nYMask)
  delChildren(self._mapNode.rtMarkContent)
  self.mapMark = {}
  self.mapWarnTime = {}
  for i = 0, nCount - 1 do
    local nPersent = tbTypeTime[i] / self.nTotalTime
    local nLength = nPersent * nTotalLength + 3
    local goMark
    if i == nCount - 1 then
      goMark = instantiate(self._mapNode.imgBoss, self._mapNode.rtMarkContent)
    else
      goMark = instantiate(self._mapNode.imgElite, self._mapNode.rtMarkContent)
    end
    goMark:SetActive(true)
    goMark:GetComponent("Image").enabled = true
    local ani = goMark:GetComponent("Animator")
    ani.enabled = true
    local rtGoMark = goMark:GetComponent("RectTransform")
    rtGoMark.anchoredPosition = Vector2(nLength, nY)
    self.mapMark[tbTypeTime[i]] = goMark
    self.mapWarnTime[tbTypeTime[i] - 5] = goMark
  end
end

function VampireSurvivorRoomInfo:OnEvent_Boss_Spawn()
  self._mapNode.rtProgress:SetActive(false)
  self.bStop = true
end

function VampireSurvivorRoomInfo:OnEvent_ExpChange(nExp, nAllExp, nLevel, bMaxLevel)
  if bMaxLevel then
    self._mapNode.rtFillMaskLevelBar.sizeDelta = Vector2(nLevelBarLength, nLevelBarHeight)
  else
    self._mapNode.rtFillMaskLevelBar.sizeDelta = Vector2(nLevelBarLength * (nExp / nAllExp), nLevelBarHeight)
  end
  NovaAPI.SetTMPText(self._mapNode.txtTeamLevel, nLevel)
  NovaAPI.SetImageColor(self._mapNode.imgLevelBarAdd, Color(1, 1, 1, 0))
end

function VampireSurvivorRoomInfo:OnEvent_InputEnable(bEnable)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, bEnable and 1 or 0)
end

return VampireSurvivorRoomInfo
