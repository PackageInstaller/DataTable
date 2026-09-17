local this = class("pageWorldMapLv", G_UIPageBase)
local _worldDifficultyCityTpl = L_GameTpl:getWorldDifficultyCityTpl()
local _worldCityTpl = L_GameTpl:getWorldCityTpl()
local _areaTpl = L_GameTpl:getAreaTpl()
local _worldAreaTpl = L_GameTpl:getWorldAreaTpl()

local function getMapStore()
  return C_MapManager:GetMapStore()
end

local path_img_lv = "UI/Atlas/WorldLevel/tex_world_difficulty_level_bg_0%d.png"
local path_img_levelIcon = "UI/Atlas/WorldLevel/tex_world_difficulty_pattern_icon_0%d.png"
local path_img_nextlv_circleLine = "UI/Atlas/WorldLevel/tex_world_difficulty_pattern_frame_0%d.png"
local txtCheckDescOri_Colors = {
  "#6d7879",
  "#73825e",
  "#5a6c89",
  "#745373",
  "#b273a9",
  "#91a6d3",
  "#72abc6"
}
local txtCheckDescOri_GradientColors = {
  [5] = "#70488f",
  [6] = "#7c6cb3",
  [7] = "#72abc6"
}
local imgSignColors = {
  "#d6eaec",
  "#75fb40",
  "#29c1ff",
  "#fdbbe2",
  "#ffd1f9",
  "#e9d0fe",
  "#a2c7ff"
}
local imgSignGradientColors = {
  [5] = "#dbf1fb",
  [6] = "#b2e1fe",
  [7] = "#4ef3fd"
}
local nextLvLine_Colors = {
  "#2b883d",
  "#2b6d88",
  "#882b62",
  "#731b53",
  "#4023f0",
  "#1389ee"
}
local txtCheckDesc2Names = {
  L_WordsTpl:getValue("residual_code_pageworldmaplv_01"),
  "下降"
}

function this.bind()
  return {
    module_commonTipSmall = L_Const.ModuleInfo.ModuleCommonTip,
    txtTitle = "",
    txtCheckDescOri = "",
    txtCheckDescNext = "",
    txtCheckDesc2 = "",
    txt_lv1 = "",
    txt_lv2 = "",
    go_showNoMore = false,
    img_lev1 = "",
    img_lev2 = "",
    img_lvIcon = "",
    img_next_lvIcon = "",
    img_sign_oriColor = nil,
    img_sign_nextColor = nil,
    img_next_circleLine = "",
    img_next_lineColor = C_LuaUtility.ParseHtmlStringColor(nextLvLine_Colors[1]),
    go_ani_loop = ""
  }
end

function this.methods()
  return {
    onClick_noMoreShow = function(self)
      self.bind.go_showNoMore = not self.bind.go_showNoMore
    end,
    module_commonTipSmall = {
      onClick_close = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_cancel = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_confirm = function(self)
        local function cb(a, errCode, c)
          if errCode == L_Const.errorCode.ErrCodeSucc then
            if self.m_params.confirmCb ~= nil then
              self.m_params.confirmCb()
            end
            L_UI:close(self.pageName)
          end
        end
        
        L_WorldMapLvStore:req_worldMapLevel(self.m_params.mapId, self.m_params.nextLv, cb)
      end,
      onClick_bg = function(self)
        L_UI:close(self.pageName)
      end
    }
  }
end

function this:preOpen(options)
  if options.oriLv == options.nextLv then
    L_UI:close(self.pageName)
  end
  self.m_params = options
  self:refreshData()
  self:refreshDis()
end

function this:close()
  local mapStore = getMapStore()
  if mapStore then
    mapStore:setShowMapLvChangeTips(not self.bind.go_showNoMore)
  end
end

function this:refreshData()
  self.m_params.txtTitle = L_WordsTpl:getValue("world_difficulty_tip_title")
  local mapStore = getMapStore()
  local showTips = true
  if mapStore then
    showTips = mapStore:getShowMapLvChangeTips()
  end
  self.m_isNoMoreShow = not showTips
