local Vector3 = CS.UnityEngine.Vector3
local BattleRoleBubbleUI, Super = System.NewComponent("BattleRoleBubbleUI")

function BattleRoleBubbleUI:ctor(rootNode, battleRole)
  Super.ctor(self)
  self.battleRole = battleRole
  self.roleUid = battleRole.uid
  self.roleData = bg.battleDataCenter:GetRoleDataModel(self.roleUid)
  self.bubbleRootNode = rootNode
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function BattleRoleBubbleUI:OnBind(binder)
  self.binder = binder
  self:OnBindBubble(binder, self.battleRole)
end

function BattleRoleBubbleUI:OnUnbind()
  Super.OnUnbind(self)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

function BattleRoleBubbleUI:OnBindBubble(binder, battleRole)
  binder:BindToRaw(function(_, v, o)
    self:ShowBubble(v)
  end, function()
    do return battleRole.GetBubbleInfo end
    return battleRole.GetBubbleInfo, battleRole
  end)
  binder:BindEvent(EventMgr.Instance.ShowAwakerBubble, System.fn(self, self.ShowAwakerVoiceBubble))
end

function BattleRoleBubbleUI:SetActive(isActive)
  if isActive and not self.showTipsSchedulerId then
    return
  end
  if self.bubbleItem then
    self.bubbleItem:SetActive(isActive, true)
  end
end

function BattleRoleBubbleUI:ShowBubble(data)
  if not data or data.tipsId == nil then
    if self.bubbleItem then
      self.bubbleItem:SetActive(false, true)
    end
    if self.showTipsSchedulerId then
      bg.battleRender:UnperformWithDelay(self.showTipsSchedulerId)
    end
    self.showTipsSchedulerId = nil
    return
  end
  local position = self.bubbleRootNode.transform.position
  local pos
  local config = self.battleRole.awakerList[1].configData
  if config.BodySize == "Big" then
    pos = Vector3(position.x - 5, position.y, position.z)
  elseif config.BodySize == "Huge" then
    pos = Vector3(position.x - 5, position.y - 0.8, position.z)
  else
    pos = Vector3(position.x, position.y + 3, position.z)
    if config.AnimationID == cd.SpecialMonsterAnim.Cat then
      pos = Vector3(position.x, position.y + 1, position.z)
    end
  end
  if self.showTipsSchedulerId then
    self.bubbleItem:SetActive(false, true)
    bg.battleRender:UnperformWithDelay(self.showTipsSchedulerId)
    self.showTipsSchedulerId = nil
  end
  if nil == self.bubbleItem then
    self.bubbleItem = self.binder:BindNewComponent(self.bubbleRootNode, MonsterBubbleItem, UI_Battle_Item_Monster_BubbleResource, data.tipsId, pos)
  end
  if nil ~= self.bubbleItem then
    self.bubbleItem:SetText(data.tipsId)
    local skipBubbleAnim = bg.battleDataCenter and bg.battleDataCenter:ShouldSkipEnterUIAnim()
    self.bubbleItem:SetActive(true, skipBubbleAnim)
  end
  self.showTipsSchedulerId = bg.battleRender:PerformWithDelay(data.showTime / 1000, function()
    self.bubbleItem:SetActive(false)
    self.showTipsSchedulerId = nil
    self.bubbleItem = nil
  end)
end

function BattleRoleBubbleUI:ShowAwakerVoiceBubble(content, duration, delay, awakerId)
  local position = self.bubbleRootNode.transform.position
  local pos = Vector3(position.x, position.y + 3, position.z)
  if self.battleRole.camp == bc.BattleCamp.Camp2 then
    return
  end
  local allRole = bg.battleScene:GetRoleListByCamp(bc.BattleCamp.Camp1)
  local speakAwakerIdx = 1
  for idx, data in pairs(allRole) do
    if data.tid == awakerId then
      speakAwakerIdx = idx
      break
    end
  end
  if self.bubbleItem == nil then
    self.bubbleItem = self.binder:BindNewComponent(self.bubbleRootNode, MonsterBubbleItem, UI_Battle_Item_Monster_BubbleResource, content, pos, speakAwakerIdx)
  end
  self.bubbleItem.ui.uiNode.transform.anchoredPosition3D = Vector3(-80, -80, 0)
  self.bubbleItem:SetActive(false, true)
  
  local function ShowVoice()
    if self.bubbleItem ~= nil then
      self.bubbleItem:SetText(content)
      self.bubbleItem:SetActive(true)
    end
    if 0 == duration then
      self.bubbleItem:SetActive(false, true)
    else
      self.binder:BindTimer(duration, 1, nil, function()
        self.bubbleItem:SetActive(false)
      end)
    end
  end
  
  if not delay then
    ShowVoice()
  else
    delay = delay and delay / 1000 or 1
    self.binder:BindTimer(delay, 1, nil, ShowVoice)
  end
end

return BattleRoleBubbleUI
