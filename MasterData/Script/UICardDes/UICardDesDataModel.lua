local View = require("UICardDes/UICardDesView")
local DataModel = {}
local space = 30
local downSpace = 10
local bgHight = 255
local baseDowny = -300
local baseUPy = -40

function DataModel:Init()
  local CA = PlayerData:GetFactoryData(DataModel.data.id)
  local cardDes = DataModel.data.cardDes
  local Group_LeaderCondition = View.Group_LeaderCondition
  Group_LeaderCondition.self:SetActive(false)
  local Group_Skill = View.Group_Skill.Group_Content.Group_UP.Group_Skill
  Group_Skill.Txt_Des_Leader:SetText("")
  local Leader_Space = 0
  if CA.leaderCardConditionDesc ~= nil and CA.leaderCardConditionDesc ~= "" then
    local tagCA = PlayerData:GetFactoryData(80600356)
    if tagCA.text ~= "" and DataModel.data.isLeaderCard == 1 then
      Group_Skill.Txt_Des_Leader:SetText(tagCA.text .. CA.leaderCardConditionDesc)
      Leader_Space = Group_Skill.Txt_Des_Leader:GetHeight() + 15
      Group_Skill.Txt_Des_Leader:SetHeight()
    end
  end
  local textId = 0
  local data = DataModel.data
  local battleConfig = PlayerData:GetFactoryData(99900008, "ConfigFactory")
  local makeDamageValue = (1 + (data.MakeDamageUp or 0) - (data.MakeDamageDown or 0)) * (1 + (data.MakeDamageFinalUp or 0) - (data.MakeDamageFinalDown or 0)) - 1
  local healValue = (data.MakeHealUp or 0) - (data.MakeHealDown or 0)
  local result, bg, arrow
  if makeDamageValue ~= 0 then
    result = tostring(PlayerData:GetPreciseDecimalFloor(makeDamageValue * 100, 0)) .. "%"
    if 0 < makeDamageValue then
      textId = 80601019
      bg = battleConfig.damageUpBg
      arrow = battleConfig.upArrow
      Group_Skill.Img_Show.Txt_Value:SetColor("#F3F0EE")
    else
      textId = 80601018
      bg = battleConfig.damageDownBg
      arrow = battleConfig.damageDownArrow
      Group_Skill.Img_Show.Txt_Value:SetColor("#CC6D6B")
    end
  elseif healValue ~= 0 then
    result = tostring(PlayerData:GetPreciseDecimalFloor(healValue * 100, 0)) .. "%"
    if 0 < healValue then
      textId = 80601016
      bg = battleConfig.healUpBg
      arrow = battleConfig.upArrow
      Group_Skill.Img_Show.Txt_Value:SetColor("#F3F0EE")
    else
      textId = 80601017
      bg = battleConfig.healDownBg
      arrow = battleConfig.healDownArrow
      Group_Skill.Img_Show.Txt_Value:SetColor("#65C529")
    end
  end
  if 0 < textId then
    Group_Skill.Img_Show:SetSprite(bg)
    Group_Skill.Img_Show.Img_Arrow:SetSprite(arrow)
    Group_Skill.Img_Show.Txt_Value:SetText(GetText(textId) .. result)
  end
  Group_Skill.Img_Show:SetActive(0 < textId)
  Group_Skill.Group_icon_mark:SetActive(false)
  Group_Skill.Group_icon_mark.skill_ex_text_x:SetActive(false)
  Group_Skill.Group_icon_mark.skill_ex_text_num:SetActive(false)
  local currentCount = 0
  if data.id == 12300112 or data.id == 12301960 then
    for k, v in pairs(data.Grave) do
      if v == 12300110 or v == 12300088 then
        currentCount = currentCount + 1
      end
    end
  end
  if 0 < currentCount then
    Group_Skill.Group_icon_mark:SetActive(true)
    local count = Group_Skill.Group_icon_mark.self.transform.childCount - 2
    if currentCount > count then
      for i = 1, count do
        Group_Skill.Group_icon_mark["Img_skill_ex_icon_" .. i]:SetActive(true)
      end
    else
      for i = 1, count do
        Group_Skill.Group_icon_mark["Img_skill_ex_icon_" .. i]:SetActive(i <= currentCount)
      end
    end
    if currentCount > count then
      currentCount = count
    end
    for i = 1, currentCount do
      Group_Skill.Group_icon_mark["Img_skill_ex_icon_" .. i]:SetSprite(battleConfig.specialIcon01)
    end
  end
  local greenCount = 0
  local yellowCount = 0
  if data.id == 12300285 or data.id == 12300251 then
    for k, v in pairs(data.Grave) do
      if v == 12300286 or v == 12300741 then
      elseif v == 12300284 then
      end
    end
    for k, v in pairs(data.Hand) do
      if v == 12300286 or v == 12300741 then
      elseif v == 12300284 then
      end
    end
  end
  currentCount = greenCount + yellowCount
  if 0 < currentCount then
    Group_Skill.Group_icon_mark:SetActive(true)
    local count = Group_Skill.Group_icon_mark.self.transform.childCount - 2
    if currentCount > count then
      for i = 1, count do
        Group_Skill.Group_icon_mark["Img_skill_ex_icon_" .. i]:SetActive(true)
      end
    else
      for i = 1, count do
        Group_Skill.Group_icon_mark["Img_skill_ex_icon_" .. i]:SetActive(i <= currentCount)
      end
    end
    local path
    if currentCount > count then
      currentCount = count
    end
    for i = 1, currentCount do
      if yellowCount >= i then
        path = battleConfig.specialIcon03
      else
        path = battleConfig.specialIcon02
      end
      Group_Skill.Group_icon_mark["Img_skill_ex_icon_" .. i]:SetSprite(path)
    end
  end
  local _desc = string.gsub(CA.description, "\\n", "*")
  _desc = string.gsub(_desc, "\\", "")
  _desc = string.gsub(_desc, "*", "\n")
  local cardDes = DataModel.data.cardDes
  if data.id == 12300514 and string.find(_desc, "#r") ~= nil then
    local startIndex = string.find(_desc, "#r")
    local numStr = ""
    currentCount = 0
    for i = startIndex, string.getLength(cardDes) do
      local curChar = string.sub(cardDes, i, i)
      if tonumber(curChar) ~= nil then
        numStr = numStr .. curChar
      else
        break
      end
    end
    local num = tonumber(numStr)
    if num ~= nil then
      currentCount = num
    end
    if 0 < currentCount then
      Group_Skill.Group_icon_mark:SetActive(true)
      local count = Group_Skill.Group_icon_mark.self.transform.childCount - 2
      Group_Skill.Group_icon_mark.Img_skill_ex_icon_1:SetActive(true)
      Group_Skill.Group_icon_mark.Img_skill_ex_icon_1:SetSprite(battleConfig.specialIcon04)
      for i = 2, count do
        Group_Skill.Group_icon_mark["Img_skill_ex_icon_" .. i]:SetActive(false)
      end
      Group_Skill.Group_icon_mark.skill_ex_text_x:SetActive(true)
      Group_Skill.Group_icon_mark.skill_ex_text_num:SetActive(true)
      Group_Skill.Group_icon_mark.skill_ex_text_num:SetText(currentCount)
    end
  end
  if data.id == 12302070 then
    local BattleControlManager = CBus:GetManager(CS.ManagerName.BattleControlManager)
    local roleList = BattleControlManager.teamDataDic[1].roleList
    local roleCount = roleList.Count
    currentCount = 0
    for i = 0, roleCount - 1 do
      local buffSys = roleList[i].buffSystem
      currentCount = currentCount + buffSys:GetBuffLevel(10413979) + buffSys:GetBuffLevel(10414110) * 5
    end
    if 0 < currentCount then
      Group_Skill.Group_icon_mark:SetActive(true)
      local count = Group_Skill.Group_icon_mark.self.transform.childCount - 2
      Group_Skill.Group_icon_mark.Img_skill_ex_icon_1:SetActive(true)
      Group_Skill.Group_icon_mark.Img_skill_ex_icon_1:SetSprite(battleConfig.specialIcon06 or "")
      for i = 2, count do
        Group_Skill.Group_icon_mark["Img_skill_ex_icon_" .. i]:SetActive(false)
      end
      Group_Skill.Group_icon_mark.skill_ex_text_x:SetActive(true)
      Group_Skill.Group_icon_mark.skill_ex_text_num:SetActive(true)
      Group_Skill.Group_icon_mark.skill_ex_text_num:SetText(currentCount)
    end
  end
  if data.id == 12304472 then
    local BattleControlManager = CBus:GetManager(CS.ManagerName.BattleControlManager)
    local roleList = BattleControlManager.teamDataDic[1].roleList
    local roleCount = roleList.Count
    currentCount = 0
    for i = 0, roleCount - 1 do
      local buffSys = roleList[i].buffSystem
      currentCount = currentCount + buffSys:GetBuffLevel(10427474)
    end
    if 0 < currentCount then
      Group_Skill.Group_icon_mark:SetActive(true)
      local count = Group_Skill.Group_icon_mark.self.transform.childCount - 2
      Group_Skill.Group_icon_mark.Img_skill_ex_icon_1:SetActive(true)
      Group_Skill.Group_icon_mark.Img_skill_ex_icon_1:SetSprite(battleConfig.specialIcon07 or "")
      for i = 2, count do
        Group_Skill.Group_icon_mark["Img_skill_ex_icon_" .. i]:SetActive(false)
      end
      Group_Skill.Group_icon_mark.skill_ex_text_x:SetActive(true)
      Group_Skill.Group_icon_mark.skill_ex_text_num:SetActive(true)
      Group_Skill.Group_icon_mark.skill_ex_text_num:SetText(currentCount)
    end
  end
  if data.id == 12304503 or data.id == 12304516 or data.id == 12304516 or data.id == 12304502 or data.id == 12304513 or data.id == 12304515 or data.id == 12304504 or data.id == 12304514 then
    local BattleControlManager = CBus:GetManager(CS.ManagerName.BattleControlManager)
    local roleList = BattleControlManager.teamDataDic[1].roleList
    local roleCount = roleList.Count
    currentCount = 0
    for i = 0, roleCount - 1 do
      local buffSys = roleList[i].buffSystem
      currentCount = currentCount + buffSys:GetBuffLevel(10427865)
    end
    if 0 < currentCount then
      Group_Skill.Group_icon_mark:SetActive(true)
      local count = Group_Skill.Group_icon_mark.self.transform.childCount - 2
      Group_Skill.Group_icon_mark.Img_skill_ex_icon_1:SetActive(true)
      Group_Skill.Group_icon_mark.Img_skill_ex_icon_1:SetSprite(battleConfig.specialIcon08 or "")
      for i = 2, count do
        Group_Skill.Group_icon_mark["Img_skill_ex_icon_" .. i]:SetActive(false)
      end
      Group_Skill.Group_icon_mark.skill_ex_text_x:SetActive(true)
      Group_Skill.Group_icon_mark.skill_ex_text_num:SetActive(true)
      Group_Skill.Group_icon_mark.skill_ex_text_num:SetText(currentCount)
    end
  end
  if data.id == 12300420 then
    local BattleControlManager = CBus:GetManager(CS.ManagerName.BattleControlManager)
    currentCount = BattleControlManager.currentPlayerTeamData.buffSystem:GetBuffLevel(10402816)
    if 0 < currentCount then
      Group_Skill.Group_icon_mark:SetActive(true)
      local count = Group_Skill.Group_icon_mark.self.transform.childCount - 2
      Group_Skill.Group_icon_mark.Img_skill_ex_icon_1:SetActive(true)
      Group_Skill.Group_icon_mark.Img_skill_ex_icon_1:SetSprite(battleConfig.specialIcon05)
      for i = 2, count do
        Group_Skill.Group_icon_mark["Img_skill_ex_icon_" .. i]:SetActive(false)
      end
      Group_Skill.Group_icon_mark.skill_ex_text_x:SetActive(true)
      Group_Skill.Group_icon_mark.skill_ex_text_num:SetActive(true)
      Group_Skill.Group_icon_mark.skill_ex_text_num:SetText(currentCount)
    end
  end
  Group_Skill.Img_Item:SetSprite(CA.iconPath)
  Group_Skill.Txt_Des:SetText(cardDes)
  if not CommonTips.IsResEN() then
    Group_Skill.Txt_Des:OnTextChange()
  end
  Group_Skill.Txt_Name:SetText(CA.name)
  Group_Skill.Txt_LvNum:SetText("")
  Group_Skill.Txt_Lv:SetText("")
  local Skill_Space = Group_Skill.Txt_Des:GetHeight()
  Group_Skill.Txt_Des:SetHeight()
  Group_Skill.Txt_Des.Rect.sizeDelta.y = Skill_Space
  Group_Skill.Txt_Des.transform.localPosition = Vector3(-70, -80 - Leader_Space, 0)
  local Group_Cost = View.Group_Skill.Group_Content.Group_UP.Group_Cost
  Group_Cost.Txt_CostNum:SetText("")
  Group_Cost.Txt_Cost:SetText("")
  local skillCA = PlayerData:GetFactoryData(CA.cardID, "cardFactory")
  local costNum = CA.cardID and skillCA.cost_SN or nil
  if costNum == nil or costNum == "" or costNum == 0 then
    Group_Cost.Txt_Cost:SetActive(false)
  elseif DataModel.data.isLeaderCard == 0 then
    Group_Cost.Txt_Cost:SetActive(true)
    Group_Cost.Txt_Cost:SetText("COST")
    Group_Cost.Txt_CostNum:SetText(math.ceil(costNum))
  end
  local Group_Type = View.Group_Skill.Group_Content.Group_UP.Group_Type
  Group_Type.self:SetActive(false)
  local Group_DownTag = View.Group_Skill.Group_Content.Group_DownTag
  Group_DownTag.self:SetActive(true)
  local show_list = {}
  local count = 1
  for k, v in pairs(skillCA.tagList) do
    local tagCA = PlayerData:GetFactoryData(v.tagId)
    show_list[count] = tagCA
    count = count + 1
  end
  local lastY = 0
  local lastSpace = 5
  local allSpace = 0
  for i = 1, 8 do
    local obj = "Group_Tag" .. i
    Group_DownTag[obj]:SetActive(false)
    local row = show_list[i]
    if row and row.isShowDetail == true then
      Group_DownTag[obj]:SetActive(true)
      Group_DownTag[obj].Txt_Tag:SetText(row.tagNameRichText .. "\239\188\154" .. row.detail)
      Group_DownTag[obj].Txt_Tag:SetHeight()
      local height = Group_DownTag[obj].Txt_Tag:GetHeight()
      Group_DownTag[obj].Img_Tag:SetSprite(row.icon)
      Group_DownTag[obj].Img_Tag:SetNativeSize()
      if i == 1 then
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
  local finishSpace = space + allSpace + Skill_Space + Leader_Space
  View.Group_Skill.Img_Bg:SetImgWidthAndHeight(700, bgHight + finishSpace)
  View.Group_Skill.Img_Glass:SetImgWidthAndHeight(700, bgHight + finishSpace)
  if 650 < bgHight + finishSpace then
    View.Group_Skill.self:SetLocalPositionY(300)
  else
    View.Group_Skill.self:SetLocalPositionY(190)
  end
  local donwY = finishSpace - Skill_Space + space * 2
  if donwY < baseDowny then
    donwY = baseDowny
  end
  View.Group_Skill.Group_Content.Group_DownTag.transform.localPosition = Vector3(0, -180 - Skill_Space - Leader_Space - 15, 0)
  local initY = 0
  for i = 0, 7 do
    local obj = "Group_" .. i
    View.Group_Right[obj]:SetActive(false)
    View.Group_Right[obj].transform.localPosition = Vector3(0, initY, 0)
  end
  local baseRightHeightBg = 94
  local baseRightTxtHeightBg = 78
  local rightSpace = 15
  local rightLastY = 0
  local rightLastSpace
  local rightSpaceDwon = 5
  local rightYSpace = 0
  local other_tagList = {}
  if DataModel.data.tag then
    local ufids = Split(DataModel.data.tag, "#")
    if ufids and 0 < table.count(ufids) then
      for k, v in pairs(ufids) do
        local table_list = Split(v, "|")
        if table_list[2] ~= "-1" then
          local row = {}
          row.unitId = table_list[1]
          row.cardId = table_list[2]
          table.insert(other_tagList, {
            tagId = table_list[2]
          })
        end
      end
    end
  end
  for i = 1, #skillCA.tagOutsideList do
    if i + #other_tagList <= 7 then
      table.insert(other_tagList, {
        tagId = skillCA.tagOutsideList[i].tagId
      })
    else
      break
    end
  end
  if other_tagList and 0 < table.count(other_tagList) then
    for i = 1, table.count(other_tagList) do
      local v = other_tagList[i]
      local tagCA = PlayerData:GetFactoryData(v.tagId)
      if tagCA and tagCA.isShowDetail == true then
        local obj = "Group_" .. i - 1
        View.Group_Right[obj]:SetActive(true)
        View.Group_Right[obj].Img_Bg.Img_Face_Box.Img_Face_Bg.Img_Face:SetSprite(tagCA.icon)
        View.Group_Right[obj].Img_Bg.Txt_Des_Box.Txt_Des:SetText("<color=#FFB800>" .. tagCA.tagNameRichText .. "\239\188\154" .. "</color>" .. tagCA.detail)
        local textHeight = View.Group_Right[obj].Img_Bg.Txt_Des_Box.Txt_Des:GetHeight()
        View.Group_Right[obj].Img_Bg.Txt_Des_Box.Txt_Des:SetHeight()
        rightLastSpace = baseRightHeightBg
        rightYSpace = 0
        View.Group_Right[obj].Img_Bg:SetImgWidthAndHeight(500, baseRightHeightBg)
        if baseRightTxtHeightBg < textHeight then
          local space = rightSpace * 2
          rightLastSpace = textHeight + space
          rightYSpace = rightLastSpace - baseRightTxtHeightBg - rightSpace
          View.Group_Right[obj].Img_Bg:SetImgWidthAndHeight(500, rightLastSpace)
          initY = initY + textHeight - baseRightTxtHeightBg + rightSpace
        end
        if 1 < i then
          View.Group_Right[obj].transform.localPosition = Vector3(0, rightLastY + rightYSpace, 0)
        else
          View.Group_Right[obj].transform.localPosition = Vector3(0, initY, 0)
        end
        rightLastY = rightLastSpace + rightLastY + rightSpaceDwon
      end
    end
  end
end

return DataModel
