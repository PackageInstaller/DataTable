local UICompAbyssGroupListItem, Super = NewViewComponent("UICompAbyssGroupListItem")

function UICompAbyssGroupListItem:ctor(uiNode, view, data, onClick, onClickAwakers)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeons_Item_Level_ContentResource(uiNode)
  self.data = data
  self.onClick = onClick
  self.onClickAwakers = onClickAwakers
  self.isDataValid = self.data ~= nil
end

function UICompAbyssGroupListItem:RegisterNotifications()
end

function UICompAbyssGroupListItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Image_level, System.fn(self, self._OnClick))
  self:AddButtonClickListener(self.ui.Btn_Receive_Small, System.bind(self._OnClickReset, self, false))
  self:AddButtonClickListener(self.ui.Btn_Reset_Extra, System.bind(self._OnClickReset, self, true))
end

function UICompAbyssGroupListItem:OnEnterComponent()
  self:_RefreshBasicUI()
  self:_RefreshTeamUI()
  self:_RefreshBtnShow()
  self:_RefreshRevivalMark()
end

function UICompAbyssGroupListItem:_OnReset(stageGroupTid)
  if stageGroupTid and stageGroupTid ~= self.data.stageGroupTid then
    return
  end
  self:_RefreshTeamUI()
  self:_RefreshBtnShow()
  self:_RefreshRevivalMark()
end

function UICompAbyssGroupListItem:_RefreshBtnShow()
  local pass = false
  if self.isDataValid then
    pass = self.data.stageTid and self.data.stageTid > 0
  end
  self.ui.Btn_Receive_Small:SetActive(pass)
end

function UICompAbyssGroupListItem:_RefreshTeamUI()
  local pass = false
  if self.isDataValid then
    pass = self.data.stageTid and self.data.stageTid > 0
  end
  self.ui.Image_Recommend:SetActive(pass)
  self.ui.Text_C_Undone:SetActive(not pass)
  self.ui.Btn_Receive_Small:SetActive(pass)
  self.ui.Image_Difficulty:SetActive(pass)
  local diffText = ""
  local diffImg
  if pass then
    local stageConfig = CopyDataUtils.GetStageConfig(self.data.stageTid)
    if stageConfig and stageConfig.StageLevel then
      if stageConfig.StageLevel >= self.data.maxStageLevel then
        diffText = LT.Text("AbyssChallengePerfectPass")
        diffImg = CommonDefine.AbyssPassTextBgImg.Perfect
        self.ui.UI_Vx_Dungeons_Item_Level_Tips_01:SetActive(true)
        self.ui.UI_Vx_Dungeons_Item_Level_Tips_02:SetActive(false)
      else
        diffText = LT.Text("AbyssChallengePass")
        diffImg = CommonDefine.AbyssPassTextBgImg.Normal
        self.ui.UI_Vx_Dungeons_Item_Level_Tips_01:SetActive(false)
        self.ui.UI_Vx_Dungeons_Item_Level_Tips_02:SetActive(true)
      end
    end
  end
  self:SetText(self.ui.Text_Difficulty, diffText)
  self:SetImage(self.ui.Image_Difficulty, diffImg)
  self:SetImage(self.ui.Image_Difficulty_Extra, diffImg)
  self:SetNormalAwakers()
  self:SetExtraAwakers()
end

function UICompAbyssGroupListItem:SetNormalAwakers()
  self:SetAwaker(false)
end

function UICompAbyssGroupListItem:SetExtraAwakers()
  local isExtraTeam = self.data.extraPass and table.next(self.data.teamExtra and self.data.teamExtra.awakers or {})
  self:SetActive(self.ui.Group_Extra, isExtraTeam)
  self:SetAwaker(true)
end

function UICompAbyssGroupListItem:SetAwaker(isExtra)
  local team = self.data.team
  if isExtra then
    team = self.data.teamExtra
  end
  local awakers = team and team.awakers or {}
  local nodeName = isExtra and "Role_ExtraAwaker_" or "Role_Awaker_"
  for i = 1, 4 do
    local obj = self.ui[nodeName .. i]
    if not obj then
    else
      local awakerData = awakers[i]
      self:SetActive(obj, nil ~= awakerData)
      if not awakerData then
      else
        local awakerItemData = {
          awakerId = awakerData.tid,
          itemCount = LT.Textf("Team_AwakerLevel", awakerData.level),
          clickFunc = function()
            self.onClickAwakers(isExtra)
          end
        }
        self:AddViewComponentOnce(obj, CompPublicIconItemType2, awakerItemData)
      end
    end
  end
end

function UICompAbyssGroupListItem:_RefreshRevivalMark()
  local normalNode = self.ui.Image_Item_Normal or self:FindChildRecursively(self.ui.uiNode, "Image_Item_Normal")
  local extraNode = self.ui.Image_Item_Extra or self:FindChildRecursively(self.ui.uiNode, "Image_Item_Extra")
  if not AbyssExtModel.Instance:IsAbyssRevivalFeatureEnabled() then
    if normalNode then
      self:SetActive(normalNode, false)
    end
    if extraNode then
      self:SetActive(extraNode, false)
    end
    return
  end
  if not self.isDataValid then
    if normalNode then
      self:SetActive(normalNode, false)
    end
    if extraNode then
      self:SetActive(extraNode, false)
    end
    return
  end
  local testForce = AbyssExtModel.TestForceRevivalMark
  local team = self.data.team
  local teamExtra = self.data.teamExtra
  local useRevivalNormal = testForce or team and team.isScoreValid == false or false == self.data.isValid or self.data.useRevivalNormal or false
  local useRevivalExtra = testForce or teamExtra and teamExtra.isScoreValid == false or false == self.data.isValidExtra or self.data.useRevivalExtra or false
  if normalNode then
    self:SetActive(normalNode, true == useRevivalNormal)
  end
  if extraNode then
    self:SetActive(extraNode, true == useRevivalExtra)
  end
end

function UICompAbyssGroupListItem:_RefreshBasicUI()
  local title = ""
  if self.isDataValid then
    local stageGroupName = CopyDataUtils.GetStageGroupName(self.data.stageGroupTid)
    title = LT.Text("AbyssChallengeTitle") .. " · " .. stageGroupName
  end
  self:SetText(self.ui.Text_Title, title)
  StrUtils.SetPreferedWidthFontSize(self.ui.Text_Title, nil, 420)
end

function UICompAbyssGroupListItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function UICompAbyssGroupListItem:_OnClick()
  if self.onClick then
    self.onClick()
  end
end

function UICompAbyssGroupListItem:_OnClickReset(isExtra)
  if not self.data.stageTid or self.data.stageTid <= 0 then
    return
  end
  local config = CopyDataUtils.GetStageConfig(self.data.stageTid)
  
  local function _OnReset()
    AbyssController.Instance:ReqResetAbyssChallenge(self.data.stageGroupTid, isExtra, function()
      Alert.ShowWithParams(10754, {
        LT.Text(config.Name)
      })
    end)
  end
  
  local stageGroupData = AbyssExtModel.Instance:GetStageGroupData(self.data.stageGroupTid)
  AbyssExtChallengeModel.Instance:UpdateData(stageGroupData)
  local tipsId = 20124
  if isExtra then
    tipsId = 20226
  else
    print("--------------is pass extra challenge ", self.data.stageTid)
    if AbyssExtChallengeModel.Instance:IsPassExtraChallenge(self.data.stageTid) then
      tipsId = 20227
    end
  end
  Alert.Show(tipsId, nil, _OnReset)
end

return UICompAbyssGroupListItem
