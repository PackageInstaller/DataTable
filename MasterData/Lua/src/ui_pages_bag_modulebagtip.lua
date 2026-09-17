local this = class("moduleBagTip", G_UIModuleBase)
local _soulessenceRankTpl = L_GameTpl:getSoulessenceRankTpl()
local _battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _foodTpl = L_GameTpl:getFoodTpl()
local _commonItemUseTypeTpl = L_GameTpl:getCommonItemUseTypeTpl()
local _taskItemTpl = L_GameTpl:getTaskItemTpl()
local _soulessenceTpl = L_GameTpl:getSoulessenceTpl()
local _accessoryTpl = L_GameTpl:getAccessoryTpl()
local _petEggTpl = L_GameTpl:getPetEggTpl()
local _accessoryScoreTpl = L_GameTpl:getAccessoryScoreTpl()
local _professionTpl = L_GameTpl:getProfessionTpl()
local _heroTpl = L_GameTpl:getHeroTpl()
local accessoryCustomedTpl = L_GameTpl:getAccessoryCustomedTpl()
local attrBaseName = {
  [L_Const.battleAtt.MAXHP] = "info_attr_basic_hp",
  [L_Const.battleAtt.ATK] = "info_attr_basic_atk",
  [L_Const.battleAtt.DEF] = "info_attr_basic_def",
  [L_Const.battleAtt.MDEF] = "info_attr_basic_mdef"
}

function this.bind()
  return {
    go_funcBtn = false,
    txt_funcBtn = nil,
    img_qualityBg = nil,
    img_icon = nil,
    img_iconFilter = nil,
    txt_name = "",
    go_desc = false,
    txt_desc = "",
    go_tag = false,
    list_tag = {
      moduleName = "pages/bag/cellBagTag"
    },
    go_desc_sub = false,
    txt_desc_sub = "",
    go_num = false,
    txt_num = "",
    go_access = false,
    list_access = {
      moduleName = "pages/bag/cellItemAccess"
    },
    list_star = {
      moduleName = "pages/bag/cellBagTipStar"
    },
    list_soulessenceStar = {
      moduleName = "pages/bag/cellSoulEssenceStar"
    },
    list_goldAccessoryStar = {
      moduleName = "pages/bag/cellGoldAccessoryStar"
    },
    go_starRoot = false,
    go_star = false,
    go_soulessenceStar = false,
    go_goldAccessoryStar = false,
    go_foodBuff = false,
    img_foodBuff = nil,
    go_foodUseBtnGroup = false,
    go_foodDesc = false,
    go_foodDesc_pet = false,
    txt_foodDesc_pet = nil,
    go_foodDesc_heroHungry = false,
    txt_foodDesc_heroHungry = nil,
    go_foodDesc_hero = false,
    txt_foodDesc_hero = nil,
    go_moduleFishRodBuff = false,
    module_fishRodBuff = {
      moduleName = "pages/fishing/moduleFishRodBuff"
    },
    go_soulessenceLevel = false,
    txt_soulessenceLevel = nil,
    go_soulessenceAtt = false,
    list_soulessenceAtt = {
      moduleName = "pages/bag/cellBagTipSoulEssenceAccessoryAtt"
    },
    go_soulessenceSkillDesc = false,
    txt_soulessenceSkillDesc = nil,
    txt_soulessenceProfession1 = nil,
    txt_soulessenceProfession2 = nil,
    go_soulessenceProfessionDesc = false,
    imgProfession = nil,
    imgEleBg = nil,
    go_subDescLine = false,
    txt_AccessoryAttToggleName = "",
    toggleAccessoryAtt = {
      type = "toggleModule",
      moduleAccessoryAtt = {
        assetName = "UI/Pages/Bag/moduleAttGroup",
        moduleName = "pages/bag/moduleAttGroup"
      }
    },
    txt_AccessorySuitToggleName = "",
    toggleAccessorySuit = {
      type = "toggleModule",
      moduleAccessorySuit = {
        assetName = "UI/Pages/Bag/moduleAccessorySuit",
        moduleName = "pages/accessory/moduleAccessorySuit"
      }
    },
    go_accessoryHeadRank = false,
    img_accessoryHeadRank = nil,
    go_saLockBtn = false,
    isOn_saLock = false,
    go_saOwner = false,
    img_saOwner = nil,
    go_saMaxLevel = false,
    go_limit = false,
    img_limit = "",
    txt_limit = ""
  }
end

