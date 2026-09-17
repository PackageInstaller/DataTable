local this = class("pageRuneCompose", G_UIPageBase)
local talentRuneTpl = L_GameTpl:getTalentRuneTpl()
local _talentRuneComposeTpl = L_GameTpl:getTalentRuneComposeTpl()
local commonItemTpl = L_GameTpl:getCommonItemTpl()
local _dungeonEntrustTypeTpl = L_GameTpl:getDungeonEntrustTypeTpl()
local _systemLock = L_GameTpl:getSystemUnlockTpl()
local targetNumToMove = 4
local _dungeonEntrustTpl = L_GameTpl:getDungeonEntrustTpl()
local _dungeonMaterialTpl = L_GameTpl:getDungeonMaterialTpl()
local _dungeonMaterialTypeTpl = L_GameTpl:getDungeonMaterialTypeTpl()
local _commonJumpTpl = L_GameTpl:getCommonJumpTpl()
local MAX_COMPOSE_NUM = 999
local DEFAULT_TARGET_NUM = 1
local animMap = {
  [1] = 2,
  [2] = 4,
  [3] = 3,
  [4] = 1
}

function this.bind()
  return {
    targetList = {
      moduleName = "pages/rune/cellRuneComposeTarget"
    },
    composeList = {
      moduleName = "pages/rune/cellComposeMaterial"
    },
    moduleSelectNum = L_Const.ModuleInfo.SelectNum,
    numSelectActive = false,
    targetFocusIndex = 1,
    composeNum = "",
    go_composeNum = false,
    targetStarList = {},
    infoStarList = {},
    targetIcon = "",
    targetInfoIcon = "",
    targetIconBg = "",
    targetIconLight = "",
    img_composeBg = "",
    img_quality = "",
    targetItemName = "",
    targetItemDesc = "",
    hadNumText = "",
    hadNumBg = "",
    needNumText = "",
    runeNameText = "",
    infoCardBg = "",
    go_dungeonAcclist = false,
    dungeonAccessList = {
      moduleName = "pages/rune/cellRuneComposeDungeonAccess"
    },
    go_normalAcclist = false,
    accessList = {
      moduleName = "pages/rune/cellRuneComposeAccess"
    },
    hadFxActive = true,
    composeBtnActive = true,
    txt_compose = "",
    needNumTextActive = true,
    block = false,
    go_lock = false,
    txt_lockDuegondesc = "",
    go_allAccessEmpty = false
  }
end

