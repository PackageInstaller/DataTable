local View
local DataModel = {
  RoleId = nil,
  RoleData = {},
  RoleCA = {},
  Type = 0,
  IsGoback = false,
  IsBook = false,
  BookRoleData = nil,
  live2D = false,
  selectedPosX = {
    [1] = -300,
    [2] = 0,
    [3] = 300
  }
}

function DataModel:SetUIScript(viewStr)
  View = require(viewStr)
end

function DataModel:Clear()
  if DataModel.InstantiateList then
    for k, v in pairs(DataModel.InstantiateList) do
      Object.Destroy(v)
      v = nil
    end
  end
end

local function SwitchSpeed(tSpeed)
  if tSpeed <= 80 then
    return 80600232
  elseif tSpeed <= 120 then
    return 80600233
  elseif tSpeed <= 200 then
    return 80600234
  elseif tSpeed <= 275 then
    return 80600235
  else
    return 80600236
  end
end

local function SwitchSpeedRange(line)
  local line_config = {
    [0] = 80600228,
    [1] = 80600229,
    [2] = 80600230,
    [3] = 80600231
  }
  return line_config[line] or line
end

DataModel.InfoInitPos = {
  isRecord = true,
  x = 0,
  y = 0,
  scale = 1,
  offsetX = 0,
  offsetY = 1
}

local function SetMissingConfig(isSpine2, portrailData)
  local Group_CharacterSkin = View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content
  Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetActive(false)
  Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetActive(false)
  if isSpine2 == true then
    Group_CharacterSkin.Group_Character2.self:SetActive(true)
    Group_CharacterSkin.Group_Character2.Img_Character2:SetSprite(portrailData.State2Res)
  else
    Group_CharacterSkin.Group_Character.self:SetActive(true)
    Group_CharacterSkin.Group_Character.Img_Character:SetSprite(portrailData.resUrl)
  end
  Group_CharacterSkin.Group_Character.Img_Character:SetNativeSize()
  Group_CharacterSkin.Group_Character2.Img_Character2:SetNativeSize()
  DataModel.InfoInitPos.isRecord = true
  if DataModel.InfoInitPos.isRecord then
    DataModel.InfoInitPos.isRecord = false
    local transform = Group_CharacterSkin.transform
    DataModel.InfoInitPos.y = transform.localPosition.y
    DataModel.InfoInitPos.scale = transform.localScale.x
  end
  DataModel.InfoInitPos.offsetX = portrailData.offsetX
  DataModel.InfoInitPos.offsetY = portrailData.offsetY
end

local isSpine2