function this.methods()
  return {
    onClick_mask = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_func = function(self)
      if self._type == L_BagConst.bagTag.accessory then
        local pageReward = L_UI:getPage("pageReward")
        if pageReward then
          C_UIMgr.OpenCutin("pageAccessoryStrength", 1, function()
            L_UI:backToRoot()
            L_UI:open("pageAccessoryStrength", {
              accessoryId = self._guid
            }, function(b)
              C_UIMgr.CloseCutin()
            end)
          end, false)
        else
          L_UI:open("pageAccessoryStrength", {
            accessoryId = self._guid
          })
        end
      elseif self._type == L_BagConst.bagTag.soulEssence then
        local pageReward = L_UI:getPage("pageReward")
        if pageReward then
          C_UIMgr.OpenCutin("pageSoulEssenceUpgrade", 1, function()
            L_UI:backToRoot()
            L_UI:open("pageSoulEssenceUpgrade", {
              isPreview = false,
              soulEssenceGuid = self._guid
            }, function(b)
              C_UIMgr.CloseCutin()
            end)
          end, false)
        else
          L_UI:open("pageSoulEssenceUpgrade", {
            isPreview = false,
            soulEssenceGuid = self._guid
          })
        end
      elseif self._type == L_BagConst.bagTag.petEgg then
        if math.isEmpty(self._guid) then
          return
        end
        L_PetReleaseManager:reqDeletePetEgg({
          self._guid
        })
      else
        C_BagMgr:UseBagItem(self._guid, self._callback or nil)
      end
    end,
    onClick_eatFoodByHero = function(self)
      C_BagMgr:UseBagItem(self._guid)
    end,
    onClick_lock = function(self)
      if self._type == L_BagConst.bagTag.accessory then
        local lock = C_AccessoryMgr:getAccessory(self._guid).bLock
        C_AccessoryMgr:req_setLockAccessory(self._guid, not lock, function()
          self.bind.isOn_saLock = not lock
          if self.btnLockAction ~= nil then
            self.btnLockAction(self._guid, not lock)
          end
        end)
      elseif self._type == L_BagConst.bagTag.soulEssence then
        C_SoulEssenceMgr:req_lockSoulEssence(self._guid, not self.bind.isOn_saLock, function(param)
        end)
      end
    end,
    scrollList_access = {
      onClick_select = function(self)
        L_UI:close(self.pageName)
      end
    }
  }
end

function this:open()
  self.playerNameUrl = L_PlayerStore:getPlayerModHeadImgName()
  self.onEvent_onSoulEssenceChange = handler(self, self.onSoulEssenceChange)
  C_BagEvent.instance:Listen(C_EBagEvent.SoulEssenceChange, self.onEvent_onSoulEssenceChange)
end

function this:close()
  self._callback = nil
  C_BagEvent.instance:Cancel(C_EBagEvent.SoulEssenceChange, self.onEvent_onSoulEssenceChange)
  L_PhotoManager:clearPhotoEntity(self)
  if not self.refreshTimer then
    return
  end
  self.refreshTimer:destroy()
  self.refreshTimer = nil
end

function this:onSoulEssenceChange(bNumChange, changeList)
  if self._type == L_BagConst.bagTag.soulEssence then
    if bNumChange then
      self:setSoulEssenceData()
    elseif table.containsValue(changeList, self._guid) then
      self:setSoulEssenceData()
    end
  end
end

function this:setData(type, guid, param)
  self._guid = guid
  self._type = type
  self._param = param or table.empty
  if type == L_BagConst.bagTag.accessory then
    self:setAccessoryData()
  elseif type == L_BagConst.bagTag.soulEssence then
    self:setSoulEssenceData()
  elseif type == L_BagConst.bagTag.taskProp then
    self:setTaskPropData()
  elseif type == L_BagConst.bagTag.petEgg then
    self:setPetEggData()
  elseif type == L_BagConst.bagTag.collectionTool then
    self:setCollectionTool()
  else
    self:setCommonItemData()
  end
  self.bindComponents.spiritStoryRed.gameObject:SetActive(type == L_BagConst.bagTag.soulEssence)
  if self._lastType == nil or self._lastType ~= self._type then
    self.bindComponents.ani_moduleBagTip:Stop()
    self.bindComponents.ani_moduleBagTip:Play("anim_Nbag_tips_in")
    self._lastType = self._type
    self._lastGuid = self._guid
    self.bindComponents.scrollView_content.verticalNormalizedPosition = 1
  elseif self._lastGuid ~= self._guid then
    self.bindComponents.ani_moduleBagTip:Stop()
    self.bindComponents.ani_moduleBagTip:Play("anim_Nbag_tips_change")
    self._lastGuid = self._guid
    self.bindComponents.scrollView_content.verticalNormalizedPosition = 1
  end
  if type ~= L_BagConst.bagTag.accessory then
    self.bind.txt_AccessoryAttToggleName = ""
    self.bind.txt_AccessorySuitToggleName = ""
    self:newOrResetTimer("animTimer1", function()
      if self.bindComponents.accessorySuitTrans then
        self.bindComponents.accessoryAttTrans.localScale = L_Vector3.new(0, 0, 0)
        self.bindComponents.accessorySuitTrans.localScale = L_Vector3.new(0, 0, 0)
        self.bindComponents.accessoryAttLayoutEle.ignoreLayout = true
        self.bindComponents.accessorySuitLayoutEle.ignoreLayout = true
      end
    end, 0.2)
  end
  self:newOrResetTimer("layout", function()
    Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.namelayout)
  end, 0.3)
