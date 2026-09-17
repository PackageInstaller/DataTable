local this = class("moduleSoulEssenceListExpand", G_UIModuleBase)
local soulessenceTpl = L_GameTpl:getSoulessenceTpl()

function this.bind()
  return {
    list_soulessence_expand = L_Const.ModuleInfo.CellBasicItem,
    module_sortFilter = L_Const.ModuleInfo.SortFilterModule
  }
end

function this.methods()
  return {
    onClickClose = function(self)
      self:onClick_close()
    end
  }
end

function this:initSortFilter()
  if self._sortFilter then
    return
  end
  
  local function callback()
    self:updateSortSoulEssenceList()
    self:refreshSoulessenceList()
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

function this:initModuleData(soulEssenceDatas, callback)
  self._soulEssenceDatas = table.clone(soulEssenceDatas)
  self._callback = callback
  self:initSortFilter()
  self:updateSortSoulEssenceList()
  self:refreshSoulessenceList()
end

function this:onClickSoulessenceCell(cell)
  if self._callback then
    self._callback(cell:getItemId())
  end
  self:SetActive(false)
end

function this:refreshSoulessenceList()
  if not self._soulEssenceDatas then
    return
  end
  self.bind.list_soulessence_expand:clear()
  self.bind.list_soulessence_expand:insert_array(self._soulEssenceDatas)
end

function this:onClick_close()
  self:SetActive(false)
end

function this:close(options)
  this.super.close(self, options)
  self._callback = nil
end

return this
