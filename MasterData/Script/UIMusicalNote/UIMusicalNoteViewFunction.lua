local View = require("UIMusicalNote/UIMusicalNoteView")
local DataModel = require("UIMusicalNote/UIMusicalNoteDataModel")

local function UpdateVal(isInit)
  local BattleControlManager = CBus:GetManager(CS.ManagerName.BattleControlManager)
  local roleList = BattleControlManager.teamDataDic[1].roleList
  local roleCount = roleList.Count
  local val = 0
  for i = 0, roleCount - 1 do
    local buffSys = roleList[i].buffSystem
    val = val + buffSys:GetBuffLevel(10427181)
  end
  local group, lastGroup
  if val <= 20 then
    group = View.Group_NoteLevel0
    if 20 < DataModel.lastVal then
      lastGroup = View.Group_NoteLevel1
    end
  else
    group = View.Group_NoteLevel1
    if 0 <= DataModel.lastVal and 20 >= DataModel.lastVal then
      lastGroup = View.Group_NoteLevel0
    end
  end
  group.self:SetActive(true)
  if lastGroup ~= nil then
    View.self:SelectPlayAnim(lastGroup.self, "Disappear", function()
      lastGroup.self:SetActive(false)
    end)
    View.self:SelectPlayAnim(group.self, "LvUp", function()
      View.self:SelectPlayAnim(group.self, "Loop")
    end)
  elseif isInit then
    View.self:SelectPlayAnim(group.self, "LvUp", function()
      View.self:SelectPlayAnim(group.self, "Loop")
    end)
  end
  DataModel.lastVal = val
  local valStr = ""
  local str = tostring(val)
  for i = 1, #str do
    local subVal = string.sub(str, i, i)
    if tonumber(subVal) == nil then
      valStr = valStr .. "<sprite=11>"
    else
      valStr = valStr .. "<sprite=" .. subVal .. ">"
    end
  end
  if group.Group_Num.CardCost_Nums then
    group.Group_Num.CardCost_Nums.Tmp.text = valStr
  end
end

local ViewFunction = {
  UpdateVal = function(isInit)
    UpdateVal(isInit)
  end
}
return ViewFunction
