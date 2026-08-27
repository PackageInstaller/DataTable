local dungeon_material_count = {
  [1801] = {},
  [1802] = {id = 1802},
  [1803] = {id = 1803},
  [1804] = {id = 1804},
  [1805] = {id = 1805},
  [1806] = {colorCount = 15, id = 1806},
  [1807] = {colorCount = 15, id = 1807},
  [1808] = {colorCount = 15, id = 1808},
  [1809] = {colorCount = 15, id = 1809},
  [1810] = {colorCount = 15, id = 1810},
  [1811] = {colorCount = 20, id = 1811},
  [1812] = {colorCount = 20, id = 1812},
  [1813] = {colorCount = 20, id = 1813},
  [1814] = {colorCount = 20, id = 1814},
  [1815] = {colorCount = 20, id = 1815},
  [1816] = {colorCount = 25, id = 1816},
  [1817] = {colorCount = 25, id = 1817},
  [1818] = {colorCount = 25, id = 1818},
  [1819] = {colorCount = 25, id = 1819},
  [1820] = {colorCount = 25, id = 1820},
  [1821] = {colorCount = 30, id = 1821},
  [1822] = {colorCount = 30, id = 1822},
  [1823] = {colorCount = 30, id = 1823},
  [1824] = {colorCount = 30, id = 1824},
  [1825] = {colorCount = 30, id = 1825}
}
local __default_values = {colorCount = 10, id = 1801}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(dungeon_material_count) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(dungeon_material_count, {__index = __rawdata})
return dungeon_material_count
