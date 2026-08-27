local UIEventInvitation = class("UIEventInvitation", UIBaseWindow)
local base = UIBaseWindow
local UINEventInvitationMain = require("Game.ActivityInvitation.UI.UINEventInvitationMain")
local UINEventInvitationTask = require("Game.ActivityInvitation.UI.UINEventInvitationTask")
local UINEventInvitationTog = require("Game.ActivityInvitation.UI.UINEventInvitationTog")
local UINEventInvitationInput = require("Game.ActivityInvitation.UI.UINEventInvitationInput")
local UINShareCommonBtn = require("Game.Share.UI.UINShareCommonBtn")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local ActivityInvitationEnum = require("Game.ActivityInvitation.Data.ActivityInvitationEnum")
local EInvitationReddotType = ActivityInvitationEnum.EInvitationReddotType
local EInvitationPageType = {InvitePage = 1, TaskPage = 2}
local InvitationPageFunc = {
  [EInvitationPageType.InvitePage] = function(self)
    self._inviteNode:InitInvitationMain(self._data, BindCallback(self, self.__OpenInput))
    self._inviteNode:Show()
  end,
  [EInvitationPageType.TaskPage] = function(self)
    self._taskNode:InitInvitationTask(self._data)
    self._taskNode:Show()
  end
}

function UIEventInvitation:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Tips, self, self.OnClickRule)
  self._inviteNode = UINEventInvitationMain.New()
  self._inviteNode:Init(self.ui.obj_InviteNode)
  self._taskNode = UINEventInvitationTask.New()
  self._taskNode:Init(self.ui.obj_TaskNode)
  self._togItemPool = UIItemPool.New(UINEventInvitationTog, self.ui.tog_Page, false)
  self._shareNode = UINShareCommonBtn.New()
  self._shareNode:Init(self.ui.shareCommonButton)
  self._shareNode:Hide()
  self.ui.prtScNode:SetActive(false)
  self.ui.logicPreviewNode:SetActive(false)
  self._resloader = CS.ResLoader.Create()
  self.__OnClickTogCallback = BindCallback(self, self.ClickInvitationPage)
  self.__OnReceiveCodeRegisterCallback = BindCallback(self, self.__OnReceiveCodeRegister)
  MsgCenter:AddListener(eMsgEventId.InvitationCodeRegister, self.__OnReceiveCodeRegisterCallback)
end

function UIEventInvitation:InitInvitation(actId)
  local invitationCtrl = ControllerManager:GetController(ControllerTypeId.ActivityInvitation)
  self._data = invitationCtrl:GetInvitationDataByActId(actId)
  self.ui.tex_Title.text = self._data:GetActivityName()
  local tipId = self._data:GetInvitationMainCfg().activity_des
  self.ui.tex_Des.text = ConfigData:GetTipContent(tipId)
  self.ui.tex_Code.text = self._data:GetInvitationCode()
  self._mainColor = ColorUtil.FromHexUnit(self._data:GetInvitationMainCfg().invitation_color)
  self.ui.img_Logo.gameObject:SetActive(false)
  local titleImgPath = self._data:GetInvitationMainCfg().title_icon
  if not string.IsNullOrEmpty(titleImgPath) then
    self._resloader:LoadABAssetAsync(PathConsts:GetActivityInvatationPath(self._data:GetInvitationMainCfg().title_icon), function(texture)
      if IsNull(texture) or IsNull(self.transform) then
        return
      end
      self.ui.img_Logo.gameObject:SetActive(true)
      self.ui.img_Logo.texture = texture
    end)
  end
  self.ui.img_Hero.gameObject:SetActive(false)
  self._resloader:LoadABAssetAsync(PathConsts:GetActivityInvatationPath(self._data:GetInvitationMainCfg().invitation_hero), function(texture)
    if IsNull(texture) or IsNull(self.transform) then
      return
    end
    self.ui.img_Hero.gameObject:SetActive(true)
    self.ui.img_Hero.texture = texture
  end)
  self.ui.img_Background.gameObject:SetActive(false)
  self._resloader:LoadABAssetAsync(PathConsts:GetActivityInvatationPath(self._data:GetInvitationMainCfg().invitation_bg), function(texture)
    if IsNull(texture) or IsNull(self.transform) then
      return
    end
    self.ui.img_Background.gameObject:SetActive(true)
    self.ui.img_Background.texture = texture
  end)
  self.ui.img_Mask.color = self._mainColor
  self._shareNode:Hide()
  local shareCfg = ConfigData.share[self._data:GetInvitationMainCfg().share_id]
  if shareCfg ~= nil then
    if string.IsNullOrEmpty(shareCfg.picture_route) then
      self.isShowPrtScNode = false
      self._shareNode:Show()
      self._shareNode:InitShareCommonBtn(BindCallback(self, self.__OpenShare), self._data:GetInvitationMainCfg().share_id)
    else
      self._resloader:LoadABAssetAsync(PathConsts:GetShareRoutePic(shareCfg.picture_route), function(texture)
        if IsNull(texture) or IsNull(self.transform) then
          return
        end
        self.isShowPrtScNode = true
        self.ui.img_PrtSc.texture = texture
        self._shareNode:Show()
        self._shareNode:InitShareCommonBtn(BindCallback(self, self.__OpenShare), self._data:GetInvitationMainCfg().share_id)
      end)
    end
  end
  if self._timerId == nil then
    self._timerId = TimerManager:StartTimer(1, self.__OnTimer, self)
    self:__OnTimer()
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local isFirst = not saveUserData:GetInvitationLooked(actId)
  if isFirst then
    saveUserData:SetInvitationLooked(actId)
    self._data:RefreshInvitationRed()
  end
  if not self._data:IsInvitationCommonUser() and not self._data:IsInvitationReturnPicked() and isFirst then
    self:__OpenInput()
  end
  self._togItemPool:HideAll()
  self._togItemDic = {}
  local inviteNodeTog = self._togItemPool:GetOne()
  local togName = LanguageUtil.GetLocaleText(self._data:GetInvitationMainCfg().invitation_name)
  inviteNodeTog:InitInvitationTogItem(EInvitationPageType.InvitePage, self.__OnClickTogCallback, togName)
  local togRed = self._data:GetInvitationReddot(EInvitationReddotType.InviteReward)
  inviteNodeTog:SetInvitationTogRed(togRed)
  self._togItemDic[EInvitationPageType.InvitePage] = inviteNodeTog
  if self._data:GetInvitaionTaskCfg() ~= nil then
    local taskNodeTog = self._togItemPool:GetOne()
    local togName = LanguageUtil.GetLocaleText(self._data:GetInvitaionTaskCfg()[self._data:GetInvitationUserType()].task_name)
    taskNodeTog:InitInvitationTogItem(EInvitationPageType.TaskPage, self.__OnClickTogCallback, togName)
    local togRed = self._data:GetInvitationReddot(EInvitationReddotType.TaskReward)
    taskNodeTog:SetInvitationTogRed(togRed)
    self._togItemDic[EInvitationPageType.TaskPage] = taskNodeTog
  end
  self:ClickInvitationPage(EInvitationPageType.InvitePage)
