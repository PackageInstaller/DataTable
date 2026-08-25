local SocialRelationPage = SocialDefine.SocialRelationPage
local AddClipToPlay = AnimatorUtils.AddClipToPlay
local UIAnimationController = CS.Z1Client.UIAnimationController
local SocialRelationMainPanel, Super = System.NewClass("SocialRelationMainPanel", UIBasePanel)
SocialRelationMainPanel.uiResCls = UI_Social_Panel_MainResource

function SocialRelationMainPanel:ctor()
  Super.ctor(self)
  SocialDataUtils.CreateFacadeStateStr("Shop", {421, 2314})
end

function SocialRelationMainPanel:OnBind(binder)
  self:_OnInitData(binder)
  self:_OnInitUI()
  self:_OnBindToggles()
  self:_OnBindPageChange()
  self:_OnBindTitle()
  self:_OnBindCloseBtn()
  self:_PlayToggleOpenAnim()
  binder:BindEvent(EventMgr.Instance.SocialAttention, System.fn(self, self.OnSocialAttention))
end

function SocialRelationMainPanel:_OnInitData(binder)
  self.binder = binder
  self.model = binder:createModel(SocialRelationMainModel)
  self.showingSubPanel = nil
  self.ui.Btn_Find:SetActive(false)
  self.pageInfoMap = {
    [SocialRelationPage.Follow] = {
      page = SocialRelationPage.Follow,
      toggleUI = self.ui.Btn_Attention,
      openPageFunc = function()
        do return UIManager.Instance.Reopen, UIManager.Instance end
        return UIManager.Instance.Reopen, UIManager.Instance, Urls.SocialRelationFollowPanel
      end,
      label = LT.Text("SocialSystemFollow"),
      sort = 1
    },
    [SocialRelationPage.Fans] = {
      page = SocialRelationPage.Fans,
      toggleUI = self.ui.Btn_Fans,
      openPageFunc = function()
        do return UIManager.Instance.Reopen, UIManager.Instance end
        return UIManager.Instance.Reopen, UIManager.Instance, Urls.SocialRelationFansPanel
      end,
      label = LT.Text("SocialSystemFans"),
      sort = 2,
      redFunc = function()
        do return SocialRedUtils.GetSocialRed end
        return SocialRedUtils.GetSocialRed, {
          RedTypeDefine.SocialSubType.NewFans
        }, RedTypeDefine.SocialSubType.NewFans
      end
    },
    [SocialRelationPage.Visiter] = {
      page = SocialRelationPage.Visiter,
      toggleUI = self.ui.Btn_Visitor,
      openPageFunc = function()
        do return UIManager.Instance.Reopen, UIManager.Instance end
        return UIManager.Instance.Reopen, UIManager.Instance, Urls.SocialRelationVisiterPanel
      end,
      label = LT.Text("SocialSystemVisitor"),
      sort = 3
    },
    [SocialRelationPage.Bans] = {
      page = SocialRelationPage.Bans,
      toggleUI = self.ui.Btn_Blacklist,
      openPageFunc = function()
        do return UIManager.Instance.Reopen, UIManager.Instance end
        return UIManager.Instance.Reopen, UIManager.Instance, Urls.SocialRelationBanPanel
      end,
      label = LT.Text("TextBanTitle"),
      sort = 4
    },
    [SocialRelationPage.Search] = {
      page = SocialRelationPage.Search,
      toggleUI = self.ui.Btn_Find,
      openPageFunc = function()
        do return UIManager.Instance.Reopen, UIManager.Instance end
        return UIManager.Instance.Reopen, UIManager.Instance, Urls.SocialRelationSearchPanel
      end,
      label = LT.Text("SocialSystemLookup"),
      sort = 5
    },
    [SocialRelationPage.Rank] = {
      page = SocialRelationPage.Rank,
      toggleUI = self.ui.Btn_Rank,
      openPageFunc = function()
        do return UIManager.Instance.Reopen, UIManager.Instance end
        return UIManager.Instance.Reopen, UIManager.Instance, Urls.SocialRankView
      end,
      label = LT.Text("SocialSystemRank"),
      sort = 6
    },
    [SocialRelationPage.Invitation] = {
      page = SocialRelationPage.Invitation,
      toggleUI = self.ui.Btn_Invitation,
      openPageFunc = function()
        do return UIManager.Instance.Reopen, UIManager.Instance end
        return UIManager.Instance.Reopen, UIManager.Instance, Urls.InvitaionCodeView
      end,
      label = LT.Text("SocialSystemInvitation"),
      sort = 7,
      redFunc = function()
        do return end
        return RedPointDataUtils.IsShowSocialInviteRed, nil
      end
    },
    [SocialRelationPage.Community] = {
      page = SocialRelationPage.Community,
      toggleUI = self.ui.Btn_Community,
      openPageFunc = function()
        do return UIManager.Instance.Reopen, UIManager.Instance end
        return UIManager.Instance.Reopen, UIManager.Instance, Urls.CommunityJumpPanel
      end,
      label = LT.Text("SocialSystemCommunity"),
      sort = 8,
      redFunc = function()
        do return end
        return RedPointDataUtils.GetCommunityRed, nil
      end
    }
  }
  local defaultPage = SocialRelationPage.Follow
  for _, pageInfo in pairs(self.pageInfoMap) do
  end
  self.model:SetPage(defaultPage)
