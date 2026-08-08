local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local PU = require("Common/PlatformUtil")
local DU = require("Common/DungeonUtil")
local m_iapHandler = S:Get("IAPHandler")
local m_localedPrice, m_data
local m_url = "fci/gamecenter"
local Msdk = CS.Msdk
local m_platform, m_msdkUrlData
local rapidjson = require("rapidjson")
local m_isNewbieAdOpen = true

function OpenPlatformPage()
  WU.AcquireWindowAsync("PlatformStartPage", function(ui)
    _ENV["$"](ui)["$$SetData"]({socialPlatform = m_platform})
  end)
end

function LoopAd()
  local chapterInfo = this:GetData("fci/dungeon/chapter-summary")
  local RangeLeft, RangeRight
  DU.IsDungeonFinished(chapterInfo, 3, function(finished)
    RangeLeft = finished
  end)
  DU.IsDungeonFinished(chapterInfo, 10, function(finished)
    RangeRight = finished
  end)
  if not RangeLeft or RangeRight then
    WU.SetActive(REF.NewbieTips, false)
    return
  end
  if this:GetData("PurchasedNewbieGift") then
    return
  end
  WU.SetActive(REF.NewbieTips, m_isNewbieAdOpen)
  m_isNewbieAdOpen = not m_isNewbieAdOpen
  this:DelayInvokeInSeconds(10, LoopAd)
end

