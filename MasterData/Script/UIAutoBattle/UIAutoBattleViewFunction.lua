local View = require("UIAutoBattle/UIAutoBattleView")
local DataModel = require("UIAutoBattle/UIAutoBattleDataModel")
local firstCardWeight = 900000
local stepSubWeight = 10000
local discardBtnWeight = 1000000
local leadarCardWeight = 1200000
local spCardWeight = 1100000
local banWeight = -9999999
local firstWeight = 9999999
local notMetWeight = -999999
local enemyWeight = 999999
local discardBtnCardId = "10600474"
local discardBtnSkillId = "12303725"

local function IsAutoBattleAvailable()
  local levelCA = PlayerData:GetFactoryData(PlayerData.BattleInfo.battleStageId, "LevelFactory")
  local rt = true
  if levelCA ~= nil and levelCA.isBanAutoBattle then
    rt = false
  end
  return rt
end

local function Reset()
  local Data = DataModel.CurrentData
  Data.discardType = DataModel.DefaultValue.discardType
  Data.keepCardNum = DataModel.DefaultValue.keepCardNum
end

local function SetConfigSetView()
end

local function ChangeSet(index)
  if index < 1 then
    index = 1
  end
  if 3 < index then
    index = 3
  end
  DataModel.DataIndex = index
  DataModel.CurrentData = DataModel.Data[index]
  index = PlayerData:SetPlayerPrefs("int", "CardAIIndex", index, true)
end

local function CompressData(str)
  local compMs = CS.System.IO.MemoryStream()
  local zipStream = CS.System.IO.Compression.DeflateStream(compMs, CS.System.IO.Compression.CompressionMode.Compress, false)
  local l, byte, byteList = string.getLength(str)
  zipStream:Write(str, 0, byte)
  zipStream:Close()
  local press = compMs:ToArray()
  local str64 = CS.System.Convert.ToBase64String(press)
  return str64
end

local function isBase64(str)
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

local function DeCompressData(str64)
  if str64 == "" or not isBase64(str64) then
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
    return str or {}
  else
    return "{}"
  end
end

local function GetCloudData(key)
  if PlayerData.ServerData.auto_deck == nil then
    PlayerData.ServerData.auto_deck = {}
  end
  if PlayerData.ServerData.auto_deck[key] == nil then
    PlayerData.ServerData.auto_deck[key] = {}
  end
  return PlayerData.ServerData.auto_deck[key]
end

local function GetCloudStr(key)
  local cData = GetCloudData(key)
  local str64 = cData.code or ""
  local str = DeCompressData(str64)
  local len = string.len(str)
  if len <= 0 or str:sub(1, 1) ~= "{" or str:sub(len, len) ~= "}" then
    CommonTips.OpenTips(GetText(80608108))
    return
  end
  return str
end

local function SaveCloudData(key, str, isAuto)
  if DataModel.isForbidCloud == true then
    return
  end
  local str64 = CompressData(str)
  if isAuto == nil then
    isAuto = true
  end
  if PlayerData.ServerData.auto_deck == nil then
    PlayerData.ServerData.auto_deck = {}
  end
  if PlayerData.ServerData.auto_deck[key] == nil then
    PlayerData.ServerData.auto_deck[key] = {}
  end
  PlayerData.ServerData.auto_deck[key].is_open = isAuto and "1" or "0"
  PlayerData.ServerData.auto_deck[key].code = str64
  Net:SendProto("deck.auto_deck", function(json)
  end, isAuto and "1" or "0", str64, key)
end

local function SaveData(forceChange)
  if DataModel.IsChanged == true or forceChange == true and DataModel.CurrentData ~= nil then
    local str
    if not pcall(function()
      str = Json.encode(DataModel.CurrentData)
    end) then
      str = ""
    end
    local autoKey = "CardAIData" .. DataModel.teamKey
    PlayerData:SetPlayerPrefs("string", autoKey, str, true)
    local cData = GetCloudData(autoKey)
    if cData.is_open and cData.is_open == "1" then
      do
        local data = Clone(DataModel.CurrentData)
        data.roleList = DataModel.roleList
        data.header = DataModel.header
        str = Json.encode(data)
        SaveCloudData(autoKey, str)
      end
    end
  end
end

local function CheckExchangeSkill(curData, roleList)
  local isChange = false
  for i = 1, #roleList do
    if 0 < roleList[i] then
      local skillList = PlayerData:GetCardDes(roleList[i])
      for j = 1, #skillList do
        if DataModel:ExchangeSkill(curData, j, skillList[j].id, roleList[i]) then
          isChange = true
        end
      end
    end
  end
  return isChange
end

local function CheckHasBlackCard(curData)
  local cardIdMap = curData.cardIdMap
  local cardList = curData.cardList
  local isChange = false
  for i = #cardList, 1, -1 do
    if DataModel:IsBlackCard(cardList[i].id) then
      table.remove(cardList, i)
      isChange = true
      cardIdMap[cardList[i].id] = nil
    end
  end
  return isChange
end

local function RemoveNoCACard(curData)
  local cardIdMap = curData.cardIdMap
  local cardList = curData.cardList
  local isChange = false
  for i = #cardList, 1, -1 do
    if not pcall(function()
      PlayerData:GetFactoryData(cardList[i].id)
    end) or PlayerData:GetFactoryData(cardList[i].id) == nil then
      table.remove(cardList, i)
      isChange = true
      cardIdMap[cardList[i].id] = nil
    end
  end
  return isChange
end

local function TryAddDiscardBtn(curData)
  local cardIdMap = curData.cardIdMap
  local isChange = false
  if cardIdMap[discardBtnCardId] == nil then
    isChange = DataModel:AddCardBySKillId(curData, discardBtnSkillId, 10000001)
    if isChange then
      local maxIndex = #DataModel.CurrentData.cardList
      if DataModel.CurrentData.discardType == 1 then
        DataModel.CurrentData.cardList[maxIndex].useType = 2
      elseif DataModel.CurrentData.discardType == 2 then
        local data = DataModel.CurrentData.cardList[maxIndex]
        table.remove(DataModel.CurrentData.cardList, maxIndex)
        table.insert(DataModel.CurrentData.cardList, 1, data)
      else
        local cardCA = PlayerData:GetFactoryData(discardBtnCardId)
        if #cardCA.ExCondList > 0 then
          DataModel.CurrentData.cardList[maxIndex].useType = 3
        end
      end
    end
  end
  return isChange
end

