local page = class("pageWildBuffBuildUp", G_UIPageBase)
local tag = "page:pageWildBuffBuildUp"
local _homeCollectionWorldTpl = L_GameTpl:getHomeCollectionWorldTpl()
local _homeBuildingCollectionTpl = L_GameTpl:getHomeBuildingCollectionTpl()
local _homeBuildingBuffWorldTpl = L_GameTpl:getHomeBuildingBuffWorldTpl()
local _worldMapTpl = L_GameTpl:getWorldMapTpl()
local _worldSpawnerTpl = L_GameTpl:getWorldSpawnerTpl()

function page:created(obj, pageConfig)
  page.super.created(self, obj, pageConfig)
end

function page:preBind()
  return {}
end

function page:bind()
  return {
    txt_title = "",
    txt_content = "",
    txt_content_pos2 = C_Vector2(0, 0),
    active_scrollView = true,
    rl_item = L_Const.ModuleInfo.CellIconBag,
    btn_upLv_active = true
  }
end

function page:methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_mask = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_UpLv = function(self)
      self:_OnEventBtnUpLv()
    end
  }
end

function page:open(options)
  self._worldMapId = options.worldMapId
end

function page:show()
  self:_OnRefreshInfo()
end

function page:_OnRefreshInfo()
  if self._worldMapId == nil then
    return
  end
  self._wildBuffBuilding = AzurWorld.WorldMapMgr:GetWorldMapUnit(self._worldMapId)
  if self._wildBuffBuilding == nil then
    return
  end
  self._isMaxLevel = self._wildBuffBuilding:OnGetIsMaxLevel()
  self._curLevel = self._wildBuffBuilding:OnGetBuildLevel()
  local collectWorldId = self._wildBuffBuilding:OnGetCollectWorldId()
  local curBuffBuildId = self._wildBuffBuilding:OnGetBuffBuildId()
  local nextBuffBuildId = self._wildBuffBuilding:OnGetNextBuffBuildId()
  local collectionWorldTpl = _homeCollectionWorldTpl:getTplById(collectWorldId)
  local curBuffBuildTpl = _homeBuildingBuffWorldTpl:getTplById(curBuffBuildId)
  local curDescContent = _homeBuildingBuffWorldTpl:getCurBuffContent(curBuffBuildTpl)
  local content = L_WordsTpl:getValue("ui_home_building_buff_world_effect") .. tostring(curDescContent)
  self.bind.txt_title = L_WordsTpl:getValueParam("ui_home_building_buff_world_name", _homeCollectionWorldTpl:getName(collectionWorldTpl))
  if self._isMaxLevel then
    self.bind.txt_content_pos2 = C_Vector2(0, 0)
    self.bind.btn_upLv_active = false
    self.bind.active_scrollView = false
    self.bind.rl_item:clear()
  else
    local nextBuffBuildTpl = _homeBuildingBuffWorldTpl:getTplById(nextBuffBuildId)
    local nextDescContent = _homeBuildingBuffWorldTpl:getCurBuffContent(nextBuffBuildTpl)
    content = content .. tostring(nextDescContent) .. "\n"
    self.bind.txt_content_pos2 = C_Vector2(0, 34)
    self.bind.btn_upLv_active = true
    self.bind.active_scrollView = true
    local materialList = _homeBuildingBuffWorldTpl:getMaterial(nextBuffBuildTpl)
    local itemList = {}
    for i, v in pairs(materialList) do
      local itemType, itemId, ItemNum = v[1], v[2], v[3]
      local hasNum = L_ItemTplManager:getItemNum(itemType, itemId)
      local item = {
        itemType = itemType,
        itemId = itemId,
        itemNumTxt = string.format("%s/%s", L_GameUtil.fillColor(hasNum, ItemNum > hasNum and L_Const.colorHtml.red001 or L_Const.colorHtml.white001), v[3])
      }
      table.insert(itemList, item)
    end
    self.bind.rl_item:clear()
    self.bind.rl_item:insert_array(itemList)
  end
  self.bind.txt_content = content
end

function page:close()
  self._worldMapId = nil
end

function page:_OnEventBtnUpLv()
  if self._wildBuffBuilding == nil or self._isMaxLevel then
    return
  end
  self._wildBuffBuilding:OnReqUpBuffBuild()
  L_UI:close(self.pageName)
end

return page
