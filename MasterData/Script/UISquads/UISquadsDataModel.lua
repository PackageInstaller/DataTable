local View = require("UISquads/UISquadsView")
local DataModel = {
  Enum = {
    MainUI = "MainUI",
    Chapter = "Chapter",
    College = "College",
    LevelChain = "LevelChain",
    Monopoly = "Monopoly"
  },
  Current = nil,
  curSquadIndex = 1,
  curSquad = {},
  curLevelId = 0,
  hasLevelRole = false,
  curRefreshElement = nil,
  curDetailIndex = 1,
  curSelectIndex = 1,
  SquadEquip = {},
  Equipments = {},
  LastRoleIndex = nil,
  InitRoleList = {},
  TopColumn = 1,
  ttbSid = nil,
  ttbIndex = nil,
  ttbId = nil,
  dialogId = 0,
  friendId = 0,
  gridId = 0
}
DataModel.AllRoles = {}
DataModel.SortRoles = {}
DataModel.SortType = {
  pluckList = {},
  isIncr = false
}
DataModel.currentRoleData = {}
DataModel.HaveSquads = {}
DataModel.MaxSquadCount = 5
DataModel.currentSquadIndex = 0
DataModel.currentIndex = 0
DataModel.hasOpenThreeView = false
DataModel.SortType = {
  pluckList = {},
  isIncr = false
}
DataModel.Squads = {}
DataModel.currentSquad = {}
DataModel.currentSortSquad = {}
DataModel.CardPool = {}
DataModel.CardColorData = {}
DataModel.RoleExpList = {}
DataModel.ChallengeInfo = {}
DataModel.curShowIdx = 0
DataModel.curShowImgDefaultInfo = {
  x = 0,
  y = 0,
  scale = 1
}
DataModel.AllEquips = {}

function DataModel:SetEquipHaveList()
  DataModel.FindEquipList = {}
  for k, v in pairs(PlayerData.ServerData.squad) do
    DataModel.FindEquipList[k] = {}
    local role_list = v.role_list
    for c, d in pairs(role_list) do
      if d.id and d.equips then
        for a, b in pairs(d.equips) do
          if b ~= "" and b ~= nil then
            table.insert(DataModel.FindEquipList[k], b)
          end
        end
      end
    end
  end
end

local function FindEquipState(equipId)
  if equipId == nil then
    return false
  end
  local Data = DataModel.SquadEquip.Data
  if Data.DefultIndex == nil then
    local now_find_list = DataModel.FindEquipList[Data.SquadIndex]
    if now_find_list and table.count(now_find_list) > 0 then
      for k, v in pairs(now_find_list) do
        if v == equipId then
          return true
        end
      end
    end
  end
  return false
end

function DataModel:GetEquipmentType(isRefresh)
  if isRefresh == nil then
    isRefresh = false
  end
  if isRefresh then
    DataModel.Equipments = {}
    local selfequips = {}
    local count = 0
    local lastType
    local isAllSameType = false
    for i, v in pairs(PlayerData.ServerData.roles) do
      if v.equips then
        for a, b in ipairs(v.equips) do
          if b ~= "" then
            selfequips[tostring(b)] = v.id
            count = count + 1
          end
        end
      end
    end
    local equipmentSlotList = PlayerData:GetFactoryData(tonumber(DataModel.SquadEquip.RoleId)).equipmentSlotList
    for k, v in pairs(equipmentSlotList) do
      local typeInt = PlayerData:GetTypeInt("enumEquipTypeList", v.tagID)
      if lastType == nil then
        lastType = typeInt
      elseif typeInt == lastType or typeInt == 0 then
        if lastType == 0 then
          lastType = 0
        end
        isAllSameType = true
      end
    end
    for i, v in pairs(PlayerData.ServerData.equipments.equips) do
      local data = PlayerData:GetFactoryData(v.id, "EquipmentFactory")
      local typeInt = PlayerData:GetTypeInt("enumEquipTypeList", data.equipTagId)
      local isCross = false
      local isWeight = false
      if v.weight > data.overweight then
        isWeight = true
      end
      if isWeight == true and isAllSameType == true and (typeInt == lastType or lastType == 0) then
        isCross = true
      end
      local type
      if DataModel.SquadEquip.Type == 0 then
        type = true
      else
        type = typeInt == DataModel.SquadEquip.Type
      end
      local isLock = false
      isLock = FindEquipState(i)
      data.skills = v.skills
      local index = typeInt
      if isWeight == false and DataModel.SquadEquip.Type == typeInt then
        isCross = true
      end
      local owner = selfequips[i] or nil
      local allequips = index == 2 and v.id or nil
      table.insert(DataModel.Equipments, {
        data = data,
        eid = v.ueid,
        owner = owner,
        allequips = allequips,
        type = type,
        index = index,
        iscross = isCross,
        isweight = isWeight,
        isLock = isLock
      })
    end
    table.sort(DataModel.Equipments, function(a, b)
      return a.index < b.index
    end)
  end
  return DataModel.Equipments
