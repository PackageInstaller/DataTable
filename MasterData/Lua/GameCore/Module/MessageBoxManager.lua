local MessageBoxManager = {}
local objMessageBoxPanel, objPopupTipsPanel, objSideBannerPanel, objOrderWaitPanel

local function OnEvent_Open(_, mapMsg, sLanguageId)
  if type(mapMsg) == "string" then
    mapMsg = {
      nType = AllEnum.MessageBox.Tips,
      bPositive = false,
      sContent = mapMsg
    }
  elseif mapMsg == true then
    mapMsg = {
      nType = AllEnum.MessageBox.Tips,
      bPositive = true,
      sContent = ConfigTable.GetUIText(sLanguageId)
    }
  end
  if mapMsg.nType == AllEnum.MessageBox.Tips then
    if objPopupTipsPanel == nil then
      local PopupTipsPanel = require("Game.UI.MessageBoxEx.PopupTipsPanel")
      objPopupTipsPanel = PopupTipsPanel.new(AllEnum.UI_SORTING_ORDER.MessageBoxOverlay, 0, mapMsg)
      objPopupTipsPanel:_PreEnter()
      objPopupTipsPanel:_Enter()
    else
      EventManager.Hit("ContinuePopupTips", mapMsg)
    end
  elseif objMessageBoxPanel == nil then
    local MessageBoxPanel = require("Game.UI.MessageBoxEx.MessageBoxPanel")
    objMessageBoxPanel = MessageBoxPanel.new(AllEnum.UI_SORTING_ORDER.MessageBox, 0, mapMsg)
    objMessageBoxPanel:_PreEnter()
    objMessageBoxPanel:_Enter()
  else
    EventManager.Hit("ContinueMessageBox", mapMsg)
  end
end

local function OnEvent_ClosePopupTips(_)
  if objPopupTipsPanel then
    objPopupTipsPanel:_PreExit()
    objPopupTipsPanel:_Exit()
    objPopupTipsPanel:_Destroy()
    objPopupTipsPanel = nil
  end
end

local function OnEvent_CloseMessageBox(_)
  if objMessageBoxPanel then
    objMessageBoxPanel:_PreExit()
    objMessageBoxPanel:_Exit()
    objMessageBoxPanel:_Destroy()
    objMessageBoxPanel = nil
  end
end

local function OpenSideBannerPanel(mapMsg)
  local SideBannerPanel = require("Game.UI.SideBanner.SideBannerPanel")
  objSideBannerPanel = SideBannerPanel.new(AllEnum.UI_SORTING_ORDER.MessageBoxOverlay, 0, mapMsg)
  objSideBannerPanel:_PreEnter()
  objSideBannerPanel:_Enter()
end

local function OnEvent_CloseSideBanner(_)
  if objSideBannerPanel then
    objSideBannerPanel:_PreExit()
    objSideBannerPanel:_Exit()
    objSideBannerPanel:_Destroy()
    objSideBannerPanel = nil
  end
end

local function OnEvent_OpenSideBanner(_, mapMsg)
  if objSideBannerPanel == nil then
    OpenSideBannerPanel(mapMsg)
  else
    OnEvent_CloseSideBanner()
    OpenSideBannerPanel(mapMsg)
  end
end

local function OpenOrderWaitPanel(mapMsg)
  local OrderWaitPanel = require("Game.UI.Mall.OrderWaitPanel")
  objOrderWaitPanel = OrderWaitPanel.new(AllEnum.UI_SORTING_ORDER.MessageBox, 0, mapMsg)
  objOrderWaitPanel:_PreEnter()
  objOrderWaitPanel:_Enter()
end

local function OnEvent_CloseOrderWait(_)
  if objOrderWaitPanel then
    objOrderWaitPanel:_PreExit()
    objOrderWaitPanel:_Exit()
    objOrderWaitPanel:_Destroy()
    objOrderWaitPanel = nil
  end
end

local function OnEvent_OpenOrderWait(_, mapMsg)
  if objOrderWaitPanel == nil then
    OpenOrderWaitPanel(mapMsg)
  else
    OnEvent_CloseOrderWait()
    OpenOrderWaitPanel(mapMsg)
  end
end

local function Uninit(_)
  EventManager.Remove(EventId.OpenMessageBox, MessageBoxManager, OnEvent_Open)
  EventManager.Remove(EventId.CloseMessageBox, MessageBoxManager, OnEvent_CloseMessageBox)
  EventManager.Remove("OpenSideBanner", MessageBoxManager, OnEvent_OpenSideBanner)
  EventManager.Remove("CloseSideBanner", MessageBoxManager, OnEvent_CloseSideBanner)
  EventManager.Remove("OpenOrderWait", MessageBoxManager, OnEvent_OpenOrderWait)
  EventManager.Remove("CloseOrderWait", MessageBoxManager, OnEvent_CloseOrderWait)
  EventManager.Remove(EventId.CSLuaManagerShutdown, MessageBoxManager, Uninit)
end

function MessageBoxManager.CheckOrderWaitOpen()
  return objOrderWaitPanel ~= nil
end

function MessageBoxManager.Init()
  EventManager.Add(EventId.OpenMessageBox, MessageBoxManager, OnEvent_Open)
  EventManager.Add(EventId.CloseMessageBox, MessageBoxManager, OnEvent_CloseMessageBox)
  EventManager.Add(EventId.ClosePopupTips, MessageBoxManager, OnEvent_ClosePopupTips)
  EventManager.Add("OpenSideBanner", MessageBoxManager, OnEvent_OpenSideBanner)
  EventManager.Add("CloseSideBanner", MessageBoxManager, OnEvent_CloseSideBanner)
  EventManager.Add("OpenOrderWait", MessageBoxManager, OnEvent_OpenOrderWait)
  EventManager.Add("CloseOrderWait", MessageBoxManager, OnEvent_CloseOrderWait)
  EventManager.Add(EventId.CSLuaManagerShutdown, MessageBoxManager, Uninit)
end

return MessageBoxManager