function Awake()
  WU.BindButtonEvent(REF.SpriteSpecial, function()
    WU.RecordButtonClick(100147)
    WU.AcquireWindowAsync("ProfitBuff")
  end)
  WU.BindButtonEvent(REF.SpriteNewbie, function()
    this:SetData("PurchaseTab", "Newbie")
    WU.AcquireWindowAsync("Purchase")
  end)
  this:Bind("PurchasedNewbieGift", function(result)
    WU.SetActive(REF.NewbieTips, not result)
  end)
  this:Bind("PurchasedAllNewbieGift", function(result)
    WU.SetActive(REF.SpriteNewbie, not result)
    WU.SetActive(REF.NewbieEffectBg, not result)
  end)
  REF.Panel.transform.localScale = CS.UnityEngine.Vector3(0.9, 0.9, 1)
  REF.Panel.transform.localPosition = CS.UnityEngine.Vector3.zero
  m_msdkUrlData = PB.all("MsdkUrl")[1]
  WU.BindButtonEvent(REF.SpriteWXStart, OpenPlatformPage)
  WU.BindButtonEvent(REF.HeartCenter, OpenXinYue)
  WU.BindButtonEvent(REF.SpriteVip, function()
    REF.SpriteRed.gameObject:SetActive(false)
    local data = DB:GetData(m_url)
    if data then
      data.gamecenterClickTime = CS.GameTime.serverUtc
      DB:SetData(m_url, data)
    end
    this:GameRequest(m_url):Put({})
    local accountCache = this:GetData("accountCache")
    if accountCache then
      local pfKey = accountCache.pfKey or ""
      local playerId = 1
      local worldId = 1
      local url = m_msdkUrlData.QQVipH5 .. "?sRoleId=" .. playerId .. "&sPartition=" .. worldId .. "&sPfkey=" .. pfKey
      WU.OpenUrl(url)
    end
    UpdateData()
  end)
  WU.BindButtonEvent(REF.SpritePvp, function()
    local data = DB:GetData(m_url)
    if data then
      data.raceClickTime = CS.GameTime.serverUtc
      DB:SetData(m_url, data)
    end
    UpdateRaceRedPoint()
    this:GameRequest(m_url):Post({isRaceClick = true})
    WU.OpenUrl(m_msdkUrlData.PvpUrl)
  end)
  WU.BindButtonEvent(REF.SpriteAnime, function()
    WU.OpenUrlExternal(m_msdkUrlData.AnimeUrl)
  end)
  WU.BindButtonEvent(REF.SpriteYingYongBao, function()
    WU.OpenUrlWithDir(m_msdkUrlData.YingYongBaoUrl, 0)
  end)
  WU.BindButtonEvent(REF.SpriteGift, function()
    local platform = U.ToEnum(Msdk.ePlatform, m_platform)
    local url = m_msdkUrlData.QQGiftCenter
    if platform == Msdk.ePlatform.ePlatform_Weixin then
      url = m_msdkUrlData.WXGiftCenter
    end
    WU.OpenUrlWithDir(url, 0)
  end)
  WU.BindButtonEvent(REF.SpriteCenter, function()
    local platform = U.ToEnum(Msdk.ePlatform, m_platform)
    local url = m_msdkUrlData.QQTribe
    if platform == Msdk.ePlatform.ePlatform_Weixin then
      url = string.format("https://game.weixin.qq.com/cgi-bin/h5/static/circle/index.html?appid=wx687f4629ba7c3086&auth_type=2&ssid=12")
    end
    WU.OpenUrl(url)
  end)
  WU.BindButtonEvent(REF.SpriteOther, function()
    REF.ContainerBottom.gameObject:SetActive(not REF.ContainerBottom.gameObject.activeSelf)
  end)
  WU.BindButtonEvent(REF.SpriteSVIP, OnClickSVIP)
  WU.BindButtonEvent(REF.SpriteWSQ, function()
    WU.OpenUrl(m_msdkUrlData.WsqUrl)
  end)
  WU.BindButtonEvent(REF.SpriteTXRecharge, function()
    local url = m_msdkUrlData.TXRechargeUrl .. "?partition=" .. DB:GetData("worldId") .. "&roleid=" .. DB:GetData("playerId") .. "&subscribekey=djwk"
    WU.OpenUrl(url)
  end)
  WU.BindButtonEvent(REF.SpriteKingCard, function()
    WU.OpenUrl(m_msdkUrlData.KingCardUrl)
  end)
  WU.BindButtonEvent(REF.SpriteEightEight, function()
    WU.OpenUrl(m_msdkUrlData.EightEightUrl)
  end)
  WU.BindButtonEvent(REF.SpriteAnimeMovie, function()
    local data = DB:GetData(m_url)
    if data then
      data.animeMovieClickTime = CS.GameTime.serverUtc
      DB:SetData(m_url, data)
    end
    UpdateAnimeMovieRedPoint()
    this:GameRequest(m_url):Post({isAnimeMovieClick = true})
    WU.OpenUrl(m_msdkUrlData.AnimeMovieDeeplink)
    local startTime = CS.GameTime.serverUtc
    this:DelayInvokeInSeconds(0.1, function()
      if CS.GameTime.serverUtc - startTime < 1 then
        WU.OpenUrl(m_msdkUrlData.AnimeMovieUrl)
      end
    end)
  end)
  WU.BindButtonEvent(REF.SpriteAnimeMovieOct, function()
    local data = DB:GetData(m_url)
    if data then
      data.animeMovieOctClickTime = CS.GameTime.serverUtc
      DB:SetData(m_url, data)
    end
    UpdateAnimeMovieOctRedPoint()
    this:GameRequest(m_url):Post({isAnimeMovieOctClick = true})
    WU.OpenUrl(m_msdkUrlData.AnimeMovieOctDeeplink)
    local startTime = CS.GameTime.serverUtc
    this:DelayInvokeInSeconds(0.1, function()
      if CS.GameTime.serverUtc - startTime < 1 then
        WU.OpenUrl(m_msdkUrlData.AnimeMovieOctUrl)
      end
    end)
  end)
  WU.BindButtonEvent(REF.SpriteCarnivalMonth, function()
    WU.OpenUrlWithDir(m_msdkUrlData.CarnivalMonthUrl, 0)
  end)
  WU.BindButtonEvent(REF.SpriteCollectionActivity, function()
    WU.OpenUrlWithDir(m_msdkUrlData.CollectionActivityhUrl, 0)
  end)
  WU.BindButtonEvent(REF.SpriteAnecdoteMoive, function()
    WU.OpenUrl(m_msdkUrlData.AnecdoteMoiveUrl)
  end)
end

function AddQueryParam(url, key, value)
  local res = url .. "&" .. key .. "=" .. tostring(value)
  return res
end

