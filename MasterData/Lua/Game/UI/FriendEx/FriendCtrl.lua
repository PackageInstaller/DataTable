local FriendCtrl = class("FriendCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local Tog = {
  Info = 1,
  List = 2,
  Request = 3
}
local AnimName = {
  [1] = "FriendPanel_Info_",
  [2] = "FriendPanel_List_",
  [3] = "FriendPanel_Request_"
}
FriendCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  tog = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeSheet"
  },
  ctrlTog = {
    nCount = 3,
    sNodeName = "tog",
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  animRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_ClosePop"
  },
  trActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  },
  Info = {
    sNodeName = "---Info---",
    sCtrlName = "Game.UI.FriendEx.FriendInfoCtrl"
  },
  List = {
    sNodeName = "---List---",
    sCtrlName = "Game.UI.FriendEx.FriendListCtrl"
  },
  Request = {
    sNodeName = "---Request---",
    sCtrlName = "Game.UI.FriendEx.FriendRequestCtrl"
  },
  Rename = {
    sNodeName = "---Rename---",
    sCtrlName = "Game.UI.FriendEx.FriendRenameCtrl"
  },
  Head = {
    sNodeName = "---Head---",
    sCtrlName = "Game.UI.FriendEx.FriendHeadCtrl"
  },
  Search = {
    sNodeName = "---Search---",
    sCtrlName = "Game.UI.FriendEx.FriendSearchCtrl"
  },
  Title = {
    sNodeName = "---Title---",
    sCtrlName = "Game.UI.FriendEx.FriendTitleCtrl"
  },
  Signature = {
    sNodeName = "---Signature---",
    sCtrlName = "Game.UI.FriendEx.FriendSignatureCtrl"
  },
  Member = {
    sNodeName = "---Member---",
    sCtrlName = "Game.UI.FriendEx.FriendMemberCtrl"
  },
  Portrait = {
    sNodeName = "---Portrait---",
    sCtrlName = "Game.UI.FriendEx.FriendPortraitCtrl"
  },
  Recommend = {
    sNodeName = "---Recommend---",
    sCtrlName = "Game.UI.FriendEx.FriendRecommendCtrl"
  },
  HonorTitle = {
    sNodeName = "---HonorTitle---",
    sCtrlName = "Game.UI.FriendEx.FriendHonorTitleCtrl"
  },
  redDotTog = {nCount = 3}
}
FriendCtrl._mapEventConfig = {
  FriendChangeHead = "OnEvent_ChangeHead",
  FriendChangeName = "OnEvent_ChangeName",
  FriendChangeTitle = "OnEvent_ChangeTitle",
  FriendChangeSignature = "OnEvent_ChangeSignature",
  FriendChangePortrait = "OnEvent_ChangePortrait",
  FriendChangeMember = "OnEvent_ChangeMember",
  FriendClosePop = "OnBtnClick_ClosePop",
  FriendSearch = "OnEvent_Search",
  FriendRecommend = "OnEvent_Recommend",
  FriendRefreshActor2D = "OnEvent_RefreshActor2D",
  FriendChangeHonorTitle = "OnEvent_ChangeHonorTitle"
}

function FriendCtrl:RegisterRedDot()
  RedDotManager.RegisterNode(RedDotDefine.Friend_Info, nil, self._mapNode.redDotTog[1])
  RedDotManager.RegisterNode(RedDotDefine.Friend_Energy, nil, self._mapNode.redDotTog[2])
  RedDotManager.RegisterNode(RedDotDefine.Friend_Apply, nil, self._mapNode.redDotTog[3])
end

function FriendCtrl:SwitchTog()
  if self.nPrevTog ~= nil then
    local animPrev = AnimName[self.nPrevTog] .. "out"
    self._mapNode.animRoot:Play(animPrev)
    local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.animRoot, {animPrev})
    if self.timerAnim ~= nil then
      self.timerAnim:Cancel()
      self.timerAnim = nil
    end
    self.timerAnim = self:AddTimer(1, nAnimTime, function()
      self:OpenCtrl()
    end, true, true, true)
  else
    self:OpenCtrl()
  end
end

