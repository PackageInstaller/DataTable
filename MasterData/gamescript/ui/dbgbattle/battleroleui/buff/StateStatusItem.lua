local fadeCom = typeof(CS.Z1Client.EffectFadeAction)
local StateStatusItem, Super = System.NewComponent("StateStatusItem")
StateStatusItem.width = 50
StateStatusItem.height = 50
local Animator = CS.UnityEngine.Animator
local DisappearStateHash = Animator.StringToHash("Base Layer.UA_Buff_tubiao_xiaoshi")

function StateStatusItem:ctor(uiNode, role, state, isShowLayer, onClick)
  Super.ctor(self)
  self.ui = Item_Battle_BuffResource(uiNode)
  self.role = role
  self.state = state
  self.layer = 0
  self.isShowLayer = isShowLayer
  self.onClick = onClick
  self.playedVFXIds = nil
end

function StateStatusItem:OnBind(binder)
  self.binder = binder
  self.rootRectTransorm = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.RectTransform))
  self.animationController = self.ui.E_se_buff_tubiao:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  local isVisible = self:CheckVisible()
  self.ui.uiNode:SetActive(isVisible)
  if isVisible then
    binder:BindToImage(self.ui.Image_Buff_Icon, function()
      if self.state.configData.Icon then
        return bc.ICON_PATH_PERFIX .. self.state.configData.Icon
      end
    end)
    binder:BindToImage(self.ui.Image, function()
      if self.state.configData.Icon then
        return bc.ICON_PATH_PERFIX .. self.state.configData.Icon
      end
    end)
    binder:BindToVisible(self.ui.Image_Icon_SubIcon, function()
      return self.state.configData.SubIcon
    end)
    binder:BindToImage(self.ui.Image_Icon_SubIcon, function()
      if self.state.configData.SubIcon then
        return bc.ICON_PATH_PERFIX .. self.state.configData.SubIcon
      end
    end)
    binder:BindButtonClick(self.ui.Btn_Buff, function()
      if self.onClick ~= nil then
        self.onClick(self)
      end
    end)
    self:UpdateState(self.state)
    self:PlayOpenAnim()
  end
  self:InitStateMaterialEffect()
  self:InitUniqStateEffect()
end

function StateStatusItem:CheckVisible()
  return self.state.configData.ShowType ~= bc.StateShowType.Hide
end

function StateStatusItem:_StateLayer()
  return self.state.layer or 0
end

function StateStatusItem:UpdateState(state)
  if state then
    self.state = state
  end
  local layer = self:_StateLayer()
  if self.layer == layer then
    return
  end
  self.layer = layer
  self:UpdateStateVFX()
  self.ui.Dbg_Image_Buff_Tips:SetActive(self.isShowLayer and 0 ~= layer)
  self.binder:SetText(self.ui.Dbg_Text_Buff_Tips, bc.NumberToCompact(layer))
  self.ui.Dbg_Text_Buff_Tips:SetActive(layer > 0)
  if bg.isPVP and layer > 0 then
    local color = StateDataUtils.GetPvpStatusLayerColor(self.state.configData)
    if color then
      self.binder:SetTextColorByHtml(self.ui.Dbg_Text_Buff_Tips, color)
    end
  end
  if not bg.battleDataCenter or not bg.battleDataCenter:ShouldSkipEnterUIAnim() then
    self.animationController:PlayState("Item_Battle_Buff_Work", nil)
  end
end

function StateStatusItem:SwitchActive(gameObj, isActive)
  gameObj:SetActive(not isActive)
  gameObj:SetActive(isActive)
end

function StateStatusItem:OnDisappearComplete(hash)
  if hash == DisappearStateHash then
    self.binder:teardown()
  end
end

function StateStatusItem:SetBuffActive(active)
  self.ui.uiNode:SetActive(active)
end

function StateStatusItem:SetPosition(pos)
  pos.x = pos.x + StateStatusItem.width
  self.ui.uiNode.transform.anchoredPosition = pos
end

