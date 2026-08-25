local Input = CS.UnityEngine.Input
local KeyCode = CS.UnityEngine.KeyCode
local ShortCutKeys = {}
ShortCutKeys.CtrlKeys = {
  KeyCode.LeftControl,
  KeyCode.RightControl,
  KeyCode.LeftShift,
  KeyCode.RightShift,
  KeyCode.LeftAlt,
  KeyCode.RightAlt
}
local NormalKeys = {}
local KeyCodes = CS.System.Enum.GetValues(typeof(KeyCode))
for i = 0, KeyCodes.Length - 1 do
  local key = KeyCodes[i]
  if not table.contains(ShortCutKeys.CtrlKeys, key) then
    local keyStr = key:ToString()
    if keyStr and #keyStr > 0 then
      NormalKeys[key] = keyStr
    end
  end
end
ShortCutKeys.NormalKeys = NormalKeys
ShortCutKeys.SpecialKeys = {
  [KeyCode.Alpha0] = "0",
  [KeyCode.Alpha1] = "1",
  [KeyCode.Alpha2] = "2",
  [KeyCode.Alpha3] = "3",
  [KeyCode.Alpha4] = "4",
  [KeyCode.Alpha5] = "5",
  [KeyCode.Alpha6] = "6",
  [KeyCode.Alpha7] = "7",
  [KeyCode.Alpha8] = "8",
  [KeyCode.Alpha9] = "9",
  [KeyCode.Escape] = "ESC",
  [KeyCode.Space] = "Space",
  [KeyCode.Return] = "Enter",
  [KeyCode.KeypadEnter] = "Enter",
  [KeyCode.LeftControl] = "Control",
  [KeyCode.RightControl] = "Control",
  [KeyCode.LeftShift] = "Shift",
  [KeyCode.BackQuote] = "~",
  [KeyCode.RightShift] = "Shift",
  [KeyCode.LeftAlt] = "Alt",
  [KeyCode.RightAlt] = "Alt"
}

function ShortCutKeys.ProcessKeyInput()
end

function ShortCutKeys.Key2String(key)
  return ShortCutKeys.SpecialKeys[key] or NormalKeys[key]
end

local ctrlKeyStrList = {}
local normalKeyStrList = {}

function ShortCutKeys.GetPressKeyCodeStrs()
  table.clear(ctrlKeyStrList)
  table.clear(normalKeyStrList)
  for _, key in ipairs(ShortCutKeys.CtrlKeys) do
    if Input.GetKey(key) then
      table.insert(ctrlKeyStrList, ShortCutKeys.Key2String(key))
    end
  end
  for key in pairs(NormalKeys) do
    if Input.GetKeyDown(key) then
      table.insert(normalKeyStrList, ShortCutKeys.Key2String(key))
    end
  end
  return ctrlKeyStrList, normalKeyStrList
end

function ShortCutKeys.IsLeftMouseDown()
  do return Input.GetKeyDown end
  return Input.GetKeyDown, KeyCode.Mouse0
end

return ShortCutKeys
