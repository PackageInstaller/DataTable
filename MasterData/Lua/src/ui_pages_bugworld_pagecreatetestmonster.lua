local this = class("pageCreateTestMonster", G_UIPageBase)

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
      self:refreshEnemyChoiceList(value)
    end,
    scrollChoiceEnemy = {
      onClick = function(self, bind)
        self:onClick_choiceEnemy(bind.id)
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
    curEnemyId = nil
  }
  self.bindComponents.input_choice_lv.text = "1"
  self:refreshEnemyChoiceList()
end

function this:refreshEnemyChoiceList(search)
  local enemyList = {}
  local insertList = {}
  local _enemyTpl = L_GameTpl:getEnemyTpl()
  enemyList = table.toArray(_enemyTpl.data)
  for i, v in ipairs(enemyList) do
    if v.isUsable == 1 then
      if string.isEmpty(search) then
        local item = {}
        item.id = _enemyTpl:getId(v)
        item.txt_name = _enemyTpl:getId(v) .. " - " .. _enemyTpl:getName(v)
        table.insert(insertList, item)
      else
        local item = {}
        item.id = _enemyTpl:getId(v)
        item.txt_name = _enemyTpl:getId(v) .. " - " .. _enemyTpl:getName(v)
        if string.find(item.txt_name, search) then
          table.insert(insertList, item)
        end
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
  AzurWorld.playerMgr.myPlayerUnitAdapter:RefreshKiBoTransformData(1, self.data.curEnemyId, tonumber(self.bindComponents.input_choice_lv.text))
  AzurWorld.playerMgr.myPlayerUnitAdapter:SwitchToKiBoTransformMainControl()
  L_UI:close(self.pageName)
end

function this:onClick_choiceEnemy(enemyId)
  if string.isEmpty(self.bindComponents.input_choice_lv.text) then
    errorf("填等级")
    return
  end
  self.data.curEnemyId = enemyId
end

return this
