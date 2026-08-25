local BattleDbgEntryPanel, Super = System.NewClass("BattleDbgEntryPanel", UIBasePanel)
BattleDbgEntryPanel.uiResCls = Panel_Gm_Battle_Dbg_EntryResource
RegisterLuaModule("ServerUtil", "GameScript.Utils.ServerUtil")

function BattleDbgEntryPanel:ctor(isPVP, clickCallback)
  Super.ctor(self)
  self.isLogin = SceneMgr.Instance:IsLoginScene()
  self.isPVP = isPVP
  self.clickCallback = clickCallback
end

function BattleDbgEntryPanel:OnBind(binder)
  self.binder = binder
  self.mockData = table.deepclone(DT.MockDataConfig[1])
  local index = 1
  self.levels = {}
  for i, tid in ipairs(self.mockData.Awakers) do
    local level = self.mockData.Levels[i]
    local awakerCfg = DT.AwakerConfig[tid]
    binder:SetText(self.ui["Text_Input" .. index], awakerCfg.ID .. "-" .. LT.Text(awakerCfg.Name))
    self.levels[index] = level
    index = index + 1
  end
  local battleId = self.mockData.BattleID
  local battleCfg = DT.BattleConfig[battleId]
  local sceneCfg = DT.BattleSceneConfig[battleCfg.SceneID]
  local sceneName = PathStrUtils.GetBaseName(sceneCfg.BattleScene)
  binder:SetText(self.ui.Text_Scene, sceneCfg.ID .. "-" .. sceneName)
  self.ui.GroupCampMonster:SetActive(true)
  self:RecoverLocalData()
  self.binder:BindButtonClick(self.ui.Btn_Cancel, System.fn(self, self.OnClickCancle))
  self.binder:BindButtonClick(self.ui.Btn_Enter, System.fn(self, self.OnClickEnter))
  for i = 1, 4 do
    self.binder:BindButtonClick(self.ui["InputFidle_ID" .. i], System.bind(self.OnClickAwaker, self, i))
  end
  for i = 1, 5 do
    self.binder:BindButtonClick(self.ui["Monster_ID" .. i], System.bind(self.OnClickMonster, self, i))
    self.binder:BindButtonClick(self.ui["Pos_ID" .. i], System.bind(self.OnClickPos, self, i))
  end
  for i = 1, 8 do
    self.binder:BindButtonClick(self.ui["Relic_ID" .. i], System.bind(self.OnClickRelic, self, i))
  end
  for i = 1, 4 do
    self.binder:BindButtonClick(self.ui["Weapon_ID" .. i], System.bind(self.OnClickPVPWeapon, self, i))
  end
  for i = 1, 2 do
    self.binder:BindButtonClick(self.ui["Keeper_ID" .. i], System.bind(self.OnClickPVPKeeper, self, i))
  end
  self.binder:BindButtonClick(self.ui.SceneInfo, System.fn(self, self.OnClickScene))
  self.binder:BindButtonClick(self.ui.ShowInfo, System.fn(self, self.OnClickShowInfo))
  self.binder:BindButtonClick(self.ui.BattleInfo, System.fn(self, self.OnClickBattle))
  self.binder:BindButtonClick(self.ui.GenderInfo, System.fn(self, self.OnClickGender))
  self.binder:BindButtonClick(self.ui.KeeperSkillInfo, System.fn(self, self.OnClickKeeperInfo))
  self.binder:BindButtonClick(self.ui.PVPDir, System.fn(self, self.OnClickPVPDir))
  self:ReadLocalFile()
end

function BattleDbgEntryPanel:ReadLocalFile()
  for i = 1, 4 do
    MobileFileDataManager.Instance:ReadTextFromLocalFile(self, "Text_Input" .. i)
  end
  for i = 1, 5 do
    MobileFileDataManager.Instance:ReadTextFromLocalFile(self, "Monster_Name" .. i)
    MobileFileDataManager.Instance:ReadTextFromLocalFile(self, "Pos_Name" .. i)
    MobileFileDataManager.Instance:ReadTextFromLocalFile(self, "MonterHp_Input" .. i)
  end
  MobileFileDataManager.Instance:ReadTextFromLocalFile(self, "RoleHp_Input")
  for i = 1, 8 do
    MobileFileDataManager.Instance:ReadTextFromLocalFile(self, "Relic_Name" .. i)
  end
  for i = 1, 4 do
    MobileFileDataManager.Instance:ReadTextFromLocalFile(self, "Weapon_Name" .. i)
  end
  for i = 1, 2 do
    MobileFileDataManager.Instance:ReadTextFromLocalFile(self, "Keeper_Name" .. i)
  end
  MobileFileDataManager.Instance:ReadTextFromLocalFile(self, "Text_Scene")
  MobileFileDataManager.Instance:ReadTextFromLocalFile(self, "Text_ShowInfo")
  MobileFileDataManager.Instance:ReadTextFromLocalFile(self, "Text_Battle")
  MobileFileDataManager.Instance:ReadTextFromLocalFile(self, "Text_Gender")
  MobileFileDataManager.Instance:ReadTextFromLocalFile(self, "Text_KeeperSkill")
  MobileFileDataManager.Instance:ReadTextFromLocalFile(self, "Text_PVPDir")