end

function UIEventInvitation:__OpenInput()
  if not self._data:IsInvitationCommonUser() and not self._data:IsInvitationReturnPicked() then
    if self._inputNode == nil then
      self.ui.logicPreviewNode:SetActive(true)
      self._inputNode = UINEventInvitationInput.New()
      self._inputNode:Init(self.ui.logicPreviewNode)
      self._inputNode:InitInvitationInput(self._data)
    else
      self._inputNode:Show()
    end
  end
end

function UIEventInvitation:__OpenShare()
  UIManager:ShowWindowAsync(UIWindowTypeID.Share, function(win)
    if win == nil then
      return
    end
    win:SetShareBeforeCaptureFunc(function()
      UIUtil.HideTopStatus()
      self.ui.prtScNode:SetActive(self.isShowPrtScNode)
      local frameUI = UIManager:GetWindow(UIWindowTypeID.ActivityFrameMain)
      if frameUI ~= nil and frameUI.active then
        frameUI:SetTagPageNodeState(false)
      end
    end):SetShareAfterCaptureFunc(function()
      self.ui.prtScNode:SetActive(false)
      UIUtil.ReShowTopStatus()
      local frameUI = UIManager:GetWindow(UIWindowTypeID.ActivityFrameMain)
      if frameUI ~= nil and frameUI.active then
        frameUI:SetTagPageNodeState(true)
      end
    end):InitShare(self._data:GetInvitationMainCfg().share_id)
  end)
end

function UIEventInvitation:__OnTimer()
  if (self._nextTime or 0) < PlayerDataCenter.timestamp then
    local title, timeStr, expireTime = ActivityFrameUtil.GetShowEndTimeStr(self._data)
    self.ui.tex_TimeTitle.text = title
    self.ui.tex_EndTime.text = timeStr
    self._nextTime = expireTime
  end
  local countdownStr, diff = ActivityFrameUtil.GetCountdownTimeStr(self._nextTime)
  self.ui.tex_LastTime.text = countdownStr
  if diff < 0 and self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
end

function UIEventInvitation:OnClickRule()
  local cfg = self._data:GetInvitationMainCfg()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfo(ConfigData:GetTipContent(cfg.rule_des), ConfigData:GetTipContent(cfg.rule_title))
  end)
end

function UIEventInvitation:ClickInvitationPage(newPageType)
  if self._currentPageType == newPageType then
    return
  end
  self._inviteNode:Hide()
  self._taskNode:Hide()
  if self._togItemDic[newPageType] ~= nil then
    self._togItemDic[newPageType]:SetInvitationTogState(true)
  end
  if InvitationPageFunc[newPageType] then
    self._currentPageType = newPageType
    InvitationPageFunc[newPageType](self)
  end
end

function UIEventInvitation:__OnReceiveCodeRegister()
  self._inviteNode:RefreshInvitationMain()
  self._inputNode:Hide()
end

function UIEventInvitation:OnDelete()
  self._inviteNode:Delete()
  self._taskNode:Delete()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  for _, togItem in pairs(self._togItemDic) do
    togItem:Delete()
  end
  MsgCenter:RemoveListener(eMsgEventId.InvitationCodeRegister, self.__OnReceiveCodeRegisterCallback)
  base.OnDelete(self)
end

return UIEventInvitation
