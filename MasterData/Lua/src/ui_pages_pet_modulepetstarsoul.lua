local this = class("modulePetStarSoul", G_UIModuleBase)
local _petTpl = L_GameTpl:getPetTpl()
local _petStarSoulTpl = L_GameTpl:getPetStarSoulTpl()
local StagePath = {
  [1] = "Assets/ResourcesAssets/UI/Texture/PetSoul/tex_kibo_starsoul_bg_worldtree_I.png",
  [2] = "Assets/ResourcesAssets/UI/Texture/PetSoul/tex_kibo_starsoul_bg_worldtree_I.png",
  [3] = "Assets/ResourcesAssets/UI/Texture/PetSoul/tex_kibo_starsoul_bg_worldtree_I.png",
  [4] = "Assets/ResourcesAssets/UI/Texture/PetSoul/tex_kibo_starsoul_bg_worldtree_II.png",
  [5] = "Assets/ResourcesAssets/UI/Texture/PetSoul/tex_kibo_starsoul_bg_worldtree_II.png",
  [6] = "Assets/ResourcesAssets/UI/Texture/PetSoul/tex_kibo_starsoul_bg_worldtree_III.png"
}
local StageImgPath = "UI/Atlas/HeroTalentRankNum/tex_role_talent_bg_numA0%s.png"
local StageNodeImgPath = "UI/Atlas/PetSoul/tex_kibo_starsoul_icon_skill_0%s.png"

function this.bind()
  return {
    isActive = true,
    txtConditionTip = "",
    imgLv = "",
    imgLv2 = "",
    imgStage = "",
    conditionActive = false,
    btnUpgrade = L_Const.ModuleInfo.ModuleBtn,
    petStageList = {
      moduleName = "pages/Pet/cellPetStageItem"
    },
    petStageNodeList = {
      moduleName = "pages/Pet/cellPetStageItem"
    },
    toggleModuleName = "",
    toggleModuleBar = {
      type = "toggleModule",
      modulePetAttrUp = {
        assetName = "UI/Pages/Pet/modulePetAttrUp",
        moduleName = "pages/Pet/modulePetAttrUp"
      },
      modulePetSkillUp = {
        assetName = "UI/Pages/Pet/modulePetSkillUp",
        moduleName = "pages/Pet/modulePetSkillUp"
      }
    },
    costList = L_Const.ModuleInfo.CellIconBag,
    costActive = true,
    stageActive = true,
    stageNodeActive = true,
    btnUpgradeActive = true,
    bottomActive = true,
    maxlvActive = false,
    previewActive = false,
    preBtnActive = true,
    nextBtnActive = true,
    cellPetStage4 = nil,
    cellPetStage5 = nil,
    cellPetStage2 = nil,
    cellPetStage1 = nil,
    cellPetStage3 = nil,
    cellPetStage2_1 = nil,
    cellPetStage1_1 = nil,
    cellPetStage3_1 = nil,
    cellPetStage4_1 = nil,
    cellPetStage5_1 = nil,
    listStageActive = true,
    singleStageActive = false,
    changeFx1Active = false,
    changeFx2Active = false,
    changeFx3Active = false,
    leveUpFx1Active = false,
    leveUpFx2Active = false,
    leveUpFx3Active = false,
    fxActive = false
  }
end

function this.methods()
  return {
    onClick_Pre = function(self)
      if not self.curSelectStage then
        return
      end
      if self.isPlayAniming then
        return
      end
      local oldStage = self.curSelectStage
      local newStage = oldStage - 1
      if newStage < 1 then
        return
      end
      if self.curStage == newStage then
        self:_playChangeAnim("anim_modulePetStarSoul_return1")
      else
        self.bind.imgLv = string.format(StageImgPath, tostring(oldStage))
        self.bind.imgLv2 = string.format(StageImgPath, tostring(newStage))
        self:_playChangeAnim("anim_modulePetStarSoul_change", newStage)
      end
    end,
    onClick_Next = function(self)
      if not self.curSelectStage then
        return
      end
      if self.isPlayAniming then
        return
      end
      local oldStage = self.curSelectStage
      local newStage = oldStage + 1
      if newStage > self.maxStage then
        return
      end
      if self.curStage == newStage then
        self:_playChangeAnim("anim_modulePetStarSoul_return1")
      else
        self.bind.imgLv = string.format(StageImgPath, tostring(oldStage))
        self.bind.imgLv2 = string.format(StageImgPath, tostring(newStage))
        self:_playChangeAnim("anim_modulePetStarSoul_change", newStage)
      end
    end,
    onClick_back = function(self)
      if self.isPlayAniming then
        return
      end
      self:_playChangeAnim("anim_modulePetStarSoul_return1")
    end
  }
