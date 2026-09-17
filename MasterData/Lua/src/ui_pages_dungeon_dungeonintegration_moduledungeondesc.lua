local this = class("moduleDungeonDesc", G_UIModuleBase)
local _dungeonExpTpl = L_GameTpl:getDungeonExpTpl()
local _dungeonTpl = L_GameTpl:getDungeonTpl()

function this.bind()
  return {
    list_cellDungeonDescCard = {
      moduleName = "pages/dungeon/dungeonIntegration/cellDungeonDescCard"
    }
  }
end

function this.methods()
  return {}
end

function this:initParent(parent)
  self.parent = parent
end

function this:initData(chooseDoorIds)
  local cellDungeonDescCardEmptyList = {}
  if chooseDoorIds then
    for i = 1, #chooseDoorIds do
      local doorId = chooseDoorIds[i]
      local dungeonConfig = _dungeonTpl:getTplListByDoorId(doorId)
      local dungeonTpl
      for groupId, tplList in pairs(dungeonConfig) do
        dungeonTpl = tplList[1]
      end
      if not dungeonTpl then
        errorf(string.format("moduleDungeonDesc:initData 参数错误 doorId:%s", doorId))
        return
      end
      table.insert(cellDungeonDescCardEmptyList, {
        viewIndex = i,
        doorId = doorId,
        doorName = _dungeonTpl:getName(dungeonTpl)
      })
    end
  else
    local dungeonExpTplList = _dungeonExpTpl:getTplList()
    local viewIndex = 1
    for k, tpl in pairs(dungeonExpTplList) do
      table.insert(cellDungeonDescCardEmptyList, {
        viewIndex = viewIndex,
        doorId = _dungeonExpTpl:getDungeonDoorId(tpl),
        doorName = _dungeonExpTpl:getDungeonName(tpl),
        img_icon = _dungeonExpTpl:getDungeonIcon(tpl)
      })
    end
  end
  self.bind.list_cellDungeonDescCard:clear()
  self.bind.list_cellDungeonDescCard:insert_array(cellDungeonDescCardEmptyList)
  for i = 1, #self.bind.list_cellDungeonDescCard do
    local cellDungeonDescCard = self.bind.list_cellDungeonDescCard:getItemCls(i)
    cellDungeonDescCard:initParent(self)
  end
end

function this:initUI()
  for i = 1, #self.bind.list_cellDungeonDescCard do
    local cellDungeonDescCard = self.bind.list_cellDungeonDescCard:getItemCls(i)
    cellDungeonDescCard:refreshUI(false)
  end
end

function this:initFirstClick()
  local cellDungeonDescCard = self.bind.list_cellDungeonDescCard:getItemCls(1)
  cellDungeonDescCard:onClickDungeonDescCard()
end

function this:onClickDungeonDescCard(doorId)
  for i = 1, #self.bind.list_cellDungeonDescCard do
    local cellDungeonDescCard = self.bind.list_cellDungeonDescCard:getItemCls(i)
    cellDungeonDescCard:refreshUI(cellDungeonDescCard:getDoorId() == doorId)
  end
  self.parent:onClickDungeonDescCard(doorId)
end

function this:showSelf()
  self.bind.active_self = true
end

function this:hideSelf()
  self.bind.active_self = false
end

return this
