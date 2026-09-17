local this = class("modulePetSkillTips", G_UIModuleBase)
local petTpl = L_GameTpl:getPetTpl()
local SHORTCUT_AUDIO_EVENT = "Play_SFX_System_UI_General_Click"
local offsetBottomMobile = 7

function this.bind()
  return {
    list_capacity = {
      moduleName = "pages/pet/new/cellPetNewTipSkill"
    },
    active_switchSkillDetailShortCut = true,
    txt_switchSkillDetailShortCut = "",
    tog_detail = nil,
    go_showTab = false,
    tabList = {
      moduleName = "pages/pet/new/cellPetSkillTipsTab"
    },
    tabGroupSelectIndex = nil,
    go_moduleTagInfos = false,
    module_petSkillTagInfo = {
      moduleName = "pages/pet/new/modulePetSkillTagInfo"
    }
  }
end

function this.methods()
  return {
    onValueChanged_detail = function(self, isOn)
      if self.isToggleAnim then
        return
      end
      L_PetStore:setShowPetSkillDetail(isOn)
      self:showDetail(isOn)
      self:playToggleAnim()
      if isOn then
        self.bindComponents.RightSelectAnim:Play("anim_commonBtn_PressedON")
        self:setToggleAnim(true)
      else
        self.bindComponents.LeftSelectAnim:Play("anim_commonBtn_PressedOFF")
        self:setToggleAnim(true)
      end
    end,
    onSelectTab = function(self, id)
      self:onClickCellTab(id)
      self:playToggleAnim()
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.curIsBattleSkill = false
  if L_DeviceTpl:getIsPc() then
    offsetBottomMobile = 0
  end
end

function this:open()
  local showShortCut = L_DeviceTpl:getIsPc()
  self.bind.active_switchSkillDetailShortCut = showShortCut
  if showShortCut then
    local shortCutKeyStr = "E"
    self.bind.txt_switchSkillDetailShortCut = shortCutKeyStr
  end
  self:registerShortCut()
  local action = C_InputManager_KeyType.SwitchSkillTip and C_InputManager.GetAction(tostring(C_InputManager_KeyType.SwitchSkillTip))
  local shortCutStr = "Q"
  local tabListData = {
    {
      txt_name = L_WordsTpl:getValue("ui_kibo_info_text_1"),
      tabGroupId = 0,
      txt_shortCut = shortCutStr
    },
    {
      txt_name = L_WordsTpl:getValue("ui_kibo_info_text_2"),
      tabGroupId = 1,
      txt_shortCut = shortCutStr
    }
  }
  self.bind.tabList:clear()
  self.bind.tabList:insert_array(tabListData)
end

function this:close()
  self:unregisterShortCut()
  self.isEnable = false
  this.super.close(self)
end

function this:checkIsToggleAnim()
  return self.isToggleAnim
end

function this:setToggleAnim(isToggleAnim)
  self.isToggleAnim = isToggleAnim
  Timer.once(0.5, function()
    self.isToggleAnim = not isToggleAnim
  end, self, self.gameObject)
end

function this:resetToggleAnimState()
  if not self.bindComponents then
    return
  end
  local rightAnim = self.bindComponents.RightSelectAnim
  local leftAnim = self.bindComponents.LeftSelectAnim
  if not rightAnim or not leftAnim then
    return
  end
  rightAnim:Stop()
  leftAnim:Stop()
  if self.bind.tog_detail then
    rightAnim:Play("anim_commonBtn_PressedON")
    local state = rightAnim.get_Item and rightAnim:get_Item("anim_commonBtn_PressedON")
    if state then
      state.normalizedTime = 1
    end
    rightAnim:Sample()
    rightAnim:Stop()
  else
    leftAnim:Play("anim_commonBtn_PressedOFF")
    local state = leftAnim.get_Item and leftAnim:get_Item("anim_commonBtn_PressedOFF")
    if state then
      state.normalizedTime = 1
    end
    leftAnim:Sample()
    leftAnim:Stop()
  end
end

function this:SwitchSkillTip()
  if self.isToggleAnim then
    return
  end
  if not self.bind or not self.bind.active_switchSkillDetailShortCut then
    return
  end
  L_AudioUtil.playSound(SHORTCUT_AUDIO_EVENT)
  local isOn = not self.bind.tog_detail
  L_PetStore:setShowPetSkillDetail(isOn)
  self:showDetail(isOn)
  self.bind.tog_detail = isOn
  if isOn then
    self.bindComponents.RightSelectAnim:Play("anim_commonBtn_PressedON")
    self:setToggleAnim(true)
  else
    self.bindComponents.LeftSelectAnim:Play("anim_commonBtn_PressedOFF")
    self:setToggleAnim(true)
  end
  self:playToggleAnim()
end

function this:registerShortCut()
  L_ShortCutManager:registerShortCut("pagePetBox", C_InputManager_KeyType.SwitchSkillTip, function()
    if self.skillInfoOnly then
      return
    end
    L_AudioUtil.playSound(SHORTCUT_AUDIO_EVENT)
    self:switchSkillType(not self.curIsBattleSkill)
    self:updateCurSelectTab()
    self:playToggleAnim()
  end)
  L_ShortCutManager:registerShortCut("pagePetBox", C_InputManager_KeyType.SwitchSkillDetail, function()
    if not self.isKiboArena then
      self:SwitchSkillTip()
    end
  end)
  C_InputManager.SetGamepadUIInputMap("modulePetSkillTips", true)
  L_ShortCutManager:registerShortCut("modulePetSkillTips", C_InputManager_KeyType.EModulePetSkillTipsTogglePropertyDetail, function()
    if self.isToggleAnim then
      return
    end
    if not self.gameObject.activeInHierarchy then
      return
    end
    local isOn = not self.bind.tog_detail
    L_PetStore:setShowPetSkillDetail(isOn)
    self:showDetail(isOn)
    self.bind.tog_detail = isOn
    if isOn then
      self.bindComponents.RightSelectAnim:Play("anim_commonBtn_PressedON")
      self:setToggleAnim(true)
    else
      self.bindComponents.LeftSelectAnim:Play("anim_commonBtn_PressedOFF")
      self:setToggleAnim(true)
    end
    self:playToggleAnim()
  end)
end

function this:unregisterShortCut()
  L_ShortCutManager:unregisterShortCut("pagePetBox", C_InputManager_KeyType.SwitchSkillTip)
  L_ShortCutManager:unregisterShortCut("pagePetBox", C_InputManager_KeyType.SwitchSkillDetail)
  C_InputManager.SetGamepadUIInputMap("modulePetSkillTips", false)
  L_ShortCutManager:unregisterShortCut("modulePetSkillTips", C_InputManager_KeyType.EModulePetSkillTipsTogglePropertyDetail)
end

function this:buildModuleList(listData, pet, skillInfoOnly, isDue)
  self.skillInfoOnly = skillInfoOnly or false
  self.skillInfoOnlyAndDue = skillInfoOnly and isDue or false
  self.isKiboArena = isDue
  self.curListData = listData
  self:InternalSetDatas(pet)
end

function this:Init(data)
  self.skillInfoOnly = data.skillInfoOnly or false
  self.skillInfoOnlyAndDue = self.skillInfoOnly and data.isDue or false
  self.curListData = data.skillData
  self:InternalSetDatas(data.pet)
end

function this:InternalSetDatas(petInfo)
  self.curKiboDuelListData = self:getKiboDuelSkillListData(petInfo)
  if self.skillInfoOnly then
    self.curIsBattleSkill = self.skillInfoOnlyAndDue or false
  end
  self:refreshTagInfos(petInfo)
  self:setSkillInfos()
  self:updateCurSelectTab()
  self.bind.tog_detail = L_PetStore:isShowPetSkillDetail()
  if self.bind.tog_detail == true then
    self:showDetail(true)
  end
  self:resetToggleAnimState()
end

function this:switchSkillType(_curIsBattleSkill)
  self.curIsBattleSkill = _curIsBattleSkill
  if not self.curListData then
    return
  end
  self:updateTagInfoShowState()
  self:setSkillInfos(true)
end

function this:fixListData()
  if self.curIsBattleSkill then
    return self.curKiboDuelListData or {}
  end
  return self.curListData or {}
end

function this:refreshModule(listData)
  self.curListData = listData
  self.curKiboDuelListData = self:getKiboDuelSkillListData(self.pet)
  self:setSkillInfos()
end

function this:getKiboDuelSkillListData(petInfo)
  if not petInfo then
    return {}
  end
  local list = L_PetStore:getPetKiboDuelSkills(petInfo)
  local data = {}
  for _, v in ipairs(list) do
    table.insert(data, {kiboInfo = v})
  end
  return data
end

function this:setSkillInfos(resetContentPos)
  local temp = self:fixListData()
  self.bind.list_capacity:clear()
  self.bind.list_capacity:insert_array(temp)
  local isShowDetail = L_PetStore:isShowPetSkillDetail()
  self:showDetail(isShowDetail, resetContentPos)
end

function this:refreshLayout()
  if not self.bindComponents then
    return
  end
  self:UpdateContainerVerticalLayout(self.bindComponents.rect)
end

function this:UpdateContainerVerticalLayout(rect, resetContentPos)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rect)
  local height = rect:GetComponent("VerticalLayoutGroup").preferredHeight
  rect:SetSizeWithCurrentAnchors(1, height)
  local curHeight = height
  local maxHeight, scrollPartHeight
  local isShowingTagInfos = self.bind.go_moduleTagInfos
  if not isShowingTagInfos then
    maxHeight = 710
    scrollPartHeight = math.min(curHeight, maxHeight)
  else
    local tagInfoDefaultHeight = self.modules.module_petSkillTagInfo:getDefaultShowHeight()
    local tagInfoCurHeight = self.modules.module_petSkillTagInfo:getCurShowHeight(true)
    maxHeight = math.min(660, curHeight) + tagInfoDefaultHeight - tagInfoCurHeight
    scrollPartHeight = math.min(curHeight, maxHeight)
  end
  self.bindComponents.layoutElement_scrollList.preferredHeight = scrollPartHeight
  if resetContentPos then
    self.bindComponents.rect:SetAnchoredPosition(self.bindComponents.rect.anchoredPosition.x, 0)
  end
  if self.bindComponents.scrollView then
    local enableScroll = curHeight > maxHeight
    self.bindComponents.scrollView.enabled = enableScroll
    if not enableScroll then
      self.bindComponents.rect:SetAnchoredPosition(self.bindComponents.rect.anchoredPosition.x, 0)
    end
  end