function DataModel:CharacterLoad(self, isSkin2, callback)
  if isSpine2 ~= nil and isSkin2 ~= nil and isSpine2 == isSkin2 then
    return
  end
  local portraitId = DataModel.RoleCA.skinList[1].unitViewId
  local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
  local live2D = DataModel.live2D
  isSpine2 = false
  print_r(portrailData)
  if isSkin2 and isSkin2 == true then
    if portrailData.spine2Url == nil or portrailData.spine2Url == "" then
      CommonTips.OpenTips(80601926)
      return
    end
    isSpine2 = true
  end
  if View.Btn_Close ~= nil then
    View.Btn_Close:SetActive(isSpine2)
  end
  DataModel.isSpine2 = isSpine2
  if callback then
    callback()
  end
  local Group_CharacterSkin = View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content
  Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetActive(false)
  Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetActive(false)
  Group_CharacterSkin.Group_Character.self:SetActive(false)
  Group_CharacterSkin.Group_Character2.self:SetActive(false)
  Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetLocalScale(Vector3(1, 1, 1))
  if Group_CharacterSkin.Group_Spine.Spine_Head == nil then
    local spineUrl = portrailData.spineUrl
    if spineUrl ~= nil and spineUrl ~= "" then
      Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetActive(true)
      Group_CharacterSkin.Group_Spine.SpineAnimation_Fade:SetActive(true)
      Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetActive(not isSpine2)
      Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetActive(isSpine2)
      if live2D == false then
        SetMissingConfig(isSpine2, portrailData)
      elseif isSpine2 then
        spineUrl = portrailData.spine2Url
        Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetPrefab(spineUrl)
        Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetData("")
        Group_CharacterSkin.Group_Spine.SpineSecondMode_Character.transform.localPosition = Vector3(0, 0, 0)
        if portrailData.state2Overturn == true then
          Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetLocalScale(Vector3(-1, 1, 1))
        end
      else
        Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetActive(false)
        Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetPrefab("")
        Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetActive(true)
        Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetData(spineUrl)
        Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetLocalScale(Vector3(100, 100, 1))
        Group_CharacterSkin.Group_Spine.SpineAnimation_Character.transform.localPosition = Vector3(-400 + portrailData.spineX, -1200 + portrailData.spineY, 0)
      end
    else
      SetMissingConfig(isSpine2, portrailData)
      View.Group_Information.Img_Live2dBg:SetActive(false)
      View.Group_Information.Txt_Live2D:SetActive(false)
    end
  else
    Group_CharacterSkin.Group_Spine.Spine_Head:SetData(portrailData.spineUrl, "idle")
    Group_CharacterSkin.Group_Spine.Spine_Head:SetActive(true)
  end
  if View.Group_Mask ~= nil then
    View.Group_Mask.self:SetActive(isSpine2)
  end
  if DataModel.InfoInitPos.isRecord == false then
    local pos = DataModel.InfoInitPos
    local posX = pos.x + portrailData.offsetX * pos.scale
    local posY = pos.y + portrailData.offsetY * pos.scale
    if isSpine2 == true then
      posX = pos.x + portrailData.offsetX2 * pos.scale
      posY = pos.y + portrailData.offsetY2 * pos.scale
    end
    Group_CharacterSkin.Group_Character.Img_Character:SetLocalPosition(Vector3(-400 + portrailData.offsetX, portrailData.offsetY, 0))
    Group_CharacterSkin.Group_Character2.Img_Character2:SetLocalPosition(Vector3(0, portrailData.offsetY2, 0))
    Group_CharacterSkin.Group_Character.Img_Character:SetLocalScale(Vector3(portrailData.offsetScale, portrailData.offsetScale, portrailData.offsetScale))
    DataModel.Spine2PosX = posX + DataModel.InfoInitPos.x
  end
  DataModel.NowSkin = {}
  DataModel.NowSkin.portraitId = tonumber(portraitId)
  DataModel.NowSkin.isSpine2 = isSpine2 == true and 1 or 0
end

function DataModel:ClickLive2D(state)
  local Img_Live2dBg = View.Group_Information.Img_Live2dBg
  DataModel.live2D = not DataModel.live2D
  local state_n = 0
  if DataModel.live2D == false then
    state_n = 1
  end
  PlayerData:SetPlayerPrefs("int", DataModel.RoleId .. "live2d", state_n)
  if DataModel.live2D ~= state then
    DataModel.CharacterLoad(self, DataModel.isSpine2)
  end
  if DataModel.live2D == true then
    DOTweenTools.DOLocalMoveXCallback(Img_Live2dBg.Img_On.transform, 24, 0.25, function()
      Img_Live2dBg:SetSprite("UI/CharacterInfo/Skin/onbg")
    end)
  else
    DOTweenTools.DOLocalMoveXCallback(Img_Live2dBg.Img_On.transform, -24, 0.25, function()
      Img_Live2dBg:SetSprite("UI/CharacterInfo/Skin/offbg")
    end)
  end
end

function DataModel:MoveSpine2Live2D(type)
  View.Group_CharacterSkin.ScrollView_Skin.self.ScrollRect.enabled = false
  local posX = DataModel.Spine2PosX
  if type == 1 then
    posX = 0
  end
  if DataModel.live2D then
    DOTweenTools.DOLocalMoveXCallback(View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Character2.Img_Character2.transform, posX, 0.25, function()
    end)
  end
end