function OnClickSVIP()
  local finalUrl = ""
  local baseUrl = "https://svip.game.qq.com/svip/managershow/redirect"
  finalUrl = baseUrl .. "?role_id=" .. this:GetData("playerId")
  local accountCache = this:GetData("accountCache")
  local social = accountCache.socialPlatform
  if social == PB.enum.MSDKLoginPlatform.MSDK_QQ then
    finalUrl = AddQueryParam(finalUrl, "plat_id", "2")
  elseif social == PB.enum.MSDKLoginPlatform.MSDK_Wechat then
    finalUrl = AddQueryParam(finalUrl, "plat_id", "1")
  else
    warning("MSDK", "Unknow MSDK socialPlatform:" .. tostring(social))
  end
  finalUrl = AddQueryParam(finalUrl, "source", "xy_games")
  finalUrl = AddQueryParam(finalUrl, "partition_id", "2068")
  local worldId = this:GetData("worldId")
  finalUrl = AddQueryParam(finalUrl, "area_id", worldId)
  local system_id = 2
  system_id = 1
  finalUrl = AddQueryParam(finalUrl, "system_id", system_id)
  finalUrl = AddQueryParam(finalUrl, "game_id", "1285")
  finalUrl = AddQueryParam(finalUrl, "role_name", "pseudo")
  WU.OpenUrl(finalUrl)
end

function GetXinYueCode()
  local plat = "0"
  plat = "1"
  local accountCache = this:GetData("accountCache")
  m_platform = accountCache.socialPlatform
  local platform = U.ToEnum(Msdk.ePlatform, accountCache.socialPlatform)
  local ch, area
  if platform == Msdk.ePlatform.ePlatform_QQ then
    ch = "1"
    area = "2"
  else
    ch = "2"
    area = "1"
  end
  local worldId = this:GetData("worldId")
  local appId = fif(platform == Msdk.ePlatform.ePlatform_QQ, "1106429722", "wx687f4629ba7c3086")
  local baseInfo = this:GetData("fci/baseinfo/")
  local imgUrl = baseInfo.socialPicture
  if imgUrl == nil then
    imgUrl = ""
  end
  local params = {
    gid = "1285",
    pid = "43",
    reg = "1",
    plat = plat,
    ch = ch,
    area = area,
    part = "",
    openid = this:GetData("SocialOpenId"),
    appid = appId,
    role = tostring(accountCache.accountId),
    msdkt = accountCache.accessToken,
    t = tostring(os.time()),
    r = tostring(math.random(1000, 10000)),
    ava = imgUrl,
    nick = baseInfo.name
  }
  local paramsJson = rapidjson.encode(params)
  local base64String = CS.UnityHTTP.Ext.ToBase64(paramsJson)
  local base64String = string.gsub(base64String, "+", "-")
  local base64String = string.gsub(base64String, "/", "_")
  local base64String = string.gsub(base64String, "=", "")
  local md5String = CS.UnityHTTP.Ext.ToMD5(base64String .. "Bui1tin#t@Clu8")
  local signString = string.sub(md5String, 9, 24)
  local code = base64String .. signString
  return code
end

function OpenXinYue()
  local data = DB:GetData(m_url)
  if data then
    data.xinyueClickTime = CS.GameTime.serverUtc
    DB:SetData(m_url, data)
  end
  this:GameRequest(m_url):Post({isXinyueClick = true}, function(res)
  end)
  local url = m_msdkUrlData.XinYueH5 .. "code="
  local code = GetXinYueCode()
  url = url .. code
  WU.OpenUrl(url)
  UpdateXinYueRedPoint()
end

function UpdateRedPont()
  UpdateXinYueRedPoint()
  UpdateAnimeMovieRedPoint()
  UpdateAnimeMovieOctRedPoint()
  UpdateRaceRedPoint()
end

function HideOtherMenu()
  REF.ContainerBottom.gameObject:SetActive(false)
end

function IsShowRedPoint(clickTime)
  local now = CS.GameTime.serverNow
  local time1 = CS.GameTime.UtcToLocal(clickTime)
  return not CS.GameTime.IsSameWeek(time1, now)
end