end

function this:formatName(name)
  if L_ItemTplManager:getNameLength(name) > 24 then
    self.bindComponents.nameTmp.enableAutoSizing = true
  else
    self.bindComponents.nameTmp.enableAutoSizing = false
  end
  self.bind.txt_name = L_ItemTplManager:getSplitName(name, 35)
end

function this:setAccessoryData()
  self.bind.go_num = false
  self.bind.txt_AccessoryAttToggleName = "moduleAccessoryAtt"
  self.bind.txt_AccessorySuitToggleName = "moduleAccessorySuit"
  local serverData = C_AccessoryMgr:getAccessory(self._guid)
  if serverData then
    local accessoryTpl = _accessoryTpl:getTplById(serverData.accessoryId)
    local quality = _accessoryTpl:getRarity(accessoryTpl)
    self:formatName(string.format("%s+%s", _accessoryTpl:getName(accessoryTpl), serverData.level))
    local path = string.format("UI/Texture/Bag/tex_bag_rarity_tips_bg_%d.png", quality)
    self.bindComponents.img_qualityBg:LoadSprite(path, false)
    self.bind.go_saLockBtn = not self._param.hideLock
    self.bind.isOn_saLock = serverData.bLock
    self.bind.img_icon = ""
    self.bind.img_iconFilter = ""
    self._bGoldSide = serverData.quality == 5
    local path = _accessoryTpl:getIcon(accessoryTpl)
    if self._bGoldSide then
      self.bind.img_icon = path:gsub("%.png$", "_G.png")
    else
      self.bind.img_icon = path
    end
    self.bind.txt_goldSideValue = "/" .. serverData.maxValue
    self.bind.txt_goldSideValueSSS = "/" .. serverData.maxValue
    local isEquipped = not math.isEmpty(serverData.wearHero)
    self.bind.go_saOwner = isEquipped
    if isEquipped then
      local heroData = L_HeroStore:getHero(serverData.wearHero)
      local modName = L_PlayerStore:getPlayerModHeadImgName()
      if heroData then
        if L_HeroStore:getHeroGuid(heroData) == L_HeroStore:getDefaultHeroGuid() and not string.isEmpty(modName) then
          L_PhotoManager:fillMainHead(self, self.bindComponents.img_head.gameObject, nil, L_Const.avatarTextureIndex.head, function()
            self.bindComponents.img_head.gameObject:SetActive(true)
          end)
        else
          L_PhotoManager:releaseHead(self)
          self.bind.img_saOwner = L_GameUtil.getAvatarTexturePath(L_HeroStore:getHeroConfigId(heroData), L_Const.resourceIndexOfAvatarTextureInHeroTpl.small)
        end
      end
    end
    self.bindComponents.accessoryAttTrans.localScale = L_Vector3.new(1, 1, 1)
    self.bindComponents.accessoryAttLayoutEle.ignoreLayout = false
    self.modules.toggleAccessoryAtt.moduleAccessoryAtt:setServerData(self._guid)
    self.bindComponents.accessorySuitTrans.localScale = L_Vector3.new(1, 1, 1)
    self.bindComponents.accessorySuitLayoutEle.ignoreLayout = false
    self.modules.toggleAccessorySuit.moduleAccessorySuit:setNormalSuit(self._guid)
    local scroe = serverData.score
    local isMax = C_AccessoryMgr:getIsMaxLevel(self._guid) and scroe >= serverData.maxValue
    self.bind.go_funcBtn = not isMax and not self._param.hideFuncBtn
    self.bind.go_saMaxLevel = isMax
    self.btnLockAction = self._param.lockAction
    local tpl_use = _commonItemUseTypeTpl:getTplById(L_BagConst.bagUseType.accessory)
    self.bind.txt_funcBtn = _commonItemUseTypeTpl:getName(tpl_use)
    self:setStar(serverData.grade, quality + 2)
    local headRank = _accessoryTpl:getHeadRank(accessoryTpl) or 0
    self.bind.go_accessoryHeadRank = 0 < headRank
    if 0 < headRank then
      self.bind.img_accessoryHeadRank = C_AccessoryMgr:getAccessoryHeadRankIcon(headRank)
    end
    if C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.itemAccess) then
      self.bind.go_access = true
      local accessList = _accessoryTpl:getWayList(accessoryTpl)
      local tmp = {}
      for i, v in ipairs(accessList) do
        table.insert(tmp, {
          systemId = v.id,
          txt_access = v.desc,
          itemId = serverData.accessoryId
        })
      end
      self.bind.list_access:clear()
      self.bind.list_access:insert_array(tmp)
    end
    local string_des_sub = _accessoryTpl:getDesc(accessoryTpl)
    self.bind.go_subDescLine = true
    self.bind.go_desc_sub = string_des_sub ~= string.empty
    self.bind.txt_desc_sub = string_des_sub
  else
    self:setAccessoryDataNotSever()
  end
