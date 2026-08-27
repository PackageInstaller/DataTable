local ep_mvp_special = {
  [6271] = {
    id = 6271,
    lpic = "demiurge_avg"
  },
  [62710] = {
    id = 62710,
    lpic = "demiurge_avg"
  },
  [500091] = {
    lpic = "beelneith_avg_stage_perform"
  },
  [500171] = {
    id = 500171,
    lpic = "hesperus_weapon2_avg_stage_perform"
  },
  [502091] = {
    id = 502091,
    lpic = "beelneith_avg_stage_perform"
  },
  [502171] = {
    id = 502171,
    lpic = "hesperus_weapon2_avg_stage_perform"
  },
  [601201] = {
    id = 601201,
    lpic = "demi_lava2_avg"
  },
  [601501] = {id = 601501, lpic = "sol"},
  [602001] = {
    id = 602001,
    lpic = "persicaria_sp2_avg"
  },
  [603401] = {
    id = 603401,
    lpic = "persicaria_bq_avg"
  },
  [603802] = {id = 603802},
  [604101] = {id = 604101},
  [604102] = {id = 604102},
  [611201] = {
    id = 611201,
    lpic = "demi_lava2_avg"
  },
  [611501] = {id = 611501, lpic = "sol"},
  [612001] = {
    id = 612001,
    lpic = "persicaria_sp2_avg"
  },
  [613401] = {
    id = 613401,
    lpic = "persicaria_bq_avg"
  },
  [613802] = {id = 613802},
  [614101] = {id = 614101},
  [614102] = {id = 614102},
  [633401] = {
    id = 633401,
    lpic = "persicaria_bq_avg"
  },
  [633802] = {id = 633802},
  [634101] = {id = 634101},
  [634102] = {id = 634102}
}
local __default_values = {id = 500091, lpic = "endperform"}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(ep_mvp_special) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(ep_mvp_special, {__index = __rawdata})
return ep_mvp_special