function this.methods()
  return {
    onClick_composeBtn = function(self)
      local unlock = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.runeCompose)
      if not unlock then
        return
      end
      if self.bComposeMaterial == false then
        return
      end
      if self.bcanDirectCompose == false and self.bCanInDircCompose == false then
        L_FlyMsgManager:showNormalMsgByKey("notice_shortageMaterial")
        return
      end
      
      local function callback(rspData)
        self.bindComponents.showAnim:Stop()
        self.bindComponents.showAnim:Play("anim_rune_synthesis")
        self.bind.block = true
        Timer.once(1.0, function()
          if self.isBind then
            self.bind.block = false
          end
          L_RewardManager:showPage(rspData.rewards.rewards, rspData.src, L_Const.pageRewardType.normal)
        end, self)
      end
      
      local data = {
        item_id = self.curTargetId,
        num = self.targetNum,
        equip = false
      }
      if self.bCanInDircCompose == true then
        local data = {
          txtContent = L_WordsTpl:getValue("notice_talent_rune_submit"),
          itemList = self.materiaList,
          confirmCallback = function()
            L_RuneStore:req_CSProtoComposeRune(data, callback)
          end
        }
        L_GameUtil.showCommonTip(data)
      else
        L_RuneStore:req_CSProtoComposeRune(data, callback)
      end
    end,
    targetList = {
      onClick_item = function(self, data)
        self:switchTarget(data)
      end
    },
    composeList = {
      onClick_item = function(self, data)
        self:switchTarget(data)
      end
    },
    dungeonAccessList = {
      onClick = function(self, data)
        if data.dungeonType == "material" then
          local unlockId = L_SystemConst.enum.dungeonMaterial
          if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(unlockId) then
            L_FlyMsgManager:showNormalMsg(C_IntegrateMgr.SystemUnlockModule:getSystemUnlockConditionDesc(unlockId))
            return
          end
          local matCfg = _dungeonMaterialTpl:getTplById(data.selectId)
          if matCfg then
            local unlockCond = _dungeonMaterialTpl:getUnlock(matCfg)
            local isComplete = true
            local failCondId
            for _, cond in ipairs(unlockCond) do
              local csList = CS.System.Collections.Generic.List(CS.System.Int32)()
              for _, v in ipairs(cond) do
                csList:Add(v)
              end
              local condId = AzurWorld.ConditionMgr:CreateCond(csList, nil)
              if not AzurWorld.ConditionMgr:CheckCond(condId) then
                isComplete = false
                failCondId = condId
                break
              end
            end
            if not isComplete then
              local condObj = AzurWorld.ConditionMgr:GetCond(failCondId)
              if condObj then
                L_FlyMsgManager:showNormalMsg(condObj:ShowMsg())
              end
              return
            end
          end
          local jumpTagId = 0
          local jumpTypeId = 0
          if matCfg then
            jumpTypeId = _dungeonMaterialTpl:getTypeId(matCfg) or 0
            local typeCfg = jumpTypeId ~= 0 and _dungeonMaterialTypeTpl:getTplById(jumpTypeId)
            if typeCfg then
              jumpTagId = _dungeonMaterialTypeTpl:getTagId(typeCfg) or 0
            end
          end
          L_UI:open("pageDungeonMaterial", {
            jumpParams = {
              jumpTagId,
              jumpTypeId,
              data.selectId
            }
          })
          return
        end
        local realEntrustId = data.selectId
        local tpl = _dungeonEntrustTypeTpl:getTplById(data.entrustType)
        local unlockId = _dungeonEntrustTypeTpl:getSystemUnLockId(tpl)
        if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(unlockId) then
          L_FlyMsgManager:showNormalMsg(C_IntegrateMgr.SystemUnlockModule:getSystemUnlockConditionDesc(unlockId))
          return
        end
        local lockTpl = _systemLock:getTplById(unlockId)
        if lockTpl then
          local conditionList = _systemLock:getUnlockCondi(lockTpl)
          local isComplete = true
          local failCondId
          for _, cond in ipairs(conditionList) do
            local csList = CS.System.Collections.Generic.List(CS.System.Int32)()
            for _, v in ipairs(cond) do
              csList:Add(v)
            end
            local condId = AzurWorld.ConditionMgr:CreateCond(csList, nil)
            if not AzurWorld.ConditionMgr:CheckCond(condId) then
              isComplete = false
              failCondId = condId
              break
            end
          end
          if not isComplete then
            local condObj = AzurWorld.ConditionMgr:GetCond(failCondId)
            if condObj then
              L_FlyMsgManager:showNormalMsg(condObj:ShowMsg())
            end
            return
          end
        end
        local isComplete = L_EntrustStore:checkEntrustLevelUnlock(data.selectId)
        local found = false
        if not isComplete then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_target_dungeon_entrust_locked"), 2)
          local modeInfo = _dungeonEntrustTpl:getInfoByDifficulty()
          for i = #modeInfo, 1, -1 do
            local levelGroup = modeInfo[i]
            for j = #levelGroup.levelInfos, 1, -1 do
              local levelInfo = levelGroup.levelInfos[j]
              local levelId = _dungeonEntrustTpl:getId(levelInfo)
              if L_EntrustStore:checkEntrustLevelUnlock(levelId) then
                realEntrustId = levelId
                found = true
                break
              end
              if found then
                break
              end
            end
            if found then
              break
            end
          end
        end
        AzurWorld.DungeonEntrustManager:JumpToMainEntrust(_dungeonEntrustTpl:getGroupId(_dungeonEntrustTpl:getTplById(realEntrustId)), isComplete and realEntrustId or 0)
        if data.selectId == realEntrustId then
          L_EntrustStore:setIsRuneJump(true)
          L_EntrustStore:setCurLackRuneInfo({
            runeId = data.runeId,
            itemId = data.itemId,
            needTargetNum = data.needTargetNum,
            heroGuid = self.options.heroGuid,
            canEquip = self.options.canEquip,
            currentRank = self.options.currentRank,
            isEquiped = self.options.isEquiped,
            slotId = self.options.slotId,
            EntrustId = data.selectId
          })
        end
      end
    },
    onClick_closeBtn = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.onEvent_composeSuccessHandle = handler(self, self.onEvent_composeSuccess)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self.onEvent_composeSuccessHandle)
  self.targetList = {}
  self.options = options
  self:setTargetNum(DEFAULT_TARGET_NUM)
  self:refreshPage(options)
  self:initSelectNumModule()