end

function this:_playChangeAnim(animName, stage)
  L_AudioUtil.playSound("Play_SFX_System_QiboYuanMai_Whoosh_Blue")
  self.bindComponents.animation:Play(animName)
  L_TimerManager:stopTimer(self, "animChange")
  self.isPlayAniming = true
  local timeAnimClip = self.bindComponents.animation:GetClip("anim_modulePetStarSoul_staruptime")
  L_TimerManager:newOrResetTimer(self, "animChange", function()
    self.isPlayAniming = false
    self:refreshUI(stage)
  end, timeAnimClip.length)
end

function this:open()
  self.isPlayAniming = false
  self._onBagNumChangeHandle = handler(self, self.refreshItemCost)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self._onBagNumChangeHandle)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshStarSoul, self.onRefreshStarSoul, self)
end

function this:close()
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self._onBagNumChangeHandle)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshStarSoul, self.onRefreshStarSoul)
  self._starSoulUpgrading = nil
  L_TimerManager:clearTimer(self)
end

function this:refreshSubMobule(starSoulTpl)
  if self.isSkillUpgrade then
    self.bind.toggleModuleName = "modulePetSkillUp"
    self.modules.toggleModuleBar.modulePetSkillUp:setShowPetGuid(self.petGuid)
    self.modules.toggleModuleBar.modulePetSkillUp:refreshUI()
  else
    local nextStarSoulTpl = _petStarSoulTpl:getNextTpl(starSoulTpl)
    self.bind.toggleModuleName = "modulePetAttrUp"
    self.modules.toggleModuleBar.modulePetAttrUp:setShowPetGuid(self.petGuid)
    self.modules.toggleModuleBar.modulePetAttrUp:refreshUI(nextStarSoulTpl)
  end
end

function this:setShowPetGuid(petGuid)
  if petGuid ~= nil and petGuid ~= self.petGuid then
    self.bindComponents.animation:Play("anim_modulePetStarSoul_show")
  end
  self.petGuid = petGuid
end

function this:checkPetCanFeed()
  local serverData = L_PetStore:getPetItem(self.petGuid)
  return serverData ~= nil and not serverData:getPetAbilityLimited()
end

function this:SetJumpCall(callBack)
  self.jumpCall = callBack
end

