_class("UIFeatureSanInfo", UIController)
UIFeatureSanInfo = UIFeatureSanInfo

function UIFeatureSanInfo:OnShow(uiParams)
  self._sanInitData = uiParams[1]
  self._curVal = uiParams[2]
  self._maxVal = uiParams[3]
  self:InitWidget()
  self:_RefreshContent()
end

function UIFeatureSanInfo:InitWidget()
  self._titleText = self:GetUIComponent("UILocalizationText", "TitleText")
  self._subTitleText = self:GetUIComponent("UILocalizationText", "SubTitleText")
  self._content = self:GetUIComponent("UILocalizationText", "Content")
end

function UIFeatureSanInfo:DotBGOnClick()
  self:CloseDialog()
end

function UIFeatureSanInfo:_RefreshContent()
  if self._sanInitData then
    local param = self._sanInitData:GetSanityParam()
    local validColorStrFormat = "<color=#E2C017>%s</color>"
    if param then
      local paramCount = #param
      local contentStr = ""
      for i, v in ipairs(param) do
        local descStr
        local rangeTb = v.range
        if rangeTb then
          local rangeMin = rangeTb[1]
          local rangeMax = rangeTb[2]
          descStr = StringTable.Get(v.descStr)
          if rangeMax >= self._curVal then
            descStr = string.format(validColorStrFormat, descStr)
          end
        else
          descStr = StringTable.Get(v.descStr)
        end
        if paramCount == i then
          contentStr = contentStr .. descStr
        else
          contentStr = contentStr .. descStr .. "\n"
        end
      end
      self._content:SetText(contentStr)
      local subTitleStr = StringTable.Get("str_battle_san_desc_common", tostring(self._maxVal))
      self._subTitleText:SetText(subTitleStr)
    end
  end
end
