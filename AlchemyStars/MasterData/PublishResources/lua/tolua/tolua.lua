if jit then
  if jit.opt then
    jit.opt.start(3)
  end
  print("ver" .. jit.version_num .. " jit: ", jit.status())
  print(string.format("os: %s, arch: %s", jit.os, jit.arch))
end
if DebugServerIp then
  require("mobdebug").start(DebugServerIp)
end
require("functions")
Mathf = require("umathf")
Vector3 = require("vector3")
Quaternion = require("quaternion")
Vector2 = require("vector2")
Vector4 = require("vector4")
Color = require("color")
Ray = require("ray")
Bounds = require("bounds")
RaycastHit = require("raycasthit")
Touch = require("touch")
LayerMask = require("layermask")
Plane = require("plane")
Time = reimport("utime")
list = require("list")
utf8 = require("utf8")
require("typeof")
require("valuetype")
require("bindingflags")
