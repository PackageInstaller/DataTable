local module = class("moduleAchieveTabList", G_UIModuleBase)
local tabIconList = {
  "UI/Page/Achievement/tex_achievement_icon_inside_02",
  "UI/Page/Achievement/tex_achievement_icon_inside_03",
  "UI/Page/Achievement/tex_achievement_icon_inside_04",
  "UI/Page/Achievement/tex_achievement_icon_inside_05",
  "UI/Page/Achievement/tex_achievement_icon_inside_06"
}

function module.bind()
  return {
    selectTab = -1,
    list_tab = {
      moduleName = "pages/achievement/CellAchieveFirstDir"
    }
  }
end

function module.methods()
  return {
    onTabId = function(self, id)
      print("========================onTabID", id)
      if self._callback then
        self._callback(id)
      end
      Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.root)
    end
  }
end

function module:setData(idList, callback, selectId)
  self.bind.list_tab:clear()
  self._callback = callback
  if #idList <= 0 then
    return
  end
  local dataList = {}
  for i, id in ipairs(idList) do
    table.insert(dataList, {
      index = i,
      id = id,
      icon = tabIconList[i]
    })
  end
  self.bind.list_tab:insert_array(dataList)
  self.bind.selectTab = selectId
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.root)
end

function module:setSelectTabId(id)
  self.bind.selectTab = id
end

return module
