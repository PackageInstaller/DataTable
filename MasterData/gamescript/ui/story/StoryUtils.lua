local StoryUtils, Super = System.NewClass("StoryUtils")

function StoryUtils.ParseToHtml(optionText)
  local htmlText = optionText
  local optionReg = "{(.-)%*(.-)%*(.-)}"
  for cfgName, cfgId, cfgField in string.gmatch(optionText, optionReg) do
    local content
    if "Item" == cfgName and "Name" == cfgField then
      content = ItemDataUtils.GetRichItemName(cfgId, nil, false)
    else
      local cfg = DT[cfgName] and DT[cfgName][cfgId] or {}
      content = cfg[cfgField]
    end
    if content then
      content = string.format("<link=\"\">%s</link>", content)
      htmlText = string.gsub(htmlText, optionReg, content, 1)
    else
      Logger.Warn("%s*%s*%s 配置错误", cfgName, cfgId, cfgField)
    end
  end
  return htmlText
end

function StoryUtils.GetParams(text)
  local params = {}
  local optionReg = "{(.+)%*(.+)%*(.+)}"
  for cfgName, cfgId, cfgField in string.gmatch(text, optionReg) do
    table.insert(params, {
      cfgName,
      cfgId,
      cfgField
    })
  end
  return params
end

return StoryUtils
