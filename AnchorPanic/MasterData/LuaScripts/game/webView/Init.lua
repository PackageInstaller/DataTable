webView = {}

webView.WebView = "game/webView/view/WebView"
webView.SurveyWebView = "game/webView/view/SurveyWebView"

local _c = require('game/webView/controller/SurveyWebViewController').new()

local module = { _c }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
