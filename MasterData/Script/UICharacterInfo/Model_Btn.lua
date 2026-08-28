local View = require("UICharacterInfo/UICharacterInfoView")
local BackgroundLoader = require("UICharacterInfo/ViewBackground")
local InfoLoader = require("UICharacterInfo/ViewInfo")
local AwakeLoader = require("UICharacterInfo/ViewAwake")
local BreakThroughLoader = require("UICharacterInfo/ViewBreakThrough")
local TalentLoader = require("UICharacterInfo/ViewTalent")
local ResonanceLoader = require("UICharacterInfo/ViewResonanceNew")
local DataModel = require("UICharacterInfo/DataModel")
local NullLoader = {
  Load = function(self)
  end
}
local Btn_TableMap = {}
local Table_LoaderMap = {}
local currentBtn

local function InitParam()
  currentBtn = nil
  Table_LoaderMap = {
    [View.Group_Middle] = BackgroundLoader,
    [View.Group_TabInfo] = InfoLoader,
    [View.Group_TabAwake] = AwakeLoader,
    [View.Group_TabBreakThrough] = BreakThroughLoader,
    [View.Group_SkillTree] = ResonanceLoader,
    [View.Group_TabTalent] = TalentLoader
  }
  Btn_TableMap = {
    [View.Group_TopRight.Btn_TabInfo] = View.Group_TabInfo,
    [View.Group_TopRight.Btn_TabAwake] = View.Group_TabAwake,
    [View.Group_TopRight.Btn_TabBreakThrough] = View.Group_TabBreakThrough,
    [View.Group_TopRight.Btn_TabResonance] = View.Group_SkillTree,
    [View.Group_TopRight.Btn_TabTalent] = View.Group_TabTalent
  }
end

local BtnController = {
  Reset = function(self)
    InitParam()
    for key, value in pairs(Btn_TableMap) do
      key.Img_N:SetActive(true)
      key.Img_P:SetActive(false)
      value.self:SetActive(false)
    end
  end,
  Click = function(self, newBtn)
    if currentBtn ~= nil then
      currentBtn.Img_P:SetActive(false)
      currentBtn.Img_N:SetActive(true)
      Btn_TableMap[currentBtn].self:SetActive(false)
    end
    currentBtn = newBtn
    currentBtn.Img_P:SetActive(true)
    currentBtn.Img_N:SetActive(false)
    Btn_TableMap[currentBtn].self:SetActive(true)
  end
}

function BtnController:SetSkillList()
  DataModel.SkillList = {}
  DataModel.SkillList = PlayerData:GetCardDes(DataModel.RoleId)
  for k, v in pairs(DataModel.SkillList) do
    local skillCA = PlayerData:GetFactoryData(v.id)
    v.ExSkillList = skillCA.ExSkillList
    v.detailDescription = skillCA.detailDescription
    for c, d in pairs(v.ExSkillList) do
      local skill = DataManager:GetCardDes(d.ExSkillName)
      local skillList = Json.decode(skill)
      d.description = skillList.des
      d.ca = skill
    end
  end
end

local function SetRole(roleId)
  if DataModel.RoleId == roleId then
    return
  end
  DataModel.RoleId = roleId
  DataModel.RoleData = PlayerData:GetRoleById(roleId)
  DataModel.RoleData.portrait_id = DataModel.RoleData.current_skin[1]
  BtnController:SetSkillList()
  DataModel.RoleCA = PlayerData:GetFactoryData(roleId, "UnitFactory")
  local server = PlayerData:GetRoleById(DataModel.RoleId)
  DataModel.roleTrustLv = server.trust_lv or 1
  DataModel.roleTrustLvExp = server.trust_exp or 0
  local trustCfg = PlayerData:GetFactoryData(99900039)
  DataModel.trustExpList = trustCfg.trustExpList
  DataModel:SetRoleAttributeCurrent()
end

