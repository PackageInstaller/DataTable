_class("CN13PerfectPuzzlePieceItemData", Object)
CN13PerfectPuzzlePieceItemData = CN13PerfectPuzzlePieceItemData
local toint = math.tointeger

function CN13PerfectPuzzlePieceItemData:Init(data, verIndex, hoIndex, verCount, hoCount)
  self.resName = data
  self.verIndex = verIndex
  self.hoIndex = hoIndex
  self.verCount = verCount
  self.hoCount = hoCount
end
