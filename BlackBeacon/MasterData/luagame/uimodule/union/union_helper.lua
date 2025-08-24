local helper = {}
local UnionCfg = require("uimodule.union.union_config")
local STATE = UnionCfg.JOIN_STATE

function helper.get_join_state(union_data)
  if union_data.member_num >= union_data.member_num_limit then
    return STATE.FULL
  end
  local need_check = union_data.verify_type == UnionCfg.JOIN_MODE.CHAIRMAN_APPROVAL
  if need_check then
    local has_applyed = 1 == union_data.apply_status
    return has_applyed and STATE.APPLYING or STATE.APPLY
  end
  return STATE.JOIN
end

local IconCfg = ShareRes.create("guild.guild_icon")

function helper.get_union_icon_path(icon)
  return IconCfg[icon].name
end

local avatar_cfg = ShareRes.create("player.player_avatar")
local player_icon_path_prefix = "Icon/Profile/%s"

function helper.get_player_icon_path(avatar_id)
  local icon_name = nil == avatar_cfg[avatar_id] and avatar_cfg[700051].Icon or avatar_cfg[avatar_id].Icon
  return string.format(player_icon_path_prefix, icon_name)
end

function helper.filter_special_char(str)
  local ss = {}
  for k = 1, #str do
    local c = string.byte(str, k)
    if not c then
      break
    end
    if c >= 48 and c <= 57 or c >= 65 and c <= 90 or c >= 97 and c <= 122 then
      table.insert(ss, string.char(c))
    elseif c >= 228 and c <= 233 then
      local c1 = string.byte(str, k + 1)
      local c2 = string.byte(str, k + 2)
      if c1 and c2 then
        local a1, a2, a3, a4 = 128, 191, 128, 191
        if 228 == c then
          a1 = 184
        elseif 233 == c then
          a2, a4 = 190, 190 ~= c1 and 191 or 165
        end
        if c1 >= a1 and c1 <= a2 and c2 >= a3 and c2 <= a4 then
          k = k + 2
          table.insert(ss, string.char(c, c1, c2))
        end
      end
    end
  end
  return table.concat(ss)
end

return helper
