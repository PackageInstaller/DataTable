_class("UIEducationMainBtn", UICustomWidget)
UIEducationMainBtn = UIEducationMainBtn

function UIEducationMainBtn:Constructor()
end

function UIEducationMainBtn:OnShow(uiParams)
  self:UIWidget()
end

function UIEducationMainBtn:OnHide()
end

function UIEducationMainBtn:ButtonOnClick(go)
  if self._clickCB ~= nil then
    self._clickCB(self._element:ElementType())
  end
end

function UIEducationMainBtn:UIWidget()
  self._bgImage = self:GetUIComponent("RawImageLoader", "bgImage")
  self._petElement = self:GetUIComponent("RawImageLoader", "petElement")
  self._elementName = self:GetUIComponent("UILocalizationText", "elementName")
  self._stageName = self:GetUIComponent("UILocalizationText", "stageName")
  self._stageLevel = self:GetUIComponent("UILocalizationText", "stageLevel")
  self._uiRed = self:View():GetUIComponent("UISelectObjectPath", "uiRed")
  self._uiRedSpawn = nil
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIEducationMainBtn:SetData(element, atlasProperty, clickCB)
  self._element = element
  self._atlasProperty = atlasProperty
  self._clickCB = clickCB
end

function UIEducationMainBtn:GetNameColor()
  if self._nameColors == nil then
    UIEducationMainBtn._nameColors = {
      [ElementType.ElementType_Blue] = "<color=#6FFFFF>%s</color>",
      [ElementType.ElementType_Red] = "<color=#FE2B1E>%s</color>",
      [ElementType.ElementType_Green] = "<color=#BBFF49>%s</color>",
      [ElementType.ElementType_Yellow] = "<color=#FFFF29>%s</color>"
    }
  end
  local format = self._nameColors[self._element:ElementType()]
  return format
end

function UIEducationMainBtn:GetElementBg(elementType)
  if self._elementBg == nil then
    UIEducationMainBtn._elementBg = {
      [ElementType.ElementType_Blue] = {
        "enlighten_tb_bing1",
        "enlighten_tb_bing2"
      },
      [ElementType.ElementType_Red] = {
        "enlighten_tb_huo1",
        "enlighten_tb_huo2"
      },
      [ElementType.ElementType_Green] = {
        "enlighten_tb_sen1",
        "enlighten_tb_sen2"
      },
      [ElementType.ElementType_Yellow] = {
        "enlighten_tb_lei1",
        "enlighten_tb_lei2"
      }
    }
  end
  local elementBg = self._elementBg[elementType]
  return elementBg
end

function UIEducationMainBtn:Flush()
  local elementBg = self:GetElementBg(self._element:ElementType())
  self._bgImage:LoadImage(elementBg[1])
  self._petElement:LoadImage(elementBg[2])
  self._elementName:SetText(string.format(self:GetNameColor(), self._element:GetName()))
  self._stageName:SetText(StringTable.Get("str_education_stage_name", self._element:GetCurrentStage()))
  local curLevel = self._element:GetCurrentLevel()
  local maxLevel = self._element:GetCurrentMaxLevel()
  self._stageLevel:SetText(string.format("%d/%d", curLevel, maxLevel))
  local showRedDot = self._element:HasRed()
  self._uiRed.gameObject:SetActive(showRedDot)
  if showRedDot and self._uiRedSpawn == nil then
    self._uiRedSpawn = self._uiRed:SpawnOneObject("ManualLoad0")
  end
end

function UIEducationMainBtn:PlayAnimation(animName)
  self._animation:Play(animName)
end