end

function this:refreshDis()
  self.modules.module_commonTipSmall:initModule(self.m_params)
  if self.m_params.oriLv == 5 or self.m_params.oriLv == 6 or self.m_params.oriLv == 7 then
    self.bindComponents.checkDescOri.enabled = true
    self.bindComponents.img_ori_sign.enabled = true
    self.bind.txtCheckDescOri = self:getLvDesc(self.m_params.oriLv)
    local _, oriColor = C_ColorUtility.TryParseHtmlString(txtCheckDescOri_Colors[self.m_params.oriLv])
    self.bindComponents.checkDescOri.LinearColor1 = oriColor
    local _, nextColor = C_ColorUtility.TryParseHtmlString(txtCheckDescOri_GradientColors[self.m_params.oriLv])
    self.bindComponents.checkDescOri.LinearColor2 = nextColor
    local _, oriColor01 = C_ColorUtility.TryParseHtmlString(imgSignColors[self.m_params.oriLv] .. "BF")
    self.bindComponents.img_ori_sign.LinearColor1 = oriColor01
    local _, nextColor01 = C_ColorUtility.TryParseHtmlString(imgSignGradientColors[self.m_params.oriLv] .. "BF")
    self.bindComponents.img_ori_sign.LinearColor2 = nextColor01
    local _, color001 = C_ColorUtility.TryParseHtmlString("#fffff")
    self.bindComponents.checkDescOri_stroke.style.outlineColor = color001
  else
    local _, signOriColor = C_ColorUtility.TryParseHtmlString(imgSignColors[self.m_params.oriLv] .. "BF")
    self.bind.img_sign_oriColor = signOriColor
    self.bindComponents.checkDescOri.enabled = false
    self.bindComponents.img_ori_sign.enabled = false
    self.bind.txtCheckDescOri = L_GameUtil.fillColor(self:getLvDesc(self.m_params.oriLv), txtCheckDescOri_Colors[self.m_params.oriLv])
    local _, color0001 = C_ColorUtility.TryParseHtmlString("#ebebeb")
    self.bindComponents.checkDescOri_stroke.style.outlineColor = color0001
  end
  if self.m_params.nextLv == 5 or self.m_params.nextLv == 6 or self.m_params.nextLv == 7 then
    self.bindComponents.checkDescOri_next.enabled = true
    self.bindComponents.img_next_sign.enabled = true
    self.bind.txtCheckDescNext = self:getLvDesc(self.m_params.nextLv)
    local _, oriColor2 = C_ColorUtility.TryParseHtmlString(txtCheckDescOri_Colors[self.m_params.nextLv])
    self.bindComponents.checkDescOri_next.LinearColor1 = oriColor2
    local _, nextColor02 = C_ColorUtility.TryParseHtmlString(txtCheckDescOri_GradientColors[self.m_params.nextLv])
    self.bindComponents.checkDescOri_next.LinearColor2 = nextColor02
    local _, oriColor02 = C_ColorUtility.TryParseHtmlString(imgSignColors[self.m_params.nextLv] .. "BF")
    self.bindComponents.img_next_sign.LinearColor1 = oriColor02
    local _, nextColor002 = C_ColorUtility.TryParseHtmlString(imgSignGradientColors[self.m_params.nextLv] .. "BF")
    self.bindComponents.img_next_sign.LinearColor2 = nextColor002
    local _, color002 = C_ColorUtility.TryParseHtmlString("#fffff")
    self.bindComponents.checkDescOri_next_stroke.style.outlineColor = color002
  else
    local _, signNextColor = C_ColorUtility.TryParseHtmlString(imgSignColors[self.m_params.nextLv] .. "BF")
    self.bind.img_sign_nextColor = signNextColor
    self.bindComponents.img_next_sign.enabled = false
    self.bindComponents.checkDescOri_next.enabled = false
    self.bind.txtCheckDescNext = L_GameUtil.fillColor(self:getLvDesc(self.m_params.nextLv), txtCheckDescOri_Colors[self.m_params.nextLv])
    local _, color0002 = C_ColorUtility.TryParseHtmlString("#ebebeb")
    self.bindComponents.checkDescOri_next_stroke.style.outlineColor = color0002
  end
  local tpl1 = _worldDifficultyCityTpl:getTplByMapIdAndLv(self.m_params.mapId, self.m_params.oriLv)
  if tpl1 == nil then
    error("地图等级:未找到数据" .. tostring(self.m_params.oriLv))
  else
    self.bind.txt_lv1 = L_Config:provider(tpl1.desc)
  end
  local tpl2 = _worldDifficultyCityTpl:getTplByMapIdAndLv(self.m_params.mapId, self.m_params.nextLv)
  if tpl2 == nil then
    error("地图等级:未找到数据" .. tostring(self.m_params.nextLv))
  else
    self.bind.txt_lv2 = L_Config:provider(tpl2.desc)
  end
  local isLvUp = self.m_params.oriLv < self.m_params.nextLv
  self.bind.txtCheckDesc2 = isLvUp and L_WordsTpl:getValue("ui_notice_world_difficulty_change1", {
    [0] = string.format("<color=#3266b4>%s </color>", txtCheckDesc2Names[1]),
    [1] = string.format("<color=#3266b4>%s</color>", txtCheckDesc2Names[1])
  }) or L_WordsTpl:getValue("ui_notice_world_difficulty_change1", {
    [0] = string.format("<color=#3266b4>%s </color>", txtCheckDesc2Names[2]),
    [1] = string.format("<color=#3266b4>%s</color>", txtCheckDesc2Names[2])
  })
  self.bind.go_showNoMore = self.m_isNoMoreShow
  local diffTipNotice = L_WordsTpl:getValue("world_difficulty_tip_notice")
  local cityName
  local truetpl = _worldAreaTpl:getTplById(self.m_params.areaId)
  if truetpl then
    local sceneId = _worldAreaTpl:getSceneId(truetpl)
    local id = _worldAreaTpl:getId(truetpl)
    local areaData = _areaTpl:getConfig()
    local set = false
    for i, v in ipairs(areaData) do
      if _areaTpl:getWorldAreaId(v) == id and _areaTpl:getSceneId(v) == sceneId then
        cityName = _areaTpl:getAreaName(v)
        set = true
        break
      end
    end
    if not set then
      cityName = _worldAreaTpl:getName(truetpl)
    end
  else
    local tempWorldCityTpl = _worldCityTpl:getTplById(self.m_params.mapId)
    cityName = _worldCityTpl:getCity(tempWorldCityTpl)
  end
  self.bind.txtTitle = string.format(diffTipNotice, cityName)
  self.bind.txtTitle = cityName
  self.bind.img_lev1 = string.format(path_img_lv, self.m_params.oriLv)
  self.bind.img_lev2 = string.format(path_img_lv, self.m_params.nextLv)
  self.bind.img_lvIcon = string.format(path_img_levelIcon, self.m_params.oriLv)
  self.bind.img_next_lvIcon = string.format(path_img_levelIcon, self.m_params.nextLv)
  self.bind.img_next_circleLine = string.format(path_img_nextlv_circleLine, self.m_params.nextLv)
  local _, lineColor = C_ColorUtility.TryParseHtmlString(nextLvLine_Colors[self.m_params.nextLv])
  self.bind.img_next_lineColor = lineColor
end

function this:getLvDesc(level)
  local tpl = _worldDifficultyCityTpl:getTplByMapIdAndLv(self.m_params.mapId, level)
  if tpl == nil then
    return ""
  end
  local txtDesc = L_Config:provider(tpl.name)
  local txtLv = L_Config:provider(tpl.desc)
  return txtDesc
end

return this
