local View = require("UIGroup_EnemyTalent/UIGroup_EnemyTalentView")
local DataModel = require("UIGroup_EnemyTalent/UIGroup_EnemyTalentDataModel")
local MainDataModel = require("UICubeRogueMain/UICubeRogueMainDataModel")
local Controller = {}

function Controller:InitSingularityInfo()
  local bossBuff = MainDataModel.GetBossBuff()
  local exLv = bossBuff.boss.lv
  local atk = 0
  local def = 0
  local hp = 0
  local energy = 0
  local damage = 0
  for k, v in pairs(bossBuff.boss.skills) do
    local skillCa = PlayerData:GetFactoryData(k)
    if skillCa == nil then
      logError("\233\148\153\232\175\175\231\154\132\230\138\128\232\131\189Id\239\188\154" .. k)
    elseif skillCa.id == 12303544 or skillCa.id == 12303545 then
      atk = atk + v * 10
    elseif skillCa.id == 12303547 then
      def = def + v * 10
    elseif skillCa.id == 12303549 then
      hp = hp + v * 10
    elseif skillCa.id == 12303548 then
      energy = energy + v * 10
    elseif skillCa.id == 12303550 then
      damage = damage + v * 10
    end
  end
  local bossCube = MainDataModel.rubikCube:GetCube(MainDataModel.bossCtrl.face, MainDataModel.bossCtrl.x, MainDataModel.bossCtrl.y)
  local bossItem = bossCube.item or {}
  local spNum = 0
  if bossItem[11400622] then
    spNum = bossItem[11400622].num or 0
  end
  DataModel.exLv = exLv
  DataModel.atk = atk
  DataModel.def = def
  DataModel.hp = hp
  DataModel.energy = energy
  DataModel.damage = damage
  DataModel.spNum = spNum
  local cubeTypeMap = {}
  cubeTypeMap[MainDataModel.Enum_CubeType.Boss] = MainDataModel.rubikCube:GetCubeTypeNum(MainDataModel.Enum_CubeType.Boss)
  cubeTypeMap[MainDataModel.Enum_CubeType.HardBattle] = MainDataModel.rubikCube:GetCubeTypeNum(MainDataModel.Enum_CubeType.HardBattle)
  cubeTypeMap[MainDataModel.Enum_CubeType.NormalBattle] = MainDataModel.rubikCube:GetCubeTypeNum(MainDataModel.Enum_CubeType.NormalBattle)
  cubeTypeMap[MainDataModel.Enum_CubeType.Shop] = MainDataModel.rubikCube:GetCubeTypeNum(MainDataModel.Enum_CubeType.Shop)
  cubeTypeMap[MainDataModel.Enum_CubeType.Recover] = MainDataModel.rubikCube:GetCubeTypeNum(MainDataModel.Enum_CubeType.Recover)
  cubeTypeMap[MainDataModel.Enum_CubeType.Reward] = MainDataModel.rubikCube:GetCubeTypeNum(MainDataModel.Enum_CubeType.Reward)
  cubeTypeMap[MainDataModel.Enum_CubeType.Event] = MainDataModel.rubikCube:GetCubeTypeNum(MainDataModel.Enum_CubeType.Event)
  DataModel.cubeTypeMap = cubeTypeMap
end

function Controller:RefreshSingularityInfo()
  View.Group_Left.Group_Singularity_Info.Group_Row_Attr_01.Txt_Attr_Val:SetText(DataModel.atk)
  View.Group_Left.Group_Singularity_Info.Group_Row_Attr_02.Txt_Attr_Val:SetText(DataModel.def)
  View.Group_Left.Group_Singularity_Info.Group_Row_Attr_03.Txt_Attr_Val:SetText(DataModel.hp)
  View.Group_Left.Group_Singularity_Info.Group_Row_Attr_04.Txt_Attr_Val:SetText(DataModel.energy)
  View.Group_Left.Group_Singularity_Info.Group_Row_Attr_05.Txt_Attr_Val:SetText(DataModel.exLv)
  View.Group_Left.Group_Singularity_Info.Group_Row_Attr_06.Txt_Attr_Val:SetText(DataModel.damage)
  View.Group_Left.Group_Singularity_Info.Group_Row_Attr_07.Txt_Attr_Val:SetText(DataModel.spNum)