function this:refreshUI(stage, animType)
  if self._starSoulUpgrading then
    return
  end
  if stage and stage < 1 then
    return
  end
  if not self.petGuid then
    self.bind.isActive = false
    return
  end
  local pet = L_PetStore:getPetItem(self.petGuid)
  local selectStage = stage or pet.stage
  if not pet or not selectStage then
    self.bind.isActive = false
    return
  end
  self.petId = pet.petId
  local petTpl = _petTpl:getTplById(pet.petId)
  local templateId = _petTpl:getStarsoulId(petTpl)
  self.maxStage = _petStarSoulTpl:getMaxStage(templateId)
  self.curStage = pet.stage
  self.curSelectStage = math.min(selectStage, self.maxStage)
  self.curSelectStage = math.max(self.curSelectStage, 1)
  self.curStageNode = pet.node
  if self.curSelectStage ~= pet.stage then
    self.curStageNode = 1
  end
  self.bind.fxActive = false
  local starSoulTpl = _petStarSoulTpl:getTplByStageNode(templateId, self.curSelectStage, self.curStageNode)
  if not starSoulTpl or not petTpl then
    self.bind.isActive = false
    return
  end
  self.isPreview = self.curSelectStage ~= self.curStage
  self.isMaxLv = self.curStage >= self.maxStage
  self.bind.isActive = true
  self.bind.preBtnActive = self.curSelectStage ~= 1
  self.bind.nextBtnActive = self.curSelectStage < self.maxStage
  self.bind.maxlvActive = not self.isPreview and self.isMaxLv
  self.bind.bottomActive = not self.isPreview and not self.isMaxLv
  self.bind.previewActive = self.isPreview
  self.bind.stageActive = self.curSelectStage ~= self.maxStage
  self.bind.costActive = not self.isPreview and not self.isMaxLv
  self.bind.btnUpgradeActive = not self.isPreview and not self.isMaxLv
  self.bind.conditionActive = not self.isPreview and not self.isMaxLv
  self.bind.toggleModuleName = ""
  self.bind.imgStage = StagePath[self.curSelectStage]
  if not self._skipImgLevel then
    local path = string.format(StageImgPath, tostring(self.curSelectStage))
    self.bind.imgLv = path
    self.bind.imgLv2 = path
  end
  self.bind.listStageActive = self.maxStage ~= 1
  self.bind.singleStageActive = self.maxStage == 1
  if 1 < self.maxStage then
    local cellPetStages = {}
    for i = 1, self.maxStage do
      table.insert(cellPetStages, {
        selectActive = i <= self.curStage,
        unlockActive = true,
        vXActive = animType == 1 and i == self.curStage
      })
    end
    self.bind.petStageList:freshAll(cellPetStages)
  end
  local nodeCnt = _petStarSoulTpl:getNodeCnt(templateId, self.curSelectStage)
  local cellPetStageNodes = {}
  if 1 < nodeCnt then
    for i = 1, nodeCnt - 1 do
      local isUnlock = self.curSelectStage < self.curStage or self.curSelectStage == self.curStage and i < pet.node
      table.insert(cellPetStageNodes, {
        unlockActive = not isUnlock,
        selectActive = isUnlock,
        itemIcon = string.format(StageNodeImgPath, tostring(i)),
        vXActive = animType == 2 and i == self.curStageNode - 1
      })
    end
  end
  self.bind.petStageNodeList:freshAll(cellPetStageNodes)
  if self.bindComponents.listStatusCtrl then
    self.bindComponents.listStatusCtrl:ChangeStatus(math.max(nodeCnt - 2, 0))
  end
  if not self.isPreview and not self.isMaxLv then
    self.condition = _petStarSoulTpl:getUnlockCondition(starSoulTpl)
    if self.condition and not table.isEmpty(self.condition) then
      self.bind.txtConditionTip = L_ConditionManager:getSingleDesc(self.condition)
    end
    self.upgradeType = _petStarSoulTpl:getType(starSoulTpl)
    self.isSkillUpgrade = 0 < _petStarSoulTpl:getUpgradeSkillLv(starSoulTpl)
    self:refreshSubMobule(starSoulTpl)
    self:refreshItemCost()
    self:refreshBtnInfo()
  end
  self:setChangeFx(self.curSelectStage)
  self:setLevelUpFx(self.curStage)
end

function this:onRefreshStarSoul(petGuid, isSucess)
  self._starSoulUpgrading = nil
  if not isSucess then
    return
  end
  if petGuid ~= self.petGuid or not self._oldStage then
    return
  end
  local pet = L_PetStore:getPetItem(petGuid)
  if not pet then
    return
  end
  local animType = 2
  local tiemLen = 0
  local timeAnim = 0
  if pet.stage > self._oldStage then
    animType = 1
    self.bindComponents.animation:Play("anim_modulePetStarSoul_starup")
    local animClip = self.bindComponents.animation:GetClip("anim_modulePetStarSoul_staruptime")
    tiemLen = animClip.length
    local animClip2 = self.bindComponents.animation:GetClip("anim_modulePetStarSoul_starup")
    timeAnim = animClip2.length
  else
    self.bindComponents.animation:Play("anim_modulePetStarSoul_levelup")
    local animClip = self.bindComponents.animation:GetClip("anim_modulePetStarSoul_levelup")
    tiemLen = animClip.length
    local animClip2 = self.bindComponents.animation:GetClip("anim_modulePetStarSoul_levelup")
    timeAnim = animClip2.length
  end
  L_AudioUtil.playSound("Play_SFX_System_QiboYuanMai_Whoosh_Yellow")
  L_TimerManager:stopTimer(self, "animUpgrade")
  if 0 < tiemLen then
    L_TimerManager:newOrResetTimer(self, "animUpgrade", function()
      if animType == 2 then
        L_AudioUtil.playSound("Play_SFX_System_QiboYuanMai_Light")
      end
      self:refreshUI(nil, animType)
    end, tiemLen)
  end
  if 0 < timeAnim then
    L_TimerManager:stopTimer(self, "animStatus")
    self.isPlayAniming = true
    L_TimerManager:newOrResetTimer(self, "animStatus", function()
      self.isPlayAniming = false
    end, timeAnim)
  end
  self._oldStage = nil
