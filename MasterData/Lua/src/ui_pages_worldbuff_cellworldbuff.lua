local cell = class("cellWorldBuff", G_UIModuleBase)
local _WorldBuffTpl = L_GameTpl:getWorldBuffTpl()
local _worldMapTpl = L_GameTpl:getWorldMapTpl()
local _worldCityTpl = L_GameTpl:getWorldCityTpl()
local _homeCollectionWorldTpl = L_GameTpl:getHomeCollectionWorldTpl()
local _homeBuildingBuffWorldTpl = L_GameTpl:getHomeBuildingBuffWorldTpl()

function cell.bind()
  return {
    color_icon = C_Color(0.8, 0.3333333, 0.5764706, 1),
    txt_buffDesc = "",
    txt_buffDesc_color = C_Color(0.8, 0.3333333, 0.5764706, 1),
    color_buildBg = C_Color(0.8, 0.3333333, 0.5764706, 1),
    txt_buildName = ""
  }
end

function cell.methods()
  return {}
end

function cell:show()
  self:onRefreshCell()
end

function cell:onSetData(param)
  self._worldCityId = param.worldCityId
  self._homeCollectionId = param.buildCollectionId
  self:onRefreshCell()
end

function cell:onRefreshCell()
  if not self.isBind then
    return
  end
  local isHadBuild, buildBuffId = L_HomeBuffManager:getIsHadWildBuffBuild(self._homeCollectionId, true)
  local tpl = _homeBuildingBuffWorldTpl:getTplById(buildBuffId)
  local buildName = tpl ~= nil and _homeBuildingBuffWorldTpl:getName(tpl) or ""
  local buffStr = ""
  if isHadBuild then
    local _, colorPoint = C_ColorUtility.TryParseHtmlString("#CA7F30")
    colorPoint.a = 0.5
    local _, colorBg = C_ColorUtility.TryParseHtmlString("#CC9355")
    local _, colorTxt = C_ColorUtility.TryParseHtmlString("#C37420")
    colorTxt.a = 1
    self.bind.color_icon = colorPoint
    self.bind.txt_buffDesc_color = colorTxt
    self.bind.color_buildBg = colorBg
    buildName = L_WordsTpl:getValueParam("ui_home_building_buff_world_built", buildName)
    buffStr = buildName .. "   " .. _homeBuildingBuffWorldTpl:getCurBuffContent(tpl)
  else
    local _, colorPoint = C_ColorUtility.TryParseHtmlString("#4B463E")
    colorPoint.a = 0.2
    local _, colorBg = C_ColorUtility.TryParseHtmlString("#959187")
    local _, colorTxt = C_ColorUtility.TryParseHtmlString("#959187")
    colorTxt.a = 0.6
    self.bind.color_icon = colorPoint
    self.bind.txt_buffDesc_color = colorTxt
    self.bind.color_buildBg = colorBg
    buildName = L_WordsTpl:getValueParam("ui_home_building_buff_world_unbuilt", buildName)
    buffStr = buildName .. "   " .. L_WordsTpl:getValueParam("ui_home_building_buff_world_effectshow", buildName)
  end
  self.bind.txt_buildName = buildName
  self.bind.txt_buffDesc = buffStr
end

return cell
