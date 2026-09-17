local this = {}
this.pattern = "{(.-)}"

function this.getArgsDictByMailContent(content)
  local argsDict = {}
  if string.isEmpty(content) then
    return nil, content
  end
  local isFind = string.find(content, this.pattern)
  if not isFind then
    return nil, content
  end
  for matchStr in string.gmatch(content, this.pattern) do
    local list = string.split(matchStr, "|")
    local argsType = list[1]
    argsDict[argsType] = this.parseArgs(argsType, list)
  end
  local newContent = string.gsub(content, this.pattern, "")
  printf("getArgsDictByMailContent", newContent, argsDict)
  return argsDict, newContent
end

function this.parseArgs(argsType, list)
  local funcName = "parseArgs_" .. argsType
  if this[funcName] then
    return this[funcName](list)
  end
end

function this.parseArgs_url(list)
  return {
    showStr = list[2],
    url = list[3],
    questionId = tonumber(list[4]),
    rwMailId = tonumber(list[5])
  }
end

return this
