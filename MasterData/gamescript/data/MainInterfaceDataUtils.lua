local MainInterfaceDataUtils = {}

function MainInterfaceDataUtils.ResetAll()
  DataCenter.mainInterfaceData.curShowAwaker = 0
  DataCenter.mainInterfaceData.curNaviFunc = ""
  DataCenter.mainInterfaceData.recoverAwakerPanel = false
end

return MainInterfaceDataUtils
