local this = class("kiboDuelSimulatorStore", G_BaseStore)
this.event = {}
this.constSaveKey = "kiboDuelSimulatorTeam"
this:importPartialClass(require(L_R.store .. "kiboDuelSimulator.kiboDuelSimulatorState"))

function this:getData()
  return self.data
end

function this:getPlayerInfo(side)
  return self.data.playerInfo[side]
end

function this:saveNameList(list)
  local path = "../Client/Assets/ResourcesAssets/Config/World/Home/kibo_duel_simulator_name.bytes"
  self:SaveTableToFile(path, self:SerializeTable(list))
end

function this:getNameList()
  local path = "../Client/Assets/ResourcesAssets/Config/World/Home/kibo_duel_simulator_name.bytes"
  if not C_BattleDebugLuaUtility.IsLuaExists(path) then
    return self:getDefaultNameList()
  end
  local chunk, err = loadfile(path)
  if not chunk then
    return self:getDefaultNameList()
  end
  local success, result = pcall(chunk)
  if not success then
    return self:getDefaultNameList()
  end
  return result
end

function this:getDefaultNameList()
  local list = {}
  for i = 1, 5 do
    list[i] = {
      id = i,
      name = L_WordsTpl:getValue("residual_code_kiboduelsimulatorstore_01") .. i
    }
  end
  return list
end

function this:saveCurInfo(index)
  local path = string.format("../Client/Assets/ResourcesAssets/Config/World/Home/kibo_duel_simulator_%s.bytes", index)
  local serialized = self:SerializeTable(self:dataToTable())
  self:SaveTableToFile(path, serialized)
end

function this:resetLoadInfo(index)
  local path = string.format("../Client/Assets/ResourcesAssets/Config/World/Home/kibo_duel_simulator_%s.bytes", index)
  if not C_BattleDebugLuaUtility.IsLuaExists(path) then
    self:initData()
    return
  end
  local chunk, err = loadfile(path)
  if not chunk then
    self:initData()
    return
  end
  local success, result = pcall(chunk)
  if not success then
    self:initData()
    return
  end
  self:getSaveData(result)
end

function this:storeKiboInfo()
  local data = {}
  for i = 1, 8 do
    local simulatorData = self.data.playerInfo[1].kiboList[i]
    data[i] = {
      guid = 99 + i,
      config_id = simulatorData.kiboId,
      lv = simulatorData.lv
    }
  end
  L_PetStore:syncPetItem(data)
end

function this:setCSharpData()
  if not self:checkData() then
    return false
  end
  local csData = C_KiboDuelSimulatorManager.instance.kiboDuelTeam
  csData.isRing = self.data.isRing
  csData.tdInfoId = self.data.kiboDuelId
  csData.sceneId = self.data.sceneId
  csData.enemyData.behaviourName = self.data.behaviorName
  csData.enemyData.fsmName = self.data.fsmName
  csData.enemyData:SetSummonListLength(#self.data.summonList)
  for i, v in ipairs(self.data.summonList) do
    for j = 1, 5 do
      csData.enemyData.summonList[i - 1][j - 1] = v[j]
    end
  end
  local gameConstTpl = L_GameTpl:getGameConstTpl()
  local skillList = gameConstTpl:getData("KIBO_DUEL_HERO_SKILL", L_Const.GameTplType.list_int)
  for i = 1, 2 do
    local playerInfo = self.data.playerInfo[i]
    local sideData = i == 1 and csData.heroData or csData.enemyData
    sideData.playerEntityId = playerInfo.playerEntityId
    for index, v in ipairs(playerInfo.skillList) do
      if 0 < v then
        sideData.playerSkillList[index - 1] = v
      else
        sideData.playerSkillList[index - 1] = skillList[index]
      end
    end
    for j = 1, 8 do
      local luaKiboData = playerInfo.kiboList[j]
      local csKiboData = sideData.kiboTeamList[j - 1]
      csKiboData.kiboId = luaKiboData.kiboId
      csKiboData.source_pet_guid = i * 100 + j - 1
      csKiboData.level = luaKiboData.lv
    end
  end
  return true
end

function this:updateDataByConfig(configId)
  local td = L_GameTpl:getKiboDuelTpl()
  local tpl = td:getTplById(configId)
  self.data.isRing = false
  self.data.kiboDuelId = configId
  self.data.sceneId = td:getMapId(tpl)
  local behaviorName = string.match(td:getBehaviortree(tpl), ".*/([^/]+)$")
  local result1 = string.gsub(behaviorName, "^ast_(.*)%.asset$", "%1")
  self.data.behaviorName = result1
  local fsmName = string.match(td:getFsm(tpl), ".*/([^/]+)$")
  local result2 = string.gsub(fsmName, "^ast_(.*)%.asset$", "%1")
  self.data.fsmName = result2
  self.data.summonList = td:getParam(tpl)
  self.data.playerInfo[1].skillList = {
    td:getSkillList(tpl)[1],
    td:getSkillList(tpl)[2]
  }
  self.data.playerInfo[2].playerEntityId = td:getNpcSpawnerID(tpl)
  self.data.playerInfo[2].skillList = {}
  local param = td:getEnemy(tpl)
  local enemyKiboList = {}
  for i, v in pairs(param) do
    table.insert(enemyKiboList, {i, v})
  end
  for j = 1, 8 do
    if enemyKiboList[j] then
      self.data.playerInfo[2].kiboList[j].kiboId = enemyKiboList[j][1]
      self.data.playerInfo[2].kiboList[j].lv = enemyKiboList[j][2]
    end
  end
end

function this:checkData()
  local check = true
  local errorTips = "【奇波对战模拟器】奇波对战战斗数据错误！\n"
  for i = 1, 8 do
    local kiboInfo = self.data.playerInfo[1].kiboList[i]
    if not kiboInfo.kiboId then
      errorTips = errorTips .. "我方上阵奇波未满！\n"
      check = false
      break
    end
  end
  for i = 1, 8 do
    local kiboInfo = self.data.playerInfo[2].kiboList[i]
    if not kiboInfo.kiboId then
      errorTips = errorTips .. "敌方上阵奇波未满！\n"
      check = false
      break
    end
  end
  if not check then
    error(errorTips)
  end
  return check
end

function this:SerializeTable(tbl, indent)
  indent = indent or 0
  local spaces = string.rep(" ", indent)
  local result = {}
  table.insert(result, "{\n")
  for k, v in pairs(tbl) do
    local key
    if type(k) == "string" and string.match(k, "^[a-zA-Z_][a-zA-Z0-9_]*$") then
      key = k
    else
      key = "[" .. tostring(k) .. "]"
    end
    local value
    if type(v) == "table" then
      value = self:SerializeTable(v, indent + 4)
    elseif type(v) == "string" then
      value = string.format("%q", v)
    elseif type(v) == "function" then
      value = "function() --[[函数内容被省略]] end"
    else
      value = tostring(v)
    end
    table.insert(result, string.format("%s    %s = %s,\n", spaces, key, value))
  end
  table.insert(result, spaces .. "}")
  return table.concat(result)
end

function this:SaveTableToFile(filePath, serialized)
  local file = io.open(filePath, "w")
  if not file then
    return false, "无法打开文件进行写入: " .. filePath
  end
  file:write("return " .. serialized)
  file:close()
  return true
end

return this
