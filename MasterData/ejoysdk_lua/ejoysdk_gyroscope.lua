local E = require("ejoysdk_lua.ejoysdk")
local TAG = "ejoy_gyroscope#"
local M = {}

local function set_dummy_gyro_interface()
  local dummy_meta = {
    __index = function(_, key)
      if "supportsGyroscope" == key then
        return false
      elseif "enabled" == key then
        return false
      elseif "attitude" == key then
        return {
          1,
          0,
          0,
          0
        }
      elseif "rotationRate" == key then
        return {
          0,
          0,
          0
        }
      elseif "userAcceleration" == key then
        return {
          0,
          0,
          0
        }
      elseif "gravity" == key then
        return {
          0,
          0,
          -9.81
        }
      elseif "updateInterval" == key then
        return 0.016666666666666666
      else
        _ejoysdk.log(TAG .. " " .. "Gyro property" .. tostring(key) .. " is not support")
        return nil
      end
    end,
    __newindex = function(_, _key, _value)
    end
  }
  return dummy_meta
end

if _ejoysdk.os() == "android" then
  if E.Sysinfo.is_simulator() then
    local gyro_meta = set_dummy_gyro_interface()
    setmetatable(M, gyro_meta)
  else
    local IVK_SYSINFO_GYROSCOPE_FUNC = "SYSINFO_GYROSCOPE_STATIS_FUNC"
    local gyro_meta = {
      __index = function(_, key)
        if "enabled" == key then
          local Native_Entry = "GET_GYRO_ENABLED"
          local ret = E.sync_call(IVK_SYSINFO_GYROSCOPE_FUNC, {entry = Native_Entry})
          if ret and ret.enabled ~= nil then
            return ret.enabled
          else
            _ejoysdk.log(TAG .. " " .. "fail to get gyro enable status")
            return false
          end
        elseif "supportsGyroscope" == key then
          local IVK_SYSINFO_GYROSCOPE_SUPPORT = "SYSINFO_GYROSCOPE_SUPPORT"
          local ret = E.sync_call(IVK_SYSINFO_GYROSCOPE_SUPPORT, {})
          local is_support = ret and ret.support or false
          return is_support
        elseif "attitude" == key then
          local Native_Entry = "GYRO_ATTITUDE_FUNC"
          local ret = E.sync_call(IVK_SYSINFO_GYROSCOPE_FUNC, {entry = Native_Entry})
          if ret then
            return ret
          else
            _ejoysdk.log(TAG .. " " .. "fail to get gyro attitude ")
            return nil
          end
        elseif "rotationRate" == key then
          local Native_Entry = "GYRO_ROTATION_RATE_FUNC"
          local ret = E.sync_call(IVK_SYSINFO_GYROSCOPE_FUNC, {entry = Native_Entry})
          if ret then
            return ret
          else
            _ejoysdk.log(TAG .. " " .. "fail to get gyro rotation rate ")
            return nil
          end
        elseif "userAcceleration" == key then
          local Native_Entry = "GYRO_USER_ACCELERATION_FUNC"
          local ret = E.sync_call(IVK_SYSINFO_GYROSCOPE_FUNC, {entry = Native_Entry})
          if ret then
            return ret
          else
            _ejoysdk.log(TAG .. " " .. "fail to get gyro user acceleration")
            return nil
          end
        elseif "gravity" == key then
          local Native_Entry = "GYRO_GRAVITY_FUNC"
          local ret = E.sync_call(IVK_SYSINFO_GYROSCOPE_FUNC, {entry = Native_Entry})
          if ret then
            return ret
          else
            _ejoysdk.log(TAG .. " " .. "fail to get gyro gravity")
            return nil
          end
        elseif "updateInterval" == key then
          local Native_Entry = "GET_GYRO_UPDATE_INTERVAL"
          local ret = E.sync_call(IVK_SYSINFO_GYROSCOPE_FUNC, {entry = Native_Entry})
          if ret and ret.interval then
            return ret.interval
          else
            _ejoysdk.log(TAG .. " " .. "fail to get gyro update interval ")
            return nil
          end
        else
          _ejoysdk.log(TAG .. " " .. "Gyro property" .. tostring(key) .. " is not support")
          return nil
        end
      end,
      __newindex = function(_, key, value)
        if "enabled" == key then
          if type(value) == "boolean" then
            local Native_Entry = "SET_GYRO_ENABLED"
            E.sync_call(IVK_SYSINFO_GYROSCOPE_FUNC, {entry = Native_Entry, enable = value})
          else
            _ejoysdk.log(TAG .. " " .. "set  gyro enabled needs boolean value")
            return
          end
        elseif "updateInterval" == key then
          if type(value) == "number" then
            local Native_Entry = "SET_GYRO_UPDATE_INTERVAL"
            if value < 0.002 then
              _ejoysdk.log(TAG .. " " .. "update interval is lower than minimum value ,fall back to 0.002(500HZ)")
              value = 0.002
            end
            E.sync_call(IVK_SYSINFO_GYROSCOPE_FUNC, {entry = Native_Entry, interval = value})
          else
            _ejoysdk.log(TAG .. " " .. "set  gyro update interval needs number value")
            return
          end
        else
          _ejoysdk.log(TAG .. " " .. "Gyro." .. key .. " is read-only")
        end
      end
    }
    setmetatable(M, gyro_meta)
  end
