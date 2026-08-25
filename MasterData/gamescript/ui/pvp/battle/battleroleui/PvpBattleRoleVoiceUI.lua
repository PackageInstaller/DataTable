local BgMaxHeight = 156
local textViewHeight = 126
local BgMinHeight = 70
local Bg2TextMargin = 30
local PvpBattleRoleVoiceUI, Super = System.NewComponent("PvpBattleRoleVoiceUI")

function PvpBattleRoleVoiceUI:ctor(uiNode, viewData)
  Super.ctor(self)
  self.ui = UI_Pvp_AwakerVoiceResource(uiNode)
  self.rootNode = viewData.rootNode
  self.content = viewData.content
  self.battleRole = viewData.battleRole
end

function PvpBattleRoleVoiceUI:OnBind(binder)
  self.binder = binder
  self:_RefreshContent(self.content)
  self:_RefreshUiNodeHeight()
  self:_RefreshUiNodePos()
end

function PvpBattleRoleVoiceUI:SetContent(content)
  self.content = content
  self:_RefreshContent()
  self:_RefreshUiNodeHeight()
end

function PvpBattleRoleVoiceUI:_RefreshContent()
  self.binder:SetText(self.ui.Text_Voice, self.content)
end

function PvpBattleRoleVoiceUI:_RefreshUiNodeHeight()
  local textHeight = self:_GetTextHeight()
  local targetBgHeight = textHeight + Bg2TextMargin
  if targetBgHeight > BgMaxHeight then
    textHeight = textViewHeight
    targetBgHeight = BgMaxHeight
  end
  CS.Framework.TransformUtil.SetHeight(self.ui.VoiceView.transform, textHeight)
  CS.Framework.TransformUtil.SetHeight(self.ui.Group_Bg.transform, targetBgHeight)
  AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Voice, 0, 0, 0, nil, true, true)
end

function PvpBattleRoleVoiceUI:_RefreshUiNodePos()
  local posX, posY = self:_GetUiNodePosByBattleRole()
  CS.Framework.TransformUtil.SetLocalPos(self.ui.uiNode.transform, posX, posY, 0)
end

local CampPlayerFieldPos2PosDict = {
  [1] = {x = -18, y = -43},
  [2] = {x = -18, y = -43},
  [3] = {x = -18, y = -43},
  [4] = {x = -18, y = -43}
}
local CampEnemyBattleFieldPos2PosDict = {
  [1] = {x = -12, y = -50},
  [2] = {x = -12, y = -50},
  [3] = {x = -12, y = -50},
  [4] = {x = -12, y = -50}
}

function PvpBattleRoleVoiceUI:_GetUiNodePosByBattleRole()
  local battleFieldPos = self.battleRole.battleFieldPos
  local targetPos = self.battleRole.camp == bg.battleDataCenter:GetMyCamp() and CampPlayerFieldPos2PosDict[battleFieldPos] or CampEnemyBattleFieldPos2PosDict[battleFieldPos]
  return targetPos.x, targetPos.y
end

function PvpBattleRoleVoiceUI:_GetTextHeight()
  do return StrUtils.SetPreferredHeight end
  return StrUtils.SetPreferredHeight, self.ui.Text_Voice
end

function PvpBattleRoleVoiceUI:Hide()
  self.ui.uiNode:SetActive(false)
end

function PvpBattleRoleVoiceUI:Show()
  self.ui.uiNode:SetActive(true)
end

return PvpBattleRoleVoiceUI
