local M = {}

function M.player_to_cache_entity(player)
  local entity = {
    player_info = player,
    player_id = player.player_id,
    update_time = player.update_time
  }
  return entity
end

function M.cache_entity_to_player(entity)
  local player = entity.player_info
  player.player_id = entity.player_id
  return player
end

return M
