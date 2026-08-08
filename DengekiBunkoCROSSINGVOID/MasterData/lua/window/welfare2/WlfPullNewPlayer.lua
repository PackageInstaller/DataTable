local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local Msdk = CS.Msdk
local m_stBusy = false

function Awake()
  WU.BindButtonEvent(REF.ButtonShare, OnClickButtonShare)
  local tabSlotSpriteName = ""
  local accountCache = this:GetData("accountCache")
  if accountCache.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_QQ then
    tabSlotSpriteName = "welfare_21"
  elseif accountCache.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_Wechat then
    tabSlotSpriteName = "welfare_21"
  elseif accountCache.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_Guest then
    tabSlotSpriteName = "welfare_21"
  end
  _ENV["$"](REF.TabSlotPullNewPlayer).SpriteFront.UISprite.spriteName = tabSlotSpriteName
end

function OnEnable()
  WU.SetGameDataCache("lastLoginTime" .. DB:GetData("playerId") .. "/PullNewPlayer", CS.GameTime.serverUtc)
  RU.SetRedMark("Welfare/PullNewPlayer", false)
end

function OnClickButtonShare()
  WU.RecordButtonClick(901)
  if not m_stBusy then
    m_stBusy = true
    local time = CS.GameTime.serverUtc
    local fileName = "screencapture" .. time .. ".png"
    this:DelayInvokeInSeconds(0.5, function()
      local m_imagePath = CS.ResourceManager.Instance.SharePath .. "/" .. fileName
      CS.GameUtility.ScreenCapture(m_imagePath)
      CS.NativeInterface.External_SaveToAlbum(m_imagePath, "PullNewPlayer/OnScreenshotSuccess", "PullNewPlayer/OnScreenshotFailure")
    end)
  end
end

function OnScreenshotSuccess()
  WU.ToggleTopBar("PullNewPlayer", true)
  m_stBusy = false
  WU.ShowHintText(WU.GetString("Window_SaveSuccess"))
end

function OnScreenshotFailure()
  WU.ToggleTopBar("PullNewPlayer", true)
  m_stBusy = false
  WU.ShowHintText(WU.GetString("Window_SaveFail"))
end