function DataModel:Reset()
  View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.transform.localScale = Vector3(1, 1, 1)
  View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Character.transform.localScale = Vector3(1, 1, 1)
  View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.self:SetLocalPosition(Vector3(0, 0, 0))
  View.Group_CharacterSkin.ScrollView_Skin.self.ScrollRect.enabled = false
end

function DataModel:SetRole(roleId, lv, awake_lv, resonance_lv, skillPath, resonancePath, awakePath, equipList)
  if lv == nil then
    lv = 1
  end
  if awake_lv == nil then
    awake_lv = 0
  end
  if resonance_lv == nil then
    resonance_lv = 0
  end
  if skillPath == nil then
    skillPath = "UI/CharacterInfo/Group_Skill"
  end
  if resonancePath == nil then
    resonancePath = "UI/CharacterInfo/Group_Resonance"
  end
  if awakePath == nil then
    awakePath = "UI/CharacterInfo/Group_Awake"
  end
  if equipList == nil then
    equipList = {}
  end
  DataModel.RoleData = {}
  DataModel.RoleCA = PlayerData:GetFactoryData(roleId, "UnitFactory")
  DataModel.RoleData.equips = {}
  DataModel.RoleData.equips[1] = {}
  DataModel.RoleData.equips[2] = {}
  DataModel.RoleData.equips[3] = {}
  DataModel.RoleData.skills = {}
  DataModel.RoleData.lv = lv
  DataModel.RoleData.awake_lv = awake_lv
  DataModel.RoleData.resonance_lv = resonance_lv
  DataModel.RoleData.trust_lv = 1
  DataModel.RoleData.current_skin = {}
  DataModel.RoleData.current_skin[1] = DataModel.RoleCA.viewId
  DataModel.InstantiateList = {}
  DataModel.SkillList = {}
  local SkillList = {}
  SkillList = PlayerData:GetCardDes(roleId, 1)
  for k, v in pairs(SkillList) do
    v.ExSkillList = PlayerData:GetFactoryData(v.id).ExSkillList
    table.insert(DataModel.SkillList, {
      id = v.id,
      des = v.des,
      isEx = false,
      num = DataModel.RoleCA.skillList[k].num
    })
    for c, d in pairs(v.ExSkillList) do
      local skill = DataManager:GetCardDes(d.ExSkillName)
      local skillList = Json.decode(skill)
      d.description = skillList.des
      d.ca = skill
      table.insert(DataModel.SkillList, {
        id = d.ExSkillName,
        des = d.description,
        ca = skill,
        isEx = true
      })
    end
  end
  DataModel:SetEquips(equipList)
  DataModel:InfoLoad()
  DataModel:CharacterLoad()
  DataModel.Top_Right_List = {
    [1] = {
      name = GetText(80603395),
      element = "",
      obj = skillPath
    },
    [2] = {
      name = GetText(80603397),
      element = "",
      obj = resonancePath
    },
    [3] = {
      name = GetText(80603400),
      element = "",
      obj = awakePath
    }
  }
  DataModel:RightInfoLoad()
end

