local vec3 = require("base.vec3")
local newVec = vec3.New
local Unity = CS.UnityEngine
local behaviorBase = {}
behaviorBase.__index = behaviorBase
behaviorBase.behaviorBase = behaviorBase

function behaviorBase.setUp(behaviorBase)
  local behaviorBase = behaviorBase
  behaviorBase.tool = ComnMgr.ToolBase
end

function behaviorBase.new(base, npc, fileId, npcScope, globalScope)
  local behavior = setmetatable({}, base)
  behavior.file_id = fileId
  behavior.module = base
  behavior.behaviorBase = behaviorBase
  behavior.base = behaviorBase
  behavior.npc = npc
  behavior.isInitOver = false
  behavior:add_to_inst_list()
  behavior:_init(npc)
  return behavior
end

function behaviorBase.now(behavior)
  return get_npc_time(behavior.npc)
end

function behaviorBase.isInStatus(behavior, ...)
  local npc = behavior.npc
  local check = check_npc_status
  local status
  for i = 1, select("#", ...) do
    status = select(i, ...)
    if check(npc, status) then
      return true
    end
  end
  return false
end

function behaviorBase.add_to_inst_list(behavior)
  local npc = behavior.npc
  local base = getmetatable(behavior)
  local behaviorBase = behaviorBase
  local instList, getInstList
  for _ = 1, 10 do
    if not base or base == behaviorBase then
      return
    else
      getInstList = base.getAllInst
      if not getInstList then
      else
        instList = getInstList(base)
        instList[behavior] = npc
        base.instNum = base:getInstNum() + 1
      end
      base = getmetatable(base)
    end
  end
  return behavior:debugOutput("父类层级超过10层")
end

function behaviorBase.remove_from_inst_list(behavior)
  local npc = behavior.npc
  local base = getmetatable(behavior)
  local behaviorBase = behaviorBase
  local instList, getInstList
  for _ = 1, 10 do
    if not base or base == behaviorBase then
      return
    else
      getInstList = base.getAllInst
      if not getInstList then
      else
        instList = getInstList(base)
        instList[behavior] = nil
        base.instNum = base:getInstNum() - 1
        if base.instNum < 0 then
          base.instNum = 0
          base:debugOutput("behaviorBase.remove_from_inst_list is called and base.instNum is decreased to negative")
        end
      end
      base = getmetatable(base)
    end
  end
  return behavior:debugOutput("父类层级超过10层")
end

function behaviorBase.on_remove(behavior)
  behavior:remove_from_inst_list()
end

function behaviorBase.isInst(obj)
  return obj.npc and obj.file_id
end

function behaviorBase.getModule(obj)
  return obj:isInst() and obj.module or obj
end

function behaviorBase.getAllInst(behavior)
  local module = behavior:getModule()
  local instList = module.instList
  if not instList then
    instList = {}
    module.instList = instList
  end
  return instList
end

function behaviorBase.getInstNum(behavior)
  local module = behavior:getModule()
  local num = module.instNum
  if not num then
    module.instNum = 0
    return 0
  end
  return num
end

function behaviorBase.addBornLogic(base, func, canRepeat, ...)
  if base.file_id and base.module then
    base = base.module
  end
  base:call_func_to_module(func, ...)
  local list = base._born_logics
  if not list then
    list = {}
    base._born_logics = list
  end
  if not canRepeat and list[func] then
    return
  end
  local info = {
    ...
  }
  info.func = func
  table.insert(list, info)
  list[func] = true
end

function behaviorBase.call_func_to_module(base, func, ...)
  if base.file_id and base.module then
    base = base.module
  end
  local instList = base.instList
  if not instList then
    return
  end
  for behavior, _ in pairs(instList) do
    if behavior.isInitOver then
      func(behavior, ...)
    end
  end
end

function behaviorBase.on_start(behavior)
  behavior.isInitOver = true
  local bornFuncList = behavior.module._born_logics
  if not bornFuncList then
    return
  end
  for _, info in ipairs(bornFuncList) do
    info.func(behavior, table.unpack(info))
  end
end

function behaviorBase.checkMagic(behavior, magicId)
  return check_magic(behavior.npc, magicId)
end

function behaviorBase.addMagic(behavior, magicId, lv, caster, num)
  if not magicId then
    return
  end
  if num and num <= 0 then
    return
  end
  caster = caster or behavior.npc
  return cast_magic(caster, behavior.npc, magicId, lv, num)
end

function behaviorBase.addMagics(behavior, ...)
  local npc = behavior.npc
  local magic
  for i = 1, select("#", ...) do
    magic = select(i, ...)
    cast_magic(npc, npc, magic)
  end
end

function behaviorBase.abortMagic(behavior, magicId, num)
  if not magicId then
    return
  end
  return abort_magic_by_id(behavior.npc, magicId, num)
