local DataModel = {
  drinkBuff = {},
  bargainBuff = {},
  preMouseDown = false
}

function DataModel:RefreshBuffGroup(group, buff)
  if group == nil then
    return
  end
  if buff == nil then
    group.self:SetActive(false)
    return
  end
  group.self:SetActive(true)
  local buffCA = PlayerData:GetFactoryData(buff.id, "HomeBuffFactory")
  local desc = buffCA.desc
  if buffCA.mod == "\229\150\157\233\133\146\231\155\184\229\133\179" then
    local oneForAll = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.OneForAll)
    if 0 < oneForAll then
      desc = buffCA.intensifyDesc
    end
  end
  if buffCA.buffType == EnumDefine.HomeSkillEnum.AddSpeedPercentage or buffCA.buffType == EnumDefine.HomeSkillEnum.AccelerationBrakingPerformance then
    desc = string.format(desc, math.floor(buff.param * 100))
  end
  if buffCA.buffType == EnumDefine.HomeSkillEnum.HomeBattleBuff then
    local skillCA = PlayerData:GetFactoryData(buffCA.battleBuff, "SkillFactory")
    if skillCA ~= nil then
      desc = skillCA.description
      local skillParam = skillCA.desParamList[1]
      if skillParam ~= nil then
        if skillParam.isPercent then
          desc = string.format(desc, PlayerData:GetPreciseDecimalFloor(skillParam.param * 100, 1))
        else
          desc = string.format(desc, PlayerData:GetPreciseDecimalFloor(skillParam.param, 1))
        end
      end
    end
    desc = string.format(GetText(80606871), desc)
  end
  if buffCA.name ~= nil and buffCA.name ~= "" then
    group.Txt_Tips1:SetText(buffCA.name)
  end
  group.Txt_Dec:SetText(desc)
  if buff.endTime and 0 < buff.endTime then
    local remainTime = buff.endTime - TimeUtil:GetServerTimeStamp()
    group.Txt_Time:SetText(string.format(GetText(80600773), math.ceil(remainTime / 60)))
  end
  local showWL = false
  if group.Img_BtmWL then
    local tempList = PlayerData:GetFactoryData(80309368, "ListFactory").drinkBuffList
    for k, v in pairs(tempList) do
      if buffCA.id == v.id then
        showWL = true
        break
      end
    end
    group.Img_BtmWL:SetActive(showWL)
    group.Img_Btm:SetActive(not showWL)
  else
    group.Img_Btm:SetActive(true)
  end
end

return DataModel
