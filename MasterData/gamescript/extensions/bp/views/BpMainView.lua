local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local BpPage = CommonDefine.BpPage
local AddClipToPlay = AnimatorUtils.AddClipToPlay
local BpMainView, Super = NewClass("BpMainView", BaseView)
BpMainView.uiResCls = UI_Passport_Panel_Main_NewResource

function BpMainView:ctor(isJumpToBuy)
  Super.ctor(self)
  Logger.Info("BattlePass Sys With BpMainView")
  BpModel.Instance:OnInit()
  self.isJumpToBuy = isJumpToBuy
  if BattlePassDataUtils.GetIsFirstEnterBp() then
    RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.BattlePass, RedPointDataUtils.RedAttrType.IsNew)
  end
end

function BpMainView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnBpMainViewPageChanged, self._OnBpMainViewPageChanged, self)
end

function BpMainView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Role, System.fn(self, self.OnRoleClick))
end

function BpMainView:_OnBpMainViewPageChanged(page)
  if self.isJumpToBuy and page ~= BpPage.Recharge then
    self:OnClickClose()
    return
  end
  self:SwitchPage(page)
end

function BpMainView:SwitchPage(page)
  self:SwitchChildTapView(page)
  self:_RefreshView()
end

function BpMainView:_OnPageUISwitchedFinished(curPage)
  local newPage = curPage
  local oldPage = BpModel.Instance.lastPage
  if curPage == BpPage.WeaponReward then
    CameraManager:SetCameraChangeOnce(true, true)
  end
  if oldPage == BpPage.WeaponReward then
    CameraManager:SetCameraChangeOnce(false, false)
  end
  local newPageInfo = self.childrenTapViews[newPage]
  if not oldPage then
    local openClip = newPageInfo.openClip
    if newPage == BpPage.ItemReward then
      openClip = nil
    end
    self:PlayOpenAnimation(openClip)
    return
  end
  local clipsToPlay = ""
  local oldPageInfo = self.childrenTapViews[oldPage]
  if oldPageInfo and oldPageInfo.closeClip then
    clipsToPlay = AddClipToPlay(clipsToPlay, oldPageInfo.closeClip)
  elseif not oldPageInfo.closeClip then
    if oldPageInfo.instance then
      oldPageInfo.instance:SetRendered(false)
    else
      self:CloseChildPanel(oldPageInfo.pageUrl)
    end
  end
  if newPageInfo and newPageInfo.openClip then
    clipsToPlay = AddClipToPlay(clipsToPlay, newPageInfo.openClip)
  end
  self.uiAnimationController:StopPlayableGraph()
  self.uiAnimationController:PlayMultiState(clipsToPlay, function()
  end)
end

function BpMainView:OnEnterView()
  Super.OnEnterView(self)
  self:_InitData()
  for _, toggleInfo in pairs(self.toggleInfoMap) do
    self:AddZ1ToggleValueChangedListener(toggleInfo.obj, function(isOn)
      if isOn then
        BpModel.Instance:SetCurPage(toggleInfo.page)
      end
    end)
  end
  self:_InitCompCloseBtn()
  self:_RefreshView()
  self:SetActive(self.ui.Toggle_Task, false)
  self:PlayToggleOpenAnim()
  PlayerDataUtils.OpenFirstTimeIllustrate(self.__name, nil, LT.Text("BPRuleTxt"))
  ClientDataUtils.SetClientSubData(cd.ClientSubKey.TodayHideDoubleBpTag, cd.NumberTrue, true)
end

function BpMainView:_RefreshView()
  self:SetText(self.ui.Text_Label, LT.Text(self.labelNameMap[BpModel.Instance.curPage]))
  self:SetImage(self.ui.Image_Bg, BpModel.Instance.curPage == BpPage.ItemReward and CommonDefine.BpBg.Reward or CommonDefine.BpBg.Other)
  for _, toggleInfo in pairs(self.toggleInfoMap) do
    if toggleInfo.redFunc then
      self:AddViewComponentOnce(UI_Common_Item_Toggle_2Resource(toggleInfo.obj).Com_RedDot, UICompRedDot, CommonDefine.RedDotType.Dot, toggleInfo.redFunc)
    end
  end
end

function BpMainView:_InitCompCloseBtn()
  self.compCloseBtn = self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, function()
    if not self.clickClose then
      self:OnClickClose()
    end
  end)
end