end

function this:showDetail(isOn, resetContentPos)
  for i, v in pairs(self.modules.list_capacity) do
    v:showDetail(isOn)
  end
  self:UpdateContainerVerticalLayout(self.bindComponents.rect, resetContentPos)
  self:refreshSizeDeltaWithTipBubble()
end

function this:refreshSizeDeltaWithTipBubble()
  if self.parent and self.parent.SetImageContentSizeAndPivot then
    self.parent:SetImageContentSizeAndPivot(self.bindComponents.rect_module, C_Vector2(0.5, 0))
  end
end

function this:updateCurSelectTab()
  if self.skillInfoOnly then
    self.bind.go_showTab = false
    return
  else
    self.bind.go_showTab = true
  end
  local index = self.curIsBattleSkill and 1 or 0
  self.bind.tabGroupSelectIndex = index
  self:refreshTabState()
end

function this:onClickCellTab(tabId)
  local isBattleSkill = tabId == 1
  self:switchSkillType(isBattleSkill)
  self:refreshTabState()
end

function this:refreshTabState()
  for _, tabItem in pairs(self.modules.tabList) do
    local show = not self.curIsBattleSkill and tabItem.bind.tabGroupId == 0 or self.curIsBattleSkill and tabItem.bind.tabGroupId == 1
    tabItem:refreshState(show)
  end
