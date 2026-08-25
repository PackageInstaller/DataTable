local CopyBackJumpUtils = {}
CopyBackJumpUtils.CheckStackJumpPanel = {
  [Urls.GuideNoteMainView] = {isSilent = true}
}
CopyBackJumpUtils.PanelJumpFunc = {
  [Urls.GuideNoteMainView] = function(_, params)
    GuideNoteDataUtils.OpenMainView(params.page, {
      targetStageGroupTid = params.stageGroupTid
    })
  end
}
CopyBackJumpUtils.StaticParams = {
  [Urls.GuideNoteMainView] = {
    page = function()
      return GuideNoteModel.Instance and GuideNoteModel.Instance:GetCurPage()
    end
  }
}

function CopyBackJumpUtils._GetBattleFinishJumper(url, params)
  local jumper = CopyBackJumpUtils.PanelJumpFunc[url]
  if type(jumper) == "function" then
    return function()
      jumper(url, params or {})
    end
  else
    return function()
      UIManager.Instance:Reopen(url)
    end
  end
end

function CopyBackJumpUtils._GetPanelList()
  local urlList = {}
  local _, panelList = UIManager.Instance:GetTopFullScreenPanel()
  for i = #(panelList or {}), 1, -1 do
    if CopyBackJumpUtils.CheckStackJumpPanel[panelList[i].url] then
      table.insert(urlList, panelList[i].url)
    end
  end
  return urlList
end

function CopyBackJumpUtils._SilentOpenPanel(url)
  local panel = UIManager.Instance:GetWindow(url)
  if panel then
    panel:SetRendered(false)
    panel.closeWithoutAnim = true
  end
end

function CopyBackJumpUtils._StartStackJump(urlList, params, cb, notSilent)
  CopyBackJumpUtils.startStackJumpFunc = nil
  for i = 1, #urlList do
    local url = urlList[i]
    local isTop = i == #urlList
    local checkCfg = CopyBackJumpUtils.CheckStackJumpPanel[url]
    local isSilent = checkCfg and checkCfg.isSilent
    local jumper = CopyBackJumpUtils._GetBattleFinishJumper(url, params)
    if isTop and (notSilent or not isSilent) then
      if jumper then
        jumper()
      end
    else
      local existingPanel = UIManager.Instance:GetWindow(url)
      if existingPanel then
        existingPanel.closeWithoutAnim = true
      end
      if jumper then
        jumper()
      end
      CopyBackJumpUtils._SilentOpenPanel(url)
    end
  end
  if cb then
    cb()
  end
end

CopyBackJumpUtils.startStackJumpFunc = nil
CopyBackJumpUtils.needStackJump = false

function CopyBackJumpUtils.Reset()
  CopyBackJumpUtils.startStackJumpFunc = nil
  CopyBackJumpUtils.needStackJump = false
end

function CopyBackJumpUtils.GetIsNeedStackJump()
  local urlList = CopyBackJumpUtils._GetPanelList()
  CopyBackJumpUtils.needStackJump = #urlList > 0
  return CopyBackJumpUtils.needStackJump
end

function CopyBackJumpUtils.GetStartStackJumpFunc(stageTid)
  local urlList = CopyBackJumpUtils._GetPanelList()
  local params = {
    stageTid = stageTid,
    stageGroupTid = CopyDataUtils.GetStageGroupId(stageTid)
  }
  for i = 1, #urlList do
    local paramTable = CopyBackJumpUtils.StaticParams[urlList[i]]
    if paramTable then
      for k, v in pairs(paramTable) do
        params[k] = type(v) == "function" and v() or v
      end
    end
  end
  
  function CopyBackJumpUtils.startStackJumpFunc(cb, notSilent)
    CopyBackJumpUtils._StartStackJump(urlList, params, cb, notSilent)
  end
  
  return CopyBackJumpUtils.startStackJumpFunc
end

return CopyBackJumpUtils
