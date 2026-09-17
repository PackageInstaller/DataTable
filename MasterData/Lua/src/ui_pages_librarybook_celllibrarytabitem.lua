local this = class("cellLibraryTabItem", G_UIModuleBase)
local _libraryBranchTpl = L_GameTpl:getLibraryBranchTpl()
local _librarySeriesTpl = L_GameTpl:getLibrarySeriesTpl()

function this.bind()
  return {
    txtBookGroupName = "",
    txtProcress = "",
    txtUnSle = "",
    tfmSelected = false,
    tfmUnSelected = true,
    active_selection = false,
    active_UnSelc = false,
    active_lineF = false,
    active_lineB = false
  }
end

function this.methods()
  return {
    onClick = function(self)
      if self.bind.callback then
        self.bind.callback(self)
      end
    end
  }
end

function this:open()
  self:refreshView()
end

function this:refreshView()
  local tpl = _libraryBranchTpl:getTplById(self.bind.id)
  local totalNum = 0
  for k, v in pairs(tpl.seriesId) do
    local tempTpl = _librarySeriesTpl:getTplById(v)
    if tempTpl ~= nil then
      totalNum = totalNum + #tempTpl.subId
    else
      warn("书籍：地区中的书籍未全部在series中配置" .. v)
    end
  end
  local collectedNum = 0
  for k, v in pairs(tpl.seriesId) do
    local tempTpl = _librarySeriesTpl:getTplById(v)
    if tempTpl ~= nil then
      for k2, v2 in pairs(tempTpl.subId) do
        for k3, v3 in pairs(L_LibraryBookStore.data.itemDic) do
          if v2 == v3.itemId then
            collectedNum = collectedNum + 1
            break
          end
        end
      end
    else
      warn("书籍：地区中的书籍未全部在series中配置" .. v)
    end
  end
  self.bind.txtBookGroupName = _libraryBranchTpl:getName(tpl)
  self.bind.txtUnSle = _libraryBranchTpl:getName(tpl)
end

function this:setSelected(isSelected)
  self.bind.tfmSelected = isSelected
  self.bind.tfmUnSelected = not isSelected
  self.bind.active_selection = isSelected
  self.bind.active_UnSelc = not isSelected
  if self.bind.isFirst == false then
    self.bind.active_lineF = not isSelected
  end
  if self.bind.isLast == false then
    self.bind.active_lineB = not isSelected
  end
end

return this