end

function BattleDbgEntryPanel:SaveLocalFile()
  for i = 1, 4 do
    MobileFileDataManager.Instance:SaveTextFromLocalFile(self, "Text_Input" .. i)
  end
  for i = 1, 5 do
    MobileFileDataManager.Instance:SaveTextFromLocalFile(self, "Monster_Name" .. i)
    MobileFileDataManager.Instance:SaveTextFromLocalFile(self, "Pos_Name" .. i)
    MobileFileDataManager.Instance:SaveTextFromLocalFile(self, "MonterHp_Input" .. i)
  end
  MobileFileDataManager.Instance:SaveTextFromLocalFile(self, "RoleHp_Input")
  for i = 1, 8 do
    MobileFileDataManager.Instance:SaveTextFromLocalFile(self, "Relic_Name" .. i)
  end
  for i = 1, 4 do
    MobileFileDataManager.Instance:SaveTextFromLocalFile(self, "Weapon_Name" .. i)
  end
  for i = 1, 2 do
    MobileFileDataManager.Instance:SaveTextFromLocalFile(self, "Keeper_Name" .. i)
  end
  MobileFileDataManager.Instance:SaveTextFromLocalFile(self, "Text_Scene")
  MobileFileDataManager.Instance:SaveTextFromLocalFile(self, "Text_ShowInfo")
  MobileFileDataManager.Instance:SaveTextFromLocalFile(self, "Text_Battle")
  MobileFileDataManager.Instance:SaveTextFromLocalFile(self, "Text_Gender")
  MobileFileDataManager.Instance:SaveTextFromLocalFile(self, "Text_KeeperSkill")
  MobileFileDataManager.Instance:SaveTextFromLocalFile(self, "Text_PVPDir")
  MobileFileDataManager.Instance:OnSaveCommInfo()
end

function BattleDbgEntryPanel:RecoverLocalData()
end

function BattleDbgEntryPanel:OnClickAwaker(index)
  local list = {}
  table.insert(list, {id = 0, text = "清除"})
  for _, info in pairs(DT.AwakerConfig) do
    local schoolName = LT.Text(DT.SchoolConfig[info.School].Name)
    local title = LT.Text(info.Title)
    local name = LT.Text(info.Name)
    table.insert(list, {
      id = info.ID,
      text = string.format("%s-%s-%s-%s-%s", info.ID, schoolName, title or "", name, info.CnID),
      awakerTid = info.ID,
      skinSortId = 0
    })
  end
  for _, info in pairs(DT.AwakerSkin) do
    local awakerTid = info.OwnerAwaker
    if awakerTid and 0 ~= awakerTid then
      local awakerCfg = DT.AwakerConfig[awakerTid]
      local schoolName = LT.Text(DT.SchoolConfig[awakerCfg.School].Name)
      local title = LT.Text(awakerCfg.Title)
      local name = LT.Text(info.Name)
      table.insert(list, {
        id = info.ID,
        text = string.format("%s-%s-%s-%s-%s-%s", awakerTid, schoolName, title or "", name, info.CnID, info.Item),
        awakerTid = awakerTid,
        skinSortId = info.BaseSortID
      })
    end
  end
  table.sort(list, function(a, b)
    if 0 == a.id or 0 == b.id then
      return a.id < b.id
    end
    if a.awakerTid == b.awakerTid then
      return a.skinSortId < b.skinSortId
    end
    return a.awakerTid < b.awakerTid
  end)
  UIManager.Instance:Reopen(Urls.SimpleListView, list, function(data)
    UIManager.Instance:CloseByUrl(Urls.SimpleListView)
    if data.text ~= "清除" then
      self.binder:SetText(self.ui["Text_Input" .. index], data.text)
    else
      self.binder:SetText(self.ui["Text_Input" .. index], "")
    end
  end, true)
