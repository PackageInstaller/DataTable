local LoginPVDataUtils = require("GameScript.Data.LoginPVDataUtils")
local FAKE_PV_STORY_ID = -99999
local LoginPVModifyItem, Super = NewViewComponent("LoginPVModifyItem", CGItem)

function LoginPVModifyItem:ctor(uiNode, view, cfg)
  Super.ctor(self, uiNode, view, 0, UI_Collection_Item_PV_SubItemResource(uiNode))
  self.cfg = cfg
end

function LoginPVModifyItem:OnBuildComponent()
  self:InitView()
end

function LoginPVModifyItem:InitParams(cfg)
  self.cfg = cfg
end

function LoginPVModifyItem:UpdateShow(cfg)
  self.cfg = cfg
  self:InitView()
end

function LoginPVModifyItem:InitLockState()
end

function LoginPVModifyItem:InitItemLockState()
end

function LoginPVModifyItem:UpdateRedComp()
end

function LoginPVModifyItem:RegisterNotifications()
end

function LoginPVModifyItem:InitView()
  if self.ui.Image_CurrentCG then
    local manualInfo = LoginPVDataUtils.GetManualLoginPVInfo()
    local currentVideo = manualInfo and manualInfo.video
    local isCurrentPV = self.cfg and self.cfg[2] == currentVideo
    self.ui.Image_CurrentCG:SetActive(true == isCurrentPV)
  end
  if self.ui.Image_PV and self.cfg and self.cfg[5] then
    self:SetImage(self.ui.Image_PV, self.cfg[5])
  end
  local name = LT.Text(self.cfg and self.cfg[4] or "")
  self:SetText(self.ui.Text_Name, name)
end

function LoginPVModifyItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self.OnClickItem))
end

function LoginPVModifyItem:OnClickItem()
  if not self.cfg then
    return
  end
  local videoUrl = self.cfg[2]
  local audioEventId = self.cfg[3]
  if not videoUrl then
    return
  end
  local fakeDialogData = {
    BaseSortID = 1,
    Sequence = string.format("PlayVideo(%s,,%s)", videoUrl, cd.NumberTrue),
    Audio = audioEventId and {audioEventId} or nil,
    AudioTalk = {
      "Stop_Avg_Vocal"
    },
    AudioManageEvent = {
      "Pause_Ingame_Fight_SFXandVoice"
    },
    BanSpeedUp = 1
  }
  AvgStoryManager.Instance:RegisterTempDialog(FAKE_PV_STORY_ID, {
    ID = FAKE_PV_STORY_ID,
    CnID = "预览登录PV",
    BaseSortID = 1,
    data_list = {
      [1] = fakeDialogData
    }
  })
  local cfg = self.cfg
  AudioManager.Instance:PostSoundEvent("Stop_VO_Chr_All")
  AvgStoryManager.Instance:StartStoryById(FAKE_PV_STORY_ID)
  UIManager.Instance:Reopen(Urls.LoginPVDisplayView, cfg)
end

return LoginPVModifyItem
