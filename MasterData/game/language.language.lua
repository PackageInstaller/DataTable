local language_zh = import(".language_zh")

function textByKey(key, ...)
  local language = language_zh
  local text = language[key]
  if not text then
    print("Language can not find key >>>>", key)
    text = ""
  end
  return text
end
