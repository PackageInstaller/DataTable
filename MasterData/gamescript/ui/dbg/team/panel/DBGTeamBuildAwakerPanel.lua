local AddClipToPlay = AnimatorUtils.AddClipToPlay
local UIAnimationController = CS.Z1Client.UIAnimationController
local DBGTeamBuildAwakerPanel, Super = System.NewClass("DBGTeamBuildAwakerPanel", UIBasePanel)
DBGTeamBuildAwakerPanel.uiResCls = UI_Team_Panel_Awaker_MainResource

function DBGTeamBuildAwakerPanel:ctor(dbgTeamBuildModel)
  Super.ctor(self)
  self.model = dbgTeamBuildModel
end

function DBGTeamBuildAwakerPanel:OnBind(binder)
  self:InitAnimation()
  self:PlayAnim("UI_Team_Panel_Awaker_Main_open_02")
  self.closeBtn = binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    self.model:SetCurBuildingAwakerTeam(table.deepclone(self.model.teamAwakerTids))
    self:Close()
  end))
  binder:BindComponent(DBGTeamChooseAwakerGroupItem(self.ui.UI_Team_Popup_Awaker_List, self.model, self.model.BuildTeamType.ChooseBuild, System.fn(self, self.Close)))
  binder:BindToVisible(self.ui.Group_Chose_Awaker, function()
    local tid = self.model:GetCurBuildingAwakerTeam(self.model.curAwakerSlot)
    return 0 == tid
  end)
  binder:BindToText(self.ui.Text_Tips1, function()
    do return LT.Text end
    return LT.Text, "Formation_SelectRole_Recommend_String1"
  end)
  binder:BindToText(self.ui.Text_Tips2, function()
    do return LT.Text end
    return LT.Text, "Formation_SelectRole_Recommend_String2"
  end)
  binder:BindToVisible(self.ui.Group_Awaker, function()
    local tid = self.model:GetCurBuildingAwakerTeam(self.model.curAwakerSlot, true)
    return 0 ~= tid
  end)
  binder:BindToText(self.ui.Text_Name, function()
    local tid = self.model:GetCurBuildingAwakerTeam(self.model.curAwakerSlot, true)
    if tid and 0 ~= tid then
      return DT.AwakerConfig[tid].Name
    end
    return ""
  end)
  binder:BindToText(self.ui.Text_Designation, function()
    local tid = self.model:GetCurBuildingAwakerTeam(self.model.curAwakerSlot, true)
    if tid and 0 ~= tid then
      return DT.AwakerConfig[tid].Title
    end
    return ""
  end)
  binder:BindToText(self.ui.Text_Military, function()
    local tid = self.model:GetCurBuildingAwakerTeam(self.model.curAwakerSlot)
    if tid and 0 ~= tid then
      local awakerData = self.model:GetAwakerDataByCfgId(tid)
      return awakerData.fighting
    end
    return ""
  end)
  binder:BindToVisible(self.ui.Text_Military, function()
    return self.model.teamType ~= CommonDefine.TeamType.Daily
  end)
  binder:BindToRaw(function(childBinder, resNum)
    if resNum then
      local com = childBinder:BindComponent(AwakerPortraitComp(self.ui.Container_Awaker, nil, resNum))
      com:ChangeMaterialMask(CommonRes.UIPortraitMask.teamShowMask)
    end
  end, function()
    local tid = self.model:GetCurBuildingAwakerTeam(self.model.curAwakerSlot, true)
    if tid and 0 ~= tid then
      do return AwakerDataUtils.GetAwakerResNum, tid end
      return AwakerDataUtils.GetAwakerResNum, tid, false
    end
  end)
  self:OnBindSchool(binder)
  self:_BindAwakerFavor(binder)
end