end

function Controller:RefreshPanelInfo()
  View.Group_Left.Group_Plane_Info.Group_Row_Info_01.Txt_Attr_Val:SetText(DataModel.cubeTypeMap[MainDataModel.Enum_CubeType.Boss])
  View.Group_Left.Group_Plane_Info.Group_Row_Info_02.Txt_Attr_Val:SetText(DataModel.cubeTypeMap[MainDataModel.Enum_CubeType.HardBattle])
  View.Group_Left.Group_Plane_Info.Group_Row_Info_03.Txt_Attr_Val:SetText(DataModel.cubeTypeMap[MainDataModel.Enum_CubeType.NormalBattle])
  View.Group_Left.Group_Plane_Info.Group_Row_Info_04.Txt_Attr_Val:SetText(DataModel.cubeTypeMap[MainDataModel.Enum_CubeType.Shop])
  View.Group_Left.Group_Plane_Info.Group_Row_Info_05.Txt_Attr_Val:SetText(DataModel.cubeTypeMap[MainDataModel.Enum_CubeType.Recover])
  View.Group_Left.Group_Plane_Info.Group_Row_Info_06.Txt_Attr_Val:SetText(DataModel.cubeTypeMap[MainDataModel.Enum_CubeType.Reward])
  View.Group_Left.Group_Plane_Info.Group_Row_Info_07.Txt_Attr_Val:SetText(DataModel.cubeTypeMap[MainDataModel.Enum_CubeType.Event])
end