function StateStatusItem:UpdateStateVFX()
  local stateId = self.state.stateId
  local stateLayer = self:_StateLayer()
  local sfxList = SkillPerformUtils.GetStateVFXList(stateId, stateLayer)
  self:StopExcludeVFX(sfxList)
  self.stateSfxList = self.stateSfxList or {}
  for _, sfxId in ipairs(sfxList) do
    if self:IsVFXPlaying(sfxId) then
    else
      local ownUid = self.state.ownerUid
      if ownUid == self.role.uid then
        local roleSfxList = self.role:PlayStateSfx(sfxId)
        for _, sfx in ipairs(roleSfxList) do
          table.insert(self.stateSfxList, sfx)
          local com = sfx.rootNode and sfx.rootNode:GetComponent(fadeCom) or nil
          if com then
            com:FadeIn()
          end
        end
      else
        self.stateSfxList = {}
        for _, awaker in ipairs(self.role.awakerList) do
          if awaker.uid == ownUid then
            local sfx = awaker:PlaySfx(sfxId)
            if sfx then
              table.insert(self.stateSfxList, sfx)
              local com = sfx.rootNode and sfx.rootNode:GetComponent(fadeCom) or nil
              if com then
                com:FadeIn()
              end
            end
          end
        end
      end
    end
  end
end

function StateStatusItem:InitStateMaterialEffect()
  local stateId = self.state.stateId
  local materialEffect = DT.State[stateId].MaterialEffect
  local effectlist = DT.GetOriginalConstant(materialEffect)
  if nil == effectlist then
    return
  end
  self.role:PlayMaterialEffect(effectlist)
end

function StateStatusItem:ClearMatEffect()
  local stateId = self.state.stateId
  local materialEffect = DT.State[stateId].MaterialEffect
  local effectlist = DT.GetOriginalConstant(materialEffect)
  if nil == effectlist then
    return
  end
  self.role:ClearMaterialEffect(effectlist)
end

function StateStatusItem:InitUniqStateEffect()
  local uniqList = bg.DT.GetOriginalConstant("Awaker_EX_24_2", {})
  if self.state.stateId == uniqList[1] then
    local ownerUid = self.state.ownerUid
    local awakerClient = bg.battleScene:GetAwakerByUid(ownerUid)
    if awakerClient then
      awakerClient:Set24ShaderSwitch(true)
      self.binder:onDestroy(function()
        awakerClient:Set24ShaderSwitch(false)
      end)
    end
  end
end

function StateStatusItem:OnUnbind()
  self:PlayCloseAnim()
  self:ClearVFX()
  self:ClearMatEffect()
end

function StateStatusItem:IsVFXPlaying(sfxId)
  if not self.stateSfxList then
    return
  end
  for _, v in ipairs(self.stateSfxList) do
    if v.sfxId == sfxId then
      return true
    end
  end
end

function StateStatusItem:StopExcludeVFX(sfxList)
  if not self.stateSfxList then
    return
  end
  local i = 1
  while i <= #self.stateSfxList do
    local sfx = self.stateSfxList[i]
    local isIncluded = false
    for j = 1, #sfxList do
      if sfxList[j] == sfx.sfxId then
        isIncluded = true
        break
      end
    end
    if isIncluded then
      i = i + 1
    else
      self:StopVfx(sfx)
      table.remove(self.stateSfxList, i)
    end
  end
end

function StateStatusItem:StopVfx(sfxObj)
  if not sfxObj or not sfxObj.rootNode then
    return
  end
  local sfxMgr = bg.battleRender.sfxMgr
  
  local function free()
    sfxMgr:FreeSfx(sfxObj)
  end
  
  local com = sfxObj.rootNode:GetComponent(fadeCom)
  if com then
    com:FadeOut(free)
  else
    free()
  end
end

function StateStatusItem:ClearVFX()
  if self.stateSfxList then
    for _, v in ipairs(self.stateSfxList) do
      self:StopVfx(v)
    end
    self.stateSfxList = nil
  end
end

function StateStatusItem:PlayCloseAnim(callback)
  self.animationController:PlayState("Item_Battle_Buff_Close", callback)
end

function StateStatusItem:PlayOpenAnim()
  if bg.battleDataCenter and bg.battleDataCenter:ShouldSkipEnterUIAnim() then
    return
  end
  self.animationController:PlayState("Item_Battle_Buff_Open", nil)
end

return StateStatusItem
