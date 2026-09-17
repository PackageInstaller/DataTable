local this = class("pageTestCreatePet", G_UIPageBase)

function this.bind()
  return {
    scrollChoiceEnemy = {
      moduleName = "pages/bugWorld/cellItem/cellTestClickItem"
    }
  }
end

function this.methods()
  return {
    onClick_nowBattle = function(self)
      self:onClick_nowBattle()
    end,
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onValueChangedsearch = function(self, value)
      self:refreshPetChoiceList(value)
    end,
    scrollChoiceEnemy = {
      onClick = function(self, bind)
        self:onClick_choicePet(bind.id)
      end
    }
  }
end

function this:ctor()
  this.super.ctor(self)
end

function this:open(options)
  this.super.open(self, options)
  self.data = {
    enemyList = {},
    curPetId = nil
  }
  self:refreshPetChoiceList()
end

function this:refreshPetChoiceList(search)
  local petList = {}
  local insertList = {}
  local _petTpl = L_GameTpl:getPetTpl()
  petList = table.toArray(_petTpl.data)
  for i, v in ipairs(petList) do
    if string.isEmpty(search) then
      local item = {}
      item.id = _petTpl:getId(v)
      item.txt_name = _petTpl:getId(v) .. " - " .. _petTpl:getName(v)
      table.insert(insertList, item)
    else
      local item = {}
      item.id = _petTpl:getId(v)
      item.txt_name = _petTpl:getId(v) .. " - " .. _petTpl:getName(v)
      if string.find(item.txt_name, search) then
        table.insert(insertList, item)
      end
    end
  end
  self.bind.scrollChoiceEnemy:clear()
  self.bind.scrollChoiceEnemy:insert_array(insertList)
end

function this:close(options)
  this.super.close(self, options)
end

function this:onClick_nowBattle()
  L_UI:close(self.pageName)
  AzurWorld.playerMgr.myPlayerUnitAdapter:SwitchToKiBoMainControl(self.data.curPetId)
end

function this:onClick_choicePet(enemyId)
  self.data.curPetId = enemyId
end

return this
