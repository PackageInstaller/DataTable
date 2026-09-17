local this = class("moduleBattleDialog", G_UIModuleBase)
local _heroTpl = L_GameTpl:getHeroTpl()
local _enemyTpl = L_GameTpl:getEnemyTpl()
local _petTpl = L_GameTpl:getPetTpl()
local _dialogBattleTpl = L_GameTpl:getDialogueBattleTpl()
local _battleMessageTpl = L_GameTpl:getBattleMessageTpl()
local _charVoiceWordBattleTpl = L_GameTpl:getCharVoiceWordsBattleTpl()
local _charVoiceWordPetTpl = L_GameTpl:getCharVoiceWordsPetTpl()
local _battleMessageUnitruleTpl = L_GameTpl:getBattleMessageUnitruleTpl()
local _prefabNames = {
  empty = "emptyprefab",
  LeftAvatar = "LeftAvatarprefab",
  LeftNoAvatar = "LeftNoAvatarprefab",
  RightAvatar = "RightAvatarprefab",
  RightNoAvatar = "RightNoAvatarprefab"
}
local colorStyle = {
  normal = "FFFFFF",
  hero = "FFCA11",
  boss = "B07373"
}

function this.bind()
  return {contentPos = nil, activeContent = nil}
end

function this.methods()
  return {}
end

function this:created(...)
  this.super.created(self, ...)
end

function this:open()
  this.super.open(self)
  self.data = {
    dialogIndexDic = {}
  }
  self.showDialog = handler(self, self.showNormalDialog)
  self.dialogEnd = handler(self, self.allDialogsEnd)
  C_AliveVoiceManager.AddVoiceUnitRuleListener(self.showDialog)
  self.showSpDialog = handler(self, self.showBattleSpacialDialog)
  C_AliveVoiceManager.AddVoiceListener(self.showSpDialog)
  self._onEvent_storyStartHandle = handler(self, self.onEvent_storyStartHandle)
  C_StoryEvent.instance:Listen(C_EStoryEvent.StoryStart, self._onEvent_storyStartHandle)
  C_AliveVoiceManager.AddVoiceAllStopListener(self._onEvent_storyStartHandle)
  self.bindComponents.dialogTween.allDialogsEnd = self.dialogEnd
  self.photoCache = nil
  local curModule = L_WorldManager:getCurModule()
  if curModule == L_Const.worldModule.multiDungeon then
    local equipment = L_DeviceTpl:getEquipment()
    if equipment == L_Const.equipment.pc then
      self.bind.contentPos = C_Vector2(20, -160)
    else
      self.bind.contentPos = C_Vector2(124, -200)
    end
  end
  print(tostring(curModule))
  print(curModule == L_Const.worldModule.multiDungeon)
end

function this:close()
  self.bindComponents.dialogTween:Clear()
  if self.photoCache then
    L_PhotoManager:releaseHead(self.photoCache)
    self.photoCache = nil
  end
  C_AliveVoiceManager.RemoveVoiceUnitRuleListener(self.showDialog)
  C_AliveVoiceManager.RemoveVoiceListener(self.showSpDialog)
  if self._onEvent_storyStartHandle ~= nil then
    C_StoryEvent.instance:Cancel(C_EStoryEvent.StoryStart, self._onEvent_storyStartHandle)
    C_AliveVoiceManager.RemoveVoiceAllStopListener(self._onEvent_storyStartHandle)
    self._onEvent_storyStartHandle = nil
  end
  if self.dialogEnd then
    self.bindComponents.dialogTween.allDialogsEnd = nil
    self.dialogEnd = nil
  end
end

function this:onEvent_storyStartHandle()
  printf("剧情开始, 需要阻断当前正在播放的战斗左插")
  self.bindComponents.dialogTween:Clear()
end

