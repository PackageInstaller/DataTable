local this = class("moduleRandomDungeonMap", G_UIModuleBase)
local _dungeonRandomTpl = L_GameTpl:getDungeonRandomTpl()
local PATH = "UI/Texture/MiniMap/RandomDungeon"
local blockLength = 200
local bossRoomLength = 400

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {curRandomDungeonId = nil}
end

function this.bind()
  return {
    scrollList_block = {
      moduleName = "pages/Dungeon/cellDungeonMapBlock"
    },
    img_bossRoom = "",
    localPos_bossRoom = L_Vector3.zero,
    localRot_bossRoom = L_Vector3.zero
  }
end

function this.methods()
  return {}
end

function this:open(options)
  this.super.open(self, options)
end

function this:close(options)
  this.super.close(self, options)
end

function this:initModule(randomDungeonId)
  self.data.curRandomDungeonId = randomDungeonId
  self:initMainBlock()
  self:initBossRoom()
end

function this:initMainBlock()
  local tmp = {}
  local tpl = _dungeonRandomTpl:getTplById(self.data.curRandomDungeonId)
  local pathGroup = _dungeonRandomTpl:getPathGroup(tpl)
  local pathPrefab = _dungeonRandomTpl:getPathPrefab(tpl)
  local pathPrefabIndex = 1
  for i, v in ipairs(pathGroup) do
    if not math.isEmpty(v) then
      local index = i - 1
      local path = string.format("%s/tex_%s.png", PATH, pathPrefab[pathPrefabIndex])
      local posX = index % 4
      local posY = math.floor(index / 4)
      pathPrefabIndex = pathPrefabIndex + 1
      table.insert(tmp, {
        img_road = path,
        localPos_road = L_Vector3.new((posX - 1.5) * blockLength, (1.5 - posY) * blockLength, 0),
        localRot_road = self:getRotateEulerAngle(v)
      })
    end
  end
  self.bind.scrollList_block:clear()
  self.bind.scrollList_block:insert_array(tmp)
end

function this:initBossRoom()
  local tpl = _dungeonRandomTpl:getTplById(self.data.curRandomDungeonId)
  local roadEnd = _dungeonRandomTpl:getRoadEnd(tpl)
  local bossRoomDir = _dungeonRandomTpl:getBossRoomDir(tpl)
  local bossRoomPrefab = _dungeonRandomTpl:getBossRoomPrefab(tpl)
  if not math.isEmpty(bossRoomDir) then
    self.bind.img_bossRoom = string.format("%s/tex_%s.png", PATH, bossRoomPrefab)
    local posX = roadEnd % 4
    local posY = math.floor(roadEnd / 4)
    local dif = self:getBossRoomPosDif(bossRoomDir)
    self.bind.localPos_bossRoom = L_Vector3.new((posX - 1.5) * blockLength + dif.x, (1.5 - posY) * blockLength + dif.y, 0)
    self.bind.localRot_bossRoom = self:getBossRoomRotateEulerAngle(bossRoomDir)
  end
end

function this:getRotateEulerAngle(road)
  if road == 2 or road == 6 or road == 14 or road == 10 then
    return L_Vector3.new(0, 0, 90)
  elseif road == 4 or road == 12 or road == 13 then
    return L_Vector3.new(0, 0, 180)
  elseif road == 8 or road == 9 or road == 11 then
    return L_Vector3.new(0, 0, -90)
  end
  return L_Vector3.zero
end

function this:getBossRoomPosDif(bossRoomDir)
  local dif = 1.5 * blockLength
  if bossRoomDir == 1 then
    return L_Vector3.new(-dif, 0, 0)
  elseif bossRoomDir == 2 then
    return L_Vector3.new(0, -dif, 0)
  elseif bossRoomDir == 4 then
    return L_Vector3.new(dif, 0, 0)
  elseif bossRoomDir == 8 then
    return L_Vector3.new(0, dif, 0)
  end
  return L_Vector3.zero
end

function this:getBossRoomRotateEulerAngle(bossRoomDir)
  if bossRoomDir == 1 then
    return L_Vector3.new(0, 0, 180)
  elseif bossRoomDir == 2 then
    return L_Vector3.new(0, 0, -90)
  elseif bossRoomDir == 4 then
    return L_Vector3.new(0, 0, 0)
  elseif bossRoomDir == 8 then
    return L_Vector3.new(0, 0, 90)
  end
  return L_Vector3.zero
end

return this