end

function this:customePlayAnim()
end

function this:refreshItemCost()
  if self.isPreview or self.isMaxLv then
    return
  end
  local petTpl = _petTpl:getTplById(self.petId)
  local templateId = _petTpl:getStarsoulId(petTpl)
  local starSoulTpl = _petStarSoulTpl:getTplByStageNode(templateId, self.curSelectStage, self.curStageNode)
  if not starSoulTpl or not petTpl then
    return
  end
  local itemListData = {}
  self.bind.costList:clear()
  self.isItemEnough = true
  local itemId = _petTpl:getStarsoulItem(petTpl)
  local itemNum = _petStarSoulTpl:getCostKiBoNum(starSoulTpl)
  if itemId and itemNum and 0 < itemNum then
    local curCnt = L_ItemTplManager:getItemNum(L_Const.resType.commonItem, itemId)
    local isEnough = itemNum <= curCnt
    if self.isItemEnough and not isEnough then
      self.isItemEnough = false
    end
    local color = isEnough and L_Const.colorHtml.white001 or L_Const.colorHtml.red003
    local itemNumTxt = L_GameUtil.fillColor(string.format("%d/%d", curCnt, itemNum), color)
    table.insert(itemListData, {
      itemType = L_Const.resType.commonItem,
      itemId = itemId,
      itemNumTxt = itemNumTxt
    })
  end
  local costItemList = L_DataUtil.parseRewardConfig(_petStarSoulTpl:getCost(starSoulTpl))
  if costItemList and not table.isEmpty(costItemList) then
    for _, reward in pairs(costItemList) do
      local curCnt = L_ItemTplManager:getItemNum(reward.itemType, reward.itemId)
      local isEnough = curCnt >= reward.itemNum
      if self.isItemEnough and not isEnough then
        self.isItemEnough = false
      end
      local color = isEnough and L_Const.colorHtml.white001 or L_Const.colorHtml.red003
      local itemNumTxt = L_GameUtil.fillColor(string.format("%d/%d", curCnt, reward.itemNum), color)
      table.insert(itemListData, {
        itemType = reward.itemType,
        itemId = reward.itemId,
        itemNumTxt = itemNumTxt
      })
    end
  end
  self.bind.costList:insert_array(itemListData)
end

function this:refreshBtnInfo()
  if L_ConditionManager:singleIsComplete(self.condition) then
    self.bind.conditionActive = false
    local btnName = ""
    if self.upgradeType == 1 then
      btnName = L_WordsTpl:getValue("ui_kibo_starsoul_upgrade")
    else
      btnName = L_WordsTpl:getValue("ui_kibo_starsoul_break")
    end
    self.modules.btnUpgrade:setData({
      txtName = btnName,
      callback = function()
        self:onClickUpgradeBtn()
      end
    })
  else
    self.bind.conditionActive = true
    self.modules.btnUpgrade:setData({
      txtName = L_WordsTpl:getValue("ui_kibo_starsoul_goto_exp"),
      callback = function()
        self:onClickUpgradeBtn()
      end
    })
  end
end

function this:onClickUpgradeBtn()
  if not self.petGuid or not self.bind.isActive then
    return
  end
  if self._starSoulUpgrading or self.isPlayAniming then
    return
  end
  if not self:checkPetCanFeed() then
    L_FlyMsgManager:showNormalMsgByKey("notice_kibo_suppression_can_not_upgrade")
    return
  end
  if L_ConditionManager:singleIsComplete(self.condition) then
    if self.isItemEnough == false then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_soul_fruit_tips2"))
      return
    else
      local pet = L_PetStore:getPetItem(self.petGuid)
      self._oldStage = pet and pet.stage or 1
      self._starSoulUpgrading = true
      L_PetStore:req_StarSoulUpgrade(self.petGuid, self.isSkillUpgrade)
      self.bind.fxActive = false
    end
  elseif self.jumpCall then
    self.jumpCall()
  end
end

function this:setChangeFx(stage)
  self.bind.changeFx1Active = stage <= 3
  self.bind.changeFx2Active = 3 < stage and stage <= 5
  self.bind.changeFx3Active = 5 < stage
end

function this:setLevelUpFx(stage)
  self.bind.leveUpFx1Active = stage <= 3
  self.bind.leveUpFx2Active = 3 < stage and stage <= 5
  self.bind.leveUpFx3Active = 5 < stage
end

return this