elseif _ejoysdk.os() == "ios" then
  local gyro_meta = {
    __index = function(_, key)
      local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
      if "enabled" == key then
        local ret = _ejoysdk.sysinfo_gyro_get_status()
        if nil ~= ret then
          return ret
        else
          _ejoysdk.log(TAG .. " " .. "gyroscope#sysinfo_gyro_get_status native error")
          return false
        end
      elseif "supportsGyroscope" == key then
        local is_support = _ejoysdk.sysinfo_supports_gyroscope()
        if nil == is_support then
          _ejoysdk.log(TAG .. " " .. "gyroscope#sysinfo_supports_gyroscope native error")
          return false
        else
          return is_support
        end
      elseif "attitude" == key then
        local ret = _ejoysdk.sysinfo_gyro_get_attitude()
        if nil ~= ret then
          local attitude = CJSON.decode(ret)
          if attitude and 4 == #attitude then
            local w, x, y, z = attitude[1], attitude[2], attitude[3], attitude[4]
            if w < 0 then
              w, x, y, z = -w, -x, -y, -z
            end
            return {
              w,
              x,
              y,
              z
            }
          else
            _ejoysdk.log(TAG .. " " .. "gyroscope#sysinfo_gyro_get_attitude native error: attitude dimension wrong")
            return nil
          end
        else
          _ejoysdk.log(TAG .. " " .. "gyroscope#sysinfo_gyro_get_attitude native error")
          return nil
        end
      elseif "rotationRate" == key then
        local ret = _ejoysdk.sysinfo_gyro_get_rotation_rate()
        if nil ~= ret then
          local omega = CJSON.decode(ret)
          if omega and 3 == #omega then
            return omega
          else
            _ejoysdk.log(TAG .. " " .. "gyroscope#sysinfo_gyro_get_rotation_rate native error: omega dimension wrong")
            return nil
          end
        else
          _ejoysdk.log(TAG .. " " .. "gyroscope#sysinfo_gyro_get_rotation_rate native error")
          return nil
        end
      elseif "userAcceleration" == key then
        local ret = _ejoysdk.sysinfo_gyro_get_lin_acc()
        if nil ~= ret then
          local acc = CJSON.decode(ret)
          if acc and 3 == #acc then
            local G_TO_MPS2 = 9.81
            return {
              acc[1] * -G_TO_MPS2,
              acc[2] * -G_TO_MPS2,
              acc[3] * -G_TO_MPS2
            }
          else
            _ejoysdk.log(TAG .. " " .. "gyroscope#sysinfo_gyro_get_lin_acc native error: user acceleration dimension wrong")
            return nil
          end
        else
          _ejoysdk.log(TAG .. " " .. "gyroscope#sysinfo_gyro_get_lin_acc native error")
          return nil
        end
      elseif "gravity" == key then
        local ret = _ejoysdk.sysinfo_gyro_get_gravity()
        if nil ~= ret then
          local gravity = CJSON.decode(ret)
          if gravity and 3 == #gravity then
            local G_TO_MPS2 = 9.81
            return {
              gravity[1] * -G_TO_MPS2,
              gravity[2] * -G_TO_MPS2,
              gravity[3] * -G_TO_MPS2
            }
          else
            _ejoysdk.log(TAG .. " " .. "gyroscope#sysinfo_gyro_get_gravity native error: gravity dimension wrong")
            return nil
          end
        else
          _ejoysdk.log(TAG .. " " .. "gyroscope#sysinfo_gyro_get_gravity native error")
          return nil
        end
      elseif "updateInterval" == key then
        local ret = _ejoysdk.sysinfo_gyro_get_interval()
        if ret then
          return ret
        else
          _ejoysdk.log(TAG .. " " .. "gyroscope#sysinfo_gyro_get_interval native error ")
          return nil
        end
      else
        _ejoysdk.log(TAG .. " " .. "Gyro property" .. tostring(key) .. " is not support")
        return nil
      end
    end,
    __newindex = function(_, key, value)
      if "enabled" == key then
        if type(value) == "boolean" then
          _ejoysdk.sysinfo_gyro_set_status(value)
        else
          _ejoysdk.log(TAG .. " " .. "set  gyro enabled needs boolean value")
          return
        end
      elseif "updateInterval" == key then
        if type(value) == "number" then
          if value < 0 then
            _ejoysdk.log(TAG .. " " .. "update interval is an illegal negative value")
            return
          end
          if value < 0.002 then
            _ejoysdk.log(TAG .. " " .. "update interval is lower than minimum value, fall back to 0.002s(500HZ)")
            value = 0.002
          end
          _ejoysdk.sysinfo_gyro_set_interval(value)
          local enabled = _ejoysdk.sysinfo_gyro_get_status()
          if enabled then
            _ejoysdk.sysinfo_gyro_set_status(false)
            _ejoysdk.sysinfo_gyro_set_status(true)
          end
        else
          _ejoysdk.log(TAG .. " " .. "set  gyro update interval needs number value")
          return
        end
      else
        _ejoysdk.log(TAG .. " " .. "Gyro." .. key .. " is read-only")
      end
    end
  }
  setmetatable(M, gyro_meta)
