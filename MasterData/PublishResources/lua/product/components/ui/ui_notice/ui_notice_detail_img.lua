_class("UINoticeDetailImg", UICustomWidget)
UINoticeDetailImg = UINoticeDetailImg

function UINoticeDetailImg:OnShow(uiParams)
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._title = self:GetUIComponent("UIRichText", "title")
  self._msg = self:GetUIComponent("UIRichText", "msg")
  self._jumpName = self:GetUIComponent("UILocalizationText", "jumpName")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UINoticeDetailImg:SetData(noticeInfo)
  local tab = cjson.decode(noticeInfo.Text_NoticeContent)
  if tab then
    self._jumpType = tab.jumpType
    if tab.jumpParam then
      local param = {}
      for i = 1, #tab.jumpParam do
        local item = tab.jumpParam[i]
        if type(item) == "number" then
          local z, s = math.modf(item)
          if s == 0 then
            table.insert(param, z)
          else
            table.insert(param, item)
          end
        else
          table.insert(param, item)
        end
      end
      self._jumpParam = param
    end
    local btn = self._jumpName.gameObject.transform.parent.gameObject
    if string.isnullorempty(tab.jumpName) then
      btn:SetActive(false)
    else
      btn:SetActive(true)
      self._jumpName:SetText(tab.jumpName)
    end
    self._icon:LoadImage(tab.texture)
    self._title:SetText(tab.title)
    
    function self._title.onHrefClick(hrefName)
      SDKProxy:GetInstance():OpenUrl(hrefName)
    end
    
    self._msg:SetText(tab.content)
    
    function self._msg.onHrefClick(hrefName)
      SDKProxy:GetInstance():OpenUrl(hrefName)
    end
  else
    Log.fatal("###notice json decode fail ! content --> ", noticeInfo.Text_NoticeContent)
  end
end

function UINoticeDetailImg:AnimFade()
  self._anim:Play("uieff_Notice_DetailImg_Fade")
end

function UINoticeDetailImg:AnimShow()
  self._anim:Play("uieff_Notice_DetailImg_Show")
end

function UINoticeDetailImg:OnHide()
  self._icon = nil
  self._title = nil
  self._msg = nil
  self._jumpName = nil
end

function UINoticeDetailImg:btnOnClick()
  if self._jumpType and self._jumpType > 0 and self._jumpParam then
    local jumpModule = GameGlobal.GetModule(QuestModule).uiModule
    jumpModule:SetJumpUIData(self._jumpType, self._jumpParam)
    jumpModule:Jump()
  end
end
