local UIAnimationController = CS.Z1Client.UIAnimationController
local CHANGE_BUTTON_CD = 5
local PER_STRANGER_NUM = 20
local SocialRelationSearchPanel, Super = System.NewClass("SocialRelationSearchPanel", UIBasePanel)
SocialRelationSearchPanel.uiResCls = UI_Social_Panel_Main_SubPanel_2Resource

function SocialRelationSearchPanel:ctor()
  Super.ctor(self)
end

function SocialRelationSearchPanel:OnBind(binder)
  if SocialDataUtils.GetFirstRequestStranger() then
    SocialDataUtils.ReqOnQueryStranger(PER_STRANGER_NUM, 1, System.fn(self, self._OnQueryStrangerEnd))
    SocialDataUtils.SetFirstRequestStranger(false)
  end
  self.binder = binder
  self.model = binder:createModel(SocialRelationSearchModel)
  self.isStrangerFollowAllDone = false
  self.nameLengthMin, self.nameLengthMax = StrUtils.GetNameLengthRange()
  self.uiAnimationController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  binder:SetText(self.ui.Text_Stranger, LT.Text("SocialSystemStranger"))
  binder:SetText(self.ui.Text_Tips_2, LT.Text("SocialSystemSearchPlayers"))
  self:_OnBindStrangerPlayerGroup()
  self:_OnBindChangeStrangerBtn()
  self:_OnBindSearchGroup()
  self:_OnBindEmptyState()
end

function SocialRelationSearchPanel:_OnBindStrangerPlayerGroup()
  local binder, model = self.binder, self.model
  binder:BindToCircularListView(self.ui.ScrollView_Stranger, function()
    return model.showingGroup
  end, function(_, item, index)
    local itemData = {
      facade = model.showingGroup[index],
      socialListItemType = SocialDefine.SocialListItemType.ShowAssist,
      attentionCb = function(newRelation)
        model:UpdateFacadeRelation(index, newRelation)
      end
    }
    binder:SetIcon(MaterialIconType.SocialRelationListItem, item.gameObject, itemData)
  end)
  binder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView_Stranger)
end

function SocialRelationSearchPanel:_OnBindChangeStrangerBtn()
  local binder, model = self.binder, self.model
  binder:BindZ1Button(self.ui.UI_Common_Btn_Change, System.fn(self, self.OnClickChange), function()
    if 0 == model.changeBtnCD then
      return CommonDefine.Z1ButtonState.High
    end
    return CommonDefine.Z1ButtonState.Unclickable
  end)
  binder:SetActive(self.ui.Btn_FollowAll, true)
  binder:BindZ1Button(self.ui.Btn_FollowAll, function()
    if self.isStrangerFollowAllDone then
      Alert.ShowStr(LT.Text("Socialize_AllStrangersFollowed"))
      return
    end
    if not self.model.showingGroup or table.length(self.model.showingGroup) <= 0 then
      Alert.ShowStr(LT.Text("SocialSystemLookupEmptyStatusTitle"))
    else
      SocialDataUtils.ExecuteFollowAll(self.model.showingGroup, false, function()
        self.isStrangerFollowAllDone = true
        binder:SetButtonState(self.ui.Btn_FollowAll, CommonDefine.Z1ButtonState.Unclickable)
        Alert.ShowStr(LT.Text("Socialize_AllStrangersFollowed"))
      end)
    end
  end, function()
    print("isStrangerFollowAllDone", self.isStrangerFollowAllDone, table.length(self.model.showingGroup))
    if self.isStrangerFollowAllDone then
      return CommonDefine.Z1ButtonState.Unclickable
    end
    if self.model.showingGroup and table.length(self.model.showingGroup) > 0 then
      return CommonDefine.Z1ButtonState.High
    else
      return CommonDefine.Z1ButtonState.Unclickable
    end
  end)
  binder:BindToText(self.ui.Text_Name_Another, function()
    if 0 == model.changeBtnCD then
      do return LT.Text end
      return LT.Text, "SocialSystemChangeBatch", nil
    end
    do return LT.Textf, "SocialSystemCoolDown" end
    return LT.Textf, "SocialSystemCoolDown", model.changeBtnCD
  end)
end

