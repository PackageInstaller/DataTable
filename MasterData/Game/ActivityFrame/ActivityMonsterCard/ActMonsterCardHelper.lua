local ActMonsterCardHelper = {}
local CommonLogicUtil = require("Game.Common.CommonLogicUtil.CommonLogicUtil")

function ActMonsterCardHelper.GetShotDesFormCardList(cardList)
  local desList = {}
  local logicDic = {}
  local logicIds = {}
  local logicIdDic = {}
  for _, cardData in ipairs(cardList) do
    local logic_list, para1_list, para2_list, para3_list = cardData:AacMCD_GetOrgLogic()
    for index, logic in ipairs(logic_list) do
      CommonLogicUtil.MergeLogic(logicDic, logic, {
        para1_list[index],
        para2_list[index],
        para3_list[index]
      })
      if not logicIdDic[logic] then
        logicIdDic[logic] = true
        table.insert(logicIds, logic)
      end
    end
  end
  for _, logic in ipairs(logicIds) do
    local paraTab = logicDic[logic]
    local para1Array = paraTab[1]
    local para2Array = paraTab[2]
    local para3Array = paraTab[3]
    for k, para1 in ipairs(para1Array) do
      local para2 = para2Array and para2Array[k] or nil
      local para3 = para3Array and para3Array[k] or nil
      local longDes, shortDes, valueDes = CommonLogicUtil.GetDesString(logic, para1, para2, para3, eLogicDesType.MonsterCard)
      shortDes = shortDes or "[des]"
      valueDes = valueDes or "+[val]"
      table.insert(desList, shortDes .. valueDes)
    end
  end
  return desList
end

return ActMonsterCardHelper