end

function this:show(pageName)
  L_EntrustStore:clearRuneRecord()
end

function this:close()
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self.onEvent_composeSuccessHandle)
end

function this:onEvent_composeSuccess()
  self.needTargetNum = self.needTargetNum - self.targetNum
  if self.needTargetNum < 1 then
    self.needTargetNum = 1
  end
  self:setTargetNum(self.needTargetNum)
  self:refreshTarget(self.curTargetId, true, true)
  self:initSelectNumModule()
end

function this:switchTarget(data)
  local needNum = data.targetNum - data.hadNum
  local maxNum = L_RuneStore:getMaxCanCompose(data.itemId)
  local num = math.min(needNum, maxNum)
  self.needTargetNum = 0 < num and num or 1
  self:setTargetNum(num)
  self:refreshTarget(data.itemId, false)
  self:initSelectNumModule()
  self.bindComponents.showAnim:Stop()
  if data.index then
    self.bindComponents.showAnim:Play("anim_rune_change_" .. animMap[data.index])
  else
    self.bindComponents.showAnim:Play("anim_rune_change_back")
  end
end

function this:initSelectNumModule()
  local max = math.max(L_RuneStore:getMaxCanCompose(self.curTargetId), self.needTargetNum)
  local min = DEFAULT_TARGET_NUM
  
  local function func(num)
    self:setTargetNum(num, true)
  end
  
  self.modules.moduleSelectNum:initModule(func, max, min, self.targetNum)
  func(self.targetNum)
end

function this:refreshPage(options)
  self:refreshTarget(options.itemId, false)
end

function this:setTargetNum(targetNum, isRefresh)
  self.targetNum = targetNum
  if isRefresh then
    for i = 1, #self.bind.composeList do
      local base = self.bind.composeList:getValue(i, "baseNeed")
      if base ~= nil then
        self.bind.composeList:change(i, {
          needNum = base * targetNum
        })
      end
    end
    for _, v in ipairs(self.targetList) do
      if v.itemId == self.curTargetId then
        v.targetNum = targetNum
      end
    end
    self:refreshTargetItem(self.curTargetId, true)
    self:refreshBtnStatus()
  end
end

function this:refreshTarget(itemId, isForce, isExistAnim)
  if self.curTargetId == itemId and not isForce then
    return
  end
  self.curTargetId = itemId
  self:refreshTargetItem(itemId, isExistAnim)
  self:refreshTargetList(itemId)
  self:refreshComposeList(itemId)
  self:refreshBtnStatus()
end

function this:refreshBtnStatus()
  self.bcanDirectCompose = true
  self.bCanInDircCompose = false
  if #self.bind.composeList > 0 then
    for i = 1, #self.bind.composeList do
      local hold = self.bind.composeList:getValue(i, "hadNum")
      local target = self.bind.composeList:getValue(i, "needNum")
      if hold ~= nil and target ~= nil and hold < target then
        self.bcanDirectCompose = false
      end
    end
  end
  if self.bcanDirectCompose == false then
    self.bCanInDircCompose, self.materiaList = L_RuneStore:bCanCompose(self.curTargetId, self.targetNum)
  end
  if self.bCanInDircCompose then
    self.bind.txt_compose = L_WordsTpl:getValue("ui_talent_rune_btn_auto_compose")
  else
    self.bind.txt_compose = L_WordsTpl:getValue("ui_talent_rune_btn_compose")
  end