end

local srcovll_bgHight_Min = 300
local srcovll_bgHight_Max = 750
local space = 30
local downSpace = 10
local bgHight = 255
local baseDowny = -300
local baseUPy = 91
local lastSkillId

function DataModel.OpenCardDes(data)
  if lastSkillId and lastSkillId == data.id then
    return
  end
  UIManager:LoadSplitPrefab(View, "UI/Squads/Squads", "Group_CardDesCharacter")
  local Group_CardDesCharacter = View.Group_CardDesCharacter
  Group_CardDesCharacter.self:SetActive(false)
  Group_CardDesCharacter.self:SetActive(true)
  Group_CardDesCharacter.Btn_Close.self:SetActive(false)
  local CA = PlayerData:GetFactoryData(data.id)
  local Group_LeaderCondition = Group_CardDesCharacter.Group_LeaderCondition
  Group_LeaderCondition.self:SetActive(false)
  local Group_Skill = Group_CardDesCharacter.ScrollView_Card.Viewport.Content.Group_Content.Group_UP.Group_Skill
  Group_Skill.Txt_Des_Leader:SetText("")
  if CA.leaderCardConditionDesc ~= nil and CA.leaderCardConditionDesc ~= "" then
    local tagCA = PlayerData:GetFactoryData(80600356)
    if tagCA.text ~= "" then
      Group_Skill.Txt_Des_Leader:SetText(tagCA.text .. CA.leaderCardConditionDesc)
    end
  end
  Group_Skill.Img_Item:SetSprite(CA.iconPath)
  Group_Skill.Txt_Des:SetText(data.description)
  Group_Skill.Txt_Name:SetText(CA.name)
  Group_Skill.Txt_LvNum:SetText("")
  Group_Skill.Txt_Lv:SetText("")
  Group_Skill.Txt_Des_Dmg:SetText(data.detailDescription)
  local des_space = 0
  local Skill_Space = Group_Skill.Txt_Des:GetHeight()
  local Skill_Space_Dmg = 0
  if data.detailDescription ~= "" then
    Skill_Space_Dmg = Group_Skill.Txt_Des_Dmg:GetHeight()
    Skill_Space_Dmg = Skill_Space_Dmg + des_space
    local des_y = Group_Skill.Txt_Des.transform.localPosition.y - Skill_Space - des_space
    Group_Skill.Txt_Des_Dmg.transform.localPosition = Vector3(Group_Skill.Txt_Des_Dmg.transform.localPosition.x, des_y, 0)
  end
  local Group_Cost = Group_CardDesCharacter.ScrollView_Card.Viewport.Content.Group_Content.Group_UP.Group_Cost
  Group_Cost.Txt_CostNum:SetText("")
  Group_Cost.Txt_Cost:SetText("")
  local skillCA = PlayerData:GetFactoryData(CA.cardID, "cardFactory")
  local costNum = CA.cardID and skillCA.cost_SN or nil
  if costNum == nil or costNum == "" or costNum == 0 then
    Group_Cost.Txt_Cost:SetActive(false)
  else
    Group_Cost.Txt_Cost:SetActive(true)
    Group_Cost.Txt_Cost:SetText("COST")
    Group_Cost.Txt_CostNum:SetText(math.ceil(costNum))
  end
  local Group_Type = Group_CardDesCharacter.ScrollView_Card.Viewport.Content.Group_Content.Group_UP.Group_Type
  Group_Type.self:SetActive(false)
  local Group_DownTag = Group_CardDesCharacter.ScrollView_Card.Viewport.Content.Group_Content.Group_DownTag
  Group_DownTag.self:SetActive(true)
  local show_list = {}
  for k, v in pairs(skillCA.tagList) do
    local tagCA = PlayerData:GetFactoryData(v.tagId)
    if tagCA.isShowDetail == true then
      table.insert(show_list, tagCA)
    end
  end
  local lastY = 0
  local lastSpace = 5
  local allSpace = 0
  local count = 0
  for k, v in pairs(Group_DownTag) do
    if k ~= "self" then
      count = count + 1
      local obj = "Group_Tag" .. count
      Group_DownTag[obj]:SetActive(false)
      local row = show_list[count]
      if row then
        Group_DownTag[obj]:SetActive(true)
        Group_DownTag[obj].Txt_Tag:SetText(row.tagNameRichText .. "\239\188\154" .. row.detail)
        Group_DownTag[obj].Txt_Tag:SetHeight()
        local height = Group_DownTag[obj].Txt_Tag:GetHeight()
        Group_DownTag[obj].Img_Tag:SetSprite(row.icon)
        Group_DownTag[obj].Img_Tag:SetNativeSize()
        if count == 1 then
          lastY = Group_DownTag[obj].transform.localPosition.y
          lastSpace = height
        else
          local y = lastY - lastSpace - downSpace
          Group_DownTag[obj].transform.localPosition = Vector3(Group_DownTag[obj].transform.localPosition.x, y, 0)
          lastY = y
          lastSpace = height
        end
        if height < Group_DownTag[obj].Img_Tag:GetImgHeight() then
          lastSpace = Group_DownTag[obj].Img_Tag:GetImgHeight()
        end
        allSpace = allSpace + lastSpace
      end
    end
  end
  Group_DownTag.self:SetLocalPositionY(baseUPy - Skill_Space - Skill_Space_Dmg)
  local finishSpace = space + allSpace + Skill_Space + Skill_Space_Dmg
  local scrollView_Y = bgHight + finishSpace
  scrollView_Y = scrollView_Y > srcovll_bgHight_Max and srcovll_bgHight_Max or scrollView_Y
  scrollView_Y = scrollView_Y < srcovll_bgHight_Min and srcovll_bgHight_Min or scrollView_Y
  Group_CardDesCharacter.ScrollView_Card.self.Rect.sizeDelta = Vector2(700, scrollView_Y)
  Group_CardDesCharacter.ScrollView_Card:SetContentHeight(bgHight + finishSpace)
  Group_CardDesCharacter.ScrollView_Card:SetVerticalNormalizedPosition(1)
  local initY = 0
  for i = 0, 6 do
    local obj = "Group_" .. i
    Group_CardDesCharacter.Group_Right[obj]:SetActive(false)
    Group_CardDesCharacter.Group_Right[obj].transform.localPosition = Vector3(-50, initY, 0)
  end
  local baseRightHeightBg = 115
  local rightSpace = 15
  local rightLastY = 0
  local rightLastSpace
  local rightYSpace = 0
  local tagOutsideList = skillCA.tagOutsideList
  if tagOutsideList and 0 < table.count(tagOutsideList) then
    for i = 1, table.count(tagOutsideList) do
      local v = tagOutsideList[i]
      local tagCA = PlayerData:GetFactoryData(v.tagId)
      if tagCA and tagCA.isShowDetail == true then
        local obj = "Group_" .. i - 1
        Group_CardDesCharacter.Group_Right[obj]:SetActive(true)
        Group_CardDesCharacter.Group_Right[obj].Img_Face_Bg.Img_Face:SetSprite(tagCA.icon)
        Group_CardDesCharacter.Group_Right[obj].Img_Mask:SetSprite(UIConfig.SkillRightPath)
        Group_CardDesCharacter.Group_Right[obj].Txt_Des:SetText("<color=#FFB800>" .. tagCA.tagNameRichText .. "\239\188\154" .. "</color>" .. tagCA.detail)
        local textHeight = Group_CardDesCharacter.Group_Right[obj].Txt_Des:GetHeight()
        Group_CardDesCharacter.Group_Right[obj].Txt_Des:SetHeight()
        rightLastSpace = baseRightHeightBg
        Group_CardDesCharacter.Group_Right[obj].Img_Bg:SetImgWidthAndHeight(425, baseRightHeightBg)
        if baseRightHeightBg < textHeight then
          rightLastSpace = textHeight + rightSpace * 2
          rightYSpace = textHeight - baseRightHeightBg + rightSpace
          Group_CardDesCharacter.Group_Right[obj].Img_Bg:SetImgWidthAndHeight(425, rightLastSpace)
        end
        if 1 < i then
          Group_CardDesCharacter.Group_Right[obj].transform.localPosition = Vector3(-50, rightLastY + rightYSpace, 0)
        else
          Group_CardDesCharacter.Group_Right[obj].transform.localPosition = Vector3(-50, initY + rightYSpace, 0)
        end
        rightLastY = rightLastSpace + rightSpace + rightLastY + rightYSpace
      end
    end
  end
  lastSkillId = data.id
