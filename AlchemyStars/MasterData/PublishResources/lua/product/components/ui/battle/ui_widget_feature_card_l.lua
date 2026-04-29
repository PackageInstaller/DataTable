_class("UIWidgetFeatureCard_L", UIWidgetFeatureCard)
UIWidgetFeatureCard_L = UIWidgetFeatureCard_L

function UIWidgetFeatureCard_L:InitLocalData()
  self._cardAnimNames = {
    [FeatureCardType.A] = "UIWidgetFeatureCard_sun_l",
    [FeatureCardType.B] = "UIWidgetFeatureCard_moon_l",
    [FeatureCardType.C] = "UIWidgetFeatureCard_star_l"
  }
end
