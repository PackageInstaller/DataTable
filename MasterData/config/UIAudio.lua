local System = require("System.System")
local readonly = System.readonly
local UIAudio = readonly({
  [18763] = {
    ID = 18763,
    CnID = "音频@测试按钮点击",
    BaseSortID = 1,
    ImageKey = "Set",
    WwiseEvent = "Play_Ui_Com_Get_Gold"
  }
})
return UIAudio