end

function DataModel.CloseCardDes()
  View.Group_CardDesCharacter.self:SetActive(false)
  lastSkillId = nil
end

function DataModel:GetSkillTagList(cardId)
  local tempData = PlayerData:GetFactoryData(cardId).tagList
  self.skillTagList = {}
  for k, v in pairs(tempData) do
    local tagConfig = PlayerData:GetFactoryData(v.tagId)
    if tagConfig.isShowDetail then
      table.insert(self.skillTagList, v.tagId)
    end
  end
  return self.skillTagList
end

function DataModel:GetCurSquadIndex()
  return self.curSquadIndex
end

function DataModel:SetCurSquadIndex(v)
  self.curSquadIndex = v
end

function DataModel:GetNowCaptain()
  if self.isUseLevelRole then
    local roleId = PlayerData:GetLevelRoleCaptain(self.curLevelId)
    if roleId == "" then
      for i = 1, #self.curSquad do
        if self.curSquad[i] ~= nil and next(self.curSquad[i]) ~= nil then
          return tostring(self.curSquad[i].unitId)
        end
      end
      return ""
    else
      local flag = false
      local temp_index
      for i = 1, #self.curSquad do
        if self.curSquad[i] ~= nil and next(self.curSquad[i]) ~= nil then
          if temp_index == nil then
            temp_index = i
          end
          if tostring(self.curSquad[i].unitId) == roleId then
            flag = true
            break
          end
        end
      end
      if flag ~= true then
        if temp_index ~= nil then
          roleId = tostring(self.curSquad[temp_index].unitId)
        else
          roleId = ""
        end
      end
      return roleId
    end
  elseif PlayerData.curSelectedHelpRole ~= nil and PlayerData.helpSquadIndex == self.curSquadIndex then
    return DataModel.header or PlayerData.ServerData.squad[self.curSquadIndex].header
  end
  return PlayerData.ServerData.squad[self.curSquadIndex].header
