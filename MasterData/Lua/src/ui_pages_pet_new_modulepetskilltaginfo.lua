local this = class("modulePetSkillTagInfo", G_UIModuleBase)
local petTpl = L_GameTpl:getPetTpl()
local SHORTCUT_AUDIO_EVENT = "Play_SFX_System_UI_General_Click"

function this.bind()
  return {
    txt_tipTitle = "",
    go_tagInfoShow = false,
    go_tagInfoHide = false,
    list_hideTags = {
      moduleName = "pages/petDuel/cellKiBoDuelTag"
    },
    list_showTags = {
      moduleName = "pages/petDuel/cellPetDuel_tagTipItem"
    },
    active_tagInfoShortCut1 = true,
    active_tagInfoShortCut2 = true
  }
end

function this.methods()
  return {
    onClickTagShow = function(self)
      if self.onClickCallback then
        self.onClickCallback()
        return
      end
      self:swtichShowTagState(true)
      self:playToggleAnim()
    end,
    onClickTagHide = function(self)
      self:swtichShowTagState(false)
      self:playToggleAnim()
    end
  }
end

function this:open()
  local isPc = L_DeviceTpl:getIsPc()
  self.bind.active_tagInfoShortCut1 = isPc
  self.bind.active_tagInfoShortCut2 = isPc
  self.bind.txt_tipTitle = L_WordsTpl:getValue("ui_kibo_info_text_3")
  local action = C_InputManager_KeyType.SwitchPetTagTip and C_InputManager.GetAction(tostring(C_InputManager_KeyType.SwitchPetTagTip))
  L_ShortCutManager:registerShortCut("pagePetBox", C_InputManager_KeyType.SwitchPetTagTip, function()
    if self.isKiboDuelFormation then
      return
    end
    L_AudioUtil.playSound(SHORTCUT_AUDIO_EVENT)
    self:swtichShowTagState()
    self:playToggleAnim()
  end)
end

function this:close()
  L_ShortCutManager:unregisterShortCut("pagePetBox", C_InputManager_KeyType.SwitchPetTagTip)
end

function this:setSwitchShowCallback(callback)
  self.switchShowCallBack = callback
end

function this:setClickCallback(callback)
  self.onClickCallback = callback
end

function this:getCurShowHeight(forceRebuild)
  if forceRebuild then
    C_Canvas.ForceUpdateCanvases()
    Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.rect)
  end
  return self.bindComponents.rect.rect.height
end

function this:getDefaultShowHeight()
  if self.defaultHeight == nil and self.bindComponents ~= nil then
    self.defaultHeight = self.bindComponents.hideLayoutElement.preferredHeight
  end
  return self.defaultHeight or 0
end

function this:refreshTagList(pet)
  self.pet = pet
  local petId = pet.id
  local tpl = petTpl:getTplById(petId)
  local tags = petTpl:getKiboDuelTag(tpl)
  local data = {}
  for _, id in ipairs(tags) do
    table.insert(data, {tagId = id})
  end
  self.bind.list_hideTags:clear()
  self.bind.list_hideTags:insert_array(data)
  self.bind.list_showTags:clear()
  self.bind.list_showTags:insert_array(data)
  self.showTagDetail = false
  self:updateShowState()
end

function this:swtichShowTagState()
  self.showTagDetail = not self.showTagDetail and true
  self:updateShowState()
  if self.switchShowCallBack then
    self.switchShowCallBack(self.showTagDetail)
  end
end

function this:HideTagInfoShow()
  if self.showTagDetail == true then
    self.showTagDetail = not self.showTagDetail and true
    self:updateShowState()
  end
end

function this:playToggleAnim()
  if self.parent and self.parent.playToggleAnim then
    self.parent:playToggleAnim()
  end
end

function this:setKiboFormationState()
  self.isKiboDuelFormation = true
end

function this:updateShowState()
  self.bind.go_tagInfoShow = self.showTagDetail
  self.bind.go_tagInfoHide = not self.showTagDetail
end

return this
