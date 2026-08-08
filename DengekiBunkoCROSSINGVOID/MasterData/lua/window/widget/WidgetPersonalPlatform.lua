local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local m_vip = false
local m_whereFrom, m_platform

function OpenPlatformPage()
  WU.AcquireWindowAsync("PlatformStartPage", function(ui)
    _ENV["$"](ui)["$$SetData"]({socialPlatform = m_platform})
  end)
end

function Awake()
  WU.BindButtonEvent(REF.SpriteWXStart, function()
    OpenPlatformPage()
  end)
  WU.BindButtonEvent(REF.SpriteQQStart, function()
    OpenPlatformPage()
  end)
  WU.BindButtonEvent(REF.SpriteVip, function()
    local accountCache = this:GetData("accountCache")
    if accountCache then
      local pfKey = accountCache.pfKey or ""
      local playerId = 1
      local worldId = 1
      local urlData = PB.all("MsdkUrl")[1]
      local url = urlData.QQVipH5 .. "?sRoleId=" .. playerId .. "&sPartition=" .. worldId .. "&sPfkey=" .. pfKey
      CS.Msdk.WGPlatform.Instance:WGOpenUrl(url)
    end
  end)
end

function SetData(data, isWGChannel, isMySelfSpace)
  local switch = this:GetData("AccountSwitch")
  local myData = DB:GetData("fci/gamecenter")
  local accountCache = this:GetData("accountCache")
  local gamecenterLoginTime = 0
  local socialPlatform = 0
  local qqvip = 0
  if data then
    gamecenterLoginTime = data.gamecenterLoginTime
    qqvip = data.qqvip
  elseif myData then
    gamecenterLoginTime = myData.gamecenterLoginTime
    qqvip = myData.qqvip
  end
  socialPlatform = accountCache.socialPlatform
  local now = CS.GameTime.serverNow
  local loginTime = CS.GameTime.UtcToLocal(gamecenterLoginTime)
  local isLogin = now.Day == loginTime.Day
  m_platform = socialPlatform
  local platform = U.ToEnum(CS.Msdk.ePlatform, socialPlatform)
  if platform == CS.Msdk.ePlatform.ePlatform_QQ and isWGChannel then
    local bSelf = data.playerId == this:GetData("playerId")
    REF.WX.gameObject:SetActive(false)
    REF.QQ.gameObject:SetActive(true)
    if isLogin then
      REF.SpriteQQStart.UISprite.graify = false
    else
      REF.SpriteQQStart.UISprite.graify = true
    end
    REF.SpriteQQStart.gameObject:SetActive(switch.QQGameCenterPrivilege)
    REF.SpriteVip.gameObject:SetActive(switch.QQVipPrivilege and bSelf)
    if not switch.QQGameCenterPrivilege and not switch.QQVipPrivilege then
      REF.root.gameObject:SetActive(false)
    end
  elseif platform == CS.Msdk.ePlatform.ePlatform_Weixin and isWGChannel then
    REF.WX.gameObject:SetActive(switch.WXGameCenterPrivilege)
    REF.QQ.gameObject:SetActive(false)
    if not switch.WXGameCenterPrivilege then
      REF.root.gameObject:SetActive(false)
    end
  else
    REF.root.gameObject:SetActive(false)
  end
  if isMySelfSpace then
    REF.SpriteWXStart.transform.localPosition = CS.UnityEngine.Vector3(-45, 0, 0)
    REF.SpriteQQStart.transform.localPosition = CS.UnityEngine.Vector3(-45, 35, 0)
    REF.SpriteVip.transform.localPosition = CS.UnityEngine.Vector3(-45, -35, 0)
  else
    REF.SpriteWXStart.transform.localPosition = CS.UnityEngine.Vector3.zero
    REF.SpriteQQStart.transform.localPosition = CS.UnityEngine.Vector3.zero
  end
end

function Start()
end