end

function behaviorBase.abortMagics(behavior, ...)
  local npc = behavior.npc
  local magic
  for i = 1, select("#", ...) do
    magic = select(i, ...)
    abort_magic_by_id(npc, magic)
  end
end

behaviorBase._approachPos_ot = newVec()

function behaviorBase.approachPos(behavior, tarPos, maxOffset, minDist, oriPos)
  local max = math.max
  minDist = minDist and max(minDist, 0) or 0
  maxOffset = maxOffset and max(maxOffset, 0) or math.huge
  local npcPos = behavior.npc:get_pos_vec3()
  local ot = behavior._approachPos_ot
  tarPos = tarPos or npcPos
  local validOriPos
  local isSame = mathx.almost_equal
  if oriPos and not isSame(oriPos.x, oriPos.z, tarPos.x, tarPos.z) then
    validOriPos = oriPos
  elseif not isSame(npcPos.x, npcPos.z, tarPos.x, tarPos.z) then
    validOriPos = npcPos
  end
  if not validOriPos then
    local offset = math.min(minDist, maxOffset)
    ot:SetB(behavior.npc:get_dir_vec()):Mul(-offset):Add(tarPos)
    return ot:Clone(), npcPos
  end
  ot:SetB(tarPos):Sub(validOriPos)
  ot.y = 0
  local otMag = ot:Magnitude()
  local min = math.min
  if minDist >= otMag then
    local to = ot:Mul(-1)
    local maxDist = otMag + maxOffset
    local offset = min(maxDist, minDist)
    to:SetNormalize():Mul(offset):Add(tarPos)
    return to:Clone(), validOriPos
  else
    local offset = otMag - minDist
    offset = min(offset, maxOffset)
    ot:SetNormalize():Mul(offset):Add(validOriPos)
    return ot:Clone(), validOriPos
  end
end

function behaviorBase.offsetPos(behavior, dist, angle, tar)
  local npc = behavior.npc
  if not dist or dist <= 0.01 then
    return get_npc_pos(npc)
  end
  angle = angle or 0
  local face_to_pos = tar
  if tar and tar.get_pos_vec3 then
    face_to_pos = tar:get_pos_vec3()
  end
  return get_npc_offset_position(behavior.npc, face_to_pos, angle, dist)
end

behaviorBase._fixPosSrc = newVec()

function behaviorBase.fixPos(behavior, pos, height, radius, originPos, ignoreObstacle)
  local npc = behavior.npc
  local srcPos = behavior._fixPosSrc
  srcPos:SetA(originPos or npc:get_pos_vec3())
  local basePosHeight = Const.FLASH_TO_POS_Y_OFFSET
  local oriY = srcPos.y
  local rayLength
  srcPos.y = oriY + basePosHeight
  if not height then
    rayLength = basePosHeight + 0.1
    pos.y = srcPos.y
  else
    if height < 0 then
      if height <= -90 then
        behavior:debugOutput("fixPos.height 不应小于 -90， 当前值为", height)
      end
      local angle = math.rad(-height)
      local d = mathx.dist_vec2A(srcPos.x, srcPos.z, pos.x, pos.z)
      height = d * math.tan(angle)
    elseif height > 10 then
      behavior:debugOutput("fixPos.height 不应大于 10，当前值为", height)
    end
    local yOffsetP, yOffsetN
    local clamp = mathx.Clamp
    yOffsetP = clamp(height, basePosHeight, 10)
    yOffsetN = height < 10 and height or 10
    pos.y = oriY + yOffsetP
    rayLength = yOffsetP + yOffsetN
  end
  radius = radius or npc.radius + 0.15
  local _, ret = get_nearest_walkable_pos(srcPos, pos, radius, rayLength, ignoreObstacle)
  return ret
end

function behaviorBase.fixPosA(behavior, pos, height, radius, originPos)
  return behavior.behaviorBase.fixPos(behavior, pos, height, radius, originPos, true)
end

do
  local tpOriPos = vec3.New()
  
  function behaviorBase.tp(behavior, tpPos, maxOffset, lookPos, minDist, originPos)
    local isSame = mathx.almost_equal
    local npc = behavior.npc
    local npcPos = npc:get_pos_vec3()
    tpOriPos:SetA(originPos or npcPos)
    local isTpValid = tpPos and not isSame(npcPos.x, npcPos.z, tpPos.x, tpPos.z)
    if isTpValid then
      tpPos = behavior:fixPos(tpPos, nil, nil, originPos)
      tpPos = behavior:approachPos(tpPos, maxOffset, minDist, originPos)
      flash_to_pos(npc, tpPos.x, tpPos.z, tpPos.y, true)
    end
    local isTurnValid = lookPos and not isSame(npcPos.x, npcPos.z, lookPos.x, lookPos.z)
    if not isTurnValid and lookPos and isTpValid then
      lookPos = npcPos + (tpPos - tpOriPos)
      isTurnValid = not isSame(npcPos.x, npcPos.z, lookPos.x, lookPos.z)
    end
    if isTurnValid then
      lookat_position(npc, lookPos.x, lookPos.z, true)
    end
  end
