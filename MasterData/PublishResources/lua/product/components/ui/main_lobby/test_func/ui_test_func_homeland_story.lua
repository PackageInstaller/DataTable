_class("UITestFuncHomelandStory", UICustomWidget)
UITestFuncHomelandStory = UITestFuncHomelandStory

function UITestFuncHomelandStory:OnShow(uiParams)
  self:ShowSaveHomeList()
end

function UITestFuncHomelandStory:OnHide()
end

function UITestFuncHomelandStory:ShowSaveHomeList()
  self._homeStoryInp = self:GetUIComponent("InputField", "HomeStoryInputField")
  local uiHomeModule = GameGlobal.GetUIModule(HomelandModule)
  local saveStoryList = uiHomeModule:SaveStoryList()
  if saveStoryList and next(saveStoryList) then
    local showTex = ""
    for i = 1, #saveStoryList do
      local id = saveStoryList
      showTex = showTex .. tostring(id)
      if i ~= #saveStoryList then
        showTex = showTex .. ","
      end
    end
    self._homeStoryInp.text = showTex
  end
end

function UITestFuncHomelandStory:HomeStorySaveBtnOnClick(go)
  local uiHomeModule = GameGlobal.GetUIModule(HomelandModule)
  local tex = self._homeStoryInp.text
  local idStrs = string.split(tex, ",")
  local idList = {}
  for i = 1, #idStrs do
    local succ = pcall(function()
      local id = tonumber(idStrs[i])
      table.insert(idList, id)
    end)
  end
  local tips = ""
  for i = 1, #idList do
    local id = idList[i]
    tips = tips .. tostring(id)
    if i ~= #idList then
      tips = tips .. ","
    end
  end
  local count = table.count(idList)
  ToastManager.ShowToast("保存成功,触发剧情" .. count .. "个,ID:" .. tips)
  uiHomeModule:SaveStoryList(idList)
end
