_class("UIAircraftGuangPoFilter", UICustomWidget)
UIAircraftGuangPoFilter = UIAircraftGuangPoFilter
XinPoFilter = {
  All = 0,
  Star4 = 4,
  Star5 = 5,
  Star6 = 6
}

function UIAircraftGuangPoFilter:OnShow()
  self:InitWidget()
end

function UIAircraftGuangPoFilter:SetData(onChanged)
  self._onChanged = onChanged
end

function UIAircraftGuangPoFilter:InitWidget()
  self.all = self:GetUIComponent("Toggle", "all")
  self._4s = self:GetUIComponent("Toggle", "_4s")
  self._5s = self:GetUIComponent("Toggle", "_5s")
  self._6s = self:GetUIComponent("Toggle", "_6s")
  self.allText = self:GetUIComponent("UILocalizationText", "allText")
  self._4Text = self:GetUIComponent("UILocalizationText", "_4Text")
  self._4Image = self:GetUIComponent("Image", "_4Image")
  self._5Text = self:GetUIComponent("UILocalizationText", "_5Text")
  self._5Image = self:GetUIComponent("Image", "_5Image")
  self._6Text = self:GetUIComponent("UILocalizationText", "_6Text")
  self._6Image = self:GetUIComponent("Image", "_6Image")
  self._root = self:GetGameObject()
  self._onColor = Color(0.10588235294117647, 1, 1)
  self._notOnColor = Color.white
  self._toggles = {
    [XinPoFilter.All] = nil,
    [XinPoFilter.Star4] = nil,
    [XinPoFilter.Star5] = nil,
    [XinPoFilter.Star6] = nil
  }
  self._toggleViews = {
    [XinPoFilter.All] = {
      toggle = self.all,
      graphics = {
        self.allText
      }
    },
    [XinPoFilter.Star4] = {
      toggle = self._4s,
      graphics = {
        self._4Image,
        self._4Text
      }
    },
    [XinPoFilter.Star5] = {
      toggle = self._5s,
      graphics = {
        self._5Image,
        self._5Text
      }
    },
    [XinPoFilter.Star6] = {
      toggle = self._6s,
      graphics = {
        self._6Image,
        self._6Text
      }
    }
  }
end

function UIAircraftGuangPoFilter:Refresh(star4, star5, star6)
  self:ChangeToggle(XinPoFilter.Star4, star4)
  self:ChangeToggle(XinPoFilter.Star5, star5)
  self:ChangeToggle(XinPoFilter.Star6, star6)
  self:ChangeToggle(XinPoFilter.All, star4 and star5 and star6)
end

function UIAircraftGuangPoFilter:Active(active)
  self._root:SetActive(active)
  if active then
  else
    self._toggles = {}
  end
end

function UIAircraftGuangPoFilter:ChangeToggle(type, isOn)
  if self._toggles[type] == isOn then
    return
  end
  self._toggles[type] = isOn
  self._toggleViews[type].toggle.isOn = isOn
  for _, graphic in pairs(self._toggleViews[type].graphics) do
    if isOn then
      graphic.color = self._onColor
    else
      graphic.color = self._notOnColor
    end
  end
end

function UIAircraftGuangPoFilter:CheckAll()
  self:ChangeToggle(XinPoFilter.All, self._toggles[XinPoFilter.Star4] and self._toggles[XinPoFilter.Star5] and self._toggles[XinPoFilter.Star6])
end

function UIAircraftGuangPoFilter:AreaAllOnClick()
  self:ChangeToggle(XinPoFilter.All, not self._toggles[XinPoFilter.All])
  self:ChangeToggle(XinPoFilter.Star4, self._toggles[XinPoFilter.All])
  self:ChangeToggle(XinPoFilter.Star5, self._toggles[XinPoFilter.All])
  self:ChangeToggle(XinPoFilter.Star6, self._toggles[XinPoFilter.All])
  self._onChanged(XinPoFilter.All, self._toggles[XinPoFilter.All])
end

function UIAircraftGuangPoFilter:Area4OnClick()
  self:ChangeToggle(XinPoFilter.Star4, not self._toggles[XinPoFilter.Star4])
  self:CheckAll()
  self._onChanged(XinPoFilter.Star4, self._toggles[XinPoFilter.Star4])
end

function UIAircraftGuangPoFilter:Area5OnClick()
  self:ChangeToggle(XinPoFilter.Star5, not self._toggles[XinPoFilter.Star5])
  self:CheckAll()
  self._onChanged(XinPoFilter.Star5, self._toggles[XinPoFilter.Star5])
end

function UIAircraftGuangPoFilter:Area6OnClick()
  self:ChangeToggle(XinPoFilter.Star6, not self._toggles[XinPoFilter.Star6])
  self:CheckAll()
  self._onChanged(XinPoFilter.Star6, self._toggles[XinPoFilter.Star6])
end
