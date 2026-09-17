local this = class("pageSelectPetDisplay", G_UIPageBase)
local petsLimit = 4

function this.bind()
  return {
    modulePetSelect = {
      moduleName = "modulePages/unit/moduleDisplaySelectPet"
    },
    list_petsDisplay = {
      moduleName = "pages/playerCard/cellPlayerCardPetPixelDisplay"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_confirm = function(self)
      self:save()
    end,
    modulePetSelect = {
      onClick_selectPet = function(self, petGuid)
        self:onSelect_pet(petGuid)
      end
    },
    list_petsDisplay = {
      onClick_selectCell = function(self, cell)
        local isEmpty = math.isEmpty(cell.guid) or cell.guid == -1 or cell.guid == 0
        if isEmpty then
          return
        end
        self:onSelect_pet(cell.guid)
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._moduleSelectPet = self.modules.modulePetSelect
  self.petsList = {}
  self:initPetsDisplay()
  self._moduleSelectPet:initModule({
    systemId = L_SystemConst.enum.petDisplay,
    cellType = L_Const.cellIconUnitType.others,
    editMode = true
  })
  self:refreshDisplayList()
end

function this:show()
  for i, v in pairs(self.modules.list_petsDisplay) do
    v:refresh()
  end
end

function this:initPetsDisplay()
  local baseInfo = L_PlayerStore:getPlayerBaseInfo()
  local allPetInfo = L_FriendStore:getPlayerDisplayPet(baseInfo)
  local datas = {}
  for _, v in pairs(allPetInfo) do
    local pos = v.pos
    if pos <= petsLimit then
      local temp = {
        isActive_panelNone = false,
        isActive_panelSel = true,
        guid = v.guid,
        isActive_master = false
      }
      datas[pos] = temp
      self.petsList[pos] = v.guid
    end
  end
  for i = 1, petsLimit do
    if self.petsList[i] == nil then
      local empty = {
        isActive_panelNone = true,
        isActive_panelSel = false,
        isActive_master = false
      }
      datas[i] = empty
      self.petsList[i] = -1
    end
    datas[i].isActive_nextLine = i < petsLimit
  end
  self.bind.list_petsDisplay:clear()
  self.bind.list_petsDisplay:insert_array(datas)
end

function this:onSelect_pet(petGuid)
  local selGuid = petGuid
  local del = false
  local delIndex = -1
  for i, v in pairs(self.petsList) do
    local guid = v
    if selGuid == guid then
      del = true
      delIndex = i
      break
    end
  end
  if del then
    self.petsList[delIndex] = -1
  else
    for i = 1, petsLimit do
      if self.petsList[i] == -1 then
        self.petsList[i] = selGuid
        break
      end
    end
  end
  self:refreshDisplayList()
end

function this:refreshDisplayList()
  for i = 1, #self.modules.list_petsDisplay do
    local module = self.modules.list_petsDisplay[i]
    local guid = module.bind.guid
    if guid ~= self.petsList[i] then
      if self.petsList[i] ~= -1 then
        self.bind.list_petsDisplay:change(i, {
          guid = self.petsList[i],
          isActive_panelNone = false,
          isActive_panelSel = true,
          isActive_master = false
        })
      else
        self.bind.list_petsDisplay:change(i, {
          guid = -1,
          isActive_panelNone = true,
          isActive_panelSel = false
        })
      end
    end
  end
  local selectDic = {}
  for i, v in pairs(self.petsList) do
    if v and 0 < v then
      selectDic[v] = {isSelect = true, index = i}
    end
  end
  self._moduleSelectPet:setListSelect(selectDic)
end

function this:save()
  local data = {}
  for i, v in pairs(self.petsList) do
    if v ~= -1 then
      table.insert(data, {pet_guid = v, pos = i})
    end
  end
  L_PlayerStore:req_modifyDisplayPet(data, function()
    L_UI:close(self.pageName)
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_playercard_saved_success"))
  end)
end

return this
