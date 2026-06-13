local StatDef = require("cs_share.stat_defines")
local Dump = require("cs_share.dump")
local Utils = require("cs_share.utils")
local CStatMgr = {}
CStatMgr.__index = CStatMgr

function CStatMgr:new(...)
  local o = {}
  setmetatable(o, self)
  o:_init(...)
  return o
end

local REQUEST_TYPE = {
  c2gs_creat_npc = "c2gs_creat_npc",
  c2gs_remove_npc = "c2gs_remove_npc",
  c2gs_cast_skill = "c2gs_cast_skill",
  c2gs_stop_skill = "c2gs_stop_skill",
  c2gs_cast_missile = "c2gs_cast_missile",
  c2gs_missile_explosion = "c2gs_missile_explosion",
  c2gs_remove_missile = "c2gs_remove_missile",
  c2gs_sync_module_attrs = "c2gs_sync_module_attrs",
  c2gs_report_magic_action = "c2gs_report_magic_action"
}
local REQUEST_TABLE_FILED = {
  [REQUEST_TYPE.c2gs_report_magic_action] = {
    "magic_action_list"
  }
}

function CStatMgr:_init(runMode, sceneNo, roleUUID, logicInterface)
  self.m_iRunMode = runMode
  self.m_SceneNo = sceneNo
  self.m_RoleUUID = roleUUID
  self.m_oLogicInterface = logicInterface
end

function CStatMgr:creat_npc(mRequest, sTag)
  if self.m_iRunMode == StatDef.RUN_MODE.NONE then
    return
  end
  if self.m_iRunMode == StatDef.RUN_MODE.CLIENT then
    self:net_send(REQUEST_TYPE.c2gs_creat_npc, mRequest)
  end
end

function CStatMgr:remove_npc(mRequest, sTag, cb)
  if self.m_iRunMode == StatDef.RUN_MODE.NONE then
    return
  end
  if self.m_iRunMode == StatDef.RUN_MODE.CLIENT then
    self:net_send(REQUEST_TYPE.c2gs_remove_npc, mRequest, cb)
  end
end

function CStatMgr:cast_skill(mRequest, sTag)
  if self.m_iRunMode == StatDef.RUN_MODE.NONE then
    return
  end
  if self.m_iRunMode == StatDef.RUN_MODE.CLIENT then
    self:net_send(REQUEST_TYPE.c2gs_cast_skill, mRequest)
  end
end

function CStatMgr:stop_skill(mRequest, sTag)
  if self.m_iRunMode == StatDef.RUN_MODE.NONE then
    return
  end
  if self.m_iRunMode == StatDef.RUN_MODE.CLIENT then
    self:net_send(REQUEST_TYPE.c2gs_stop_skill, mRequest)
  end
end

function CStatMgr:cast_missile(mRequest, sTag)
  if self.m_iRunMode == StatDef.RUN_MODE.NONE then
    return
  end
  if self.m_iRunMode == StatDef.RUN_MODE.CLIENT then
    self:net_send(REQUEST_TYPE.c2gs_cast_missile, mRequest)
  end
end

function CStatMgr:missile_explosion(mRequest, sTag)
  if self.m_iRunMode == StatDef.RUN_MODE.NONE then
    return
  end
  if self.m_iRunMode == StatDef.RUN_MODE.CLIENT then
    self:net_send(REQUEST_TYPE.c2gs_missile_explosion, mRequest)
  end
end

function CStatMgr:remove_missile(mRequest, sTag)
  if self.m_iRunMode == StatDef.RUN_MODE.NONE then
    return
  end
  if self.m_iRunMode == StatDef.RUN_MODE.CLIENT then
    self:net_send(REQUEST_TYPE.c2gs_remove_missile, mRequest)
  end
end

function CStatMgr:sync_module_attrs(hero_uuid)
  if self.m_iRunMode == StatDef.RUN_MODE.NONE then
    return
  end
  local mRequest = {uuid = hero_uuid}
  if self.m_iRunMode == StatDef.RUN_MODE.CLIENT then
    self:net_send(REQUEST_TYPE.c2gs_sync_module_attrs, mRequest)
  end
end

local magic_aciton_request_temp = {}

function CStatMgr:report_magic_action(magic_action_list)
  if self.m_iRunMode == StatDef.RUN_MODE.NONE then
    return
  end
  if self.m_iRunMode == StatDef.RUN_MODE.CLIENT then
    magic_aciton_request_temp.magic_action_list = magic_action_list
    self:net_send(REQUEST_TYPE.c2gs_report_magic_action, magic_aciton_request_temp)
  end
end

function CStatMgr:net_send(sproto, data)
  Network:call(sproto, data)
end

function CStatMgr:clear()
  magic_aciton_request_temp = {}
end

return CStatMgr
