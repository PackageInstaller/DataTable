local AddClipToPlay = AnimatorUtils.AddClipToPlay
local UIAnimationController = CS.Z1Client.UIAnimationController
local DBGTeamListAwakerPanel, Super = System.NewClass("DBGTeamListAwakerPanel", UIBasePanel)
DBGTeamListAwakerPanel.uiResCls = UI_Team_Popup_MyTeam_Awaker_ListResource

function DBGTeamListAwakerPanel:ctor(dbgTeamBuildModel)
  Super.ctor(self)
  self.model = dbgTeamBuildModel
  self:InitUIData()
end

function DBGTeamListAwakerPanel:OnBind(binder)
  self.binder = binder
  self:InitAnimation()
  self:PlayAnim("UI_Team_Popup_MyTeam_Awaker_List_open")
  binder:BindZ1Button(self.ui.Btn_Select, System.fn(self, self.OnClickChoose), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "Formation_Administration_Sure_Btn"
  end, nil, nil, nil)
  binder:BindNormalListView(self.ui.ScrollView_Team, function()
    return self.model.allTeamList
  end, function()
    return "UI_Team_Item_MyTeam_List"
  end, function(itemBinder, item, idx)
    local index = self.model.teamCreateIndex
    self.model:SetTeamCreateIndex(index + 1)
    itemBinder:BindComponent(DBGTeamListAwakerGroupItem(item, self.model, idx))
  end)
  binder:ListViewJumpToIndex(self.ui.ScrollView_Team, 1)
  if 5 == self.model.curTeamIndex then
    binder:ListViewJumpToIndex(self.ui.ScrollView_Team, 5)
  end
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  binder:BindToText(self.ui.Text_Title, function()
    do return LT.Text end
    return LT.Text, "Formation_Administration_Title_String"
  end)
end

function DBGTeamListAwakerPanel:InitUIData()
  self.model:SetTeamTempChooseIndex(self.model.curTeamIndex)
  self.model:SetTeamCreateIndex(1)
end

function DBGTeamListAwakerPanel:OnClickChoose()
  local function saveFunc()
    if 4 == self.model.fightAwakerNum or 0 == self.model.fightAwakerNum then
      self.model:UpdateAwakerTeamInfoWithCurData(self.model.curTeamIndex)
    end
    self.model:ChooseNewTeam(self.model.teamTempChooseIndex)
    self:Close()
  end
  
  Logger.ReportApusInfo("DBGTeam SaveTeamToServer DBGTeamListAwakerPanel:OnClickChoose ")
  self.model:SaveTeamToServer(saveFunc)
end

function DBGTeamListAwakerPanel:InitAnimation()
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
end

function DBGTeamListAwakerPanel:PlayAnim(clipsString, func)
  local clipsToPlay = ""
  self.uiAnimController:PlayMultiState(AddClipToPlay(clipsToPlay, clipsString), func)
end

function DBGTeamListAwakerPanel:Close()
  self:PlayAnim("UI_Team_Popup_MyTeam_Awaker_List_close", function()
    Super.Close(self)
  end)
end

return DBGTeamListAwakerPanel