end

function this:SetParentScript(parentScript)
  self.parentScript = parentScript
end

function this:playToggleAnim()
end

function this:refreshTagInfos(pet)
  self.pet = pet
  self:updateTagInfoShowState()
  if self.skillInfoOnly then
    return
  end
  if self.bindComponents.isDotShowTag == nil then
    return
  end
  local petId = pet.id
  local tpl = petTpl:getTplById(petId)
  local tags = petTpl:getKiboDuelTag(tpl)
  local data = {}
  for _, id in ipairs(tags) do
    table.insert(data, {tagId = id})
  end
  if not self.tagInfoSwtichShowHandle then
    self.tagInfoSwtichShowHandle = handler(self, self.tagSwitchShowCallback)
  end
  self.modules.module_petSkillTagInfo:setSwitchShowCallback(self.tagInfoSwtichShowHandle)
  self.modules.module_petSkillTagInfo:refreshTagList(self.pet)
  self:refreshSizeDeltaWithTipBubble()
end

function this:updateTagInfoShowState()
  local notShowTagInfo = self.skillInfoOnly or not self.curIsBattleSkill
  self.bind.go_moduleTagInfos = not notShowTagInfo
end

function this:tagSwitchShowCallback(isShow)
  self:UpdateContainerVerticalLayout(self.bindComponents.rect, true)
  self:refreshSizeDeltaWithTipBubble()
end

return this