function Controller:RefreshTalent()
  Controller:InitEventNum()
  local bossSkills = PlayerData.TempCache.CubeRogueData.boss_skills
  local itemSkills = PlayerData.TempCache.CubeRogueData.item_skills
  local itemCnt = PlayerData.TempCache.CubeRogueData.face_item_cnt
  local pCA = PlayerData:GetFactoryData(PlayerData.TempCache.CubeRogueData.cube_id)
  for i = 1, #bossSkills do
    local group = View.Group_Right.ScrollView_Group_Talent.Viewport.Content.Group_Plane["Group_Talent_Row" .. i]
    local skillCa = PlayerData:GetFactoryData(bossSkills[i])
    if skillCa == nil then
      group:SetActive(false)
      logError("\233\148\153\232\175\175\231\154\132\230\138\128\232\131\189Id\239\188\154" .. bossSkills[i])
    else
      group:SetActive(true)
      group.Group_Know:SetActive(i > #bossSkills - DataModel.spEventNum)
      group.Group_Unknow:SetActive(i <= #bossSkills - DataModel.spEventNum)
      if i > #bossSkills - DataModel.spEventNum then
        group.Group_Know.Txt_Effect:SetText(skillCa.description)
        group.Group_Know.Group_Name.Txt_Name:SetText(skillCa.name)
        group.Group_Know.Group_Name.Group_Battle_Tags.Group_Battle_Tag_02:SetActive(i <= pCA.elitePlaneNum)
        group.Group_Know.Group_Name.Group_Battle_Tags.Group_Battle_Tag_03:SetActive(i <= pCA.eliteMuseNum)
        local colorInt = self:GetColorInt(skillCa.rarityColor)
        group.Group_Know.Txt_Lv:SetText(colorInt)
        group.Group_Know.Group_Know_Bg.Group_Know_Plane_R:SetActive(colorInt == 1)
        group.Group_Know.Group_Know_Bg.Group_Know_Plane_SR:SetActive(colorInt == 2)
        group.Group_Know.Group_Know_Bg.Group_Know_Plane_SSR:SetActive(colorInt == 3)
        group.Group_Know.Group_Know_Bg.Group_Know_Inspiration_R:SetActive(false)
        group.Group_Know.Group_Know_Bg.Group_Know_Inspiration_SR:SetActive(false)
        group.Group_Know.Group_Know_Bg.Group_Know_Inspiration_SSR:SetActive(false)
      else
        group.Group_Unknow.Group_Unknow_01:SetActive(false)
        group.Group_Unknow.Group_Unknow_02:SetActive(i == #bossSkills - DataModel.spEventNum)
        group.Group_Unknow.Group_Unknow_03:SetActive(i ~= #bossSkills - DataModel.spEventNum)
      end
    end
  end
  for i = #bossSkills + 1, 5 do
    local group = View.Group_Right.ScrollView_Group_Talent.Viewport.Content.Group_Plane["Group_Talent_Row" .. i]
    group:SetActive(false)
  end
  for i = 1, #itemSkills do
    local group = View.Group_Right.ScrollView_Group_Talent.Viewport.Content.Group_Inspiration["Group_Talent_Row" .. i]
    local skillCa = PlayerData:GetFactoryData(itemSkills[i])
    if skillCa == nil then
      group:SetActive(false)
      logError("\233\148\153\232\175\175\231\154\132\230\138\128\232\131\189Id\239\188\154" .. itemSkills[i])
    else
      group:SetActive(true)
      group.Group_Know:SetActive(i > #itemSkills - DataModel.spEventNum - DataModel.normalEventNum)
      group.Group_Unknow:SetActive(i <= #itemSkills - DataModel.spEventNum - DataModel.normalEventNum)
      if i > #itemSkills - DataModel.spEventNum - DataModel.normalEventNum then
        group.Group_Know.Txt_Effect:SetText(skillCa.description)
        group.Group_Know.Group_Name.Txt_Name:SetText(skillCa.name)
        group.Group_Know.Group_Name.Group_Battle_Tags.Group_Battle_Tag_02:SetActive(i <= pCA.ordinaryPlaneNum)
        group.Group_Know.Group_Name.Group_Battle_Tags.Group_Battle_Tag_03:SetActive(i <= pCA.ordinaryMuseNum)
        local colorInt = self:GetColorInt(skillCa.rarityColor)
        group.Group_Know.Txt_Lv:SetText(colorInt)
        group.Group_Know.Group_Know_Bg.Group_Know_Plane_R:SetActive(false)
        group.Group_Know.Group_Know_Bg.Group_Know_Plane_SR:SetActive(false)
        group.Group_Know.Group_Know_Bg.Group_Know_Plane_SSR:SetActive(false)
        group.Group_Know.Group_Know_Bg.Group_Know_Inspiration_R:SetActive(colorInt == 1)
        group.Group_Know.Group_Know_Bg.Group_Know_Inspiration_SR:SetActive(colorInt == 2)
        group.Group_Know.Group_Know_Bg.Group_Know_Inspiration_SSR:SetActive(colorInt == 3)
      else
        group.Group_Unknow.Group_Unknow_01:SetActive(i == #itemSkills - DataModel.spEventNum - DataModel.normalEventNum)
        group.Group_Unknow.Group_Unknow_02:SetActive(false)
        group.Group_Unknow.Group_Unknow_03:SetActive(i ~= #itemSkills - DataModel.spEventNum - DataModel.normalEventNum)
      end
      group.Group_Remove:SetActive(i <= itemCnt)
    end
  end
  for i = #itemSkills + 1, 5 do
    local group = View.Group_Right.ScrollView_Group_Talent.Viewport.Content.Group_Inspiration["Group_Talent_Row" .. i]
    group:SetActive(false)
  end
end

function Controller:GetColorInt(color)
  if color == "White" then
    return 0
  elseif color == "Blue" then
    return 1
  elseif color == "Purple" then
    return 2
  elseif color == "Golden" then
    return 3
  elseif color == "Grange" then
    return 4
  end
end

function Controller:InitEventNum()
  local spEventNum = 0
  local normalEventNum = 0
  local faceEvents = PlayerData.TempCache.CubeRogueData.face_events
  for k, v in pairs(faceEvents) do
    local eventCA = PlayerData:GetFactoryData(k)
    if eventCA.typeId == 12601542 then
      spEventNum = spEventNum + v
    elseif eventCA.typeId == 12601540 then
      normalEventNum = normalEventNum + v
    end
  end
  DataModel.spEventNum = spEventNum
  DataModel.normalEventNum = normalEventNum
end

return Controller