end

function this:setAccessoryDataNotSever()
  local accessoryId = self._param.itemId
  if self._param and self._param.itemType == L_Const.resType.customAccessory then
    accessoryId = accessoryCustomedTpl:getAccessoryIdById(accessoryId)
  end
  local accessoryTpl = _accessoryTpl:getTplById(accessoryId)
  local quality = _accessoryTpl:getRarity(accessoryTpl)
  local configData = L_ItemTplManager:getAccessoryItem(accessoryId)
  self:formatName(configData.name)
  self.bind.img_qualityBg = self:getQualityBgName(quality)
  self.bind.img_iconFilter = ""
  self.bind.go_saLockBtn = false
  self.bind.go_saOwner = false
  self.modules.toggleAccessoryAtt.moduleAccessoryAtt:setNotServerData(accessoryId, true)
  self.bind.txt_AccessorySuitToggleName = "moduleAccessorySuit"
  self.modules.toggleAccessorySuit.moduleAccessorySuit:setNormalSuitPreview(accessoryId)
  self.bind.go_funcBtn = false
  self.bind.go_saMaxLevel = false
  self.btnLockAction = self._param.lockAction
  local tpl_use = _commonItemUseTypeTpl:getTplById(L_BagConst.bagUseType.accessory)
  self.bind.txt_funcBtn = _commonItemUseTypeTpl:getName(tpl_use)
  local path = _accessoryTpl:getIcon(accessoryTpl)
  if self._bGoldSide then
    self.bind.img_icon = path:gsub("%.png$", "_G.png")
  else
    self.bind.img_icon = path
  end
  self:setStar(0)
  local headRank = _accessoryTpl:getHeadRank(accessoryTpl) or 0
  self.bind.go_accessoryHeadRank = 0 < headRank
  if 0 < headRank then
    self.bind.img_accessoryHeadRank = C_AccessoryMgr:getAccessoryHeadRankIcon(headRank)
  end
  if C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.itemAccess) then
    self.bind.go_access = true
    local accessList = _accessoryTpl:getWayList(accessoryTpl)
    local tmp = {}
    for i, v in ipairs(accessList) do
      table.insert(tmp, {
        systemId = v.id,
        txt_access = v.desc,
        itemId = self._guid
      })
    end
    self.bind.list_access:clear()
    self.bind.list_access:insert_array(tmp)
  end
  self.bind.go_subDescLine = true
  self.bind.go_desc_sub = true
  self.bind.txt_desc_sub = _accessoryTpl:getDesc(accessoryTpl)
end

