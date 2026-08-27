CustomCSStreamReader = {}
CustomCSStreamReader.__index = CustomCSStreamReader
local cs_MemoryStream = CS.System.IO.MemoryStream
local cs_BinaryReader = CS.System.IO.BinaryReader
local cs_SeekOrigin = CS.System.IO.SeekOrigin

function CustomCSStreamReader.New(bytes)
  local o = {}
  local memoryStream = cs_MemoryStream(bytes)
  o.binaryReader = cs_BinaryReader(memoryStream)
  setmetatable(o, CustomCSStreamReader)
  return o
end

function CustomCSStreamReader:read(count)
  return self.binaryReader:ReadBytes(count)
end

function CustomCSStreamReader:seek(seekOrigin, offset)
  if offset == nil then
    offset = 0
  end
  if seekOrigin == "set" then
    self.binaryReader.BaseStream:Seek(offset, cs_SeekOrigin.Begin)
  elseif seekOrigin == "cur" then
    self.binaryReader.BaseStream:Seek(offset, cs_SeekOrigin.Current)
  elseif seekOrigin == "end" then
    self.binaryReader.BaseStream:Seek(offset, cs_SeekOrigin.End)
  end
end

function CustomCSStreamReader:close()
  self.binaryReader:Close()
  self.binaryReader = nil
end

return CustomCSStreamReader