function DataModel:InfoLoad()
  local Group_Information = View.Group_Information
  Group_Information.Group_Top.Txt_CharacterName:SetText(DataModel.RoleCA.name)
  Group_Information.Txt_EnglishName:SetText(DataModel.RoleCA.EnglishName)
  if Group_Information.Img_Rare ~= nil then
    Group_Information.Img_Rare:SetSprite(UIConfig.WeaponQuality[DataModel.RoleCA.qualityInt])
  end
  if Group_Information.Txt_Color ~= nil then
    Group_Information.Txt_Color:SetText(UIConfig.ColorText[DataModel.RoleCA.qualityInt])
    Group_Information.Txt_Color:SetColor(UIConfig.RandomBattleQualityColor[DataModel.RoleCA.qualityInt - 1])
  end
  if Group_Information.Group_Career ~= nil and Group_Information.Group_Career.Img_1 ~= nil then
    local careerCA = PlayerData:GetFactoryData(DataModel.RoleCA.careerList[1].des)
    Group_Information.Group_Career.Img_1:SetActive(careerCA.tagID == 0)
    Group_Information.Group_Career.Img_2:SetActive(careerCA.tagID == 1)
    Group_Information.Group_Career.Img_3:SetActive(careerCA.tagID == 2)
    Group_Information.Group_Career.Img_4:SetActive(careerCA.tagID == 3)
  end
  Group_Information.Group_Station.Img_Line:SetSprite(UIConfig.CharacterLine[DataModel.RoleCA.line])
  if Group_Information.Group_Station.Txt_Station ~= nil then
    local lineCA = PlayerData:GetFactoryData(99900017).enumJobList
    if DataModel.RoleCA.line == 1 or DataModel.RoleCA.line == 0 then
      Group_Information.Group_Station.Txt_Station:SetText(PlayerData:GetFactoryData(lineCA[1].tagId).tagName)
    end
    if DataModel.RoleCA.line == 2 then
      Group_Information.Group_Station.Txt_Station:SetText(PlayerData:GetFactoryData(lineCA[2].tagId).tagName)
    end
    if DataModel.RoleCA.line == 3 then
      Group_Information.Group_Station.Txt_Station:SetText(PlayerData:GetFactoryData(lineCA[3].tagId).tagName)
    end
  end
  DataModel.RoleAttributeCurrent = {}
  local temp_data = {}
  local RoleData = DataModel.RoleData
  temp_data.tHp, temp_data.tDef, temp_data.tAtk, temp_data.tCri, temp_data.tCriDamage, temp_data.tSpeed, temp_data.tBlock, temp_data.tBlockRate, temp_data.tPDamageUp, temp_data.tMDamageUp, temp_data.tFReduce, temp_data.tGetPDamageDown, temp_data.tGetMDamageDown, temp_data.tGetFDamageDown, temp_data.tGetHealUp, temp_data.tGetShieldUp, temp_data.tSummonAtkUp, temp_data.tSummonFinalDamageUp = PlayerData:CountRoleAttributeById(DataModel.RoleId, RoleData.skills[1] and RoleData.skills[1].lv or 1, RoleData.skills[2] and RoleData.skills[2].lv or 1, RoleData.skills[2] and RoleData.skills[2].lv or 1, RoleData.lv or 1, RoleData.awake_lv or 1, RoleData.resonance_lv or 1, RoleData.trust_lv or 1, true)
  for k, v in pairs(PlayerData.AttributeConfig) do
    local row = {}
    DataModel.RoleAttributeCurrent[k] = row
    row.name = v.txt
    if temp_data[v.type] then
      row.num = temp_data[v.type] + 1.0E-7 or 0
      row.num = PlayerData:GetPreciseDecimalFloor(row.num, 2)
      if v.type == "tSpeed" then
        row.num = GetText(SwitchSpeed(temp_data[v.type]))
      end
    else
      if v.type == "tSpeedRange" then
        row.num = GetText(SwitchSpeedRange(DataModel.RoleCA.line))
      end
      if v.type == "tSpName" then
        row.num = DataModel.RoleCA.specialGiftDes
      end
    end
    row.sprite = v.sprite
  end
  Group_Information.Img_Atk.Txt_Text.Txt_Atk:SetText((PlayerData:GetPreciseDecimalFloor(DataModel.RoleAttributeCurrent[1].num, 0)))
  Group_Information.Img_Hp.Txt_Text.Txt_Hp:SetText((PlayerData:GetPreciseDecimalFloor(DataModel.RoleAttributeCurrent[2].num, 0)))
  Group_Information.Img_Def.Txt_Text.Txt_Def:SetText((PlayerData:GetPreciseDecimalFloor(DataModel.RoleAttributeCurrent[3].num, 0)))
  local tagCA = PlayerData:GetFactoryData(DataModel.RoleCA.sideId, "TagFactory")
  Group_Information.Group_Camp.Img_Icon:SetSprite(tagCA.icon)
  local lineCA = PlayerData:GetFactoryData(99900017).enumJobList
  if Group_Information.Group_Station.Txt_Station ~= nil then
    if DataModel.RoleCA.line == 1 or DataModel.RoleCA.line == 0 then
      Group_Information.Group_Station.Txt_Station:SetText(PlayerData:GetFactoryData(lineCA[1].tagId).tagName)
    end
    if DataModel.RoleCA.line == 2 then
      Group_Information.Group_Station.Txt_Station:SetText(PlayerData:GetFactoryData(lineCA[2].tagId).tagName)
    end
    if DataModel.RoleCA.line == 3 then
      Group_Information.Group_Station.Txt_Station:SetText(PlayerData:GetFactoryData(lineCA[3].tagId).tagName)
    end
  end
  Group_Information.Group_Station.Img_Line:SetSprite(UIConfig.CharacterLine[DataModel.RoleCA.line])
  if View.Group_Information.Btn_Button ~= nil then
    View.Group_Information.Btn_Button.self:SetActive(true)
    View.Group_Information.Txt_Live2D:SetActive(true)
    View.Group_Information.Img_Live2dBg:SetActive(true)
    if DataModel.BookRoleData and DataModel.BookRoleData.isGet == false then
      View.Group_Information.Btn_Button.self:SetActive(false)
      View.Group_Information.Txt_Live2D:SetActive(false)
      View.Group_Information.Img_Live2dBg:SetActive(false)
    end
  end
