_class("LinkageNumComponent", Object)
LinkageNumComponent = LinkageNumComponent

function LinkageNumComponent:Constructor(linkageNumOffset)
  self._linkageNumOffset = Vector3(linkageNumOffset[1], linkageNumOffset[2], 0)
  self._pathCountText = nil
  self._linkCount = 0
  self._linkChainRate = 0
  self._mpb = nil
  self._entityConfigId = nil
  self._linkLineType = ELinkLineType.ELLT_LINE_Common
  self._linkRestStep = 0
end

function LinkageNumComponent:SetEntityConfigId(id)
  self._entityConfigId = id
end

function LinkageNumComponent:GetEntityConfigId()
  return self._entityConfigId
end

function LinkageNumComponent:GetLinkageIndex()
  return self._linkCount
end

function LinkageNumComponent:SetLinkNum(linkCount)
  self._linkCount = linkCount
end

function LinkageNumComponent:SetLinkChainRate(rate)
  self._linkChainRate = rate
end

function LinkageNumComponent:GetLinkChainRate()
  return self._linkChainRate
end

function LinkageNumComponent:SetLinkRestStep(step)
  self._linkRestStep = step
end

function LinkageNumComponent:GetLinkRestStep()
  return self._linkRestStep
end

function LinkageNumComponent:SetLinkLineType(linkLineType)
  self._linkLineType = linkLineType
end

function LinkageNumComponent:GetLinkLineType()
  return self._linkLineType
end

function LinkageNumComponent:SetLinkCount(viewRoot)
  if self:GetLinkLineType() == ELinkLineType.ELLT_LINE_NoElementCostStep then
    return self:SetLinkCountForCostStep(viewRoot)
  end
  local linkCount = self._linkCount
  local realLinkCount = self._linkChainRate
  local numMax = GameObjectHelper.FindChild(viewRoot.transform, "number_MAX")
  local numRoot = GameObjectHelper.FindChild(viewRoot.transform, "normal")
  if not numMax then
    return
  end
  if realLinkCount >= BattleConst.SuperChainCount then
    numMax.gameObject:SetActive(true)
    numRoot.gameObject:SetActive(false)
    return
  end
  numMax.gameObject:SetActive(false)
  numRoot.gameObject:SetActive(true)
  local num = math.floor(realLinkCount / 10 + 1)
  local lastNum = realLinkCount
  if 10 <= lastNum then
    lastNum = lastNum % 10
  end
  local num1 = GameObjectHelper.FindChild(viewRoot.transform, "number_1")
  local num2 = GameObjectHelper.FindChild(viewRoot.transform, "number_2")
  if not self._mpb then
    self._mpb = UnityEngine.MaterialPropertyBlock:New()
  end
  self._mpb:SetInt("_StartFrame", num + 1)
  local num1Renderer = num1.gameObject:GetComponent(typeof(UnityEngine.Renderer))
  num1Renderer:SetPropertyBlock(self._mpb)
  self._mpb:SetInt("_StartFrame", lastNum + 1)
  local num2Renderer = num2.gameObject:GetComponent(typeof(UnityEngine.Renderer))
  num2Renderer:SetPropertyBlock(self._mpb)
end

function LinkageNumComponent:SetLinkCountForCostStep(viewRoot)
  local linkCount = self._linkCount
  local restStep = self:GetLinkRestStep()
  local numRoot = GameObjectHelper.FindChild(viewRoot.transform, "normal")
  numRoot.gameObject:SetActive(true)
  local firstNumber = -1
  local secondNumber = -1
  if 10 <= restStep then
    firstNumber = math.floor(restStep / 10)
    secondNumber = restStep % 10
  else
    firstNumber = restStep
  end
  local num1 = GameObjectHelper.FindChild(viewRoot.transform, "number_1")
  local num2 = GameObjectHelper.FindChild(viewRoot.transform, "number_2")
  local numPrefix = GameObjectHelper.FindChild(viewRoot.transform, "number_prefix")
  num1.gameObject:SetActive(true)
  num2.gameObject:SetActive(0 <= secondNumber)
  numPrefix.gameObject:SetActive(true)
  if not self._mpb then
    self._mpb = UnityEngine.MaterialPropertyBlock:New()
  end
  self._mpb:SetInt("_StartFrame", firstNumber + 1)
  local num1Renderer = num1.gameObject:GetComponent(typeof(UnityEngine.Renderer))
  num1Renderer:SetPropertyBlock(self._mpb)
  if 0 <= secondNumber then
    self._mpb:SetInt("_StartFrame", secondNumber + 1)
    local num2Renderer = num2.gameObject:GetComponent(typeof(UnityEngine.Renderer))
    num2Renderer:SetPropertyBlock(self._mpb)
    numRoot.localPosition = Vector3(0.2, 0, 0)
  else
    numRoot.localPosition = Vector3(0, 0, 0)
  end
end

function Entity:LinkageNum()
  return self:GetComponent(self.WEComponentsEnum.LinkageNum)
end

function Entity:HasLinkageNum()
  return self:HasComponent(self.WEComponentsEnum.LinkageNum)
end

function Entity:AddLinkageNum(linkageNumOffset)
  local index = self.WEComponentsEnum.LinkageNum
  local component = LinkageNumComponent:New(linkageNumOffset)
  self:AddComponent(index, component)
end

function Entity:ReplaceLinkageNum(linkageNumOffset)
  local index = self.WEComponentsEnum.LinkageNum
  local component = LinkageNumComponent:New(linkageNumOffset)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveLinkageNum()
  if self:HasLinkageNum() then
    self:RemoveComponent(self.WEComponentsEnum.LinkageNum)
  end
end
