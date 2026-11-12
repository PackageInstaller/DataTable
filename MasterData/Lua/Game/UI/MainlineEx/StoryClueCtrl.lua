local BaseCtrl = require("GameCore.UI.BaseCtrl")
local StoryClueCtrl = class("StoryClueCtrl", BaseCtrl)
local AvgData = PlayerData.Avg
StoryClueCtrl._mapNodeConfig = {
  got_fullscreen = {
    sNodeName = "t_fullscreen",
    sComponentName = "GameObject"
  },
  btnsnapshot = {
    sNodeName = "btnsnapshot",
    sComponentName = "Button",
    callback = "OnBtn_ClickClose"
  },
  btnClose = {
    sNodeName = "btnClose",
    sComponentName = "UIButton",
    callback = "OnBtn_ClickClose"
  },
  anit_window = {sNodeName = "t_window", sComponentName = "Animator"},
  loopsvClue = {
    sNodeName = "svClue",
    sComponentName = "LoopScrollView"
  },
  txtWindowTitle = {sComponentName = "TMP_Text", sLanguageId = "Story_Clue"},
  txtUnkownClueDecs = {
    sComponentName = "TMP_Text",
    sLanguageId = "Story_Unkown_Clue"
  }
}
StoryClueCtrl._mapEventConfig = {}

function StoryClueCtrl:Awake()
end

function StoryClueCtrl:FadeIn()
end

function StoryClueCtrl:FadeOut()
end

function StoryClueCtrl:OnEnable()
end

function StoryClueCtrl:RefreshPanel()
  self.gameObject:SetActive(true)
  self._mapNode.anit_window:Play("t_window_04_t_in")
  self._mapNode.got_fullscreen:SetActive(true)
  self.tbEvidence = {}
  for k, v in pairs(AvgData.CFG_StoryEvidence) do
    if v.visible == 1 then
      table.insert(self.tbEvidence, v)
    end
  end
  table.sort(self.tbEvidence, function(a, b)
    return a < b
  end)
  local count = #self.tbEvidence
  self._mapNode.loopsvClue.gameObject:SetActive(true)
  self._mapNode.loopsvClue:SetAnim(0.07)
  self._mapNode.loopsvClue:Init(count, self, self.OnRefreshClueList)
end

function StoryClueCtrl:OnRefreshClueList(grid)
  local index = tonumber(grid.name) + 1
  local evidenceId = self.tbEvidence[index]
  local mapData = ConfigTable.GetData("StoryEvidence", evidenceId)
  local bUnlock = AvgData:IsEvidenceUnlock(mapData.EvId)
  local trans = grid.transform:Find("btnGrid/AnimRoot")
  local goUnlock = trans:Find("goUnlockClue")
  local goLock = trans:Find("goLockClue")
  local imgBg = goUnlock:Find("imgChoiceBg"):GetComponent("Image")
  local imgItem = goUnlock:Find("imgClueItem"):GetComponent("Image")
  local txtClueTitle = goUnlock:Find("txtClueTitle"):GetComponent("TMP_Text")
  local txtClueDesc = goUnlock:Find("txtClueDesc"):GetComponent("TMP_Text")
  local reddot = trans:Find("reddot")
  goLock.gameObject:SetActive(not bUnlock)
  goUnlock.gameObject:SetActive(bUnlock)
  reddot.gameObject:SetActive(false)
  if bUnlock then
    if mapData.Icon ~= "" then
      self:SetPngSprite(imgItem, mapData.Icon)
    end
    NovaAPI.SetTMPText(txtClueTitle, mapData.Name)
    NovaAPI.SetTMPText(txtClueDesc, mapData.Desc)
    local bReddot = RedDotManager.GetValid(RedDotDefine.MianStoryClue_Use, evidenceId)
    reddot.gameObject:SetActive(bReddot)
  end
end

function StoryClueCtrl:OnBtn_ClickClose()
  self._mapNode.anit_window:Play("t_window_04_t_out")
  self._mapNode.got_fullscreen:SetActive(false)
  self:AddTimer(1, 0.3, "OnCloseAnimFinish", true, true, true)
end

function StoryClueCtrl:OnCloseAnimFinish()
  self.gameObject:SetActive(false)
end

return StoryClueCtrl
