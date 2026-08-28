local View = require("UICardDeatil/UICardDeatilView")
local DataModel = require("UICardDeatil/UICardDeatilDataModel")
local Controller = {}

function Controller:Init(data)
  DataModel.curData = data
  self:InitSkill()
  self:InitOptions()
  self:CloseNumSelect()
end

function Controller:InitSkill()
  local cardId = DataModel.curData.id
  local cardCA = PlayerData:GetFactoryData(cardId)
  local content = View.Group_Main.Group_Skill.ScrollView_Group_CardsSetting.Viewport.Content
  content.Group_SkillIcon.Img_SkillIcon:SetSprite(cardCA.iconPath)
  content.Txt_SkillName:SetText(cardCA.name)
  local cost = math.floor(cardCA.cost_SN)
  content.Group_Cost.Txt_CostNum:SetText(cost)
  if DataModel.curData.skillIndex ~= nil and DataModel.curData.skillIndex > 0 and DataModel.curData.ownerId ~= nil then
    content.Group_SkillCount.self:SetActive(true)
    local ownerCA = PlayerData:GetFactoryData(DataModel.curData.ownerId)
    local num = ownerCA.skillList[DataModel.curData.skillIndex].num
    if CommonTips.IsResEN() then
      num = GetText(80608688) .. num
    else
      num = num .. GetText(80608688)
    end
    content.Group_SkillCount.Txt_SkillCountNum:SetText(num)
  else
    content.Group_SkillCount.self:SetActive(false)
  end
  local tagList = {}
  for i = 1, #cardCA.tagList do
    local tagId = cardCA.tagList[i].tagId
    local tagCA = PlayerData:GetFactoryData(tagId)
    if tagCA.isShowDetail then
      tagList[#tagList + 1] = tagCA
    end
  end
  DataModel.tagList = tagList
  content.Group_SkillDes.StaticGrid_CardTags.grid.self:SetDataCount(#tagList)
  content.Group_SkillDes.StaticGrid_CardTags.grid.self:RefreshAllElement()
  if DataModel.curData.skillId ~= nil then
    DataManager:GetUnitCard(10000055, 0, 0)
    local desData = Json.decode(DataManager:GetCardDes(tonumber(DataModel.curData.skillId)))
    content.Group_SkillDes.Txt_SkillDes:SetText(desData.des)
  end
end

function Controller:OnSetTagGrid(element, elementIndex)
  local tagCA = DataModel.tagList[elementIndex]
  element.Img_Icon:SetSprite(tagCA.icon)
  element.Txt_Tag:SetText(string.format(GetText(80608786), tagCA.tagNameRichText, tagCA.detail))
end

function Controller:InitOptions()
  local cardId = DataModel.curData.id
  local cardCA = PlayerData:GetFactoryData(cardId)
  View.Group_Main.Group_Option.ScrollGrid_Options.grid.self:SetDataCount(#cardCA.ExActList + #cardCA.ExCondList + 2)
  View.Group_Main.Group_Option.ScrollGrid_Options.grid.self:MoveToTop()
  View.Group_Main.Group_Option.ScrollGrid_Options.grid.self:RefreshAllElement()
end

function Controller:OnSetOptionGrid(element, elementIndex)
  local isCurState = elementIndex == DataModel.curData.useType
  element.Img_Off.self:SetActive(isCurState)
  element.Btn_On.Group_Txt.Img_NumBox.self:SetActive(false)
  element.Img_Off.Group_Txt.Img_NumBox.self:SetActive(false)
  local optionDes = ""
  local useParam = ""
  local cardId = DataModel.curData.id
  local cardCA = PlayerData:GetFactoryData(cardId)
  if elementIndex == 1 then
    optionDes = GetText(80608531)
  elseif elementIndex == 2 then
    optionDes = GetText(80608532)
  elseif 2 < elementIndex and elementIndex <= #cardCA.ExCondList + 2 then
    local data = cardCA.ExCondList[elementIndex - 2]
    optionDes = GetText(data.des)
    if data.isNumCond then
      if DataModel.curData.useParamMap == nil then
        DataModel.curData.useParamMap = {}
      end
      local param = DataModel.curData.useParamMap[tostring(elementIndex)]
      if param == nil then
        param = data.minNum
        DataModel.curData.useParamMap[tostring(elementIndex)] = param
      end
      if isCurState then
        DataModel.curData.useParam = param
      end
      if data.typeEnum == "number" then
        useParam = useParam .. param
      elseif data.typeEnum == "percent" then
        useParam = useParam .. param .. "%"
      end
    end
  else
    local data = cardCA.ExActList[elementIndex - #cardCA.ExCondList - 2]
    optionDes = GetText(data.des)
    if data.isNumCond then
      if DataModel.curData.useParamMap == nil then
        DataModel.curData.useParamMap = {}
      end
      local param = DataModel.curData.useParamMap[tostring(elementIndex)]
      if param == nil then
        param = data.minNum
        DataModel.curData.useParamMap[tostring(elementIndex)] = param
      end
      if isCurState then
        DataModel.curData.useParam = param
      end
      if data.typeEnum == "number" then
        useParam = useParam .. param
      elseif data.typeEnum == "percent" then
        useParam = useParam .. param .. "%"
      end
    end
  end
  element.Btn_On.Group_Txt.Txt_Rule:SetText(optionDes)
  element.Btn_On:SetClickParam(elementIndex)
  if useParam ~= "" then
    element.Btn_On.Group_Txt.Img_NumBox.self:SetActive(true)
    element.Img_Off.Group_Txt.Img_NumBox.self:SetActive(true)
    element.Btn_On.Group_Txt.Img_NumBox.Txt_Num:SetText(useParam)
    element.Img_Off.Group_Txt.Img_NumBox.Txt_Num:SetText(useParam)
  end
  if isCurState then
    element.Img_Off.Group_Txt.Txt_Rule:SetText(optionDes)
  end
  element.Btn_On.Group_Txt.Img_NumBox.Btn_:SetClickParam(elementIndex)
  element.Img_Off.Group_Txt.Img_NumBox.Btn_:SetClickParam(elementIndex)
end

function Controller:SetUseType(useType)
  if DataModel.curData.useType == useType then
    return
  end
  DataModel.curData.useType = useType
  View.Group_Main.Group_Option.ScrollGrid_Options.grid.self:RefreshAllElement()
end

function Controller:OpenNumSelect(index)
  DataModel.curSetIndex = index
  local group = View.Group_Main.Group_Option.Group_NumSelect
  group.self:SetActive(true)
  local cardId = DataModel.curData.id
  local cardCA = PlayerData:GetFactoryData(cardId)
  local data
  if index <= #cardCA.ExCondList + 2 then
    data = cardCA.ExCondList[index - 2]
  else
    data = cardCA.ExActList[index - #cardCA.ExCondList - 2]
  end
  DataModel.curNumIndex = nil
  local curParam = DataModel.curData.useParamMap[tostring(index)]
  local curIndex = math.min(math.floor((curParam - data.minNum) / data.numDuration), data.interValNum - 1)
  group.Img_SelectBarBg.Page_Numbers.grid.self:SetDataCount(data.interValNum)
  group.Img_SelectBarBg.Page_Numbers.grid.self:RefreshAllElement()
  group.Img_SelectBarBg.Page_NumbersHide.grid.self:SetDataCount(data.interValNum)
  group.Img_SelectBarBg.Page_NumbersHide.grid.self:RefreshAllElement()
  group.Img_SelectBarBg.Page_NumbersHide.grid.self:LocatElementImmediate(curIndex)
end

function Controller:CloseNumSelect()
  View.Group_Main.Group_Option.Group_NumSelect.self:SetActive(false)
  DataModel.curSetIndex = nil
  DataModel.curNumIndex = nil
end

function Controller:RefreshUseParam()
  local cardId = DataModel.curData.id
  local cardCA = PlayerData:GetFactoryData(cardId)
  local data
  if DataModel.curSetIndex <= #cardCA.ExCondList + 2 then
    data = cardCA.ExCondList[DataModel.curSetIndex - 2]
  else
    data = cardCA.ExActList[DataModel.curSetIndex - #cardCA.ExCondList - 2]
  end
  local index = DataModel.curNumIndex
  local param = data.minNum + data.numDuration * index
  DataModel.curData.useParamMap[tostring(DataModel.curSetIndex)] = param
  View.Group_Main.Group_Option.ScrollGrid_Options.grid.self:RefreshAllElement()
end

return Controller
