local this = class("modulePetUpgrade", G_UIModuleBase)
local _petTpl = L_GameTpl:getPetTpl()
local _petStarSoulTpl = L_GameTpl:getPetStarSoulTpl()

function this.bind()
  return {
    isActive = true,
    txtLvTip = "ui_kibo_starsoul_break_limit",
    txtLv = "",
    lvTipActive = true,
    cellItem = L_Const.ModuleInfo.CellIconBag,
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
    }
  }
end

function this.methods()
  return {}
end

function this:refreshSubMobule(starSoulTpl)
  local upgradeType = _petStarSoulTpl:getType(starSoulTpl)
  if upgradeType == 1 then
    self.bind.toggleModuleName = "modulePetAttrUp"
    self.modules.toggleModuleBar.modulePetAttrUp:setShowPetGuid(self.petGuid)
    self.modules.toggleModuleBar.modulePetAttrUp:refreshUI(starSoulTpl)
  else
    self.bind.toggleModuleName = "modulePetSkillUp"
    self.modules.toggleModuleBar.modulePetSkillUp:setShowPetGuid(self.petGuid)
    self.modules.toggleModuleBar.modulePetSkillUp:refreshUI(starSoulTpl)
  end
end

function this:setShowPetGuid(petGuid)
  self.petGuid = petGuid
end

function this:SetJumpCall(callBack)
  self.jumpCall = callBack
end

function this:refreshUI()
  if not self.petGuid then
    self.bind.isActive = false
    return
  end
  local pet = L_PetStore:getPetItem(self.petGuid)
  if not pet or not pet.stage then
    self.bind.isActive = false
    return
  end
  local petTpl = _petTpl:getTplById(pet.petId)
  local templateId = _petTpl:getStarsoulId(petTpl)
  local starSoulTpl = _petStarSoulTpl:getTplByStageNode(templateId, pet.stage, pet.node)
  if not starSoulTpl or not petTpl then
    self.bind.isActive = false
    return
  end
  self.bind.isActive = true
  local maxStage = _petStarSoulTpl:getMaxStage(templateId)
  if maxStage <= pet.stage then
    return
  end
  self.bind.txtLv = L_Const.Number2Roma[pet.stage]
  self.bind.lvTipActive = true
  self.condition = _petStarSoulTpl:getUnlockCondition(starSoulTpl)
  local cellPetStages = {}
  for i = 1, maxStage do
    table.insert(cellPetStages, {
      unlockActive = i > pet.stage,
      selectActive = i == pet.stage
    })
  end
  self.bind.petStageList:clear()
  self.bind.petStageList:insert_array(cellPetStages)
  local nodeCnt = _petStarSoulTpl:getNodeCnt(templateId, pet.stage)
  local cellPetStageNodes = {}
  for i = 1, nodeCnt do
    table.insert(cellPetStageNodes, {
      unlockActive = i > pet.node,
      selectActive = i == pet.node
    })
  end
  self.bind.petStageNodeList:clear()
  self.bind.petStageNodeList:insert_array(cellPetStageNodes)
  self:refreshSubMobule(starSoulTpl)
  self:refreshItemCost(starSoulTpl, petTpl)
  self:refreshBtnInfo()
end

function this:refreshItemCost(starSoulTpl, petTpl)
  local upgradeType = _petStarSoulTpl:getType(starSoulTpl)
  local itemId, itemType, itemNum, curCnt, color
  self.isItemEnough = nil
  self.notEnoughTip = ""
  if upgradeType == 1 then
    local reward = L_DataUtil.parseRewardConfig(_petStarSoulTpl:getCost(starSoulTpl))[1]
    itemId = reward.itemId
    itemType = reward.itemType
    itemNum = reward.itemNum
    curCnt = L_ItemTplManager:getItemNum(L_Const.resType.commonItem, itemId)
    self.notEnoughTip = L_WordsTpl:getValue("notice_kibo_soul_fruit_tips1")
  else
    itemId = _petTpl:getStarsoulItem(petTpl)
    itemType = L_Const.resType.commonItem
    itemNum = _petStarSoulTpl:getCostKiBoNum(starSoulTpl)
    self.notEnoughTip = L_WordsTpl:getValue("notice_kibo_soul_fruit_tips2")
  end
  local curCnt = L_ItemTplManager:getItemNum(L_Const.resType.commonItem, itemId)
  self.isItemEnough = itemNum <= curCnt
  local color = self.isItemEnough and L_Const.colorHtml.white001 or L_Const.colorHtml.red003
  self.modules.cellItem:setGeneralContent(L_Const.resType.commonItem, itemId, {
    itemNumTxt = L_GameUtil.fillColor(string.format("%d/%d", curCnt, itemNum), L_Const.colorHtml.red003)
  })
end

function this:refreshBtnInfo()
  if L_ConditionManager:isComplete(self.condition) then
    self.bind.lvTipActive = false
    self.bind.txtBtnName = L_WordsTpl:getValue("ui_kibo_starsoul_Upgrade")
    self.modules.btnUpgrade:setData({
      txtName = L_WordsTpl:getValue("ui_kibo_starsoul_Upgrade"),
      callback = function()
        self:onClickUpgradeBtn()
      end
    })
  else
    self.bind.lvTipActive = true
    self.modules.btnUpgrade:setData({
      txtName = L_WordsTpl:getValue("ui_kibo_starsoul_Jump_Upgrade"),
      callback = function()
        self:onClickUpgradeBtn()
      end
    })
  end
end

function this:getPetGuid()
  return self.petGuid
end

function this:onClickUpgradeBtn()
  if not self.petGuid or not self.bind.isActive then
    return
  end
  if L_ConditionManager:isComplete(self.condition) then
    if self.isItemEnough == false then
      L_FlyMsgManager:showNormalMsg(self.notEnoughTip)
      return
    else
      L_UI:open("pagePetUpgradeSucess", {
        petGuid = self.petGuid
      })
    end
  elseif self.jumpCall then
    self.jumpCall()
  end
end

return this
