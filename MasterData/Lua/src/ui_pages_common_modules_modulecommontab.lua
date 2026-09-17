local module = class("moduleCommonTab", G_UIModuleBase)

function module.bind()
  return {
    selectTab = -1,
    list_tab = {
      moduleName = "pages/common/modules/cellCommonTab"
    }
  }
end

function module.methods()
  return {
    onTabId = function(self, id)
      print("==================id", id)
      if self._callback then
        self._callback(id)
      end
      Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.root)
    end
  }
end

function module:initData(infoList, callback, selectId)
  self.bind.list_tab:clear()
  self._callback = nil
  if #infoList <= 0 then
    return
  end
  local dataList = {}
  for i, info in ipairs(infoList) do
    table.insert(dataList, {
      id = info.id,
      name = info.name or "",
      isShow = info.isNew or false,
      active_lock = info.active_lock or false,
      reddotKey = info.reddotKey or nil,
      itemCreateCall = info.itemCreateCall,
      isLast = i == #infoList
    })
  end
  self.bind.list_tab:insert_array(dataList)
  self._callback = callback
  self.bind.selectTab = infoList[selectId or 1].id
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.root)
end

function module:getItmById(id)
  for i = 1, #self.bind.list_tab do
    local cell = self.bind.list_tab:getItemCls(i)
    if cell.bind.id == id then
      return cell
    end
  end
  error("顶部切换页签：不存在ID为" .. tostring(id) .. "的cell")
  return nil
end

function module:refreshReddot(id, isShow)
  local cell = self:getItmById(id)
  if cell then
    cell:RefreshReddot(isShow)
  end
end

function module:getItmByIndex(index)
  local cell = self.bind.list_tab:getItemCls(index)
  if cell then
    return cell
  end
  error("顶部切换页签：不存在ID为" .. tostring(index) .. "的cell")
  return nil
end

function module:setSelectTabId(id)
  self.bind.selectTab = id
end

function module:setWillSelectTab(handler)
  if not self.gameObject then
    return
  end
  local tabGroup = self.gameObject:GetComponentInChildren(typeof(C_LTabGroup))
  if not L_CommonUtil.isValid(tabGroup) then
    return
  end
  if not handler then
    tabGroup:SetWillSelectTabById(nil)
    return
  end
  tabGroup:SetWillSelectTabById(function(tabId)
    return handler(tabId) and true or false
  end)
end

function module:customHide()
  if self.bindComponents and self.bindComponents.anim then
    self.bindComponents.anim:Play("anim_common_toptab_cell_out")
  end
end

function module:customShow()
  if self.bindComponents and self.bindComponents.anim then
    self.bindComponents.anim:Play("anim_common_toptab_cell_in")
  end
end

function module:close()
end

return module