end

function this:refreshComposeList(itemId)
  self.bind.composeList:clear()
  local composeTpl = _talentRuneComposeTpl:getTplById(itemId)
  if not composeTpl then
    local itemData = {}
    for i = 1, 4 do
      table.insert(itemData, {isEmpty = true})
    end
    self.bind.composeList:insert_array(itemData)
    return
  end
  local items = _talentRuneComposeTpl:getItems(composeTpl)
  local itemData = {}
  for i = 1, 4 do
    local item = items[i]
    if item ~= nil then
      table.insert(itemData, {
        itemType = item[1],
        itemId = item[2],
        needNum = item[3] * self.targetNum,
        baseNeed = item[3],
        index = i,
        showType = L_Const.runeComposeType.compose,
        listSize = self.bindComponents.composeList.sizeDelta,
        hadNum = C_BagMgr:getItemNumByItemId(item[2])
      })
    else
      table.insert(itemData, {isEmpty = true})
    end
  end
  self.bind.composeList:insert_array(itemData)
end

function this:refreshTargetItem(itemId, isExistAnim)
  self.targetData = {
    holdNum = C_BagMgr:getItemNumByItemId(itemId),
    itemId = itemId,
    showType = L_Const.runeComposeType.target,
    targetNum = self.targetNum
  }
  local item = L_ItemTplManager:getCommonItem(itemId)
  self.bind.targetIcon = item.icon
  self.bind.targetInfoIcon = item.icon
  local tpl = commonItemTpl:getTplById(itemId)
  local rarity = commonItemTpl:getRarity(tpl) == nil and 0 or commonItemTpl:getRarity(tpl)
  self:setStars(rarity + 1)
  self.bind.img_quality = string.format("UI/Atlas/BSCommon/tex_homecommontip_bg_quality_%d.png", rarity)
  self.bind.targetIconBg = string.format("UI/Texture/HeroRune/tex_talentrunecompose_bg_hc_o0%d.png", rarity)
  self.bind.targetIconLight = string.format("UI/Texture/HeroRune/tex_talentrunecompose_bg_hc_l0%d.png", rarity)
  self.bind.img_composeBg = string.format("UI/Texture/HeroRune/tex_talentrunecompose_bg_hc_all0%d.png", rarity)
  self.bind.hadNumBg = string.format("UI/Texture/HeroRune/tex_talentrunecompose_bg_sl_t0%d.png", rarity)
  self.bind.infoCardBg = string.format("UI/Texture/HeroRune/tex_talentrunecompose_bg_xq_t0%d.png", rarity)
  self.bind.targetItemName = item.name
  self.bind.runeNameText = item.name
  self.bind.targetItemDesc = item.desc
  self.bind.hadNumText = L_WordsTpl:getValue("ui_talent_rune_compose_01", {
    [0] = self.targetData.holdNum
  })
  local needStr = tostring(self.targetData.holdNum)
  if self.needTargetNum == nil then
    self.needTargetNum = self.targetNum
  end
  if self.targetData.holdNum < self.needTargetNum then
    needStr = L_GameUtil.fillColor(needStr, L_Const.colorHtml.red009)
  end
  self.bind.needNumText = L_WordsTpl:getValue("ui_talent_rune_compose_03", {
    [0] = needStr,
    [1] = self.needTargetNum
  })
  local runeTpl = talentRuneTpl:getTplByItemId(itemId)
  self.bLeafNode = _talentRuneComposeTpl:getIsLeafNode(itemId)
  self.bUnlock = true
  local composeTpl = _talentRuneComposeTpl:getTplById(itemId)
  if self.bLeafNode == false then
    local composeCond = _talentRuneComposeTpl:getComposeCondition(composeTpl)
    self.bUnlock = true
    for _, cond in ipairs(composeCond) do
      local csList = CS.System.Collections.Generic.List(CS.System.Int32)()
      for _, v in ipairs(cond) do
        csList:Add(v)
      end
      local condId = AzurWorld.ConditionMgr:CreateCond(csList, nil)
      if not AzurWorld.ConditionMgr:CheckCond(condId) then
        self.bUnlock = false
        break
      end
    end
  end
  self.bComposeMaterial = _talentRuneComposeTpl:getIsComposeMaterial(itemId)
  self.normalMaxNum = L_RuneStore:getNormalComposeNum(itemId)
  self.totalMaxNum = L_RuneStore:getMaxCanCompose(itemId)
  if self.bUnlock then
    self.bind.go_lock = false
    self.bind.numSelectActive = self.bComposeMaterial
    self.bind.composeBtnActive = self.bComposeMaterial
    self.bind.go_composeNum = true
  else
    self.bind.go_lock = true
    self.bind.numSelectActive = false
    self.bind.composeBtnActive = false
    self.bind.go_composeNum = false
    local cond1 = _talentRuneComposeTpl:getComposeCondition(composeTpl)[1]
    self.bind.txt_lockDuegondesc = L_WordsTpl:getValue("ui_talent_rune_unlock_text", {
      [0] = _dungeonEntrustTpl:getName(_dungeonEntrustTpl:getTplById(cond1[2]))
    })
  end
  self.bind.hadFxActive = self.bComposeMaterial
  if self.bComposeMaterial then
    self.bind.composeNum = L_WordsTpl:getValue("notice_pageRuneCompose", {
      [0] = self.totalMaxNum
    })
  else
    self.bind.composeNum = L_WordsTpl:getValue("ui_talent_rune_compose_04")
  end
  local accessList = commonItemTpl:getWayList(tpl)
  local dungeonIdSet = {}
  local listRuneData = _dungeonEntrustTpl:getRuneDungeonMap()[itemId]
  if listRuneData then
    for _, value in ipairs(listRuneData) do
      dungeonIdSet[value.dungeonId] = true
    end
  end
  local matRuneData = _dungeonMaterialTpl:getRuneDungeonMap()[itemId]
  if matRuneData then
    for _, value in pairs(matRuneData) do
      dungeonIdSet[value.dungeonId] = true
    end
  end
  if not isExistAnim then
    self:refreshAccessList(accessList, itemId, dungeonIdSet)
  end
  local res = {}
  local listRuneData = _dungeonEntrustTpl:getRuneDungeonMap()[itemId]
  if listRuneData then
    for key, value in ipairs(listRuneData) do
      local isComplete = L_EntrustStore:checkEntrustLevelUnlock(value.dungeonId) and C_IntegrateMgr.SystemUnlockModule:Check(L_SystemConst.enum.entrustTask)
      table.insert(res, {
        dungeonId = value.dungeonId,
        bUnlock = isComplete,
        lv = _dungeonEntrustTpl:getRecommendLevel(_dungeonEntrustTpl:getTplById(value.dungeonId)),
        runeId = self.options.runeId,
        itemId = itemId,
        needTargetNum = self.needTargetNum,
        dungeonType = "entrust"
      })
    end
  end
  if _dungeonMaterialTpl:getRuneDungeonMap()[itemId] then
    for key, value in pairs(_dungeonMaterialTpl:getRuneDungeonMap()[itemId]) do
      local matCfg = _dungeonMaterialTpl:getTplById(value.dungeonId)
      local isComplete = true
      if matCfg then
        local unlockCond = _dungeonMaterialTpl:getUnlock(matCfg)
        for _, cond in ipairs(unlockCond) do
          local csList = CS.System.Collections.Generic.List(CS.System.Int32)()
          for _, v in ipairs(cond) do
            csList:Add(v)
          end
          local condId = AzurWorld.ConditionMgr:CreateCond(csList, nil)
          if not AzurWorld.ConditionMgr:CheckCond(condId) then
            isComplete = false
            break
          end
        end
      end
      table.insert(res, {
        dungeonId = value.dungeonId,
        bUnlock = isComplete,
        lv = matCfg and _dungeonMaterialTpl:getRecommendLevel(matCfg) or 0,
        runeId = self.options.runeId,
        itemId = itemId,
        needTargetNum = self.needTargetNum,
        dungeonType = "material"
      })
    end
  end
  if 0 < #res then
    table.sort(res, function(a, b)
      if a.bUnlock ~= b.bUnlock then
        return a.bUnlock
      elseif a.lv ~= b.lv then
        if a.bUnlock then
          return a.lv > b.lv
        else
          return a.lv < b.lv
        end
      elseif a.dungeonId ~= b.dungeonId then
        return a.dungeonId < b.dungeonId
      end
    end)
    self.bind.dungeonAccessList:clear()
    self.bind.dungeonAccessList:insert_array(res)
    self.bind.go_dungeonAcclist = true
  else
    self.bind.go_dungeonAcclist = false
  end
  if self.bind.go_dungeonAcclist == false and self.bind.go_normalAcclist == false then
    self.bind.go_allAccessEmpty = true
  else
    self.bind.go_allAccessEmpty = false
  end
