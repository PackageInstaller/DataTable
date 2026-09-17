local this = class("home_level_shell", G_BaseConfig)
local core = G_Tables.TDHomeLevelTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {
  id = 0,
  exp = 1,
  dropId = 2,
  level_reward = 3,
  home_field_max = 4,
  home_good_field_max = 5,
  worker_max = 6,
  dispatch_worker_max = 7,
  pasture_woker_max = 8,
  table_food_max = 9,
  home_task_id = 10,
  level_icon = 11,
  level_color = 12,
  unlockCropUpgrade = 13
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getExp(offset)
  return core:GetInt(offset, this.indexMap.exp)
end

function this:_getDropid(offset)
  return core:GetInt(offset, this.indexMap.dropId)
end

function this:_getLevel_reward(offset)
  local str = core:GetVString(offset, this.indexMap.level_reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getHome_field_max(offset)
  return core:GetInt(offset, this.indexMap.home_field_max)
end

function this:_getHome_good_field_max(offset)
  return core:GetInt(offset, this.indexMap.home_good_field_max)
end

function this:_getWorker_max(offset)
  return core:GetInt(offset, this.indexMap.worker_max)
end

function this:_getDispatch_worker_max(offset)
  return core:GetInt(offset, this.indexMap.dispatch_worker_max)
end

function this:_getPasture_woker_max(offset)
  return core:GetInt(offset, this.indexMap.pasture_woker_max)
end

function this:_getTable_food_max(offset)
  return core:GetInt(offset, this.indexMap.table_food_max)
end

function this:_getHome_task_id(offset)
  return core:GetInt(offset, this.indexMap.home_task_id)
end

function this:_getLevel_icon(offset)
  local str = core:GetVString(offset, this.indexMap.level_icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getLevel_color(offset)
  return core:GetVString(offset, this.indexMap.level_color).value
end

function this:_getUnlockcropupgrade(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCropUpgrade).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  exp = this._getExp,
  dropId = this._getDropid,
  level_reward = this._getLevel_reward,
  home_field_max = this._getHome_field_max,
  home_good_field_max = this._getHome_good_field_max,
  worker_max = this._getWorker_max,
  dispatch_worker_max = this._getDispatch_worker_max,
  pasture_woker_max = this._getPasture_woker_max,
  table_food_max = this._getTable_food_max,
  home_task_id = this._getHome_task_id,
  level_icon = this._getLevel_icon,
  level_color = this._getLevel_color,
  unlockCropUpgrade = this._getUnlockcropupgrade
}
return this
