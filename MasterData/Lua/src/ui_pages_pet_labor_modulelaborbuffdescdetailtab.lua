local module = class("moduleLaborBuffDescDetailTab", G_UIModuleBase)
local CommonFunc = require("ui.pages.pet.labor.laborCommonFunc")
local _homeLaborTypeTpl = L_GameTpl:getHomeLaborTypeTpl()

function module:bind()
  return {
    go_canUpDesc = false,
    txt_canUpDesc = "",
    list_laborDesc = {
      moduleName = "pages/pet/labor/cellLaborBuffEntryDetail"
    }
  }
end

function module:Init(_data)
  self:refreshModule(_data)
end

function module:refreshModule(_data)
  local laborId = _data.laborId
  local homeLaborTypeTpl = _homeLaborTypeTpl:getTplById(laborId)
  local canAddExpTxt = CommonFunc:getMinRarityDescByLaborGrade(_data.laborGrade, laborId)
  if not string.isEmpty(canAddExpTxt) then
    self.bind.go_canUpDesc = true
    self.bind.txt_canUpDesc = canAddExpTxt
  end
  local tmp = {}
  local displayList = CommonFunc.getBuffDisplayList(homeLaborTypeTpl)
  for i = 1, #_homeLaborTypeTpl:getLaborDescDetailList(homeLaborTypeTpl) do
    local displayData = displayList[i]
    if displayData then
      local descContent = CommonFunc.getNoTalentDetailDescText(i, laborId, _data.needLaborType, _data.laborGrade)
      if not string.isEmpty(descContent) then
        table.insert(tmp, {
          index = i,
          id = _homeLaborTypeTpl:getHomeBuffIdList(homeLaborTypeTpl)[i],
          laborId = laborId,
          titleIcon = displayData.titleIcon,
          detailDesc = self:getLastDesc(descContent)
        })
      end
    end
  end
  self.bind.list_laborDesc:clear()
  self.bind.list_laborDesc:insert_array(tmp)
end

function module:getLastDesc(desc)
  local str = type(desc) == "string" and desc or table.concat(desc or {}, "\n")
  return string.trim(str:match([[
[^
]+$]]) or str)
end

return module