function this:setSoulEssenceData()
  local serverData = C_SoulEssenceMgr:getsoulessenceItem(self._guid)
  local tpl = _soulessenceTpl:getTplById(serverData.soulEssenceId)
  self:formatName(_soulessenceTpl:getName(tpl))
  local path = string.format("UI/Texture/Bag/tex_bag_rarity_tips_bg_%d.png", _soulessenceTpl:getRarity(tpl))
  self.bindComponents.img_qualityBg:LoadSprite(path, false)
  self.bind.img_icon = _soulessenceTpl:getAvatarTexture(tpl, 1)
  self.bind.img_iconFilter = ""
  self.bind.go_saLockBtn = true
  self.bind.isOn_saLock = serverData.bLock
  self.bind.go_soulessenceLevel = true
  local rankData = _soulessenceRankTpl:getChildren(serverData.soulEssenceId)
  local limitTxt = L_GameUtil.fillColor(string.concat("/", rankData[serverData.rank].rankLevelLimit), L_Const.colorHtml.grey008)
  self.bind.txt_soulessenceLevel = string.concat(serverData.level, limitTxt)
  local isEquipped = not math.isEmpty(serverData.wearHero)
  self.bind.go_saOwner = isEquipped
  if isEquipped then
    local heroData = L_HeroStore:getHero(serverData.wearHero)
    local modName = L_PlayerStore:getPlayerModHeadImgName()
    if heroData then
      if L_HeroStore:getHeroGuid(heroData) == L_HeroStore:getDefaultHeroGuid() and not string.isEmpty(modName) then
        L_PhotoManager:fillMainHead(self, self.bindComponents.img_head.gameObject, nil, L_Const.avatarTextureIndex.head, function()
          self.bindComponents.img_head.gameObject:SetActive(true)
        end)
      else
        L_PhotoManager:releaseHead(self)
        self.bind.img_saOwner = L_GameUtil.getAvatarTexturePath(L_HeroStore:getHeroConfigId(heroData), L_Const.resourceIndexOfAvatarTextureInHeroTpl.small)
      end
    end
  end
  self:setStar(C_SoulEssenceMgr:getsoulessenceItem(self._guid).star - 1)
  local tmp = {}
  local attList = C_SoulEssenceMgr:getConfigAttList(serverData.soulEssenceId, serverData.level, serverData.rank)
  local showBg = true
  for k, v in pairs(attList) do
    local tpl_battleInfo = _battleInfoTpl:getTplById(k)
    local name = L_WordsTpl:getValue(attrBaseName[k])
    table.insert(tmp, {
      txt_name = string.isEmpty(name) and _battleInfoTpl:getName(tpl_battleInfo) or name,
      txt_value = _battleInfoTpl:getShowTxt(k, v),
      go_bg = showBg
    })
    showBg = not showBg
  end
  self.bind.go_soulessenceAtt = true
  self.bind.list_soulessenceAtt:clear()
  self.bind.list_soulessenceAtt:insert_array(tmp)
  local ServerStar = math.clamp(serverData.star, 1, 4)
  if serverData.soulEssenceId == 10001 then
    self.bind.go_soulessenceSkillDesc = true
    self.bind.txt_soulessenceSkillDesc = C_SoulEssenceMgr:getExclusiveSkill(serverData.soulEssenceId, ServerStar - 1).skillDesc
  else
    self.bind.go_soulessenceSkillDesc = false
  end
  local professionTplItem, professionName, heroGuid, heroData
  heroGuid = serverData.wearHero
  heroData = L_HeroStore:getHero(heroGuid)
  local validProfession = _soulessenceTpl:getValidProfession(tpl)
  self.bind.go_soulessenceProfessionDesc = validProfession ~= 0
  if validProfession ~= 0 then
    professionTplItem = _professionTpl:getTplById(validProfession)
    professionName = _professionTpl:getName(professionTplItem)
    local flag = self:checkSpiritOnwerPosition(heroGuid, validProfession)
    local isSameHero = true
    if self._param ~= nil and self._param.onwerHeroGuid ~= nil then
      isSameHero = self._param.onwerHeroGuid == heroGuid
    end
    local professionIcon
    local professionTpl = L_GameTpl:getProfessionTpl()
    local iconPath = professionTpl:getIcon(professionTpl:getTplById(validProfession))
    professionIcon = "ProfessionIcon/tex_common_icon_profession_sele_" .. string.sub(iconPath, -2 - #".ing")
    self.bind.imgProfession = professionIcon
    if heroData ~= nil and not flag and isSameHero then
      self.bind.txt_soulessenceProfession1 = string.format("<color=#b32031>非</color>")
      self.bind.txt_soulessenceProfession2 = string.format("<color=#ff8c04>[%s]</color><color=#b32031>角色，效果未生效</color>", professionName)
    else
      self.bind.txt_soulessenceProfession1 = string.format("以下效果对")
      self.bind.txt_soulessenceProfession2 = string.format("<color=#ff8c04>[%s]</color>角色生效", professionName)
    end
  end
  self.bind.go_subDescLine = true
  self.bind.go_desc_sub = true
  self.bind.txt_desc_sub = _soulessenceTpl:getDesc(tpl)
  local tpl_use = _commonItemUseTypeTpl:getTplById(L_BagConst.bagUseType.soulEssence)
  self.bind.go_funcBtn = not self._param.hideFuncBtn
  self.bind.txt_funcBtn = _commonItemUseTypeTpl:getName(tpl_use)
  self.timer = Timer.once(0.1, function()
    Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.box)
  end, self)
end

function this:setTaskPropData()
  local tpl = _taskItemTpl:getTplById(self._guid)
  local quality = _taskItemTpl:getRarity(tpl)
  self:formatName(_taskItemTpl:getName(tpl))
  self.bind.img_qualityBg = self:getQualityBgName(quality)
  self.bind.img_icon = _taskItemTpl:getIcon(tpl)
  self.bind.img_iconFilter = ""
  self.bind.go_num = true
  self.bind.txt_num = tostring(AzurWorld.TaskMgr:GetTaskUIModule():GetTaskPropNum(self._guid))
  self.bind.go_tag = true
  local tag = {}
  local tags = _taskItemTpl:getTag(tpl)
  for i, v in ipairs(tags) do
    table.insert(tag, {txt_tag = v})
  end
  self.bind.list_tag:clear()
  self.bind.list_tag:insert_array(tag)
  self.bind.go_desc = true
  self.bind.txt_desc = _taskItemTpl:getDesc(tpl)
  self.bind.go_desc_sub = true
  self.bind.txt_desc_sub = _taskItemTpl:getSpecialDesc(tpl)
  local useType = _taskItemTpl:getUseType(tpl)
  self.bind.go_funcBtn = not math.isEmpty(useType) and not self._param.hideFuncBtn
  if not math.isEmpty(useType) then
    local tpl_use = _commonItemUseTypeTpl:getTplById(useType)
    self.bind.txt_funcBtn = _commonItemUseTypeTpl:getName(tpl_use)
  end
  local starNum = AzurWorld.ItemMgr:GetItemShowStarNum(L_Const.resType.taskItem, self._guid)
  self:setStar(starNum)
