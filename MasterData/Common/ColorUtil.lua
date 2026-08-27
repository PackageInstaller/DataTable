local strfmt = string.format
local strsub = string.sub
local channel_default = 255
local hex24_default = "#FFFFFF"
local hex32_default = "#FFFFFFFF"
local rgb_default = {
  r = channel_default,
  g = channel_default,
  b = channel_default
}
local rgba_default = {
  r = rgb_default.r,
  g = rgb_default.g,
  b = rgb_default.b,
  a = channel_default
}

local function to_color_bit(color)
  color = tonumber(color)
  if color and color <= channel_default and 0 <= channel_default then
    return color
  end
  return channel_default
end

local function to_valid_color(color)
  if type(color) ~= "table" then
    return rgba_default
  end
  color.r = to_color_bit(color.r)
  color.g = to_color_bit(color.g)
  color.b = to_color_bit(color.b)
  color.a = to_color_bit(color.a)
end

local function str_to_hex_num(hex)
  return tonumber(hex, 16) or channel_default
end

local function num_to_hex_str(value)
  return strfmt("%02X", to_color_bit(value))
end

local function hex_to_color(hex)
  local len = string.len(hex)
  if len < 7 then
    return rgb_default
  end
  if strsub(hex, 1, 1) ~= "#" then
    return rgb_default
  end
  local color = {
    r = to_color_bit(str_to_hex_num(strsub(hex, 2, 3))),
    g = to_color_bit(str_to_hex_num(strsub(hex, 4, 5))),
    b = to_color_bit(str_to_hex_num(strsub(hex, 6, 7))),
    a = channel_default
  }
  if len == 9 then
    color.a = to_color_bit(str_to_hex_num(strsub(hex, 8, 9)))
  end
  return color
end

local function hex_to_color_unit(hex)
  local color = hex_to_color(hex)
  local color_unit = {
    r = color.r / channel_default,
    g = color.g / channel_default,
    b = color.b / channel_default,
    a = color.a / channel_default
  }
  return color_unit
end

local function tab_to_color(tbl)
  return {
    r = to_color_bit(tbl[1]),
    g = to_color_bit(tbl[2]),
    b = to_color_bit(tbl[3]),
    a = to_color_bit(tbl[4])
  }
end

local function color_to_tab(color)
  to_valid_color(color)
  return {
    color.r,
    color.g,
    color.b,
    color.a
  }
end

local function color_to_hex24(color)
  if type(color) ~= "table" then
    return hex24_default
  end
  if not (color.r and color.g) or not color.b then
    return hex24_default
  end
  local hex = "#"
  hex = hex .. num_to_hex_str(color.r)
  hex = hex .. num_to_hex_str(color.g)
  hex = hex .. num_to_hex_str(color.b)
  return hex
end

local function color_to_hex32(color)
  return color_to_hex24(color) .. num_to_hex_str(color.a)
end

ColorUtil = {
  FromHex = hex_to_color,
  FromHexUnit = hex_to_color_unit,
  FromTab = tab_to_color,
  ToTab = color_to_tab,
  ToHex24 = color_to_hex24,
  ToHex32 = color_to_hex32,
  ToHex = color_to_hex24,
  Hex = {
    Red = "#FF0000",
    Green = "#00FF00",
    Blue = "#0000FF",
    White = "#FFFFFF",
    Yellow = "#FFFF00",
    Magenta = "#FF00FF",
    Aqua = "#00FFFF",
    Cyan = "#00FFFF",
    Black = "#000000"
  }
}
