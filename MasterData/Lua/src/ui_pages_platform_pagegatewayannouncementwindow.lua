local this = class("pageGatewayAnnouncementWindow", G_UIPageBase)
local replaceTable = {
  {"&lt;", "<"},
  {"&gt;", ">"},
  {"&#34;", "\""},
  {"<br>", "\n"},
  {"style=\"\">", "style=\"\"/>"}
}

function this.bind()
  return {
    txtOK = "",
    title = "",
    txt_content = "",
    moduleCommonTip = L_Const.ModuleInfo.ModuleCommonTip
  }
end

function this.methods()
  return {
    moduleCommonTip = {
      onClick_close = function(self)
        L_UI:close(self.pageName)
        if self.onClickCloseCallback then
          self.onClickCloseCallback()
        end
      end,
      onClick_bg = function(self)
        L_UI:close(self.pageName)
        if self.onClickCloseCallback then
          self.onClickCloseCallback()
        end
      end,
      onClick_confirm = function(self)
        L_UI:close(self.pageName)
        if self.onClickOkCallback then
          self.onClickOkCallback()
        end
      end
    }
  }
end

function this:created(...)
  this.super.created(self, ...)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:initOptions(options)
end

function this:initOptions(options)
  options = options or {}
  self.modules.moduleCommonTip:initModule({
    txtTitle = options.title,
    txtConfirm = options.txtOK,
    hideCancel = true
  })
  if options.title then
    self.bind.title = options.title
  end
  if options.txtOK then
    self.bind.txtOK = options.txtOK
  end
  self.onClickOkCallback = options.onClickOkCallback
  self.onClickCloseCallback = options.onClickCloseCallback
  self.resourceUrl = options.url
  if self.resourceUrl then
    self:initData(self.resourceUrl)
  else
    error("没有网关公告内容url")
  end
end

function this:open()
  this.super.open(self)
end

function this:close()
  this.super.close(self)
end

function this:onDownloadCalback(isSuccess, data)
  if not isSuccess then
    return
  end
  data = self:formatSrcString(data)
  local retList = CS.Lens.Framework.Utility.Html2UnityRichApi.ToUnityRichText(data)
  local srcText = self:parse_text(retList)
  self.bind.txt_content = srcText
end

function this:parse_text(c_list)
  local list = {}
  local count = c_list.Count
  local srcText = ""
  for i = 0, count - 1 do
    srcText = srcText .. CS.Lens.Framework.Utility.Html2UnityRichApi.ReplaceStartEnBlank(c_list[i].text)
  end
  return srcText
end

function this:formatSrcString(data)
  if data == nil then
    return nil
  end
  for k, v in pairs(replaceTable) do
    data = string.gsub(data, v[1], v[2])
  end
  return data
end

function this:StripHtml(htmlString)
  if htmlString == nil or htmlString == "" then
    return ""
  end
  local text = htmlString
  text = string.gsub(text, "<[Ss][Tt][Yy][Ll][Ee][^>]*>.-</[Ss][Tt][Yy][Ll][Ee]>", "")
  text = string.gsub(text, "<[Ss][Cc][Rr][Ii][Pp][Tt][^>]*>.-</[Ss][Cc][Rr][Ii][Pp][Tt]>", "")
  text = string.gsub(text, "<[Bb][Rr][^>]*>", "\n")
  text = string.gsub(text, "</[Pp]>", [[


]])
  text = string.gsub(text, "<[^>]+>", "")
  text = string.gsub(text, "&nbsp;", " ")
  text = string.gsub(text, "&lt;", "<")
  text = string.gsub(text, "&gt;", ">")
  text = string.gsub(text, "&amp;", "&")
  text = string.gsub(text, "&quot;", "\"")
  text = string.gsub(text, "&#39;", "'")
  return text
end

function this:initData(url)
  self:OnGetAnnounceCallback(true, url)
end

function this:clearHtmlCache(html)
  if self.cacheData ~= nil then
    self.cacheData[html] = nil
  end
end

function this:OnGetAnnounceCallback(isSuccess, data)
  if not isSuccess then
    return
  end
  self.cacheData = self.cacheData or {}
  local html = data
  if self.cacheData[html] then
    self:onDownloadCalback(true, self.cacheData[html])
  else
    self:downloadTxt(html, handler(self, self.onDownloadCalback))
  end
end

function this:downloadTxt(url, callback)
  local function successCall(self, tex)
    self.cacheData[url] = tex
    
    if callback then
      callback(true, tex)
    end
    print("下载成功：" .. tex)
  end
  
  local function failCall(self, key)
    if callback then
      callback(false, nil)
    end
    error("下载失败：" .. key)
  end
  
  print("开始下载：" .. url)
  C_CDNManager.GetObject(url, handler(self, successCall), handler(self, failCall))
end

function this:stripUrl(url)
  if not url or url == "" then
    return ""
  end
  local text = url
  return string.sub(text, 32)
end

function this:escHandle()
  L_UI:close(self.pageName)
  if self.onClickCloseCallback then
    self.onClickCloseCallback()
  end
end

return this