end

local baseDesHight = 60
local baseBGHight = 166
local baseBGWidth = 916
local baseContentHight = 980

local function SetLeftRoleDown(obj, row)
  obj.transform:Find("Txt_Name").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.name)
  obj.transform:Find("Txt_Num").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.num)
end

local function SetRightRoleSkill(obj, row)
  local skillCA = PlayerData:GetFactoryData(row.id)
  local costNum = PlayerData:GetFactoryData(skillCA.cardID).cost_SN or 0
  obj.transform:Find("Group_2").transform:GetComponent(typeof(CS.Seven.UIGroup)):SetActive(false)
  obj.transform:Find("Group_1").transform:GetComponent(typeof(CS.Seven.UIGroup)):SetActive(false)
  obj.transform:Find("Img_SkillIconBg/Img_SkillIcon").transform:GetComponent(typeof(CS.Seven.UIImg)):SetSprite(skillCA.iconPath)
  if row.isEx == true then
    obj.transform:Find("Group_2").transform:GetComponent(typeof(CS.Seven.UIGroup)):SetActive(true)
    obj.transform:Find("Group_2/Txt_Name").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(skillCA.name)
    obj.transform:Find("Group_2/Txt_Num").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(math.ceil(costNum))
  else
    obj.transform:Find("Group_1").transform:GetComponent(typeof(CS.Seven.UIGroup)):SetActive(true)
    obj.transform:Find("Group_1/Txt_Name").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(skillCA.name)
    if obj.transform:Find("Group_1/Txt_T") ~= nil then
      obj.transform:Find("Group_1/Txt_Num2").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.num)
    else
      obj.transform:Find("Group_1/Txt_Num2").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(GetText(80603660) .. row.num)
    end
    obj.transform:Find("Group_1/Txt_Num").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(math.ceil(costNum))
  end
  obj.transform:Find("Txt_SkillDetail").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.des)
  local hight_des = obj.transform:Find("Txt_SkillDetail").transform:GetComponent(typeof(CS.Seven.UITxt)):GetHeight()
  local Hight = 0
  obj.transform:Find("Img_SkillBg").transform:GetComponent(typeof(CS.Seven.UIImg)):SetImgWidthAndHeight(baseBGWidth, baseBGHight)
  if hight_des > baseDesHight then
    Hight = hight_des - baseDesHight
    obj.transform:Find("Img_SkillBg").transform:GetComponent(typeof(CS.Seven.UIImg)):SetImgWidthAndHeight(baseBGWidth, Hight + baseBGHight)
  end
  return Hight
