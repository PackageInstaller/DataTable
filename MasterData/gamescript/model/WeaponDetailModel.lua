local Quality2ExpType = {
  Orange = "OrangeWeaponLevelUpExp",
  Purple = "PurpleWeaponLevelUpExp",
  Blue = "BlueWeaponLevelUpExp"
}

local function TotalExpOfLevel(targetLv, expType)
  if 1 == targetLv then
    return 0
  end
  local exp = 0
  for lv, cfg in ipairs(DT.WeaponLevelUpExp) do
    exp = exp + cfg[expType]
    if lv == targetLv - 1 then
      break
    end
  end
  return exp
end

local function GetWeaponPrimAttrList(weapon)
  local attrList = {}
  if not weapon.tid then
    return attrList
  end
  if weapon.mainAttr then
    if table.next(weapon.mainAttr) then
      local AttrTypeMap = AttrUtils.GetAttrTypeMap()
      for t, v in pairs(weapon.mainAttr) do
        table.insert(attrList, {
          id = AttrTypeMap[t],
          value = v
        })
      end
      table.sort(attrList, function(a, b)
        local aCfg = DT.ActorAttrType[a.id]
        local bCfg = DT.ActorAttrType[b.id]
        return aCfg.BaseSortID < bCfg.BaseSortID
      end)
    else
      Logger.Error("[武器] 获取主属性列表失败！服务器下发的\"mainAttr\"字段为空table！tid:%s uid:%s", weapon.tid, weapon.uid)
    end
  end
  return attrList
end

local function createWeaponDetailState(weapon, awakerModel)
  local state = {}
  state.weapon = weapon
  state.awakerModel = awakerModel
  
  function state.weaponConfig()
    if state.weapon == nil then
      return nil
    end
    if 0 == state.weapon.tid then
      return CommonDefine.DummyWeapon.Config
    end
    return DT.Item[state.weapon.tid]
  end
  
  if state.weapon then
    state.enhanceLevelPreview = {
      before = state.weapon.enhanceLevel or 1,
      after = 0
    }
    state.enhanceExpPreview = {curr = 0, max = 1}
    local primAttrList = GetWeaponPrimAttrList(state.weapon)
    if #primAttrList <= 0 then
      return state
    end
    local primAttr_1 = primAttrList[1]
    local primAttr_2 = primAttrList[2]
    local primAttr_3 = primAttrList[3]
    local secAttr = ItemDataUtils.GetWeaponSecAttr(state.weapon)
    state.enhanceAttrPreview = {
      prim = {
        {
          id = primAttr_1.id,
          before = primAttr_1.value,
          after = 0
        },
        {
          id = primAttr_2.id,
          before = primAttr_2.value,
          after = 0
        },
        {
          id = primAttr_3.id,
          before = primAttr_3.value,
          after = 0
        }
      },
      sec = {
        id = secAttr.id,
        before = secAttr.value,
        after = 0
      }
    }
    state.primAttrInc = {}
    local factor = DT.GetConstant("WeaponUpgradeBoostPropertyRate")
    local cfg = state.weaponConfig()
    for idx = 1, #cfg.WeaponMainAttribute - 1, 2 do
      local id = cfg.WeaponMainAttribute[idx]
      local value = cfg.WeaponMainAttribute[idx + 1]
      state.primAttrInc[id] = value * factor
    end
  end
  return state
end

