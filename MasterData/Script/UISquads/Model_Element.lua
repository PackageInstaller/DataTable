local DataModel = require("UISquads/UISquadsDataModel")
local module = {
  SetElement = function(self, element, data)
    if element.current == nil then
      element.current = {}
    end
    local unitData = PlayerData:GetFactoryData(data.unitId, "UnitFactory")
    if unitData == nil then
      return
    end
    DataModel.curRefreshElement = element
    local ca = PlayerData:GetFactoryData(data.unitId)
    self:_SetRoleQuality(element, unitData.qualityInt)
    self:_SetRoleLevel(element, data.lv)
    self:_SetPortrait(element, data.unitId, ca)
    self:_SetRoleName(element, unitData.name)
    self._SetRoleCard(element, data)
    self._SetRoleResonanceLvAndEquip(element, ca, data)
    self._SetLine(element, ca)
    local currentRole = PlayerData:GetRoleById(data.unitId)
    local hasBatman = next(currentRole) == nil
    local expPercent = 1
    if not hasBatman then
      local expList = PlayerData:GetFactoryData(99900003, "ConfigFactory").expList
      local length = #expList
      if length < data.lv then
        expPercent = 1
      else
        expPercent = currentRole.exp / expList[data.lv].levelUpExp
      end
      element.Group_Awake.Img_Awake:SetSprite(UIConfig.AwakeCommon[data.resonanceLv + 1])
      self:_SetBreakThrough(element, data.awakeLv)
    end
    element.Group_LV.Group_ExpBar.Img_Bar:SetFilledImgAmount(expPercent)
    element.Group_Awake.Img_Awake:SetSprite(UIConfig.AwakeCommon[data.resonanceLv + 1])
    local isFinalSkillUnlock = PlayerData:IsRoleFinalSkillUnlock(data.unitId)
    local talentNum = #ca.talentList
    element.Group_Awake.Group_Effect4:SetActive(isFinalSkillUnlock and data.resonanceLv == 4)
    element.Group_Awake.Group_Effect5:SetActive(isFinalSkillUnlock and data.resonanceLv == 5)
    if isFinalSkillUnlock then
      element.Group_Awake.Img_Awake:SetColor("#FFE266")
      element.Group_Awake.Img_Bg:SetColor("#FFE266")
    else
      element.Group_Awake.Img_Awake:SetColor("#FFFFFF")
      element.Group_Awake.Img_Bg:SetColor("#FFFFFF")
    end
    self:_SetBreakThrough(element, data.awakeLv)
    local ca = PlayerData:GetFactoryData(data.unitId)
    local tagCA = PlayerData:GetFactoryData(ca.sideId, "TagFactory")
    element.Group_Camp.Img_Mask.Img_Camp:SetSprite(tagCA.icon)
    DataModel.curRefreshElement = nil
    if element.Group_Tip_02 then
      element.Group_Tip_02.self:SetActive(data.isBlocked)
    end
    if element.Group_HelpRole then
      element.Group_HelpRole.self:SetActive(data.isHelpRole)
    end
  end,
  _SetRoleQuality = function(self, element, rarityInt)
    if not _Assert(element.current, {Rarity = rarityInt}) then
      element.Img_Rarity:SetSprite(UIConfig.SquadsRarity[rarityInt])
    end
  end,
  _SetRoleCareer = function(self, element, careerInt)
    if not _Assert(element.current, {Career = careerInt}) then
    end
  end,
  _SetRoleLevel = function(self, element, level)
    if not _Assert(element.current, {Level = level}) then
      element.Group_LV.Txt_LVNum:SetText(level)
    end
  end,
  _SetPortrait = function(self, element, unitId, ca)
    if not _Assert(element.current, {UnitId = unitId}) then
      local server = PlayerData:GetRoleById(unitId)
      local portraitId = PlayerData:GetFactoryData(unitId).viewId
      local isServer = false
      if server and table.count(server) ~= 0 then
        isServer = true
        portraitId = server.current_skin[1]
      end
      local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
      element.Img_Mask.Img_Character:SetSprite(portrailData.squadsHalf1)
      if portrailData.squadsHalf1 == "" then
        element.Img_Mask.Img_Character:SetSprite(portrailData.roleListResUrl)
      end
      if isServer == true and server.current_skin[2] == 1 and ca.isSpine2 == 1 then
        element.Img_Mask.Img_Character:SetSprite(portrailData.squadsHalf2)
      end
      local posX = portrailData.squadsX or 0
      local posY = portrailData.squadsY or 0
      element.Img_Mask.Img_Character.transform.position.y = posY
      element.Img_Mask.Img_Character.transform.position.x = posX
    end
  end,
  _SetRoleName = function(self, element, roleName)
    if not _Assert(element.current, {RoleName = roleName}) then
      element.Txt_Name:SetText(roleName)
    end
  end,
  _SetBreakThrough = function(self, element, breakthrough)
    if not _Assert(element.current, {BreakThroughLv = breakthrough}) then
      element.Group_Break.StaticGrid_BK.grid.self:RefreshAllElement()
    end
  end,
  _SetLine = function(element, ca)
    local Group_SkillColor = element.Group_SkillColor
    local Group_Locate = Group_SkillColor.Group_Locate
    Group_Locate.Img_Line:SetSprite(UIConfig.CharacterLine[ca.line])
  end,
  _SetRoleCard = function(element, data)
    local Group_SkillColor = element.Group_SkillColor
    local cardList = PlayerData:GetRoleCardList(data.unitId)
    for i = 1, table.count(cardList) do
      local obj = "Group_SkillColor" .. i
      local cardCA = PlayerData:GetFactoryData(cardList[table.count(cardList) - i + 1].id)
      local color = cardCA.color
      Group_SkillColor[obj].Img_Color:SetSprite(UIConfig.CharacterSkillColor[color])
    end
  end,
  _SetRoleResonanceLvAndEquip = function(element, ca, rData)
    local canResonance = false
    local canEquip = false
    local canEquipUpgrade = false
    local banUrEquip = false
    local urequip = DataModel:GetUrEquipData()
    if urequip[tostring(ca.id)] then
      for i = 1, 3 do
        if urequip[tostring(ca.id)][i] and tonumber(urequip[tostring(ca.id)][i].id) ~= nil and urequip[tostring(ca.id)][i].isUse == false then
          banUrEquip = true
          break
        end
      end
    end
    local roleData = PlayerData:GetRoleById(ca.id)
    local showLevel = PlayerData:GetFactoryData("99900007").formationTipOpen
    local userLevel = PlayerData:GetUserInfo().lv or 1
    if not roleData or table.count(roleData) == 0 or showLevel > userLevel or DataModel.hasLevelRole then
      canEquip = false
      canResonance = false
    else
      local resonanceLv = roleData.resonance_lv or 0
      if resonanceLv + 1 < table.count(ca.awakeList) and ca.awakeList[resonanceLv + 1] then
        local awakeId = ca.awakeList[resonanceLv + 1].awakeId
        local awakeCA = PlayerData:GetFactoryData(awakeId)
        if rData.lv < awakeCA.level then
          canResonance = false
        else
          local data = PlayerData:GetFactoryData(awakeId, "AwakeFactory")
          local materialList = data.materialList
          local isEnoughMaterial = true
          local items = {}
          local re_item = {}
          for i = 1, #materialList do
            local item = materialList[i]
            local needNum = item.num
            local haveItem = PlayerData:GetGoodsById(item.itemId)
            local haveNum = haveItem.num
            if needNum > haveNum and isEnoughMaterial then
              isEnoughMaterial = false
              break
            end
            items[item.itemId] = needNum
            re_item[tostring(item.itemId)] = needNum
          end
          canResonance = isEnoughMaterial
        end
      end
      if DataModel.AllEquips and 0 < table.count(DataModel.AllEquips) and roleData then
        local equips = roleData.equips
        for i = 1, 3 do
          if equips[i] and equips[i] == "" and DataModel.AllEquips[i] then
            for index, value in ipairs(DataModel.AllEquips[i]) do
              if value.server.hid == "" then
                canEquip = true
                break
              end
            end
          end
        end
        if not canEquip then
          local canUpgradeLv = PlayerData:GetFactoryData("99900007").equipTipOpen
          local equipTipLv = PlayerData:GetFactoryData("99900007").equipTipLv
          for i = 1, 3 do
            local eid = equips[i]
            local equipData = PlayerData:GetEquipByEid(eid)
            if equipData then
              local lv = equipData.lv
              local roleLv = roleData.lv
              if canUpgradeLv <= roleLv - lv and equipTipLv > lv then
                canEquipUpgrade = true
              end
            end
          end
        end
      end
    end
    local equipTipMaxLv = PlayerData:GetFactoryData("99900007").equipTipMax
    local isShow = roleData and roleData.lv and equipTipMaxLv > roleData.lv
    if isShow then
      element.Group_Tip:SetActive(canResonance or canEquip or canEquipUpgrade)
    else
      element.Group_Tip:SetActive(canResonance or canEquip or banUrEquip)
    end
    if banUrEquip or canResonance or canEquip or canEquipUpgrade then
      if banUrEquip then
        element.Group_Tip.Img_.Txt_:SetText(GetText(80612090))
      elseif canEquipUpgrade then
        if isShow then
          if canResonance then
            element.Group_Tip.Img_.Txt_:SetText(GetText(80609847))
          else
            element.Group_Tip.Img_.Txt_:SetText(GetText(80609846))
          end
        else
          element.Group_Tip.Img_.Txt_:SetText(GetText(80609584))
        end
      elseif canEquip then
        if canResonance then
          element.Group_Tip.Img_.Txt_:SetText(GetText(80609585))
        else
          element.Group_Tip.Img_.Txt_:SetText(GetText(80609583))
        end
      elseif canResonance then
        element.Group_Tip.Img_.Txt_:SetText(GetText(80609584))
      end
    end
  end
}
return module