local function TryCorrrectData(data)
  if data.roleList == nil then
    data.roleList = {
      -1,
      -1,
      -1,
      -1,
      -1
    }
  end
  local roleCount = 0
  for i = 1, 5 do
    if data.roleList[i] == nil then
      data.roleList[i] = -1
    end
    if data.roleList[i] ~= -1 then
      roleCount = roleCount + 1
    end
  end
  if roleCount <= 0 and data.cardList ~= nil and 0 < #data.cardList then
    local cardList = data.cardList
    local curOwnerMap = {}
    for i = 1, #cardList do
      curOwnerMap[cardList[i].ownerId] = true
    end
    data.roleList = {}
    for k, v in pairs(curOwnerMap) do
      if k ~= 10000001 then
        data.roleList[#data.roleList + 1] = k
      end
    end
    if data.header == nil or curOwnerMap[data.header] ~= true then
      data.header = data.roleList[1]
    end
  end
  RemoveNoCACard(data)
  DataModel:CheckDirtyCard(data, data.roleList)
  DataModel:CheckCardList(data, data.roleList)
  DataModel:CheckEquipCard(data, data.roleList)
end

local function SelectSettingMode(mode, isInit)
  if mode == DataModel.settingMode and not isInit then
    return
  end
  DataModel.settingMode = mode
  View.Group_Main.ScrollView_Group_Weight.self:SetActive(DataModel.settingMode == 1)
  View.Group_Main.ScrollView_Group_CardsSetting.self:SetActive(DataModel.settingMode == 2)
  View.Group_TopBar.Group_TopButtons.Group_Weight.Img_On:SetActive(DataModel.settingMode == 1)
  View.Group_TopBar.Group_TopButtons.Group_CardsSetting.Img_On:SetActive(DataModel.settingMode == 2)
end

local function SetDiscardBtnView()
  local canvasGroup = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_Discard.Group_Ban.Img_On.self:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = DataModel.CurrentData.discardType == 1 and 1 or 0
  canvasGroup = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_Discard.Group_Ban.Btn_Off:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = DataModel.CurrentData.discardType == 1 and 0 or 1
  canvasGroup = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_Discard.Group_Active.Img_On:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = DataModel.CurrentData.discardType == 2 and 1 or 0
  canvasGroup = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_Discard.Group_Active.Btn_Off:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = DataModel.CurrentData.discardType == 2 and 0 or 1
  canvasGroup = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_Discard.Group_NoCard.Img_On:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = DataModel.CurrentData.discardType == 3 and 1 or 0
  canvasGroup = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_Discard.Group_NoCard.Btn_Off:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = DataModel.CurrentData.discardType == 3 and 0 or 1
end

local function SetConfigUploadView()
  local autoKey = "CardAIData" .. DataModel.teamKey
  local cData = GetCloudData(autoKey)
  local isAuto = cData.is_open and cData.is_open == "1"
  local canvasGroup = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_Row_configUpload.Btn_Switch.Bg02_Off.self:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = not isAuto and 1 or 0
  canvasGroup = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_Row_configUpload.Btn_Switch.Bg01_On.self:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = isAuto and 1 or 0
  View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_Row_configUpload.Btn_Switch.Bg01_On.Img_Block:SetLocalPositionX(isAuto and 45 or -45)
  View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_Row_configUpload.Btn_Switch.Bg02_Off.Img_Block:SetLocalPositionX(isAuto and 45 or -45)
end

local function SetLeaderCardView()
  local canvasGroup = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_Row_teamleaderSkill.Btn_Switch.Bg02_Off.self:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = not DataModel.CurrentData.isLeaderCardOn and 1 or 0
  canvasGroup = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_Row_teamleaderSkill.Btn_Switch.Bg01_On.self:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = DataModel.CurrentData.isLeaderCardOn and 1 or 0
  View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_Row_teamleaderSkill.Btn_Switch.Bg01_On.Img_Block:SetLocalPositionX(DataModel.CurrentData.isLeaderCardOn and 45 or -45)
  View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_Row_teamleaderSkill.Btn_Switch.Bg02_Off.Img_Block:SetLocalPositionX(DataModel.CurrentData.isLeaderCardOn and 45 or -45)
end

local function SetSpCardView()
  local canvasGroup = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_Row_spSkill.Btn_Switch.Bg02_Off.self:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = not DataModel.CurrentData.isSpCardOn and 1 or 0
  canvasGroup = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_Row_spSkill.Btn_Switch.Bg01_On.self:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = DataModel.CurrentData.isSpCardOn and 1 or 0
  View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_Row_spSkill.Btn_Switch.Bg01_On.Img_Block:SetLocalPositionX(DataModel.CurrentData.isSpCardOn and 45 or -45)
  View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_Row_spSkill.Btn_Switch.Bg02_Off.Img_Block:SetLocalPositionX(DataModel.CurrentData.isSpCardOn and 45 or -45)
end

local function SetOtherCardView()
  local canvasGroup = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_OtherCards.Group_Btns.Group_FirstUse.Img_On.self:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = DataModel.CurrentData.otherCard == 0 and 1 or 0
  canvasGroup = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_OtherCards.Group_Btns.Group_FirstUse.Btn_Off.self:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = DataModel.CurrentData.otherCard == 0 and 0 or 1
  canvasGroup = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_OtherCards.Group_Btns.Group_LastUse.Img_On.self:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = DataModel.CurrentData.otherCard == 1 and 1 or 0
  canvasGroup = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_OtherCards.Group_Btns.Group_LastUse.Btn_Off.self:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = DataModel.CurrentData.otherCard == 1 and 0 or 1
  canvasGroup = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_OtherCards.Group_Btns.Group_DontUse.Img_On.self:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = DataModel.CurrentData.otherCard == 2 and 1 or 0
  canvasGroup = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_OtherCards.Group_Btns.Group_DontUse.Btn_Off.self:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = DataModel.CurrentData.otherCard == 2 and 0 or 1
end

local function ShowKeepCardNum()
  View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_keepCard.Group_Btns.Group_Nums.Txt_Num:SetText(tostring(DataModel.CurrentData.keepCardNum))
  if DataModel.CurrentData.keepCardNum == DataModel.sKeepCardNumMax then
  else
  end
  if DataModel.CurrentData.keepCardNum == 0 then
  else
  end
end

local function SetCardWeightView()
  local scrollGridCard = View.Group_Main.ScrollView_Group_Weight.Viewport.Content.ScrollGrid_Card
  scrollGridCard.grid.self:SetDataCount(#DataModel.CurrentData.cardList)
  scrollGridCard.grid.self:RefreshAllElement()
  scrollGridCard.grid.self:MoveToTop()
end

local function RefreshAll()
  SelectSettingMode(1, true)
  SetConfigSetView()
  SetDiscardBtnView()
  SetConfigUploadView()
  SetLeaderCardView()
  SetSpCardView()
  SetOtherCardView()
  ShowKeepCardNum()
  SetCardWeightView()
  View.self:PlayAnimOnce("AutoBattle_In")
end

local function TryLoadDataByConfig(data, noPrompt)
  TryCorrrectData(data)
  local isSameRole = true
  local rt = 1
  local roleListMap = {}
  for i = 1, #DataModel.roleList do
    if DataModel.roleList[i] ~= -1 then
      roleListMap[DataModel.roleList[i]] = 1
    end
  end
  local iRoleListMap = {}
  for i = 1, #data.roleList do
    if data.roleList[i] ~= -1 then
      iRoleListMap[data.roleList[i]] = 1
    end
  end
  if table.count(roleListMap) ~= table.count(iRoleListMap) then
    isSameRole = false
  else
    for k, v in pairs(iRoleListMap) do
      if roleListMap[k] == nil then
        isSameRole = false
      end
    end
  end
  local notHaveRoles = {}
  if isSameRole then
    if data.header ~= DataModel.header and (data.header ~= nil or DataModel.header ~= -1) then
      rt = 2
    end
  else
    local rolesMap = PlayerData.ServerData.roles
    if DataModel.tempRoles then
      rolesMap = DataModel.tempRoles
    end
    for i = 1, #data.roleList do
      if data.roleList[i] and data.roleList[i] > 0 and rolesMap[tostring(data.roleList[i])] == nil then
        notHaveRoles[#notHaveRoles + 1] = data.roleList[i]
      end
    end
    if #notHaveRoles <= 0 then
      rt = 3
    else
      rt = 4
    end
  end
  
  local function loadWhenSameRole()
    DataModel.CurrentData = data
    CheckExchangeSkill(DataModel.CurrentData, DataModel.roleList)
    CheckHasBlackCard(DataModel.CurrentData)
    TryAddDiscardBtn(DataModel.CurrentData)
    DataModel.IsChanged = true
    SaveData()
    if noPrompt ~= true then
      RefreshAll()
      CommonTips.OpenTips(GetText(80608607))
    end
  end
  
  local function loadWhenDifferentHeader()
    local squadIndex = tonumber(DataModel.teamKey)
    if squadIndex ~= nil then
      local squad = PlayerData.ServerData.squad[squadIndex]
      Net:SendProto("deck.set_deck", function(res)
        squad.header = data.header
        DataModel.header = data.header
        PlayerData.ServerData.squad[squadIndex].header = data.header
        DataModel.CurrentData = data
        CheckExchangeSkill(DataModel.CurrentData, DataModel.roleList)
        CheckHasBlackCard(DataModel.CurrentData)
        TryAddDiscardBtn(DataModel.CurrentData)
        DataModel.IsChanged = true
        SaveData()
        if noPrompt ~= true then
          RefreshAll()
          CommonTips.OpenTips(GetText(80608607))
        end
      end, squadIndex - 1, nil, data.header)
    else
      local keyData = string.split(DataModel.teamKey, "_")
      if keyData[1] == "Abyss" then
        local abyssController = require("UITeam_Abyss/UITeam_AbyssController")
        local abyssData = abyssController:GetUIDataModel()
        local abyssRoleList = abyssData.levelRoleList[tonumber(keyData[2])]
        for i = 1, #abyssRoleList do
          local roleId = abyssRoleList[i]
          if tonumber(roleId) == data.header then
            abyssRoleList[i] = abyssRoleList[1]
            abyssRoleList[1] = roleId
            break
          end
        end
        abyssController:SaveCurLevelRoleList()
        DataModel.header = data.header
        DataModel.CurrentData = data
        CheckExchangeSkill(DataModel.CurrentData, DataModel.roleList)
        CheckHasBlackCard(DataModel.CurrentData)
        TryAddDiscardBtn(DataModel.CurrentData)
        DataModel.IsChanged = true
        SaveData()
        if noPrompt ~= true then
          RefreshAll()
          CommonTips.OpenTips(GetText(80608607))
        end
      elseif keyData[1] == "Cube" then
        local rogueController = require("UITeam_CubeNew/UITeam_CubeNewController")
        local rogueData = rogueController:GetDataModel()
        local idx = rogueData.roleCheckMap[tostring(data.header)].idx
        rogueController:ExchangeSingleRole(1, 1, 1, idx)
        rogueController:SaveCubeDeck()
        DataModel.header = data.header
        DataModel.CurrentData = data
        CheckExchangeSkill(DataModel.CurrentData, DataModel.roleList)
        CheckHasBlackCard(DataModel.CurrentData)
        TryAddDiscardBtn(DataModel.CurrentData)
        DataModel.IsChanged = true
        SaveData()
        if noPrompt ~= true then
          RefreshAll()
          CommonTips.OpenTips(GetText(80608607))
        end
      elseif keyData[1] == "Endless_" then
        local endlessController = require("UIEndlessBattle/UIEndlessBattleController")
        local endlessData = endlessController:GetDataModel()
        local idx = endlessData.roleCheckMap[tostring(data.header)].idx
        local team = tonumber(keyData[2])
        endlessController:ExchangeSingleRole(team, 1, team, idx)
        endlessController:SaveCurLevelRoleList()
        DataModel.header = data.header
        DataModel.CurrentData = data
        CheckExchangeSkill(DataModel.CurrentData, DataModel.roleList)
        CheckHasBlackCard(DataModel.CurrentData)
        TryAddDiscardBtn(DataModel.CurrentData)
        DataModel.IsChanged = true
        SaveData()
        if noPrompt ~= true then
          RefreshAll()
          CommonTips.OpenTips(GetText(80608607))
        end
      end
    end
  end
  
  local function loadWhenDifferentRole()
    local squadIndex = tonumber(DataModel.teamKey)
    if squadIndex ~= nil then
      PlayerData.ServerData.squad[squadIndex].header = data.header
      PlayerData.ServerData.squad[squadIndex].role_list = {}
      local string_value = ""
      for i = 1, #data.roleList do
        local roleData = {
          id = tostring(data.roleList[i]),
          skill_list = {
            [1] = "",
            [2] = "",
            [3] = ""
          }
        }
        string_value = string_value .. (data.roleList[i] == -1 and "" or data.roleList[i])
        if i ~= #data.roleList then
          string_value = string_value .. "|"
        end
        if data.roleList[i] ~= -1 then
          PlayerData.ServerData.squad[squadIndex].role_list[i] = roleData
        else
          PlayerData.ServerData.squad[squadIndex].role_list[i] = {}
        end
      end
      if string_value == "||||" then
        string_value = ""
      end
      Net:SendProto("deck.set_deck", function(res)
        DataModel.header = data.header
        DataModel.roleList = data.roleList
        DataModel.CurrentData = data
        CheckExchangeSkill(DataModel.CurrentData, DataModel.roleList)
        CheckHasBlackCard(DataModel.CurrentData)
        TryAddDiscardBtn(DataModel.CurrentData)
        DataModel.IsChanged = true
        SaveData()
        if noPrompt ~= true then
          RefreshAll()
          CommonTips.OpenTips(GetText(80608607))
        end
      end, squadIndex - 1, string_value, data.header)
    else
      local keyData = string.split(DataModel.teamKey, "_")
      if keyData[1] == "Abyss" then
        local abyssController = require("UITeam_Abyss/UITeam_AbyssController")
        local abyssData = abyssController:GetUIDataModel()
        DataModel.isForbidCloud = true
        abyssController:ClearTeamByIndex(tonumber(keyData[2]), true)
        if data.roleList[1] ~= data.header then
          for i = 1, #data.roleList do
            if data.roleList[i] == data.header then
              data.roleList[i] = data.roleList[1]
              data.roleList[1] = data.header
            end
          end
        end
        for i = 1, #data.roleList do
          local roleId = tostring(data.roleList[i])
          local curRoleTeam = abyssData.roleCheckMap[roleId]
          local curTeamIndex
          if curRoleTeam ~= nil then
            curTeamIndex = curRoleTeam.team
            abyssController:RemoveRoleToTeam(roleId, true)
          end
          abyssController:AddRoleToTeam(roleId, tonumber(keyData[2]), true)
        end
        abyssController:SaveCurLevelRoleList()
        DataModel.header = data.header
        DataModel.roleList = data.roleList
        DataModel.CurrentData = data
        CheckExchangeSkill(DataModel.CurrentData, DataModel.roleList)
        CheckHasBlackCard(DataModel.CurrentData)
        TryAddDiscardBtn(DataModel.CurrentData)
        DataModel.IsChanged = true
        DataModel.isForbidCloud = false
        SaveData()
        if noPrompt ~= true then
          RefreshAll()
          CommonTips.OpenTips(GetText(80608607))
        end
      elseif keyData[1] == "Cube" then
        local rogueController = require("UITeam_CubeNew/UITeam_CubeNewController")
        local rogueData = rogueController:GetDataModel()
        DataModel.isForbidCloud = true
        rogueController:ClearTeamByIndex(true)
        if data.roleList[1] ~= data.header then
          for i = 1, #data.roleList do
            if data.roleList[i] == data.header then
              data.roleList[i] = data.roleList[1]
              data.roleList[1] = data.header
            end
          end
        end
        for i = 1, #data.roleList do
          local roleId = tostring(data.roleList[i])
          local curRoleTeam = rogueData.roleCheckMap[roleId]
          if curRoleTeam == nil then
            rogueController:AddRoleToTeam(roleId, true)
          end
        end
        rogueController:SaveCubeDeck()
        DataModel.header = data.header
        DataModel.roleList = data.roleList
        DataModel.CurrentData = data
        CheckExchangeSkill(DataModel.CurrentData, DataModel.roleList)
        CheckHasBlackCard(DataModel.CurrentData)
        TryAddDiscardBtn(DataModel.CurrentData)
        DataModel.IsChanged = true
        DataModel.isForbidCloud = false
        SaveData()
        if noPrompt ~= true then
          RefreshAll()
          CommonTips.OpenTips(GetText(80608607))
        end
      elseif keyData[1] == "Endless" then
        local endlessController = require("UIEndlessBattle/UIEndlessBattleController")
        local endlessData = endlessController:GetDataModel()
        local team = tonumber(keyData[2])
        endlessController:ClearTeamByIndex(team, true)
        if data.roleList[1] ~= data.header then
          for i = 1, #data.roleList do
            if data.roleList[i] == data.header then
              data.roleList[i] = data.roleList[1]
              data.roleList[1] = data.header
            end
          end
        end
        for i = 1, #data.roleList do
          local roleId = tostring(data.roleList[i])
          local curRoleTeam = endlessData.roleCheckMap[roleId]
          local curTeamIndex
          if curRoleTeam ~= nil then
            curTeamIndex = curRoleTeam.team
            endlessController:RemoveRoleToTeam(roleId, true)
          end
          endlessController:AddRoleToTeam(roleId, tonumber(keyData[2]), true)
        end
        endlessController:SaveCurLevelRoleList()
        DataModel.header = data.header
        DataModel.CurrentData = data
        CheckExchangeSkill(DataModel.CurrentData, DataModel.roleList)
        CheckHasBlackCard(DataModel.CurrentData)
        TryAddDiscardBtn(DataModel.CurrentData)
        DataModel.IsChanged = true
        SaveData()
        if noPrompt ~= true then
          RefreshAll()
          CommonTips.OpenTips(GetText(80608607))
        end
      end
    end
  end
  
  if rt == 1 then
    if noPrompt ~= true then
      CommonTips.OnPrompt(GetText(80608563), "80600068", "80600067", function()
        loadWhenSameRole()
      end)
    else
      loadWhenSameRole()
    end
  elseif rt == 2 then
    if DataModel.isInBattle == true then
      CommonTips.OnPrompt(GetText(80608783), "80600068", "80600067", function()
        DataModel.CurrentData = data
        CheckExchangeSkill(DataModel.CurrentData, DataModel.roleList)
        CheckHasBlackCard(DataModel.CurrentData)
        TryAddDiscardBtn(DataModel.CurrentData)
        DataModel.IsChanged = true
        SaveData()
        RefreshAll()
        CommonTips.OpenTips(GetText(80608607))
      end)
    elseif noPrompt ~= true then
      local headerCA = PlayerData:GetFactoryData(data.header)
      CommonTips.OnPrompt(string.format(GetText(80608564), headerCA.name), "80600068", "80600067", function()
        loadWhenDifferentHeader()
      end)
    else
      loadWhenDifferentHeader()
    end
  elseif rt == 3 then
    if DataModel.isInBattle == true then
      CommonTips.OnPrompt(GetText(80608784), "80600068", "80600067")
    elseif noPrompt ~= true then
      CommonTips.OnPrompt(GetText(80608566), "80600068", "80600067", function()
        loadWhenDifferentRole()
      end)
    else
      loadWhenDifferentRole()
    end
  elseif rt == 4 then
    if DataModel.isInBattle == true then
      CommonTips.OpenTips(GetText(80608784))
    else
      local notHaveRolesStr = ""
      for i = 1, #notHaveRoles do
        local roleCA = PlayerData:GetFactoryData(notHaveRoles[i])
        if notHaveRolesStr ~= "" then
          notHaveRolesStr = notHaveRolesStr .. GetText(80608608)
        end
        notHaveRolesStr = notHaveRolesStr .. roleCA.name
      end
      CommonTips.OnPrompt(string.format(GetText(80608565), notHaveRolesStr), "80600068", "80600067")
    end
  end
  return rt
end

local function LoadData()
  if PlayerData:GetPlayerPrefs("int", "CardAIOn", true) == 0 then
    DataModel.IsAutoBattleOn = false
  else
    DataModel.IsAutoBattleOn = true
  end
  local isChange = false
  local autoKey = "CardAIData" .. DataModel.teamKey
  local str = PlayerData:GetPlayerPrefs("string", autoKey, true)
  local cData = GetCloudData(autoKey)
  if cData.is_open and cData.is_open == "1" then
    local cStr = GetCloudStr(autoKey)
    if str == nil or string.getLength(str) < 1 then
      isChange = true
    end
    str = cStr
  end
  if str == nil or string.getLength(str) < 1 then
    local Data = {}
    Data.discardType = DataModel.DefaultValue.discardType
    Data.keepCardNum = DataModel.DefaultValue.keepCardNum
    Data.otherCard = DataModel.DefaultValue.otherCard
    Data.isLeaderCardOn = DataModel.DefaultValue.isLeaderCardOn
    Data.isSpCardOn = DataModel.DefaultValue.isSpCardOn
    Data.cardList = {}
    Data.cardIdMap = {}
    for i = 1, #DataModel.roleList do
      DataModel:AddCardsByUnitId(Data, DataModel.roleList[i])
    end
    DataModel.CurrentData = Data
    if TryAddDiscardBtn(Data) then
      isChange = true
    end
    if DataModel:CheckEquipCard(Data, DataModel.roleList) then
      isChange = true
    end
    SaveData(isChange)
  else
    local Data = Json.decode(str)
    local keyData = string.split(DataModel.teamKey, "_")
    if cData.is_open and cData.is_open == "1" and keyData[1] == "Abyss" then
      TryLoadDataByConfig(Data, true)
      return
    end
    if Data.discardType == nil then
      Data.discardType = DataModel.DefaultValue.discardType
    end
    if Data.keepCardNum == nil then
      Data.keepCardNum = DataModel.DefaultValue.keepCardNum
    end
    if Data.otherCard == nil then
      Data.otherCard = DataModel.DefaultValue.otherCard
    end
    if Data.cardList == nil then
      Data.cardList = {}
    end
    if Data.cardIdMap == nil then
      Data.cardIdMap = {}
    end
    if Data.isLeaderCardOn == nil then
      Data.isLeaderCardOn = DataModel.DefaultValue.isLeaderCardOn
    end
    if Data.isSpCardOn == nil then
      Data.isSpCardOn = DataModel.DefaultValue.isSpCardOn
    end
    DataModel.CurrentData = Data
    if RemoveNoCACard(Data) then
      isChange = true
    end
    if DataModel:CheckDirtyCard(Data, DataModel.roleList) then
      isChange = true
    end
    if DataModel:CheckCardList(Data, DataModel.roleList) then
      isChange = true
    end
    if DataModel:CheckEquipCard(Data, DataModel.roleList) then
      isChange = true
    end
    if CheckExchangeSkill(Data, DataModel.roleList) then
      isChange = true
    end
    if CheckHasBlackCard(Data) then
      isChange = true
    end
    if TryAddDiscardBtn(Data) then
      isChange = true
    end
    if isChange == true then
      SaveData(true)
    end
  end
end

local function ApplyAICoreSet()
  local BattleControlManager = CBus:GetManager(CS.ManagerName.BattleControlManager)
  local core = BattleControlManager.playerCardAICore
  core:ClearCommonActionEx()
  core:ClearCommonCardAvailableConditionEx()
  core:ClearCommonCardAdjustWeightEx()
  core:ClearCardWeightEx()
  core:ClearCardCondEx()
  core:ClearCardReplaceAction()
  if DataModel.CurrentData.isLeaderCardOn == true then
    core:AddCommonCardAdjustWeightEx(96200022, leadarCardWeight)
  end
  if DataModel.CurrentData.isSpCardOn == true then
    core:AddCommonCardAdjustWeightEx(96200021, spCardWeight)
  end
  if DataModel.CurrentData.discardType == 1 then
  else
    if DataModel.CurrentData.discardType == 2 then
    else
    end
  end
  local tKeepCard = DataModel.CurrentData.keepCardNum
  if tKeepCard == 0 then
    tKeepCard = -1
  end
  core:AddCommonCardAvailableConditionEx(96200010, true, tKeepCard)
  if DataModel.CurrentData.otherCard == 0 then
    core:AddCommonCardAdjustWeightEx(96200025, enemyWeight)
  elseif DataModel.CurrentData.otherCard == 2 then
    core:AddCommonCardAdjustWeightEx(96200025, notMetWeight)
  end
  for i = 1, #DataModel.CurrentData.cardList do
    local cardData = DataModel.CurrentData.cardList[i]
    if tostring(cardData.id) == discardBtnCardId then
      local cardCA = PlayerData:GetFactoryData(cardData.id)
      if cardData.useType == 1 then
        core:AddCommonActionEx(96300006, firstCardWeight - stepSubWeight * (i - 1), 96200034)
        core:AddCardWeightEx(cardData.id, firstCardWeight - stepSubWeight * (i - 1))
      elseif cardData.useType >= 3 and cardData.useType <= #cardCA.ExCondList + 2 then
        local condData = cardCA.ExCondList[cardData.useType - 2]
        local condId = condData.condId
        if condId <= 0 then
          condId = 96200016
        end
        core:AddCommonActionEx(96300006, firstCardWeight - stepSubWeight * (i - 1), condId)
        core:AddCardWeightEx(cardData.id, firstCardWeight - stepSubWeight * (i - 1))
      end
    else
      if cardData.useType ~= 2 then
        core:AddCardWeightEx(cardData.id, firstCardWeight - stepSubWeight * (i - 1))
      else
        core:AddCardWeightEx(cardData.id, banWeight)
      end
      local cardCA = PlayerData:GetFactoryData(cardData.id)
      if 2 < cardData.useType and cardData.useType <= #cardCA.ExCondList + 2 then
        local condData = cardCA.ExCondList[cardData.useType - 2]
        local param = cardData.useParam
        if condData.typeEnum == "percent" then
          param = SafeMath.FloatToSafeNumber(param / 100.0)
        end
        core:AddCardCondEx(tonumber(cardData.id), condData.condId, notMetWeight, param)
      end
      if cardData.useType > #cardCA.ExCondList + 2 then
        local actData = cardCA.ExActList[cardData.useType - #cardCA.ExCondList - 2]
        if actData ~= nil then
          core:AddCardReplaceAction(tonumber(cardData.id), tonumber(actData.condId), -1, 2, cardData.useParam)
        end
      end
      if cardCA.linkCardId ~= nil then
        for j = 1, #cardCA.linkCardId do
          local cardId = tonumber(cardCA.linkCardId[j].Id)
          if cardData.useType ~= 2 then
            core:AddCardWeightEx(cardId, firstCardWeight - stepSubWeight * (i - 1))
          else
            core:AddCardWeightEx(cardId, banWeight)
          end
          if 2 < cardData.useType and cardData.useType <= #cardCA.ExCondList + 2 then
            local condData = cardCA.ExCondList[cardData.useType - 2]
            local param = cardData.useParam
            if condData.typeEnum == "percent" then
              param = SafeMath.FloatToSafeNumber(param / 100.0)
            end
            core:AddCardCondEx(tonumber(cardId), condData.condId, notMetWeight, param)
          end
          if cardData.useType > #cardCA.ExCondList + 2 then
            local actData = cardCA.ExActList[cardData.useType - #cardCA.ExCondList - 2]
            if actData ~= nil then
              core:AddCardReplaceAction(tonumber(cardId), tonumber(actData.condId), -1, 2, cardData.useParam)
            end
          end
        end
      end
    end
  end
end

local function SetKeepCardNum(num)
  if num < 0 then
    DataModel.CurrentData.keepCardNum = 0
  elseif num > DataModel.sKeepCardNumMax then
    DataModel.CurrentData.keepCardNum = DataModel.sKeepCardNumMax
  else
    DataModel.CurrentData.keepCardNum = num
  end
  ShowKeepCardNum()
end

local function SetCardView(element, data)
  local ownerId = data.ownerId or 10000001
  local curRole = PlayerData:GetRoleById(ownerId)
  local bg
  if curRole and curRole.current_skin then
    bg = PlayerData:GetFactoryData(curRole.current_skin[1], "UnitViewFactory").roleListResUrl
  else
    local roleCA = PlayerData:GetFactoryData(ownerId)
    if roleCA == nil then
      roleCA = PlayerData:GetFactoryData(10000001)
    end
    local viewId = roleCA.viewId
    local viewCA = PlayerData:GetFactoryData(viewId)
    if viewCA ~= nil and viewCA.roleListResUrl ~= nil and viewCA.roleListResUrl ~= "" then
      bg = PlayerData:GetFactoryData(viewId).roleListResUrl
    else
      bg = PlayerData:GetFactoryData(99900008, "ConfigFactory").teamCardPath
    end
  end
  element.Btn_Front.Img_MaskCharacter.Img_Character:SetSprite(bg)
  local cardCA = PlayerData:GetFactoryData(data.id)
  element.Btn_Front.Group_SkillIcon.Img_MaskSkill.Img_Skill:SetSprite(cardCA.iconPath)
  element.Btn_Front.Txt_SkillName:SetText(cardCA.name)
  local cost = cardCA.cost_SN
  element.Btn_Front.Group_Cost.Img_Nums:SetNum(cost)
  element.Btn_Front.Group_Ban:SetActive(data.useType == 2)
  if tonumber(ownerId) == tonumber(DataModel.header) and data.skillIndex == 3 then
    element.Btn_Front.Group_LeaderSkill:SetActive(true)
  else
    element.Btn_Front.Group_LeaderSkill:SetActive(false)
  end
end

local function SetTeamData(key, roleList, header)
  DataModel.teamKey = tostring(key)
  DataModel.roleList = roleList
  DataModel.header = header
  LoadData()
end

local function CloseCardDetail()
  local index = DataModel.curDetailIndex
  DataModel.curDetailIndex = nil
  local detailDataModel = require("UICardDeatil/UICardDeatilDataModel")
  DataModel.CurrentData.cardList[index].useType = detailDataModel.curData.useType
  DataModel.CurrentData.cardList[index].useParam = detailDataModel.curData.useParam
  if DataModel.CurrentData.cardList[index].useParamMap == nil then
    DataModel.CurrentData.cardList[index].useParamMap = {}
  end
  if detailDataModel.curData.useParamMap ~= nil then
    for k, v in pairs(detailDataModel.curData.useParamMap) do
      DataModel.CurrentData.cardList[index].useParamMap[k] = v
    end
  end
  local scrollGridCard = View.Group_Main.ScrollView_Group_Weight.Viewport.Content.ScrollGrid_Card
  scrollGridCard.grid.self:RefreshAllElement()
  DataModel.IsChanged = true
  SaveData()
end

local function OpenCardDetail(cardIndex)
  DataModel.curDetailIndex = cardIndex
  UIManager:Open("UI/Battle/AutoBattle/New/CardDeatil", Json.encode(DataModel.CurrentData.cardList[cardIndex]), function()
    CloseCardDetail()
  end)
end

local function GetMousePos()
  local minScale = math.min(GameSetting.scaleWidth, GameSetting.scaleHeight)
  local position = Input.mousePosition
  position = Vector3((position.x - Screen.width * 0.5) / minScale - 90, (position.y - Screen.height * 0.5) / minScale + 130, position.z)
  return position
end

local function BeginDrag(index)
  if DataModel.curFrameMouseUp then
    return
  end
  local data = DataModel.CurrentData.cardList[index]
  if data == nil then
    return
  end
  DataModel.isDrag = true
  DataModel.dragIdx = index
  local pos = GetMousePos()
  View.Group_CardTemp.self:SetLocalPosition(pos)
  SetCardView(View.Group_CardTemp, data)
  View.Group_CardTemp:SetActive(true)
  local scrollGridCard = View.Group_Main.ScrollView_Group_Weight.Viewport.Content.ScrollGrid_Card
  scrollGridCard.grid.self:RefreshAllElement()
  scrollGridCard.self:SetEnable(false)
end

local function CalcDragingPos()
  local scrollGridCard = View.Group_Main.ScrollView_Group_Weight.Viewport.Content.ScrollGrid_Card
  local cardCount = scrollGridCard.self.gridController.DataCount
  local toIndex = -1
  local pos = scrollGridCard.grid.self.ViewportTransform:InverseTransformPoint(View.Group_CardTemp.self.transform.position)
  for i = 1, cardCount do
    local groupCard = scrollGridCard.grid.self:GetElementByIndex(i - 1)
    if groupCard ~= nil then
      local gridPos = scrollGridCard.grid.self.ViewportTransform:InverseTransformPoint(groupCard.self.transform.position)
      if math.abs(gridPos.x - pos.x) <= 90 and math.abs(gridPos.y - pos.y) <= 130 then
        toIndex = i
        break
      end
      if toIndex ~= -1 then
        break
      end
    end
  end
  return toIndex
end

local function Draging()
  local scrollGridCard = View.Group_Main.ScrollView_Group_Weight.Viewport.Content.ScrollGrid_Card
  local pos = scrollGridCard.self.transform:InverseTransformPoint(View.Group_CardTemp.self.transform.position)
  local h = scrollGridCard.self.transform.rect.height
  if h / 2 - pos.y < -130 then
    local prog = scrollGridCard.grid.self:GetSyncProgress()
    scrollGridCard.grid.self:SetSyncProgress(math.max(prog - 0.001, 0), 0)
    scrollGridCard.grid.self:HandleScrollEvent(Vector2(0, scrollGridCard.grid.self.ScrollRect.verticalNormalizedPosition))
    return
  end
  if pos.y - -h / 2 < 130 then
    local prog = scrollGridCard.grid.self:GetSyncProgress()
    local gridH = scrollGridCard.grid.self.RectTransform.rect.height
    local maxProg = math.min(1, (gridH - h) / gridH)
    scrollGridCard.grid.self:SetSyncProgress(math.min(prog + 0.001, maxProg), 0)
    scrollGridCard.grid.self:HandleScrollEvent(Vector2(0, scrollGridCard.grid.self.ScrollRect.verticalNormalizedPosition))
    return
  end
end

local function DragEnd()
  local toIdx = CalcDragingPos()
  if toIdx ~= -1 and DataModel.dragIdx ~= toIdx then
    local data = DataModel.CurrentData.cardList[DataModel.dragIdx]
    table.remove(DataModel.CurrentData.cardList, DataModel.dragIdx)
    table.insert(DataModel.CurrentData.cardList, toIdx, data)
    DataModel.IsChanged = true
  end
  DataModel.dragIdx = nil
  View.Group_CardTemp:SetActive(false)
  local scrollGridCard = View.Group_Main.ScrollView_Group_Weight.Viewport.Content.ScrollGrid_Card
  scrollGridCard.self:SetEnable(true)
  scrollGridCard.grid.self:RefreshAllElement()
end

local function SortCardByColor(weight)
  if weight == nil then
    weight = DataModel.defaultColorWeight
  end
  DataModel:SortCardByColor(DataModel.CurrentData, weight)
  DataModel.IsChanged = true
  local scrollGridCard = View.Group_Main.ScrollView_Group_Weight.Viewport.Content.ScrollGrid_Card
  scrollGridCard.self:SetEnable(true)
  scrollGridCard.grid.self:RefreshAllElement()
end

local ViewFunction = {
  AutoBattle_Group_TopBar_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    SaveData()
    UIManager:GoBack()
    if DataModel.isInBattle == true then
      ApplyAICoreSet()
      local BattleControlManager = CBus:GetManager(CS.ManagerName.BattleControlManager)
      BattleControlManager:Pause(false)
    end
  end,
  AutoBattle_Group_TopBar_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    SaveData()
    UIManager:GoHome()
  end,
  AutoBattle_Group_TopBar_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  AutoBattle_Group_TopBar_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  AutoBattle_Group_TopBar_Group_TopButtons_Group_Weight_Btn_Off_Click = function(btn, str)
    SelectSettingMode(1)
    View.self:PlayAnimOnce("AutoBattle_Weight")
  end,
  AutoBattle_Group_TopBar_Group_TopButtons_Group_CardsSetting_Btn_Off_Click = function(btn, str)
    SelectSettingMode(2)
    View.self:PlayAnimOnce("AutoBattle_CardsSetting")
  end,
  AutoBattle_Group_Main_ScrollView_Group_Weight_Viewport_Content_Group_Title_Btn_Recommended_Click = function(btn, str)
  end,
  AutoBattle_Group_Main_ScrollView_Group_Weight_Viewport_Content_Group_Title_Btn_Quick_Click = function(btn, str)
    UIManager:Open("UI/Battle/AutoBattle/New/QuickSet", nil, function()
      local quickSetData = require("UIQuickSet/UIQuickSetDataModel")
      local weight = quickSetData:GetColorWeight()
      SortCardByColor(weight)
      SaveData()
    end)
  end,
  AutoBattle_Group_Main_ScrollView_Group_CardsSetting_Viewport_Content_Group_Discard_Group_Ban_Btn_Off_Click = function(btn, str)
    local group = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_Discard
    if DataModel.CurrentData.discardType == 2 then
      group.Group_Active.self:SetEnableAnimator(true)
      View.self:SelectPlayAnim(group.Group_Active.self, "DisCardBtnOff")
    elseif DataModel.CurrentData.discardType == 3 then
      group.Group_NoCard.self:SetEnableAnimator(true)
      View.self:SelectPlayAnim(group.Group_NoCard.self, "DisCardBtnOff")
    end
    if DataModel.CurrentData.discardType ~= 1 then
      group.Group_Ban.self:SetEnableAnimator(true)
      View.self:SelectPlayAnim(group.Group_Ban.self, "DisCardBtnOn")
    end
    DataModel.CurrentData.discardType = 1
    SetDiscardBtnView()
    DataModel.IsChanged = true
  end,
  AutoBattle_Group_Main_ScrollView_Group_CardsSetting_Viewport_Content_Group_Discard_Group_Active_Btn_Off_Click = function(btn, str)
    local group = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_Discard
    if DataModel.CurrentData.discardType == 1 then
      group.Group_Ban.self:SetEnableAnimator(true)
      View.self:SelectPlayAnim(group.Group_Ban.self, "DisCardBtnOff")
    elseif DataModel.CurrentData.discardType == 3 then
      group.Group_NoCard.self:SetEnableAnimator(true)
      View.self:SelectPlayAnim(group.Group_NoCard.self, "DisCardBtnOff")
    end
    if DataModel.CurrentData.discardType ~= 2 then
      group.Group_Active.self:SetEnableAnimator(true)
      View.self:SelectPlayAnim(group.Group_Active.self, "DisCardBtnOn")
    end
    DataModel.CurrentData.discardType = 2
    SetDiscardBtnView()
    DataModel.IsChanged = true
  end,
  AutoBattle_Group_Main_ScrollView_Group_CardsSetting_Viewport_Content_Group_Discard_Group_NoCard_Btn_Off_Click = function(btn, str)
    local group = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_Discard
    if DataModel.CurrentData.discardType == 1 then
      group.Group_Ban.self:SetEnableAnimator(true)
      View.self:SelectPlayAnim(group.Group_Ban.self, "DisCardBtnOff")
    elseif DataModel.CurrentData.discardType == 2 then
      group.Group_Active.self:SetEnableAnimator(true)
      View.self:SelectPlayAnim(group.Group_Active.self, "DisCardBtnOff")
    end
    if DataModel.CurrentData.discardType ~= 3 then
      group.Group_NoCard.self:SetEnableAnimator(true)
      View.self:SelectPlayAnim(group.Group_NoCard.self, "DisCardBtnOn")
    end
    DataModel.CurrentData.discardType = 3
    SetDiscardBtnView()
    DataModel.IsChanged = true
  end,
  AutoBattle_Group_Main_ScrollView_Group_CardsSetting_Viewport_Content_Group_keepCard_Group_Btns_Btn_Add_Click = function(btn, str)
    SetKeepCardNum(DataModel.CurrentData.keepCardNum + 1)
    DataModel.IsChanged = true
  end,
  AutoBattle_Group_Main_ScrollView_Group_CardsSetting_Viewport_Content_Group_keepCard_Group_Btns_Btn_Sub_Click = function(btn, str)
    SetKeepCardNum(DataModel.CurrentData.keepCardNum - 1)
    DataModel.IsChanged = true
  end,
  AutoBattle_Group_Main_ScrollView_Group_CardsSetting_Viewport_Content_Group_OtherCards_Group_Btns_Group_FirstUse_Btn_Off_Click = function(btn, str)
    local group = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_OtherCards.Group_Btns
    if DataModel.CurrentData.otherCard == 1 then
      group.Group_LastUse.self:SetEnableAnimator(true)
      View.self:SelectPlayAnim(group.Group_LastUse.self, "DisCardBtnOff")
    elseif DataModel.CurrentData.otherCard == 2 then
      group.Group_DontUse.self:SetEnableAnimator(true)
      View.self:SelectPlayAnim(group.Group_DontUse.self, "DisCardBtnOff")
    end
    if DataModel.CurrentData.otherCard ~= 0 then
      group.Group_FirstUse.self:SetEnableAnimator(true)
      View.self:SelectPlayAnim(group.Group_FirstUse.self, "DisCardBtnOn")
    end
    DataModel.CurrentData.otherCard = 0
    SetOtherCardView()
    DataModel.IsChanged = true
  end,
  AutoBattle_Group_Main_ScrollView_Group_CardsSetting_Viewport_Content_Group_OtherCards_Group_Btns_Group_LastUse_Btn_Off_Click = function(btn, str)
    local group = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_OtherCards.Group_Btns
    if DataModel.CurrentData.otherCard == 0 then
      group.Group_FirstUse.self:SetEnableAnimator(true)
      View.self:SelectPlayAnim(group.Group_FirstUse.self, "DisCardBtnOff")
    elseif DataModel.CurrentData.otherCard == 2 then
      group.Group_DontUse.self:SetEnableAnimator(true)
      View.self:SelectPlayAnim(group.Group_DontUse.self, "DisCardBtnOff")
    end
    if DataModel.CurrentData.otherCard ~= 1 then
      group.Group_LastUse.self:SetEnableAnimator(true)
      View.self:SelectPlayAnim(group.Group_LastUse.self, "DisCardBtnOn")
    end
    DataModel.CurrentData.otherCard = 1
    SetOtherCardView()
    DataModel.IsChanged = true
  end,
  AutoBattle_Group_Main_ScrollView_Group_CardsSetting_Viewport_Content_Group_OtherCards_Group_Btns_Group_DontUse_Btn_Off_Click = function(btn, str)
    local group = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content.Group_OtherCards.Group_Btns
    if DataModel.CurrentData.otherCard == 0 then
      group.Group_FirstUse.self:SetEnableAnimator(true)
      View.self:SelectPlayAnim(group.Group_FirstUse.self, "DisCardBtnOff")
    elseif DataModel.CurrentData.otherCard == 1 then
      group.Group_LastUse.self:SetEnableAnimator(true)
      View.self:SelectPlayAnim(group.Group_LastUse.self, "DisCardBtnOff")
    end
    if DataModel.CurrentData.otherCard ~= 2 then
      group.Group_DontUse.self:SetEnableAnimator(true)
      View.self:SelectPlayAnim(group.Group_DontUse.self, "DisCardBtnOn")
    end
    DataModel.CurrentData.otherCard = 2
    SetOtherCardView()
    DataModel.IsChanged = true
  end,
  AutoBattle_Group_Main_ScrollView_Group_CardsSetting_Viewport_Content_Group_Share_Btn_ConfigOut_Click = function(btn, str)
    local data = Clone(DataModel.CurrentData)
    data.roleList = DataModel.roleList
    data.header = DataModel.header
    local str = Json.encode(data)
    local str64 = CompressData(str)
    CS.UnityEngine.GUIUtility.systemCopyBuffer = str64
    CommonTips.OpenTips(GetText(80608606))
  end,
  AutoBattle_Group_Main_ScrollView_Group_CardsSetting_Viewport_Content_Group_Share_Btn_ConfigIn_Click = function(btn, str)
    local str64 = CS.UnityEngine.GUIUtility.systemCopyBuffer
    local str = DeCompressData(str64)
    local len = string.len(str)
    if str:sub(1, 1) ~= "{" or str:sub(len, len) ~= "}" or not pcall(function()
      Json.decode(str)
    end) then
      CommonTips.OpenTips(GetText(80608108))
      return
    end
    local data = Json.decode(str)
    if table.count(data) == 0 then
      CommonTips.OpenTips(GetText(80608108))
      return
    end
    TryLoadDataByConfig(data)
  end,
  AutoBattle_Group_Main_ScrollView_Group_Weight_Viewport_Content_ScrollGrid_Card_SetGrid = function(element, elementIndex)
    element.Btn_Front:SetActive(DataModel.dragIdx ~= elementIndex)
    if DataModel.dragIdx == elementIndex then
      return
    end
    local data = DataModel.CurrentData.cardList[elementIndex]
    SetCardView(element, data)
    element.Btn_Front:SetClickParam(elementIndex)
  end,
  AutoBattle_Group_Main_ScrollView_Group_Weight_Viewport_Content_ScrollGrid_Card_Group_Card_Btn_Front_Click = function(btn, str)
    OpenCardDetail(tonumber(str))
  end,
  AutoBattle_Group_Main_ScrollView_Group_Weight_Viewport_Content_ScrollGrid_Card_Group_Card_Btn_Front_LongPress = function(btn, str)
    BeginDrag(tonumber(str))
  end,
  AutoBattle_Group_Main_ScrollView_Group_Weight_Viewport_Content_Group_Card_Btn_Front_Click = function(btn, str)
  end,
  AutoBattle_Group_Main_ScrollView_Group_Weight_Viewport_Content_Group_Card_Btn_Front_LongPress = function(btn, str)
  end,
  AutoBattle_Group_Main_ScrollView_Group_CardsSetting_Viewport_Content_Group_Row_teamleaderSkill_Btn_Switch_Click = function(btn, str)
    DataModel.CurrentData.isLeaderCardOn = not DataModel.CurrentData.isLeaderCardOn
    local animeName = ""
    if DataModel.CurrentData.isLeaderCardOn then
      animeName = "ProudskillBtnOn"
    else
      animeName = "ProudskillBtnOff"
    end
    local content = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content
    View.self:SelectPlayAnim(content.Group_Row_teamleaderSkill.Btn_Switch.self, animeName)
    SetLeaderCardView()
    DataModel.IsChanged = true
  end,
  AutoBattle_Group_Main_ScrollView_Group_CardsSetting_Viewport_Content_Group_Row_spSkill_Btn_Switch_Click = function(btn, str)
    DataModel.CurrentData.isSpCardOn = not DataModel.CurrentData.isSpCardOn
    local animeName = ""
    if DataModel.CurrentData.isSpCardOn then
      animeName = "ProudskillBtnOn"
    else
      animeName = "ProudskillBtnOff"
    end
    local content = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content
    View.self:SelectPlayAnim(content.Group_Row_spSkill.Btn_Switch.self, animeName)
    SetSpCardView()
    DataModel.IsChanged = true
  end,
  AutoBattle_Group_CardTemp_Btn_Front_Click = function(btn, str)
  end,
  AutoBattle_Group_CardTemp_Btn_Front_LongPress = function(btn, str)
  end,
  AutoBattle_Group_Main_ScrollView_Group_CardsSetting_Viewport_Content_Group_Row_configUpload_Btn_Switch_Click = function(btn, str)
    local autoKey = "CardAIData" .. DataModel.teamKey
    local cData = GetCloudData(autoKey)
    local isAuto = not cData.is_open or cData.is_open ~= "1"
    local animeName = ""
    SetConfigUploadView()
    DataModel.IsChanged = true
    local data = Clone(DataModel.CurrentData)
    data.roleList = DataModel.roleList
    data.header = DataModel.header
    local str = Json.encode(data)
    local autoKey = "CardAIData" .. DataModel.teamKey
    if isAuto then
      animeName = "ProudskillBtnOn"
      SaveCloudData(autoKey, str, true)
    else
      animeName = "ProudskillBtnOff"
      SaveCloudData(autoKey, str, false)
    end
    local content = View.Group_Main.ScrollView_Group_CardsSetting.Viewport.Content
    View.self:SelectPlayAnim(content.Group_Row_configUpload.Btn_Switch.self, animeName)
  end,
  AutoBattle_Group_Header_Group_Header_Right_Btn_Pre1_Click = function(btn, str)
    ChangeSet(1)
    RefreshAll()
  end,
  AutoBattle_Group_Header_Group_Header_Right_Btn_Pre2_Click = function(btn, str)
    ChangeSet(2)
    RefreshAll()
  end,
  AutoBattle_Group_Header_Group_Header_Right_Btn_Pre3_Click = function(btn, str)
    ChangeSet(3)
    RefreshAll()
  end,
  SetDiscardBtnView = function()
    SetDiscardBtnView()
  end,
  ShowKeepCardNum = function()
    ShowKeepCardNum()
  end,
  RefreshAll = function()
    RefreshAll()
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_5_Group_ResetBorder_Btn_Reset_Click = function(btn, str)
    Reset()
    RefreshAll()
    DataModel.IsChanged = true
  end,
  IsAutoBattleAvailable = function()
    return IsAutoBattleAvailable()
  end,
  IsAutoBattle = function()
    return DataModel.IsAutoBattleOn
  end,
  LoadData = function()
    LoadData()
  end,
  SaveData = function(forceChange)
    SaveData(forceChange)
  end,
  ApplyAICoreSet = function()
    ApplyAICoreSet()
  end,
  SelectSettingMode = function()
    SelectSettingMode()
  end,
  SetTeamData = function(key, roleList, header)
    SetTeamData(key, roleList, header)
  end,
  CheckExchangeSkill = function(curData, roleList)
    return CheckExchangeSkill(curData, roleList)
  end,
  GetMousePos = function()
    return GetMousePos()
  end,
  BeginDrag = function()
    BeginDrag()
  end,
  CalcDragingPos = function()
    return CalcDragingPos()
  end,
  Draging = function()
    Draging()
  end,
  DragEnd = function()
    DragEnd()
  end,
  SetOtherCardView = function()
    SetOtherCardView()
  end,
  SaveCloudData = function(self, key, str)
    SaveCloudData(key, str)
  end,
  GetCloudData = function(self, key)
    return GetCloudData(key)
  end,
  GetCloudStr = function(self, key)
    return GetCloudStr(key)
  end,
  DeCompressData = function(str64)
    return DeCompressData(str64)
  end
}
return ViewFunction
