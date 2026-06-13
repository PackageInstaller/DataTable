local FIGHT_DEFINE = require("cs_share.fight_define")
local RES2MAX = FIGHT_DEFINE.RES2MAX
local _mfloor = math.floor
local t = {}
local _max = math.max
local RADIO = 1.0E-4

local function GetShareRes(fileName, fileDir)
  if not t._getResources then
    if _LUA_SERVER_ENV then
      t._getResources = require("glib.share_res").GetResources
    else
      t._getResources = ShareRes.create
    end
  end
  if fileDir then
    fileName = fileDir .. "." .. fileName
  end
  assert(type(t._getResources) == "function")
  return t._getResources(fileName)
end

local function calc_real_lv(buddy_lv, buddy_break)
  return 5 * buddy_break ^ 2 + 55 * buddy_break + buddy_lv - 60
end

local function calc_attr_score(attr_list, debug_info)
  local coeff_cfg = GetShareRes("attr_coeff", "combat_effectiveness")
  local sum = 1
  local temp = 0
  for attrId, cfg in pairs(coeff_cfg) do
    local realId = RES2MAX[attrId] or attrId
    if 1 == cfg.CalType then
      local score = cfg.Coeff * assert(attr_list[realId], attrId)
      sum = sum * score
      if debug_info then
        debug_info[#debug_info + 1] = string.format("类型:%s, 属性id:%s <-> %s = (%s * %s)", cfg.CalType, attrId, score, cfg.Coeff, attr_list[realId])
      end
    elseif 2 == cfg.CalType then
      if 0 == temp then
        temp = 1
      end
      local score = cfg.Coeff * RADIO * assert(attr_list[realId], attrId)
      temp = temp * score
      if debug_info then
        debug_info[#debug_info + 1] = string.format("类型:%s, 属性id:%s <-> %s = ((%s * %s) / 10000)", cfg.CalType, attrId, score, cfg.Coeff, attr_list[realId])
      end
    elseif 3 == cfg.CalType then
      local score = 1 + assert(attr_list[realId], attrId) * cfg.Coeff / 10000
      sum = sum * score
      if debug_info then
        debug_info[#debug_info + 1] = string.format("类型:%s, 属性id:%s <-> %s = ((1 + (%s / 10000)) * %s)", cfg.CalType, attrId, score, attr_list[realId], cfg.Coeff)
      end
    elseif 4 == cfg.CalType then
      local score = (assert(attr_list[realId], attrId) + cfg.Coeff) / cfg.Coeff
      sum = sum * score
      if debug_info then
        debug_info[#debug_info + 1] = string.format("类型:%s, 属性id:%s <-> %s = ((%s + %s) / %s)", cfg.CalType, attrId, score, attr_list[realId], cfg.Coeff, cfg.Coeff)
      end
    elseif 5 == cfg.CalType then
      local attrIdCoeff = _max(1 - assert(attr_list[realId], attrId) / 10000, 0)
      local score = (cfg.Coeff[1] + cfg.Coeff[2]) / (cfg.Coeff[2] + cfg.Coeff[1] * attrIdCoeff)
      sum = sum * score
      if debug_info then
        debug_info[#debug_info + 1] = string.format("类型:%s, 属性id:%s <-> %s = ((%s + %s) / %s + %s * (1 - (%s / 10000)))", cfg.CalType, attrId, score, cfg.Coeff[1], cfg.Coeff[2], cfg.Coeff[2], cfg.Coeff[1], attr_list[realId])
      end
    end
  end
  if 0 ~= temp then
    sum = sum * (1 + temp)
  end
  return sum
end

local function calc_quality_score(buddy_id, buddy_real_lv)
  local buddy_cfg = GetShareRes("buddy", "buddy")
  local quality = assert(buddy_cfg[buddy_id].Quality, buddy_id)
  local coeff_cfg = GetShareRes("quality_coeff", "combat_effectiveness")
  local cfg = assert(coeff_cfg[quality], quality)
  return cfg.Coeff * buddy_real_lv
end

local function calc_advance_score(buddy_id, buddy_real_lv, buddy_advance)
  local coeff_cfgs = GetShareRes("advance_coeff", "combat_effectiveness")
  local coeff_cfg = coeff_cfgs[buddy_id]
  return assert(coeff_cfg.Coeff[buddy_advance], buddy_id)
end

local function calc_base_skill_score(buddy_id, buddy_real_lv, skill_data)
  local buddy_cfg = GetShareRes("buddy_skill", "buddy")
  local skill_list = assert(buddy_cfg[buddy_id], buddy_id).Skill
  local sum = 0
  local coeff_cfg = GetShareRes("base_skill_coeff", "combat_effectiveness")
  for index, skill_id in pairs(skill_list) do
    local lv = assert(skill_data[skill_id], skill_id)
    local coeffs = assert(coeff_cfg[index].Coeff, index)
    local coeff = assert(coeffs[lv], lv)
    sum = sum + coeff
  end
  return sum
end

local function calc_equip_score(buddy_real_lv, equip_id, equip_advance)
  local coeff_cfgs = GetShareRes("equip_coeff", "combat_effectiveness")
  local coeff_cfg = coeff_cfgs[equip_id]
  return assert(coeff_cfg.Coeff[equip_advance], equip_id)
end

local function calc_equip_gemstone_score(gemstone_list)
  local sum = 1
  if gemstone_list then
    local gemstone_cfgs = GetShareRes("equip_gemstone", "equip")
    local coeff_cfgs = GetShareRes("gemstone_coeff", "combat_effectiveness")
    for _, gemstone in pairs(gemstone_list) do
      local gemstone_cfg = assert(gemstone_cfgs[gemstone.id], gemstone.id)
      local coeff_cfg = assert(coeff_cfgs[gemstone_cfg.Quality])
      local ceoff = coeff_cfg.Coeff[gemstone.level]
      sum = sum * ceoff
    end
  end
  return sum
end

local function calc_equip_talent_score(talent_lv)
  local talent_cfgs = GetShareRes("talent_coeff", "combat_effectiveness")
  return talent_cfgs[talent_lv] or 1
end

local function calc_puzzle_score(puzzle_list)
  local coeff = 1
  if puzzle_list then
    local puzzle_coeffs = GetShareRes("puzzle_coeff", "combat_effectiveness")
    for _, puzzle in pairs(puzzle_list) do
      local puzzle_id = puzzle.id
      local puzzle_quality = puzzle.quality
      local puzzle_cfg = puzzle_coeffs[puzzle_id]
      if puzzle_cfg then
        local puzzle_coeff = puzzle_cfg.Coeff[puzzle_quality]
        coeff = coeff * puzzle_coeff
      end
    end
  end
  return coeff
end

function t.calc_buddy_final_score(buddy_id, args_map)
  local coeff_cfg = GetShareRes("general_coeff", "combat_effectiveness")[1]
  local buddy_lv, buddy_break, buddy_advance, equip_id, equip_advance, attr_list, skill_data = args_map.buddy_lv, args_map.buddy_break, args_map.buddy_advance, args_map.equip_id, args_map.equip_advance, args_map.attr_list, args_map.skill_data
  local gemstone_list, talent_lv, puzzle_list = args_map.gemstone_list, args_map.talent_lv, args_map.puzzle_list
  local real_lv = calc_real_lv(buddy_lv, buddy_break)
  local debug_info
  if args_map.dump_debug then
    debug_info = {}
  end
  local attr_score = calc_attr_score(attr_list, debug_info)
  local advance_score = calc_advance_score(buddy_id, real_lv, buddy_advance)
  local skill_score = calc_base_skill_score(buddy_id, real_lv, skill_data)
  local equip_score = calc_equip_score(real_lv, equip_id, equip_advance)
  local gemstone_score = calc_equip_gemstone_score(gemstone_list)
  local talent_score = calc_equip_talent_score(talent_lv)
  local puzzle_score = calc_puzzle_score(puzzle_list)
  local general_coeff_cfg = GetShareRes("general_coeff", "combat_effectiveness")[1]
  local exponent_score = general_coeff_cfg and general_coeff_cfg.Coeff[3] or 0.5
  local nPower = math.ceil(coeff_cfg.Coeff[1] * (attr_score * advance_score * skill_score * equip_score * gemstone_score * talent_score * puzzle_score) ^ exponent_score + coeff_cfg.Coeff[2])
  if args_map.dump_debug then
    local debug_info_list = {}
    debug_info_list[#debug_info_list + 1] = string.format("角色id       %s", buddy_id)
    debug_info_list[#debug_info_list + 1] = string.format("战力         %s", nPower)
    debug_info_list[#debug_info_list + 1] = string.format("通用系数1     %s", coeff_cfg.Coeff[1])
    debug_info_list[#debug_info_list + 1] = string.format("属性部       %s", attr_score)
    debug_info_list[#debug_info_list + 1] = string.format("属性部详情\n%s", table.concat(debug_info, "\n"))
    debug_info_list[#debug_info_list + 1] = string.format("技能部       %s", skill_score)
    debug_info_list[#debug_info_list + 1] = string.format("角色部       %s", advance_score * talent_score)
    debug_info_list[#debug_info_list + 1] = string.format("武器部       %s", equip_score)
    debug_info_list[#debug_info_list + 1] = string.format("插件部       %s", puzzle_score)
    debug_info_list[#debug_info_list + 1] = string.format("通用系数2    %s", coeff_cfg.Coeff[2])
    args_map.dump_debug_string = table.concat(debug_info_list, "\n")
  end
  return nPower
end

return t