end

function DataModel:GetTeamKey()
  local teamKey = DataModel.hasLevelRole and "LevelRoleList_" .. DataModel.curLevelId or DataModel.curSquadIndex
  if DataModel.curSquadIndex == PlayerData.helpSquadIndex then
    teamKey = "HelpRole"
  end
  if PlayerData.BattleInfo.TeamKey then
    teamKey = PlayerData.BattleInfo.TeamKey
  end
  return tostring(teamKey)
end

function DataModel:RefreshUrEquip()
  local equipData = self:GetUrEquipData()
  local hasRoleMap = {}
  for i = 1, #DataModel.curSquad do
    local role = DataModel.curSquad[i]
    if role.unitId ~= nil then
      hasRoleMap[tostring(role.unitId)] = true
      for j = 1, 3 do
        local equipId = role["equip" .. j .. "Id"]
        if equipId and tonumber(equipId) and tonumber(equipId) > 0 then
          if equipData[tostring(role.unitId)] == nil then
            equipData[tostring(role.unitId)] = {}
          end
          if equipData[tostring(role.unitId)][j] == nil then
            equipData[tostring(role.unitId)][j] = {}
          end
          if equipData[tostring(role.unitId)][j].id ~= equipId then
            equipData[tostring(role.unitId)][j].id = equipId
            equipData[tostring(role.unitId)][j].isUse = nil
          end
        else
          if equipData[tostring(role.unitId)] == nil then
            equipData[tostring(role.unitId)] = {}
          end
          equipData[tostring(role.unitId)][j] = {id = "", isUse = false}
        end
      end
    end
  end
  for k, v in pairs(equipData) do
    if hasRoleMap[k] ~= true then
      equipData[k] = nil
    end
  end
  local usingEquip = {}
  for k, v in pairs(equipData) do
    for j = 1, 3 do
      local eData = v[j]
      if eData.isUse == true then
        usingEquip[tostring(eData.id)] = true
      end
    end
  end
  for k, v in pairs(equipData) do
    for j = 1, 3 do
      local eData = v[j]
      if eData.isUse ~= true and usingEquip[tostring(eData.id)] ~= true then
        usingEquip[tostring(eData.id)] = true
        eData.isUse = true
      elseif eData.isUse ~= true then
        local eCA = PlayerData:GetFactoryData(eData.id)
        eData.isUse = eCA and eCA.quality ~= "Orange" or false
      end
    end
  end
  self:SaveUrEquipData(equipData)