function BtnController.InitSortRoles(param)
  local data = {}
  local roleId = param.currentRoleId
  if DataModel.isWeaponRoleId then
    roleId = DataModel.isWeaponRoleId
  end
  SetRole(tonumber(roleId))
  View.Group_Middle.SpineAnimation_Character:SetLocalPositionX(DataModel.InfoInitPos.x - 100)
  DataModel.SpinePosX = View.Group_Middle.SpineAnimation_Character.transform.position.x
  View.Group_Middle.Group_Character.self:SetLocalPositionX(DataModel.InfoInitPos.x)
  DataModel.ImgCharacterPosX = View.Group_Middle.Group_Character.transform.position.x
  if param.fromView ~= nil and param.fromView == EnumDefine.CommonFilterType.SquadView then
    data = param.roleList
  else
    local sortType = param.sortType
    for k in pairs(PlayerData.ServerData.roles) do
      table.insert(data, k)
    end
    if table.count(sortType.pluckList) == 0 then
      sortType.pluckList = {
        "lv",
        "qualityInt",
        "awake_lv",
        "resonance_lv",
        "obtain_time",
        "id"
      }
    end
    data = PlayerData:SortRole(data, sortType.pluckList, sortType.isIncr)
    DataModel.QueueData.Count = #data
    for k, v in pairs(data) do
      if v == roleId then
        DataModel.QueueData.CurrentIndex = k
        break
      end
    end
  end
  DataModel.Roles = data
end

function BtnController.NextRole(isNext)
  local index = DataModel.QueueData.CurrentIndex
  local count = DataModel.QueueData.Count
  index = index + (isNext and 1 or -1)
  if count < index then
    index = 1
  elseif index == 0 then
    index = count
  end
  SetRole(tonumber(DataModel.Roles[index]))
  DataModel.QueueData.CurrentIndex = index
  BackgroundLoader:Load()
end

function BtnController.GetPortraitPos(isSpine2)
  local portrailData = PlayerData:GetFactoryData(DataModel.RoleData.current_skin[1], "UnitViewFactory")
  local pos = Vector3(-275 + portrailData.offsetX, portrailData.offsetY, 0)
  if portrailData.videoSpine then
    pos = Vector3(portrailData.videoX, portrailData.videoY, 0)
  elseif isSpine2 then
    if portrailData.moveBoolen then
      pos = Vector3(-275 + portrailData.offsetX + portrailData.offsetX2, portrailData.offsetY + portrailData.offsetY2, 0)
    else
      pos = Vector3(portrailData.offsetX2, portrailData.offsetY2, 0)
    end
  elseif portrailData.moveBoolen then
    pos = Vector3(-275 + portrailData.offsetX + portrailData.offsetX2, portrailData.offsetY + portrailData.offsetY2, 0)
  end
  View.Group_Middle.Group_Pos.transform.localPosition = pos
  return View.Group_Middle.Group_Pos.transform.localPosition.x
end

function BtnController.GetSpinePortraitPos(isSpine2)
  local portrailData = PlayerData:GetFactoryData(DataModel.RoleData.current_skin[1], "UnitViewFactory")
  local pos = Vector3(-275 + portrailData.spineX, -1200 + portrailData.spineY, 0)
  if portrailData.videoSpine then
    pos = Vector3(portrailData.videoX, portrailData.videoY, 0)
  elseif isSpine2 then
    if portrailData.moveBoolen then
      pos = Vector3(-275 + portrailData.spineX + portrailData.spine2X, -1200 + portrailData.spineY + portrailData.spine2Y, 0)
    else
      pos = Vector3(portrailData.spine2X, portrailData.spine2Y, 0)
    end
  elseif portrailData.moveBoolen then
    pos = Vector3(-275 + portrailData.spineX + portrailData.spine2X, -1200 + portrailData.spineY + portrailData.spine2Y, 0)
  end
  View.Group_Middle.Group_Pos.transform.localPosition = pos
  return View.Group_Middle.Group_Pos.transform.localPosition.x
end

function BtnController.RefreshSetRole(roleId)
  SetRole(tonumber(roleId))
end

return BtnController
