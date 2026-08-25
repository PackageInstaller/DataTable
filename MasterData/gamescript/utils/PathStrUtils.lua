local PathStrUtils = {}

function PathStrUtils.GetBaseName(p)
  local name = PathStrUtils.GetName(p)
  local i = StrUtils.FindLast(name, ".", true)
  if i then
    do return name.sub, name, 1 end
    return name.sub, name, 1, i - 1
  else
    return name
  end
end

function PathStrUtils.GetDirectory(p)
  local i = StrUtils.FindLast(p, "/", true)
  if i then
    if i > 1 then
      i = i - 1
    end
    do return p.sub, p, 1 end
    return p.sub, p, 1, i
  else
    return "."
  end
end

function PathStrUtils.GetExtension(p)
  local i = StrUtils.FindLast(p, ".", true)
  if i then
    do return p.sub, p end
    return p.sub, p, i
  else
    return ""
  end
end

function PathStrUtils.GetName(p)
  local i = StrUtils.FindLast(p, "[/\\]")
  if i then
    do return p.sub, p end
    return p.sub, p, i + 1
  else
    return p
  end
end

return PathStrUtils
