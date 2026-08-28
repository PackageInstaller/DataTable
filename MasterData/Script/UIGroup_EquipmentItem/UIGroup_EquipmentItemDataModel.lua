local DataModel = {}
local View = require("UIGroup_EquipmentItem/UIGroup_EquipmentItemView")

function DataModel:SetUIScript(viewStr)
  View = require(viewStr)
end

local function Clear()
  if DataModel.AffixList then
    for k, v in pairs(DataModel.AffixList) do
      Object.Destroy(v)
    end
  end
end

function DataModel:Clear()
  Clear()
end

local baseDesHight = 24

local function SetDownAffix(obj, row, index)
  obj.transform:Find("Txt_Entry_1").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.descriptionShow)
  if row.isTxt then
    obj.transform:Find("Img_").transform:GetComponent(typeof(CS.Seven.UIImg)):SetColor(UIConfig.Color.Orange)
  else
    obj.transform:Find("Img_").transform:GetComponent(typeof(CS.Seven.UIImg)):SetColor(UIConfig.EntryColor[row.rarityColor])
  end
  local hight_des = obj.transform:Find("Txt_Entry_1").transform:GetComponent(typeof(CS.Seven.UITxt)):GetHeight()
  local Hight = 0
  if hight_des > baseDesHight then
    Hight = hight_des - baseDesHight
  end
  return Hight
end

local function SetDownAllAffix(Content, AffixList)
  local lastY = 0
  local img_desc_y = 70
  local top_des_height = img_desc_y
  local lastY_1 = -20
  local lastY_1_Bg = 0
  local count = 1
  local baseViewSpace = 320
  local space = 0
  Content.self:SetLocalPositionY(0)
  local Parent = Content.transform
  local Group_Entry = "UI/CharacterInfo/weapon/WeaponItemWindow/Group_Entry"
  Content.Group_Des:SetActive(false)
  space = top_des_height
  DataModel.AffixList = {}
  local random_affix = AffixList
  local affix_list = {}
  local now_affix_num = 0
  if random_affix ~= nil then
    for k, v in pairs(random_affix) do
      local row = v
      row.index = k
      table.insert(affix_list, row)
    end
    now_affix_num = table.count(random_affix)
  end
  table.sort(affix_list, function(a, b)
    return a.index < b.index
  end)
  local max_affix_num = DataModel.Max_Affix_Num
  local streng_lv = DataModel.params.server.lv
  local LevelNum = DataModel.EquipFactory.LevelNum
  local unLock_num = math.modf(streng_lv / LevelNum)
  local residue_affix_num
  if max_affix_num > unLock_num then
    residue_affix_num = unLock_num - now_affix_num
  else
    residue_affix_num = max_affix_num - now_affix_num
  end
  local isFirst = false
  print_r(DataModel.params.server)
  print_r(AffixList)
  print_r(affix_list)
  print_r("----------------")
  if 0 < table.count(affix_list) then
    for i = 1, table.count(affix_list) do
      local talentCA = {}
      if affix_list[i].id then
        talentCA = PlayerData:GetFactoryData(affix_list[i].id)
        if affix_list[i].value > -1 then
          talentCA.descriptionShow = string.format(talentCA.description, PlayerData:GetPreciseDecimalFloor(tonumber(affix_list[i].value * talentCA.CommonNum), talentCA.floatNum))
        else
          talentCA.descriptionShow = talentCA.description
        end
      else
        talentCA.descriptionShow = affix_list[i].txt
        talentCA.isTxt = true
      end
      local obj = View.self:GetRes(Group_Entry, Parent.transform)
      local name = obj.name
      local hight = obj.transform.sizeDelta.y
      local lastPosY = obj.transform.localPosition.y
      local lastPosX = obj.transform.localPosition.x
      local offest = 0
      hight = 47
      if count ~= 1 then
        lastY = lastY - hight + offest - lastY_1_Bg
      else
        lastY = lastY_1
      end
      obj.name = name .. "_" .. count
      obj.transform.localPosition = Vector3(lastPosX, lastY, 0)
      obj:SetActive(true)
      table.insert(DataModel.AffixList, obj)
      local hight_des = SetDownAffix(obj, talentCA, count)
      lastY_1_Bg = hight_des
      space = space + hight_des + hight
      count = count + 1
      if baseViewSpace < space then
        View.ScrollView_Content:SetContentHeight(space)
      end
    end
    if DataModel.equipCA.des ~= "" then
      Content.Group_Des:SetActive(true)
      Content.Group_Des.Txt_EquipmentDetail:SetText(DataModel.equipCA.des)
      local desHeight = Content.Group_Des.Txt_EquipmentDetail:GetHeight()
      local lastPosY = Content.Group_Des.transform.localPosition.y
      local lastPosX = Content.Group_Des.transform.localPosition.x
      Content.Group_Des.transform.localPosition = Vector3(lastPosX, -space, 0)
      if baseViewSpace < space + desHeight then
        View.ScrollView_Content:SetContentHeight(space + desHeight)
      end
    end
  end