end

function this:setPetEggData()
  local petEgg = L_PetStore:getPetEggItem(self._guid)
  local tpl = _petEggTpl:getTplById(petEgg.configId)
  local quality = _petEggTpl:getRarity(tpl)
  self:formatName(_petEggTpl:getName(tpl))
  self.bind.img_qualityBg = self:getQualityBgName(quality)
  self.bind.img_icon = _petEggTpl:getEggImgIcon(tpl)
  self.bind.img_iconFilter = ""
  self.bind.go_tag = true
  local tag = {}
  local tags = _petEggTpl:getTag(tpl)
  for i, v in ipairs(tags) do
    table.insert(tag, {txt_tag = v})
  end
  self.bind.list_tag:clear()
  self.bind.list_tag:insert_array(tag)
  self.bind.go_desc = true
  self.bind.txt_desc = _petEggTpl:getDesc(tpl)
  self.bind.go_desc_sub = true
  self.bind.txt_desc_sub = _petEggTpl:getSpecialDesc(tpl)
  local useType = _petEggTpl:getUseType(tpl)
  self.bind.go_funcBtn = not math.isEmpty(useType) and not self._param.hideFuncBtn
  if not math.isEmpty(useType) then
    local tpl_use = _commonItemUseTypeTpl:getTplById(useType)
    self.bind.txt_funcBtn = _commonItemUseTypeTpl:getName(tpl_use)
  end
  local starNum = AzurWorld.ItemMgr:GetItemShowStarNum(L_Const.resType.petEgg, petEgg.configId)
  self:setStar(starNum)
end

function this:setCollectionTool()
  local configTable = CS.Azur.Gameplay.Table.TDCollectionToolTable.GetData(self._guid)
  if configTable.id == 0 then
    return
  end
  local quality = configTable.rarity
  self:formatName(configTable.name.value)
  self.bind.img_qualityBg = self:getQualityBgName(quality)
  self.bind.img_icon = configTable.icon[0]
  self.bind.img_iconFilter = ""
  self.bind.go_tag = true
  local tag = {}
  local tags = configTable.tag
  if tags then
    for i = 0, tags.Count - 1 do
      table.insert(tag, {
        txt_tag = tags[i].value
      })
    end
  end
  self.bind.list_tag:clear()
  self.bind.list_tag:insert_array(tag)
  self.bind.go_desc = true
  self.bind.txt_desc = configTable.desc.value
  self.bind.go_desc_sub = true
  self.bind.txt_desc_sub = configTable.specialDesc.value
  if C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.itemAccess) then
    self.bind.go_access = true
    local tmp = {}
    local wayList = configTable:GetWayList() or table.empty
    local wayDescList = configTable.wayDesc
    for i = 0, wayList.Count - 1 do
      table.insert(tmp, {
        systemId = wayList[i],
        txt_access = wayDescList[i].value,
        itemId = configTable.id
      })
    end
    self.bind.list_access:clear()
    self.bind.list_access:insert_array(tmp)
  end
  local starNum = AzurWorld.ItemMgr:GetItemShowStarNum(L_Const.resType.collectionTool, configTable.id)
  self:setStar(starNum)
end

