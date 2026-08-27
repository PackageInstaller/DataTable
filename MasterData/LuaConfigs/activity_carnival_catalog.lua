local activity_carnival_catalog = {
  [101] = {catalog_des = 362979, catalog_des2 = 308176},
  [102] = {catalog_des2 = 217487, id = 102},
  [103] = {catalog_des = 480871, id = 103},
  [104] = {catalog_des = 514867, id = 104},
  [201] = {
    catalog_des = 362979,
    catalog_des2 = 175577,
    id = 201
  },
  [202] = {catalog_des2 = 382093, id = 202},
  [203] = {
    catalog_des = 480871,
    catalog_des2 = 256314,
    id = 203
  },
  [204] = {
    catalog_des = 514867,
    catalog_des2 = 256314,
    id = 204
  },
  [301] = {
    catalog_des = 362979,
    catalog_des2 = 426969,
    id = 301
  },
  [302] = {catalog_des2 = 461540, id = 302},
  [303] = {
    catalog_des = 480871,
    catalog_des2 = 294429,
    id = 303
  },
  [304] = {
    catalog_des = 514867,
    catalog_des2 = 294429,
    id = 304
  },
  [305] = {catalog_des = 216241, id = 305},
  [401] = {
    catalog_des = 362979,
    catalog_des2 = 426969,
    id = 401
  },
  [402] = {catalog_des2 = 461540, id = 402},
  [403] = {
    catalog_des = 155109,
    catalog_des2 = 68424,
    id = 403
  },
  [404] = {
    catalog_des = 480871,
    catalog_des2 = 458198,
    id = 404
  },
  [405] = {
    catalog_des = 514867,
    catalog_des2 = 458198,
    id = 405
  },
  [406] = {
    catalog_des = 216241,
    catalog_des2 = 256314,
    id = 406
  }
}
local __default_values = {
  catalog_des = 201489,
  catalog_des2 = 211979,
  id = 101
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_carnival_catalog) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_carnival_catalog, {__index = __rawdata})
return activity_carnival_catalog
