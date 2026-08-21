require("llb_logic_base")
_class("LLBuffLogicIncreaseProductionTagLink", LLBuffLogicBase)
LLBuffLogicIncreaseProductionTagLink = LLBuffLogicIncreaseProductionTagLink

function LLBuffLogicIncreaseProductionTagLink:Constructor(buffObj, logicParam)
  self._tagType = logicParam.tagType
  self._tagParam = logicParam.tagParam
  self._incType = logicParam.incType
  self._fixVal = logicParam.fixVal
  self._perVal = logicParam.perVal
end

function LLBuffLogicIncreaseProductionTagLink:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local linkCount = 0
  local entityMgr = LuckLandInnerGameHelper.GetEntityMgr()
  local pets
  if self._tagType == LLPetTagType.Element then
    pets = entityMgr:GetFightPetsByElement(self._tagParam)
  elseif self._tagType == LLPetTagType.Camp then
    pets = entityMgr:GetFightPetsByCamp(self._tagParam)
  elseif self._tagType == LLPetTagType.Level then
    pets = entityMgr:GetFightPetsByLevel(self._tagParam)
  elseif self._tagType == LLPetTagType.Res then
    pets = entityMgr:GetFightPetsByResType(self._tagParam)
  end
  if pets then
    if #pets == 1 then
      linkCount = 1
    elseif 1 < #pets then
      local posList = {}
      for _, pet in ipairs(pets) do
        table.insert(posList, pet:GetPos())
      end
      local maxLinkCount = 1
      local curPos = posList[1]
      local curLinkCount = 1
      for i = 2, #posList do
        if posList[i] - curPos == 1 then
          curLinkCount = curLinkCount + 1
          if maxLinkCount < curLinkCount then
            maxLinkCount = curLinkCount
          end
        else
          curLinkCount = 1
        end
        curPos = posList[i]
      end
      linkCount = maxLinkCount
    end
  end
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target, linkCount)
  end
end

function LLBuffLogicIncreaseProductionTagLink:DoLogicSingle(target, linkCount)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    if target:HasDeleteFlag() then
      return
    end
  elseif target:GetEntityType() == LuckLandEntityType.Monster and target:IsDead() then
    return
  end
  if self._incType == LuckLandIncType.Accumulate then
    if self._fixVal then
      target:AddAccFixValue(self._fixVal * linkCount)
    end
    if self._perVal then
      target:AddAccPerValue(self._perVal * linkCount)
    end
  elseif self._incType == LuckLandIncType.Temp then
    if self._fixVal then
      target:AddTempFixValue(self._fixVal * linkCount)
    end
    if self._perVal then
      target:AddTempPerValue(self._perVal * linkCount)
    end
  end
end
