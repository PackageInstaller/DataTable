local print = print
local table = table
local string = string
local _M = {}
local LABEL_DIV_BEGIN = "<div>"
local LABEL_DIV_END = "</div>"
local BOOLEAN_TRUE = "true"
local BOOLEAN_FALSE = "false"

function _M.parse(text)
  local parsedtable = {}
  if not string.find(text, "^%b<>.+%b<>$") then
    text = table.concat({
      LABEL_DIV_BEGIN,
      text,
      LABEL_DIV_END
    })
  end
  local labelheadstack = {}
  local index = 0
  for beginindex, endindex in function()
    return string.find(text, "%b<>", index)
  end, nil, nil do
    local label = string.sub(text, beginindex, endindex)
    if string.find(label, "^</") then
      _M.disposeLabelTail(labelheadstack, parsedtable, text, label, beginindex, endindex)
    elseif string.find(label, "/>$") then
      _M.disposeLabelSelfClosing(labelheadstack, parsedtable, text, label, beginindex, endindex)
    else
      _M.disposeLabelHead(labelheadstack, parsedtable, text, label, beginindex, endindex)
    end
    index = endindex + 1
  end
  return parsedtable
end

function _M.disposeLabelHead(labelheadstack, parsedtable, text, labelhead, beginindex, endindex)
  local labelinfo = _M.peekstack(labelheadstack)
  if labelinfo then
    local content = string.sub(text, labelinfo.endindex + 1, beginindex - 1)
    local labelparams = _M.parseLabelWithContent(labelinfo.labelhead, content)
    table.insert(parsedtable, labelparams)
  end
  _M.pushstack(labelheadstack, {
    labelhead = labelhead,
    beginindex = beginindex,
    endindex = endindex
  })
end

function _M.disposeLabelTail(labelheadstack, parsedtable, text, labeltail, beginindex, endindex, selfclosing)
  local labelinfo = _M.popstack(labelheadstack)
  if labelinfo then
    if not _M.checkLabelMatch(labelinfo.labelhead, labeltail) then
      return print(string.format("labelparser # error: label can not match(%s, %s)", labelinfo.labelhead, labeltail))
    end
    local content = string.sub(text, labelinfo.endindex + 1, beginindex - 1)
    local labelparams = _M.parseLabelWithContent(labelinfo.labelhead, content, selfclosing)
    table.insert(parsedtable, labelparams)
    local labelinfo_unused = _M.peekstack(labelheadstack)
    if labelinfo_unused then
      labelinfo_unused.beginindex = beginindex
      labelinfo_unused.endindex = endindex
    end
  end
end

function _M.disposeLabelSelfClosing(labelheadstack, parsedtable, text, label, beginindex, endindex)
  _M.disposeLabelHead(labelheadstack, parsedtable, text, label, beginindex, endindex)
  _M.disposeLabelTail(labelheadstack, parsedtable, text, label, beginindex, endindex, true)
end

function _M.checkLabelMatch(labelhead, labeltail)
  local labelheadname = _M.parseLabelname(labelhead)
  local labeltailname = _M.parseLabelname(labeltail)
  return labeltailname == labelheadname
end

function _M.parseLabelWithContent(labelhead, content, selfclosing)
  if not selfclosing then
    if content == nil or content == "" then
      return
    end
  else
    content = nil
  end
  local labelname = _M.parseLabelname(labelhead)
  local labelparams = _M.parseLabelHead(labelhead)
  labelparams.labelname = labelname
  labelparams.content = content
  return labelparams
end

function _M.parseLabelname(label)
  local labelnameindex1, labelnameindex2 = string.find(label, "%w+")
  if not labelnameindex1 then
    return print("labelparser # error: label name not found") and nil
  end
  local labelname = string.sub(label, labelnameindex1, labelnameindex2)
  local labelname = string.lower(labelname)
  return labelname
end

function _M.parseLabelHead(labelhead)
  local labelparams = {}
  for property in string.gmatch(labelhead, "[%w%_]+%=[^%s%>]+") do
    local equalmarkpos = string.find(property, "=")
    local propertyname = string.sub(property, 1, equalmarkpos - 1)
    local propertyvalue = string.sub(property, equalmarkpos + 1, string.len(property))
    propertyname = string.lower(propertyname)
    local continue = false
    local beginindex, endindex = string.find(propertyvalue, "['\"].+['\"]")
    if beginindex then
      propertyvalue = string.sub(propertyvalue, beginindex + 1, endindex - 1)
      continue = true
    end
    if not continue then
      local propertyvalue_lower = string.lower(propertyvalue)
      if propertyvalue_lower == BOOLEAN_TRUE then
        propertyvalue = true
        continue = true
      elseif propertyvalue_lower == BOOLEAN_FALSE then
        propertyvalue = false
        continue = true
      end
    end
    if not continue then
      local propertyvalue_number = tonumber(propertyvalue)
      if propertyvalue_number then
        propertyvalue = propertyvalue_number
        continue = true
      end
    end
    labelparams[propertyname] = propertyvalue
  end
  return labelparams
end

function _M.peekstack(stacktable)
  return stacktable[#stacktable]
end

function _M.pushstack(stacktable, elem)
  table.insert(stacktable, elem)
end

function _M.popstack(stacktable)
  local elem = stacktable[#stacktable]
  stacktable[#stacktable] = nil
  return elem
end

return _M
