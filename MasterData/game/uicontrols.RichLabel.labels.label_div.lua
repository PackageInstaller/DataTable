local function div_createlabel(self, word, fontname, fontsize, fontcolor)
  if word == "" then
    return
  end
  local label = ccui.Text:create(word, fontname, fontsize)
  if label then
    label:setTextColor(fontcolor)
  else
    self:printf("<div> - create label failed")
    return
  end
  if label:getContentSize().width == 0 then
    label = ccui.Text:create(word, display.SYS_FONT, fontsize)
    label:setTextColor(fontcolor)
  end
  return label
end

local function div_parseshadow(self, shadow)
  if not shadow then
    return
  end
  local params = self:split(shadow, ",")
  if #params ~= 4 then
    self:printf("parser <div> property shadow error")
    return nil
  end
  local offset_x = tonumber(params[1]) or 0
  local offset_y = tonumber(params[2]) or 0
  params.offset = cc.size(offset_x, offset_y)
  params.blurradius = tonumber(params[3]) or 0
  params.color = self:convertColor(params[4]) or cc.c4b(255, 255, 255, 255)
  return params
end

local function div_parseoutline(self, outline)
  if not outline then
    return
  end
  local params = self:split(outline, ",")
  if #params ~= 2 then
    self:printf("parser <div> property outline error")
    return nil
  end
  params.size = tonumber(params[1]) or 0
  params.color = self:convertColor(params[2]) or cc.c4b(255, 255, 255, 255)
  return params
end

local function div_parseglow(self, glow)
  if not glow then
    return
  end
  local color = self:convertColor(glow) or cc.c4b(255, 255, 255, 255)
  return {color = color}
end

return function(self, params, default)
  local content = params.content
  if content then
    params.charlist = self:stringToChars(content)
  end
  local charlist = params.charlist
  local labellist = {}
  if not charlist then
    return labellist
  end
  local fontname = params.font or default.font
  local fontsize = params.fontsize or params.size or default.size
  local fontcolor = self:convertColor(params.color) or default.color
  local shadow = params.shadow
  local shadow_params = div_parseshadow(self, shadow)
  local outline = params.outline
  local outline_params = div_parseoutline(self, outline)
  local glow = params.glow
  local glow_params = div_parseglow(self, glow)
  for index, char in pairs(charlist) do
    if index == 1 and string.len(char) == 3 and string.byte(char, 1) == 239 and string.byte(char, 2) == 187 and string.byte(char, 3) == 191 then
    else
      local label = div_createlabel(self, char, fontname, fontsize, fontcolor)
      if label then
        if shadow then
          label:enableShadow(shadow_params.color, shadow_params.offset, shadow_params.blurradius)
        end
        if outline then
          label:enableOutline(outline_params.color, outline_params.size)
        end
        if glow then
          label:enableGlow(glow_params.color)
        end
        table.insert(labellist, label)
      end
    end
  end
  return labellist
end