end

local function SetRightRoleTalent(obj, row, index)
  obj.transform:Find("Txt_Name").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.name)
  obj.transform:Find("Txt_ResonanceDetail").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.desc)
  local hight_des = obj.transform:Find("Txt_ResonanceDetail").transform:GetComponent(typeof(CS.Seven.UITxt)):GetHeight()
  local Hight = 0
  obj.transform:Find("Img_ResonanceBg").transform:GetComponent(typeof(CS.Seven.UIImg)):SetImgWidthAndHeight(baseBGWidth, baseBGHight)
  if hight_des > baseDesHight then
    Hight = hight_des - baseDesHight
    obj.transform:Find("Img_ResonanceBg").transform:GetComponent(typeof(CS.Seven.UIImg)):SetImgWidthAndHeight(baseBGWidth, Hight + baseBGHight)
  end
  if obj.transform:Find("Img_ResonanceStage/Txt_Num") ~= nil then
    obj.transform:Find("Img_ResonanceStage/Txt_Num").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(index)
  else
    obj.transform:Find("Img_ResonanceStage/Txt_ResonanceStage").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(string.format(GetText(80601186), index))
  end
  obj.transform:Find("Group_1").transform:GetComponent(typeof(CS.Seven.UIGroup)):SetActive(false)
  obj.transform:Find("Group_5").transform:GetComponent(typeof(CS.Seven.UIGroup)):SetActive(false)
  if index == 5 then
    obj.transform:Find("Group_5").transform:GetComponent(typeof(CS.Seven.UIGroup)):SetActive(true)
    obj.transform:Find("Group_5/Img_SkillIcon").transform:GetComponent(typeof(CS.Seven.UIImg)):SetSprite(row.path)
  else
    obj.transform:Find("Group_1").transform:GetComponent(typeof(CS.Seven.UIGroup)):SetActive(true)
    obj.transform:Find("Group_1/Img_SkillIcon").transform:GetComponent(typeof(CS.Seven.UIImg)):SetSprite(row.path)
  end
  return Hight
end

local function SetRightRoleBreak(obj, row, index)
  obj.transform:Find("Txt_Name").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.name)
  obj.transform:Find("Txt_AwakeDetail").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.desc)
  local hight_des = obj.transform:Find("Txt_AwakeDetail").transform:GetComponent(typeof(CS.Seven.UITxt)):GetHeight()
  local Hight = 0
  if hight_des > baseDesHight then
    Hight = hight_des - baseDesHight
    obj.transform:Find("Img_AwakeBg").transform:GetComponent(typeof(CS.Seven.UIImg)):SetImgWidthAndHeight(baseBGWidth, Hight + baseBGHight)
  end
  if obj.transform:Find("Img_AwakeStage/Txt_Num") ~= nil then
    obj.transform:Find("Img_AwakeStage/Txt_Num").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(index - 1)
  else
    obj.transform:Find("Img_AwakeStage/Txt_AwakeStage").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(string.format(GetText(80601187), index - 1))
  end
  obj.transform:Find("Group_Icon/Img_AwakeIcon").transform:GetComponent(typeof(CS.Seven.UIImg)):SetSprite(row.path)
  return Hight
end

local offest_height = 0
local skillBg_base = 160
local spaceRight = 0
local isSetScrollViewHeight = true

function DataModel:SetSpaceRight(val)
  spaceRight = val
end

function DataModel:SetIsSetHeight(val)
  isSetScrollViewHeight = val
end

