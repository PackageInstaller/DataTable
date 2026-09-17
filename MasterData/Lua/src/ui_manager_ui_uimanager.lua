local this = class("uiManager", G_EventManagerBase)
local alwaysPages = {
  loading = true,
  battle = true,
  pageFps = true,
  interactive = true,
  pageNetworkWaiting = true
}

function this:closeAllUnStackPages()
  local closeList = {}
  for _, v in pairs(L_UI.groupKeys) do
    if v ~= L_UI.groupKeys.stack then
      local pages = L_UI:getAllPages(v)
      if not table.isEmpty(pages) then
        for _, p in pairs(pages) do
          if not alwaysPages[p.pageName] then
            table.insert(closeList, p.pageName)
          end
        end
      end
    end
  end
  for _, p in pairs(closeList) do
    L_UI:close(p)
  end
end

function this:closeAllPages(callback)
  local closeList = {}
  for _, v in pairs(L_UI.groupKeys) do
    local pages = L_UI:getAllPages(v)
    if not table.isEmpty(pages) then
      for _, p in pairs(pages) do
        table.insert(closeList, p.pageName)
      end
    end
  end
  for _, p in pairs(closeList) do
    L_UI:close(p)
  end
  C_UIMgr.GetGroup(CS.Azur.Gameplay.EUIGroup.Freedom):ClearCache()
end

function this:tmpPauseInput(isPause)
  self.bInputBlocked = isPause
  C_UIMgr.uiListenerMiddleware:TempPauseInput(isPause)
  L_BattleManager:sendEvent(L_BattleManager.event.tmpPauseInput, isPause)
end

function this:pushUIRTStack(bPush)
  if self.RTStack == nil then
    self.RTStack = {}
  end
  if bPush then
    table.insert(self.RTStack, true)
  else
    table.insert(self.RTStack, false)
  end
  if self.RTStack[#self.RTStack] == true then
    C_UIMgr.EnableCubismMaskSetting(true)
  else
    C_UIMgr.EnableCubismMaskSetting(false)
  end
end

function this:popUIRTStack()
  if self.RTStack and #self.RTStack > 0 then
    table.remove(self.RTStack, #self.RTStack)
  end
end

return this
