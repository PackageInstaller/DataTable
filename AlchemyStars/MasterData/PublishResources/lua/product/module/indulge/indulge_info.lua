local IndulgeType = {
  InstructionType_Tips = 1,
  InstructionType_Logout = 2,
  InstructionType_OpenUrl = 3
}
_enum("IndulgeType", IndulgeType)
_class("MobileindulgeInfo", Object)
MobileindulgeInfo = MobileindulgeInfo

function MobileindulgeInfo:Constructor()
  self.type = 0
  self.title = ""
  self.msg = ""
  self.url = ""
  self.modal = 0
  self.data = ""
  self.ratio = 0.0
  self.ruleName = ""
end

MobileindulgeInfo._proto = {
  [1] = {"type", "int"},
  [2] = {"title", "string"},
  [3] = {"msg", "string"},
  [4] = {"url", "string"},
  [5] = {"modal", "int"},
  [6] = {"data", "string"},
  [7] = {"ratio", "double"},
  [8] = {"ruleName", "string"}
}
