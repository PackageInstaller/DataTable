local JointDrillRaidCtrl = class("JointDrillRaidCtrl", BaseCtrl)
local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
JointDrillRaidCtrl._mapNodeConfig = {
  goBlur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  btnBgClose = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  animWindow = {
    sNodeName = "---RaidCount---",
    sComponentName = "Animator"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Raid_Title_Raid"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtRaidCountCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Raid_RaidCount"
  },
  txtRaidCount = {sComponentName = "TMP_Text"},
  txtRaidTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Fast_Battle_Tip_Text"
  },
  imgEnergy = {sComponentName = "Image"},
  txtEnergyCount = {sComponentName = "TMP_Text"},
  Slider = {
    sComponentName = "Slider",
    callback = "OnValueChange_Slider"
  },
  btnReduce = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reduce"
  },
  btnAdd = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Add"
  },
  btnGrayAdd = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_MaxGray"
  },
  btnGrayReduce = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_MinGray"
  },
  btnConfirm1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "Raid_Btn_Raid"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Cancel"
  }
}
JointDrillRaidCtrl._mapEventConfig = {}
JointDrillRaidCtrl._mapRedDotConfig = {}

function JointDrillRaidCtrl:Refresh()
  local mapItemCfg = ConfigTable.GetData_Item(self.nTicketsId)
  if mapItemCfg ~= nil then
    self:SetPngSprite(self._mapNode.imgEnergy, mapItemCfg.Icon)
  end
  self:RefreshData()
  self:RefreshCount()
  self:RefreshBar()
end

function JointDrillRaidCtrl:RefreshData()
  self.nTicketsCount = PlayerData.Item:GetItemCountByID(self.nTicketsId)
  self.nMaxCount = self.nTicketsCount
  NovaAPI.SetSliderMinValue(self._mapNode.Slider, 1)
  NovaAPI.SetSliderMaxValue(self._mapNode.Slider, self.nMaxCount)
  NovaAPI.SetSliderInteractable(self._mapNode.Slider, self.nMaxCount > 1)
end

function JointDrillRaidCtrl:RefreshCount()
  NovaAPI.SetTMPText(self._mapNode.txtRaidCount, self.nSelectCount)
  NovaAPI.SetTMPText(self._mapNode.txtEnergyCount, self.nSelectCount)
  NovaAPI.SetTMPColor(self._mapNode.txtEnergyCount, self.nTicketsCount < self.nSelectCount and Red_Unable or Blue_Normal)
  self:RefreshAddButton(self.nSelectCount < self.nMaxCount)
  self:RefreshReduceButton(self.nSelectCount > 1)
end

function JointDrillRaidCtrl:RefreshAddButton(bAble)
  self._mapNode.btnGrayAdd.gameObject:SetActive(not bAble)
  self._mapNode.btnAdd.gameObject:SetActive(bAble)
end

function JointDrillRaidCtrl:RefreshReduceButton(bAble)
  self._mapNode.btnGrayReduce.gameObject:SetActive(not bAble)
  self._mapNode.btnReduce.gameObject:SetActive(bAble)
end

function JointDrillRaidCtrl:RefreshBar()
  NovaAPI.SetSliderValue(self._mapNode.Slider, self.nSelectCount)
end

function JointDrillRaidCtrl:PlayOutAni()
  self._mapNode.animWindow:Play("t_window_04_t_out")
  
  local function closeCall()
    self:Close()
  end
  
  self:AddTimer(1, 0.2, closeCall, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function JointDrillRaidCtrl:Close()
  EventManager.Hit(EventId.ClosePanel, JointDrillContext.GetPanelId(PlayerData.JointDrill_1.nActId, "Raid"))
end

function JointDrillRaidCtrl:Awake()
end

function JointDrillRaidCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  if tbParam ~= nil then
    self.nSelectLevelId = tbParam[1]
  end
  self.nSelectCount = 1
  self._mapNode.animWindow.gameObject:SetActive(false)
  self._mapNode.goBlur.gameObject:SetActive(true)
  self._mapNode.btnBgClose.gameObject:SetActive(false)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.animWindow.gameObject:SetActive(true)
    self._mapNode.btnBgClose.gameObject:SetActive(true)
    self._mapNode.animWindow:Play("t_window_04_t_in")
    self.nTicketsId = ConfigTable.GetConfigNumber("JointDrill_Challenge_Tickets_Id")
    self:Refresh()
    EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  end
  
  cs_coroutine.start(wait)
end

function JointDrillRaidCtrl:OnDisable()
end

function JointDrillRaidCtrl:OnDestroy()
end

function JointDrillRaidCtrl:OnRelease()
end

function JointDrillRaidCtrl:OnBtnClick_Cancel(btn)
  self:PlayOutAni()
end

function JointDrillRaidCtrl:OnValueChange_Slider(_, value)
  self.nSelectCount = math.ceil(value)
  self:RefreshCount()
end

function JointDrillRaidCtrl:OnBtnClick_Add(btn)
  local nRemain = self.nMaxCount - self.nSelectCount
  if nRemain <= 0 then
    return
  end
  if btn.Operate_Type == 0 then
    self.nSelectCount = self.nSelectCount + 1
  elseif btn.Operate_Type == 3 then
    local nAdd = 2 ^ btn.CurrentGear
    local nAfterRemain = nRemain - nAdd
    if nAfterRemain < 0 then
      nAdd = nRemain
    end
    self.nSelectCount = math.floor(self.nSelectCount + nAdd)
  end
  self:RefreshCount()
  self:RefreshBar()
end

function JointDrillRaidCtrl:OnBtnClick_Reduce(btn)
  if self.nSelectCount <= 1 then
    return
  end
  if btn.Operate_Type == 0 then
    self.nSelectCount = self.nSelectCount - 1
  elseif btn.Operate_Type == 3 then
    self.nSelectCount = math.floor(self.nSelectCount - 2 ^ btn.CurrentGear)
  end
  if self.nSelectCount < 1 then
    self.nSelectCount = 1
  end
  self:RefreshCount()
  self:RefreshBar()
end

function JointDrillRaidCtrl:OnBtnClick_Confirm(btn)
  if self.nTicketsCount < self.nSelectCount then
    return
  end
  
  local function callback()
    self.nSelectCount = 1
    self:Refresh()
    if self.nTicketsCount <= 0 then
      self:PlayOutAni()
    end
  end
  
  PlayerData.JointDrill_1:SendJointDrillSweepMsg(self.nSelectLevelId, self.nSelectCount, callback)
end

function JointDrillRaidCtrl:OnBtnClick_MinGray()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Crafting_Count_Min"))
end

function JointDrillRaidCtrl:OnBtnClick_MaxGray()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Crafting_Count_Max"))
end

function JointDrillRaidCtrl:OnBtnClick_Close()
  self:PlayOutAni()
end

return JointDrillRaidCtrl