end

function BattleDbgEntryPanel:OnClickPVPDir()
  local list = {}
  table.insert(list, {id = 0, text = "1-正向"})
  table.insert(list, {id = 1, text = "2-反向"})
  UIManager.Instance:Reopen(Urls.SimpleListView, list, function(data)
    UIManager.Instance:CloseByUrl(Urls.SimpleListView)
    self.binder:SetText(self.ui.Text_PVPDir, data.text)
  end, true)
end

function BattleDbgEntryPanel:OnClickRelic(index)
  local list = {}
  table.insert(list, {id = 0, text = "清除"})
  for id, cfg in pairs(DT.RelicConfig) do
    table.insert(list, {
      id = id,
      text = id .. "-" .. LT.Text(cfg.Name)
    })
  end
  UIManager.Instance:Reopen(Urls.SimpleListView, list, function(data)
    UIManager.Instance:CloseByUrl(Urls.SimpleListView)
    if data.text ~= "清除" then
      self.binder:SetText(self.ui["Relic_Name" .. index], data.text)
    else
      self.binder:SetText(self.ui["Relic_Name" .. index], "")
    end
  end, true, "BattleDbgRelic")
end

function BattleDbgEntryPanel:OnClickMonster(index)
  local list = {}
  table.insert(list, {id = 0, text = "清除"})
  for _, info in pairs(DT.MonsterConfig) do
    table.insert(list, {
      id = info.ID,
      text = string.format([[
%s-%s
%s]], info.ID, LT.Text(info.MonsterName), info.CnID)
    })
  end
  UIManager.Instance:Reopen(Urls.SimpleListView, list, function(data)
    UIManager.Instance:CloseByUrl(Urls.SimpleListView)
    if data.text ~= "清除" then
      self.binder:SetText(self.ui["Monster_Name" .. index], data.text)
    else
      self.binder:SetText(self.ui["Monster_Name" .. index], "")
    end
  end, true, "BattleDbgMonster")
end

function BattleDbgEntryPanel:OnClickPos(index)
  local list = {}
  table.insert(list, {id = 0, text = "清除"})
  for idx = -15, 15 do
    table.insert(list, {id = idx, text = idx})
  end
  UIManager.Instance:Reopen(Urls.SimpleListView, list, function(data)
    UIManager.Instance:CloseByUrl(Urls.SimpleListView)
    if data.text ~= "清除" then
      self.binder:SetText(self.ui["Pos_Name" .. index], data.text)
    else
      self.binder:SetText(self.ui["Pos_Name" .. index], index)
    end
  end)
end

function BattleDbgEntryPanel:OnClickScene()
  local list = {
    {id = 0, text = "清除"}
  }
  for _, info in pairs(DT.BattleSceneConfig) do
    table.insert(list, {
      id = info.ID,
      text = info.ID .. "-" .. PathStrUtils.GetBaseName(info.BattleScene)
    })
  end
  UIManager.Instance:Reopen(Urls.SimpleListView, list, function(data)
    UIManager.Instance:CloseByUrl(Urls.SimpleListView)
    if data.text ~= "清除" then
      self.binder:SetText(self.ui.Text_Scene, data.text)
    else
      self.binder:SetText(self.ui.Text_Scene, "")
    end
  end, true, "BattleDbgScene")
end

function BattleDbgEntryPanel:OnClickGender()
  local list = {}
  for id, name in pairs(CommonDefine.GenderName) do
    if tonumber(id) then
      table.insert(list, {
        id = id,
        text = id .. "-" .. name
      })
    end
  end
  UIManager.Instance:Reopen(Urls.SimpleListView, list, function(data)
    UIManager.Instance:CloseByUrl(Urls.SimpleListView)
    self.binder:SetText(self.ui.Text_Gender, data.text)
  end, true)
end

function BattleDbgEntryPanel:OnClickKeeperInfo()
  ItemDataUtils.PredealItemConfig()
  local item2KeeperSkill = DataCenter.itemData.Item2KeeperSkill
  local list = {}
  for itemId in pairs(item2KeeperSkill) do
    local itemName = ItemDataUtils.GetItemName(itemId)
    table.insert(list, {
      id = itemId,
      text = itemId .. "-" .. itemName
    })
  end
  UIManager.Instance:Reopen(Urls.SimpleListView, list, function(data)
    UIManager.Instance:CloseByUrl(Urls.SimpleListView)
    self.binder:SetText(self.ui.Text_KeeperSkill, data.text)
  end)
