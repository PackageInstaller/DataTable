_class("CSVUtil", Singleton)
CSVUtil = CSVUtil

function CSVUtil:ReadCSVFile(filename)
  local path = ResourceManager:GetInstance():GetAsset(filename, LoadType.CSV)
  local t = {}
  if path then
    local file = io.open(path, "r")
    local text = file:read("a")
    local linetable = string.split(text, "\n")
    for key, value in pairs(linetable) do
      local str = string.trimend(value, "\r")
      table.insert(t, self:ReadCSVLine(str))
    end
    file:close()
  end
  return t
end

function CSVUtil:ReadCSVLine(s)
  s = s .. ","
  local t = {}
  local fieldstart = 1
  repeat
    if string.find(s, "^\"", fieldstart) then
      local a, c
      local i = fieldstart
      repeat
        a, i, c = string.find(s, "\"(\"?)", i + 1)
      until c ~= "\""
      if not i then
        return t
      end
      local f = string.sub(s, fieldstart + 1, i - 1)
      table.insert(t, (string.gsub(f, "\"\"", "\"")))
      fieldstart = string.find(s, ",", i) + 1
    else
      local nexti = string.find(s, ",", fieldstart)
      table.insert(t, string.sub(s, fieldstart, nexti - 1))
      fieldstart = nexti + 1
    end
  until fieldstart > string.len(s)
  return t
end