function FriendCtrl:OpenCtrl()
  self._mapNode.Info.gameObject:SetActive(self.nCurTog == Tog.Info)
  self._mapNode.List.gameObject:SetActive(self.nCurTog == Tog.List)
  self._mapNode.Request.gameObject:SetActive(self.nCurTog == Tog.Request)
  self._mapNode.trActor2D_PNG.gameObject:SetActive(self.nCurTog == Tog.Info)
  if self.nCurTog == Tog.Info then
    self._mapNode.Info:Refresh(self._panel.nId)
  elseif self.nCurTog == Tog.List then
    self._mapNode.List:Refresh()
  elseif self.nCurTog == Tog.Request then
    self._mapNode.Request:Refresh()
  end
  if self.nPrevTog ~= nil then
    local animCur = AnimName[self.nCurTog] .. "in"
    self._mapNode.animRoot:Play(animCur)
  end
end

function FriendCtrl:SetDefaultTog()
  if self.nCurTog == nil then
    self.nCurTog = self._panel.nDefaultTog or Tog.Info
  end
  for i = 1, 3 do
    self._mapNode.ctrlTog[i]:SetDefault(i == self.nCurTog)
  end
  self:SwitchTog()
end

function FriendCtrl:RefreshTogText()
  self._mapNode.ctrlTog[1]:SetText(ConfigTable.GetUIText("Friend_Tog_Info"))
  self._mapNode.ctrlTog[2]:SetText(ConfigTable.GetUIText("Friend_Tog_List"))
  self._mapNode.ctrlTog[3]:SetText(ConfigTable.GetUIText("Friend_Tog_Add"))
end

function FriendCtrl:FadeIn(bPlayFadeIn)
  EventManager.Hit(EventId.SetTransition)
end

function FriendCtrl:Awake()
  self.ctrlPop = nil
  self:RefreshTogText()
end

function FriendCtrl:OnEnable()
  self:SetDefaultTog()
  self:RegisterRedDot()
end

function FriendCtrl:OnDisable()
  if self.timerAnim ~= nil then
    self.timerAnim:Cancel()
    self.timerAnim = nil
  end
end

function FriendCtrl:OnDestroy()
end

function FriendCtrl:OnBtnClick_ChangeSheet(btn, nIndex)
  if nIndex == self.nCurTog then
    return
  end
  self._mapNode.ctrlTog[nIndex]:SetTrigger(true)
  self._mapNode.ctrlTog[self.nCurTog]:SetTrigger(false)
  self.nPrevTog = self.nCurTog
  self.nCurTog = nIndex
  self:SwitchTog()
end

function FriendCtrl:OnEvent_ChangeHead()
  self.ctrlPop = self._mapNode.Head
  self._mapNode.Head:Open()
  self._mapNode.blur:SetActive(true)
end

function FriendCtrl:OnEvent_ChangeName()
  self.ctrlPop = self._mapNode.Rename
  self._mapNode.Rename:Open()
  self._mapNode.blur:SetActive(true)
end

function FriendCtrl:OnEvent_ChangeTitle()
  self.ctrlPop = self._mapNode.Title
  self._mapNode.Title:Open()
  self._mapNode.blur:SetActive(true)
end

function FriendCtrl:OnEvent_ChangeSignature()
  self.ctrlPop = self._mapNode.Signature
  self._mapNode.Signature:Open()
  self._mapNode.blur:SetActive(true)
end

function FriendCtrl:OnEvent_ChangeMember()
  self.ctrlPop = self._mapNode.Member
  self._mapNode.Member:Open()
  self._mapNode.blur:SetActive(true)
end

function FriendCtrl:OnEvent_ChangePortrait()
  self.ctrlPop = self._mapNode.Portrait
  self._mapNode.Portrait:Open()
  self._mapNode.blur:SetActive(true)
end

function FriendCtrl:OnEvent_Search(mapData)
  self.ctrlPop = self._mapNode.Search
  self._mapNode.Search:Open(mapData)
  self._mapNode.blur:SetActive(true)
end

function FriendCtrl:OnEvent_Recommend(mapData)
  self.ctrlPop = self._mapNode.Recommend
  self._mapNode.Recommend:Open(mapData)
  self._mapNode.blur:SetActive(true)
end

function FriendCtrl:OnEvent_ChangeHonorTitle()
  self.ctrlPop = self._mapNode.HonorTitle
  self._mapNode.HonorTitle:Open()
  self._mapNode.blur:SetActive(true)
end

function FriendCtrl:OnBtnClick_ClosePop()
  if self.ctrlPop then
    self.ctrlPop:PlayOutAni()
    self.ctrlPop = nil
  end
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.2, function()
    self._mapNode.blur:SetActive(false)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function FriendCtrl:OnEvent_RefreshActor2D(nCharId, nSkinId)
  Actor2DManager.SetActor2D_PNG(self._mapNode.trActor2D_PNG, self:GetPanelId(), nCharId, nSkinId)
end

return FriendCtrl