end

function BattleDbgEntryPanel:OnClickShowInfo()
  local list = {
    {id = 1, text = "普通"},
    {id = 2, text = "美术"}
  }
  UIManager.Instance:Reopen(Urls.SimpleListView, list, function(data)
    UIManager.Instance:CloseByUrl(Urls.SimpleListView)
    self.binder:SetText(self.ui.Text_ShowInfo, data.text)
    bg.isDebugMode = 2 == data.id
  end)
end

function BattleDbgEntryPanel:OnClickBattle()
  local list = {
    {
      id = -1,
      text = "清除",
      sort = -1
    }
  }
  for _, battleCfg in pairs(DT.BattleConfig) do
    table.insert(list, {
      id = battleCfg.ID,
      text = battleCfg.ID .. "-" .. battleCfg.CnID,
      sort = battleCfg.BaseSortID
    })
  end
  table.sort(list, function(a, b)
    return a.sort < b.sort
  end)
  UIManager.Instance:Reopen(Urls.SimpleListView, list, function(data)
    UIManager.Instance:CloseByUrl(Urls.SimpleListView)
    if -1 == data.id then
      self.binder:SetText(self.ui.Text_Battle, "")
    else
      self.binder:SetText(self.ui.Text_Battle, data.text)
    end
  end, true, "BattleDbgBattle")
end

function BattleDbgEntryPanel:OnClickCancle()
  self:Close()
end

function BattleDbgEntryPanel:OnClickEnter()
  BattleManager.Instance:DisposeCurrentBattle()
  local Awakers = {}
  local Levels = {}
  local SkinTids = {}
  for index = 1, 4 do
    local str = self.binder:GetTextComp(self.ui["Text_Input" .. index]).text
    if "" ~= str then
      local subStrs = string.split(str, "-")
      local id = tonumber(subStrs[1])
      local skinTid = tonumber(subStrs[6])
      table.insert(Awakers, tonumber(id))
      table.insert(Levels, self.levels[index])
      table.insert(SkinTids, skinTid or 0)
    end
  end
  self.mockData.Awakers = Awakers
  self.mockData.Levels = Levels
  self.mockData.SkinTids = SkinTids
  local Relics = {}
  for index = 1, 8 do
    local id = self:GetId(self.ui["Relic_Name" .. index])
    if id then
      table.insert(Relics, id)
    end
  end
  if table.next(Relics) then
    self.mockData.Relics = Relics
  end
  local sceneStr = self.binder:GetTextComp(self.ui.Text_Scene).text
  self.mockData.BattleSceneID = nil
  if "" ~= sceneStr then
    local id = string.split(sceneStr, "-")[1]
    self.mockData.BattleSceneID = id or "99999"
  end
  local battleId = self:GetId(self.ui.Text_Battle)
  if battleId then
    self.mockData.BattleID = battleId
  end
  local coverMonsters = {}
  local usedPos = {}
  for index = 1, 5 do
    local monsterStr = self.binder:GetTextComp(self.ui["Monster_Name" .. index]).text
    local monsterPos = self.binder:GetTextComp(self.ui["Pos_Name" .. index]).text
    local monsterHpStr = self.binder:GetInputText(self.ui["MonterHp_Input" .. index])
    if "" ~= monsterStr then
      local id = string.split(monsterStr, "-")[1]
      local pos = tonumber(monsterPos) or index
      if usedPos[pos] then
        Alert.ShowStr("怪物位置重复")
        return
      end
      usedPos[pos] = true
      coverMonsters["Monster" .. index] = tonumber(id)
      coverMonsters["MonsterPoint" .. index] = pos
      if "" ~= monsterHpStr then
        local monsterHp = tonumber(monsterHpStr)
        if monsterHp then
          coverMonsters["MonsterHp" .. index] = monsterHp
        end
      end
    end
  end
  self.mockData.coverMonsters = coverMonsters
  local roleHpStr = self.binder:GetInputText(self.ui.RoleHp_Input)
  if "" ~= roleHpStr then
    local roleHp = tonumber(roleHpStr)
    if roleHp then
      self.mockData.roleHp = roleHp
    end
  end
  self.mockData.keeperSkill = self:GetId(self.ui.Text_KeeperSkill) or 567639
  self.mockData.pvpDir = self:GetId(self.ui.Text_PVPDir)
  self.mockData.gender = self:GetId(self.ui.Text_Gender)
  local mockWeaponList = {}
  for index = 1, 4 do
    local id = self:GetId(self.ui["Weapon_Name" .. index])
    if id then
      local awakerTid = self:GetId(self.ui["Text_Input" .. index])
      table.insert(mockWeaponList, {
        tid = id,
        level = 1,
        awakerTid = awakerTid
      })
    end
  end
  self.mockData.mockWeaponList = mockWeaponList
  self.binder:BindTimer(0.01, 0, nil, System.fn(self, self.Close))
  if self.isPVP then
    self.mockData.weaponList = mockWeaponList
    local pvpKeeper = {}
    for index = 1, 2 do
      local id = self:GetId(self.ui["Keeper_Name" .. index])
      if id then
        table.insert(pvpKeeper, {tid = id, level = 1})
      end
    end
    self.mockData.keeperSkillList = pvpKeeper
    BattleManager.Instance:EnterBattle(BattlePVPMockDataUtil.MockDataToBattleData(self.mockData))
  elseif SceneMgr.Instance:IsLoginScene() or 0 == DataCenter.playerData.DRole.uid then
    BattleManager.Instance:EnterBattle(BattlePVEMockDataUtil.MockDataToBattleData(self.mockData))
  else
    local mockData = BattlePVEMockDataUtil.MockDataToBattleData(self.mockData)
    ProtoManager.Instance:ReqServer("GmRequest", "OnGmCommand", function(data, code)
      print("gm_get_battledata", table.tostring(data))
      local battleData = table.deepclone(mockData)
      for k, v in pairs(data) do
        battleData[k] = v
      end
      BattleManager.Instance:EnterBattle(battleData)
    end, function(data, code)
    end, "gm_get_battledata", {
      stageTid = mockData.stageId,
      awakerTids = Awakers
    })
  end
  if self.clickCallback then
    self.clickCallback()
  end
