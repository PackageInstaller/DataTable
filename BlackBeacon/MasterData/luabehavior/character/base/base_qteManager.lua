local qteMgr = {}
qteMgr.__index = qteMgr
qteMgr.linkMgr = import("character.base.base_linkManager")

function qteMgr.new(mgrBase, role)
  local mgr = setmetatable({}, mgrBase)
  mgr.role = role
  return mgr
end

function qteMgr.init(mgr)
  local role = mgr.role
  mgr.debugSwitch = role.debugSwitch
  mgr.qtes = role.qteList
  mgr.wander = role.baseActs.wander
  mgr.ultBtn = role.btns.ult
  mgr.ultInvul = Const.ULT_INVUL
end

function qteMgr.choose(mgr, event)
  local role = mgr.role
  local isUlt = role.need_fast_ult or role.need_ult or role.npc.by_ult_change
  if isUlt then
    return mgr:chooseUlt()
  else
    local qte = mgr:chooseQte(event)
    if qte then
      return qte
    elseif role:isInRealStay() then
      return
    else
      return role.baseActs.wander
    end
  end
end

function qteMgr.chooseUlt(mgr)
  local npc = mgr.role.npc
  cast_magic(npc, npc, mgr.ultInvul)
  return mgr.ultBtn.icon.hit:chooseSkAct()
end

function qteMgr.chooseQte(mgr, event)
  return mgr.qtes:choose(event)
end

do
  local vec3 = require("base.vec3")
  qteMgr.showUpPos_Avec = vec3:New()
  qteMgr.showUpPos_Bvec = vec3:New()
  qteMgr.showUpPos_CAvec = vec3:New()
  qteMgr.showUpPos_reDirP = vec3:New()
  
  function qteMgr.showUpPos_byTarget(act)
    local newRole = act.role
    local target = newRole.target
    local tool = act.tool
    local oldRole = tool.curRole
    local showUpPos = newRole._showUpPos
    local config = tool:getSwitchConfig()
    local max_offset_from_tar = act.startDist
    if not max_offset_from_tar then
      return newRole:debugOutput("max_offset_from_tar is lost, newAct is ", act.name)
    end
    local oldRolePos = oldRole.npc:get_pos_vec3()
    local inputDir, faceDir = oldRole:inputDir()
    local ePos = target:get_pos_vec3()
    local heDir
    if target.d_heDir then
      heDir = target.d_heDir
    else
      heDir = vec3.New()
      target.d_heDir = heDir
    end
    heDir:Set(ePos.x - oldRolePos.x, 0, ePos.z - oldRolePos.z)
    local reDis = heDir:Magnitude()
    if reDis > 0.01 then
      heDir:Div(reDis)
    else
      heDir:SetA(inputDir or faceDir)
    end
    local eRadius = target.radius or 0
    local innerFar = reDis + eRadius + config.min_offset_from_tar
    if innerFar <= config.max_offset_from_role then
      local length = math.min(config.max_offset_from_role, reDis + eRadius + max_offset_from_tar)
      showUpPos:SetB(heDir):Mul(length):Add(oldRolePos)
      return showUpPos
    end
    local innerClose = reDis - eRadius - config.min_offset_from_tar
    if innerClose >= config.min_offset_from_role then
      local length
      local outerClose = reDis - eRadius - max_offset_from_tar
      if outerClose > config.max_offset_from_role then
        length = config.max_offset_from_role
      elseif outerClose > config.min_offset_from_role then
        length = outerClose
      else
        length = config.min_offset_from_role
      end
      showUpPos:SetB(heDir):Mul(length):Add(oldRolePos)
      return showUpPos
    end
    if reDis < eRadius then
      local rolePos = oldRolePos
      oldRolePos = vec3:New()
      oldRolePos:SetB(heDir):Mul(reDis - eRadius):Add(rolePos)
      reDis = eRadius
    end
    local aPos, bPos, cPos = act.tool:circleIntersectTemp(oldRolePos, config.min_offset_from_role, ePos, eRadius + config.min_offset_from_tar)
    local qteMgr = act.qteMgr
    local aVec = qteMgr.showUpPos_Avec
    aVec:SetB(aPos):Sub(oldRolePos)
    aVec.y = 0
    local bVec = qteMgr.showUpPos_Bvec
    bVec:SetB(bPos):Sub(oldRolePos)
    bVec.y = 0
    if aVec:Dot(heDir) > 0 then
      if not inputDir then
        showUpPos:SetA(aPos)
        return showUpPos
      else
        local caVec = qteMgr.showUpPos_CAvec
        caVec:SetB(aPos):Sub(cPos)
        if caVec:Dot(inputDir) > 0 then
          showUpPos:SetA(aPos)
        else
          showUpPos:SetA(bPos)
        end
        return showUpPos
      end
    end
    local reDirP = qteMgr.showUpPos_reDirP
    reDirP:Set(heDir.z, 0, -heDir.x)
    local ra = ((eRadius + config.min_offset_from_tar) ^ 2 - reDis ^ 2) ^ 0.5
    if ra <= config.max_offset_from_role then
      if not inputDir then
        showUpPos:SetB(reDirP):Mul(ra):Add(oldRolePos)
        return showUpPos
      else
        if reDirP:Dot(inputDir) < 0 then
          reDirP:Mul(-1)
        end
        showUpPos:SetB(reDirP):Mul(ra):Add(oldRolePos)
        return showUpPos
      end
    end
    aPos, bPos, cPos = act.tool:circleIntersectTemp(oldRolePos, config.max_offset_from_role, ePos, eRadius + config.min_offset_from_tar)
    aVec = qteMgr.showUpPos_Avec
    bVec = qteMgr.showUpPos_Bvec
    aVec:SetB(aPos):Sub(oldRolePos)
    bVec:SetB(bPos):Sub(oldRolePos)
    if not inputDir then
      showUpPos:SetA(aPos)
      return showUpPos
    else
      local caVec = qteMgr.showUpPos_CAvec
      caVec:SetB(aPos):Sub(cPos)
      if caVec:Dot(inputDir) > 0 then
        showUpPos:SetA(aPos)
      else
        showUpPos:SetA(bPos)
      end
      return showUpPos
    end
  end
  
  function qteMgr.showUpPos_byRole(act)
    local newRole = act.role
    local showUpPos = newRole._showUpPos
    local tool = act.tool
    local oldRole = tool.curRole
    local inputDir, faceDir = oldRole:inputDir()
    inputDir = inputDir or faceDir
    local oldRolePos = oldRole.npc:get_pos_vec3()
    local config = tool:getSwitchConfig()
    if oldRole:isInStay() then
      showUpPos:SetB(inputDir):Mul(config.min_offset_from_role):Add(oldRolePos)
      return showUpPos
    else
      return showUpPos:SetB(oldRolePos)
    end
  end
end
return qteMgr