function BpMainView:_InitData()
  self.childrenTapViews = {
    [BpPage.ItemReward] = {
      UIUrl = Urls.BpRewardView,
      UINodeName = "UI_Passport_Reward_Item",
      viewInstance = nil,
      Name = "BpRewardView",
      openClip = "UI_Passport_Reward_Item_Open_New",
      closeClip = "UI_Passport_Reward_Item_Close_New"
    },
    [BpPage.Task] = {
      UIUrl = Urls.BpTaskView,
      UINodeName = "UI_Passport_Task_Item",
      viewInstance = nil,
      Name = "BpTaskView",
      openClip = "UI_Passport_Task_Item_Open_New",
      closeClip = "UI_Passport_Task_Item_Close_New"
    },
    [BpPage.WeaponReward] = {
      UIUrl = Urls.BpWeaponView,
      UINodeName = "UI_Passport_Praising_Item",
      viewInstance = nil,
      Name = "BpWeaponView",
      openClip = "UI_Passport_Praising_Item_Open_New",
      closeClip = "UI_Passport_Praising_Item_Close_New"
    },
    [BpPage.Recharge] = {
      UIUrl = Urls.BpRechargeView,
      UINodeName = "UI_Passport_Money_Item",
      viewInstance = nil,
      Name = "BpRechargeView",
      openClip = "UI_Passport_Money_Open_New,UI_Passport_Reward_Item_Open_New",
      closeClip = "UI_Passport_Money_Close_New"
    },
    [BpPage.Review] = {
      UIUrl = Urls.BpReviewView,
      UINodeName = "UI_Passport_Instructions",
      viewInstance = nil,
      Name = "BpReviewView"
    }
  }
  self.labelNameMap = {
    [BpPage.ItemReward] = "BPAwardTab",
    [BpPage.Task] = "BPTaskTab",
    [BpPage.WeaponReward] = "BPBoxTab"
  }
  self.toggleInfoMap = {
    [1] = {
      obj = self.ui.Toggle_Item_Reward,
      page = BpPage.ItemReward,
      redFunc = System.fn(self, self.BpRewardRedFunc)
    },
    [2] = {
      obj = self.ui.Toggle_Task,
      page = BpPage.Task,
      redFunc = System.fn(self, self.BpTaskRedFunc)
    },
    [3] = {
      obj = self.ui.Toggle_Weapon_Reward,
      page = BpPage.WeaponReward
    }
  }
  self.uiAnimationController = self.ui.uiNode:GetComponent(T_UIAnimationController)
end

function BpMainView:BpRewardRedFunc()
  do return end
  return RedPointDataUtils.IsShowBpRewardRedDot
end

function BpMainView:BpTaskRedFunc()
  do return RedPointDataUtils.IsShowTaskReceiveRedDot end
  return RedPointDataUtils.IsShowTaskReceiveRedDot, BpTaskModel.Instance.taskTabList
end

function BpMainView:OnRoleClick()
  local ruleTitle = LT.Text("RuleTipsTitle")
  local ruleContent = LT.Text("BPRuleTxt")
  local isDoubleEx, openTs, closeTs = BattlePassDataUtils.IsDoubleEx()
  if isDoubleEx then
    local openDate = os.date("*t", openTs or 0)
    local openYMDHm = LT.Textf("TimeFormatYMDHm2", openDate.month, openDate.day, openDate.hour, string.format("%02d", openDate.min))
    local closeDate = os.date("*t", closeTs or 0)
    local closeYMDHm = LT.Textf("TimeFormatYMDHm2", closeDate.month, closeDate.day, closeDate.hour, string.format("%02d", closeDate.min))
    ruleContent = string.format("%s%s", ruleContent, LT.Textf("BPRuleTxt2", openYMDHm, closeYMDHm))
  end
  UIManager.Instance:Reopen(Urls.CommonillustrateView, ruleTitle, ruleContent)
end

function BpMainView:OnEnterViewFinished()
  if self.isJumpToBuy then
    BpModel.Instance:SetCurPage(BpPage.Recharge)
    return
  end
  self:SetZ1Toggle(self.toggleInfoMap[1].obj, true)
end

function BpMainView:PlayToggleOpenAnim()
  for i = 1, 3 do
    self:SetActive(self.toggleInfoMap[i].obj, false)
  end
  for i = 1, 3 do
    FrameWaiter.OnNextFrame(function()
      if self.toggleInfoMap[i].page == BpPage.Task then
        return
      end
      if self.toggleInfoMap[i].obj then
        self:SetActive(self.toggleInfoMap[i].obj, true)
        local objUI = UI_Common_Item_Toggle_2Resource(self.toggleInfoMap[i].obj)
        local uiAnimController = objUI.uiNode:GetComponent(T_UIAnimationController)
        
        local function callBack()
        end
        
        uiAnimController:PlayState("UI_Common_Item_Toggle_2_Open", callBack, 1)
      end
    end, 2 * i)
  end
end

function BpMainView:PlayOpenAnimation(openClip)
  local function AnimEndFunc()
    if self.hideLowerLayerPanelCb then
      self.hideLowerLayerPanelCb()
    end
  end
  
  local anim = "UI_Passport_Panel_Main_Open_New"
  if openClip then
    anim = anim .. "," .. openClip
  end
  self.uiAnimationController:PlayMultiState(anim, AnimEndFunc)
end

function BpMainView:OnExitView()
  if self.uiAnimationController then
    self.uiAnimationController:StopPlayableGraph()
  end
  Super.OnExitView(self)
end

function BpMainView:OnClickClose()
  UIManager.Instance:ReShowBehindPanel(self)
  CameraManager:SetCameraChangeOnce(false, false)
  self.clickClose = true
  self.uiAnimationController:PlayMultiState("UI_Passport_Panel_Main_Close_New", function()
    if self.ui then
      self.closeWithoutAnim = true
      self:Close()
    end
  end)
end

return BpMainView