end

function this:refreshAccessList(accessList, itemId, dungeonIdSet)
  self.bind.go_access = not table.isEmpty(accessList)
  local tmp = {}
  local playTime = 0.1
  dungeonIdSet = dungeonIdSet or {}
  for _, v in ipairs(accessList) do
    if v.id ~= L_SystemConst.jumpEnum.runeCompose and v.id ~= L_SystemConst.jumpEnum.areaDelegate then
      local isDuplicate = false
      if not table.isEmpty(dungeonIdSet) then
        local jumpCfg = _commonJumpTpl:getTplById(v.id)
        if jumpCfg then
          local param = _commonJumpTpl:getParam(jumpCfg)
          if param then
            for _, p in ipairs(param) do
              local numId = tonumber(p)
              if numId and dungeonIdSet[numId] then
                isDuplicate = true
                break
              end
            end
          end
        end
      end
      if not isDuplicate then
        table.insert(tmp, {
          systemId = v.id,
          txt_access = v.desc,
          itemId = itemId,
          playTime = playTime
        })
        playTime = playTime + 0.05
      end
    end
  end
  if 0 < #tmp then
    self.bind.go_normalAcclist = true
    self.bind.accessList:clear()
    self.bind.accessList:insert_array(tmp)
  else
    self.bind.go_normalAcclist = false
  end
  for _, access in pairs(self.modules.accessList) do
    access:playFx()
  end