end

function SocialRelationMainPanel:_OnInitUI()
  local _, binder = self.model, self.binder
  binder:SetImage(self.ui.Image_Bg, SocialDefine.LargeImagePath.SocialRelationPanelBg)
end

function SocialRelationMainPanel:_OnBindToggles()
  local model, binder = self.model, self.binder
  for _, pageInfo in pairs(self.pageInfoMap) do
    binder:BindToZ1Toggle(pageInfo.toggleUI, nil, function(isOn)
      if isOn then
        local function newPageCb()
          model:SetPage(pageInfo.page)
        end
        
        local function cancelCb()
          binder:SetZ1Toggle(self.ui.Btn_Attention, true, true)
        end
        
        SocialDataUtils.CheckUnfollowing(newPageCb, cancelCb)
      end
    end, function()
      return model.page == pageInfo.page
    end)
    if pageInfo.redFunc then
      local toggleResUI = UI_Common_Item_Toggle_2Resource(pageInfo.toggleUI)
      binder:BindComponent(RedDotComponent(toggleResUI.Com_RedDot, nil, nil, pageInfo.redFunc))
    end
  end
end

function SocialRelationMainPanel:_OnBindPageChange()
  local model, binder = self.model, self.binder
  binder:BindToRaw(function(_, nVal, oVal)
    if not nVal then
      return
    end
    self:CloseShowingSubPanel()
    self.showingSubPanel = self.pageInfoMap[nVal].openPageFunc()
    if not oVal and self.showingSubPanel.PlayOpenAnim then
      self.showingSubPanel:PlayOpenAnim()
    end
  end, function()
    return model.page
  end)
end

function SocialRelationMainPanel:_OnBindTitle()
  local model, binder = self.model, self.binder
  binder:BindToText(self.ui.Text_Title, function()
    do return LT.Text end
    return LT.Text, "SocialSystemSocialInteraction"
  end)
  binder:BindToText(self.ui.Text_Label, function()
    do return LT.Text end
    return LT.Text, self.pageInfoMap[model.page].label, model.page
  end)
end

function SocialRelationMainPanel:_OnBindCloseBtn()
  local _, binder = self.model, self.binder
  self.closeBtn = binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    local function cb()
      self.closeBtn:PlayCloseAnim()
      
      self:Close()
    end
    
    SocialDataUtils.CheckUnfollowing(cb)
  end))
end

function SocialRelationMainPanel:CloseShowingSubPanel()
  Logger.Debug("[sr] close panel =%s", self.showingSubPanel)
  if self.showingSubPanel then
    self.showingSubPanel:Close()
    self.showingSubPanel = nil
  end
end

function SocialRelationMainPanel:CloseShowingSubPanelWithAnim()
  if self.showingSubPanel and self.showingSubPanel.CloseWithAnim then
    self.showingSubPanel:CloseWithAnim()
    self.showingSubPanel = nil
  end
end

function SocialRelationMainPanel:_PlayToggleOpenAnim()
  local toggleUISequence = {}
  for _, pageInfo in pairs(self.pageInfoMap) do
    toggleUISequence[pageInfo.sort] = pageInfo.toggleUI
  end
  for _, toggleUi in ipairs(toggleUISequence) do
    self.binder:SetActive(toggleUi, false)
  end
  for key, toggleUi in ipairs(toggleUISequence) do
    FrameWaiter.OnNextFrame(function()
      if not IsNil(toggleUi) then
        self.binder:SetActive(toggleUi, true)
        local objUI = UI_Common_Item_Toggle_2Resource(toggleUi)
        local uiAnimController = objUI.uiNode:GetComponent(typeof(UIAnimationController))
        local clipsToPlay = ""
        
        local function callBack()
        end
        
        clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Common_Item_Toggle_2_Open")
        uiAnimController:PlayMultiState(clipsToPlay, callBack, 1)
      end
    end, 2 * key)
  end
end

function SocialRelationMainPanel:OnSocialAttention()
  SocialDataUtils.ClearSocialListCache()
end

function SocialRelationMainPanel:Close()
  SocialDataUtils.ClearSocialListCache()
  self:CloseShowingSubPanelWithAnim()
  self:CloseShowingSubPanel()
  Super.Close(self)
end

return SocialRelationMainPanel