local function createWeaponDetailViews()
  local views = {}
  
  function views:RefineOnly()
    return true
  end
  
  function views:GetPrimaryAttrs()
    do return GetWeaponPrimAttrList end
    return GetWeaponPrimAttrList, self.weapon
  end
  
  function views:GetSecondaryAttr()
    do return ItemDataUtils.GetWeaponSecAttr end
    return ItemDataUtils.GetWeaponSecAttr, self.weapon
  end
  
  function views:GetEnhanceAttrPreview()
    return self.enhanceAttrPreview
  end
  
  function views:GetEnhanceLevel()
    return self.weapon.enhanceLevel or 1
  end
  
  function views:GetEnhanceLevelLimit()
    local breakthroughStar = self:GetBreakthroughStar()
    local levelLimitList = DT.GetOriginalConstant("WeaponBreakthroughRequiredUpgradeLevel")
    return levelLimitList[breakthroughStar + 1] or CommonDefine.WeaponEnhance.MaxLevel
  end
  
  function views:GetNextEnhanceLevelLimit()
    local breakthroughStar = self:GetBreakthroughStar()
    local levelLimitList = DT.GetOriginalConstant("WeaponBreakthroughRequiredUpgradeLevel")
    return levelLimitList[breakthroughStar + 2] or CommonDefine.WeaponEnhance.MaxLevel
  end
  
  function views:IsReachEnhanceLevelLimit()
    local level = self:GetEnhanceLevel()
    local levelLimit = self:GetEnhanceLevelLimit()
    return level == levelLimit
  end
  
  function views:GetEnhanceLevelPreview()
    return self.enhanceLevelPreview
  end
  
  function views:GetEnhanceExpPreview()
    return self.enhanceExpPreview
  end
  
  function views:GetCurrEnhanceExp()
    return self.weapon.exp or 0
  end
  
  function views:GetEnhanceExpToNextLevel()
    local currLevel = self:GetEnhanceLevel()
    do return self.GetEnhanceExpToLevel, self end
    return self.GetEnhanceExpToLevel, self, currLevel + 1
  end
  
  function views:GetEnhanceExpToLevel(level)
    if 1 == level then
      return 0
    end
    if level > CommonDefine.WeaponEnhance.MaxLevel then
      return -1
    end
    if not self.weaponConfig then
      return -1
    end
    local quality = self.weaponConfig.Quality
    local expType = Quality2ExpType[quality]
    if not expType then
      return -1
    end
    return DT.WeaponLevelUpExp[level - 1][expType]
  end
  
  function views:GetTotalEnhanceExp()
    return self:GetTotalExpToCurrEnhanceLevel() + self:GetCurrEnhanceExp()
  end
  
  function views:GetTotalExpToCurrEnhanceLevel()
    if not self.weaponConfig then
      return 0
    end
    local quality = self.weaponConfig.Quality
    local expType = Quality2ExpType[quality]
    if not expType then
      return 0
    end
    local currLevel = self:GetEnhanceLevel()
    do return TotalExpOfLevel, currLevel end
    return TotalExpOfLevel, currLevel, expType
  end
  
  function views:GetTotalExpToNextEnhanceLevel()
    if not self.weaponConfig then
      return 0
    end
    local quality = self.weaponConfig.Quality
    local expType = Quality2ExpType[quality]
    if not expType then
      return 0
    end
    local currLevel = self:GetEnhanceLevel()
    do return TotalExpOfLevel, currLevel + 1 end
    return TotalExpOfLevel, currLevel + 1, expType
  end
  
  function views:GetTotalExpToEnhanceLevelLimit()
    if not self.weaponConfig then
      return 0
    end
    local quality = self.weaponConfig.Quality
    local expType = Quality2ExpType[quality]
    if not expType then
      return 0
    end
    local levelLimit = self:GetEnhanceLevelLimit()
    do return TotalExpOfLevel, levelLimit end
    return TotalExpOfLevel, levelLimit, expType
  end
  
  function views:GetTotalExpToNextLevelOfEnhanceLevelLimit()
    if not self.weaponConfig then
      return 0
    end
    local quality = self.weaponConfig.Quality
    local expType = Quality2ExpType[quality]
    if not expType then
      return 0
    end
    local levelLimit = self:GetEnhanceLevelLimit()
    do return TotalExpOfLevel, levelLimit + 1 end
    return TotalExpOfLevel, levelLimit + 1, expType
  end
  
  function views:GetBreakthroughStar()
    return self.weapon.breakLevel or 0
  end
  
  function views:IsReachBreakthroughLimit()
    local breakthroughStar = self:GetBreakthroughStar()
    local levelLimitList = DT.GetOriginalConstant("WeaponBreakthroughRequiredUpgradeLevel")
    return breakthroughStar == #levelLimitList
  end
  
  function views:GetEnhanceLevelBreakthroughPreview()
    return self.enhanceLevelBreakthroughPreview
  end
  
  function views:GetBreakthroughAttrPreview()
    return self.breakthroughAttrPreview
  end
  
  function views:GetNextBreakthroughPlayerLevel()
    local breakthroughStar = self:GetBreakthroughStar()
    local playerLevelList = DT.GetOriginalConstant("PlayerLevelRequiredForWeaponBreakthrough")
    return playerLevelList[breakthroughStar + 1] or 0
  end
  
  function views:GetWeaponName()
    if self.weaponConfig == nil then
      return ""
    end
    do return LT.Text end
    return LT.Text, self.weaponConfig.Name
  end
  
  function views:GetWeaponPainting()
    if self.weaponConfig == nil then
      return ""
    end
    return self.weaponConfig.Icon
  end
  
  function views:GetWeaponQuality()
    if self.weaponConfig == nil then
      return ""
    end
    return self.weaponConfig.Quality
  end
  
  function views:GetWeaponBreakthroughMtrlTypes()
    if self.weaponConfig == nil then
      return nil
    end
    return self.weaponConfig.WeaponBreakthroughMaterialModule or {}
  end
  
  function views:GetWeaponlevel()
    if self.weapon == nil then
      return 0
    end
    if self.weapon.level then
      return self.weapon.level
    end
    if self.weapon.tid then
      do return ItemDataUtils.GetItemDefaultLevel end
      return ItemDataUtils.GetItemDefaultLevel, self.weapon.tid
    end
    return 0
  end
  
  function views:GetSubTypeName()
    if self.weapon == nil then
      return ""
    end
    do return ItemDataUtils.GetItemSubTypeName end
    return ItemDataUtils.GetItemSubTypeName, self.weapon.tid
  end
  
  function views:GetItemType()
    if self.weapon == nil then
      return
    end
    do return ItemDataUtils.GetItemType end
    return ItemDataUtils.GetItemType, self.weapon.tid
  end
  
  function views:IsPrimitiveWeapon()
    if self.weapon == nil then
      return true
    end
    return 0 == self.weapon.level
  end
  
  function views:GetWeaponAttrName()
    if self.weapon == nil then
      return ""
    end
    do return ItemDataUtils.GetWeaponAttrName end
    return ItemDataUtils.GetWeaponAttrName, self.weapon.tid
  end
  
  function views:HasOwner()
    if self.weapon == nil then
      return false
    end
    return nil ~= self.weapon.awaker and 0 ~= self.weapon.awaker
  end
  
  function views:GetAwakerName()
    if self.weapon.awaker == nil or 0 == self.weapon.awaker then
      return ""
    end
    local ownAwaker = self.weapon.awaker
    if self.awakerModel.selectAwakerId and 0 ~= self.awakerModel.selectAwakerId then
      local changeFormAwaker = AwakerDataUtils.GetChangerForm(ownAwaker)
      if ownAwaker == self.awakerModel.selectAwakerId or changeFormAwaker == self.awakerModel.selectAwakerId then
        ownAwaker = self.awakerModel.selectAwakerId
      end
    elseif not AwakerDataUtils.IsAwakerShow(ownAwaker) then
      ownAwaker = AwakerDataUtils.GetChangerForm(ownAwaker)
    end
    local awakerConfig = DT.AwakerConfig[ownAwaker]
    do return LT.Text end
    return LT.Text, awakerConfig.Title
  end
  
  function views:GetAwakerIcon()
    if self.weapon.awaker == nil or 0 == self.weapon.awaker then
      return ""
    end
    local ownAwaker = self.weapon.awaker
    if self.awakerModel.selectAwakerId and 0 ~= self.awakerModel.selectAwakerId then
      local changeFormAwaker = AwakerDataUtils.GetChangerForm(ownAwaker)
      if ownAwaker == self.awakerModel.selectAwakerId or changeFormAwaker == self.awakerModel.selectAwakerId then
        ownAwaker = self.awakerModel.selectAwakerId
      end
    elseif not AwakerDataUtils.IsAwakerShow(ownAwaker) then
      ownAwaker = AwakerDataUtils.GetChangerForm(ownAwaker)
    end
    do return AwakerDataUtils.GetLittleIcon end
    return AwakerDataUtils.GetLittleIcon, ownAwaker
  end
  
  function views:GetAwakerQualityDesc()
    if self.weapon.awaker == nil or 0 == self.weapon.awaker then
      return ""
    end
    local ownAwaker = self.weapon.awaker
    if self.awakerModel.selectAwakerId and 0 ~= self.awakerModel.selectAwakerId then
      local changeFormAwaker = AwakerDataUtils.GetChangerForm(ownAwaker)
      if ownAwaker == self.awakerModel.selectAwakerId or changeFormAwaker == self.awakerModel.selectAwakerId then
        ownAwaker = self.awakerModel.selectAwakerId
      end
    elseif not AwakerDataUtils.IsAwakerShow(ownAwaker) then
      ownAwaker = AwakerDataUtils.GetChangerForm(ownAwaker)
    end
    local awakerConfig = DT.AwakerConfig[ownAwaker]
    local key = string.format("Quality%s", awakerConfig.Quality)
    do return LT.Text end
    return LT.Text, key
  end
  
  function views:GetSchoolIcon()
    if self.weapon.awaker == nil or 0 == self.weapon.awaker then
      return ""
    end
    local awakerConfig = DT.AwakerConfig[self.weapon.awaker]
    local schoolConfig = DT.SchoolConfig[awakerConfig.School]
    return schoolConfig.Icon
  end
  
  function views:GetSchoolName()
    if self.weapon.awaker == nil or 0 == self.weapon.awaker then
      return ""
    end
    local awakerConfig = DT.AwakerConfig[self.weapon.awaker]
    local schoolConfig = DT.SchoolConfig[awakerConfig.School]
    do return LT.Text end
    return LT.Text, schoolConfig.Name
  end
  
  function views:GetWeaponQualityDesc()
    if not self.weaponConfig then
      return ""
    end
    local key = string.format("Quality%s", self.weaponConfig.Quality)
    do return LT.Text end
    return LT.Text, key
  end
  
  function views:GetStateDesc()
    if self.weapon == nil then
      return ""
    end
    do return SkillUtils.GetWeaponStateDesc, self.weapon.tid end
    return SkillUtils.GetWeaponStateDesc, self.weapon.tid, self.weapon.level
  end
  
  function views:GetExclusiveDesc()
    if self.weaponConfig == nil then
      return ""
    end
    if nil == self.weaponConfig.SpParam then
      return ""
    end
    local awakerTid = self.weaponConfig.SpParam[3]
    if nil == awakerTid then
      return ""
    end
    local color = "#AAAAAA"
    if self:HasOwner() then
      local ownerAwakerConfig = DT.AwakerConfig[self.weapon.awaker]
      if ownerAwakerConfig.ID == awakerTid then
        color = "#FFFFFF"
      end
    end
    local exclusiveAwakerConfig = DT.AwakerConfig[awakerTid]
    local exclusiveAwakerName = LT.Text(exclusiveAwakerConfig.Title)
    local tips = LT.Textf("WeaponExclusiveTips", exclusiveAwakerName, exclusiveAwakerName)
    do return string.format, "<Color='%s'>%s</Color>", color end
    return string.format, "<Color='%s'>%s</Color>", color, tips
  end
  
  function views:GetStory()
    if self.weaponConfig == nil then
      return ""
    end
    return self.weaponConfig.StoryDesc or ""
  end
  
  function views:GetWeapponAttrValue()
    if self.weapon == nil then
      return 0
    end
    do return ItemDataUtils.GetWeaponAttrValue end
    return ItemDataUtils.GetWeaponAttrValue, self.weapon.tid
  end
  
  return views