function this:setCommonItemData()
  local tpl = _commonItemTpl:getTplById(self._guid)
  local quality = _commonItemTpl:getRarity(tpl)
  self:formatName(_commonItemTpl:getName(tpl))
  self.bind.img_qualityBg = self:getQualityBgName(quality)
  self.bind.img_icon = _commonItemTpl:getIcon(tpl)
  self.bind.img_iconFilter = _commonItemTpl:getFilterIcon(tpl)
  self.bind.go_num = true
  self.bind.txt_num = tostring(C_BagMgr:getItemNumByItemId(self._guid))
  self.bind.go_tag = true
  local tag = {}
  local tags = _commonItemTpl:getTag(tpl)
  for i, v in ipairs(tags) do
    table.insert(tag, {txt_tag = v})
  end
  self.bind.list_tag:clear()
  self.bind.list_tag:insert_array(tag)
  self.bind.go_desc = true
  self.bind.txt_desc = _commonItemTpl:getDesc(tpl)
  self.bind.go_desc_sub = true
  self.bind.txt_desc_sub = _commonItemTpl:getSpecialDesc(tpl)
  if C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.itemAccess) then
    self.bind.go_access = true
    local accessList = _commonItemTpl:getWayList(tpl)
    local tmp = {}
    for i, v in ipairs(accessList) do
      table.insert(tmp, {
        systemId = v.id,
        txt_access = v.desc,
        itemId = self._guid
      })
    end
    self.bind.list_access:clear()
    self.bind.list_access:insert_array(tmp)
  end
  local useType = _commonItemTpl:getUseType(tpl)
  self.bind.go_funcBtn = not math.isEmpty(useType) and not self._param.hideFuncBtn
  if not math.isEmpty(useType) then
    local tpl_use = _commonItemUseTypeTpl:getTplById(useType)
    if useType == L_BagConst.bagUseType.scan then
      self.bind.txt_funcBtn = C_BagMgr:checkScanUsingItem(self._guid) and L_WordsTpl:getValue("ui_pageQui_ckEditRoulette_04") or _commonItemUseTypeTpl:getName(tpl_use)
    else
      local tpl_use = _commonItemUseTypeTpl:getTplById(useType)
      self.bind.txt_funcBtn = _commonItemUseTypeTpl:getName(tpl_use)
    end
  end
  local starNum = AzurWorld.ItemMgr:GetItemShowStarNum(L_Const.resType.commonItem, self._guid)
  self:setStar(starNum)
  local type = _commonItemTpl:getType(tpl)
  self.bind.go_moduleFishRodBuff = L_BagConst.bagItemType.fishingRod == type
  self.bind.go_foodUseBtnGroup = false
  if type == L_BagConst.bagItemType.food then
    self:setFoodData()
  elseif type == L_BagConst.bagItemType.fishingRod then
    self:setFishingRodData()
  elseif type == L_BagConst.bagItemType.fishingBait then
    self:setFishingBaitData()
  end
  local item = C_BagMgr:getItem(self._guid)
  if item then
    local deadTime = item.deadTime
    if deadTime and 0 < deadTime and deadTime > L_TimeUtil.getServerTime() then
      self.bind.go_limit = true
      self.refreshTimer = Timer.repeated(1, function()
        self.bind.txt_limit = L_TimeUtil.getLeftTimeString2(deadTime)
      end)
      self.bind.img_limit = "Assets/Arts/UI/Page/Common/icon/tex_common_icon_countdown_02.png"
    else
      self.bind.go_limit = false
    end
  end
end

function this:setFoodData()
  local tpl_food = _foodTpl:getTplById(self._guid)
  self.bind.go_foodBuff = true
  self.bind.img_foodBuff = string.format("UI/Atlas/FoodType/tex_icon_foodtype_tag_0%s.png", _foodTpl:getFoodType(tpl_food))
  local satiety = _foodTpl:getSatietyScore(tpl_food)
  local isPetFood = not math.isEmpty(satiety)
  self.bind.go_funcBtn = self.bind.go_funcBtn and not isPetFood and not self._param.hideFuncBtn
  self.bind.go_foodUseBtnGroup = isPetFood and not self._param.hideFuncBtn
  self.bind.go_desc = false
  self.bind.go_foodDesc = true
  self.bind.go_foodDesc_pet = isPetFood
  self.bind.txt_foodDesc_pet = string.concat(L_WordsTpl:getValue("ui_pet_food_desc"), satiety)
  satiety = _foodTpl:getCharge(tpl_food)
  self.bind.go_foodDesc_heroHungry = not math.isEmpty(satiety)
  self.bind.txt_foodDesc_heroHungry = string.concat(L_WordsTpl:getValue("ui_hero_food_desc"), satiety)
  local tpl_commonItem = _commonItemTpl:getTplById(self._guid)
  local foodDescHero = _commonItemTpl:getDesc(tpl_commonItem)
  self.bind.go_foodDesc_hero = not string.isEmpty(foodDescHero)
  self.bind.txt_foodDesc_hero = foodDescHero
end

function this:setFishingRodData()
  local isFromPond = not math.isEmpty(self._param.fishPondId)
  self.bind.go_desc = false
  self.bind.go_tag = not isFromPond
  self.bind.go_access = not isFromPond
  self.bind.go_subDescLine = false
  self.bind.go_num = false
  local moduleRodBuff = self.modules.module_fishRodBuff
  moduleRodBuff:setData(self._guid, self._param.fishPondId)
end

function this:setFishingBaitData()
  local isFromPond = not math.isEmpty(self._param.fishPondId)
  self.bind.go_tag = not isFromPond
  self.bind.go_access = not isFromPond
end

