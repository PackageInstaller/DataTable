_class("ComponentDataHelper", Object)
ComponentDataHelper = ComponentDataHelper

function ComponentDataHelper:Constructor()
end

function ComponentDataHelper.ParseData(a_data, a_out_data)
  if a_data then
    local ret, msg = lua_dc.LoadStream(a_out_data._className, a_data, a_out_data)
    if not ret then
      Log.error("[Campaign][ComponentDataHelper] ParseData lua_dc.LoadStream, _className:", a_out_data._className, ", msg = ", msg)
      return false
    else
      return true
    end
  else
    Log.error("[Campaign][ComponentDataHelper] ParseDataid: a_data is nil!")
  end
  return false
end
