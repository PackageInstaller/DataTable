local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local M = {}
local registered_background_groups_map = {}

function M.check_groups_infos_valid(card_id, group_infos)
  if not group_infos then
    return true
  end
  if type(group_infos) ~= "table" then
    return false, CONSTANTS.BACKGROUND_DOWNLOAD_ERROR_CODES.PARAMS_NOT_COMPLETE, "groups is not a table"
  end
  for i, group_info in ipairs(group_infos) do
    if type(group_info) ~= "table" then
      return false, CONSTANTS.BACKGROUND_DOWNLOAD_ERROR_CODES.PARAMS_NOT_COMPLETE, "group at index " .. tostring(i) .. " is not a table"
    end
    local group_name = group_info.name
    local existing_card_info = registered_background_groups_map[group_name]
    if existing_card_info then
      if existing_card_info.card_id ~= card_id then
        return false, CONSTANTS.BACKGROUND_DOWNLOAD_ERROR_CODES.PARAMS_NOT_COMPLETE, "group '" .. group_name .. "' is already registered by card_id: " .. tostring(existing_card_info.card_id)
      end
    else
      registered_background_groups_map[group_name] = {card_id = card_id}
    end
  end
  return true
end

return M