function this:reset()
  self.bind.go_funcBtn = false
  self.bind.go_desc = false
  self.bind.go_tag = false
  self.bind.go_desc_sub = false
  self.bind.go_num = false
  self.bind.go_access = false
  self.bind.go_foodBuff = false
  self.bind.go_foodUseBtnGroup = false
  self.bind.go_foodDesc = false
  self.bind.go_moduleFishRodBuff = false
  self.bind.go_soulessenceLevel = false
  self.bind.go_soulessenceAtt = false
  self.bind.go_soulessenceSkillDesc = false
  self.bind.go_subDescLine = false
  self.bind.go_accessoryHeadRank = false
  self.bind.go_saOwner = false
  self.bind.go_saLockBtn = false
  self.bind.go_saMaxLevel = false
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
end

function this:setStar(starNum, maxNum)
  if starNum == 0 and maxNum == nil then
    self.bind.go_starRoot = false
  else
    self.bind.go_starRoot = true
  end
  local stars = {}
  if self._type == L_BagConst.bagTag.soulEssence then
    for i = 1, starNum do
      table.insert(stars, {})
    end
    self.bind.go_soulessenceStar = true
    self.bind.go_star = false
    self.bind.go_goldAccessoryStar = false
    self.bind.list_soulessenceStar:clear()
    self.bind.list_soulessenceStar:insert_array(stars)
  elseif self._type == L_BagConst.bagTag.accessory then
    if self._bGoldSide == true then
      self.bind.go_soulessenceStar = false
      self.bind.go_star = false
      self.bind.go_goldAccessoryStar = true
      for i = 1, maxNum do
        table.insert(stars, {
          go_active = i <= starNum
        })
      end
      self.bind.list_goldAccessoryStar:clear()
      self.bind.list_goldAccessoryStar:insert_array(stars)
    else
      self.bind.go_soulessenceStar = false
      self.bind.go_goldAccessoryStar = false
      self.bind.go_star = true
      for i = 1, maxNum do
        table.insert(stars, {
          go_active = i <= starNum
        })
      end
      self.bind.list_star:clear()
      self.bind.list_star:insert_array(stars)
    end
  else
    self.bind.go_soulessenceStar = false
    self.bind.go_goldAccessoryStar = false
    if starNum == 0 then
      self.bind.go_star = false
    else
      self.bind.go_star = true
      for i = 1, starNum do
        table.insert(stars, {
          go_active = i <= starNum
        })
      end
    end
    self.bind.list_star:clear()
    self.bind.list_star:insert_array(stars)
  end
end

function this:setEmpty()
  self._lastGuid = nil
  self._lastType = nil
end

function this:setType(type)
  self._lastType = type
end

function this:restSelectGuid()
  self._lastGuid = nil
end

function this:restSelectType()
  self._lastType = nil
end

function this:setUseCallBack(cb)
  self._callback = cb
end

function this:onSetFuncBtnContent(id)
  if id == self._guid then
    self.bind.txt_funcBtn = L_WordsTpl:getValue("ui_pageQui_ckEditRoulette_04")
  else
    local tpl = _commonItemTpl:getTplById(self._guid)
    local useType = _commonItemTpl:getUseType(tpl)
    local tpl_use = _commonItemUseTypeTpl:getTplById(useType)
    self.bind.txt_funcBtn = _commonItemUseTypeTpl:getName(tpl_use)
  end
end

function this:checkSoulessenceOnwerByHeroGuid(heroGuid)
  local heroData = L_HeroStore:getHero(heroGuid)
  if heroData == nil then
    return false
  end
  local spiritGuid = L_HeroStore:getHeroSoulEssenceGuid(heroData)
  if spiritGuid == nil or spiritGuid ~= self._guid then
    return false
  end
  return true
end

function this:checkSpiritOnwerPosition(heroGuid, profession)
  if not self:checkSoulessenceOnwerByHeroGuid(heroGuid) then
    return false
  end
  local heroData = L_HeroStore:getHero(heroGuid)
  local tpl = _heroTpl:getTplById(heroData.configId)
  local pos = _heroTpl:getPosition(tpl)
  return profession == pos
end

function this:setEquippedAccessory(heroGuid, isPreview)
  self.modules.toggleAccessorySuit.moduleAccessorySuit:setEquippedSuit(self._guid, heroGuid, isPreview)
  self.bind.go_saMaxLevel = false
end

function this:getQualityBgName(quality)
  quality = quality or 0
  if self.getQualityBgNameFunc then
    return self.getQualityBgNameFunc(quality)
  end
  return string.format("UI/Texture/Bag/tex_bag_rarity_tips_bg_%s.png", quality)
end

function this:setQualityBgFunc(cb)
  self.getQualityBgNameFunc = cb
end

function this:setMapCollectionShow(isShow)
  self.bind.go_access = isShow
  self.bind.go_foodUseBtnGroup = isShow
  self.bind.go_funcBtn = isShow
end

return this
