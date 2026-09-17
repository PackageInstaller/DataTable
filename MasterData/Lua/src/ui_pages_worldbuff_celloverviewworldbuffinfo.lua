local cell = class("cellOverviewWorldBuffInfo", G_UIModuleBase)
local tag = "module:cellOverviewWorldBuffInfo"
local _worldCityTpl = L_GameTpl:getWorldCityTpl()

function cell:preBind()
  return {}
end

function cell:bind()
  return {
    txt_cityName = "",
    rl_buildBuff = {
      moduleName = "pages/worldBuff/cellWorldBuff"
    }
  }
end

function cell:methods()
  return {}
end

function cell:onSetData(param)
  self._worldCityId = param.worldCityId
  self._collectionList = param.collectionList
  self:onRefreshView()
end

function cell:onRefreshView()
  if not self.isBind then
    return
  end
  local cityTpl = _worldCityTpl:getTplById(self._worldCityId)
  local cityName = _worldCityTpl:getCity(cityTpl)
  self.bind.txt_cityName = cityName
  local dataList = {}
  for _, v in ipairs(self._collectionList) do
    local item = {
      worldCityId = self._worldCityId,
      buildCollectionId = v
    }
    table.insert(dataList, item)
  end
  self.bind.rl_buildBuff:refresh_array(dataList)
end

return cell
