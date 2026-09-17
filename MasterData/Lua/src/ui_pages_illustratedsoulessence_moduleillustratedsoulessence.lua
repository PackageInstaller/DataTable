local this = class("moduleIllustratedSoulEssence", G_UIModuleBase)
local soulessenceTpl = L_GameTpl:getSoulessenceTpl()

function this.bind()
  return {
    soulEssenceCardItem = {
      moduleName = "pages/SoulEssence/cellSoulEssenceCardItem"
    },
    module_sortFilter = L_Const.ModuleInfo.SortFilterModule,
    soulessenceList = L_Const.ModuleInfo.CellBasicItem,
    moduleSoulEssenceBasicInfo = {
      moduleName = "pages/illustratedSoulEssence/moduleSoulEssenceBasicInfo"
    },
    moduleListExpand = {
      moduleName = "pages/illustratedSoulEssence/moduleSoulEssenceListExpand"
    }
  }
end

function this.methods()
  return {
    onClickClose = function(self)
      self:onClick_close()
    end,
    onClickExpand = function(self)
      self.modules.moduleListExpand:SetActive(true)
    end
  }
end

function this:initPage()
  self.isClose = false
  self.closeFunc = nil
  self._selectItemId = nil
  self._selectCell = nil
  self:initSortFilter()
  self:initSoulessenceList()
  self:refreshSelectSoulEssenceUI()
  self:initSoulEssenceListExpand()
end

function this:open()
  self.isClose = false
  C_IntegrateMgr.TopBarModule:SetTopBarBackName("灵子图鉴")
end

function this:setCloseFunc(closeFunc)
  self.closeFunc = closeFunc
end

function this:initSoulEssenceListExpand()
  if table.isEmpty(self._soulEssenceDatas) then
    return
  end
  self.modules.moduleListExpand:initModuleData(self._soulEssenceDatas, function(itemId)
    self:setSelectSoulessence(itemId)
  end)
  self.modules.moduleListExpand:SetActive(false)
end

function this:initSortFilter()
  if self._sortFilter then
    return
  end
  
  local function callback()
    self._selectCell = nil
    self:updateSortSoulEssenceList()
    self:refreshSoulessenceList()
    self:refreshSelectSoulEssenceUI()
  end
  
  self._sortFilter = L_SortFilterManager:createSortFilter(L_SystemConst.enum.Librarysoulessence, callback, callback)
  self._sortFilter:bindModule(self.modules.module_sortFilter)
end

function this:updateSortSoulEssenceList()
  if not self._soulEssenceDatas then
    return
  end
  self._sortFilter:sortFilterList(self._soulEssenceDatas)
end

function this:initSoulessenceList()
  if not table.isEmpty(self._soulEssenceDatas) then
    return
  end
  local handbooksoulessences = soulessenceTpl:getHandbooksoulessences()
  local datas = {}
  
  local function _callback(cell)
    self:selectSoulessenceCell(cell)
  end
  
  local tpl
  for _, id in pairs(handbooksoulessences) do
    tpl = soulessenceTpl:getTplById(id)
    if tpl then
      table.insert(datas, {
        itemId = id,
        itemType = L_Const.resType.soulEssence,
        quality = soulessenceTpl:getRarity(tpl),
        level = 1,
        star = 1,
        bSel = self._selectItemId == id,
        customReddotKey = string.format(L_ReddotManager.DotDef.IllustratedSoulEssence_New, id),
        callback = _callback
      })
    end
  end
  self._sortFilter:sortFilterList(datas)
  if self._selectItemId == nil and 0 < #datas then
    self._selectItemId = datas[1].itemId
    datas[1].bSel = true
  end
  self._soulEssenceDatas = datas
  self:refreshSoulessenceList()
end

function this:selectSoulessenceCell(cell)
  self:setSelectSoulessence(cell:getItemId())
  self.modules.moduleListExpand:SetActive(false)
end

function this:setSelectSoulessence(itemId)
  self._selectItemId = itemId
  self._selectCell = nil
  self:refreshSoulessenceListSelect()
  self:refreshSelectSoulEssenceUI()
  L_ReddotManager:markNew(L_ReddotManager.DotDef.IllustratedSoulEssence_New, self._selectItemId)
end

function this:refreshSoulessenceListSelect()
  for i, cell in pairs(self.modules.soulessenceList) do
    if self._selectItemId == cell:getItemId() then
      cell:setSel(true)
    else
      cell:setSel(false)
    end
  end
end

function this:refreshSoulessenceList()
  if not self._soulEssenceDatas then
    return
  end
  self.bind.soulessenceList:clear()
  self.bind.soulessenceList:insert_array(self._soulEssenceDatas)
end

function this:refreshSelectSoulEssenceUI()
  if not self._selectItemId then
    return
  end
  local isCanView = C_SoulEssenceMgr:getHasSoulEssence(self._selectItemId)
  self.modules.soulEssenceCardItem:setId(self._selectItemId, true, isCanView)
  local data = {
    soulEssenceId = self._selectItemId,
    star = 1,
    level = 1,
    rank = 1
  }
  self.modules.moduleSoulEssenceBasicInfo:initModule(data)
end

function this:close(options)
  this.super.close(self, options)
  self._selectCell = nil
end

function this:escHandle()
  self:onClick_close()
end

function this:onClick_close()
  if self.isClose == true then
    return
  end
  if self.closeFunc then
    self.closeFunc()
  else
    L_UI:close(self.pageName)
  end
  self.isClose = true
end

return this