local function RefreshRightData(index)
  local hight = 0
  local lastPosY = 90
  View.ScrollView_Right.Viewport.Content.self:SetLocalPositionY(0)
  local parent = View.ScrollView_Right.Viewport.Content.transform
  local Show_Obj = DataModel.Top_Right_List[index].obj
  if DataModel.ChooseList and 0 < table.count(DataModel.ChooseList) then
    for i = 1, table.count(DataModel.ChooseList) do
      if index == 3 and i == table.count(DataModel.ChooseList) then
        break
      end
      local obj = View.self:GetRes(Show_Obj, parent.transform)
      obj:SetActive(true)
      obj.name = obj.name .. "_" .. i
      local group = obj.transform:GetComponent(typeof(CS.Seven.UIGroup))
      local ObjHight = obj.transform.sizeDelta.y + offest_height
      group:SetAnchoredPositionY(-lastPosY)
      local hight_des = 0
      if index == 1 then
        hight_des = SetRightRoleSkill(obj, DataModel.ChooseList[i], i)
      end
      if index == 2 then
        local talentCA = PlayerData:GetFactoryData(DataModel.ChooseList[i].talentId)
        hight_des = SetRightRoleTalent(obj, talentCA, i)
      end
      if index == 3 and i < table.count(DataModel.ChooseList) then
        local breakthroughCA = PlayerData:GetFactoryData(DataModel.ChooseList[i + 1].breakthroughId)
        hight_des = SetRightRoleBreak(obj, breakthroughCA, i + 1)
      end
      hight_des = 30 < hight_des and hight_des - 7 or hight_des
      lastPosY = lastPosY + ObjHight + hight_des + spaceRight
      hight = hight + ObjHight + hight_des + spaceRight
      table.insert(DataModel.InstantiateList, obj)
    end
  end
  local skillIntensifyTitle = View.ScrollView_Right.Viewport.Content.transform:Find("Group_SkillTitle")
  if skillIntensifyTitle then
    local titleGroup = skillIntensifyTitle:GetComponent(typeof(CS.Seven.UIGroup))
    titleGroup:SetActive(index == 2)
    if index == 2 then
      titleGroup.Rect.pivot = Vector2(0.5, 1)
      titleGroup:SetAnchoredPositionY(-hight)
      hight = hight + titleGroup.Rect.sizeDelta.y
      for i, info in ipairs(DataModel.RoleCA.talentList) do
        local talentCA = PlayerData:GetFactoryData(info.talentId, "TalentFactory")
        if 0 < talentCA.skillIntensify then
          local obj = View.self:GetRes("UI/CharacterInfo/Group_SkillUpdate", parent.transform)
          local group = obj.transform:GetComponent(typeof(CS.Seven.UIGroup))
          group.Rect.pivot = Vector2(0.5, 1)
          hight = hight + 7
          group:SetAnchoredPositionY(-hight)
          hight = hight + group.Rect.sizeDelta.y
          local skillCA = PlayerData:GetFactoryData(talentCA.skillIntensify, "SkillFactory")
          local nameTxt = obj.transform:Find("Group_Title/Txt_Name"):GetComponent(typeof(CS.Seven.UITxt))
          nameTxt:SetText(skillCA.name)
          local iconImg = obj.transform:Find("Img_SkillIconBg/Img_SkillIcon"):GetComponent(typeof(CS.Seven.UIImg))
          iconImg:SetSprite(skillCA.iconPath)
          local desTxt = obj.transform:Find("Txt_SkillDetail"):GetComponent(typeof(CS.Seven.UITxt))
          desTxt:SetText(string.format(skillCA.description, skillCA.digitSN))
          table.insert(DataModel.InstantiateList, obj)
        end
      end
    end
  end
  hight = hight > baseContentHight and hight + 350 or hight
  View.ScrollView_Right:SetContentHeight(hight)
end

