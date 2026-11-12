local BaseCtrl = require("GameCore.UI.BaseCtrl")
local CharacterStoryCtrl = class("CharacterStoryCtrl", BaseCtrl)
CharacterStoryCtrl._mapNodeConfig = {
  goCharacterStory = {
    sNodeName = "CharacterStory",
    sComponentName = "GameObject"
  },
  got_fullscreen_story = {
    sNodeName = "t_fullscreen_story",
    sComponentName = "GameObject"
  },
  btnsnapshot_story = {
    sNodeName = "snapshot_story",
    sComponentName = "Button",
    callback = "OnBtn_ClickCloseStory"
  },
  txtStory = {sNodeName = "txtStory", sComponentName = "TMP_Text"},
  btn_CloseStory = {
    sNodeName = "btn_CloseStory",
    sComponentName = "UIButton",
    callback = "OnBtn_ClickCloseStory"
  },
  txtBtnCloseStory = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Confirm"
  },
  txtStoryName = {
    sNodeName = "txtStoryName",
    sComponentName = "TMP_Text"
  },
  btnReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward"
  },
  animWindow = {sNodeName = "goWindow", sComponentName = "Animator"}
}
CharacterStoryCtrl._mapEventConfig = {}

function CharacterStoryCtrl:Awake()
end

function CharacterStoryCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  self.nCharId = tbParam[1]
  self.nArchiveId = tbParam[2]
  local data = ConfigTable.GetData("CharacterArchiveContent", self.nArchiveId)
  if data ~= nil then
    local bUpdate = PlayerData.Char:CheckCharArchiveContentUpdate(self.nCharId, self.nArchiveId)
    local sContent = bUpdate and data.UpdateContent1 or data.Content
    NovaAPI.SetTMPText(self._mapNode.txtStory, ProcAvgTextContent(sContent, GetLanguageIndex(Settings.sCurrentTxtLanguage)))
    NovaAPI.SetTMPText(self._mapNode.txtStoryName, data.Title)
    local bReceived = PlayerData.Char:CheckCharArchiveReward(self.nCharId, self.nArchiveId)
    self._mapNode.btnReward.gameObject:SetActive(not bReceived)
  end
  self._mapNode.got_fullscreen_story:SetActive(true)
  self._mapNode.goCharacterStory:SetActive(true)
  self._mapNode.animWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function CharacterStoryCtrl:OnPanelClose()
  self._mapNode.goCharacterStory:SetActive(false)
  self._mapNode.got_fullscreen_story:SetActive(false)
  EventManager.Hit(EventId.ClosePanel, PanelId.CharacterStory)
end

function CharacterStoryCtrl:OnBtn_ClickCloseStory()
  self._mapNode.animWindow:Play("t_window_04_t_out")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, "OnPanelClose", true, true, true)
end

function CharacterStoryCtrl:OnBtnClick_Reward()
  local function callbackFunc()
    self._mapNode.btnReward.gameObject:SetActive(false)
  end
  
  PlayerData.Char:SendCharArchiveRewardReceive(self.nCharId, self.nArchiveId, callbackFunc)
end

return CharacterStoryCtrl