function this:_createPre(type)
  if type == _prefabNames.empty then
    return
  end
  self.bind.activeContent = true
  local item = {}
  item.go = self.bindComponents.dialogTween:AddDialog(type)
  local name = item.go.transform:Find("MovementRoot/AvartarRoot/Name")
  item.txt_name = name:GetComponent(typeof(C_LTextMeshProUGUI))
  local txtGo = item.go.transform:Find("MovementRoot/ContentRoot/animroot/txtPro_content")
  item.txt_content = txtGo:GetComponent(typeof(C_LTextMeshProUGUI))
  local imageData = item.go.transform:Find("MovementRoot/AvartarRoot/animroot/img_mask/LeftAvatar")
  item.img_head = imageData:GetComponent(typeof(C_LImage))
  return item
end

function this:showNormalDialog(guid, typeId, tagID, content)
  if AzurWorld.StoryMgr.IsPlaying or AzurWorld.FreedomDialogMgr:IsPlayFreedom() then
    printf("剧情播放中, 不播放战斗左插")
    return
  end
  local unitTpl = _battleMessageUnitruleTpl:getTplById(typeId)
  local ruleType = _battleMessageUnitruleTpl:getRuleType(unitTpl)
  if ruleType == 1 then
    self:showHeroNormalDialog(guid, typeId, tagID, content)
  elseif ruleType == 2 then
    self:showPetNormalDialog(guid, typeId, tagID, content)
  end
end

function this:showPetNormalDialog(guid, typeId, tagID, content)
  local petItem = L_PetStore:getPetItem(guid)
  if petItem == nil then
    return
  end
  local petConfigId = petItem.id
  local unitTpl = _battleMessageUnitruleTpl:getTplById(typeId)
  local chartpl = _charVoiceWordPetTpl:getTplById(petConfigId)
  if chartpl == nil then
    return
  end
  local key = _battleMessageUnitruleTpl:getMessageTag(unitTpl)
  local item = {}
  if string.isEmpty(content) then
    item.txt_content = _charVoiceWordPetTpl:getTagValue(chartpl, key[tagID])
  else
    item.txt_content = content
  end
  if string.isEmpty(item.txt_content) then
    return
  end
  local petItem = L_PetStore:getPetItem(guid)
  local isSpecialPet = false
  if petItem ~= nil then
    isSpecialPet = petItem:isSpecialPet()
  end
  item.img_head = _petTpl:getPetTalkIcon(_petTpl:getTplById(petConfigId), isSpecialPet)
  item.delayTime = _battleMessageUnitruleTpl:getMessageTime(unitTpl)
  item.identify = _prefabNames.LeftAvatar
  item.moduleName = "pages/battle/cellBattleDialog"
  self:insertArray(item)
end

function this:showHeroNormalDialog(guid, typeId, tagID, content)
  local heroData = L_HeroStore:getHero(guid)
  if heroData == nil then
    return
  end
  local heroId = heroData.configId
  local unitTpl = _battleMessageUnitruleTpl:getTplById(typeId)
  local chartpl = _charVoiceWordBattleTpl:getTplById(heroId)
  if chartpl == nil then
    return
  end
  if heroId == nil then
    return
  end
  local key = _battleMessageUnitruleTpl:getMessageTag(unitTpl)
  local item = {}
  item.txtColor_name = colorStyle.hero
  if heroId == L_GameUtil.getDefaultHeroId() then
    item.txt_name = L_PlayerStore:getPlayerName()
  else
    item.txt_name = _charVoiceWordBattleTpl:getName(chartpl)
  end
  if string.isEmpty(content) then
    item.txt_content = _charVoiceWordPetTpl:getTagValue(chartpl, key[tagID])
  else
    item.txt_content = content
  end
  if string.isEmpty(item.txt_content) then
    return
  end
  item.img_head = L_GameUtil.getAvatarTexturePath(heroId, L_Const.resourceIndexOfAvatarTextureInHeroTpl.mid)
  item.delayTime = _battleMessageUnitruleTpl:getMessageTime(unitTpl)
  local messageType = _battleMessageUnitruleTpl:getMessageType(unitTpl)
  if messageType == 1 then
    item.identify = _prefabNames.LeftAvatar
    item.moduleName = "pages/battle/cellBattleDialog"
  else
    item.identify = _prefabNames.LeftNoAvatar
    item.moduleName = "pages/battle/cellBattleDialog"
  end
  item.heroId = heroId
  self:insertArray(item)
