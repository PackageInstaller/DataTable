local ByteBuffer = class("ByteBuffer")
ByteBuffer.PACKAGE_HEAD_FMT = ">H"
ByteBuffer.PACKAGE_HEAD_SIZE = 2

function ByteBuffer:ctor()
  self._readBuffer = cc.CircularBuffer:create()
  self._remainSize = 0
end

function ByteBuffer:paserMessage(byteString)
  local msgs = {}
  self._readBuffer:Write(byteString, #byteString)
  while true do
    if self._remainSize == 0 then
      if self._readBuffer:GetSize() < ByteBuffer.PACKAGE_HEAD_SIZE then
        return msgs
      end
      local head = self._readBuffer:Read(ByteBuffer.PACKAGE_HEAD_SIZE)
      self._remainSize = struct.unpack(ByteBuffer.PACKAGE_HEAD_FMT, head)
    end
    if self._remainSize == 0 then
      return msgs
    end
    if self._readBuffer:GetSize() < self._remainSize then
      return msgs
    end
    local data = self._readBuffer:Read(self._remainSize)
    msgs[#msgs + 1] = data
    self._remainSize = 0
  end
  return msgs
end

function ByteBuffer:reset()
  self._readBuffer:clear()
  self._remainSize = 0
end

return ByteBuffer