end

local function createWeaponDetailActions(data)
  local actions = {}
  
  function actions:SetWeapon(weapon)
    data.weapon = weapon
    if not data.weapon.tid then
      return
    end
    data.primAttrInc = {}
    local factor = DT.GetConstant("WeaponUpgradeBoostPropertyRate")
    local cfg = data.weaponConfig
    for idx = 1, #cfg.WeaponMainAttribute - 1, 2 do
      local id = cfg.WeaponMainAttribute[idx]
      local value = cfg.WeaponMainAttribute[idx + 1]
      data.primAttrInc[id] = value * factor
    end
  end
  
  function actions:ReqEnhanceWeapon(mtrlList, callback)
    ProtoManager.Instance:ReqServer("GameRequest", "OnEnhanceWeapon", function(svrData)
      data:_UpdateWeaponData(svrData)
      if callback then
        callback(svrData.backItems)
      end
    end, nil, data.weapon.uid, mtrlList)
  end
  
  function actions:ReqBreakthroughWeapon(callback)
    ProtoManager.Instance:ReqServer("GameRequest", "OnBreakWeapon", function(svrData)
      data:_UpdateWeaponData(svrData)
      if callback then
        callback()
      end
    end, nil, data.weapon.uid)
  end
  
  function actions:_UpdateWeaponData(svrData)
    if svrData.enhanceLevel then
      data.weapon.enhanceLevel = svrData.enhanceLevel
    end
    if svrData.exp then
      data.weapon.exp = svrData.exp
    end
    if svrData.breakLevel then
      data.weapon.breakLevel = svrData.breakLevel
    end
    local weaponMainAttr = data.weapon.mainAttr
    local serverMainAttr = svrData.mainAttr
    for t, _ in pairs(weaponMainAttr) do
      local value = serverMainAttr[t]
      if value then
        weaponMainAttr[t] = value
      end
    end
    local weaponSubAttr = data.weapon.subAttr
    local serverSubAttr = svrData.subAttr
    for t, _ in pairs(weaponSubAttr) do
      local value = serverSubAttr[t]
      if value then
        weaponSubAttr[t] = value
      end
    end
  end
  
  function actions:UpdateEnhancePreview(exp)
    data:_CalcEnhanceLevelChange(exp)
    data:_CalcEnhanceExpChange(exp)
    data:_CalcAttrChange()
  end
  
  function actions:_CalcEnhanceLevelChange(exp)
    if not data.weapon then
      return
    end
    if 0 == exp then
      data.enhanceLevelPreview = {
        before = data.weapon.enhanceLevel or 1,
        after = data.weapon.enhanceLevel or 1
      }
      return
    end
    local quality = data.weaponConfig.Quality
    local expType = Quality2ExpType[quality]
    if not expType then
      return
    end
    local totalExp = data:GetTotalEnhanceExp() + exp
    local achievableLevel = 0
    local maxLevel = CommonDefine.WeaponEnhance.MaxLevel
    for lv = 1, maxLevel do
      if totalExp >= TotalExpOfLevel(lv, expType) then
        achievableLevel = lv
      end
    end
    local levelLimit = data:GetEnhanceLevelLimit()
    data.enhanceLevelPreview = {
      before = data.weapon.enhanceLevel or 1,
      after = math.min(achievableLevel, levelLimit)
    }
  end
  
  function actions:_CalcEnhanceExpChange(exp)
    if not data.weapon then
      return
    end
    if 0 == exp then
      data.enhanceExpPreview = {
        curr = data:GetCurrEnhanceExp(),
        max = data:GetEnhanceExpToNextLevel()
      }
      return
    end
    local quality = data.weaponConfig.Quality
    local expType = Quality2ExpType[quality]
    if not expType then
      return
    end
    local achievableLevel = data.enhanceLevelPreview.after
    if achievableLevel == CommonDefine.WeaponEnhance.MaxLevel then
      local expToMaxLevel = data:GetEnhanceExpToLevel(achievableLevel)
      data.enhanceExpPreview = {curr = expToMaxLevel, max = expToMaxLevel}
      return
    end
    local totalExp = data:GetTotalEnhanceExp() + exp
    local expToAchievableLevel = TotalExpOfLevel(achievableLevel, expType)
    data.enhanceExpPreview = {
      curr = totalExp - expToAchievableLevel,
      max = data:GetEnhanceExpToLevel(achievableLevel + 1)
    }
  end
  
  function actions:_CalcAttrChange()
    if not data.weapon then
      return
    end
    local levelInc = data.enhanceLevelPreview.after - data.enhanceLevelPreview.before
    local primAttrList = GetWeaponPrimAttrList(data.weapon)
    local secAttr = ItemDataUtils.GetWeaponSecAttr(data.weapon)
    if 0 == #primAttrList then
      data.enhanceAttrPreview = {
        prim = {},
        sec = {}
      }
      return
    end
    local primAttr_1 = primAttrList[1]
    local primAttr_2 = primAttrList[2]
    local primAttr_3 = primAttrList[3]
    local primAttr_1_Id = primAttr_1.id
    local primAttr_1_ValueBefore = primAttr_1.value
    local primAttr_1_ValueAfter = primAttr_1_ValueBefore + levelInc * (data.primAttrInc[primAttr_1_Id] or 0)
    local primAttr_2_Id = primAttr_2.id
    local primAttr_2_ValueBefore = primAttr_2.value
    local primAttr_2_ValueAfter = primAttr_2_ValueBefore + levelInc * (data.primAttrInc[primAttr_2_Id] or 0)
    local primAttr_3_Id = primAttr_3.id
    local primAttr_3_ValueBefore = primAttr_3.value
    local primAttr_3_ValueAfter = primAttr_3_ValueBefore + levelInc * (data.primAttrInc[primAttr_3_Id] or 0)
    data.enhanceAttrPreview = {
      prim = {
        {
          id = primAttr_1_Id,
          before = primAttr_1_ValueBefore,
          after = primAttr_1_ValueAfter
        },
        {
          id = primAttr_2_Id,
          before = primAttr_2_ValueBefore,
          after = primAttr_2_ValueAfter
        },
        {
          id = primAttr_3_Id,
          before = primAttr_3_ValueBefore,
          after = primAttr_3_ValueAfter
        }
      },
      sec = {
        id = secAttr.id,
        before = secAttr.value,
        after = 0
      }
    }
  end
  
  function actions:CalcBreakthroughPreview()
    data.enhanceLevelBreakthroughPreview = {
      level = data:GetEnhanceLevel(),
      currLevelLimit = data:GetEnhanceLevelLimit(),
      nextLevelLimit = data:GetNextEnhanceLevelLimit(),
      nextBreakthroughStar = data:GetBreakthroughStar() + 1
    }
    local primAttrList = GetWeaponPrimAttrList(data.weapon)
    local secAttr = ItemDataUtils.GetWeaponSecAttr(data.weapon)
    if 0 == #primAttrList then
      data.enhanceAttrPreview = {
        prim = {},
        sec = {}
      }
      return
    end
    local primAttr_1 = primAttrList[1]
    local primAttr_2 = primAttrList[2]
    local primAttr_3 = primAttrList[3]
    if data:IsReachBreakthroughLimit() then
      data.breakthroughAttrPreview = {
        prim = {
          {
            id = primAttr_1.id,
            before = primAttr_1.value,
            after = primAttr_1.value
          },
          {
            id = primAttr_2.id,
            before = primAttr_2.value,
            after = primAttr_2.value
          },
          {
            id = primAttr_3.id,
            before = primAttr_3.value,
            after = primAttr_3.value
          }
        },
        sec = {
          id = secAttr.id,
          before = secAttr.value,
          after = secAttr.value
        }
      }
    else
      local attrDict = {}
      local cfg = data.weaponConfig
      for idx = 1, #cfg.WeaponMainAttribute - 1, 2 do
        local id = cfg.WeaponMainAttribute[idx]
        local value = cfg.WeaponMainAttribute[idx + 1]
        attrDict[id] = value
      end
      local id = cfg.WeaponSubAttribute[1]
      local value = cfg.WeaponSubAttribute[2]
      attrDict[id] = value
      local primRatio = DT.GetConstant("WeaponBreakthroughMainRatio")
      local secRatio = DT.GetConstant("WeaponBreakthroughSubRatio")
      local primAttr_1_Id = primAttr_1.id
      local primAttr_1_ValueBefore = primAttr_1.value
      local primAttr_1_ValueAfter = primAttr_1_ValueBefore + (attrDict[primAttr_1_Id] or 0) * primRatio
      local primAttr_2_Id = primAttr_2.id
      local primAttr_2_ValueBefore = primAttr_2.value
      local primAttr_2_ValueAfter = primAttr_2_ValueBefore + (attrDict[primAttr_2_Id] or 0) * primRatio
      local primAttr_3_Id = primAttr_3.id
      local primAttr_3_ValueBefore = primAttr_3.value
      local primAttr_3_ValueAfter = primAttr_3_ValueBefore + (attrDict[primAttr_3_Id] or 0) * primRatio
      local secAttrId = secAttr.id
      local secAttrValueBefore = secAttr.value
      local secAttrValueAfter = secAttrValueBefore + (attrDict[secAttrId] or 0) * secRatio
      data.breakthroughAttrPreview = {
        prim = {
          {
            id = primAttr_1_Id,
            before = primAttr_1_ValueBefore,
            after = primAttr_1_ValueAfter
          },
          {
            id = primAttr_2_Id,
            before = primAttr_2_ValueBefore,
            after = primAttr_2_ValueAfter
          },
          {
            id = primAttr_3_Id,
            before = primAttr_3_ValueBefore,
            after = primAttr_3_ValueAfter
          }
        },
        sec = {
          id = secAttrId,
          before = secAttrValueBefore,
          after = secAttrValueAfter
        }
      }
    end
  end
  
  return actions
end

local function onSetup(_, _)
end

local WeaponDetailModel = Vue.model("WeaponDetailModel", createWeaponDetailState):views(createWeaponDetailViews):actions(createWeaponDetailActions):setup(onSetup)
return WeaponDetailModel
