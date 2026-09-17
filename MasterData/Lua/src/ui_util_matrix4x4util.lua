local this = {}
local matrix4x4 = {}

function matrix4x4:multiplyPoint(v3)
  local x = v3.x
  local y = v3.y
  local z = v3.z
  local w = 1
  local transformed_x = self[1][1] * x + self[1][2] * y + self[1][3] * z + self[1][4] * w
  local transformed_y = self[2][1] * x + self[2][2] * y + self[2][3] * z + self[2][4] * w
  local transformed_z = self[3][1] * x + self[3][2] * y + self[3][3] * z + self[3][4] * w
  local transformed_w = self[4][1] * x + self[4][2] * y + self[4][3] * z + self[4][4] * w
  if transformed_w ~= 1 and transformed_w ~= 0 then
    transformed_x = transformed_x / transformed_w
    transformed_y = transformed_y / transformed_w
    transformed_z = transformed_z / transformed_w
  end
  return L_Vector3.new(transformed_x, transformed_y, transformed_z)
end

function matrix4x4:inverse()
  local inv = {
    {},
    {},
    {},
    {}
  }
  local m = self
  local det = 0
  for i = 1, 4 do
    for j = 1, 4 do
      local subMat = {}
      for si = 1, 4 do
        if si ~= i then
          local row = {}
          for sj = 1, 4 do
            if sj ~= j then
              table.insert(row, m[si][sj])
            end
          end
          table.insert(subMat, row)
        end
      end
      local subDet = subMat[1][1] * (subMat[2][2] * subMat[3][3] - subMat[2][3] * subMat[3][2]) - subMat[1][2] * (subMat[2][1] * subMat[3][3] - subMat[2][3] * subMat[3][1]) + subMat[1][3] * (subMat[2][1] * subMat[3][2] - subMat[2][2] * subMat[3][1])
      inv[j][i] = ((i + j) % 2 == 0 and 1 or -1) * subDet
      if i == 1 then
        det = det + m[1][j] * inv[j][i]
      end
    end
  end
  if det == 0 then
    error("Matrix is not invertible!")
  else
    for i = 1, 4 do
      for j = 1, 4 do
        inv[i][j] = inv[i][j] / det
      end
    end
  end
  return this.new(inv)
end

local ma = {
  __index = matrix4x4,
  __add = function(a, b)
    local result = {}
    for i = 1, 4 do
      result[i] = {}
      for j = 1, 4 do
        result[i][j] = a[i][j] + b[i][j]
      end
    end
    return this.new(result)
  end,
  __sub = function(a, b)
    local result = {}
    for i = 1, 4 do
      result[i] = {}
      for j = 1, 4 do
        result[i][j] = a[i][j] - b[i][j]
      end
    end
    return this.new(result)
  end,
  __mul = function(a, b)
    if type(a) == "number" then
      local result = {}
      for i = 1, 4 do
        result[i] = {}
        for j = 1, 4 do
          result[i][j] = a * b[i][j]
        end
      end
      return this.new(result)
    elseif type(b) == "number" then
      local result = {}
      for i = 1, 4 do
        result[i] = {}
        for j = 1, 4 do
          result[i][j] = a[i][j] * b
        end
      end
      return this.new(result)
    else
      local result = {}
      for i = 1, 4 do
        result[i] = {}
        for j = 1, 4 do
          result[i][j] = 0
          for k = 1, 4 do
            result[i][j] = result[i][j] + a[i][k] * b[k][j]
          end
        end
      end
      return this.new(result)
    end
  end,
  __div = function(a, b)
    if type(b) == "number" then
      local result = {}
      for i = 1, 4 do
        for j = 1, 4 do
          result[i][j] = a[i][j] / b
        end
      end
      return this.new(result)
    else
      error("Matrix division by another matrix is undefined")
    end
  end
}

function this.new(matrix)
  matrix = matrix or {
    {
      0,
      0,
      0,
      0
    },
    {
      0,
      0,
      0,
      0
    },
    {
      0,
      0,
      0,
      0
    },
    {
      0,
      0,
      0,
      0
    }
  }
  return setmetatable(matrix, ma)
end

function this.createTranslation(dx, dy, dz)
  local matrix = {
    {
      1,
      0,
      0,
      dx
    },
    {
      0,
      1,
      0,
      dy
    },
    {
      0,
      0,
      1,
      dz
    },
    {
      0,
      0,
      0,
      1
    }
  }
  return this.new(matrix)
end

function this.createScale(sx, sy, sz)
  local matrix = {
    {
      sx,
      0,
      0,
      0
    },
    {
      0,
      sy,
      0,
      0
    },
    {
      0,
      0,
      sz,
      0
    },
    {
      0,
      0,
      0,
      1
    }
  }
  return this.new(matrix)
end

function this.createRotationY(y)
  y = math.rad(y)
  local cy = math.cos(y)
  local sy = math.sin(y)
  local matrix = {
    {
      cy,
      0,
      sy,
      0
    },
    {
      0,
      1,
      0,
      0
    },
    {
      -sy,
      0,
      cy,
      0
    },
    {
      0,
      0,
      0,
      1
    }
  }
  return this.new(matrix)
end

function this.createRotation(x, y, z)
  local matrix = this.new()
  x = math.rad(x)
  y = math.rad(y)
  z = math.rad(z)
  local cx = math.cos(x)
  local sx = math.sin(x)
  local cy = math.cos(y)
  local sy = math.sin(y)
  local cz = math.cos(z)
  local sz = math.sin(z)
  matrix[1][1] = cy * cz
  matrix[2][1] = sx * sy - cx * sy * sz
  matrix[3][1] = cx * sy + sx * sy * sz
  matrix[1][2] = cy * sz
  matrix[2][2] = sx * sy * sz + cx * cz
  matrix[3][2] = cx * sy * sz - sx * cz
  matrix[1][3] = -sy
  matrix[2][3] = sx * cy
  matrix[3][3] = cx * cy
  matrix[4][4] = 1
  return matrix
end

function this.createTrs(pos, rot, scale)
  local trsMatrix = this.new()
  local cx = math.cos(rot.x)
  local sx = math.sin(rot.x)
  local cy = math.cos(rot.y)
  local sy = math.sin(rot.y)
  local cz = math.cos(rot.z)
  local sz = math.sin(rot.z)
  trsMatrix[1][1] = cy * cz * scale.x
  trsMatrix[2][1] = (sx * sy + cx * cy * sz) * scale.x
  trsMatrix[3][1] = (-cx * sy + sx * cy * sz) * scale.x
  trsMatrix[1][2] = -cy * sz * scale.y
  trsMatrix[2][2] = (cx * cz - sx * sy * sz) * scale.y
  trsMatrix[3][2] = (sx * cz + cx * sy * sz) * scale.y
  trsMatrix[1][3] = sy * scale.z
  trsMatrix[2][3] = -sx * cy * scale.z
  trsMatrix[3][3] = cx * cy * scale.z
  trsMatrix[1][4] = pos.x
  trsMatrix[2][4] = pos.y
  trsMatrix[3][4] = pos.z
  trsMatrix[4][4] = 1
  return trsMatrix
end

return this
