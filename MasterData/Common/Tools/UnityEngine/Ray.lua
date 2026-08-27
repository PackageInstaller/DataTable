local rawget = _ENV.rawget
local setmetatable = _ENV.setmetatable
local Vector3 = _ENV.Vector3
local Ray = {
  direction = Vector3.zero,
  origin = Vector3.zero
}
local unity_ray = CS.UnityEngine.Ray

function Ray.__index(t, k)
  local var = rawget(Ray, k)
  if var ~= nil then
    return var
  end
  return rawget(unity_ray, k)
end

function Ray.__call(t, direction, origin)
  return Ray.New(direction, origin)
end

function Ray.New(direction, origin)
  local ray = {}
  ray.direction = direction:Normalize()
  ray.origin = origin
  setmetatable(ray, Ray)
  return ray
end

function Ray:GetPoint(distance)
  local dir = self.direction * distance
  dir:Add(self.origin)
  return dir
end

function Ray:Get()
  local o = self.origin
  local d = self.direction
  return o.x, o.y, o.z, d.x, d.y, d.z
end

function Ray:__tostring()
  return string.format("Origin:(%f,%f,%f),Dir:(%f,%f, %f)", self.origin.x, self.origin.y, self.origin.z, self.direction.x, self.direction.y, self.direction.z)
end

Ray.unity_ray = CS.UnityEngine.Ray
CS.UnityEngine.Ray = Ray
setmetatable(Ray, Ray)
return Ray