elseif _ejoysdk.os() == "harmonyos" then
  local jf = lunate.js_functions
  local _gyro_api = jf.utils().gyroInfo
  local ET = require("ejoysdk_lua.ejoysdk_topic")
  ET.subscribe("CROSS_VM_APP_LIFE_CIRCLE_EVENT", function(life_data)
    life_data = life_data or {}
    _ejoysdk.log(TAG .. " " .. "receive lifecycle in game vm:" .. tostring(life_data.life))
    if life_data.life == "onBackground" then
      _gyro_api:onBackground()
    elseif life_data.life == "onForeground" then
      _gyro_api:onForeground()
    end
    ET.publish("APP_LIFE_CIRCLE_EVENT", life_data)
  end)
  if E.Sysinfo.is_simulator() then
    local gyro_meta = set_dummy_gyro_interface()
    setmetatable(M, gyro_meta)
  else
    local gyro_meta = {
      __index = function(_, key)
        if "enabled" == key then
          local _ret = _gyro_api:getEnabled()
          if _ret then
            local ret = lunate.deepcopy(_ret)
            return ret.enabled
          else
            _ejoysdk.log(TAG .. " " .. "fail to get gyro enable status")
            return false
          end
        elseif "supportsGyroscope" == key then
          local _ret = _gyro_api:getSupport()
          if _ret then
            local ret = lunate.deepcopy(_ret)
            return ret.supported
          else
            _ejoysdk.log(TAG .. " " .. "fail to get gyro support status")
            return false
          end
        elseif "attitude" == key then
          local _ret = _gyro_api:getAttitude()
          if _ret then
            local ret = lunate.deepcopy(_ret)
            return {
              ret.w,
              ret.x,
              ret.y,
              ret.z
            }
          else
            _ejoysdk.log(TAG .. " " .. "fail to get gyro attitude ")
            return nil
          end
        elseif "rotationRate" == key then
          local _ret = _gyro_api:getRotationRate()
          if _ret then
            local ret = lunate.deepcopy(_ret)
            return {
              ret.x,
              ret.y,
              ret.z
            }
          else
            _ejoysdk.log(TAG .. " " .. "fail to get gyro rotation rate")
            return nil
          end
        elseif "userAcceleration" == key then
          local _ret = _gyro_api:getUserAcceleration()
          if _ret then
            local ret = lunate.deepcopy(_ret)
            return {
              ret.x,
              ret.y,
              ret.z
            }
          else
            _ejoysdk.log(TAG .. " " .. "fail to get gyro user acceleration")
            return nil
          end
        elseif "gravity" == key then
          local _ret = _gyro_api:getGravity()
          if _ret then
            local ret = lunate.deepcopy(_ret)
            return {
              ret.x,
              ret.y,
              ret.z
            }
          else
            _ejoysdk.log(TAG .. " " .. "fail to get gyro gravity")
            return nil
          end
        elseif "updateInterval" == key then
          local _ret = _gyro_api:getUpdateInterval()
          if _ret then
            local ret = lunate.deepcopy(_ret)
            return ret.interval
          else
            _ejoysdk.log(TAG .. " " .. "fail to get gyro update interval ")
            return nil
          end
        else
          _ejoysdk.log(TAG .. " " .. "Gyro property " .. tostring(key) .. " is not support")
          return nil
        end
      end,
      __newindex = function(_, key, value)
        if "enabled" == key then
          if type(value) == "boolean" then
            _gyro_api:setEnabled(value)
          else
            _ejoysdk.log(TAG .. " " .. "set  gyro enabled needs boolean value")
            return
          end
        elseif "updateInterval" == key then
          if type(value) == "number" then
            if value < 0.002 then
              _ejoysdk.log(TAG .. " " .. "update interval is lower than minimum value, fall back to 0.002(500HZ)")
              value = 0.002
            end
            _gyro_api:setUpdateInterval(value)
          else
            _ejoysdk.log(TAG .. " " .. "set  gyro update interval needs number value")
            return
          end
        else
          _ejoysdk.log(TAG .. " " .. "Gyro property" .. tostring(key) .. " is not supported to set!!")
        end
      end
    }
    setmetatable(M, gyro_meta)
  end
end
return M