function DataModel:ClickRightTop(index)
  if index and DataModel.RightTopIndex == index then
    return
  end
  local posX = DataModel.selectedPosX
  local duration = 0.25
  if DataModel.RightTopIndex and (DataModel.RightTopIndex == 1 and index == 3 or DataModel.RightTopIndex == 3 and index == 1) then
    duration = 0.35
  end
  DOTweenTools.DOLocalMoveXCallback(View.Img_PageBg.Img_selected.transform, posX[index], duration, function()
    if DataModel.RightTopIndex then
      local obj = View.Img_PageBg["Btn_" .. DataModel.RightTopIndex]
      obj.Group_On.self:SetActive(false)
      obj.Group_Off.self:SetActive(true)
    end
    local obj = View.Img_PageBg["Btn_" .. index]
    obj.Group_On.self:SetActive(true)
    obj.Group_Off.self:SetActive(false)
    DataModel.ChooseList = {}
    if index == 1 then
      DataModel.ChooseList = DataModel.SkillList
    end
    if index == 2 then
      DataModel.ChooseList = DataModel.RoleCA.talentList
    end
    if index == 3 then
      DataModel.ChooseList = DataModel.RoleCA.breakthroughList
    end
    DataModel:Clear()
    RefreshRightData(index)
    DataModel.RightTopIndex = index
  end)
end

function DataModel:RightInfoLoad()
  DataModel.RightTopIndex = nil
  for i = 1, 3 do
    local obj = View.Img_PageBg["Btn_" .. i]
    obj.Group_On.self:SetActive(false)
    obj.Group_Off.self:SetActive(true)
  end
  if View.Img_PageBg.StaticGrid_Top ~= nil then
    View.Img_PageBg.StaticGrid_Top.self:SetActive(false)
  end
  if isSetScrollViewHeight then
    View.ScrollView_Right.self:SetHeight(GameSetting.screenHeightOrigin * 0.865)
  end
  DataModel:ClickRightTop(1)
end

function DataModel:SetEquips(equipList)
  for i = 1, #equipList do
    local eCA = PlayerData:GetFactoryData(equipList[i].id)
    local tag = PlayerData:GetFactoryData(eCA.equipTagId)
    DataModel.RoleData.equips[tag.typeID] = equipList[i]
  end
  if View.Group_Information.Group_Equipment ~= nil then
    View.Group_Information.Group_Equipment.StaticGrid_Equipment.grid.self:SetDataCount(#DataModel.RoleData.equips)
    View.Group_Information.Group_Equipment.StaticGrid_Equipment.grid.self:RefreshAllElement()
  end
end

function DataModel:OnSetEquipGrid(element, elementIndex)
  local equipData = DataModel.RoleData.equips[elementIndex]
  element.Group_Empty.self:SetActive(true)
  element.Group_Have.self:SetActive(false)
  if next(equipData) ~= nil then
    element.Group_Empty.self:SetActive(false)
    element.Group_Have.self:SetActive(true)
    local equipId = equipData.id
    local equipCA = PlayerData:GetFactoryData(equipId)
    local typeCA = PlayerData:GetFactoryData(equipCA.equipTagId)
    element.Group_Have.Group_Type.Img_1:SetActive(typeCA.typeID == 1)
    element.Group_Have.Group_Type.Img_2:SetActive(typeCA.typeID == 2)
    element.Group_Have.Group_Type.Img_3:SetActive(typeCA.typeID == 3)
    element.Group_Have.Group_Color.Img_R:SetActive(equipCA.qualityInt == 1)
    element.Group_Have.Group_Color.Img_SR:SetActive(equipCA.qualityInt == 2)
    element.Group_Have.Group_Color.Img_SSR:SetActive(equipCA.qualityInt == 3)
    element.Group_Have.Group_Color.Img_UR:SetActive(equipCA.qualityInt == 4)
    element.Group_Have.Img_Item:SetSprite(equipCA.iconPath)
    element.Group_Have.Txt_EquipmentLevel:SetText(string.format(GetText(80600474), equipData.lv))
    element.Group_Have.Btn_Item:SetClickParam(elementIndex)
  end
end

function DataModel:SetSelectPos(newPos)
  for i = 1, #newPos do
    DataModel.selectedPosX[i] = newPos[i]
  end
end

function DataModel:SetSize(desHight, bgHight, bgWidth, contentHeight)
  baseDesHight = desHight
  baseBGHight = bgHight
  baseBGWidth = bgWidth
  baseContentHight = contentHeight
end

return DataModel