end

function this:setStars(num)
  if not self.isBind then
    return
  end
  local stars = {}
  for i = 1, num do
    table.insert(stars, {})
  end
  self.bind.targetStarList:clear()
  self.bind.targetStarList:insert_array(stars)
  self.bind.infoStarList:clear()
  self.bind.infoStarList:insert_array(stars)
end

function this:refreshTargetList(itemId)
  local isOld = false
  local data = {}
  for _, v in ipairs(self.targetList) do
    v.needToPlay = false
    table.insert(data, v)
    if v.itemId == itemId then
      isOld = true
      break
    end
  end
  if not isOld then
    table.insert(data, {
      itemId = itemId,
      targetIndex = #self.targetList + 1,
      showType = L_Const.runeComposeType.targetList,
      targetNum = self.targetNum,
      needToPlay = true,
      hadNum = C_BagMgr:getItemNumByItemId(itemId)
    })
  end
  self.targetList = data
  for _, v in ipairs(self.targetList) do
    v.isTarget = v.itemId == itemId
    v.totalIndex = #self.targetList
  end
  self.bind.targetList:clear()
  self.bind.targetList:insert_array(self.targetList)
  self.bindComponents.targetListComp.disableScroll = #self.targetList < targetNumToMove
  self.bind.targetFocusIndex = #self.targetList
end

return this