end

function behaviorBase.getUri(behavior)
  local uri = behavior._uri
  if not uri then
    local npc = behavior.npc
    local npcId, uuId, fileId = npc and npc:get_npc_id(), npc and npc.uuid, behavior.file_id
    local list = {}
    table.insert(list, npcId)
    table.insert(list, uuId)
    table.insert(list, fileId)
    uri = table.concat(list, "|")
    if npcId and uuId and fileId then
      behavior._uri = uri
    end
  end
  return uri
end

function behaviorBase.debugOutput(behavior, ...)
  Util.debug_output(behavior:getUri(), ...)
end

function behaviorBase.debugOutputA(behavior, ...)
  if not GAME_DEBUG then
    return
  end
  local args = table.pack(...)
  local str = Global.frame_id .. ": " .. behavior:getUri() .. ", "
  for i = 1, args.n do
    str = str .. tostring(args[i]) .. ", "
  end
  Log.Error(str)
end

function behaviorBase.debugOutputB(behavior, str, ...)
  if not GAME_DEBUG then
    return
  end
  local output = Global.frame_id .. ": " .. behavior:getUri() .. ", " .. str
  Log.Errorf(output, ...)
end

function behaviorBase.errorOutput(behavior, ...)
  local args = table.pack(...)
  local str = Global.frame_id .. ": " .. behavior:getUri() .. ", "
  for i = 1, args.n do
    str = str .. tostring(args[i]) .. ", "
  end
  str = str .. "\n" .. debug.traceback()
  Log.Error(str)
end

function behaviorBase.debugPos(behavior, pos, name, type)
  type = type or Const.DEBUG_MESH_TYPE.BALL
  local funName = "debug" .. type
  behavior[funName](behavior, pos, name or "RandPos")
  return pos
end

function behaviorBase.getDebugObj(behavior, name, type, parent)
  if not GAME_DEBUG then
    return
  end
  local obj = behavior[name]
  if not obj then
    if parent then
      obj = parent.transform:Find(name)
    else
      obj = Unity.GameObject.Find("/" .. name)
    end
    if not obj then
      if type then
        obj = Unity.GameObject.CreatePrimitive(type)
      else
        obj = Unity.GameObject(name)
      end
    end
    obj.name = name
    behavior[name] = obj
    obj.transform.localScale = Unity.Vector3(0.5, 0.5, 0.5)
  end
  return obj
end

function behaviorBase.debugBall(behavior, pos, name)
  if not GAME_DEBUG then
    return
  end
  local objName = behavior:getUri() .. "_debugBall_" .. name
  local ball = behavior:getDebugObj(objName, Unity.PrimitiveType.Sphere)
  if not pos then
    ball:SetActive(false)
    return behavior:debugOutput("debugBall(" .. tostring(name) .. ") lost pos")
  end
  ball:SetActive(true)
  ball.transform.position = Unity.Vector3(pos.x, pos.y, pos.z)
  return ball
end

function behaviorBase.debugCube(behavior, pos, name)
  if not GAME_DEBUG then
    return
  end
  local objName = behavior:getUri() .. "_debugCube_" .. name
  local cube = behavior:getDebugObj(objName, Unity.PrimitiveType.Cube)
  if not pos then
    cube:SetActive(false)
    return behavior:debugOutput("debugCube(" .. tostring(name) .. ") lost pos")
  end
  cube:SetActive(true)
  cube.transform.position = Unity.Vector3(pos.x, pos.y, pos.z)
  return cube
end

function behaviorBase.debugCylinder(behavior, pos, name)
  if not GAME_DEBUG then
    return
  end
  local objName = behavior:getUri() .. "_debugCylinder_" .. name
  local cylinder = behavior:getDebugObj(objName, Unity.PrimitiveType.Cylinder)
  if not pos then
    cylinder:SetActive(false)
    return behavior:debugOutput("debugCylinder(" .. tostring(name) .. ") lost pos")
  end
  cylinder:SetActive(true)
  cylinder.transform.position = Unity.Vector3(pos.x, pos.y, pos.z)
  return cylinder
end

behaviorBase._debugPos = newVec()

function behaviorBase.debugCubeA(behavior, x, y, z, name)
  local pos = behavior._debugPos
  local rolePos = behavior.npc:get_pos_vec3()
  pos:Set(x or rolePos.x, y or rolePos.y, z or rolePos.z)
  return behavior:debugCube(pos, name)
end

do return behaviorBase end

function behaviorBase._init(behavior, npc)
end
