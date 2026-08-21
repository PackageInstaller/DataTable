_class("AttrSys", Singleton)
AttrSys = AttrSys
local toint = math.tointeger

function AttrSys.GetFormatNum(num)
  local num0 = num / 1000000000
  local num1 = num / 100000000
  local num2 = num / 100000
  local num3 = num / 10000
  local s = num
  if 1 <= num0 then
    s = StringTable.Get("str_common_hundreds_of_millions_of", toint(num1))
  elseif 1 <= num1 then
    if num - num1 * 100000000 >= 10000000 then
      s = StringTable.Get("str_common_hundreds_of_millions_of", string.format("%0.1f", num1))
    else
      s = StringTable.Get("str_common_hundreds_of_millions_of", toint(num1))
    end
  elseif 1 <= num2 then
    s = StringTable.Get("str_common_tens_of_thousands_of", toint(num3))
  elseif 1 <= num3 then
    if num - math.floor(num3) * 10000 >= 1000 then
      s = StringTable.Get("str_common_tens_of_thousands_of", string.format("%0.1f", num3))
    else
      s = StringTable.Get("str_common_tens_of_thousands_of", toint(num3))
    end
  else
    s = toint(num)
  end
  return s
end

function AttrSys.FillForcenum()
end

function AttrSys.GetLanguage()
  return Localization.GetCurLanguage()
end

function AttrSys.GetLanguages()
  return Localization.GetLanguages()
end
