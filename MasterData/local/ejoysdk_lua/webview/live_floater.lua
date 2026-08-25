local E = require("ejoysdk_lua.ejoysdk")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local FLOATER = require("ejoysdk_lua.webview.floater")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local TAG = "live"
local Live = {}
local is_muted = false
local has_showed = false
local disable_live_event = false
setmetatable(Live, {__index = FLOATER})

local function live_reset()
  is_muted = false
  has_showed = false
end

Live.LIVE_EVENT = {
  ON_LIVE_SHOW = "on_live_show",
  ON_LIVE_DESTROY = "on_live_destroy",
  ON_LIVE_HIDE = "on_live_hide"
}
Live.LIVE_EVENT_MAP = {
  [FLOATER.Event.SHOW] = Live.LIVE_EVENT.ON_LIVE_SHOW,
  [FLOATER.Event.HIDE] = Live.LIVE_EVENT.ON_LIVE_HIDE,
  [FLOATER.Event.CLOSE] = Live.LIVE_EVENT.ON_LIVE_DESTROY
}

local function publish_live_event(_event)
  if _event then
    ET.publish(ET.live_floater.ON_CHANGED, _event, disable_live_event)
  end
end

Live.Default_InjectJS = "var __private_ejoySdk_startTime__=Date.now();var __private_ejoySdk_mightInited__=false;function ejoySdkGetSid(){console.log(\"----- ejoySdkGetSid\");try{var douyuDid=localStorage.getItem(\"douyuDid\");var cacheSidStr=localStorage.getItem(\"dysv2_cache.sid\");var cacheSidJson=JSON.parse(cacheSidStr)||{};return(cacheSidJson.v||{})[douyuDid+\"_\"]||\"\"}catch(e){return\"\"}}function ejoySdkLogArms(t,options){console.log(\"----- ejoySdkLogArms\");if(location&&location.href&&location.href.indexOf(\"http\")<0){return}var sampling=(options||{}).sampling||1;var params={t:t,page:location.href,uid:ejoySdkGetSid(),sid:Date.now(),times:1,sr:screen.width+\"x\"+screen.height,vp:window.innerWidth+\"x\"+window.innerHeight,ct:\"other\",sampling:sampling,pid:\"dsv9zcel92@f83f01cf028607c\",_v:\"1.3.0\",c1:Date.now()-__private_ejoySdk_startTime__,z:Date.now()};if(options){if(t===\"error\"&&options.error){sampling=params.sampling=1;params.cate=options.error.name;params.msg=options.error.message;params.stack=options.error.stack}}if(Math.random()*sampling<=1){var queryStr=Object.keys(params).map(function(key){return key+\"=\"+encodeURIComponent(params[key])}).join(\"&\");var img=new Image;img.crossOrigin=\"Anonymous\";img.src=\"https://arms-retcode.aliyuncs.com/r.png?\"+queryStr}}function ejoySdkLogArmsError(error,force){if(force||__private_ejoySdk_mightInited__||Date.now()-__private_ejoySdk_startTime__>1e3){console.log(\"----- ejoySdkLogArmsError\");ejoySdkLogArms(\"error\",{error:error})}else{console.log(\"----- ejoySdkLogArmsError\",\"SKIP\")}}function ejoySdkAddStyle(styleString){console.log(\"----- ejoySdkAddStyle\");var style=document.createElement(\"style\");style.textContent=styleString;if(document.head){document.head.append(style)}else{setTimeout(function(){document.head.append(style)},100)}}function ejoySdkGetMeta(metaName){console.log(\"----- ejoySdkGetMeta\");var metas=document.getElementsByTagName(\"meta\");for(var i=0;i<metas.length;i++){if(metas[i].getAttribute(\"name\")===metaName){return metas[i]}}throw new Error(\"[EJOY_ERROR] \"+metaName+\" meta not found\")}function ejoySdkFixViewport(reportError){console.log(\"----- ejoySdkFixViewport\");try{var meta=ejoySdkGetMeta(\"viewport\");var content=(meta.getAttribute(\"content\")||\"\").replace(/width=\\d+,/,\"width=device-width,\");meta.setAttribute(\"content\",content)}catch(e){if(reportError){ejoySdkLogArmsError(e)}}}function ejoySdkGetVideo(){console.log(\"----- ejoySdkGetVideo\");var player=document.querySelector(\"video\");if(player){console.log(\"----- ejoySdkGetVideo :get video\");return player}else{onsole.log(\"----- ejoySdkGetVideo : not get video\")}throw new Error(\"[EJOY_ERROR] video not found\")}function ejoySdkSetPauseMaskDisplay(displayValue){var pauseMask=document.querySelector(\"._2GaEReDWPpJu19uUj3YBum\");if(pauseMask){pauseMask.style.display=displayValue}}var __private_ejoySdk_videoIsPaused__=false;function ejoySdkPause(){console.log(\"----- ejoySdkPause\");try{ejoySdkGetVideo().pause();__private_ejoySdk_videoIsPaused__=true;ejoySdkSetPauseMaskDisplay(\"\")}catch(error){ejoySdkLogArmsError(error)}}function ejoySdkPlay(){console.log(\"----- ejoySdkPlay\");try{ejoySdkGetVideo().play();__private_ejoySdk_videoIsPaused__=false;if(__private_ejoySdk_videoIsMuted__){ejoySdkMute()}ejoySdkSetPauseMaskDisplay(\"none\");var loadingMask=document.querySelector(\"._3jJRrIQYexxO0BzqVPstxF\");if(loadingMask){loadingMask.style.display=\"none\"}var loadingMask2=document.querySelector(\"._3yKUHN3E-SrOTvmieIw2XX\");if(loadingMask2){loadingMask2.style.display=\"none\"}}catch(error){ejoySdkLogArmsError(error)}}var __private_ejoySdk_videoIsMuted__=false;function ejoySdkMute(){__private_ejoySdk_videoIsMuted__=true;console.log(\"----- ejoySdkMute\");try{var v=ejoySdkGetVideo();v.muted=true;v.volume=0}catch(error){ejoySdkLogArmsError(error)}}function ejoySdkUnmute(){__private_ejoySdk_videoIsMuted__=false;console.log(\"----- ejoySdkUnmute\");try{var v=ejoySdkGetVideo();v.muted=false;v.volume=1}catch(error){ejoySdkLogArmsError(error)}}function ejoySdkGetPlayStatus(cbid){console.log(\"----- ejoySdkGetPlayStatus\");try{var isPlaying=!ejoySdkGetVideo().paused;return isPlaying?1:0}catch(error){ejoySdkLogArmsError(error)}}(function hackOnPlay(){var oclg=console.log;console.log=function(){oclg.apply(console,arguments);if(arguments[0]===\"onplay\"){__private_ejoySdk_mightInited__=true;if(__private_ejoySdk_videoIsMuted__){oclg(\"---------------- hack onPlay and mute --------------\");ejoySdkMute()}}}})();(function main(){try{ejoySdkAddStyle(\"#__h5player>div:last-child {display: none}\");ejoySdkAddStyle(\"#__h5player>div>div:last-child {display: none}\");ejoySdkAddStyle(\"#__h5player>div>div:nth-last-child(2) {display: none}\");ejoySdkAddStyle(\"#__h5player ._2R0LBnB5MSMzrReXM0ham7 {display: none}\");ejoySdkAddStyle(\"#__h5player .HrEWW6C31vUyqvmtpthBu {display: none}\");ejoySdkFixViewport(false);setTimeout(function(){ejoySdkFixViewport(true);ejoySdkLogArms(\"pv\",{sampling:100})},200)}catch(error){ejoySdkLogArmsError(error,true)}})();(function(){window.addEventListener(\"error\",function(e){ejoySdkLogArmsError(e,true)})})();"

