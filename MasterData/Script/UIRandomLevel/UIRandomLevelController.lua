local View = require("UIRandomLevel/UIRandomLevelView")
local DataModel = require("UIRandomLevel/UIRandomLevelDataModel")
local StartBattle = require("UISquads/View_StartBattle")
local autoBattleVF = require("UIAutoBattle/UIAutoBattleViewFunction")
local Controller = {}

function Controller:Init(data)
  PlayerData.BattleInfo.UrEquipData = nil
  View.Group_CommonTopLeft.self:SetActive(true)
  DataModel.rbData = data
  if DataModel.rbData.rb_id == nil or DataModel.rbData.rb_id == "" then
    Controller:OnClickReturn()
    return
  end
  DataModel.randBattleCA = PlayerData:GetFactoryData(DataModel.rbData.rb_id or 89000001)
  local configCA = PlayerData:GetFactoryData(99900113)
  DataModel.rbConfigCA = configCA
  local group_item = View.Group_CommomBottomLeft.Group_Items
  local coinCA = PlayerData:GetFactoryData(configCA.randomBattleCoinId)
  group_item.Img_Icon:SetSprite(coinCA.iconPath)
  local coinNum = math.min(PlayerData:GetGoodsById(coinCA.id).num, 9999)
  group_item.Txt_Num:SetText(string.format("%04d", coinNum))
  if next(DataModel.rbData.choice) then
    local roleList = {}
    DataModel.headerIndex = 1
    for k, v in pairs(DataModel.rbData.choice) do
      roleList[#roleList + 1] = Controller:GetRoleData(k, v)
      if v.header ~= nil then
        DataModel.headerIndex = #roleList
      end
    end
    local roleList1 = {}
    for i = 1, #roleList do
      roleList1[#roleList1 + 1] = tonumber(roleList[i].unitId)
    end
    autoBattleVF.SetTeamData("RandomBattle", roleList1, roleList1[DataModel.headerIndex])
    DataModel.roleList = roleList
    View.Group_Team.self:SetActive(true)
    View.Group_Level.self:SetActive(true)
    View.Group_LevelDetails.self:SetActive(true)
    View.Img_MaskStart:SetActive(true)
    View.Group_Team.StaticGrid_Team.grid.self:SetDataCount(#DataModel.roleList)
    View.Group_Team.StaticGrid_Team.grid.self:RefreshAllElement()
    local passCount = 0
    for i = 1, #DataModel.rbData.pre_levels do
      Controller:SetLevelGrid(View.Group_Level.ScrollView_Level.Viewport.Content["Group_Level" .. i], i)
      if i ~= #DataModel.rbData.pre_levels and DataModel.rbData.pre_levels[i].reward == 0 and DataModel.rbData.pre_levels[i].status == 1 then
        Controller:OpenRewardChoose(i)
      end
      if DataModel.rbData.pre_levels[i].status == 1 then
        passCount = passCount + 1
      end
    end
    local initLevelIndex = math.min(passCount, #DataModel.rbData.pre_levels)
    local levelWidth = View.Group_Level.ScrollView_Level.Viewport.Content.Group_Level1.Rect.rect.width
    local levelSpace = View.Group_Level.ScrollView_Level.Viewport.Content.Group_Level2.Rect.anchoredPosition.x - View.Group_Level.ScrollView_Level.Viewport.Content.Group_Level1.Rect.anchoredPosition.x - levelWidth
    local viewPortWidth = View.Group_Level.ScrollView_Level.Viewport.Rect.rect.width
    local initContentPos = viewPortWidth / 2 - View.Group_Level.ScrollView_Level.Viewport.Content.Group_Level1.Rect.anchoredPosition.x - (levelWidth + levelSpace) * initLevelIndex
    initContentPos = math.min(0, initContentPos)
    initContentPos = math.max(viewPortWidth - View.Group_Level.ScrollView_Level.Viewport.Content.Rect.rect.width, initContentPos)
    View.Group_Level.ScrollView_Level.Viewport.Content.transform.localPosition = Vector3(initContentPos, 0, 0)
    if DataModel.rbData.fail_cnt >= configCA.randomBattleLose or passCount == #DataModel.rbData.pre_levels then
      local rewardCount = DataModel.randBattleCA.rewardFinish[passCount + 1].num
      if rewardCount > table.count(DataModel.rbData.reward) then
        Controller:OpenRewardFinish(passCount)
      end
    end
    View.Group_Level.Group_Hp.StaticGrid_Hp.grid.self:SetDataCount(configCA.randomBattleLose)
    View.Group_Level.Group_Hp.StaticGrid_Hp.grid.self:RefreshAllElement()
    View.Group_Level.Group_Progress.Txt_Progress:SetText(passCount .. "/" .. #DataModel.rbData.pre_levels)
    DataModel.passCount = passCount
  else
    View.Group_Team.self:SetActive(false)
    View.Group_Level.self:SetActive(false)
    View.Img_MaskStart:SetActive(false)
    Controller:OpenChoosePanel()
  end
end

function Controller:OnSetHPGrid(element, elementIndex)
  local failIndex = DataModel.rbConfigCA.randomBattleLose - DataModel.rbData.fail_cnt
  element.Img_Off:SetActive(elementIndex > failIndex)
  element.Img_On:SetActive(elementIndex <= failIndex)
end

function Controller:OpenChoosePanel()
  View.Group_CommonTopLeft.self:SetActive(false)
  UIManager:Open("UI/Activity/ActivityRandomBattle/InitChoose", Json.encode(DataModel.rbData))
end

function Controller:SetLevelGrid(element, elementIndex)
  element.Btn_Level:SetClickParam(elementIndex)
  element.Btn_Level.Group_UnLock:SetActive(not Controller:IsLevelUnlock(elementIndex))
  element.Btn_Level.Group_Current:SetActive(Controller:IsLevelUnlock(elementIndex) and DataModel.rbData.pre_levels[elementIndex].status ~= 1)
  element.Btn_Level.Group_Finish:SetActive(Controller:IsLevelUnlock(elementIndex) and DataModel.rbData.pre_levels[elementIndex].status == 1)
  element.Btn_Level.Group_UnLock.Txt_Index:SetText(string.format("%02d", elementIndex))
  element.Btn_Level.Group_Current.Txt_Index:SetText(string.format("%02d", elementIndex))
  element.Btn_Level.Group_Finish.Txt_Index:SetText(string.format("%02d", elementIndex))
end

function Controller:IsLevelUnlock(index)
  if index == 1 then
    return true
  end
  return DataModel.rbData.pre_levels[index - 1].status ~= 0
end

function Controller:OnClickReturn()
  UIManager:GoBack()
  if DataModel.backToActivity then
    UIManager:Open("UI/Activity/ActivityMain", Json.encode({id = 86000037}))
  end
end

function Controller:OnClickLevel()
  local index = DataModel.passCount + 1
  if not Controller:IsLevelUnlock(index) then
    return
  end
  local configCA = DataModel.rbConfigCA
  if DataModel.rbData.fail_cnt >= configCA.randomBattleLose then
    Controller:OnClickReturn()
    return
  end
  if index > #DataModel.rbData.pre_levels then
    return
  end
  Controller:StartBattle(index)
end

function Controller:StartBattle(index)
  local header = DataModel.roleList[DataModel.headerIndex]
  DataModel.roleList[DataModel.headerIndex] = DataModel.roleList[1]
  DataModel.roleList[1] = header
  local roleList1 = {}
  for i = 1, #DataModel.roleList do
    roleList1[#roleList1 + 1] = tonumber(DataModel.roleList[i].unitId)
  end
  autoBattleVF.SetTeamData("RandomBattle", roleList1, roleList1[1])
  local levelId = DataModel.rbData.pre_levels[index].level
  PlayerData.Last_Chapter_Parms = {isBattleBack = true}
  PlayerData.TempCache.EventIndex = nil
  PlayerData.BattleInfo.battleStageId = levelId
  PlayerData.BattleCallBackPage = "UI/Activity/ActivityRandomBattle/RandomLevel"
  PlayerData.BattleInfo.rbFailTime = DataModel.rbData.fail_cnt
  PlayerData.BattleInfo.TeamKey = "RandomBattle"
  StartBattle:StartRandomBattle(levelId, DataModel.roleList, 1, index - 1)
end

function Controller:SetRoleGrid(element, elementIndex)
  local roleData = DataModel.roleList[elementIndex]
  local roleCA = PlayerData:GetFactoryData(roleData.unitId)
  element.Txt_Name:SetText(roleCA.name)
  element.Txt_Lv:SetText(roleData.lv)
  local viewCA = PlayerData:GetFactoryData(roleCA.viewId)
  element.Img_Head:SetSprite(viewCA.face)
  element.Img_Captain:SetActive(DataModel.headerIndex == elementIndex)
  element.Btn_Click:SetClickParam(elementIndex)
end

function Controller:GetRoleData(roleId, roleData)
  if next(roleData) == nil then
    return {}
  end
  local roleInfo = {}
  local roleCA = PlayerData:GetFactoryData(roleId)
  local tempData = DataModel.randBattleCA.initRoleList[1]
  roleInfo.unitId = roleId
  roleInfo.unitViewId = roleCA.viewId
  roleInfo.lv = tempData.lv
  roleInfo.breakthroughLv = 0
  local awakeLv = tempData["break"]
  roleInfo.awakeLv = awakeLv
  local resonanceLv = tempData.awake
  roleInfo.resonanceLv = resonanceLv
  roleInfo.resonanceStage = 0
  roleInfo.trustLv = 0
  roleInfo.skill1Lv = 1
  roleInfo.skill2Lv = 1
  roleInfo.skill3Lv = 1
  local lv = DataModel.randBattleCA.initEquipList[1].lv
  local equipList = {}
  for k, v in pairs(roleData.eid) do
    equipList[#equipList + 1] = {
      id = k,
      random_affix = v or {},
      lv = lv
    }
  end
  roleInfo.equipList = equipList
  local equip1 = equipList[1] or {}
  local e1Id = tonumber(equip1.id) or -1
  local e1CA = PlayerData:GetFactoryData(e1Id)
  local e1s1Id = -1
  if e1CA ~= nil and 0 < #e1CA.skillList then
    e1s1Id = e1CA.skillList[1].skillId
  end
  roleInfo.equip1Id = e1Id
  roleInfo.equip1Lv = lv
  roleInfo.e1s1Id = e1s1Id
  roleInfo.e1s1NumSN = -2
  equip1.random_affix["0"] = {id = e1s1Id, value = -2}
  local e1SkillDic = equip1.random_affix or {}
  roleInfo.e1s2Id = e1SkillDic["1"] and e1SkillDic["1"].id or -1
  roleInfo.e1s2NumSN = e1SkillDic["1"] and -1 < e1SkillDic["1"].value and e1SkillDic["1"].value * 10000 or 0
  roleInfo.e1s3Id = e1SkillDic["2"] and e1SkillDic["2"].id or -1
  roleInfo.e1s3NumSN = e1SkillDic["2"] and -1 < e1SkillDic["2"].value and e1SkillDic["2"].value * 10000 or 0
  roleInfo.e1s4Id = e1SkillDic["3"] and e1SkillDic["3"].id or -1
  roleInfo.e1s4NumSN = e1SkillDic["3"] and -1 < e1SkillDic["3"].value and e1SkillDic["3"].value * 10000 or 0
  roleInfo.e1s5Id = e1SkillDic["4"] and e1SkillDic["4"].id or -1
  roleInfo.e1s5NumSN = e1SkillDic["4"] and -1 < e1SkillDic["4"].value and e1SkillDic["4"].value * 10000 or 0
  roleInfo.e1s6Id = e1SkillDic["5"] and e1SkillDic["5"].id or -1
  roleInfo.e1s6NumSN = e1SkillDic["5"] and -1 < e1SkillDic["5"].value and e1SkillDic["5"].value * 10000 or 0
  local equip2 = equipList[2] or {}
  local e2Id = tonumber(equip2.id) or -1
  local e2CA = PlayerData:GetFactoryData(e2Id)
  local e2s1Id = -1
  if e2CA ~= nil and 0 < #e2CA.skillList then
    e2s1Id = e2CA.skillList[1].skillId
  end
  roleInfo.equip2Id = e2Id
  roleInfo.equip2Lv = lv
  roleInfo.e2s1Id = e2s1Id
  roleInfo.e2s1NumSN = -2
  local e2SkillDic = equip2.random_affix or {}
  roleInfo.e2s2Id = e2SkillDic["1"] and e2SkillDic["1"].id or -1
  roleInfo.e2s2NumSN = e2SkillDic["1"] and -1 < e2SkillDic["1"].value and e2SkillDic["1"].value * 10000 or 0
  roleInfo.e2s3Id = e2SkillDic["2"] and e2SkillDic["2"].id or -1
  roleInfo.e2s3NumSN = e2SkillDic["2"] and -1 < e2SkillDic["2"].value and e2SkillDic["2"].value * 10000 or 0
  roleInfo.e2s4Id = e2SkillDic["3"] and e2SkillDic["3"].id or -1
  roleInfo.e2s4NumSN = e2SkillDic["3"] and -1 < e2SkillDic["3"].value and e2SkillDic["3"].value * 10000 or 0
  roleInfo.e2s5Id = e2SkillDic["4"] and e2SkillDic["4"].id or -1
  roleInfo.e2s5NumSN = e2SkillDic["4"] and -1 < e2SkillDic["4"].value and e2SkillDic["4"].value * 10000 or 0
  roleInfo.e2s6Id = e2SkillDic["5"] and e2SkillDic["5"].id or -1
  roleInfo.e2s6NumSN = e2SkillDic["5"] and -1 < e2SkillDic["5"].value and e2SkillDic["5"].value * 10000 or 0
  local equip3 = equipList[3] or {}
  local e3Id = tonumber(equip3.id) or -1
  local e3CA = PlayerData:GetFactoryData(e3Id)
  local e3s1Id = -1
  if e3CA ~= nil and 0 < #e3CA.skillList then
    e3s1Id = e3CA.skillList[1].skillId
  end
  roleInfo.equip3Id = e3Id
  roleInfo.equip3Lv = lv
  roleInfo.e3s1Id = e3s1Id
  roleInfo.e3s1NumSN = -2
  local e3SkillDic = equip3.random_affix or {}
  roleInfo.e3s2Id = e3SkillDic["1"] and e3SkillDic["1"].id or -1
  roleInfo.e3s2NumSN = e3SkillDic["1"] and -1 < e3SkillDic["1"].value and e3SkillDic["1"].value * 10000 or 0
  roleInfo.e3s3Id = e3SkillDic["2"] and e3SkillDic["2"].id or -1
  roleInfo.e3s3NumSN = e3SkillDic["2"] and -1 < e3SkillDic["2"].value and e3SkillDic["2"].value * 10000 or 0
  roleInfo.e3s4Id = e3SkillDic["3"] and e3SkillDic["3"].id or -1
  roleInfo.e3s4NumSN = e3SkillDic["3"] and -1 < e3SkillDic["3"].value and e3SkillDic["3"].value * 10000 or 0
  roleInfo.e3s5Id = e3SkillDic["4"] and e3SkillDic["4"].id or -1
  roleInfo.e3s5NumSN = e3SkillDic["4"] and -1 < e3SkillDic["4"].value and e3SkillDic["4"].value * 10000 or 0
  roleInfo.e3s6Id = e3SkillDic["5"] and e3SkillDic["5"].id or -1
  roleInfo.e3s6NumSN = e3SkillDic["5"] and -1 < e3SkillDic["5"].value and e3SkillDic["5"].value * 10000 or 0
  roleInfo.cardNum1 = -1
  roleInfo.cardNum2 = -1
  return roleInfo
end

function Controller:OpenRewardChoose(index)
  View.Group_CommonTopLeft.self:SetActive(false)
  View.Group_Level.self:SetActive(false)
  View.Img_MaskStart:SetActive(false)
  UIManager:Open("UI/Activity/ActivityRandomBattle/RewardChoose", Json.encode({
    index = index,
    melee = DataModel.rbData
  }))
end

function Controller:OpenRewardFinish(passCount)
  View.Group_CommonTopLeft.self:SetActive(false)
  View.Group_Team.self:SetActive(false)
  View.Group_Level.self:SetActive(false)
  View.Group_LevelDetails.self:SetActive(false)
  UIManager:Open("UI/Activity/ActivityRandomBattle/RewardFinish", Json.encode({
    passCount = passCount,
    reward = DataModel.rbData.reward,
    rb_id = DataModel.rbData.rb_id,
    isWin = DataModel.rbData.fail_cnt < DataModel.rbConfigCA.randomBattleLose
  }))
end

function Controller:OnClickBtnAuto()
  local roleList = DataModel.roleList
  local aiRoleList = {}
  local usableRoles = {}
  for i = 1, #roleList do
    aiRoleList[#aiRoleList + 1] = tonumber(roleList[i].unitId)
    usableRoles[tostring(roleList[i].unitId)] = true
  end
  UIManager:Open("UI/Battle/AutoBattle/New/AutoBattle", Json.encode({
    teamKey = "RandomBattle",
    roleList = aiRoleList,
    header = aiRoleList[DataModel.headerIndex],
    usableRoles = usableRoles
  }))
end

function Controller:OnClickRole(str)
  local params = {}
  local idx = tonumber(str)
  local roleData = DataModel.roleList[idx]
  params.id = roleData.unitId
  params.lv = roleData.lv
  params.awakeLv = roleData.awakeLv
  params.resonanceLv = roleData.resonanceLv
  params.equipList = roleData.equipList
  View.Group_CommonTopLeft.self:SetActive(false)
  View.Group_Level.self:SetActive(false)
  View.Img_MaskStart:SetActive(false)
  CommonTips.OpenRandomBattleUnitDetail(params, function()
    View.Group_CommonTopLeft.self:SetActive(true)
    View.Group_Level.self:SetActive(true)
    View.Img_MaskStart:SetActive(true)
  end)
end

function Controller:OnBtnGiveUp()
  CommonTips.OnPrompt(GetText(80610075), "80600068", "80600067", function()
    Net:SendProto("battle.abandon", function(json)
      DataModel.rbData.fail_cnt = DataModel.rbConfigCA.randomBattleLose
      Controller:Init(DataModel.rbData)
    end)
  end)
end

return Controller