function SocialRelationSearchPanel:_OnBindSearchGroup()
  local binder, model = self.binder, self.model
  binder:BindZ1Button(self.ui.UI_Common_Btn_Search, function()
    if model:CheckHaveInputStr() then
      if model.inputStr == tostring(PlayerDataUtils.GetPlayerUid()) then
        Alert.ShowStr(LT.Text("SocialSystemCannotSearchForOneself"))
        return
      end
      SocialDataUtils.ReqOnSocialVisit(tonumber(model.inputStr), function(svrData)
        if not self.ui then
          return
        end
        model:SetShowingGroup({
          svrData.facade
        })
        self.isStrangerFollowAllDone = false
        if table.length(self.model.showingGroup) > 0 then
          binder:SetButtonState(self.ui.Btn_FollowAll, CommonDefine.Z1ButtonState.High)
        end
        binder:SetText(self.ui.Text_Stranger, LT.Text("SocialSystemSearchResult"))
      end, function()
        Alert.ShowStr(LT.Text("SocialSystemNoFoundInTheSearch"))
      end)
      return
    end
    Alert.ShowStr(LT.Text("SocialSystemEnterUID"))
  end, function()
    if model:CheckHaveInputStr() then
      return CommonDefine.Z1ButtonState.High
    end
    return CommonDefine.Z1ButtonState.Unclickable
  end, function()
    do return LT.Text end
    return LT.Text, "SocialSystemSearch"
  end)
  binder:BindZ1Button(self.ui.Btn_Remove, function()
    local newStr = ""
    if not model:CheckHaveInputStr() then
      newStr = StrUtils.PasteFromClipboard()
      if string.match(newStr, "%D") then
        newStr = ""
      end
    end
    binder:SetInputText(self.ui.InputField_Account_Stranger, newStr)
    model:SetInputStr(newStr)
  end, function()
    if model:CheckHaveInputStr() then
      return CommonDefine.Z1ButtonState.Unclickable
    end
    return CommonDefine.Z1ButtonState.Normal
  end)
  binder:BindToInputValueChange(self.ui.InputField_Account_Stranger, function(str)
    local subStr = StrUtils.SubStr(str, self.nameLengthMax)
    if subStr ~= str then
      binder:SetInputText(self.ui.InputField_Account_Stranger, subStr)
    end
    model:SetInputStr(subStr)
  end)
end

function SocialRelationSearchPanel:_OnBindEmptyState()
  local binder, model = self.binder, self.model
  binder:BindToVisible(self.ui.Group_Null_Black, function()
    return 0 == #model.showingGroup
  end)
  binder:SetText(self.ui.Text_NoTask, LT.Text("SocialSystemLookupEmptyStatusTitle"))
  binder:SetText(self.ui.Text_Time, LT.Text("SocialSystemLookupEmptyStatusDesc"))
end

function SocialRelationSearchPanel:CreateChangeBtnTimer()
  self.timer = self.binder:BindTimer(1, CHANGE_BUTTON_CD, function()
    self.model:SetChangeBtnCD(self.model.changeBtnCD - 1)
  end, function()
    self:ClearChangeBtnTimer()
  end)
end

function SocialRelationSearchPanel:ClearChangeBtnTimer()
  if self.timer then
    self.binder:StopTimer(self.timer)
    self.timer = nil
  end
end

function SocialRelationSearchPanel:OnClickChange()
  local binder, model = self.binder, self.model
  if 0 == model.changeBtnCD then
    SocialDataUtils.ReqOnQueryStranger(PER_STRANGER_NUM, 1, System.fn(self, self._OnQueryStrangerEnd))
    binder:SetText(self.ui.Text_Stranger, LT.Text("SocialSystemStranger"))
  end
end

function SocialRelationSearchPanel:_OnQueryStrangerEnd()
  if not self.ui then
    return
  end
  local binder, model = self.binder, self.model
  model:SetShowingGroup(model:SortStrangerGroup(SocialDataUtils.GetStrangerMap()))
  self.isStrangerFollowAllDone = false
  if table.length(self.model.showingGroup) > 0 then
    binder:SetButtonState(self.ui.Btn_FollowAll, CommonDefine.Z1ButtonState.High)
  end
  model:SetChangeBtnCD(CHANGE_BUTTON_CD)
  self:CreateChangeBtnTimer()
  binder:CircularScrollTo(self.ui.ScrollView_Stranger, 1)
end

function SocialRelationSearchPanel:PlayOpenAnim()
  self.uiAnimationController:PlayState("UI_Social_Panel_Main_SubPanel_2_Open", function()
  end)
end

function SocialRelationSearchPanel:CloseWithAnim()
  self.uiAnimationController:PlayState("UI_Social_Panel_Main_SubPanel_2_Close", System.fn(self, self.Close))
end

return SocialRelationSearchPanel
