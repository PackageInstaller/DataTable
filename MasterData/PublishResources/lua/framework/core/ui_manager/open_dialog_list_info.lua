_class("OpenDialogListInfo", Object)
OpenDialogListInfo = OpenDialogListInfo

function OpenDialogListInfo:Constructor()
  self._uiList = {}
end

function OpenDialogListInfo:AddUIInfo(uiname, ...)
  self._uiList[#self._uiList + 1] = {
    uiname,
    {
      ...
    }
  }
end

function OpenDialogListInfo:GetUIList()
  return self._uiList
end