function Live.create(url, frame, params)
  live_reset()
  params = params or {}
  params.window_type = "LIVE"
  params.injectJS = params.injectJS or Live.Default_InjectJS
  params.callbacks = params.callbacks or {}
  params.injection = params.injection or {}
  local host = E.HTTP.parse(url).host
  if host and not params.injection[host] then
    params.injection[host] = {}
  end
  
  local function override_mute()
    if true == is_muted or false == has_showed then
      Live.mute()
    end
  end
  
  disable_live_event = params and params.disable_live_event or false
  local override_event = {
    FLOATER.Event.PAGE_LOAD_FINISHED,
    FLOATER.Event.SHOW,
    FLOATER.Event.HIDE,
    FLOATER.Event.CLOSE
  }
  for _, event in ipairs(override_event) do
    local origin_cb = params.callbacks[event]
    params.callbacks[event] = function(...)
      if event == FLOATER.Event.PAGE_LOAD_FINISHED or event == FLOATER.Event.SHOW then
        override_mute()
      end
      if origin_cb then
        origin_cb(...)
      end
      publish_live_event(Live.LIVE_EVENT_MAP[event])
    end
  end
  do return FLOATER.create, url, frame end
  return FLOATER.create, url, frame, params, nil, nil, params.callbacks[event], params.callbacks, function(...)
    if event == FLOATER.Event.PAGE_LOAD_FINISHED or event == FLOATER.Event.SHOW then
      override_mute()
    end
    if origin_cb then
      origin_cb(...)
    end
    publish_live_event(Live.LIVE_EVENT_MAP[event])
  end
end

function Live.mute()
  Live.call_js("ejoySdkMute();")
  is_muted = true
end

function Live.unmute()
  Live.call_js("ejoySdkUnmute();")
  is_muted = false
end

function Live.play(need_refresh)
  if true == need_refresh then
    Live.reload()
  else
    Live.call_js("ejoySdkPlay();")
  end
end

function Live.pause()
  Live.call_js("ejoySdkPause();")
end

function Live.get_play_status(cb)
  Live.call_js("ejoySdkGetPlayStatus();", function(ret)
    if ret then
      local os = _ejoysdk.os()
      if "ios" == os then
        ret = JSON.safe_decode(ret)
      end
    end
    if ret and ret.result then
      if type(ret.result) == "string" then
        ret.result = tonumber(ret.result)
      end
      cb(ret.result)
    end
  end)
end

local origin_frame

function Live.hide()
  if nil == origin_frame then
    origin_frame = Live.get_frame()
  end
  E.LOG.debug(TAG, origin_frame)
  Live.minimize()
  publish_live_event(Live.LIVE_EVENT_MAP[FLOATER.Event.HIDE])
end

function Live.show()
  if false == has_showed then
    has_showed = true
    Live.unmute()
  end
  if origin_frame then
    Live.resize(origin_frame.width, origin_frame.height, false)
    Live.reposition(origin_frame.x, origin_frame.y, false)
    origin_frame = nil
    publish_live_event(Live.LIVE_EVENT_MAP[FLOATER.Event.SHOW])
  else
    FLOATER.show()
  end
end

function Live.destroy()
  origin_frame = nil
  FLOATER.destroy()
end

return Live