function UpdateData()
  local switch = this:GetData("AccountSwitch")
  local isVipRed = false
  local data = DB:GetData(m_url)
  local accountCache = this:GetData("accountCache")
  if data then
    isVipRed = IsShowRedPoint(data.gamecenterClickTime)
  end
  m_platform = accountCache.socialPlatform
  local platform = U.ToEnum(Msdk.ePlatform, accountCache.socialPlatform)
  if platform == Msdk.ePlatform.ePlatform_QQ then
    REF.SpriteWXStart.gameObject:SetActive(false)
    REF.SpriteVip.gameObject:SetActive(switch.QQVipPrivilege)
    REF.SpriteRed.gameObject:SetActive(isVipRed and switch.QQVipPrivilege)
    REF.SpritePvp.gameObject:SetActive(true)
    REF.SpriteAnime.gameObject:SetActive(true)
    REF.SpriteGift.gameObject:SetActive(true)
    REF.SpriteTXRecharge.gameObject:SetActive(switch.TxRecharge)
    REF.SpriteKingCard.gameObject:SetActive(switch.KingCard)
    REF.SpriteEightEight.gameObject:SetActive(switch.EightEight)
    REF.SpriteAnimeMovie.gameObject:SetActive(switch.AnimeMovie)
    REF.SpriteAnimeMovieOct.gameObject:SetActive(false)
    REF.SpriteCarnivalMonth.gameObject:SetActive(switch.CarnivalMonth)
    REF.SpriteCollectionActivity.gameObject:SetActive(switch.CollectionActivity)
    REF.SpriteAnecdoteMoive.gameObject:SetActive(switch.AnecdoteMoive)
  elseif platform == Msdk.ePlatform.ePlatform_Weixin then
    REF.SpriteWXStart.gameObject:SetActive(switch.WXGameCenterPrivilege)
    REF.SpriteRed.gameObject:SetActive(false)
    REF.SpriteVip.gameObject:SetActive(false)
    REF.SpritePvp.gameObject:SetActive(false)
    REF.SpriteAnime.gameObject:SetActive(false)
    REF.SpriteGift.gameObject:SetActive(false)
    REF.SpriteTXRecharge.gameObject:SetActive(switch.TxRecharge)
    REF.SpriteKingCard.gameObject:SetActive(switch.KingCard)
    REF.SpriteEightEight.gameObject:SetActive(false)
    REF.SpriteAnimeMovie.gameObject:SetActive(switch.AnimeMovie)
    REF.SpriteAnimeMovieOct.gameObject:SetActive(false)
    REF.SpriteCarnivalMonth.gameObject:SetActive(false)
    REF.SpriteCollectionActivity.gameObject:SetActive(false)
    REF.SpriteAnecdoteMoive.gameObject:SetActive(false)
  else
    HidePlatformButtons()
  end
  local isYingYongBaoChannel = PU.GetChannelId("yingyongbao") == Msdk.WGPlatform.Instance:WGGetChannelId()
  REF.SpriteYingYongBao.gameObject:SetActive(isYingYongBaoChannel)
  REF.SpriteSVIP.gameObject:SetActive(false)
  this:Unbind("fci/xinyue-vipinfo/", OnXinyueVipInfo)
  this:BindRemote(DB:GameRequest("fci/xinyue-vipinfo/"):SyncInput(false):ResetGameWhenFailed(false), OnXinyueVipInfo)
  REF.GridBottom.gameObject:SetActive(switch.OtherPrivilege)
  REF.GridBottom.UIGrid:Reposition()
  REF.Container.UIGrid:Reposition()
  SetSpriteBgSize()
  UpdateRedPont()
end

function SetSpriteBgSize()
  local gridChildCount = 0
  WU.TraverseChildren(REF.GridBottom, function(go, i)
    if go.activeSelf then
      gridChildCount = gridChildCount + 1
    end
  end)
  local coloumn = math.min(gridChildCount, REF.GridBottom.UIGrid.maxPerLine)
  local row = math.floor((gridChildCount - 1) / REF.GridBottom.UIGrid.maxPerLine) + 1
  local pos = REF.SpriteBg.transform.localPosition
  REF.SpriteBg.UISprite.width = -pos.x * 2 + (coloumn - 1) * REF.GridBottom.UIGrid.cellWidth
  REF.SpriteBg.UISprite.height = pos.y * 2 + (row - 1) * REF.GridBottom.UIGrid.cellHeight
end

function OnXinyueVipInfo(xinyueVipInfo)
  if xinyueVipInfo and xinyueVipInfo.ilevel and xinyueVipInfo.ilevel >= 10 then
    REF.SpriteSVIP.gameObject:SetActive(true)
  else
    REF.SpriteSVIP.gameObject:SetActive(false)
  end
  REF.GridBottom.UIGrid:Reposition()
  SetSpriteBgSize()
  UpdateRedPont()
end

