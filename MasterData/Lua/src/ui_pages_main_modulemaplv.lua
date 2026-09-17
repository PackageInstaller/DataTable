local this = class("moduleMapLv", G_UIModuleBase)

local function getMapStore()
  return C_MapManager:GetMapStore()
end

local _worldDifficultyCityTpl = L_GameTpl:getWorldDifficultyCityTpl()
local _wordTpl = L_GameTpl:getWordsTpl()
local path_img_lv = "UI/Atlas/Map/tex_mapLv_word_nd0%d.png"

function this.bind()
  return {
    goRoot = false,
    txtDesc = "",
    txtLv = "",
    listTab = {
      moduleName = "pages/main/cellMapLv"
    },
    goReddot = false,
    goList = false,
    img_lv = "",
    active_arrow_on = false,
    active_arrow_off = false
  }
end

function this.methods()
  return {
    onClickDumpList = function(self)
      self.m_isOpening = not self.m_isOpening
      if self.m_isOpening then
        C_AudioManager.Play("Play_SFX_System_UI_General_Drop_Open")
      else
        C_AudioManager.Play("Play_SFX_System_UI_General_Drop_Close")
      end
      self:refreshData()
      self:refreshSelected()
      self:refreshOpening()
    end
  }
end

function this:close()
  L_WorldMapLvStore:unListenCallFunc(L_WorldMapLvStore.event.refreshDeddot, self.refreshCellReddot, self)
end

function this:RefreshByMapId(mapId, areaId)
  self.m_mapId = mapId
  self.areaId = areaId
  self:initData()
  self:refreshInfo()
end

function this:initData()
  self.m_selectedLv = 0
  self.m_isOpening = false
  if self.m_mapId == nil then
    return
  end
  self:refreshData()
end

function this:refreshData()
  self.m_selectedLv = 0
  local tpls = _worldDifficultyCityTpl:getTplsByMapId(self.m_mapId)
  if tpls == nil then
    self.bind.goRoot = false
    return
  end
  self.m_selectedLv = L_WorldMapLvStore:getNowLevel(self.m_mapId)
end

function this:initList()
  self.bind.listTab:clear()
  self:refreshInfo()
end

function this:refreshInfo()
  L_WorldMapLvStore:listenCallFunc(L_WorldMapLvStore.event.refreshDeddot, self.refreshCellReddot, self)
  local tpls = _worldDifficultyCityTpl:getTplsByMapId(self.m_mapId)
  local mapLvInfo = L_WorldMapLvStore:getInfoByMapId(self.m_mapId)
  if tpls == nil then
    self.bind.goRoot = false
    return
  end
  local dataList = {}
  for i, tpl in pairs(tpls) do
    table.insert(dataList, {
      index = i,
      isLast = i == #tpls,
      selectedLv = self.m_selectedLv,
      tpl = tpl,
      isReddotFinish = mapLvInfo ~= nil and mapLvInfo.reddotFinished ~= nil and table.containsValue(mapLvInfo.reddotFinished, tpl.difficultLv),
      callback = function(cell)
        self:onCellClick(cell)
      end
    })
  end
  table.sort(dataList, function(a, b)
    return a.index < b.index
  end)
  self.bind.goRoot = true
  self.bind.listTab:insert_array(dataList)
  self:refreshOpening()
  self:refreshSelected()
  self:refreshReddot()
end

function this:refreshOpening()
  local opening = self.m_isOpening ~= nil and self.m_isOpening
  self.bind.goList = opening
  self.bind.active_arrow_on = opening
  self.bind.active_arrow_off = opening == false
  FrameScheduler.add(function()
    Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.content)
  end)
  self:refreshReddot()
end

function this:refreshCellReddot()
  local tpls = _worldDifficultyCityTpl:getTplsByMapId(self.m_mapId)
  local mapLvInfo = L_WorldMapLvStore:getInfoByMapId(self.m_mapId)
  if tpls == nil then
    return
  end
  for i, tpl in ipairs(tpls) do
    local isReddotFinish = mapLvInfo ~= nil and mapLvInfo.reddotFinished ~= nil and table.containsValue(mapLvInfo.reddotFinished, tpl.difficultLv)
    self.modules.listTab[i]:setReddotFinish(isReddotFinish)
  end
end

function this:refreshSelected()
  for i, v in pairs(self.modules.listTab) do
    v:setSelected(self.m_selectedLv)
  end
  local tpl = _worldDifficultyCityTpl:getTplByMapIdAndLv(self.m_mapId, self.m_selectedLv)
  if tpl == nil then
    return
  end
  self.bind.txtDesc = L_Config:provider(tpl.name)
  self.bind.txtLv = L_Config:provider(tpl.desc)
  local path_img_lv = "UI/Atlas/Common/tex_mapLv_word_nd0%d.png"
  self.bind.img_lv = string.format(path_img_lv, self.m_selectedLv)
  L_WorldMapLvStore:req_worldMapReddot(self.m_mapId, self.m_selectedLv)
end

function this:onCellClick(cell)
  if L_BattleDataManager:checkPlayerBattle() then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.MapWorldLv))
    return
  end
  
  local function _confirmCb()
    self.m_selectedLv = cell.bind.tpl.difficultLv
    self:refreshSelected()
    self:refreshReddot()
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("world_difficulty_change_complete"))
  end
  
  local mapStore = getMapStore()
  local showTips = true
  if mapStore then
    showTips = mapStore:getShowMapLvChangeTips()
  end
  if showTips then
    local confirmCbHandler = handler(self, _confirmCb)
    local options = {
      confirmCb = confirmCbHandler,
      oriLv = self.m_selectedLv,
      nextLv = cell.bind.tpl.difficultLv,
      mapId = self.m_mapId,
      areaId = self.areaId
    }
    L_UI:open("pageWorldMapLv", options)
  else
    local function cb(a, errCode)
      if errCode == L_Const.errorCode.ErrCodeSucc then
        _confirmCb()
      end
    end
    
    L_WorldMapLvStore:req_worldMapLevel(self.m_mapId, cell.bind.tpl.difficultLv, cb)
  end
end

function this:refreshReddot()
  local tpls = _worldDifficultyCityTpl:getTplsByMapId(self.m_mapId)
  local mapLvInfo = L_WorldMapLvStore:getInfoByMapId(self.m_mapId)
  self.bind.goReddot = false
  if tpls == nil or self.m_isOpening then
    return
  end
  for i, tpl in ipairs(tpls) do
    local isComplete = L_ConditionManager:isComplete(tpl.condition)
    local isReddotFinish = mapLvInfo ~= nil and mapLvInfo.reddotFinished ~= nil and table.containsValue(mapLvInfo.reddotFinished, tpl.difficultLv)
    if isComplete and not isReddotFinish then
      self.bind.goReddot = true
      return
    end
  end
end

return this