end

function DataModel:CompressData(str)
  local compMs = CS.System.IO.MemoryStream()
  local zipStream = CS.System.IO.Compression.DeflateStream(compMs, CS.System.IO.Compression.CompressionMode.Compress, false)
  local l, byte, byteList = string.getLength(str)
  zipStream:Write(str, 0, byte)
  zipStream:Close()
  local press = compMs:ToArray()
  local str64 = CS.System.Convert.ToBase64String(press)
  return str64
end

function DataModel:isBase64(str)
  local base64Chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  local pattern = "^[" .. base64Chars .. "]*[=]*$"
  local isMatch = string.match(str, pattern)
  if isMatch then
    local len = string.len(str)
    if len % 4 == 0 or len % 4 == 1 and str:sub(-1) == "=" or len % 4 == 2 and str:sub(-2) == "==" then
      return true
    end
  end
  return false
end

function DataModel:DeCompressData(str64)
  if str64 == "" or not self:isBase64(str64) then
    return "{}"
  end
  local str
  
  local function decompress()
    str64 = CS.System.Convert.FromBase64String(str64)
    local og = CS.System.IO.MemoryStream(str64)
    local gzi = CS.System.IO.Compression.DeflateStream(og, CS.System.IO.Compression.CompressionMode.Decompress, false)
    local tg = CS.System.IO.MemoryStream()
    gzi:CopyTo(tg)
    str = tg:ToArray()
  end
  
  if pcall(decompress) then
    return str or "{}"
  else
    return "{}"
  end
end

function DataModel:GetUrEquipData()
  if PlayerData.BattleInfo.UrEquipData then
    return PlayerData.BattleInfo.UrEquipData
  end
  local serverEquip = PlayerData.ServerData.ur_equip or {}
  local teamKey = self:GetTeamKey()
  local equipStr = serverEquip[teamKey] or {}
  equipStr = equipStr.code or ""
  equipStr = self:DeCompressData(equipStr)
  local equipData = Json.decode(equipStr)
  return equipData
end

function DataModel:SaveUrEquipData(equipData)
  local equipStr = Json.encode(equipData)
  equipStr = self:CompressData(equipStr)
  local teamKey = self:GetTeamKey()
  if PlayerData.ServerData.ur_equip == nil then
    PlayerData.ServerData.ur_equip = {}
  end
  if PlayerData.ServerData.ur_equip[teamKey] == nil then
    PlayerData.ServerData.ur_equip[teamKey] = {}
  end
  PlayerData.ServerData.ur_equip[teamKey].code = equipStr
  Net:SendProto("deck.deck_equip", function(json)
  end, equipStr, teamKey)
end

return DataModel