function DBGTeamBuildAwakerPanel:OnBindSchool(binder)
  binder:BindButtonClick(self.ui.Button_Awaker_Talent, System.fn(self, self.OnCareerClick))
  binder:BindButtonClick(self.ui.Button_Talent, System.fn(self, self.OnCareerClick))
  binder:BindToRaw(function(_, schoolId)
    if not schoolId then
      self.ui.Image_Icon:SetActive(false)
      binder:SetText(self.ui.Text_Talent, LT.Text("Team_Occupation_Tips"))
      binder:SetText(self.ui.Text_Talent2, LT.Text("Team_Occupation_Tips"))
      binder:SetActive(self.ui.Image_Talent_Actived, false)
    else
      local schoolConfig = DT.SchoolConfig[schoolId]
      if schoolConfig then
        self.ui.Image_Icon:SetActive(true)
        binder:SetImage(self.ui.Image_Icon, schoolConfig.Icon)
        binder:SetText(self.ui.Text_Talent, LT.Text("School_Activate"))
        binder:SetText(self.ui.Text_Talent2, LT.Text("School_Activate"))
        binder:SetActive(self.ui.Image_Talent_Actived, true)
      end
    end
  end, function()
    return nil
  end)
  self.binder:BindToTextColor(self.ui.Text_Talent2, function()
    return CommonDefine.ColorType.Dark
  end)
end

function DBGTeamBuildAwakerPanel:_BindAwakerFavor(binder)
  if not self.ui.Image_AwakerFavor then
    return
  end
  binder:BindToVisible(self.ui.Image_AwakerFavor, function()
    local tid = self.model:GetCurBuildingAwakerTeam(self.model.curAwakerSlot, true)
    if not tid or 0 == tid then
      return false
    end
    local awakerData
    if self.model.curAwakerSlot == CommonDefine.TeamAssign.MaxBattleNum then
      awakerData = self.model:GetAssistAwaker()
    else
      awakerData = self.model:GetAwakerDataByCfgId(tid)
    end
    do return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, tid end
    return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, tid, awakerData
  end)
end

function DBGTeamBuildAwakerPanel:Close()
  self.closeBtn:PlayCloseAnim()
  self:PlayAnim("UI_Team_Panel_Awaker_Main_close_02", function()
    self.model:SetCurAwakerSlot(0)
    Super.Close(self)
  end)
  self.model:SetPage(CommonDefine.DBGTeamBuildPage.Main)
end

function DBGTeamBuildAwakerPanel:OnCareerClick()
  UIManager.Instance:Reopen(Urls.DBGTeamCareerPanel, self.model.careerEffectList)
end

function DBGTeamBuildAwakerPanel:OnJumpToAwakerPanel()
  local tid = self.model:GetCurBuildingAwakerTeam(self.model.curAwakerSlot)
  
  local function jumpCallBack()
    if self.model.teamType == CommonDefine.TeamType.Daily then
      Alert.Show(10527)
    end
  end
  
  local function panelOpenFunc()
    local awakerBasePanelData = {}
    awakerBasePanelData.jumpPage = CommonDefine.AwakerPage.Detail
    local awakerData = table.clone(self.model:GetAwakerDataByCfgId(tid))
    awakerData.tid = math.abs(awakerData.tid)
    awakerBasePanelData.specialAwakerList = {awakerData}
    UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
  end
  
  FuncJumpManager.JumpToFuncPanel(jumpCallBack, panelOpenFunc)
end

function DBGTeamBuildAwakerPanel:InitAnimation()
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
end

function DBGTeamBuildAwakerPanel:PlayAnim(clipsString, func)
  local clipsToPlay = ""
  Logger.Debug("DBGTeamBuildMainPanel PlayAnim: ", clipsString)
  
  local function callBack()
    if func then
      func()
    end
    self.model:SetBanClick(false)
  end
  
  self.model:SetBanClick(true)
  self.uiAnimController:PlayMultiState(AddClipToPlay(clipsToPlay, clipsString), callBack)
end

return DBGTeamBuildAwakerPanel