function IsOtherRedPointActive()
  return not REF.SpriteRedXinYue.gameObject.activeSelf and (not REF.SpriteRedAnimeMovie.gameObject.activeSelf or not REF.SpriteAnimeMovie.gameObject.activeSelf) and REF.SpriteRedAnimeMovieOct.gameObject.activeSelf and REF.SpriteAnimeMovieOct.gameObject.activeSelf
end

function UpdateXinYueRedPoint()
  local data = DB:GetData(m_url)
  if data then
    local clickTime = data.xinyueClickTime
    local b = IsShowRedPoint(clickTime)
    REF.SpriteRedXinYue.gameObject:SetActive(b)
  else
    REF.SpriteRedXinYue.gameObject:SetActive(false)
  end
  REF.SpriteRedOther.gameObject:SetActive(IsOtherRedPointActive())
end

function UpdateAnimeMovieRedPoint()
  local data = DB:GetData(m_url)
  if data then
    local clickTime = data.animeMovieClickTime
    local b = IsShowRedPoint(clickTime)
    REF.SpriteRedAnimeMovie.gameObject:SetActive(b)
  else
    REF.SpriteRedAnimeMovie.gameObject:SetActive(false)
  end
  REF.SpriteRedOther.gameObject:SetActive(IsOtherRedPointActive())
end

function UpdateAnimeMovieOctRedPoint()
  local data
  if data then
    local clickTime = data.animeMovieOctClickTime
    local b = IsShowRedPoint(clickTime)
    REF.SpriteRedAnimeMovieOct.gameObject:SetActive(b)
  else
    REF.SpriteRedAnimeMovieOct.gameObject:SetActive(false)
  end
  REF.SpriteRedOther.gameObject:SetActive(IsOtherRedPointActive())
end

function UpdateRaceRedPoint()
  local data = DB:GetData(m_url)
  if data then
    local clickTime = data.raceClickTime
    local b = IsShowRedPoint(clickTime)
    REF.SpriteRaceRed.gameObject:SetActive(b)
  else
    REF.SpriteRaceRed.gameObject:SetActive(false)
  end
end

function HidePlatformButtons()
  REF.PlatformButtonBg.gameObject:SetActive(false)
  REF.SpriteWXStart.gameObject:SetActive(false)
  REF.SpriteVip.gameObject:SetActive(false)
  REF.SpritePvp.gameObject:SetActive(false)
  REF.SpriteOther.gameObject:SetActive(false)
  REF.Container.UIGrid:Reposition()
end

function Start()
  WU.SetActive(REF.SpriteNewbie, false)
  WU.SetActive(REF.NewbieEffectBg, false)
  this:Bind("AccountSwitch", function(switch)
    if switch == nil then
      HidePlatformButtons()
      return
    end
    if not switch.QQVipPrivilege and (not switch.QQGameCenterPrivilege or not switch.WXGameCenterPrivilege) and not switch.OtherPrivilege then
      HidePlatformButtons()
      return
    end
    local channel = Msdk.WGPlatform.Instance:WGGetChannelId()
    if PU.IsPrivilegeIgnore(channel) then
      HidePlatformButtons()
      return
    end
    local data = DB:GetData(m_url)
    local accountCache = this:GetData("accountCache")
    if data == nil then
      local token = accountCache.accessToken
      if token then
        local bLogin = false
        local platform = U.ToEnum(Msdk.ePlatform, accountCache.socialPlatform)
        if platform == Msdk.ePlatform.ePlatform_QQ then
          bLogin = CS.PlatformManager.Instance.IsQQGameCenter and switch.QQGameCenterPrivilege
        elseif platform == Msdk.ePlatform.ePlatform_Weixin then
          bLogin = CS.PlatformManager.Instance.IsWXGameCenter and switch.WXGameCenterPrivilege
        end
        this:GameRequest(m_url):Post({socialToken = token, isGamecenterLogin = bLogin}, function(res)
          DB:SetData(m_url, res)
          UpdateData()
        end)
      end
    end
    local platform = U.ToEnum(Msdk.ePlatform, accountCache.socialPlatform)
    if platform == Msdk.ePlatform.ePlatform_QQ then
      REF.SpriteCenter.UISprite.spriteName = "buff_tribe"
    elseif platform == Msdk.ePlatform.ePlatform_Weixin then
      REF.SpriteCenter.UISprite.spriteName = "buff_game_circle"
    end
    UpdateData()
    REF.ContainerBottom.gameObject:SetActive(false)
  end)
end
