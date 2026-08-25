local PcRewardCfg = DT.GetOriginalConstant("OSLoginReward_PC")
local MobileRewardCfg = DT.GetOriginalConstant("OSLoginReward_MOBILE")
local SettingBindRewardView, Super = NewClass("SettingBindRewardView", BaseView)
SettingBindRewardView.uiResCls = UI_Setting_Popup_PlatformBindingResource

function SettingBindRewardView:ctor()
  Super.ctor(self)
  self:_InitViewData()
end

function SettingBindRewardView:OnEnterView()
  self:SetText(self.ui.Text_Platform_1, LT.Text("SetLogInReward_PC_Tips"))
  self:SetText(self.ui.Text_Platform_2, LT.Text("SetLogInReward_MOBILE_Tips"))
  self:SetButtonText(self.ui.Btn_Cancel, LT.Text(TipsTypeCfgUtils.GetCfgField("LeftBtnDesc", "20145")))
  self:_RefreshView()
end

function SettingBindRewardView:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnSettingBindRewardStateChanged, self._OnSettingBindRewardStateChanged, self)
end

function SettingBindRewardView:_OnSettingBindRewardStateChanged()
  self:_RefreshRewardState()
end

function SettingBindRewardView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Receive_Platform_1, System.fn(self, self._OnReceivePlatform1))
  self:AddButtonClickListener(self.ui.Btn_Receive_Platform_2, System.fn(self, self._OnReceivePlatform2))
end

function SettingBindRewardView:_OnReceivePlatform1()
  SettingController.Instance:ReqGetOSLoginReward(SettingDefine.LoginRewardType.PC)
end

function SettingBindRewardView:_OnReceivePlatform2()
  SettingController.Instance:ReqGetOSLoginReward(SettingDefine.LoginRewardType.MOBILE)
end

function SettingBindRewardView:_InitViewData()
  self.pcRewardInfoList = {}
  self.mobileRewardInfoList = {}
  for i = 1, #PcRewardCfg, 2 do
    table.insert(self.pcRewardInfoList, {
      tid = PcRewardCfg[i],
      num = PcRewardCfg[i + 1]
    })
  end
  for i = 1, #MobileRewardCfg, 2 do
    table.insert(self.mobileRewardInfoList, {
      tid = MobileRewardCfg[i],
      num = MobileRewardCfg[i + 1]
    })
  end
end

function SettingBindRewardView:_RefreshView()
  self:_RefreshRewardInfo()
  self:_RefreshRewardState()
end

function SettingBindRewardView:_RefreshRewardInfo()
  for i, rewardInfo in ipairs(self.pcRewardInfoList) do
    local go = self.ui["Reward_icon_" .. i .. "_Platform_1"]
    if not go then
    else
      go:SetActive(true)
      local itemData = {
        tid = rewardInfo.tid,
        num = rewardInfo.num,
        callback = function()
          ItemDataUtils.ShowItemDetailTips(self.binder, go, nil, rewardInfo.tid)
        end
      }
      self:AddViewComponentOnce(go, CompPublicIconItemType1, itemData)
    end
  end
  for i, rewardInfo in ipairs(self.mobileRewardInfoList) do
    local go = self.ui["Reward_icon_" .. i .. "_Platform_2"]
    if not go then
    else
      go:SetActive(true)
      local itemData = {
        tid = rewardInfo.tid,
        num = rewardInfo.num,
        callback = function()
          ItemDataUtils.ShowItemDetailTips(self.binder, go, nil, rewardInfo.tid)
        end
      }
      self:AddViewComponentOnce(go, CompPublicIconItemType1, itemData)
    end
  end
end

function SettingBindRewardView:_RefreshRewardState()
  local pcRewardState = SettingModel.Instance:GetLoginRewardState(SettingDefine.LoginRewardType.PC)
  local isGainPrize = pcRewardState == CommonDefine.CommonState.GainPrize
  local isFinish = pcRewardState == CommonDefine.CommonState.Finish
  self:SetActive(self.ui.NotReceive_Platform_1, not isGainPrize and not isFinish)
  self:SetActive(self.ui.Btn_Receive_Platform_1, isGainPrize)
  self:SetActive(self.ui.Got_Platform_1, isFinish)
  local mobileRewardState = SettingModel.Instance:GetLoginRewardState(SettingDefine.LoginRewardType.MOBILE)
  isGainPrize = mobileRewardState == CommonDefine.CommonState.GainPrize
  isFinish = mobileRewardState == CommonDefine.CommonState.Finish
  self:SetActive(self.ui.NotReceive_Platform_2, not isGainPrize and not isFinish)
  self:SetActive(self.ui.Btn_Receive_Platform_2, isGainPrize)
  self:SetActive(self.ui.Got_Platform_2, isFinish)
end

return SettingBindRewardView
