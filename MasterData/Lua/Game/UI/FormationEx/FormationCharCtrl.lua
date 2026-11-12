local FormationCharCtrl = class("FormationCharCtrl", BaseCtrl)
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResType = GameResourceLoader.ResType
FormationCharCtrl._mapNodeConfig = {
  trParent = {sComponentName = "Transform"},
  rtInfo = {
    sCtrlName = "Game.UI.TemplateEx.TemplateCharInfoCtrl"
  },
  btnSelect = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Select"
  },
  btnAdd = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SelectAdd"
  },
  btnAddAnim = {sNodeName = "btnAdd", sComponentName = "Animator"},
  Animator = {sNodeName = "rtInfo", sComponentName = "Animator"},
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  btnDown = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Down"
  },
  rtBtnDownParent = {},
  txtBtnDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Formation_Btn_Info"
  },
  fxChange = {},
  goArrow = {},
  txtLeader = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Leader"
  },
  txtSub = {sComponentName = "TMP_Text", sLanguageId = "Build_Sub"},
  AnimationRoot = {sComponentName = "Animator"},
  eventDrag = {
    sNodeName = "btnSelect",
    sComponentName = "UIDrag",
    callback = "OnUIDrag_Drag"
  },
  txtBtnEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainlineFormationDisc_HintEmpty"
  }
}
FormationCharCtrl._mapEventConfig = {
  Guide_FormationChar_OpenList = "OnEvent_FormationChar_OpenList"
}

function FormationCharCtrl:OnRender(tbTeamMemberId, index, bTrialLevel, nDirection)
  self.mIndex = index
  self.bTrialLevel = bTrialLevel
  self.tbTeamId = tbTeamMemberId
  local nCharId = tbTeamMemberId[index]
  self._mapNode.btnDetail.gameObject:SetActive(not self.bTrialLevel and 0 < nCharId)
  self._mapNode.AnimationRoot.enabled = 0 < nCharId
  if 0 < nCharId then
    local mapCharCfgData, mapCharData
    if bTrialLevel then
      mapCharData = PlayerData.Char:GetTrialCharById(nCharId)
      mapCharCfgData = ConfigTable.GetData_Character(mapCharData.nId)
    else
      mapCharData = PlayerData.Char:GetCharDataByTid(nCharId)
      mapCharCfgData = ConfigTable.GetData_Character(nCharId)
    end
    self._mapNode.rtInfo:Refresh(mapCharData, mapCharCfgData)
  end
  if 0 < nCharId then
    if nDirection ~= nil then
      local sStateName = nDirection == 1 and "rtInfo_left" or "rtInfo_right"
      self._mapNode.Animator:Play(sStateName)
    elseif self.nCharId ~= nCharId and self.nCharId ~= nil then
      self._mapNode.Animator:Play("rtInfo_up")
    end
    self._mapNode.btnAdd.gameObject:SetActive(false)
    self._mapNode.btnDown.gameObject:SetActive(true)
  else
    self._mapNode.btnDown.gameObject:SetActive(false)
    self._mapNode.btnAdd.gameObject:SetActive(not bTrialLevel)
    if self.nCharId ~= nil and nDirection == nil and self.nCharId ~= 0 then
      self._mapNode.Animator:Play("rtInfo_down")
      self._mapNode.btnAddAnim:Play("btnAdd_in")
    else
      self._mapNode.Animator:Play("rtInfo_hide")
    end
  end
  self.nCharId = nCharId
end

function FormationCharCtrl:PlayChangeFx()
  GameUIUtils.RestartParticle(self._mapNode.fxChange)
end

function FormationCharCtrl:SetSelectedChar(rtSelectedChar)
  self.rtSelectedChar = rtSelectedChar
end

function FormationCharCtrl:OnEnable()
  self.mActive = true
  self._mapNode.btnDown.gameObject:SetActive(false)
end

function FormationCharCtrl:OnDisable()
  self.mActive = false
end

function FormationCharCtrl:OnBtnClick_Select(btn)
  if not self.bTrialLevel then
    if btn.Operate_Type == 0 then
      EventManager.Hit("OnEvent_OpenSelectTeamMemberList", self.mIndex)
    end
  else
    local sTip = ConfigTable.GetUIText("RegionBoss_Member_CannotBeChanged")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
  end
end

function FormationCharCtrl:SetItemPos(dragPos)
  local localPos = GameUIUtils.ScreenPointToLocalPointInRectangle(dragPos, self.rtSelectedChar.parent.transform)
  self.rtSelectedChar.localPosition = Vector3(localPos.x, self.rtSelectedChar.anchoredPosition.y, 0)
end

function FormationCharCtrl:OnUIDrag_Drag(mDrag)
  if mDrag.DragEventType == AllEnum.UIDragType.DragStart then
    EventManager.Hit("OnEvent_OpenSwapTeamMember", self.mIndex)
    self:SetItemPos(mDrag.EventData.position)
  elseif mDrag.DragEventType == AllEnum.UIDragType.Drag then
    self:SetItemPos(mDrag.EventData.position)
  elseif mDrag.DragEventType == AllEnum.UIDragType.DragEnd then
    EventManager.Hit("CloseSwap")
  end
end

function FormationCharCtrl:OnBtnClick_SelectAdd(btn)
  if not self.bTrialLevel then
    EventManager.Hit("OnEvent_OpenSelectTeamMemberList", self.mIndex)
  else
    local sTip = ConfigTable.GetUIText("RegionBoss_Member_CannotBeChanged")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
  end
end

function FormationCharCtrl:SetArrowShow(bShow)
  self._mapNode.goArrow:SetActive(bShow)
end

function FormationCharCtrl:OnBtnClick_Detail(btn)
  if not self.bTrialLevel then
    local tbChar = {}
    for _, v in pairs(self.tbTeamId) do
      if v ~= 0 then
        table.insert(tbChar, v)
      end
    end
    EventManager.Hit(EventId.OpenPanel, PanelId.CharBgPanel, PanelId.CharInfo, self.nCharId, tbChar, false)
  end
end

function FormationCharCtrl:OnBtnClick_Down()
  EventManager.Hit("ForamtionDown", self.mIndex)
end

function FormationCharCtrl:OpenList(bOpen)
  self._mapNode.btnSelect.gameObject:SetActive(not bOpen)
  self._mapNode.rtBtnDownParent:SetActive(bOpen)
  self._mapNode.btnAdd.enabled = not bOpen
end

function FormationCharCtrl:OnEvent_FormationChar_OpenList(index, bOpen)
  if index == self.mIndex then
    self._mapNode.btnSelect.enabled = bOpen
    self._mapNode.btnAdd.enabled = bOpen
  end
end

return FormationCharCtrl
