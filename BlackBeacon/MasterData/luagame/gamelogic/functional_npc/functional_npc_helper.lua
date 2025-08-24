local helper = {}
local CommonDefind = require("cs_share.common_define")

function helper.is_reward_npc(npc_id)
  local npc_cfg = ShareRes.create("npc.functional_npc", npc_id)
  if npc_cfg and (npc_cfg.Type == CommonDefind.FUNCTIONAL_NPC_TYPE.REWARD or npc_cfg.Type == CommonDefind.FUNCTIONAL_NPC_TYPE.FIXED_DROP) then
    return true
  end
  return false
end

function helper.is_role_npc(npc_id)
  local npc_cfg = ShareRes.create("npc.functional_npc", npc_id)
  if npc_cfg and helper.is_role_npc_with_type(npc_cfg.Type) then
    return true
  end
  return false
end

function helper.is_role_npc_with_type(npc_type)
  return npc_type == CommonDefind.FUNCTIONAL_NPC_TYPE.ROLE_NPC
end

helper.is_need_show_bubble_list = {}

function helper.is_need_show_bubble(npc_cfg)
  if not npc_cfg or not npc_cfg.Id then
    return false
  end
  if not helper.is_need_show_bubble_list[npc_cfg.Id] then
    helper.is_need_show_bubble_list[npc_cfg.Id] = FunctionalNpcMgr:is_need_show_bubble_with_npc_cfg(npc_cfg)
  end
  return helper.is_need_show_bubble_list[npc_cfg.Id]
end

return helper
