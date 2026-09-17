local this = class("pageDisplayHero", G_UIPageBase)
local DisplayHeroCount = 3

function this.bind()
  return {
    list_display = {
      moduleName = "pages/playerCard/cellSlotDisplay"
    },
    module_selectHero = {
      moduleName = "modulePages/unit/moduleSelectHero"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_confirm = function(self)
      local data = {}
      for i, v in pairs(self._selectHero) do
        table.insert(data, {hero_id = v, pos = i})
      end
      L_PlayerStore:req_modifyDisplayHero(data, function()
        L_UI:close(self.pageName)
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_playercard_saved_success"))
      end)
    end,
    module_selectHero = {
      onClick_selectHero = this.onClick_selectHero
    },
    list_display = {
      onClick_select = this.onClick_select
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._selectHero = {}
  local displayHero = L_PlayerStore:getDisplayHero()
  for i, v in pairs(displayHero) do
    self._selectHero[i] = v.id
  end
  self._moduleSelectHero = self.modules.module_selectHero
  self._moduleSelectHero:initModule({
    systemId = L_SystemConst.enum.playerDisplayHero,
    ignoreState = true
  })
  self:refreshDisplayList(true)
  self:refreshHeroSelect()
end

function this:refreshDisplayList(isInit)
  local tmp = {}
  for i = 1, DisplayHeroCount do
    local dataSrc = {}
    if self._selectHero[i] then
      local hero = L_HeroStore:getHero(self._selectHero[i])
      dataSrc.guid = L_HeroStore:getHeroGuid(hero)
      dataSrc.configId = L_HeroStore:getHeroConfigId(hero)
      dataSrc.lv = L_HeroStore:getHeroLevel(hero)
      dataSrc.type = L_HeroStore:getHeroType(hero)
    end
    table.insert(tmp, {dataSrc = dataSrc, isEdit = true})
  end
  if isInit then
    self.bind.list_display:clear()
    self.bind.list_display:insert_array(tmp)
  else
    for i, v in pairs(self.modules.list_display) do
      local cell = v
      cell:refreshView(tmp[i])
    end
  end
end

function this:refreshHeroSelect()
  local selectList = {}
  for i, v in pairs(self._selectHero) do
    selectList[v] = {isSelect = true, index = i}
  end
  self._moduleSelectHero:setListSelect(selectList)
end

function this:onClick_selectHero(selectHeroId)
  local isSelect = true
  local focIndex = 0
  for i, v in pairs(self._selectHero) do
    if v == selectHeroId then
      isSelect = false
      focIndex = i
      break
    end
  end
  if isSelect then
    focIndex = self:getMinCanAddDisplayHeroPos()
  end
  if 0 < focIndex then
    self._selectHero[focIndex] = isSelect and selectHeroId or nil
  end
  self:refreshDisplayList()
  self:refreshHeroSelect()
end

function this:onClick_select(cell)
  if table.isEmpty(cell.dataSrc) then
    return
  end
  self:onClick_selectHero(cell.dataSrc.guid)
end

function this:getSelectHero()
  return self._selectHero or {}
end

function this:CSharpGetSortValue(heroGuid)
  local selectHeroList = self:getSelectHero()
  local result = table.keyOf(selectHeroList, heroGuid) or math.maxinteger
  return result
end

function this:getMinCanAddDisplayHeroPos()
  for i = 1, DisplayHeroCount do
    if not self._selectHero[i] then
      return i
    end
  end
  return 0
end

return this
