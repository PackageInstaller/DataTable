local module = class("moduleLaborEntryTabList", G_UIModuleBase)
local _homeLaborTypeTpl = L_GameTpl:getHomeLaborTypeTpl()
local IsPc = L_DeviceTpl:getIsPc()

function module.bind()
  return {
    list_tab = {
      moduleName = "pages/pet/labor/cellLaborBuffEntry"
    }
  }
end

function module:open()
  L_PetStore:listenCallFunc(L_PetStore.event.triggerLaborDescPoint, self.setEntryLight, self)
end

function module:setEntryLight(info)
  local laborId = info.laborId
  if laborId ~= nil and (self._laborId == nil or laborId ~= self._laborId) then
    return
  end
  local id = info.id
  local isShow = info.isShow
  for i = 1, #self.bind.list_tab do
    local v = self.bind.list_tab:getItemCls(i)
    if id == v:getItemId() then
      v:isShowHover(isShow)
    elseif not IsPc then
      v:isShowHover(false)
    end
  end
end

local CommonFunc = require("ui.pages.pet.labor.laborCommonFunc")

function module:setTextData(homeLaborTypeTpl, _laborId, _needLaborType, _laborGrade)
  self._laborId = _laborId
  local temp = {}
  local displayList = CommonFunc.getBuffDisplayList(homeLaborTypeTpl)
  for i = 1, #_homeLaborTypeTpl:getLaborDescDetailList(homeLaborTypeTpl) do
    local displayData = displayList[i]
    if displayData then
      local descContent = CommonFunc.getNoTalentDetailDescText(i, _laborId, _needLaborType, _laborGrade)
      if not string.isEmpty(descContent) then
        local _rarityProduct, _isStarEq = CommonFunc._handleSpecialBuffRarity(i, _laborId, _needLaborType, _laborGrade)
        table.insert(temp, {
          index = i,
          id = _homeLaborTypeTpl:getHomeBuffIdList(homeLaborTypeTpl)[i],
          titleIcon = displayData.titleIcon,
          titleName = displayData.titleName,
          buffSimpleDesc = displayData.buffSimpleDesc,
          buffDesc = CommonFunc.getNoTalentDescText(i, _laborId, _needLaborType, _laborGrade),
          iconList = displayData.iconList,
          rarity = CommonFunc.getRarityByScore(_laborGrade),
          rarityProduct = _rarityProduct,
          isStarEq = _isStarEq
        })
      end
    end
  end
  self.dataList = temp
  self:setData(temp)
end

function module:getListCount()
  return self.dataList ~= nil and #self.dataList or 0
end

function module:setData(dataList)
  self.bind.list_tab:clear()
  if #dataList <= 0 then
    return
  end
  table.sort(dataList, function(a, b)
    local strA = L_Lang:_translate(a.buffSimpleDesc)
    local strB = L_Lang:_translate(b.buffSimpleDesc)
    
    local function isInvalidDesc(str)
      return not str or str == "" or str == " "
    end
    
    local aInvalid = isInvalidDesc(strA)
    local bInvalid = isInvalidDesc(strB)
    if aInvalid ~= bInvalid then
      return aInvalid
    end
    return a.index < b.index
  end)
  self.bind.list_tab:insert_array(dataList)
end

function module:close()
  L_PetStore:unListenCallFunc(L_PetStore.event.triggerLaborDescPoint, self.setEntryLight, self)
end

return module