end

function this:showBattleSpacialDialog(id)
  if AzurWorld.StoryMgr.IsPlaying or AzurWorld.FreedomDialogMgr:IsPlayFreedom() then
    printf("剧情播放中, 不播放战斗左插")
    return
  end
  local battleMsgTpl = _battleMessageTpl:getTplById(id)
  local dialogueId = _battleMessageTpl:getDialogueId(battleMsgTpl)
  local dialogTpl = _dialogBattleTpl:getTplById(dialogueId)
  local item = {}
  item.txt_content = _dialogBattleTpl:getContent(dialogTpl)
  item.delayTime = _battleMessageTpl:getMessageTime(battleMsgTpl)
  local charType = _battleMessageTpl:getCharacterType(battleMsgTpl)
  local charId = _battleMessageTpl:getCharacter(battleMsgTpl)
  if charType == 0 then
  end
  local icon = self:getHeadIcon(charId, charType)
  item.heroId = charId
  item.img_head = icon
  if charId == L_GameUtil.getDefaultHeroId() then
    icon = ""
  end
  item.txt_name = self:getHeadName(charId, charType)
  local messageType = _battleMessageTpl:getMessageType(battleMsgTpl)
  if messageType == 0 then
    return
  elseif messageType == 1 then
    item.identify = icon and _prefabNames.LeftAvatar or _prefabNames.LeftNoAvatar
    item.txtColor_name = colorStyle.normal
  elseif messageType == 2 then
    item.identify = icon and _prefabNames.LeftAvatar or _prefabNames.LeftNoAvatar
    item.txtColor_name = colorStyle.hero
  elseif messageType == 3 then
    item.identify = icon and _prefabNames.RightAvatar or _prefabNames.RightNoAvatar
    item.txtColor_name = colorStyle.boss
  end
  item.moduleName = "pages/battle/cellBattleDialog"
  self:insertArray(item)
end

function this:insertArray(itemData)
  if itemData.identify == _prefabNames.empty then
    return
  end
  local itemPre = self:_createPre(itemData.identify)
  itemPre.txt_name.text = itemData.txt_name
  if itemData.txtColor_name then
    itemPre.txt_name:LoadColorStyle(itemData.txtColor_name)
  end
  itemPre.txt_content.text = itemData.txt_content
  if itemData.heroId == L_GameUtil.getDefaultHeroId() then
    if self.photoCache then
      L_PhotoManager:releaseHead(self.photoCache)
      self.photoCache = nil
    end
    self.photoCache = itemPre
    L_PhotoManager:fillMainHead(self.photoCache, itemPre.img_head.gameObject, nil, L_Const.avatarTextureIndex.head_talk)
  else
    itemPre.img_head:LoadSprite(itemData.img_head)
  end
end

function this:getHeadIcon(characterId, characterType)
  if characterId == nil then
    return nil
  end
  if characterType == 1 then
    if characterId == L_GameUtil.getDefaultHeroId() then
      return nil
    end
    return L_GameUtil.getAvatarTexturePath(characterId, L_Const.avatarTextureIndex.head_talk)
  elseif characterType == 2 then
    local heroClothingTpl = L_GameTpl:getHeroClothingTpl()
    return heroClothingTpl:getAvatarTexture(heroClothingTpl:getTplById(characterId), L_Const.avatarTextureIndex.head_talk)
  end
end

function this:getHeadName(characterId, characterType)
  if characterId == nil then
    return "?????"
  end
  if characterType == 1 then
    if characterId == L_GameUtil.getDefaultHeroId() then
      return L_PlayerStore:getPlayerName()
    end
    local tpl = _heroTpl:getTplById(characterId)
    return _heroTpl:getName(tpl)
  end
  if characterType == 2 then
    local tpl = _enemyTpl:getTplById(characterId)
    return _enemyTpl:getName(tpl)
  end
  return nil
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

function this:allDialogsEnd()
  self.bind.activeContent = false
end

return this