end

function DataModel:RefreshRightDownContent(Group)
  local max = DataModel.Max_Affix_Num
  local ScrollView_Content = View.ScrollView_Content
  if DataModel.params.server.random_affix == nil then
    ScrollView_Content.self:SetActive(false)
    return
  end
  ScrollView_Content.self:SetActive(true)
  ScrollView_Content.Viewport.Content.Txt_EntryNumber:SetText(string.format(GetText(80600501), table.count(DataModel.params.server.random_affix), max))
  SetDownAllAffix(ScrollView_Content.Viewport.Content, DataModel.params.server.random_affix)
end

function DataModel:RefreshRightContent()
  DataModel.IsMax = false
  Clear()
  local Group_BasicAttributes = View.Group_BasicAttributes
  Group_BasicAttributes.Txt_BasicAttributes.Img_Icon:SetActive(false)
  Group_BasicAttributes.Txt_BasicAttributes.Group_.Txt_Attributes:SetActive(false)
  Group_BasicAttributes.Txt_BasicAttributes.Group_.Txt_AttributesNum:SetActive(false)
  if Group_BasicAttributes.Group_BreakLv then
    Group_BasicAttributes.Group_BreakLv:SetActive(false)
  end
  if DataModel.equipCA.skillList and table.count(DataModel.equipCA.skillList) ~= 0 then
    local pro, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp = PlayerData:GetBreakMainAttr(DataModel.equipCA, DataModel.params.server.lv, 0, DataModel.params.server.bk_lv or 0)
    Group_BasicAttributes.Txt_BasicAttributes.Img_Icon:SetSprite(pro.icon)
    Group_BasicAttributes.Txt_BasicAttributes.Group_.Txt_Attributes:SetActive(true)
    Group_BasicAttributes.Txt_BasicAttributes.Group_.Txt_Attributes:SetText(pro.name .. " <color='#FFB800'>+ " .. PlayerData:GetPreciseDecimalFloor(curNum, 0) .. "</color>")
    Group_BasicAttributes.Txt_BasicAttributes.Img_Icon:SetActive(true)
    if Group_BasicAttributes.Group_BreakLv then
      Group_BasicAttributes.Group_BreakLv:SetActive(true)
      Group_BasicAttributes.Group_BreakLv.Txt_EquipmentCharacter:SetText(string.format(GetText(80612235), DataModel.params.server.bk_lv or 0))
    end
    if DataModel.params.server.random_affix == nil then
      DataModel.params.server.random_affix = {}
      DataModel.params.server.random_affix["0"] = {}
      DataModel.params.server.random_affix["0"].id = DataModel.equipCA.skillList[1].skillId
      DataModel.params.server.random_affix["0"].value = -1
    end
  end
  DataModel:RefreshRightDownContent()
end

function DataModel:ClickLockBtn()
  if DataModel.isLockState == 0 then
    View.Group_Lock.Btn_Unlock:SetActive(false)
    View.Group_Lock.Btn_Lock:SetActive(true)
    DataModel.isLockState = 1
  else
    View.Group_Lock.Btn_Unlock:SetActive(true)
    View.Group_Lock.Btn_Lock:SetActive(false)
    DataModel.isLockState = 0
  end
  DataModel.isChangeLock = false
  if DataModel.isLockState ~= DataModel.params.server.is_locked then
    DataModel.isChangeLock = true
  end
end

function DataModel:SendEquipLockData(callback, back)
  local isChange = false
  local str_lock = ""
  local str_unlock = ""
  local changeList = {}
  if DataModel.isChangeLock == true then
    if DataModel.isLockState == 1 then
      str_lock = DataModel.eid
    else
      str_unlock = DataModel.eid
    end
    isChange = true
  else
    isChange = false
  end
  if isChange == false then
    callback()
    return
  end
  if isChange == true then
    Net:SendProto("equip.lock", function(json)
      print_r(json)
      PlayerData:GetEquipByEid(DataModel.eid).is_locked = DataModel.isLockState
      callback()
    end, str_lock, str_unlock)
  end
end

return DataModel