end

function BattleDbgEntryPanel:GetText(owner)
  return self.binder:GetTextComp(owner).text
end

function BattleDbgEntryPanel:GetId(owner, splitStr)
  splitStr = splitStr or "-"
  local text = self.binder:GetTextComp(owner).text
  if "" == text then
    return
  end
  local arr = string.split(text or "", splitStr)
  for i, v in ipairs(arr) do
    arr[i] = tonumber(v) or v
  end
  do return table.unpack end
  return table.unpack, arr, ipairs(arr)
end

function BattleDbgEntryPanel:Close()
  Super.Close(self)
end

function BattleDbgEntryPanel:OnUnbind()
  Super.OnUnbind(self)
  self:SaveLocalFile()
end

function BattleDbgEntryPanel:OnClickPVPWeapon(index)
  local list = {}
  table.insert(list, {id = 0, text = "清除"})
  for id, cfg in pairs(DT.Item) do
    if cfg.Type == "Weapon" and cfg.PVPSkill then
      table.insert(list, {
        id = id,
        text = id .. "-" .. LT.Text(cfg.Name)
      })
    end
  end
  UIManager.Instance:Reopen(Urls.SimpleListView, list, function(data)
    UIManager.Instance:CloseByUrl(Urls.SimpleListView)
    if data.text ~= "清除" then
      self.binder:SetText(self.ui["Weapon_Name" .. index], data.text)
    else
      self.binder:SetText(self.ui["Weapon_Name" .. index], "")
    end
  end, true, "BattleDbgWeapon")
end

function BattleDbgEntryPanel:OnClickPVPKeeper(index)
  local list = {}
  table.insert(list, {id = 0, text = "清除"})
  for id, cfg in pairs(DT.Item) do
    if cfg.Type == "KeeperSkill" and cfg.PVPSkill then
      table.insert(list, {
        id = id,
        text = id .. "-" .. LT.Text(cfg.Name)
      })
    end
  end
  UIManager.Instance:Reopen(Urls.SimpleListView, list, function(data)
    UIManager.Instance:CloseByUrl(Urls.SimpleListView)
    if data.text ~= "清除" then
      self.binder:SetText(self.ui["Keeper_Name" .. index], data.text)
    else
      self.binder:SetText(self.ui["Keeper_Name" .. index], "")
    end
  end, true)
end

return BattleDbgEntryPanel
